import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_hik_print_platform_interface.dart';

/// An implementation of [FlutterHikPrintPlatform] that uses method channels.
class MethodChannelFlutterHikPrint extends FlutterHikPrintPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_hik_print');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> printText(String text) async {
    try {
      await methodChannel.invokeMethod('printText', {'text': text});
    } on PlatformException catch (e) {
      print("Failed to print: '${e.message}'.");
    }
  }
}
