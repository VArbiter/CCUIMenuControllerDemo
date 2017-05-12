//
//  UIView+CCDynamicGenerateMethod.m
//  CCMenuItemProject
//
//  Created by CC on 12/05/2017.
//  Copyright © 2017 CC. All rights reserved.
//

#import "RCTMenuView+CCDynamicGenerateMethod.h"

#import <objc/runtime.h>

static NSArray *_arrayKeys = nil;

@implementation RCTMenuView (CCDynamicGenerateMethod)

+ (BOOL) resolveInstanceMethod:(SEL)sel {
    for (id obj in self.arrayKeys) {
        if (![obj isKindOfClass:[NSString class]]) continue;
        NSString *stringKey = (NSString *) obj ;
        if (sel == NSSelectorFromString(stringKey)) {
            return class_addMethod([self class],
                                   sel,
                                   class_getMethodImplementation(self, @selector(_CC_DYNAMIC_METHOD_GENERATOR_IMPLEMENTATION_:)),
                                   "s@:@");;
        }
    }
    return [super resolveInstanceMethod:sel];
}

- (void) _CC_DYNAMIC_METHOD_GENERATOR_IMPLEMENTATION_ : (id) sender  {
    if (self.blockStringTitle)
        self.blockStringTitle([NSString stringWithUTF8String:sel_getName(_cmd)]);
}

- (void)setBlockStringTitle:(void (^)(NSString *))blockStringTitle {
    objc_setAssociatedObject(self, @selector(blockStringTitle), blockStringTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(NSString *))blockStringTitle {
    return objc_getAssociatedObject(self, _cmd);
}

+ (void)setArrayKeys:(NSArray *)arrayKeys {
    _arrayKeys = arrayKeys;
}
+ (NSArray *)arrayKeys {
    return _arrayKeys;
}

@end
