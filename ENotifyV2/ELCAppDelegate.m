//
//  ELCAppDelegate.m
//  ENotifyV2
//
//  Created by Cuong Pham Ngoc on 8/11/14.
//  Copyright (c) 2014 PCuong. All rights reserved.
//

#import "ELCAppDelegate.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ELCAppDelegate()

-(void)initQueryRtuListWithToken:(NSString*)authToken;

@end

@implementation ELCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    
    // Dia chi RESTFul
    _baseRESTFulUrl = @"http://118.70.169.1:8778/RESTFul";
    //_baseRESTFulUrl = @"http://192.168.1.5:8778/RESTFul";
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = TRUE;
    
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

-(NSString*)authToken
{
    return _authToken;
}

-(void)setAuthToken:(NSString *)authToken
{
    if(_authToken != authToken){
        
        [self initQueryRtuListWithToken:authToken];
            
        _authToken = authToken;
    }
}

-(NSDictionary*)alarmList
{
    return nil;

}

-(void)initQueryRtuListWithToken:(NSString*)authToken
{
    NSURL* restUrl = [NSURL URLWithString:self.baseRESTFulUrl];
    AFHTTPSessionManager* session = [[AFHTTPSessionManager alloc] initWithBaseURL:restUrl];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString* query = [NSString stringWithFormat:@"RtuList?token=%@", authToken];
    [session GET:[query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil  success:^(NSURLSessionDataTask* task, id responseObject)
    {
        
        NSArray* result = (NSArray*)responseObject;
        if(!result)
        {
            NSLog(@"RtuList: %@", responseObject);
            
            return ;
        }
        
        for (NSObject* obj in result) {
            
            
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        
        NSLog(@"%@", [error localizedDescription]);
        
        [ELCAppDelegate alert:@"Hệ thống" otherValue:@"Không lấy được danh sách tủ"];
        
    }];
    
}

+(void)alert:(NSString*)title otherValue:(NSString*)message {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Xác nhận" otherButtonTitles:nil, nil];
    
    [alert show];
}

+ (ELCAppDelegate *)sharedAppDelegate
{
    return (ELCAppDelegate *) [UIApplication sharedApplication].delegate;
}

+ (void)vibrateIPhone
{
    //There are two seemingly similar functions that take a parameter kSystemSoundID_Vibrate:
    
    //1) AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    //2) AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    //Both the functions vibrate the iPhone. But when you use the first function on devices that don’t support vibration, it plays a beep sound. The second function on the other hand does nothing on unsupported devices. So if you are going to vibrate the device continuously, as a alert, common sense says, use function 2.
    
    //    See also "iPhone Tutorial: Better way to check capabilities of iOS devices" article.
    
    //    First, add the AudioToolbox framework (AudioToolbox.framework) to your target in Build Phases.
    
    //    Then, header file to import: #import <AudioToolbox/AudioServices.h>
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}
@end
