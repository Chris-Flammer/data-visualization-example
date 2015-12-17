//
//  AnimatedCircleView.m
//  DataVisualization
//
//  Created by Fishington Studios on 12/16/15.
//  Copyright © 2015 Chris Flammer. All rights reserved.
//

#import "AnimatedCircleView.h"

#define kStartAngle -M_PI_2
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)

@interface AnimatedCircleView()

@property (nonatomic, strong) CAShapeLayer *backgroundLayer;
@property (nonatomic, strong) CAShapeLayer *circle;
@property (nonatomic) CGPoint centerPoint;
@property (nonatomic) CGFloat duration;
@property (nonatomic) CGFloat percent;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) BOOL clockwise;
@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic) NSInteger startAngle;
@end

@implementation AnimatedCircleView

#pragma mark - Initialzation Methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}




- (void)drawCircleWithRadius:(CGFloat)radius
                  startAngle:(NSInteger)startAngle
                     percent:(CGFloat)percent
                    duration:(CGFloat)duration
                   lineWidth:(CGFloat)lineWidth
                   clockwise:(BOOL)clockwise
              animatedColors:(NSArray *)colors {
    
    self.duration = duration;
    self.percent = percent;
    self.radius = radius;
    self.startAngle = startAngle;
    self.lineWidth = lineWidth;
    self.clockwise = clockwise;
    self.centerPoint = CGPointMake(self.frame.size.width / 2 - self.radius, self.frame.size.height / 2 - self.radius);
    self.colors = [NSMutableArray new];
    if (colors != nil) {
        for (UIColor *color in colors) {
            [self.colors addObject:(id)color.CGColor];
        }
    } else {
         [self.colors addObject:(id)[UIColor blueColor].CGColor];
    }
    
    self.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(self.startAngle));
    
    [self setupBackgroundLayerWithFillColor:[UIColor clearColor]];
    [self setupCircleLayerWithStrokeColor:[UIColor clearColor]];
    
}




#pragma mark - Appearance setup

- (void)setupBackgroundLayerWithFillColor:(UIColor *)fillColor {
    self.backgroundLayer = [CAShapeLayer layer];
    self.backgroundLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.radius, self.radius) radius:self.radius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(360) clockwise:self.clockwise].CGPath;
    
    // Center the shape in self.view
    self.backgroundLayer.position = self.centerPoint;
    
    // Configure the apperence of the circle
    self.backgroundLayer.fillColor = fillColor.CGColor;
    self.backgroundLayer.strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5].CGColor;
    self.backgroundLayer.lineWidth = self.lineWidth;
    self.backgroundLayer.lineCap = kCALineCapSquare;
    self.backgroundLayer.shouldRasterize = YES;
    
    // Add to parent layer
    [self.layer addSublayer:self.backgroundLayer];
}






- (void)setupCircleLayerWithStrokeColor:(UIColor *)strokeColor {
    // Set up the shape of the circle
    self.circle = [CAShapeLayer layer];
    CGFloat endAngle = [self calculateToValueWithPercent:self.percent];
    
    // Make a circular shape
    self.circle.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.radius, self.radius) radius:self.radius startAngle:kStartAngle endAngle:endAngle clockwise:self.clockwise].CGPath;
    
    // Center the shape in self.view
    self.circle.position = self.centerPoint;
    
    // Configure the apperence of the circle
    self.circle.fillColor = [UIColor clearColor].CGColor;
    self.circle.strokeColor = strokeColor.CGColor;
    self.circle.lineWidth = self.lineWidth;
    self.circle.lineCap = kCALineCapSquare;
    self.circle.shouldRasterize = YES;
    [self.layer addSublayer:self.circle];
}








#pragma mark - Animation



- (void)startAnimation {
    [self drawCircle];
}


- (void)drawCircle {
    
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = self.duration; // "animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // Add the animation to the circle
    [self.circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    
    CAKeyframeAnimation *colorsAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeColor"];
    colorsAnimation.values = self.colors;
    colorsAnimation.calculationMode = kCAAnimationPaced;
    colorsAnimation.removedOnCompletion = NO;
    colorsAnimation.fillMode = kCAFillModeForwards;
    colorsAnimation.duration = self.duration;
    
    [self.circle addAnimation:colorsAnimation forKey:@"strokeColor"];
}


#pragma mark - Helper Methods

- (CGFloat)calculateToValueWithPercent:(CGFloat)percent {
    return (kStartAngle + (percent * 2 * M_PI) / 100);
}



@end


