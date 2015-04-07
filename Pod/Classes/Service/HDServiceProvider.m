//
//  HDServiceProvider.m
//  Pods
//
//  Created by Dailingchi on 15/4/6.
//
//

#import "HDServiceProvider.h"
#import "HDService.h"

#import <ROAD/ROADAttribute.h>
#import <objc/runtime.h>

static NSMutableDictionary *services;

@implementation HDServiceProvider

//动态提供service
+ (BOOL)resolveClassMethod:(SEL)sel
{
    BOOL result = [super resolveClassMethod:sel];
    if (!result)
    {
        NSString *selectorName = NSStringFromSelector(sel);
        if (![selectorName hasPrefix:@"RF_"])
        {
            HDService *serviceAttribute = [[self class] RF_attributeForMethod:selectorName
                                                            withAttributeType:[HDService class]];
            if (serviceAttribute != nil)
            {
                result = YES;
                IMP const imp = [self methodForSelector:@selector(_hdGenerateService)];
                Class metaClass = object_getClass(self);
                class_addMethod(metaClass, sel, imp, "@@:");
            }
        }
    }
    return result;
}

+ (id)_hdGenerateService
{
    NSString *const serviceName = NSStringFromSelector(_cmd);
    __block id theService;
    dispatch_sync([self sharedQueue], ^{
      theService = services[serviceName];
    });
    if (theService == nil)
    {
        HDService *serviceAttribute =
            [[self class] RF_attributeForMethod:serviceName withAttributeType:[HDService class]];
        Class const serviceClass = serviceAttribute.serviceClass;
        theService = [[serviceClass alloc] init];
        [self registerService:theService forServiceName:serviceName];
    }
    return theService;
}

#pragma mark
#pragma mark Private

+ (void)registerService:(const id)aServiceInstance forServiceName:(NSString *const)serviceName
{
    dispatch_sync([self sharedQueue], ^{
      if (aServiceInstance != nil)
      {
          if (!services)
          {
              services = [[NSMutableDictionary alloc] init];
          }
          services[serviceName] = aServiceInstance;
      }
    });
}

+ (dispatch_queue_t)sharedQueue
{
    static dispatch_once_t onceToken;
    static dispatch_queue_t sharedQueue = nil;
    dispatch_once(&onceToken, ^{
      sharedQueue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
    });
    return sharedQueue;
}

@end
