//
//  YYCPopupAlertView.m
//  LearningDemo
//
//  Created by Troyan on 2018/8/5.
//  Copyright © 2018 Troyan. All rights reserved.
//

#import "YYCPopupAlertView.h"

@interface YYCPopupAlertView()

@property(weak, nonatomic) UIImageView* imageViewTitleLogo;
@property(weak, nonatomic) UILabel* labelTitle;
@property(weak, nonatomic) UILabel* labelContent;

@end

@implementation YYCPopupAlertView

-(void)setupConfigurablePropertiesBeforeLayout{
    [self setThemeColor:[UIColor colorWithRed:250.0/255.0 green:154.0/255.0 blue:79.0/255.0 alpha:1.0]];
    [self setBackgroundColor:[UIColor colorWithRed:13.0/255.0 green:79.0/255.0 blue:139.0/255.0 alpha:0.6]];
    
    [self setUseDefaultButtonList:YES];
}
-(void)layoutTitleViewBeforeShow{
    UIImageView* imgvTitle = [UIImageView new];
    imgvTitle.image = [UIImage imageNamed:@"yyc_alert"];
    [titleView addSubview:imgvTitle];
    _imageViewTitleLogo = imgvTitle;
    [_imageViewTitleLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28.0, 28.0));
        make.left.equalTo(self->titleView).with.offset(10.0);
        make.centerY.equalTo(self->titleView);
    }];
    
    UILabel* lblTitle = [UILabel new];
    lblTitle.text = titleInfo;
    lblTitle.font = [UIFont systemFontOfSize:16.0];
    lblTitle.textColor = [UIColor colorWithWhite:0.0 alpha:1.0];
    lblTitle.numberOfLines = 1;
    [titleView addSubview:lblTitle];
    _labelTitle = lblTitle;
    [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_imageViewTitleLogo).with.offset(6.0);
        make.right.equalTo(self->titleView).with.offset(6.0);
        make.centerY.equalTo(self->titleView);
    }];
}
-(void)layoutContentViewBeforeShow{
    UILabel* lblContent = [UILabel new];
    lblContent.text = contentInfo;
    lblContent.font = [UIFont systemFontOfSize:14.0];
    lblContent.textColor = [UIColor colorWithWhite:3.0 alpha:1.0];
    lblContent.numberOfLines = 0;
    [titleView addSubview:lblContent];
    _labelContent = lblContent;
    [_labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(24.0, 28.0, -24.0, -28.0));
    }];
}
-(NSArray*)layoutButtonViewBeforeShow{
    NSUInteger count = buttonInfoList.count;
    NSMutableArray* btnList = [@[] mutableCopy];
    UIButton* lastButton;
    for(int i = 0; i<count; i++){
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [btn.titleLabel setTextColor:self.themeColor];
        [btn setTitle:[buttonInfoList[i] objectForKey:@""] forState:UIControlStateNormal];
        [buttonView addSubview:btn];
        if(i == 0)
            [btn mas_makeConstraints:^(MASConstraintMaker *make) { make.left.equalTo(self->buttonView); }];
        else if(i == count-1)
            [btn mas_makeConstraints:^(MASConstraintMaker *make) { make.right.equalTo(self->buttonView); }];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastButton).with.offset(1.0);
            make.width.equalTo(lastButton);
        }];
        lastButton = btn;
        [btnList addObject:btn];
    }
    return btnList;
}

@end
