//
//  MumsyHUD.m
//  Mumsy
//
//  Created by Kvana Inc 1 on 06/05/15.
//  Copyright (c) 2015 Kvana. All rights reserved.
//

#import "TurtleLeapsProgressHud.h"

@implementation TurtleLeapsProgressHud{

}

+(void)showHUD:(UIView *)view{

    UIImageView *loadingImage;
    
    loadingImage=[[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, 60 , 60)];
    [view addSubview:loadingImage];
    [loadingImage setContentMode:UIViewContentModeScaleAspectFit];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"loader" withExtension:@"gif"];
    loadingImage.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = loadingImage;
    [HUD.customView setBackgroundColor:[UIColor clearColor]];
    HUD.color=[UIColor clearColor];//UIColorFromRGB(APPCOLOR);
    [HUD.layer setBackgroundColor:[[UIColor clearColor] CGColor]];
    HUD.backgroundColor=[UIColor clearColor];
    
//    UITapGestureRecognizer *tapG=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideHud:)];
//    tapG.numberOfTapsRequired=1;
//    [HUD addGestureRecognizer:tapG];

}
+(void)hideHud:(id)view{
//    if([view isKindOfClass:[UITapGestureRecognizer class]]){
//        [MBProgressHUD hideAllHUDsForView:((UITapGestureRecognizer*)view).view animated:YES];
//
//    }else{
        [MBProgressHUD hideAllHUDsForView:view animated:YES];

//    }
    
//    [HUD hide:YES];
    //    [loadingImage removeFromSuperview];
}


@end
