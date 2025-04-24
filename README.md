<h1 align="center"><a href="https://github.com/Json031/SNUnitTests"><img src="https://img.shields.io/badge/swift-5.0-orange?logo=swift" title="Swift version" float=left></a><strong><a href="https://github.com/Json031/SNUnitTests">Click here to go to the Swift version</a></strong></h1>

# SNUnitTestsOC
[![CocoaPods](https://img.shields.io/cocoapods/v/SNUnitTestsOC.svg)](https://cocoapods.org/pods/SNUnitTestsOC)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://github.com/Json031/SNUnitTestsOC/blob/main/LICENSE)
<br>
SNUnitTestsOC 是一个基于XCTest框架开发的Objective-C开源项目，集成了 UI 自动化测试、高并发 以及 覆盖 API与类方法等范围的单元测试，方便开发者对应用程序的 UI 、 API、类方法高并发等模块 进行全面的自动化单元测试。
<br>SNUnitTestsOC is a Objective-C open source project developed based on the XCTest framework, which integrates UI automation testing, high concurrency, and unit testing covering APIs and class methods, making it convenient for developers to understand the UI API、 Conduct comprehensive automated unit testing on high concurrency modules such as class methods.
* 最新版本 Latest Version: 

# Installation 安装:

* CocoaPods
The [SNUnitTestsOC SDK for iOS](https://github.com/Json031/SNUnitTestsOC) is available through [CocoaPods](http://cocoapods.org). If CocoaPods is not installed, install it using the following command. Note that Ruby will also be installed, as it is a dependency of Cocoapods.
```bash
    brew install cocoapods
    pod setup
```
```bash
   $iOSVersion = '11.0'
   
   platform :ios, $iOSVersion
   use_frameworks!
   
   target 'YourProjectName' do

       target 'YourProjectNameTests' do
          inherit! :search_paths

          pod 'SNUnitTestsOC' # Full version with all features
       end
   end
```

* 手动安装 manual install
将Classes文件夹拽入项目中，OC项目还需要桥接
<br>Drag the Classes folder into the project, OC project still needs bridging

# 单元测试示例 Unit Test Example
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


# 问题或改进建议 <br> issues or improvement suggestions
如果你发现任何问题或有改进建议，请在 GitHub 上提交 [issue](https://github.com/Json031/SNUnitTestsOC/issues) 或 [pull request](https://github.com/Json031/SNUnitTestsOC/pulls)。
<br>If you find any issues or have improvement suggestions, please submit [issue](https://github.com/Json031/SNUnitTestsOC/issues) Or [pull request][pull request](https://github.com/Json031/SNUnitTestsOC/pulls) on GitHub.

# MIT 许可证 <br> MIT license
本项目采用 MIT 许可证，详情请参阅 [MIT License](https://github.com/Json031/SNUnitTestsOC/blob/main/LICENSE) 文件。
<br>This project adopts the MIT license, please refer to the [MIT License](https://github.com/Json031/SNUnitTestsOC/blob/main/LICENSE) document for details.
