//
//  JHInputPayPWDView.m
//  JHKit
//
//  Created by HaoCold on 2018/4/19.
//  Copyright © 2018年 HaoCold. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2018 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "JHInputPayPWDView.h"
#import "JHVerificationCodeView.h"

#define kJHInputPayPWDView_UIColorFromHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kScreenW    [[UIScreen mainScreen] bounds].size.width
#define kScreenH    [[UIScreen mainScreen] bounds].size.height
#define kScaleW(w)  (w)*(kScreenW/375.0)
#define kScaleH(h)  (h)*(kScreenH/667.0)

@interface JHInputPayPWDView()

@property (nonatomic,  strong) UIView *grayView;
@property (nonatomic,  strong) UIView *whiteView;
@property (nonatomic,  strong) UILabel *titleLabel;
@property (nonatomic,  strong) UIView *line1;
@property (nonatomic,  strong) UILabel *subTitleLabel;
@property (nonatomic,  strong) UILabel *moneyLabel;
@property (nonatomic,  strong) UIView *line2;
@property (nonatomic,  strong) JHVerificationCodeView *codeView;

@end


@implementation JHInputPayPWDView

- (instancetype)initWithFrame:(CGRect)frame
{
    frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame];
    if (self) {
        [self jh_setupViews];
    }
    return self;
}

- (void)jh_setupViews
{
    [self addSubview:self.grayView];
    [self addSubview:self.whiteView];
    [_whiteView addSubview:self.titleLabel];
    [_whiteView addSubview:self.line1];
    [_whiteView addSubview:self.subTitleLabel];
    [_whiteView addSubview:self.moneyLabel];
    [_whiteView addSubview:self.line2];
    [_whiteView addSubview:self.codeView];
}

- (void)setMoney:(CGFloat)money{
    if (money < 0) {
        _money = money;
        _moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",money];
    }
}

- (void)showInView:(UIView *)view{
    [view addSubview:self];
}

- (void)remove{
    if (_removeWhenTouchOutside) {
        [self removeFromSuperview];
    }
}

#pragma mark - lazy
- (UIView *)grayView{
    if (!_grayView) {
        UIView *view = [[UIView alloc] init];
        view.frame = self.bounds;
        view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        [view addSubview:({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = view.bounds;
            [button addTarget:self action:@selector(remove) forControlEvents:1<<6];
            button;
        })];
        
        _grayView = view;
    }
    return _grayView;
}

- (UIView *)whiteView{
    if (!_whiteView) {
        UIView *view = [[UIView alloc] init];
        view.layer.cornerRadius = 4;
        view.frame = CGRectMake(0, 0, kScaleW(290), kScaleH(189));
        view.center = self.center;
        view.backgroundColor = [UIColor whiteColor];
        _whiteView = view;
    }
    return _whiteView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, CGRectGetWidth(_whiteView.frame), kScaleH(44));
        label.text = @"请输入支付密码";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIView *)line1{
    if (!_line1) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_whiteView.frame), 0.5);
        view.backgroundColor = kJHInputPayPWDView_UIColorFromHexRGB(0xe5e5e5);
        [_whiteView addSubview:view];
        _line1 = view;
    }
    return _line1;
}

- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame) + kScaleH(18), CGRectGetWidth(_whiteView.frame), kScaleH(22));
        label.text = @"支出";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel = label;
    }
    return _subTitleLabel;
}

- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, CGRectGetMaxY(_subTitleLabel.frame), CGRectGetWidth(_whiteView.frame), kScaleH(30));
        label.text = @"￥0";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:24];
        label.textAlignment = NSTextAlignmentCenter;
        _moneyLabel = label;
    }
    return _moneyLabel;
}

- (UIView *)line2{
    if (!_line2) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, CGRectGetHeight(_whiteView.frame)-kScaleH(65), CGRectGetWidth(_whiteView.frame), 0.5);
        view.backgroundColor = kJHInputPayPWDView_UIColorFromHexRGB(0xe5e5e5);
        [_whiteView addSubview:view];
        _line2 = view;
    }
    return _line2;
}

- (JHVerificationCodeView *)codeView{
    if (!_codeView) {
        JHVCConfig *config = [[JHVCConfig alloc] init];
        config.inputBoxNumber = 6;
        config.inputBoxSpacing = -0.5;
        config.inputBoxWidth = kScaleH(44);
        config.inputBoxHeight = kScaleH(44);
        config.secureTextEntry = YES;
        
        CGRect frame = CGRectMake(0, CGRectGetMaxY(_line2.frame), CGRectGetWidth(_whiteView.frame), kScaleH(65));
        _codeView = [[JHVerificationCodeView alloc] initWithFrame:frame
                                                           config:config];
        __weak typeof(self) weakself = self;
        _codeView.finishBlock = ^(NSString *code) {
            if (weakself.finishEnterBlock) {
                weakself.finishEnterBlock(code);
                [weakself removeFromSuperview];
            }
        };
    }
    return _codeView;
}

@end
