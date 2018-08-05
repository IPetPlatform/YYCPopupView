//
//  YYCPopupViewFactory.h
//  LearningDemo
//
//  Created by Troyan on 2018/8/4.
//  Copyright © 2018 Troyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYCPopupView.h"

/**
 *  @brief  YYCPopupView的底部按钮点击事件的回调Block，参数popupView是弹框视图，btnIndex是按钮索引，info在回调需要传递数据时使用
 */
typedef void(^YYCPopupPropertiesSetupBlock)(YYCPopupView* popupView);

@interface YYCPopupViewFactory : NSObject

/**
 *  @brief  在指定视图中弹出YYCPopupView
 *  @param  popupViewCls    需要弹出YYCPopupView的类型
 *  @param  superView   需要弹出YYCPopupView的视图
 *  @param  ttlInfo     标题视图数据
 *  @param  cntInfo     内容视图数据
 *  @param  btnInfoList     底部按钮数据
 *  @param  btnClickBlk     按钮点击事件回调
 *  @param  propSetupBlk    用于进一步设置弹窗的可配置属性
 */
+(YYCPopupView*)showView:(Class)popupViewCls
                  inView:(UIView*)superView
               titleInfo:(id)ttlInfo
             contentInfo:(id)cntInfo
          buttonInfoList:(NSArray*)btnInfoList
        buttonClickBlock:(YYCPopupButtonClickBlock)btnClickBlk
    propertiesSetupBlock:(YYCPopupPropertiesSetupBlock)propSetupBlk;

/**
 *  @brief  在KeyWindow中弹出YYCPopupView
 *  @param  popupViewCls    需要弹出YYCPopupView的类型
 *  @param  ttlInfo     标题视图数据
 *  @param  cntInfo     内容视图数据
 *  @param  btnInfoList   底部按钮数据
 *  @param  btnClickBlk   按钮点击事件回调
 *  @param  propSetupBlk    用于进一步设置弹窗的可配置属性
 */
+(YYCPopupView*)showView:(Class)popupViewCls
   inWindowWithTitleInfo:(id)ttlInfo
             contentInfo:(id)cntInfo
          buttonInfoList:(NSArray*)btnInfoList
        buttonClickBlock:(YYCPopupButtonClickBlock)btnClickBlk
    propertiesSetupBlock:(YYCPopupPropertiesSetupBlock)propSetupBlk;

@end
