//
//  ChannelViewController.h
//  YoukuTudou
//
//  Created by ips on 15/2/27.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassChannelValue.h"

@interface ChannelViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray *arrayList;
    
}


@property (retain) NSString *_channel;
@property (assign,nonatomic) id<PassChannelValue> delegate;


@end
