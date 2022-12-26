import Flutter
import UIKit

public class SwiftStagingNetworkConfigurationPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "staging_network_configuration", binaryMessenger: registrar.messenger())
    let instance = SwiftStagingNetworkConfigurationPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
