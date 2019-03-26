//
//  ViewController.m
//  QGBingModelTool
//
//  Created by 李超群 on 2019/3/25.
//  Copyright © 2019 李超群. All rights reserved.
//

#import "ViewController.h"
#import "QIEBindModelViewTool.h"

@interface ViewController ()<QIERefreshUIProtocol>
/** <#注释#> */
@property (nonatomic, weak) UILabel *label;
@end

@implementation ViewController

-(void)injected{
    NSLog(@"sss");
    self.label.text = @"chaoqun";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(90, 90, 90, 90)];
    [self.view addSubview:label];
    label.textColor = [UIColor redColor];
    self.label = label;
    
    DYRoomModel *r = [[DYRoomModel alloc]init];
    r.title = @"哈哈哈";
    [QIEBindModelViewTool bindModelViewTool].roomModel = r;
}

-(void)refreshUI:(DYRoomModel *)viewModel{
    self.label.text = viewModel.title;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [QIEBindModelViewTool destoryTool];

}


@end
