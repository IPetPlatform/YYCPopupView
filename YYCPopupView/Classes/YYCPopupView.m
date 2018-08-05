//
//  YYCPopupView.m
//  LearningDemo
//
//  Created by Troyan on 2018/8/4.
//  Copyright © 2018 Troyan. All rights reserved.
//

#import "YYCPopupView.h"

@interface YYCPopupView()

@property(strong, nonatomic) NSArray* buttonList;
@property(strong, nonatomic) MASConstraint* centerMainFrame;
@property(strong, nonatomic) MASConstraint* leftMainFrame;
@property(strong, nonatomic) UITapGestureRecognizer* tapGestureBackground;

@end

@implementation YYCPopupView

@synthesize themeColor =_themeColor;
@synthesize backgroundColor =_backgroundColor;

#pragma mark - interface methods
-(instancetype)init{
    return [self initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _autoCloseOnClickButton = YES;
        _useDefaultButtonList = NO;
        _animationStyle = YYCPopupViewAnimationStyleEmerge;
        
        [self doMainLayout];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){ @throw YYCPopupViewExeptionInvalidInitializer; }
    return self;;
}

-(void)showInView:(UIView *)inView{
    _tapGestureBackground = [UITapGestureRecognizer new];
    [_tapGestureBackground addTarget:self action:@selector(close)];
    [backgroudView addGestureRecognizer:_tapGestureBackground];
    switch (_animationStyle){
        case YYCPopupViewAnimationStyleNone:{
            [inView addSubview:self];
            [self mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(inView); }];
        }break;
        case YYCPopupViewAnimationStyleEmerge:{
            self.alpha = 0.0;
            [inView addSubview:self];
            [self mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(inView); }];
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 1.0;
            } completion:nil];
        }break;
        case YYCPopupViewAnimationStyleSlideUp:{
            self.alpha = 0.0;
            backgroudView.alpha = 0.0;
            
            [inView addSubview:self];
            [self mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(inView); }];
            [_leftMainFrame uninstall];
            [mainFrameView mas_makeConstraints:^(MASConstraintMaker *make) { make.left.equalTo(self); }];
            [self layoutIfNeeded];
            
            CGFloat heightInView = CGRectGetHeight(inView.bounds);
            CGFloat heightMainFrame = CGRectGetHeight(mainFrameView.frame);
            CGFloat midXMainFrame = CGRectGetMidX(mainFrameView.frame);
            mainFrameView.center = CGPointMake(midXMainFrame, heightInView + heightMainFrame*0.5);
            self.alpha = 1.0;
            
            [UIView animateWithDuration:heightMainFrame/500.0 animations:^{
                self->mainFrameView.center = CGPointMake(midXMainFrame, heightInView - heightMainFrame*0.5);
                self->backgroudView.alpha = 1.0;
            } completion:nil];
        }break;
        default:
            break;
    }
}

-(void)close{
    switch (_animationStyle){
        case YYCPopupViewAnimationStyleNone:{
            [self removeGestureRecognizer:_tapGestureBackground];
            [self removeFromSuperview];
        }break;
        case YYCPopupViewAnimationStyleEmerge:{
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self removeGestureRecognizer:self->_tapGestureBackground];
                [self removeFromSuperview];
            }];
        }break;
        case YYCPopupViewAnimationStyleSlideUp:{
            [self layoutIfNeeded];
            CGFloat heightInView = CGRectGetHeight(self.superview.bounds);
            CGFloat heightMainFrame = CGRectGetHeight(mainFrameView.frame);
            CGFloat midXMainFrame = CGRectGetMidX(mainFrameView.frame);
            
            [UIView animateWithDuration:heightMainFrame/500.0 animations:^{
                self->mainFrameView.center = CGPointMake(midXMainFrame, heightInView + heightMainFrame*0.5);
                self->backgroudView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self removeGestureRecognizer:self->_tapGestureBackground];
                [self removeFromSuperview];
            }];
        }break;
        default:
            break;
    }
}

-(UIColor *)themeColor{
    if(!_themeColor)
        _themeColor = YYCPopupViewDefaultThemeColor;
    return _themeColor;
}

-(void)setThemeColor:(UIColor *)themeColor{
    _themeColor = themeColor;
    mainFrameView.backgroundColor = self.themeColor;
    for(UIButton* btn in _buttonList)
        [btn setTitleColor:self.themeColor forState:UIControlStateNormal];
}

