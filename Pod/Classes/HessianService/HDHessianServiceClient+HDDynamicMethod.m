//
//  HDHessianServiceClient+HDDynamicMethod.m
//  Pods
//
//  Created by Dailingchi on 15/4/6.
//
//

#import "HDHessianServiceClient+HDDynamicMethod.h"
#import "HDHessianService.h"
#import "HDHessianMethod.h"

#import "BBSHessianObjC.h"

#import <objc/runtime.h>

@implementation HDHessianServiceClient (HDDynamicMethod)

//消息转发
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSMethodSignature *signature = [anInvocation methodSignature];
    NSUInteger numberOfArguments = [signature numberOfArguments];
    NSMutableArray *parameterList = [NSMutableArray array];
    for (NSUInteger index = 2; index < numberOfArguments; index++)
    {
        //以后扩展Block
        //        id __autoreleasing arg;
        //        [anInvocation getArgument:&arg atIndex:(index + 2)];
        const char *argumentType = [signature getArgumentTypeAtIndex:index];
        id objectValue =
            [self getObjectValueAtIndex:&index type:argumentType invocation:anInvocation];
        if (!objectValue)
        {
            [parameterList addObject:[NSNull null]];
        }
        else
        {
            [parameterList addObject:objectValue];
        }
    }
    [self dynamicHessianCallWithArguments:parameterList forInvocation:anInvocation];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSUInteger numArgs =
        [[NSStringFromSelector(aSelector) componentsSeparatedByString:@":"] count] - 1;
    NSMethodSignature *methodSignature =
        [NSMethodSignature signatureWithObjCTypes:[[@"@@:@" stringByPaddingToLength:numArgs + 3
                                                                         withString:@"@"
                                                                    startingAtIndex:0] UTF8String]];
    return methodSignature;
}

#pragma mark
#pragma mark Private Method

- (void)dynamicHessianCallWithArguments:(NSMutableArray *)parameterList
                          forInvocation:(NSInvocation *)invocation
{
    //以后扩展Block
    //    NSAssert([parameterList count] >= 2,
    //             @"Method signature must have at least two parameters - completion blocks.
    //             Example: - "
    //             @"(id)sendRequestWithSuccess:(void(^)(id result))successBlock "
    //             @"failure:(void(^)(NSError *error))failureBlock;");
    //    id lastParameter = [self lastBlockObject:parameterList];
    //    id parameterBeforeLastParameter = [self lastBlockObject:parameterList];
    //
    //    id successBlock;
    //    id failBlock;
    //    if (parameterBeforeLastParameter)
    //    {
    //        successBlock = parameterBeforeLastParameter;
    //        failBlock = lastParameter;
    //    }
    //    else if (lastParameter)
    //    {
    //        successBlock = lastParameter;
    //    }

    NSString *selectorName = NSStringFromSelector(invocation.selector);
    //获取服务配置
    HDHessianService *serviceAttribute =
        [[self class] RF_attributeForClassWithAttributeType:[HDHessianService class]];
    //获取远程方法配置
    HDHessianMethod *methodAttribute =
        [[self class] RF_attributeForMethod:selectorName withAttributeType:[HDHessianMethod class]];
    NSString *methodName = methodAttribute.serviceMethodName;
    if (!methodName)
    {
        //默认第一个标签
        methodName = [[selectorName componentsSeparatedByString:@":"] firstObject];
    }
    //调用hessian
    [BBSHessianProxy setClassMapping:methodAttribute.classMap];
    BBSHessianProxy *proxy =
        [[BBSHessianProxy alloc] initWithUrl:[NSURL URLWithString:serviceAttribute.serviceURL]];
    [proxy setRemoteClassPrefix:serviceAttribute.classPrefix];
    id __autoreleasing result = [proxy callSynchronous:methodName
                                        withParameters:parameterList
                                       timeoutInterval:serviceAttribute.timeoutInterval];
    [self setReturnValue:result invocation:invocation];
}

- (id)lastBlockObject:(NSMutableArray *)parameterList
{
    id lastObject = [parameterList lastObject];
    if ([[lastObject class] isSubclassOfClass:NSClassFromString(@"NSBlock")])
    {
        [parameterList removeLastObject];
    }
    else if (lastObject == [NSNull null])

    {
        [parameterList removeLastObject];
        lastObject = nil;
    }
    else
    {
        NSAssert([[lastObject class] isSubclassOfClass:NSClassFromString(@"NSBlock")] ||
                     lastObject == [NSNull null],
                 @"Last two parameters must be completion blocks (or nil - to ignore completion "
                 @"handling). Example: - (id)sendRequestWithSuccess:(void(^)(id "
                 @"result))successBlock failure:(void(^)(NSError *error))failureBlock;");
    }
    return lastObject;
}

