//
//  JHInputPayPWDView.h
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

#import <UIKit/UIKit.h>

@class JHVerificationCodeView;

@interface JHInputPayPWDView : UIView

@property (nonatomic,  strong,  readonly) UIView *grayView;
@property (nonatomic,  strong,  readonly) UIView *whiteView;
@property (nonatomic,  strong,  readonly) UILabel *titleLabel;
@property (nonatomic,  strong,  readonly) UIView *line1;
@property (nonatomic,  strong,  readonly) UILabel *subTitleLabel;
@property (nonatomic,  strong,  readonly) UILabel *moneyLabel;
@property (nonatomic,  strong,  readonly) UIView *line2;
@property (nonatomic,  strong,  readonly) JHVerificationCodeView *codeView;


@property (nonatomic,  assign) CGFloat  money;
/// Default is 'NO'.
@property (nonatomic,  assign) BOOL  removeWhenTouchOutside;
@property (nonatomic,    copy) void(^finishEnterBlock)(NSString *key);

- (void)showInView:(UIView *)view;

@end
