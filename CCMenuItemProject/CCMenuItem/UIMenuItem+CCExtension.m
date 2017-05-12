//
//  UIMenuItem+CCExtension.m
//  CCMenuItemProject
//
//  Created by CC on 12/05/2017.
//  Copyright © 2017 CC. All rights reserved.
//

#import "UIMenuItem+CCExtension.h"

#import <objc/runtime.h>

@implementation UIMenuItem (CCExtension)

- (void)setDictionary:(NSMutableDictionary *)dictionary {
    objc_setAssociatedObject(self, @selector(dictionary), dictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableDictionary *)dictionary {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setIntegerCurrentIndex:(NSInteger)integerCurrentIndex {
    objc_setAssociatedObject(self, @selector(integerCurrentIndex), @(integerCurrentIndex), OBJC_ASSOCIATION_ASSIGN);
}
- (NSInteger)integerCurrentIndex {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (NSString *)stringKey {
    return self.dictionary.allKeys.firstObject;
}

@end

#pragma mark - -----------------------------------------------------------------

@implementation UIMenuController (CCExtension)

- (UIMenuItem *(^)(NSInteger))blockMenuItem {
    __weak typeof(self) pSelf = self;
    return ^UIMenuItem *(NSInteger integerIndex) {
        if (integerIndex == -1) return nil;
        for (UIMenuItem *tempItem in pSelf.menuItems) {
            if (![tempItem isKindOfClass:[UIMenuItem class]]) continue;
            if (tempItem.integerCurrentIndex == integerIndex) return tempItem;
        }
        return nil;
    };
}

- (NSInteger (^)(NSString *))blockClickIndex {
    __weak typeof(self) pSelf = self;
    return ^NSInteger(NSString *stringTitle) {
        for (UIMenuItem *tempItem in pSelf.menuItems) {
            if (![tempItem isKindOfClass:[UIMenuItem class]]) continue;
            if ([tempItem.stringKey isEqualToString:stringTitle]) 
                return tempItem.integerCurrentIndex;
        }
        return -1;
    };
}

@end
