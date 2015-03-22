//
//  ViewController.m
//  GridButtonAnimation
//
//  Created by rajat mohanty on 23/03/15.
//  Copyright (c) 2015 rajat mohanty. All rights reserved.
//

#import "ViewController.h"

#define WIDTH 70
#define HEIGHT 70
#define PADDING 50
#define NUMBEROFBUTTONSINAROW 3
#define X 25
#define Y 100
#define TOTALBUTTONS 32

@interface ViewController ()

@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,readwrite)int animationCounter;
@property(nonatomic,strong)UIScrollView *scrollview;

@end

@implementation ViewController

@synthesize animationCounter,array,scrollview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    animationCounter=0;
    
    [self createScrollView];
    
    [self createButton];
    
    [self animateButtons];
    
}

-(void)animateButtons
{
    
    if (animationCounter < TOTALBUTTONS) {
        [UIView animateWithDuration:0.5
                         animations:^{
                             ((UIButton *)[array objectAtIndex:animationCounter]).alpha = 1.0;
                         } completion:^(BOOL finished) {
                             animationCounter++;
                             [self animateButtons];
                             
                         }];
    }
}

-(void)createScrollView{
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width, (self.view.frame.size.height*2)+100);
    
}


-(void)createButton{
    
    array = [[NSMutableArray alloc] init];
    
    for(int i=0 ; i<TOTALBUTTONS;i++)
    {
        UIButton *buttonClick = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonClick setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.JPG",i]] forState:UIControlStateNormal];
        [buttonClick setFrame:CGRectMake(X+((WIDTH + PADDING) * (i%NUMBEROFBUTTONSINAROW)), Y + (HEIGHT + PADDING)*(i/NUMBEROFBUTTONSINAROW), WIDTH, HEIGHT)];
        [buttonClick addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        buttonClick.tag=i + 1;
        [buttonClick setAlpha:0.0];
        [array addObject:buttonClick];
        [self.scrollview addSubview:buttonClick];
        
    }
    
    [self.view addSubview:scrollview];
    
}
-(void)buttonTapped:(id)sender
{
    
    NSLog(@"Button Clicked %ld",(long)((UIButton *)sender).tag);
}


@end
