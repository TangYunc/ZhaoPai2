//
//  ConditionDoubleTableView.h
//  ZhaoPai
//
//  Created by Mr_Tang on 16/1/27.
//  Copyright © 2016年 Mr_Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConditionDoubleTableView;

@protocol ConditionDoubleTableViewDelegate <NSObject>

@required
- (void)selectedFirstValue:(NSString *)first SecondValue:(NSString *)second;
- (void)hideMenu;

@end

@interface ConditionDoubleTableView : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    UIView *_rootView;
    
    UITableView *_firstTableView;
    UITableView *_secondTableView;
    
    NSArray *_leftItems;
    NSArray *_rightItems;
    NSArray *_leftArray;
    NSArray *_rightArray;
    
    NSInteger firstSelectedIndex;
    NSInteger secondSelectedIndex;
    
    NSInteger _buttonIndex;
    
    BOOL isHidden;
}

@property (nonatomic, strong) id <ConditionDoubleTableViewDelegate>delegate;

//初始化下拉菜单
- (id)initWithFrame:(CGRect)frame andLeftItems:(NSArray *)leftItems andRightItems:(NSArray *)RightItems;
//显示下拉菜单
- (void)showTableView:(NSInteger)index WithSelectedLeft:(NSString *)left Right:(NSString *)right;
- (void)hideTableView;


@end
