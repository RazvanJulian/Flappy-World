//
//  EAAppDelegate.m
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//

#import "EAAppDelegate.h"
#import "EAGameCenterProvider.h"


@implementation EAAppDelegate;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.gameViewController = [[EAGameViewController alloc] init];
    self.window.rootViewController = self.gameViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[EAGameCenterProvider sharedInstance] authenticateLocalUser];
    
    return YES;
}

@end
