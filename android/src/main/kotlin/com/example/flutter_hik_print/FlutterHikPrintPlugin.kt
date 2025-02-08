package com.example.flutter_hik_print

import androidx.annotation.NonNull

import android.content.Context
import android.util.Log
import com.hikvision.hikprint.HikPrint
import com.caysn.autoreplyprint.AutoReplyPrint
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterHikPrintPlugin */
class FlutterHikPrintPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private var hikPrint: HikPrint? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_hik_print")
    channel.setMethodCallHandler(this)
    hikPrint = HikPrint.getInstance()
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "printText" -> {
        val text = call.argument<String>("text")
        if (text != null) {
          Log.i("PrintText", text)
          printText(text)
          result.success("Printing started")
        } else {
          result.error("INVALID_ARGUMENT", "Text content is required", null)
        }
      }
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun printText(text: String) {
    // 打开端口
    val portHandle = hikPrint?.CP_Port_OpenCom("COM1", 9600, 8, 0, 0, 0, 0)
    Log.i("HikPrint", hikPrint?.toString())

    if (portHandle != null) {
      Log.i("PortHandle", "${portHandle?.name}")
      // 打印文本
      hikPrint?.CP_Pos_PrintText(portHandle, text)
      // 关闭端口
      hikPrint?.CP_Port_Close(portHandle)
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
