//
//  ViewController.m
//  DataVisualization
//
//  Created by Fishington Studios on 12/16/15.
//  Copyright © 2015 Chris Flammer. All rights reserved.
//

#import "ViewController.h"
#import "AnimatedCircleView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet AnimatedCircleView *carCircle;
@property (weak, nonatomic) IBOutlet AnimatedCircleView *homeCircle;
@property (weak, nonatomic) IBOutlet AnimatedCircleView *travelCircle;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.carCircle drawCircleWithRadius:200
                              startAngle:0
                                 percent:75
                                duration:1
                               lineWidth:40
                               clockwise:YES
                          animatedColors:@[[UIColor colorWithRed:0.42 green:0.74 blue:0.25 alpha:1],
                                           ]];
    
    [self.homeCircle drawCircleWithRadius:125
                               startAngle:180
                                  percent:40
                                 duration:1
                                lineWidth:30
                                clockwise:NO
                           animatedColors:@[[UIColor colorWithRed:0.11 green:0.52 blue:0.23 alpha:1],
                                            ]];
    
    
    
    [self.travelCircle drawCircleWithRadius:65
                                 startAngle:90
                                    percent:50
                                   duration:1
                                  lineWidth:20
                                  clockwise:YES
                             animatedColors:@[[UIColor colorWithRed:0.71 green:0.87 blue:0.62 alpha:1],
                                              ]];
    
    
    [self animateData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







-(void)animateData {
    [self.carCircle performSelector:@selector(startAnimation) withObject:nil afterDelay:0];
    [self.homeCircle performSelector:@selector(startAnimation) withObject:nil afterDelay:.5];
    [self.travelCircle performSelector:@selector(startAnimation) withObject:nil afterDelay:1.0];
}





@end
