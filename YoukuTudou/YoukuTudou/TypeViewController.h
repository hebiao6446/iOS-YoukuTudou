//
//  TypeViewController.h
//  YoukuTudou
//
//  Created by ips on 15/2/27.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassTypeValue.h"

@interface TypeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray *arrayList;
    
}


@property (retain) NSString *_sort;

@property (assign,nonatomic) id<PassTypeValue> delegate;

@end
