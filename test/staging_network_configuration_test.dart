import 'package:flutter_test/flutter_test.dart';
import 'package:staging_network_configuration/staging_network_configuration.dart';
import 'package:staging_network_configuration/staging_network_configuration_platform_interface.dart';
import 'package:staging_network_configuration/staging_network_configuration_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockStagingNetworkConfigurationPlatform
    with MockPlatformInterfaceMixin
    implements StagingNetworkConfigurationPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final StagingNetworkConfigurationPlatform initialPlatform = StagingNetworkConfigurationPlatform.instance;

  test('$MethodChannelStagingNetworkConfiguration is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelStagingNetworkConfiguration>());
  });

  test('getPlatformVersion', () async {
    StagingNetworkConfiguration stagingNetworkConfigurationPlugin = StagingNetworkConfiguration();
    MockStagingNetworkConfigurationPlatform fakePlatform = MockStagingNetworkConfigurationPlatform();
    StagingNetworkConfigurationPlatform.instance = fakePlatform;

    expect(await stagingNetworkConfigurationPlugin.getPlatformVersion(), '42');
  });
}
