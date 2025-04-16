//
//  SNAPITestsTool.h
//
//  Created by MorganChen on 2025/4/16.
//  Copyright © 2025 MorganChen. All rights reserved.
//https://github.com/Json031/SNUnitTestsOC
//

#import <XCTest/XCTest.h>

@interface SNAPITestsTool : NSObject

+ (BOOL)testAPIResponseCodeWithTestCase:(XCTestCase *)testCase apiAddress:(NSString *)apiAddress expectedCode:(NSInteger)code timeout:(NSUInteger)timeout;
+ (BOOL)testAPIResponseTimeWithTestCase:(XCTestCase *)testCase apiAddress:(NSString *)apiAddress timeoutMillis:(NSUInteger)timeout;
+ (void)testAPIResponseIsValidJSONWithTestCase:(XCTestCase *)testCase apiAddress:(NSString *)apiAddress;
+ (void)testAPIResponseContainsRequiredFieldsWithTestCase:(XCTestCase *)testCase apiAddress:(NSString *)apiAddress;
+ (void)testAPINotFoundResponseWithTestCase:(XCTestCase *)testCase apiAddress:(NSString *)apiAddress;
+ (void)testAPIPostRequestWithTestCase:(XCTestCase *)testCase apiAddress:(NSString *)apiAddress;

@end
