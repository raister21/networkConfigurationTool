import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'staging_network_configuration_method_channel.dart';

abstract class StagingNetworkConfigurationPlatform extends PlatformInterface {
  /// Constructs a StagingNetworkConfigurationPlatform.
  StagingNetworkConfigurationPlatform() : super(token: _token);

  static final Object _token = Object();

  static StagingNetworkConfigurationPlatform _instance = MethodChannelStagingNetworkConfiguration();

  /// The default instance of [StagingNetworkConfigurationPlatform] to use.
  ///
  /// Defaults to [MethodChannelStagingNetworkConfiguration].
  static StagingNetworkConfigurationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [StagingNetworkConfigurationPlatform] when
  /// they register themselves.
  static set instance(StagingNetworkConfigurationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
