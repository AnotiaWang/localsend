import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_helper/flutter_native_helper.dart';
import 'package:localsend_app/gen/strings.g.dart';
import 'package:localsend_app/model/session_status.dart';
import 'package:localsend_app/pages/progress_page.dart';
import 'package:localsend_app/pages/receive_options_page.dart';
import 'package:localsend_app/provider/network/server/server_provider.dart';
import 'package:localsend_app/provider/selection/selected_receiving_files_provider.dart';
import 'package:localsend_app/provider/settings_provider.dart';
import 'package:localsend_app/theme.dart';
import 'package:localsend_app/util/ip_helper.dart';
import 'package:localsend_app/util/native/keypress_simulate.dart';
import 'package:localsend_app/util/native/platform_check.dart';
import 'package:localsend_app/util/ui/snackbar.dart';
import 'package:localsend_app/widget/device_bage.dart';
import 'package:localsend_app/widget/responsive_list_view.dart';
import 'package:logging/logging.dart';
import 'package:refena_flutter/refena_flutter.dart';
import 'package:routerino/routerino.dart';
import 'package:url_launcher/url_launcher.dart';

final Logger _logger = Logger('ReceivePage');

class ReceivePage extends StatefulWidget {
  const ReceivePage({Key? key}) : super(key: key);

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> with Refena {
  String? _message;
  bool _isLink = false;
  bool _showFullIp = false;
  bool _isViewPhotos = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => _init());
  }

  Future<void> _init() async {
    final receiveSession = ref.read(serverProvider)?.session;
    if (receiveSession == null) {
      return;
    }
    if (receiveSession.isViewPhoto) _isViewPhotos = true;

    ref.notifier(selectedReceivingFilesProvider).setFiles(receiveSession.files.values.map((f) => f.file).toList());
    setState(() {
      // show message if there is only one text file
      _message = receiveSession.message;
      _isLink = _message != null && (_message!.startsWith('http://') || _message!.startsWith('https'));
    });

    if (_message == 'arrow_right_alt' || _message == 'arrow_left_alt') {
      await simulateSwitchPowerPoint(_message == 'arrow_right_alt');
      await Future.delayed(const Duration(milliseconds: 300));
      _acceptNothing();
      // 自动退出页面
      // ignore: use_build_context_synchronously
      context.pop();
    } else if (_message == 'ring_volume' && Platform.isAndroid) {
      //手机端接收到到之后，播放默认铃声
      await Future.delayed(const Duration(milliseconds: 1));
      _acceptNothing();
      // ignore: use_build_context_synchronously
      context.pop();
      //响铃
      var isSuccess = await FlutterNativeHelper.instance.playSystemRingtone();
      if (isSuccess) {
        //播放成功
        _logger.info('播放成功');
        // ignore: unawaited_futures
        Future.delayed(const Duration(seconds: 5), () {
          FlutterNativeHelper.instance.stopSystemRingtone();
        });
      } else {
        //播放失败
        _logger.info('播放失败');
      }
    }
    // 如果接收方的设置中启用了“接收到文本时自动粘贴”，就自动隐藏窗口并模拟复制粘贴
    else if (_message != null && ref.read(settingsProvider).autoPasteOnReceiveText) {
      await Future.delayed(const Duration(seconds: 1));
      await simulateCopyPaste(text: _message!);
      _acceptNothing();
      // 自动退出页面
      // ignore: use_build_context_synchronously
      context.pop();
    }
  }

  void _acceptNothing() {
    ref.notifier(serverProvider).acceptFileRequest({});
  }

  void _accept() {
    final selectedFiles = ref.read(selectedReceivingFilesProvider);
    ref.notifier(serverProvider).acceptFileRequest(selectedFiles);
  }

  void _decline() {
    ref.notifier(serverProvider).declineFileRequest();
  }

  @override
  Widget build(BuildContext context) {
    final receiveSession = ref.watch(serverProvider)?.session;
    if (receiveSession == null) {
      // when declining/accepting the request, there is a short frame where tempRequest is null
      return Scaffold(
        body: Container(),
      );
    }
    final selectedFiles = ref.watch(selectedReceivingFilesProvider);

    return WillPopScope(
      onWillPop: () async {
        _decline();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: ResponsiveListView.defaultMaxWidth),
              child: Builder(
                builder: (context) {
                  final height = MediaQuery.of(context).size.height;
                  final smallUi = _message != null && height < 600;
                  final String subtitle;

                  if (_isViewPhotos) {
                    subtitle = t.receivePage.subTitleViewPhoto;
                  } else if (_message != null) {
                    subtitle = _isLink ? t.receivePage.subTitleLink : t.receivePage.subTitleMessage;
                  } else {
                    subtitle = t.receivePage.subTitle(n: receiveSession.files.length);
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: smallUi ? 20 : 30),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (!smallUi)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Icon(receiveSession.sender.deviceType.icon, size: 64),
                                ),
                              FittedBox(
                                child: Text(
                                  receiveSession.sender.alias,
                                  style: TextStyle(fontSize: smallUi ? 32 : 48),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() => _showFullIp = !_showFullIp);
                                    },
                                    child: DeviceBadge(
                                      backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                                      foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
                                      label: _showFullIp ? receiveSession.sender.ip : '#${receiveSession.sender.ip.visualId}',
                                    ),
                                  ),
                                  if (receiveSession.sender.deviceModel != null) ...[
                                    const SizedBox(width: 10),
                                    DeviceBadge(
                                      backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                                      foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
                                      label: receiveSession.sender.deviceModel!,
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 40),
                              Text(
                                subtitle,
                                style: smallUi ? null : Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              ),
                              if (_message != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: SizedBox(
                                        height: 100,
                                        child: Card(
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: SelectableText(
                                                _message!,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            unawaited(
                                              Clipboard.setData(ClipboardData(text: _message!)),
                                            );
                                            if (checkPlatformIsDesktop()) {
                                              context.showSnackBar(t.general.copiedToClipboard);
                                            }
                                            _acceptNothing();
                                            context.pop();
                                          },
                                          child: Text(t.general.copy),
                                        ),
                                        if (_isLink)
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Theme.of(context).buttonTheme.colorScheme!.primary,
                                                foregroundColor: Theme.of(context).buttonTheme.colorScheme!.onPrimary,
                                              ),
                                              onPressed: () {
                                                // ignore: discarded_futures
                                                launchUrl(Uri.parse(_message!), mode: LaunchMode.externalApplication);
                                                _acceptNothing();
                                                context.pop();
                                              },
                                              child: Text(t.general.open),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        if (receiveSession.status == SessionStatus.waiting && _message == null && !_isViewPhotos)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TextButton.icon(
                              style: TextButton.styleFrom(
                                foregroundColor: Theme.of(context).colorScheme.onSurface,
                              ),
                              onPressed: () async {
                                await context.push(() => const ReceiveOptionsPage());
                              },
                              icon: const Icon(Icons.settings),
                              label: Text(t.receiveOptionsPage.title),
                            ),
                          ),
                        if (receiveSession.status == SessionStatus.canceledBySender) ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              t.receivePage.canceled,
                              style: TextStyle(color: Theme.of(context).colorScheme.warning),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ref.notifier(serverProvider).closeSession();
                                context.pop();
                              },
                              icon: const Icon(Icons.check_circle),
                              label: Text(t.general.close),
                            ),
                          ),
                        ] else if (_message != null)
                          Center(
                            child: TextButton.icon(
                              style: TextButton.styleFrom(
                                foregroundColor: Theme.of(context).colorScheme.onSurface,
                              ),
                              onPressed: () {
                                _acceptNothing();
                                context.pop();
                              },
                              icon: const Icon(Icons.close),
                              label: Text(t.general.close),
                            ),
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.error,
                                  foregroundColor: Theme.of(context).colorScheme.onError,
                                ),
                                onPressed: () {
                                  _decline();
                                  context.pop();
                                },
                                icon: const Icon(Icons.close),
                                label: Text(t.general.decline),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).buttonTheme.colorScheme!.primary,
                                  foregroundColor: Theme.of(context).buttonTheme.colorScheme!.onPrimary,
                                ),
                                onPressed: selectedFiles.isEmpty
                                    ? null
                                    : () async {
                                        final sessionId = ref.read(serverProvider)?.session?.sessionId;
                                        if (sessionId == null) {
                                          return;
                                        }
                                        _accept();
                                        await context.pushAndRemoveUntilImmediately(
                                          removeUntil: ReceivePage,
                                          builder: () => ProgressPage(
                                            showAppBar: false,
                                            closeSessionOnClose: true,
                                            sessionId: sessionId,
                                          ),
                                        );
                                      },
                                icon: const Icon(Icons.check_circle),
                                label: Text(t.general.accept),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
