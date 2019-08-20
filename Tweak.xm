#import <dlfcn.h>
#import <UIKit/UIKit.h>
#include <notify.h>
#include <objc/message.h>
#import "FLEXManager.h"

// SpringBoard
#import <SpringBoard/SpringBoard.h>
%hook SpringBoard

-(void)frontDisplayDidChange:(id)newDisplay {
    %orig(newDisplay);
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.pba.FlexTool.plist"];
    id setting = [settings objectForKey:[NSString stringWithFormat:@"FlexToolEnabled-com.apple.springboard"]];
    if (setting && [setting boolValue]) {
        if (newDisplay == NULL){
            [[FLEXManager sharedManager] showExplorer];
        } else {
            [[FLEXManager sharedManager] hideExplorer];
        }
    }
}
%end

// FlexTool.h
__attribute__((visibility("hidden")))
@interface FlexTool : NSObject {
@private
}
@end

#define kBundlePath @"/Library/MobileSubstrate/DynamicLibraries/FlexToolBundle.bundle"

// FlexTool.m
@implementation FlexTool

+ (instancetype)sharedInstance
{
    static FlexTool *_sharedFactory;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedFactory = [[self alloc] init];
    });

    return _sharedFactory;
}

- (id)init
{
        if ((self = [super init]))
        {
                     
        }
        return self;
}

-(void)inject {
	
	NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.pba.FlexTool.plist"];
    id setting = [settings objectForKey:[NSString stringWithFormat:@"FlexToolEnabled-%@", [NSBundle mainBundle].bundleIdentifier]];

    if (setting && [setting boolValue]) {

        [[FLEXManager sharedManager] showExplorer];

    }
}

@end


/*static NSString *nsNotificationString = @"com.pba.flextool.springboardsettingschanged";
static BOOL notificationState;

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

    notificationState = !notificationState;

}*/

%ctor {
    
    // Add observer for UIApplicationDidBecomeActiveNotification
    [[NSNotificationCenter defaultCenter] addObserver:[FlexTool sharedInstance] selector:@selector(inject) name:UIApplicationDidBecomeActiveNotification object:nil];

    /*// Add observer for ALChangeNotification
    notificationCallback(NULL, NULL, NULL, NULL, NULL);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
    NULL,
    notificationCallback,
    (CFStringRef)nsNotificationString,
    NULL,
    CFNotificationSuspensionBehaviorCoalesce);*/

}