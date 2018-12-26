//
//  SYGuideView.m
//  GUMGuideView
//
//  Created by FaceBook on 2018/12/26.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import "SYGuideView.h"
typedef void(^EnterBlock)(void);
@interface SYGuideView()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    CGSize _size;
}
@property(nonatomic,strong)UIPageControl* pageControl;
@property(nonatomic,copy)EnterBlock enterBlock;
@end
@implementation SYGuideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _size = frame.size;
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        [self addSubview:_scrollView];
        _scrollView.bounces                        = NO;
        _scrollView.delegate                       = self;
        _scrollView.pagingEnabled                  = YES;
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.pageControl];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeCurrentView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)removeCurrentView{
    if (_pageControl.currentPage == _guideImages.count - 1) {
        [self removeFromSuperview];
        if (self.enterBlock) {
            self.enterBlock();
        }
    }
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(_size.width * 0.5, _size.height - 60, 0, 40)];
        _pageControl.currentPageIndicatorTintColor =[UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor purpleColor];
    }
    return _pageControl;
}

-(void)setGuideImages:(NSArray *)guideImages{
    _guideImages = guideImages;
    if (guideImages.count) {
        _pageControl.numberOfPages = guideImages.count;
        _scrollView.contentSize = CGSizeMake(guideImages.count * _size.width, _size.height);
        for (int i = 0; i < guideImages.count; i ++) {
            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * _size.width, 0, _size.width, _size.height)];
            [imageView setImage:[UIImage imageNamed:guideImages[i]]];
            [_scrollView addSubview:imageView];
            if (i == guideImages.count -1) {
                UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
                [iv setTitle:@"立即体验" forState:UIControlStateNormal];
                [iv setTitle:@"立即体验" forState:UIControlStateHighlighted];
                iv.layer.cornerRadius = 10;
                iv.backgroundColor =[UIColor clearColor];
                iv.layer.masksToBounds = YES;
                [imageView addSubview:button];
                iv.frame  = CGRectMake(0.3*SCREEN_WIDTH, 0.845*SCREEN_HEIGHT, 150, 40);
            }
        }
    }
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    _pageControl.currentPage = round(offset.x /[UIScreen mainScreen].bounds.size.width);
}
-(void)didEnterCompletetedBlock:(void (^)(void))completetBlock{
    self.enterBlock  = completetBlock;
}

@end
