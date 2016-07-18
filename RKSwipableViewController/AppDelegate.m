//
//  AppDelegate.m
//  RKSwipableViewController
//
//  Created by Richard Kim on 7/24/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//
//  Modified by Kenial Lee on 7/17/16


#import "AppDelegate.h"

#import "RKSwipableViewController.h"

@interface AppDelegate () <RKSwipableViewControllerDataSource>
@end

@implementation AppDelegate

NSMutableArray *_vcArray;
NSArray *_vcMenuTitles;
#define NUMBER_OF_SWIPABLE_VIEWS 8

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];

    _vcArray = [[NSMutableArray alloc] init];
    for(int i=0; i<NUMBER_OF_SWIPABLE_VIEWS; i++) {
        [_vcArray addObject:[NSNull null]];
    }
    _vcMenuTitles = [[NSArray alloc] initWithObjects: @"first",@"second",@"third",@"fourth",@"fifth",@"sixth",@"seventh",@"eighth",nil];

    RKSwipableViewController *swipableVC = [[RKSwipableViewController alloc] init];
    swipableVC.isSegmentSizeFixed = NO;
    swipableVC.segmentButtonMinimumWidth = 50.0f;
    swipableVC.segmentButtonMarginWidth = 25.0f;
    swipableVC.segmentButtonEdgeMarginWidth = 10.0f;
    swipableVC.shouldSelectedButtonCentered = YES;
    swipableVC.segmentButtonHeight = 60.0f;
    swipableVC.segmentButtonBackgroundColor = [UIColor blackColor];
    swipableVC.segmentButtonTextColor = [UIColor whiteColor];
    swipableVC.selectionBarColor = [UIColor greenColor];
    swipableVC.segmentContainerScrollViewBackgroundColor = [UIColor blackColor];
    swipableVC.dataSource = self;
    swipableVC.enablesScrollingOverEdge = YES;
    swipableVC.doUpdateNavigationTitleWithSwipedViewController = YES;

    self.window.rootViewController = swipableVC;
    [self.window makeKeyAndVisible];

    return YES;
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

#pragma mark - RKSwipableViewControllerDataSource
- (long)numberOfViewControllers:(RKSwipableViewController *)swipableViewController {
    return NUMBER_OF_SWIPABLE_VIEWS;
}

- (UIViewController *)swipableViewController:(RKSwipableViewController *)swipableViewController viewControllerAt:(long)index {
    // VC source should be initialized before execution path arrives at here.
    if(_vcArray[index] == [NSNull null]) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor colorWithWhite:1.0 - (index/16.0) alpha:1];
        UILabel *label = [[UILabel alloc] initWithFrame:swipableViewController.view.frame];
        label.text = _vcMenuTitles[index];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:36];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [vc.view addSubview:label];
        vc.title = label.text;
        _vcArray[index] = vc;
    }
    return _vcArray[index];
}

- (long)swipableViewController:(RKSwipableViewController *)swipableViewController indexOfViewController:(UIViewController *)viewController {
    for(long i=0; i<_vcArray.count; i++) {
        if(_vcArray[i] == viewController)
            return i;
    }
    return NSNotFound;
}

- (NSString *)swipableViewController:(RKSwipableViewController *)swipableViewController segmentTextAt:(long)index {
    return _vcMenuTitles[index];
}
@end
