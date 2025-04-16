//
//  SNAPITests.m
//
//  Created by MorganChen on 2025/4/16.
//  Copyright © 2025 MorganChen. All rights reserved.
//https://github.com/Json031/SNUnitTestsOC
//

#import "SNAPITests.h"
#import "SNAPITestsTool.h"

@implementation SNAPITests

- (BOOL)testAPIResponseCodeWithAddress:(NSString *)apiAddress expectedCode:(NSInteger)rspCode timeout:(NSUInteger)timeout {
    return [SNAPITestsTool testAPIResponseCodeWithTestCase:self apiAddress:apiAddress expectedCode:rspCode timeout:timeout];
}

- (BOOL)testAPIResponseTimeWithAddress:(NSString *)apiAddress timeoutMillis:(NSUInteger)timeout {
    return [SNAPITestsTool testAPIResponseTimeWithTestCase:self apiAddress:apiAddress timeoutMillis:timeout];
}

- (void)testAPIResponseIsValidJSONWithAddress:(NSString *)apiAddress {
    [SNAPITestsTool testAPIResponseIsValidJSONWithTestCase:self apiAddress:apiAddress];
}

- (void)testAPIResponseContainsRequiredFieldsWithAddress:(NSString *)apiAddress {
    [SNAPITestsTool testAPIResponseContainsRequiredFieldsWithTestCase:self apiAddress:apiAddress];
}

- (void)testAPINotFoundResponseWithAddress:(NSString *)apiAddress {
    [SNAPITestsTool testAPINotFoundResponseWithTestCase:self apiAddress:apiAddress];
}

- (void)testAPIPostRequestWithAddress:(NSString *)apiAddress {
    [SNAPITestsTool testAPIPostRequestWithTestCase:self apiAddress:apiAddress];
}

@end
