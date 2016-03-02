//
//  GoogleIconsViewController.m
//  YoukuTudou
//
//  Created by ips on 15/3/4.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "GoogleIconsViewController.h"


 





#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)




@implementation GoogleIconsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    arrayList=[[NSMutableArray alloc] init];
    
    for (int i=0xe600; i<=0xec7c; i++) {
        
        
        
//        [arrayList addObject:str];
        
    }
    
 
    
    
    UITableView *table=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    table.frame=CGRectMake(0, 0,320, 416+(isIPhone5?88:0));
    table.delegate=self;
    table.dataSource=self;
    table.backgroundColor=[UIColor whiteColor];
    table.separatorColor=[UIColor lightGrayColor];
    [self.view addSubview:table];
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0){
        table.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        table.backgroundColor=nil;
        table.backgroundView=nil;
    }
    
    [self.view addSubview:table];
    [table release];
    

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    
    
    
    
    return 1;
}









-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return 44;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    
    
    
    
    return [arrayList count];
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"]autorelease];
    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    
    
    
    
    
    
    
    
    
    UILabel *eLabel=[[UILabel alloc] init];
    eLabel.frame=CGRectMake(20, 0, 200, 44);
    eLabel.backgroundColor=[UIColor clearColor];
    //    eLabel.textColor=[UIColor lightGrayColor];
    //    eLabel.font=[UIFont boldSystemFontOfSize:19];
    eLabel.text=arrayList[indexPath.row];
  
    eLabel.textColor=[self randomColor];
    [cell addSubview:eLabel];
    [eLabel release];
    
    
    
    
    //     [NSThread detachNewThreadSelector:@selector(downLoadImageView) toTarget:self withObject:nil];
    
    return cell;
}


-(UIColor *)randomColor{
    
    int r=arc4random_uniform(255 + 1);
    int g=arc4random_uniform(255 + 1);
    int b=arc4random_uniform(255 + 1);
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
    
}

@end
