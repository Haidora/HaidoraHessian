//
//  HDServiceProvider+HDTest.h
//  HaidoraHessian
//
//  Created by Dailingchi on 15/4/6.
//  Copyright (c) 2015年 mrdaios. All rights reserved.
//

#import "HDServiceProvider.h"
#import "HDServiceTest.h"

@interface HDServiceProvider (HDTest)

RF_ATTRIBUTE(HDService, serviceClass = [HDServiceTest class])
+ (HDServiceTest *)shareTestService;

@end
