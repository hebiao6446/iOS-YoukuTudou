//
//  ChannelViewController.m
//  YoukuTudou
//
//  Created by ips on 15/2/27.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "ChannelViewController.h"

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface ChannelViewController ()

@end

@implementation ChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
  

    self.title=@"频道";
    
    
    arrayList=[[NSMutableArray alloc] init];
    
    [arrayList addObject:@{@"name":@"所有频道",@"channel":@"ALL"}];
    [arrayList addObject:@{@"name":@"娱乐",@"channel":@"1"}];
    [arrayList addObject:@{@"name":@"生活",@"channel":@"3"}];
    [arrayList addObject:@{@"name":@"搞笑",@"channel":@"5"}];
    [arrayList addObject:@{@"name":@"动漫",@"channel":@"9"}];
    [arrayList addObject:@{@"name":@"游戏",@"channel":@"10"}];
    [arrayList addObject:@{@"name":@"音乐",@"channel":@"14"}];
    
    [arrayList addObject:@{@"name":@"体育",@"channel":@"15"}];
    [arrayList addObject:@{@"name":@"电影",@"channel":@"22"}];
    [arrayList addObject:@{@"name":@"电视剧",@"channel":@"30"}];
    [arrayList addObject:@{@"name":@"教育",@"channel":@"25"}];
    [arrayList addObject:@{@"name":@"汽车",@"channel":@"26"}];
     [arrayList addObject:@{@"name":@"纪实",@"channel":@"28"}];
     [arrayList addObject:@{@"name":@"资讯",@"channel":@"29"}];
     [arrayList addObject:@{@"name":@"综艺",@"channel":@"31"}];
     [arrayList addObject:@{@"name":@"时尚",@"channel":@"32"}];
     [arrayList addObject:@{@"name":@"健康",@"channel":@"33"}];
     [arrayList addObject:@{@"name":@"美容",@"channel":@"34"}];
     [arrayList addObject:@{@"name":@"旅游",@"channel":@"35"}];
     [arrayList addObject:@{@"name":@"曲艺",@"channel":@"40"}];
     [arrayList addObject:@{@"name":@"母婴",@"channel":@"37"}];
    
     [arrayList addObject:@{@"name":@"网络剧",@"channel":@"19"}];
     [arrayList addObject:@{@"name":@"财经",@"channel":@"24"}];
     [arrayList addObject:@{@"name":@"女性",@"channel":@"27"}];
    
     [arrayList addObject:@{@"name":@"微电影",@"channel":@"39"}];
     [arrayList addObject:@{@"name":@"原创",@"channel":@"99"}];
    [arrayList addObject:@{@"name":@"其他1",@"channel":@"12"}];
    [arrayList addObject:@{@"name":@"其他2",@"channel":@"36"}];
    [arrayList addObject:@{@"name":@"其他3",@"channel":@"38"}];
     [arrayList addObject:@{@"name":@"其他4",@"channel":@"100"}];
     [arrayList addObject:@{@"name":@"其他5",@"channel":@"104"}];
     [arrayList addObject:@{@"name":@"其他6",@"channel":@"0"}];
    
    
    
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
    
    
    
    NSDictionary *data=arrayList[indexPath.row];
    
    
    if ([data[@"channel"] isEqualToString:self._channel]) {
        
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        
    }
    
    
    
    UILabel *eLabel=[[UILabel alloc] init];
    eLabel.frame=CGRectMake(20, 0, 200, 44);
    eLabel.backgroundColor=[UIColor clearColor];
    //    eLabel.textColor=[UIColor lightGrayColor];
    //    eLabel.font=[UIFont boldSystemFontOfSize:19];
    eLabel.text=data[@"name"];
    [cell addSubview:eLabel];
    [eLabel release];
    
    
    
    
    //     [NSThread detachNewThreadSelector:@selector(downLoadImageView) toTarget:self withObject:nil];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //     NSDictionary *data=arrList[indexPath.section][@"contactsList"][indexPath.row];
    
    
    
    
    NSDictionary *data=arrayList[indexPath.row];
    
    
    [self.delegate passChannelValue:data[@"channel"]];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}
-(void)dealloc{
    
    [super dealloc];
    
    [arrayList release];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
