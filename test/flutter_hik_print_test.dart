import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hik_print/flutter_hik_print.dart';
import 'package:flutter_hik_print/flutter_hik_print_platform_interface.dart';
import 'package:flutter_hik_print/flutter_hik_print_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterHikPrintPlatform
    with MockPlatformInterfaceMixin
    implements FlutterHikPrintPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> printText(String text) {
    // TODO: implement printText
    throw UnimplementedError();
  }
}

void main() {
  final FlutterHikPrintPlatform initialPlatform = FlutterHikPrintPlatform.instance;

  test('$MethodChannelFlutterHikPrint is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterHikPrint>());
  });

  test('getPlatformVersion', () async {
    FlutterHikPrint flutterHikPrintPlugin = FlutterHikPrint();
    MockFlutterHikPrintPlatform fakePlatform = MockFlutterHikPrintPlatform();
    FlutterHikPrintPlatform.instance = fakePlatform;

    expect(await flutterHikPrintPlugin.getPlatformVersion(), '42');
  });
}
