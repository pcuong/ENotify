//
//  ELCRtu.m
//  ENotifyV2
//
//  Created by Cuong Pham Ngoc on 8/11/14.
//  Copyright (c) 2014 PCuong. All rights reserved.
//

#import "ELCRtu.h"

@implementation ELCRtu

-(id)initWithId:(int)nRtuId
{
    if(!(self = [super init]))
        return nil;

    self->_rtuId = nRtuId;
    self->_name = [[NSString alloc]init];
    self->_status = eOK;
    
    
    return self;
}

+(NSString*)getRtuStatusText:(ERtuStatus)eStatus
{
    if(eStatus == eOK)
        return @"";
    
    NSMutableString* sText = [[NSMutableString alloc]init];
    
    if((eStatus & eRelayOnButNoI) == eRelayOnButNoI)
        [sText appendString:@",Rơle bật nhưng không có dòng"];
    
    if((eStatus & eRelayOffButI) == eRelayOffButI)
        [sText appendString:@",Rơle không bật nhưng có dòng"];
    
    if((eStatus & eUnExpectedRelayStatus) == eUnExpectedRelayStatus)
        [sText appendString:@",Rơle bất thường(Đóng ngắt không theo cấu hình)"];
    
    if((eStatus & eUnExpectedI) == eUnExpectedI)
        [sText appendString:@",I bất thường"];
    
    if((eStatus & eUnExpectedU1) == eUnExpectedU1)
        [sText appendString:@",U1 bất thường"];
    
    if((eStatus & eUnExpectedU2) == eUnExpectedU2)
        [sText appendString:@",U2 bất thường"];
    
    if((eStatus & eUnExpectedU3) == eUnExpectedU3)
        [sText appendString:@",U3 bất thường"];
    
    if((eStatus & ePhase1Error) == ePhase1Error)
        [sText appendString:@",Sự cố pha 1"];
    
    if((eStatus & ePhase2Error) == ePhase2Error)
        [sText appendString:@",Sự cố pha 2"];
    
    if((eStatus & ePhase3Error) == ePhase3Error)
        [sText appendString:@",Sự cố pha 3"];
    
    if((eStatus & eTimeError) == eTimeError)
        [sText appendString:@",Lỗi thời gian"];
    
    if((eStatus & eCableLost) == eCableLost)
        [sText appendString:@",Đứt cáp"];
    
    if ([sText length] > 0) {
        
        NSRange range = {0, 1};
        [sText deleteCharactersInRange:range];
    }
    
    return sText;
}
@end
