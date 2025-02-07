
import 'package:flutter/services.dart';

import 'flutter_hik_print_platform_interface.dart';

class FlutterHikPrint {
  static const MethodChannel _channel = MethodChannel('flutter_hik_print');

  Future<String?> getPlatformVersion() {
    return FlutterHikPrintPlatform.instance.getPlatformVersion();
  }

  Future<void> printText(String text) {
    return FlutterHikPrintPlatform.instance.printText(text);
  }
}
