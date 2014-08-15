//
//  ELCAlarm.h
//  ENotifyV2
//
//  Created by Cuong Pham Ngoc on 8/15/14.
//  Copyright (c) 2014 PCuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELCRtu.h"

@interface ELCAlarm : NSObject

@property (nonatomic) int alarmId;
@property (nonatomic) NSString* alarmText;
@property (readonly) NSDate* addedDate;
@property int rtuId;
@property (nonatomic) ELCRtu* rtu;

@end
