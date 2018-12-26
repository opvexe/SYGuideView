//
//  SYGuideView.h
//  GUMGuideView
//
//  Created by FaceBook on 2018/12/26.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYGuideView : UIView

@property(nonatomic,strong)NSArray* guideImages;

-(void)didEnterCompletetedBlock:(void(^)(void))completetBlock;

@end

NS_ASSUME_NONNULL_END
