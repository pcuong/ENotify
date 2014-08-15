//
//  ELCAppDelegate.h
//  ENotifyV2
//
//  Created by Cuong Pham Ngoc on 8/11/14.
//  Copyright (c) 2014 PCuong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELCAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString* _authToken;
}

@property (strong, nonatomic) UIWindow *window;
@property (readonly, nonatomic) NSString* baseRESTFulUrl;


@property (nonatomic) NSDictionary* rtuDictionary;

-(NSString*)authToken;
-(BOOL)setAuthToken:(NSString*)authToken;

-(NSDictionary*)alarmList;
-(BOOL)initQueryRtuList;

+(ELCAppDelegate*)sharedAppDelegate;
+(void)alert:(NSString*)title otherValue:(NSString*)message;
+(void)vibrateIPhone;

@end
