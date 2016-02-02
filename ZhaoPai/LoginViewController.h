//
//  LoginViewController.h
//  ZhaoPai
//
//  Created by Mr_Tang on 16/1/18.
//  Copyright © 2016年 Mr_Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
    UIImageView *_iconImageView;//标志图片视图
    UITextField *_accountNameTF;//账户文本框
    UITextField *_passwordTF;//密码文本框
    UIImageView *_lineImageView1;//账户文本下面的线
    UIImageView *_lineImageView2;//密码文本下面的线
    UIButton *_loginButton;//登录按钮
    UIButton *_registerButton;//注册按钮
    UIButton *_findPasswordButton;//找回密码按钮
}
@end
