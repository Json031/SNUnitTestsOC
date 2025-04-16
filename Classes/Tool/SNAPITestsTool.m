//
//  SNAPITestsTool.m
//
//  Created by MorganChen on 2025/4/16.
//  Copyright © 2025 MorganChen. All rights reserved.
//https://github.com/Json031/SNUnitTestsOC
//

#import "SNAPITestsTool.h"

@implementation SNAPITestsTool

+ (BOOL)testAPIResponseCodeWithTestCase:(XCTestCase *)testCase apiAddress:(NSString *)apiAddress expectedCode:(NSInteger)code timeout:(NSUInteger)timeout {
    XCTestExpectation *expectation = [testCase expectationWithDescription:[NSString stringWithFormat:@"API should return code %ld", (long)code]];
    __block BOOL success = NO;

    NSURL *url = [NSURL URLWithString:apiAddress];
    if (!url) {
        XCTFail(@"Invalid URL: %@", apiAddress);
        return NO;
    }

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            XCTFail(@"Request failed: %@", error.localizedDescription);
        } else {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
            success = (httpResp.statusCode == code);
            XCTAssertEqual(httpResp.statusCode, code);
        }
        [expectation fulfill];
    }];
    [task resume];

    [testCase waitForExpectationsWithTimeout:(NSTimeInterval)timeout handler:nil];
    return success;
}

+ (BOOL)testAPIResponseTimeWithTestCase:(XCTestCase *)testCase apiAddress:(NSString *)apiAddress timeoutMillis:(NSUInteger)timeout {
    XCTestExpectation *expectation = [testCase expectationWithDescription:@"API response within time"];
    __block BOOL success = NO;

    NSURL *url = [NSURL URLWithString:apiAddress];
    if (!url) {
        XCTFail(@"Invalid URL: %@", apiAddress);
        return NO;
    }

    NSDate *start = [NSDate date];

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSUInteger duration = (NSUInteger)([[NSDate date] timeIntervalSinceDate:start] * 1000);
        NSLog(@"API response time: %lu ms", (unsigned long)duration);
        success = duration < timeout;
        XCTAssertTrue(success, @"Response time too long: %lu ms", (unsigned long)duration);
        [expectation fulfill];
    }];
    [task resume];

    [testCase waitForExpectationsWithTimeout:60 handler:nil];
    return success;
}

+ (void)testAPIResponseIsValidJSONWithTestCase:(XCTestCase *)testCase apiAddress:(NSString *)apiAddress {
    XCTestExpectation *expectation = [testCase expectationWithDescription:@"Valid JSON"];

    NSURL *url = [NSURL URLWithString:apiAddress];
    if (!url) {
        XCTFail(@"Invalid URL: %@", apiAddress);
        return;
    }

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNotNil(data);

        NSError *jsonError;
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        XCTAssertNotNil(json, @"Invalid JSON");
        XCTAssertNil(jsonError, @"JSON parsing error: %@", jsonError.localizedDescription);

        [expectation fulfill];
    }];
    [task resume];

    [testCase waitForExpectationsWithTimeout:5 handler:nil];
}

+ (void)testAPIResponseContainsRequiredFieldsWithTestCase:(XCTestCase *)testCase apiAddress:(NSString *)apiAddress {
    XCTestExpectation *expectation = [testCase expectationWithDescription:@"JSON contains required fields"];

    NSURL *url = [NSURL URLWithString:apiAddress];
    if (!url) {
        XCTFail(@"Invalid URL: %@", apiAddress);
        return;
    }

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNotNil(data);

        NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        XCTAssert([json isKindOfClass:[NSDictionary class]]);
        XCTAssertNotNil(json[@"userId"]);
        XCTAssertNotNil(json[@"id"]);
        XCTAssertNotNil(json[@"title"]);
        XCTAssertNotNil(json[@"body"]);

        [expectation fulfill];
    }];
    [task resume];

    [testCase waitForExpectationsWithTimeout:5 handler:nil];
}

+ (void)testAPINotFoundResponseWithTestCase:(XCTestCase *)testCase apiAddress:(NSString *)apiAddress {
    XCTestExpectation *expectation = [testCase expectationWithDescription:@"404 Not Found"];

    NSURL *url = [NSURL URLWithString:apiAddress];
    if (!url) {
        XCTFail(@"Invalid URL: %@", apiAddress);
        return;
    }

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
        XCTAssertEqual(httpResp.statusCode, 404);
        [expectation fulfill];
    }];
    [task resume];

    [testCase waitForExpectationsWithTimeout:5 handler:nil];
}

+ (void)testAPIPostRequestWithTestCase:(XCTestCase *)testCase apiAddress:(NSString *)apiAddress {
    XCTestExpectation *expectation = [testCase expectationWithDescription:@"POST request success"];

    NSURL *url = [NSURL URLWithString:apiAddress];
    if (!url) {
        XCTFail(@"Invalid URL: %@", apiAddress);
        return;
    }

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *body = @{@"title": @"foo", @"body": @"bar", @"userId": @1};
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    request.HTTPBody = bodyData;

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
        XCTAssertEqual(httpResp.statusCode, 201);
        [expectation fulfill];
    }];
    [task resume];

    [testCase waitForExpectationsWithTimeout:5 handler:nil];
}

@end
