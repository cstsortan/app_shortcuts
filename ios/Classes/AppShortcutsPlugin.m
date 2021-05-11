#import "AppShortcutsPlugin.h"
#if __has_include(<app_shortcuts/app_shortcuts-Swift.h>)
#import <app_shortcuts/app_shortcuts-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "app_shortcuts-Swift.h"
#endif

@implementation AppShortcutsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAppShortcutsPlugin registerWithRegistrar:registrar];
}
@end
