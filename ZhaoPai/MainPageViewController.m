//
//  MainPageViewController.m
//  ZhaoPai
//
//  Created by Mr_Tang on 16/1/18.
//  Copyright © 2016年 Mr_Tang. All rights reserved.
//

#import "MainPageViewController.h"
#import "ZhaoPai-swift.h"
#import "MainPageCell.h"

@interface MainPageViewController ()

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    [self creatSubView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getResultView:) name:@"CMDI.SCAN_RESULT.GET" object:nil];

    
    
}

//创建子视图
- (void)creatSubView{


    //1.设置导航栏的搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 143*2, 64)];
    searchBar.barStyle = UIBarStyleBlackTranslucent;
    [searchBar setBackgroundImage:[UIImage imageNamed:@"体验_u30_selected.png"]];
    [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"体验_u30_selected.png"] forState:UIControlStateNormal];
    [searchBar setImage:[UIImage imageNamed:@"u10searchBar.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    searchBar.keyboardType = UIKeyboardTypeDefault;
    self.navigationItem.titleView = searchBar;
    
    //2.创建一个扫描按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
//    [button setTitle:@"扫一扫" forState:UIControlStateNormal];/BarCode_Demo.plist
    [button setBackgroundImage:[UIImage imageNamed:@"saoma.png"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [button addTarget:self action:@selector(scanCodeNuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    //3.创建表shi图
    _mainPageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-40) style:UITableViewStylePlain];
    _mainPageTableView.dataSource = self;
    _mainPageTableView.delegate = self;
    _mainPageTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mainPageTableView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"cellId";
    MainPageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MainPageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //计算单元格高度
    CGFloat cellHeight = 10+30+20+20+10;
    return cellHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    [self testData];
    DropdownMenu *dropdown = [[DropdownMenu alloc] initDropdownWithButtonTitles:_titleArray andLeftListArray:_leftArray andRightListArray:_rightArray];
    dropdown.delegate = self;   //此句的代理方法可返回选中下标值


    return dropdown.view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
}

//测试数据
- (void)testData {
    [self testTitleArray];
    [self testLeftArray];
    [self testRightArray];
}

//每个下拉的标题
- (void) testTitleArray {
    _titleArray = @[@"全部分类",@"智能排序"];
}

//左边列表可为空，则为单下拉菜单，可以根据需要传参
- (void)testLeftArray {
    NSArray *One_leftArray = @[@"全部分类", @"体验", @"搜罗", @"监察", @"调研"];
    //    NSArray *Two_leftArray = @[@"dfa",@"fagag"];
    NSArray *Two_leftArray = [[NSArray alloc] init];
    //    NSArray *R_leftArray = @[@"Test1", @"Test2"];
   
    _leftArray = [[NSArray alloc] initWithObjects:One_leftArray, Two_leftArray, nil];
}

//右边列表不可为空
- (void)testRightArray {
    NSArray *F_rightArray = @[
                              @[
                                  @{@"title":@""},
                                  ] ,
                              @[
                                  @{@"title":@"全部"},
                                  @{@"title":@"到店体验"},
                                  @{@"title":@"活动参与"},
                                  @{@"title":@"产品试用"},
                                  @{@"title":@"金融产品"},
                                  @{@"title":@"游戏体验"},
                                  @{@"title":@"热门抢购"},
                                  @{@"title":@"购物返现"},
                                  @{@"title":@"众包销售"},
                                  @{@"title":@"线上互动"},
                                  @{@"title":@"试驾体验"},
                                  @{@"title":@"注册体验"},
                                  @{@"title":@"应用体验"},
                                  ],
                              @[
                                  @{@"title":@"全部"},
                                  @{@"title":@"信息收集"},
                                  @{@"title":@"门牌搜集"},
                                  ],
                              @[
                                  @{@"title":@"全部"},
                                  @{@"title":@"门店检查"},
                                  @{@"title":@"户外检查"},
                                  ],
                              @[
                                  @{@"title":@"全部"},
                                  @{@"title":@"数据调研"},
                                  ]
                              ];
    
    NSArray *S_rightArray = @[
                              @[
                                  @{@"title":@"one"},
                                  @{@"title":@"two"},
                                  @{@"title":@"three"}
                                  ] ,
                              @[
                                  @{@"title":@"four"}
                                  ],
                              @[
                                  @{@"title":@"全部"},
                                  @{@"title":@"信息收集"},
                                  @{@"title":@"门牌搜集"},
                                  ],

                              ];
    
    _rightArray = [[NSArray alloc] initWithObjects:F_rightArray, S_rightArray, nil];
}

//实现代理，返回选中的下标，若左边没有列表，则返回0
- (void)dropdownSelectedLeftIndex:(NSString *)left RightIndex:(NSString *)right; {
    NSLog(@"%s : You choice %@ and %@", __FUNCTION__, left, right);
}



#pragma mark - 扫码按钮
- (void)scanCodeNuttonAction:(UIButton *)button{

    
    //点击扫码
    CaptureBoard *captureBardCtrl = [CaptureBoard shareInstance];
    [captureBardCtrl viewDidAppear:YES];
    [self.navigationController pushViewController:captureBardCtrl animated:YES];
    [captureBardCtrl setUseNotification:YES AndNoResultView:NO];
    

}

#pragma mark - 接收到通知调用的方法
- (void)getResultView:(NSNotification *)notif{

    _codeString = notif.object;
    ResultBoard *resultBoard = [ResultBoard shareInstance];
    //确定文件路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dataBasePath = [path stringByAppendingString:@"/BarCode_Demo.plist"];
    NSLog(@"%@",dataBasePath);
    //确定当前时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *scanBarCodeTimeString = [formatter stringFromDate:date];
    //确定当前设备
    NSString *UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    //将时间，设备号和扫描结果存入字典
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:scanBarCodeTimeString,UUID,_codeString, nil] forKeys:[NSArray arrayWithObjects:@"time",@"UUID",@"codeString",nil]];
    [dic writeToFile:dataBasePath atomically:YES];

    //判断扫描的结果是商品码还是URL地址http://webapi.chinatrace.org/api/getProductData?productCode=6901236341582
    NSRange rang1 = [_codeString rangeOfString:@"^[0-9]+$" options:NSRegularExpressionSearch];
    NSRange rang2 = [_codeString rangeOfString:@"(?<=[0-9a-z])://(?=[0-9a-z])" options:NSRegularExpressionSearch | NSCaseInsensitiveSearch];
    
    
    if (rang1.location != NSNotFound) {
        //商品码
        NSString *actURLString = [NSString stringWithFormat:@"http://webapi.chinatrace.org/api/getProductData?productCode=%@",_codeString];
        NSURL *actURL = [NSURL URLWithString:actURLString];
        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:actURL];
        [urlRequest setHTTPMethod:@"GET"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.allowsCellularAccess = NO;
        NSURLSession *taskPr = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        NSURLSessionDataTask *dataTask = [taskPr dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                //将获得的数据转换成json字符串
                NSString *getResultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"string:%@",getResultString);
                //将获得的数据写入字典
                [dic setObject:getResultString forKey:@"getResultString"];
                //将字典写入文件
                [dic writeToFile:dataBasePath atomically:YES];
                //上传文件
                NSString *urlString = [NSString stringWithFormat:@"http://webapi.cmdi-info.com/Help/Api/api/File?path=%@",dataBasePath];
                //配置参数
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                
                [params setObject:dataBasePath forKey:@"name"];
          /*      AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                    //把要上传的文件转成NSData
                    NSData *fileData = [NSData dataWithContentsOfFile:dataBasePath];
                    [formData appendPartWithFormData:fileData name:@"name"];

                } success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSLog(@"完成：%@",result);

                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"错误：%@",error.localizedDescription);
                }];*/
            }else{
                NSLog(@"error:%@",error);
            }
            
        }];
        [dataTask resume];

        
    }else if(rang2.location !=NSNotFound){
        //URL地址
        NSURL *actURL = [NSURL URLWithString:_codeString];
        if ([[UIApplication sharedApplication] canOpenURL:actURL]) {
            [[UIApplication sharedApplication] openURL:actURL];
        }
        if ([_codeString hasSuffix:@"/BarCode_Demo.plist"]) {
            [resultBoard exitApplication];
        }
    }
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
