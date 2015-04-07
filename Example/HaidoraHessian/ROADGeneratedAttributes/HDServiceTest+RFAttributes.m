#import "HDServiceTest.h"
#import <Foundation/Foundation.h>
#import <HaidoraHessian.h>
 
@interface HDServiceTest(RFAttribute)
 
@end
 
@implementation HDServiceTest(RFAttribute)
 
#pragma mark - Fill Attributes generated code (Methods section)

+ (NSArray *)RF_attributes_HDServiceTest_method_login_p3 {
    NSMutableArray *RF_attributes_list_HDServiceTest_method_login_p3 = [RFAttributeCacheManager objectForKey:@"RFAL_HDServiceTest_method_login_p3"];
    if (RF_attributes_list_HDServiceTest_method_login_p3 != nil) {
        return RF_attributes_list_HDServiceTest_method_login_p3;
    }
    
    NSMutableArray *attributesArray = [NSMutableArray arrayWithCapacity:1];
    
    HDHessianMethod *attr1 = [[HDHessianMethod alloc] init];
    attr1.serviceMethodName = @"login";
    [attributesArray addObject:attr1];

    RF_attributes_list_HDServiceTest_method_login_p3 = attributesArray;
    [RFAttributeCacheManager setObject:attributesArray forKey:@"RFAL_HDServiceTest_method_login_p3"];
    
    return RF_attributes_list_HDServiceTest_method_login_p3;
}

+ (NSMutableDictionary *)RF_attributesFactoriesForMethods {
    NSMutableDictionary *attributesHDServiceTestFactoriesForMethodsDict = [RFAttributeCacheManager objectForKey:@"RFHDServiceTestFactoriesForMethods"];
    if (attributesHDServiceTestFactoriesForMethodsDict != nil) {
        return attributesHDServiceTestFactoriesForMethodsDict;
    }
    
    NSMutableDictionary *dictionaryHolder = [super RF_attributesFactoriesForMethods];
    
    if (!dictionaryHolder) {
        dictionaryHolder = [NSMutableDictionary dictionary];
        [RFAttributeCacheManager setObject:dictionaryHolder forKey:@"RFHDServiceTestFactoriesForMethods"];
    }
    
    [dictionaryHolder setObject:[self RF_invocationForSelector:@selector(RF_attributes_HDServiceTest_method_login_p3)] forKey:@"login:password:imei:"];
    attributesHDServiceTestFactoriesForMethodsDict = dictionaryHolder;  
    
    return attributesHDServiceTestFactoriesForMethodsDict;
}


#pragma mark - 

#pragma mark - Fill Attributes generated code (Class section)

+ (NSArray *)RF_attributesForClass {
    NSMutableArray *RF_attributes_list__class_HDServiceTest = [RFAttributeCacheManager objectForKey:@"RFAL__class_HDServiceTest"];
    if (RF_attributes_list__class_HDServiceTest != nil) {
        return RF_attributes_list__class_HDServiceTest;
    }
    
    NSMutableArray *attributesArray = [NSMutableArray arrayWithCapacity:1];
    
    HDHessianService *attr1 = [[HDHessianService alloc] init];
    attr1.serviceURL = @"http://app.gosmarthome.cn/hessian/BocoAccountService";
    attr1.timeoutInterval = 30;
    [attributesArray addObject:attr1];

    RF_attributes_list__class_HDServiceTest = attributesArray;
    [RFAttributeCacheManager setObject:attributesArray forKey:@"RFAL__class_HDServiceTest"];
    
    return RF_attributes_list__class_HDServiceTest;
}

#pragma mark - 

@end
