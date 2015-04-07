#import "HDServiceProvider+HDTest.h"
#import "HDServiceProvider.h"
#import "HDServiceTest.h"
#import <Foundation/Foundation.h>
 
@interface HDServiceProvider(RFAttribute)
 
@end
 
@implementation HDServiceProvider(RFAttribute)
 
#pragma mark - Fill Attributes generated code (Methods section)

+ (NSArray *)RF_attributes_HDServiceProvider_method_shareTestService_p0 {
    NSMutableArray *RF_attributes_list_HDServiceProvider_method_shareTestService_p0 = [RFAttributeCacheManager objectForKey:@"RFAL_HDServiceProvider_method_shareTestService_p0"];
    if (RF_attributes_list_HDServiceProvider_method_shareTestService_p0 != nil) {
        return RF_attributes_list_HDServiceProvider_method_shareTestService_p0;
    }
    
    NSMutableArray *attributesArray = [NSMutableArray arrayWithCapacity:1];
    
    HDService *attr1 = [[HDService alloc] init];
    attr1.serviceClass = [HDServiceTest class];
    [attributesArray addObject:attr1];

    RF_attributes_list_HDServiceProvider_method_shareTestService_p0 = attributesArray;
    [RFAttributeCacheManager setObject:attributesArray forKey:@"RFAL_HDServiceProvider_method_shareTestService_p0"];
    
    return RF_attributes_list_HDServiceProvider_method_shareTestService_p0;
}

+ (NSMutableDictionary *)RF_attributesFactoriesForMethods {
    NSMutableDictionary *attributesHDServiceProviderFactoriesForMethodsDict = [RFAttributeCacheManager objectForKey:@"RFHDServiceProviderFactoriesForMethods"];
    if (attributesHDServiceProviderFactoriesForMethodsDict != nil) {
        return attributesHDServiceProviderFactoriesForMethodsDict;
    }
    
    NSMutableDictionary *dictionaryHolder = [super RF_attributesFactoriesForMethods];
    
    if (!dictionaryHolder) {
        dictionaryHolder = [NSMutableDictionary dictionary];
        [RFAttributeCacheManager setObject:dictionaryHolder forKey:@"RFHDServiceProviderFactoriesForMethods"];
    }
    
    [dictionaryHolder setObject:[self RF_invocationForSelector:@selector(RF_attributes_HDServiceProvider_method_shareTestService_p0)] forKey:@"shareTestService"];
    attributesHDServiceProviderFactoriesForMethodsDict = dictionaryHolder;  
    
    return attributesHDServiceProviderFactoriesForMethodsDict;
}


#pragma mark - 

@end
