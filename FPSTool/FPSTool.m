//
//  FPSTool.m
//  FPSTool
//
//  Created by pnc20171013 on 2018/12/26.
//  Copyright © 2018年 farmerly.Inc. All rights reserved.
//

#import "FPSTool.h"

#define FPSTool_screenW  [UIScreen mainScreen].bounds.size.width
#define FPSTool_screenH  [UIScreen mainScreen].bounds.size.height

@implementation FPSTool
{
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
}
static FPSTool *_sharedFPSTool = nil;
+ (instancetype)sharedInstall {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFPSTool = [[self alloc] initWithFrame:CGRectMake(0, 100, 80, 30)];
    });
    return _sharedFPSTool;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePostion:)];
        [self addGestureRecognizer:pan];
        
        __weak typeof(self) weakSelf = self;
        _link = [CADisplayLink displayLinkWithTarget:weakSelf selector:@selector(tick:)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
  
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float FPSTool = _count / delta;
    _count = 0;
    
    CGFloat progress = FPSTool / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPSTool",(int)round(FPSTool)]];
    
    [attText addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attText.length - 3)];
    [attText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(attText.length - 3, 3)];
    
    [attText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0] range:NSMakeRange(0, attText.length - 3)];
    [attText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(attText.length - 3, 3)];
    
    [self setAttributedTitle:attText forState:UIControlStateNormal];
}

- (void)changePostion:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self];
    
    CGRect originalFrame = self.frame;
    
    originalFrame = [self changeXWithFrame:originalFrame point:point];
    originalFrame = [self changeYWithFrame:originalFrame point:point];
    
    self.frame = originalFrame;
    
    [pan setTranslation:CGPointZero inView:self];
    
    UIButton *button = (UIButton *)pan.view;
    if (pan.state == UIGestureRecognizerStateBegan) {
        button.enabled = NO;
    }else if (pan.state == UIGestureRecognizerStateChanged){
    } else {
        
        CGRect frame = self.frame;
        
        if (self.center.x <= FPSTool_screenW / 2.0){
            frame.origin.x = 0;
        }else
        {
            frame.origin.x = FPSTool_screenW - frame.size.width;
        }
        
        if (frame.origin.y < 20) {
            frame.origin.y = 20;
        } else if (frame.origin.y + frame.size.height > FPSTool_screenH) {
            frame.origin.y = FPSTool_screenH - frame.size.height;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = frame;
        }];
        
        button.enabled = YES;
        
    }
}

- (CGRect)changeXWithFrame:(CGRect)originalFrame point:(CGPoint)point{
    BOOL q1 = originalFrame.origin.x >= 0;
    BOOL q2 = originalFrame.origin.x + originalFrame.size.width <= FPSTool_screenW;
    
    if (q1 && q2) {
        originalFrame.origin.x += point.x;
    }
    return originalFrame;
}

- (CGRect)changeYWithFrame:(CGRect)originalFrame point:(CGPoint)point{
    
    BOOL q1 = originalFrame.origin.y >= 20;
    BOOL q2 = originalFrame.origin.y + originalFrame.size.height <= FPSTool_screenH;
    if (q1 && q2) {
        originalFrame.origin.y += point.y;
    }
    return originalFrame;
}


@end
