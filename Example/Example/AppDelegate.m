//
//  AppDelegate.m
//  Example
//
//  Created by Ratha Hin on 1/31/14.
//  Copyright (c) 2014 Ratha Hin. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UIWindow * windows;
@property (nonatomic, strong) ViewController *viewController;
@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [self commonInitWithOptions:launchOptions];
    return YES;
}

- (void)commonInitWithOptions:(NSDictionary *)launchOptions {
  self.windows = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
  self.viewController.title = @"EXAMPLE";
  self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
  self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
  self.navigationController.navigationBar.translucent = YES;
  self.windows.rootViewController = self.navigationController;
  [self.windows makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
