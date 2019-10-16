//
//  AppDelegate.m
//  CrashDemo
//
//  Created by ptx on 2019/10/17.
//  Copyright © 2019 ptx. All rights reserved.
//

#import "AppDelegate.h"
#import <CrashReporter/CrashReporter.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self printCrash];
    [self crashSetup];
    return YES;
}

-(void)printCrash
{
    PLCrashReporter *instance = [PLCrashReporter sharedReporter];
    if ([instance hasPendingCrashReport]) {
        NSData *data = [instance loadPendingCrashReportData];
        PLCrashReport *report = [[PLCrashReport alloc] initWithData:data error:nil];
        NSString *text = [MSPLCrashReportTextFormatter stringValueForCrashReport:report withTextFormat:PLCrashReportTextFormatiOS];
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *fileName = [path stringByAppendingPathComponent:@"1.crash"];
        NSError *error = nil;
        [text writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"write crash4iOS error %@",error);
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Crash Report!!!" message:text preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
        [instance purgePendingCrashReport];
    }
}

-(void)crashSetup
{
    PLCrashReporter *instance = [PLCrashReporter sharedReporter];
    NSError *error;
    [instance enableCrashReporterAndReturnError:&error];
    if (error) {
        NSLog(@"setup Crash SDK Fail %@",error);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
