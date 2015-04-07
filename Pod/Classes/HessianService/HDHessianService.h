//
//  HDHessianService.h
//  Pods
//
//  Created by Dailingchi on 15/4/6.
//
//

#import <Foundation/Foundation.h>
#import <ROAD/ROADAttribute.h>

@interface HDHessianService : NSObject
/**
 *  服务地址
 */
@property (nonatomic, strong) NSString *serviceURL;
/**
 *  请求超时
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

@property (nonatomic, strong) NSString *classPrefix;

@end
