import 'dart:io';

import 'package:flutter/services.dart';
import 'package:keypress_simulator/keypress_simulator.dart';
import 'package:localsend_app/util/native/platform_check.dart';
import 'package:window_manager/window_manager.dart';

Future<void> simulateCopyPaste({required String text}) async {
  if (!checkPlatformIsDesktop()) return;
  final ModifierKey modifier = Platform.isMacOS ? ModifierKey.metaModifier : ModifierKey.controlModifier;

  await Clipboard.setData(ClipboardData(text: text));
  if (await windowManager.isFocused()) {
    await keyPressSimulator.simulateKeyPress(key: LogicalKeyboardKey.tab, modifiers: [modifier]);
    await keyPressSimulator.simulateKeyPress(key: LogicalKeyboardKey.tab, keyDown: false);
    await keyPressSimulator.simulateKeyPress(modifiers: [modifier], keyDown: false);
  }

  await Future.delayed(const Duration(milliseconds: 300));
  await keyPressSimulator.simulateKeyPress(key: LogicalKeyboardKey.keyV, modifiers: [modifier]);
  await keyPressSimulator.simulateKeyPress(key: LogicalKeyboardKey.keyV, keyDown: false);
}
