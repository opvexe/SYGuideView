//
//  SYGuideViewController.m
//  GUMGuideView
//
//  Created by FaceBook on 2018/12/26.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import "SYGuideViewController.h"
#import "SYGuideView.h"
@interface SYGuideViewController ()
@property(nonatomic,strong)SYGuideView *guideView;
@end

@implementation SYGuideViewController

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _guideView = ({
        SYGuideView *iv = [[SYGuideView alloc]initWithFrame:self.view.bounds];
        iv.guideImages = @[@"guideimage1",@"guideimage2",@"guideimage3",@"guideimage4"];
        [self.view addSubview:iv];
        iv;
    });
    
    [self.guideView didEnterCompletetedBlock:^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window setRootViewController:[[UINavigationController alloc] initWithRootViewController: [[SYLoginViewController alloc] init]]];
    }];
}

@end
