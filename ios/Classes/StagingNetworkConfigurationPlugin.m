#import "StagingNetworkConfigurationPlugin.h"
#if __has_include(<staging_network_configuration/staging_network_configuration-Swift.h>)
#import <staging_network_configuration/staging_network_configuration-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "staging_network_configuration-Swift.h"
#endif

@implementation StagingNetworkConfigurationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftStagingNetworkConfigurationPlugin registerWithRegistrar:registrar];
}
@end
