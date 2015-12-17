//
//  AnimatedCircleView.h
//  DataVisualization
//
//  Created by Fishington Studios on 12/16/15.
//  Copyright © 2015 Chris Flammer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimatedCircleView : UIView

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) CAMediaTimingFunction *timingFunction;

- (void)drawCircleWithRadius:(CGFloat)radius
                  startAngle:(NSInteger)startAngle
                     percent:(CGFloat)percent
                    duration:(CGFloat)duration
                   lineWidth:(CGFloat)lineWidth
                   clockwise:(BOOL)clockwise
              animatedColors:(NSArray *)colors;

// Start draw animation
- (void)startAnimation;

@end
