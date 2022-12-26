
import 'staging_network_configuration_platform_interface.dart';

class StagingNetworkConfiguration {
  Future<String?> getPlatformVersion() {
    return StagingNetworkConfigurationPlatform.instance.getPlatformVersion();
  }
}
