//
//  YYCPopupView.h
//  LearningDemo
//
//  Created by Troyan on 2018/8/4.
//  Copyright © 2018 Troyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

#define YYCPopupViewDefaultThemeColor [UIColor colorWithRed:0.0 green:178.0/255.0 blue:238.0/255.0 alpha:1.0]
#define YYCPopupViewDefaultBackgroundColor [UIColor colorWithWhite:0.0 alpha:0.5]
#define YYCPopupViewExeptionInvalidInitializer ([NSException exceptionWithName:@"非法初始化方法" reason:@"不支持该初始化方式" userInfo:nil])

@class YYCPopupView;
/**
 *  @brief  YYCPopupView的底部按钮点击事件的回调Block，参数popupView是弹框视图，btnIndex是按钮索引，info在回调需要传递数据时使用
 */
typedef void(^YYCPopupButtonClickBlock)(YYCPopupView* popupView, NSUInteger btnIndex, id info);
/**
 *  @brief  YYCPopupView的弹框样式，None表示无动画，Emage是视图alpha 0->1，SlideUp是主内容视图从底部上移显示
 */
typedef enum : NSUInteger {
    YYCPopupViewAnimationStyleNone,
    YYCPopupViewAnimationStyleEmerge,
    YYCPopupViewAnimationStyleSlideUp
} YYCPopupViewAnimationStyle;

#pragma mark - define YYCPopupView class
/**
 *  @brief  背景占满 显示弹框的父视图 的弹框视图基类，弹框操作步骤：
 *              1、init初始化；
 *              2、配置可配置属性；
 *              3、调用setupWithTitleInfo: ...方法 配置数据；
 *              4、调用showInView: 方法弹框显示
 *          通过重写setupConfigurablePropertiesBeforeLayout配置自定义的 弹框统一样式 属性，重写
 *          layoutTitleView、layoutContentView、layoutButtonView指定三个主要视图的布局过程，实
 *          现对基类的扩展
 */
@interface YYCPopupView : UIView{
    @protected
    //子视图
    __weak UIView* backgroudView;
    __weak UIView* mainFrameView;
    __weak UIView* titleView;
    __weak UIView* contentView;
    __weak UIView* buttonView;
    //视图数据
    id titleInfo;
    id contentInfo;
    NSArray* buttonInfoList;
    //底部按钮回调
    YYCPopupButtonClickBlock buttonClickBlock;
}

#pragma mark - configurable common style properties
//可配置的 弹框统一样式 属性
/**
 *  @brief  弹框主题颜色
 */
@property(strong, nonatomic) UIColor* themeColor;
/**
 *  @brief  弹框背景颜色
 */
@property(strong, nonatomic) UIColor* backgroundColor;
/**
 *  @brief  点击按钮是否总是关闭弹窗，若为否，则用户需自己按需调用close关闭弹窗
 */
@property(assign, nonatomic) BOOL autoCloseOnClickButton;
/**
 *  @brief  按钮视图是否使用默认的”取消-确定“布局，优先级高于layoutButtonViewBeforeShow，
 *          若指定为YES则不执行layoutButtonViewBeforeShow内的逻辑
 */
@property(assign, nonatomic) BOOL useDefaultButtonList;
/**
 *  @brief  决定弹窗位置和动画效果
 */
@property(assign, nonatomic) YYCPopupViewAnimationStyle animationStyle;

#pragma mark - interface methods
//对使用弹框的Client开放的接口
/**
 *  @brief  配置弹框数据
 *  @param  ttlInfo     标题视图数据
 *  @param  cntInfo     标题视图数据
 *  @param  btnInfoList     标题视图数据
 *  @param  btnClickBlk     按钮点击事件回调Block
 */
-(void)setupInfoWithTitleInfo:(id)ttlInfo contentInfo:(id)cntInfo buttonInfoList:(NSArray*)btnInfoList buttonClickBlock:(YYCPopupButtonClickBlock)btnClickBlk;
/**
 *  @brief  在视图中弹出YYCPopupView
 */
-(void)showInView:(UIView*)inView;
/**
 *  @brief  关闭YYCPopupView弹框
 */
-(void)close;

#pragma mark - methods to be override
//主视图布局，对扩展YYCPopupView基类 开放的接口
/**
 *  @brief  TO_BE_OVERRIDE!配置“可配置的 弹框统一样式 属性”，用于指定继承YYCPopupView的统一样式
 */
-(void)setupConfigurablePropertiesBeforeLayout;
/**
 *  @brief  TO_BE_OVERRIDE!根据titleInfo 布局标题视图
 */
-(void)layoutTitleViewBeforeShow;
/**
 *  @brief  TO_BE_OVERRIDE!根据contentInfo 布局内容视图
 */
-(void)layoutContentViewBeforeShow;
/**
 *  @brief  TO_BE_OVERRIDE!根据buttonInfoList 布局按钮视图，#注意：无需关注按钮的TargetAction，只管布局#
 *  @return 返回生成的按钮列表
 */
-(NSArray*)layoutButtonViewBeforeShow;

@end