-(UIColor *)backgroundColor{
    if(!_backgroundColor)
        _backgroundColor = YYCPopupViewDefaultBackgroundColor;
    return _backgroundColor;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor{
    _backgroundColor = backgroundColor;
    backgroudView.backgroundColor = backgroundColor;
}

-(void)setupInfoWithTitleInfo:(id)ttlInfo contentInfo:(id)cntInfo buttonInfoList:(NSArray *)btnInfoList
             buttonClickBlock:(YYCPopupButtonClickBlock)btnClickBlk{
    titleInfo = ttlInfo;
    contentInfo = cntInfo;
    buttonInfoList = btnInfoList;
    buttonClickBlock = btnClickBlk;
    
    [self layoutTitleViewBeforeShow];
    [self layoutContentViewBeforeShow];
    _buttonList = [self actualLayoutButtonViewBeforeShow];
    [self setupButtonClickHandleBeforeShowWithButtonList:_buttonList];
}

#pragma mark - private methods
-(void)doMainLayout{
    UIView* bgView = [UIView new];
    [self addSubview:bgView];
    backgroudView = bgView;
    backgroudView.backgroundColor = self.backgroundColor;
    [backgroudView mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(self); }];
    
    UIView* mainView = [UIView new];
    [self addSubview:mainView];
    mainFrameView = mainView;
    mainFrameView.backgroundColor = self.themeColor;
    mainFrameView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    mainFrameView.layer.shadowRadius = 5.f;
    mainFrameView.layer.shadowOffset = CGSizeMake(0.f, 0.f);
    mainFrameView.layer.shadowOpacity = 1.f;
    [mainFrameView mas_makeConstraints:^(MASConstraintMaker *make) {
        self->_centerMainFrame = make.center.equalTo(self);
        self->_leftMainFrame = make.left.equalTo(@(24.0));
        make.top.greaterThanOrEqualTo(self).with.offset(32.0);
    }];
    
    UIView* ttlView = [UIView new];
    [mainFrameView addSubview:ttlView];
    titleView = ttlView;
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->mainFrameView);
        make.left.equalTo(self->mainFrameView);
        make.right.equalTo(self->mainFrameView);
        make.height.greaterThanOrEqualTo(@(44.0));
    }];
    
    UIView* cntView = [UIView new];
    cntView.backgroundColor = [UIColor whiteColor];
    [mainFrameView addSubview:cntView];
    contentView = cntView;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->titleView.mas_bottom);
        make.left.equalTo(self->mainFrameView);
        make.right.equalTo(self->mainFrameView);
        make.height.greaterThanOrEqualTo(@(100.0));
    }];
    
    UIView* btnView = [UIView new];
    [mainFrameView addSubview:btnView];
    buttonView = btnView;
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->contentView.mas_bottom).with.offset(1.0);
        make.left.equalTo(self->mainFrameView);
        make.right.equalTo(self->mainFrameView);
        make.bottom.equalTo(self->mainFrameView);
    }];
}

-(NSArray*)actualLayoutButtonViewBeforeShow{
    if(_useDefaultButtonList){
        buttonInfoList = @[@"取消",@"确定"];
        NSUInteger count = buttonInfoList.count;
        NSMutableArray* btnList = [@[] mutableCopy];
        UIButton* lastButton;
        for(int i = 0; i<count; i++){
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor whiteColor];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
            [btn setTitle:buttonInfoList[i] forState:UIControlStateNormal];
            [btn setTitleColor:self.themeColor forState:UIControlStateNormal];
            [buttonView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if(i){
                    make.width.equalTo(lastButton);
                    make.left.mas_equalTo(lastButton.mas_right).with.offset(1.0);
                }else{
                    make.left.equalTo(self->buttonView);
                }
                if(i == count-1)
                    make.right.equalTo(self->buttonView);
                make.top.equalTo(self->buttonView);
                make.bottom.equalTo(self->buttonView);
                make.height.equalTo(@40.0);
            }];
            lastButton = btn;
            [btnList addObject:btn];
        }
        return btnList;
    }else
        return [self layoutButtonViewBeforeShow];
}

-(void)setupButtonClickHandleBeforeShowWithButtonList:(NSArray*)btnList{
    for(UIButton* btn in btnList)
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btnClick:(UIButton*)sender{
    if(buttonClickBlock)
        buttonClickBlock(self, [_buttonList indexOfObject:sender], nil);
    if(_autoCloseOnClickButton)
        [self close];
}

#pragma mark - methods to be override
-(void)setupConfigurablePropertiesBeforeLayout{ }
-(void)layoutTitleViewBeforeShow{ }
-(void)layoutContentViewBeforeShow{ }
-(NSArray*)layoutButtonViewBeforeShow{ return nil; }

@end
