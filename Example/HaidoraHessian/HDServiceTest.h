//
//  HDService.h
//  HaidoraHessian
//
//  Created by Dailingchi on 15/4/6.
//  Copyright (c) 2015年 mrdaios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HaidoraHessian.h>

RF_ATTRIBUTE(HDHessianService, serviceURL = @"http://app.gosmarthome.cn/hessian/BocoAccountService",
             timeoutInterval = 30)
@interface HDServiceTest : HDHessianServiceClient

RF_ATTRIBUTE(HDHessianMethod, serviceMethodName = @"login")
- (id)login:(NSString *)account password:(NSString *)password imei:(NSString *)imei;

@end
