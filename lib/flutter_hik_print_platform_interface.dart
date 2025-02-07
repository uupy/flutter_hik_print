import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_hik_print_method_channel.dart';

abstract class FlutterHikPrintPlatform extends PlatformInterface {
  /// Constructs a FlutterHikPrintPlatform.
  FlutterHikPrintPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterHikPrintPlatform _instance = MethodChannelFlutterHikPrint();

  /// The default instance of [FlutterHikPrintPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterHikPrint].
  static FlutterHikPrintPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterHikPrintPlatform] when
  /// they register themselves.
  static set instance(FlutterHikPrintPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> printText(String text) {
    throw UnimplementedError('printText() has not been implemented.');
  }
}
