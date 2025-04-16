//
//  SNUITests.m
//
//  Created by MorganChen on 2025/4/16.
//  Copyright © 2025 MorganChen. All rights reserved.
//https://github.com/Json031/SNUnitTestsOC
//

#import "SNUITests.h"
#import "SNUITestsTool.h"

@interface SNUITests ()
@property (nonatomic, strong) UIViewController *viewController;
@end

@implementation SNUITests

+ (instancetype)createWithViewController:(UIViewController *)viewController {
    SNUITests *instance = [[self alloc] init];
    [instance configWithViewController:viewController];
    return instance;
}

- (void)configWithViewController:(UIViewController *)viewController {
    self.viewController = viewController;
}

- (void)setUpWithError {
    XCTAssertNotNil(self.viewController, @"Please config viewController first");
    [self.viewController loadViewIfNeeded];
}

- (BOOL)clickCellAtIndex:(NSIndexPath *)indexPath nextPageClass:(Class)nextPageClass newViewClass:(Class)newViewClass {
    UITableView *tableView = [SNUITestsTool queryTableViewFromVC:self.viewController];
    BOOL result = [SNUITestsTool tableViewClickIndexPath:tableView indexPath:indexPath];
    if (!result) {
        XCTAssertTrue(result);
        return NO;
    }
    if (nextPageClass) {
        BOOL hasPush = [SNUITestsTool hasPushPage:self.viewController nextPageClass:nextPageClass];
        XCTAssertTrue(hasPush);
        return hasPush;
    }
    if (newViewClass) {
        BOOL isInView = [SNUITestsTool detectViewIsInViewControllerHierarchy:self.viewController viewClass:newViewClass];
        XCTAssertTrue(isInView);
        return isInView;
    }
    return YES;
}

- (BOOL)clickBtnAtTag:(NSInteger)tag nextPageClass:(Class)nextPageClass newViewClass:(Class)newViewClass {
    BOOL result = [SNUITestsTool clickBtnAtTag:self.viewController tag:tag];
    if (!result) {
        XCTAssertTrue(result);
        return NO;
    }
    if (nextPageClass) {
        BOOL hasPush = [SNUITestsTool hasPushPage:self.viewController nextPageClass:nextPageClass];
        XCTAssertTrue(hasPush);
        return hasPush;
    }
    if (newViewClass) {
        BOOL isInView = [SNUITestsTool detectViewIsInViewControllerHierarchy:self.viewController viewClass:newViewClass];
        XCTAssertTrue(isInView);
        return isInView;
    }
    return YES;
}

- (void)tapTabBarItemAtIndex:(NSInteger)index {
    if (![self.viewController isKindOfClass:[UITabBarController class]]) {
        XCTFail(@"viewController is not UITabBarController");
        return;
    }
    UITabBarController *tabBarController = (UITabBarController *)self.viewController;
    NSArray *items = tabBarController.tabBar.items;
    XCTAssertTrue(index < items.count, @"Tab index out of range");
    tabBarController.selectedIndex = index;
    XCTAssertEqual(tabBarController.selectedIndex, index, @"TabBar did not switch correctly");
}

- (BOOL)pollingLabelTextWithTag:(NSInteger)tag expectedText:(NSString *)expectedText timeOut:(NSUInteger)timeOut {
    return [SNUITestsTool pollingLabelTextWithTestCase:self viewController:self.viewController tag:tag expectedText:expectedText timeOut:timeOut];
}

@end
