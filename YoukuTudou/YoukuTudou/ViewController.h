//
//  ViewController.h
//  YoukuTudou
//
//  Created by ips on 15/2/27.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassChannelValue.h"
#import "PassTypeValue.h"
#import "EGORefreshTableHeaderView.h"


@interface ViewController : UIViewController<PassTypeValue,PassChannelValue,UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>{
    
    NSMutableString  *channelId;
    NSMutableString *sort;
    
    
    NSMutableArray *arrayList;
    
    
    UITableView *table;
    
    int pageNo;
    
    
    
  
    
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    BOOL _reloading;
    
    BOOL _loading;
    
    
    
    int  pingStartId;
    
    
    NSMutableString *mddddd;
    
    
}

@property (retain) UITableViewCell *nextCell;

@end

