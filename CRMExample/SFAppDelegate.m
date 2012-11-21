//
//  SFAppDelegate.m
//  CRMExample
//
//  Created by Kamil Gałuszka on 11/3/12.
//  Copyright (c) 2012 Kamil Gałuszka. All rights reserved.
//

#import "SFAppDelegate.h"
#import <RestKit/RestKit.h>
#import "SFRestAPI.h"

@implementation SFAppDelegate
@synthesize api;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setApi:[[SFRestAPI alloc] init]];
    [self.api configureDatabase];
    [self.api configureMappings];
    [self.api configurePosting];
    [self.api configureRoutes];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init]; //Create the localNotification object
    [localNotification setApplicationIconBadgeNumber:0];
    
    [application presentLocalNotificationNow:localNotification];
    
    __block UIBackgroundTaskIdentifier background_task; //Create a task object
    background_task = [application beginBackgroundTaskWithExpirationHandler: ^ {
        [application endBackgroundTask: background_task]; //Tell the system that we are done with the tasks
        background_task = UIBackgroundTaskInvalid; //Set the task to be invalid
        //System will be shutting down the app at any point in time now
    }];
    //Background tasks require you to use asyncrous tasks
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Perform your tasks that your application requires
        NSLog(@"\n\nRunning in the background!\n\n");
        [self.api startSynchronizationInBackground];
        NSLog(@"\n\nRunning in the background!\n\n");

        [application endBackgroundTask: background_task]; //End the task so the system knows that you are done with what you need to perform
        background_task = UIBackgroundTaskInvalid; //Invalidate the background_task
    });
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
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
@end
