//
//  Common.h
//  ENotifyV2
//
//  Created by Cuong Pham Ngoc on 8/11/14.
//  Copyright (c) 2014 PCuong. All rights reserved.
//

#ifndef ENotifyV2_Common_h
#define ENotifyV2_Common_h

typedef enum ERtuStatus : int {
    
    eOK = 0,
    eRelayOnButNoI = 1,
    eRelayOffButI = 2,
    eUnExpectedRelayStatus = 4,
    eDisconnect = 8,
    eUnExpectedI = 16,
    eUnExpectedU3 = 32,
    eUnExpectedU2 = 64,
    eUnExpectedU1 = 128,
    ePhase1Error = 256,
    ePhase2Error = 512,
    ePhase3Error = 1024,
    eTimeError = 2048,
    eCableLost = 4096,
    
}ERtuStatus;

#endif
