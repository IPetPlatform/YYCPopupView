//
//  YYCPopupViewFactory.m
//  LearningDemo
//
//  Created by Troyan on 2018/8/4.
//  Copyright © 2018 Troyan. All rights reserved.
//

#import "YYCPopupViewFactory.h"

@implementation YYCPopupViewFactory

+(YYCPopupView*)showView:(Class)popupViewCls
                  inView:(UIView*)superView
               titleInfo:(id)ttlInfo
             contentInfo:(id)cntInfo buttonInfoList:(NSArray*)btnInfoList
        buttonClickBlock:(YYCPopupButtonClickBlock)btnClickBlk propertiesSetupBlock:(YYCPopupPropertiesSetupBlock)propSetupBlk{
    YYCPopupView* popupView = [popupViewCls new];
    if(propSetupBlk)
        propSetupBlk(popupView);
    [popupView setupConfigurablePropertiesBeforeLayout];
    [popupView setupInfoWithTitleInfo:ttlInfo contentInfo:cntInfo buttonInfoList:btnInfoList buttonClickBlock:btnClickBlk];
    [popupView showInView:superView];
    return popupView;
}

+(YYCPopupView*)showView:(Class)popupViewCls inWindowWithTitleInfo:(id)titleInfo
             contentInfo:(id)cntInfo buttonInfoList:(NSArray*)btnInfoList
        buttonClickBlock:(YYCPopupButtonClickBlock)btnClickBlk propertiesSetupBlock:(YYCPopupPropertiesSetupBlock)propSetupBlk{
    return [self showView:popupViewCls inView:[UIApplication sharedApplication].keyWindow titleInfo:titleInfo contentInfo:cntInfo
           buttonInfoList:btnInfoList buttonClickBlock:btnClickBlk propertiesSetupBlock:propSetupBlk];
}

@end
