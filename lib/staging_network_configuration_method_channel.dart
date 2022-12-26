import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'staging_network_configuration_platform_interface.dart';

/// An implementation of [StagingNetworkConfigurationPlatform] that uses method channels.
class MethodChannelStagingNetworkConfiguration extends StagingNetworkConfigurationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('staging_network_configuration');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
