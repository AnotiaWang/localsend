import 'dart:io';

import 'package:flutter/services.dart';
import 'package:keypress_simulator/keypress_simulator.dart';
import 'package:localsend_app/util/native/platform_check.dart';
import 'package:window_manager/window_manager.dart';

// 如果目前 localsend 在前景，就把 localsend 隐藏起来
Future<void> _hideWindowIfFocused() async {
  if (!checkPlatformIsDesktop()) return;

  if (await windowManager.isFocused()) {
    final ModifierKey modifier = Platform.isMacOS ? ModifierKey.metaModifier : ModifierKey.altModifier;
    await keyPressSimulator.simulateKeyPress(key: LogicalKeyboardKey.tab, modifiers: [modifier]);
    await keyPressSimulator.simulateKeyPress(key: LogicalKeyboardKey.tab, keyDown: false);
    await keyPressSimulator.simulateKeyPress(modifiers: [modifier], keyDown: false);
    await Future.delayed(const Duration(milliseconds: 300));
  }
}

Future<void> simulateCopyPaste({required String text}) async {
  if (!checkPlatformIsDesktop()) return;
  final ModifierKey modifier = Platform.isMacOS ? ModifierKey.metaModifier : ModifierKey.altModifier;

  await Clipboard.setData(ClipboardData(text: text));

  await _hideWindowIfFocused();
  await keyPressSimulator.simulateKeyPress(key: LogicalKeyboardKey.keyV, modifiers: [modifier]);
  await keyPressSimulator.simulateKeyPress(key: LogicalKeyboardKey.keyV, keyDown: false);
}

Future<void> simulateSwitchPowerPoint(bool isNextPage) async {
  if (!checkPlatformIsDesktop()) return;
  await _hideWindowIfFocused();
  await keyPressSimulator.simulateKeyPress(key: isNextPage ? LogicalKeyboardKey.arrowRight : LogicalKeyboardKey.arrowLeft);
}