#pragma mark
#pragma mark Hessian

- (id)getObjectValueAtIndex:(NSUInteger *)pIndex
                       type:(const char *)type
                 invocation:(NSInvocation *)invocation
{
    NSUInteger index = *pIndex;
    id objectValue = nil;
    if (strcmp(type, @encode(BOOL)) == 0)
    {
        BOOL value;
        [invocation getArgument:&value atIndex:index];
        objectValue = [NSNumber numberWithBool:value];
    }
    else if (strcmp(type, @encode(int32_t)) == 0)
    {
        int value;
        [invocation getArgument:&value atIndex:index];
        objectValue = [NSNumber numberWithInteger:value];
    }
    else if (strcmp(type, @encode(int64_t)) == 0)
    {
        int64_t value;
        [invocation getArgument:&value atIndex:index];
        objectValue = [NSNumber numberWithLongLong:value];
    }
    else if (strcmp(type, @encode(float)) == 0)
    {
        float value;
        [invocation getArgument:&value atIndex:index];
        objectValue = [NSNumber numberWithFloat:value];
    }
    else if (strcmp(type, @encode(double)) == 0)
    {
        double value;
        [invocation getArgument:&value atIndex:index];
        objectValue = [NSNumber numberWithDouble:value];
    }
    else if (strcmp(type, @encode(id)) == 0)
    {
        void *value;
        [invocation getArgument:&value atIndex:index];
        objectValue = (__bridge id)value;
    }
    else
    {
        [NSException raise:NSInvalidUnarchiveOperationException
                    format:@"Unsupported type %s", type];
    }
    return objectValue;
}

- (void)setReturnValue:(id)value invocation:(NSInvocation *)invocation
{
    BOOL isInvalidClass = NO;
    const char *type = [[invocation methodSignature] methodReturnType];
    if (strcmp(type, @encode(void)) == 0)
    {
        // void method not return
    }
    else if (strcmp(type, @encode(BOOL)) == 0)
    {
        if ([value isKindOfClass:[NSNumber class]])
        {
            BOOL tmp = [(NSNumber *)value boolValue];
            [invocation setReturnValue:&tmp];
        }
        else
        {
            isInvalidClass = YES;
        }
    }
    else if (strcmp(type, @encode(int32_t)) == 0)
    {
        if ([value isKindOfClass:[NSNumber class]])
        {
            int32_t tmp = [(NSNumber *)value intValue];
            [invocation setReturnValue:&tmp];
        }
        else
        {
            isInvalidClass = YES;
        }
    }
    else if (strcmp(type, @encode(int64_t)) == 0)
    {
        if ([value isKindOfClass:[NSNumber class]])
        {
            int64_t tmp = [(NSNumber *)value longLongValue];
            [invocation setReturnValue:&tmp];
        }
        else
        {
            isInvalidClass = YES;
        }
    }
    else if (strcmp(type, @encode(float)) == 0)
    {
        if ([value isKindOfClass:[NSNumber class]])
        {
            float tmp = [(NSNumber *)value floatValue];
            [invocation setReturnValue:&tmp];
        }
        else
        {
            isInvalidClass = YES;
        }
    }
    else if (strcmp(type, @encode(double)) == 0)
    {
        if ([value isKindOfClass:[NSNumber class]])
        {
            double tmp = [(NSNumber *)value doubleValue];
            [invocation setReturnValue:&tmp];
        }
        else
        {
            isInvalidClass = YES;
        }
    }
    else if (strcmp(type, @encode(id)) == 0)
    {
        if ([value isKindOfClass:[NSNull class]])
        {
            value = nil;
        }
        [invocation setReturnValue:&value];
    }
    else
    {
        [NSException raise:NSInvalidUnarchiveOperationException
                    format:@"Unsupported type %s", type];
    }

    if (isInvalidClass)
    {
        [NSException raise:NSInvalidUnarchiveOperationException
                    format:@"Invalid type %@", NSStringFromClass([value class])];
    }
}

@end