//
//  SNAPITests.h
//
//  Created by MorganChen on 2025/4/16.
//  Copyright © 2025 MorganChen. All rights reserved.
//https://github.com/Json031/SNUnitTestsOC
//
#import <XCTest/XCTest.h>

@interface SNAPITests : XCTestCase

- (BOOL)testAPIResponseCodeWithAddress:(NSString *)apiAddress expectedCode:(NSInteger)rspCode timeout:(NSUInteger)timeout;
- (BOOL)testAPIResponseTimeWithAddress:(NSString *)apiAddress timeoutMillis:(NSUInteger)timeout;
- (void)testAPIResponseIsValidJSONWithAddress:(NSString *)apiAddress;
- (void)testAPIResponseContainsRequiredFieldsWithAddress:(NSString *)apiAddress;
- (void)testAPINotFoundResponseWithAddress:(NSString *)apiAddress;
- (void)testAPIPostRequestWithAddress:(NSString *)apiAddress;

@end
