//
//  TypeViewController.m
//  YoukuTudou
//
//  Created by ips on 15/2/27.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "TypeViewController.h"


#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface TypeViewController ()

@end

@implementation TypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=@"类型";
    
    arrayList=[[NSMutableArray alloc] init];
    
    [arrayList addObject:@{@"name":@"所有类型",@"sort":@"ALL"}];
    [arrayList addObject:@{@"name":@"最新发布",@"sort":@"t"}];
    [arrayList addObject:@{@"name":@"人气最旺",@"sort":@"v"}];
    [arrayList addObject:@{@"name":@"收藏最多",@"sort":@"f"}];
    [arrayList addObject:@{@"name":@"打分最高",@"sort":@"r"}];
    [arrayList addObject:@{@"name":@"评论最狠",@"sort":@"c"}];
    [arrayList addObject:@{@"name":@"土豆推荐",@"sort":@"m"}];
    [arrayList addObject:@{@"name":@"清晰视频序",@"sort":@"h"}];
    

    
    for (char ch='a'; ch<='z'; ch++) {
         [arrayList addObject:@{@"name":[NSString stringWithFormat:@"分类%c",ch-32],@"sort": [NSString stringWithFormat:@"%c",ch]  }];
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
    
    
    
    NSDictionary *data=arrayList[indexPath.row];
    
    
    if ([data[@"sort"] isEqualToString:self._sort]) {
        
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

    
    [self.delegate passTypeValue:data[@"sort"]];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc{
    
    [super dealloc];
    
    [arrayList release];
    
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
