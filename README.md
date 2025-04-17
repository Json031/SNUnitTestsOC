<h1 align="center"><a href="https://github.com/Json031/SNUnitTests"><img src="https://img.shields.io/badge/swift-5.0-orange?logo=swift" title="Swift version" float=left></a><strong><a href="https://github.com/Json031/SNUnitTests">Click here to go to the Swift version</a></strong></h1>

# SNUnitTestsOC
SNUnitTestsOC 是一个基于XCTest框架开发的Objective-C开源项目，集成了 UI 自动化测试、高并发 以及 覆盖 API与类方法等范围的单元测试，方便开发者对应用程序的 UI 、 API、类方法高并发等模块 进行全面的自动化单元测试。
<br>SNUnitTestsOC is a Objective-C open source project developed based on the XCTest framework, which integrates UI automation testing, high concurrency, and unit testing covering APIs and class methods, making it convenient for developers to understand the UI API、 Conduct comprehensive automated unit testing on high concurrency modules such as class methods.
* 最新版本 Latest Version: [![CocoaPods](https://img.shields.io/cocoapods/v/SNUnitTestsOC.svg)](https://cocoapods.org/pods/SNUnitTestsOC)

## 单元测试示例 Unit Test Example
![20250417092731](https://github.com/user-attachments/assets/d96a72d3-994d-44ca-88b6-629141da0e90)


单元测试示例代码 Unit Test Example Code
```
#import "UnityTool.h"

@implementation UnityTool

- (BOOL)isEmptyString:(NSString *)sourceStr {
    if ([sourceStr isEqual:@""]) {
        return YES;
    }
    if (sourceStr == nil) {
        return YES;
    }
    return NO;
}

+ (BOOL)isEmptyString:(NSString *)sourceStr {
    if ([sourceStr isEqual:@""]) {
        return YES;
    }
    if (sourceStr == nil) {
        return YES;
    }
    return NO;
}
@end
```

```
#import <XCTest/XCTest.h>
#import "SNUnitTests.h"
#import "UnityTool.h"

@interface MyProjectDataToolTests : XCTestCase

@property (nonatomic, strong) SNUnitTests *snUnitTests;


@end

@implementation MyProjectDataToolTests

- (BOOL)setUpWithError:(NSError *__autoreleasing  _Nullable *)error {
    if (self.snUnitTests == nil) {
        self.snUnitTests = [[SNUnitTests alloc] init];
        // 确保 snUnitTests 加载完成
        XCTAssertNotNil(self.snUnitTests);
    }
    
    return true;
}

//UnityTool类单元测试
-(void)testUnityToolClass {
    id resultObj = [self.snUnitTests getMethodResultWithClass:[UnityTool class] method:^id(id instance) {
        return ^id(id param) {
            return @([(UnityTool *)instance isEmptyString:(NSString *)param]);
        };
    }
                                   param:@"sds"];
    Boolean result = [resultObj boolValue];

    NSLog(@"UnityTool isEmptyString result: %hhu", result);
    
    id classMethodResultObj = [self.snUnitTests getClassMethodResult:^id(id param) {
        return @([UnityTool isEmptyString:(NSString *)param]);
    }
                                     param:@"sds"];
    Boolean classMethodResult = [classMethodResultObj boolValue];
    NSLog(@"UnityTool isEmptyString result:%hhu", classMethodResult);
    
    [self.snUnitTests testClassMethodCall:^id(id param) {
        return @([UnityTool isEmptyString:(NSString *)param]);
    }
                                     param:@"sds"
                                  expected:@(NO)
                               failMessage:nil];
    
    [self.snUnitTests testMethodCallWithClass:[UnityTool class]
                                  method:^id(id instance) {
        return ^id(id param) {
            return @([(UnityTool *)instance isEmptyString:(NSString *)param]);
        };
    }
                                   param:@"sds"
                                expected:@(NO)
                             failMessage:nil];
    
    //高并发单元测试
    [self.snUnitTests highConcurrencyUnitTestingForClassMethodWithIterations:1000 timeoutSeconds:1000 classType:[UnityTool class] method:^id(id instance) {
        return ^id(id param) {
            return @([(UnityTool *)instance isEmptyString:(NSString *)param]);
        };
    } param:@"dsad" expected:@(NO) verbose:NO];
}
@end

```
