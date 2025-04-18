//
//  SNUnitTests.m
//
//  Created by MorganChen on 2025/4/17.
//  Copyright © 2025 MorganChen. All rights reserved.
//https://github.com/Json031/SNUnitTestsOC
//

#import "SNUnitTests.h"
#import "SNUnitTestsTool.h"

@implementation SNUnitTests

- (id)getMethodResultWithClass:(Class)classType
                        method:(id (^)(id instance))method
                         param:(id)param {
    id instance = [[classType alloc] init];
    id (^methodWithParam)(id) = method(instance);
    return methodWithParam(param);
}

- (id)getClassMethodResult:(id (^)(id _Nullable))method
                    param:(id)param {
    return method(param);
}

- (void)testMethodCallWithClass:(Class)classType
                         method:(id (^)(id instance))method
                          param:(id)param
                       expected:(id)expected
                    failMessage:(NSString *)failMessage {
    id result = [self getMethodResultWithClass:classType method:method param:param];
    [SNUnitTestsTool xctAssertEqualWithResult:result expected:expected failMessage:failMessage];
}

- (void)testClassMethodCall:(id (^)(id _Nullable))method
                      param:(id)param
                   expected:(id)expected
                failMessage:(NSString *)failMessage {
    id result = [self getClassMethodResult:method param:param];
    [SNUnitTestsTool xctAssertEqualWithResult:result expected:expected failMessage:failMessage];
}

- (void)highConcurrencyUnitTestingForClassMethodWithIterations:(NSInteger)iterations
                                                timeoutSeconds:(NSTimeInterval)timeoutSeconds
                                                       method:(id (^)(id _Nullable))method
                                                        param:(id)param
                                                     expected:(id)expected
                                                      verbose:(BOOL)verbose {
    XCTestExpectation *expectation = [SNUnitTestsTool createXCTestExpectationWithDescription:@"High concurrency unit testing for class method checks" iterations:iterations];

    NSLock *lock = [[NSLock alloc] init];
    NSMutableArray<NSNumber *> *failedIndices = [NSMutableArray array];

    dispatch_apply(iterations, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        id result = [self getClassMethodResult:method param:param];
        if (![result isEqual:expected]) {
            [lock lock];
            [failedIndices addObject:@(index)];
            [lock unlock];
            if (verbose) {
                NSLog(@"❌ Mismatch at index %zu, expected: %@, but got: %@", index, expected, result);
            }
        } else {
            if (verbose) {
                NSLog(@"✅ Match at index %zu", index);
            }
        }
        [expectation fulfill];
    });

    [self waitForExpectations:@[expectation] timeout:timeoutSeconds];
    XCTAssertTrue(failedIndices.count == 0, @"Failures occurred at indices: %@", failedIndices);
}

- (void)highConcurrencyUnitTestingForMethodWithIterations:(NSInteger)iterations
                                                timeoutSeconds:(NSTimeInterval)timeoutSeconds
                                                    classType:(Class)classType
                                                       method:(id (^)(id instance))method
                                                        param:(id)param
                                                     expected:(id)expected
                                                      verbose:(BOOL)verbose {
    XCTestExpectation *expectation = [SNUnitTestsTool createXCTestExpectationWithDescription:@"High concurrency unit testing for class method checks" iterations:iterations];

    NSLock *lock = [[NSLock alloc] init];
    NSMutableArray<NSNumber *> *failedIndices = [NSMutableArray array];

    dispatch_apply(iterations, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        id result = [self getMethodResultWithClass:classType method:method param:param];
        if (![result isEqual:expected]) {
            [lock lock];
            [failedIndices addObject:@(index)];
            [lock unlock];
            if (verbose) {
                NSLog(@"❌ Mismatch at index %zu, expected: %@, but got: %@", index, expected, result);
            }
        } else {
            if (verbose) {
                NSLog(@"✅ Match at index %zu", index);
            }
        }
        [expectation fulfill];
    });

    [self waitForExpectations:@[expectation] timeout:timeoutSeconds];
    XCTAssertTrue(failedIndices.count == 0, @"Failures occurred at indices: %@", failedIndices);
}

/// 效率性能检测 Efficiency Performance Testing
/// - Parameters:
///   - iterations: 迭代次数，默认10次 Iteration times, default is 10 time
///   - threshold: 最低耗时要求，单位秒 Minimum consumption time requirement, in seconds
///   - block: 检测对象运行代码块block    Detecting object running code block
///   - failMessage: 失败提示，默认nil    Failure prompt default is nil
- (void)efficiencyPerformanceTesting:(NSInteger)iterations
                           threshold:(NSTimeInterval)threshold
                               block:(void (^)(void))block
                         failMessage:(nullable NSString *)failMessage
{
    if (iterations <= 0) {
        iterations = 10;
    }

    NSTimeInterval totalTime = 0;

    for (NSInteger i = 0; i < iterations; i++) {
        CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
        block();
        CFAbsoluteTime elapsed = CFAbsoluteTimeGetCurrent() - startTime;
        totalTime += elapsed;
    }

    double averageTime = totalTime / (double)iterations;

    NSString *message = failMessage ?: [NSString stringWithFormat:@"Execution time exceeds the expected threshold of %lfs, actual time consumption: %lfs, number of iterations: %ld", threshold, averageTime, (long)iterations];

    NSLog(@"EficiencyPerformanceTesting time cost %lfs, number of iterations: %ld", averageTime, (long)iterations);

    XCTAssertLessThanOrEqual(averageTime, threshold, @"%@", message);
}

@end
