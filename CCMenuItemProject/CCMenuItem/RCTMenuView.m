//
//  RCTMenuView.m
//  RCTExtension
//
//  Created by CC on 2017/4/19.
//  Copyright © 2017年 CC. All rights reserved.
//

#import "RCTMenuView.h"

#import "RCTMenuView+CCDynamicGenerateMethod.h"

@interface RCTMenuView()

#pragma mark - EDIT BY CC - --
- (void) ccDefaultSettings ;
- (void) ccAddMenuNotification ;
- (void) ccDidHideMenu : (NSNotification *) sender ;
- (void) ccWillHideMenu : (NSNotification *) sender ;

@property (nonatomic , strong) UIMenuController *menuController ;

@property (nonatomic , strong) NSMutableArray *arrayMenuItem ;
@property (nonatomic , copy) void(^blockClickAction)(NSMutableDictionary *dictionaryValue ,
                                                        NSString *stringKey ,
                                                        NSString *stringValue) ;
@property (nonatomic , copy) dispatch_block_t blockCloseAction ;

@end

@implementation RCTMenuView

#pragma mark - EDIT BY CC - --
- (instancetype)init {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        
        [self ccDefaultSettings];
    }
    return self;
}

#pragma mark - PUBLIC
- (void)ccShowMenu : (CGRect) rectFrame {
    self.class.arrayKeys = self.dictionaryTitleItem.allKeys;
    
    if (self.menuController.isMenuVisible) return ;
    
    [self.arrayMenuItem removeAllObjects];
    __block NSInteger integerIndex = 0;
    
    __weak typeof(self) pSelf = self;
    [self.dictionaryTitleItem enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        void (^blockAddMethod)(UIMenuItem *menuItem , SEL selector) = ^(UIMenuItem *menuItem , SEL selector) {
            [menuItem setTitle:obj];
            [menuItem setAction:selector];
            menuItem.integerCurrentIndex = integerIndex ++ ;
            menuItem.dictionary = [NSMutableDictionary dictionaryWithObject:obj
                                                                     forKey:key];
            [pSelf.arrayMenuItem addObject:menuItem];
        };
        
        if ([key isKindOfClass:[NSString class]] && [obj isKindOfClass:[NSString class]]) {
            UIMenuItem *menuItem = [[UIMenuItem alloc] init];
            SEL selector = NSSelectorFromString(key);
            if (blockAddMethod) {
                if ([pSelf.class resolveInstanceMethod:selector]) {
                    if ([pSelf respondsToSelector:selector]) {
                        blockAddMethod(menuItem , selector);
                    }
                }
                else if ([pSelf respondsToSelector:selector]) {
                    blockAddMethod(menuItem , selector);
                }
            }
        }
    }];
    
    self.menuController.menuItems = self.arrayMenuItem;
    [self becomeFirstResponder];
    [self.menuController setTargetRect:rectFrame
                                inView:self];
    [self.menuController setMenuVisible:YES
                               animated:YES];
}
- (void) ccClickAction : (void(^)(NSMutableDictionary *dictionaryValue ,
                                  NSString *stringKey ,
                                  NSString *stringValue)) blockClick
       withCloseAction : (dispatch_block_t) blockClose  {
    self.blockClickAction = [blockClick copy];
    self.blockCloseAction = [blockClose copy];
}

#pragma mark - NOTIFICATION
- (void) ccAddMenuNotification {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(ccWillHideMenu:)
                          name:UIMenuControllerWillHideMenuNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(ccDidHideMenu:)
                          name:UIMenuControllerDidHideMenuNotification
                        object:nil];
}
- (void) ccDidHideMenu : (NSNotification *) sender {
    [self removeFromSuperview];
    if (self.blockCloseAction) self.blockCloseAction();
}
- (void) ccWillHideMenu : (NSNotification *) sender {
    if ([self canResignFirstResponder]) {
        [self resignFirstResponder];
    }
}

#pragma mark - Private
- (void)ccDefaultSettings {
    [self ccAddMenuNotification];
    
    __weak typeof(self) pSelf = self;
    self.blockStringTitle = ^(NSString *stringTitle) {
        NSInteger integerIndex = pSelf.menuController.blockClickIndex(stringTitle);
        UIMenuItem *menuItem = pSelf.menuController.blockMenuItem(integerIndex);
        if (pSelf.blockClickAction)
            pSelf.blockClickAction(menuItem.dictionary ,
                                   menuItem.dictionary.allKeys.firstObject,
                                   menuItem.dictionary.allValues.firstObject);
    };
}

#pragma mark - SYSTEM // Override
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    for (NSString *tempKey in self.dictionaryTitleItem.allKeys) {
        if ([NSStringFromSelector(action) containsString:tempKey]) {
            return YES;
        }
    }
    return false;
}

#pragma mark - Getter
- (NSMutableArray *)arrayMenuItem {
    if (_arrayMenuItem) return _arrayMenuItem;
    _arrayMenuItem = [NSMutableArray array];
    return _arrayMenuItem;
}

- (UIMenuController *)menuController {
    if (_menuController) return _menuController;
    _menuController = [UIMenuController sharedMenuController];
    return _menuController;
}

- (void)dealloc {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:UIMenuControllerWillHideMenuNotification];
    [defaultCenter removeObserver:UIMenuControllerDidHideMenuNotification];
    
    NSLog(@"_CC_DEALLOC_");
}

#warning TODO >>> TEST / Need Delete / Get data from outside
- (NSDictionary *)dictionaryTitleItem {
    if (_dictionaryTitleItem) return _dictionaryTitleItem;
    _dictionaryTitleItem = @{@"copyy" : @"复制" ,
                             @"deletee" : @"删除" ,
                             @"translatee" : @"翻译" ,
                             @"moree" : @"更多"};
    return _dictionaryTitleItem;
}

@end
