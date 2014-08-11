//
//  ELCRtu.h
//  ENotifyV2
//
//  Created by Cuong Pham Ngoc on 8/11/14.
//  Copyright (c) 2014 PCuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"

@interface ELCRtu : NSObject

@property(readonly) int rtuId;
@property NSString* name;
@property int categoryId;
@property ERtuStatus status;
@property bool online;

-(id)initWithId:(int)nRtuId;
+(NSString*)getRtuStatusText:(ERtuStatus)eStatus;

@end
