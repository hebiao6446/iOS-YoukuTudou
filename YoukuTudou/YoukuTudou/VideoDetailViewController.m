//
//  VideoDetailViewController.m
//  YoukuTudou
//
//  Created by ips on 15/2/28.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "UIImageView+WebCache.h"

#import "PayVideoViewController.h"


#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation VideoDetailViewController


-(void)viewDidLoad{
    
    
    [super viewDidLoad];
    
    self.title=self.data[@"title"];
    
 
    
    UITableView *table=[[UITableView alloc] init];
    table.frame=CGRectMake(0, 0,320, 416+(isIPhone5?88:0) );
    table.delegate=self;
    table.dataSource=self;
    table.backgroundColor=[UIColor whiteColor];
    table.separatorColor=[UIColor clearColor];
    table.showsVerticalScrollIndicator=NO;
    [self.view addSubview:table];
    [table release];
    
    
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    return  5;
    
    
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.row==0) {
        return 180;
    }else if(indexPath.row==1||indexPath.row==2||indexPath.row==3){
        
        
        return 44;
        
    }else if (indexPath.row==4){
        NSString *str=[NSString stringWithFormat:@"%@ %@",self.data[@"title"],self.data[@"description"]];
        
        
    return    [str sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(280, 2000000) lineBreakMode:NSLineBreakByWordWrapping].height+15;
    }
    
    return 10;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"]autorelease];
    }
    
    
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    
  
    
    if (indexPath.row==0) {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
        [imageView setImageWithURL:[NSURL URLWithString:self.data[@"bigPicUrl"]] placeholderImage:[UIImage imageNamed:@"cell4"]];
        [cell addSubview:imageView];
        [imageView release];
    }else if (indexPath.row==1){
        
        UILabel *eLabel=[[UILabel alloc] init];
        eLabel.frame=CGRectMake(20, 0, 280, 44);
        eLabel.backgroundColor=[UIColor clearColor];
        //    eLabel.textColor=[UIColor lightGrayColor];
        //    eLabel.font=[UIFont boldSystemFontOfSize:19];
        eLabel.text=[NSString stringWithFormat:@"片名:  %@",self.data[@"title"]];
        [cell addSubview:eLabel];
        [eLabel release];
        
        
        UIView *v=[[UIView alloc] init];
        v.frame=CGRectMake(0, 43.5, 320, 0.5);
        v.backgroundColor=[UIColor lightGrayColor];
        [cell addSubview:v];
        [v release];
        

        
    }else if (indexPath.row==2){
        
        UILabel *eLabel=[[UILabel alloc] init];
        eLabel.frame=CGRectMake(20, 0, 280, 44);
        eLabel.backgroundColor=[UIColor clearColor];
        //    eLabel.textColor=[UIColor lightGrayColor];
        //    eLabel.font=[UIFont boldSystemFontOfSize:19];
        eLabel.text=[NSString stringWithFormat:@"类型:  %@",self.data[@"tags"]];
        [cell addSubview:eLabel];
        [eLabel release];
        
        UIView *v=[[UIView alloc] init];
        v.frame=CGRectMake(0, 43.5, 320, 0.5);
        v.backgroundColor=[UIColor lightGrayColor];
        [cell addSubview:v];
        [v release];
        

        
    }
    else if (indexPath.row==3){
        
        
        int t=[self.data[@"totalTime"] integerValue];
        
        t=t/1000;
        
        NSString *tim=@"时长:  ";
        
        
        int h=t/3600;
        int m=t/60%60;
        int s=t%60;
        
        if (h>0) {
           tim= [tim stringByAppendingFormat:@"%d时",h];
        }
        
        
        if (m>0) {
           tim= [tim stringByAppendingFormat:@"%d分",m];
        }
        
        if (s>0) {
           tim= [tim stringByAppendingFormat:@"%d秒",s];
        }


        
        
        UILabel *eLabel=[[UILabel alloc] init];
        eLabel.frame=CGRectMake(20, 0, 280, 44);
        eLabel.backgroundColor=[UIColor clearColor];
        //    eLabel.textColor=[UIColor lightGrayColor];
        //    eLabel.font=[UIFont boldSystemFontOfSize:19];
        eLabel.text=tim;
        [cell addSubview:eLabel];
        [eLabel release];
        UIView *v=[[UIView alloc] init];
        v.frame=CGRectMake(0, 43.5, 320, 0.5);
        v.backgroundColor=[UIColor lightGrayColor];
        [cell addSubview:v];
        [v release];
        

        
    }else if (indexPath.row==4){
        
        NSString *str=[NSString stringWithFormat:@"%@ %@",self.data[@"title"],self.data[@"description"]];
        
        
        float h=[str sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(280, 2000000) lineBreakMode:NSLineBreakByWordWrapping].height;
        
        
        UILabel *eLabel=[[UILabel alloc] init];
        eLabel.frame=CGRectMake(20, 10, 280, h);
        eLabel.backgroundColor=[UIColor clearColor];
        //    eLabel.textColor=[UIColor lightGrayColor];
        //    eLabel.font=[UIFont boldSystemFontOfSize:19];
        eLabel.numberOfLines=0;
        eLabel.font=[UIFont systemFontOfSize:16];
        eLabel.text=str;
        [cell addSubview:eLabel];
        [eLabel release];
        
        UIView *v=[[UIView alloc] init];
        v.frame=CGRectMake(0, h-0.5+15, 320, 0.5);
        v.backgroundColor=[UIColor lightGrayColor];
        [cell addSubview:v];
        [v release];

        

    }

    
    
  
    
    
    
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    PayVideoViewController *pvvc=[[PayVideoViewController alloc] init];
    pvvc.urlString=self.data[@"html5Url"];
    [self.navigationController pushViewController:pvvc animated:YES];
    [pvvc release];
    
    
    
    
    
}




-(void)dealloc{
    
    [super dealloc];
    
    [_data release];
    
}
@end
