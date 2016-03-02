//
//  ViewController.m
//  YoukuTudou
//
//  Created by ips on 15/2/27.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "ViewController.h"

#import "TypeViewController.h"
#import "ChannelViewController.h"

#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "UIImageView+WebCache.h"
#import "VideoDetailViewController.h"
//#import <SystemConfiguration/CaptiveNetwork.h>

#include <arpa/inet.h>

#include <net/if.h>

#include <ifaddrs.h>


#import "Reachability.h"
#import "SimplePingHelper.h"







#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


@interface ViewController ()

@end

@implementation ViewController



- (NSString *)localIPAddress

{
    
    NSString *localIP = nil;
    
    struct ifaddrs *addrs;
    
    if (getifaddrs(&addrs)==0) {
        
        const struct ifaddrs *cursor = addrs;
        
        while (cursor != NULL) {
            
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
                
            {
                
                //NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                
                //if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
                
//                {
                
                    localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                    
                    break;
                    
//                }
                
            }
            
            cursor = cursor->ifa_next;
            
        }
        
        freeifaddrs(addrs);
        
    }
    
    return localIP;
    
}


-(BOOL) isConnectionAvailable:(NSString *)ipAdress{
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    
    zeroAddress.sin_addr.s_addr = htons(inet_addr([ipAdress UTF8String ]));
    
    
    Reachability *reach = [Reachability reachabilityWithAddress:&zeroAddress];
    
    
    
    return reach.isReachable;
}

-(void)logReachAddress{
    
    NSString *str= [self localIPAddress];
    
    NSArray *arr=[str componentsSeparatedByString:@"."];
    
//    NSLog(@"%@ ----- ",arr);
    
    if ([arr count]!=4) {
        return;
    }
    
    mddddd=[[NSMutableString alloc] init];
    
    
    [mddddd setString:arr[2]];
    
    
    pingStartId=0;
    
//    for (int i=0; i<=255; i++) {
        NSString *ipStr=[NSString stringWithFormat:@"192.168.%@.%d",arr[2],pingStartId];
        
        
        /*
        if ([self isConnectionAvailable:ipStr]) {
            
            NSLog(@"-------------  %@",   ipStr);
        }
         */
        NSLog(@"-------------  %@",   ipStr);
       [SimplePingHelper ping:ipStr target:self sel:@selector(pingResult:)];
        
//    }
}

- (void)pingResult:(NSNumber*)success {
    if (success.boolValue) {
         NSLog(@"-------------  %@",@"SUCCESS");
    } else {
         NSLog(@"-------------  %@",@"FAILURE");
    }
    
    NSLog(@"       ");
    NSLog(@"       ");
    NSLog(@"       ");
    
    [self keepPing];
}


-(void)keepPing{
    
    
    pingStartId++;
    
    if (pingStartId>255) {
        return;
    }
    
    NSString *ipStr=[NSString stringWithFormat:@"192.168.%@.%d",mddddd,pingStartId];
    
    
    /*
     if ([self isConnectionAvailable:ipStr]) {
     
     NSLog(@"-------------  %@",   ipStr);
     }
     */
    NSLog(@"-------------  %@",   ipStr);
    [SimplePingHelper ping:ipStr target:self sel:@selector(pingResult:)];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
  
    
   [self logReachAddress];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,[UIColor clearColor],UITextAttributeTextShadowColor,[UIFont boldSystemFontOfSize:20],UITextAttributeFont,nil]];
    
    
    
    
    
    
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title2.png"] forBarMetrics:UIBarMetricsDefault];
        
    }else{
        
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title1.png"] forBarMetrics:UIBarMetricsDefault];
        
        
    }
    
    
    self.title=@"首页";
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    [self createBarLeft];
    [self createBarRight];
    
    
    channelId=[[NSMutableString alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"channelId"]!=nil) {
        
        NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"channelId"];
        
        [channelId setString:str];
        
    }else{
        [channelId setString:@"ALL"];
    }
    
    sort=[[NSMutableString alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sort"]!=nil) {
        
        NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"sort"];
        
        [sort setString:str];
        
    }else{
        [sort setString:@"ALL"];
    }
    
    
    
    pageNo=1;
    
    
    
    
    arrayList=[[NSMutableArray alloc] init];
    
    
    table=[[UITableView alloc] init];
    table.frame=CGRectMake(0, 0,320, 416+(isIPhone5?88:0) );
    table.delegate=self;
    table.dataSource=self;
    table.backgroundColor=nil;
    table.separatorColor=[UIColor lightGrayColor];
    [self.view addSubview:table];
    
    
    
    
    
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - table.bounds.size.height, 320, table.bounds.size.height)];
    _refreshHeaderView.backgroundColor=[UIColor whiteColor];
    _refreshHeaderView.delegate = self;
    _refreshHeaderView.tag=111;
    [table addSubview:_refreshHeaderView];
    [_refreshHeaderView refreshLastUpdatedDate];
    
    
    
    
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [view setCenter:CGPointMake(290.0f, 25)];
    [view setBackgroundColor:[UIColor clearColor]];
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320,50)];
    l.text = @"加载中...";
    l.backgroundColor=[UIColor whiteColor];
    l.font = [UIFont boldSystemFontOfSize:16];
    l.textAlignment = NSTextAlignmentCenter;
    self.nextCell = [[[UITableViewCell alloc] init] autorelease];
    [self.nextCell setFrame:CGRectMake(0.0f, 0.0f, 320,50)];
    [self.nextCell.contentView addSubview:l];
    [l release];
    [self.nextCell addSubview:view];
    [view release];
    [view startAnimating];
    
    
    table.tableFooterView=nil;
    
    
    
    [self getNetDataFromUrl];
    
    
    
}







-(void)getNetDataFromUrl{
    
    
    NSString *urlString=@"http://api.tudou.com/v3/gw";
    
    NSDictionary *da=@{@"name":@"hebiao",@"":@""};
    
   ASIFormDataRequest *httpRequest=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    [httpRequest setDelegate:self];
    [httpRequest setPostValue:@"item.ranking" forKey:@"method"];
    [httpRequest setPostValue:@"json" forKey:@"format"];
    [httpRequest setPostValue:@"2aaf400b13fc9bad" forKey:@"appKey"];
    [httpRequest setPostValue:@(pageNo) forKey:@"pageNo"];
    [httpRequest setPostValue:@"10" forKey:@"pageSize"];
    if (![channelId isEqualToString:@"ALL"]) {
        [httpRequest setPostValue:channelId forKey:@"channelId"];
    }
    if (![sort isEqualToString:@"ALL"]) {
        
         [httpRequest setPostValue:sort forKey:@"sort"];
    }
    
   
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDidStartSelector:@selector(startGetData:)];
    [httpRequest setDidFinishSelector:@selector(finishGetData:)];
    [httpRequest setDidFailSelector:@selector(failGetData:)];
    [httpRequest startAsynchronous];
    
    
}
-(void)startGetData:(ASIHTTPRequest *)sender{
    
}
-(void)finishGetData:(ASIHTTPRequest *)sender{
    
    NSString *str=[sender responseString];
    NSDictionary *data=[str JSONValue][@"multiPageResult"];
    
    
    _loading=NO;
    NSArray *arrayData=[data objectForKey:@"results"];
    
    
    if (_reloading) {
        [arrayList removeAllObjects];
         [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    
    
    
    
    [arrayList addObjectsFromArray:arrayData];
    if ([arrayData  count] == 10) {
        table.tableFooterView = self.nextCell;
    }else{
        table.tableFooterView = nil;
    }
    
    [self doneLoadingTableViewData];
    
    [table reloadData];
    
    
}
-(void)failGetData:(ASIHTTPRequest *)sender{
    
}
- (void)reloadTableViewDataSource{
    
    
    pageNo=1;
    _reloading = YES;
    
    [self getNetDataFromUrl];
    
 
    
    
    
    
    
    
}


- (void)doneLoadingTableViewData{
    
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:table];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    
        _refreshHeaderView.delegate = self;
  
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
   
        
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        
        if(scrollView.contentOffset.y>scrollView.contentSize.height-460-(isIPhone5?88:0)&&table.tableFooterView!=nil&&!_loading){
            _loading = YES;
            
            pageNo++;
            
            
            
            [self getNetDataFromUrl];
            
            
            
            
            
            
        }
   
    
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    
   
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
        
    
    
    
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    
    
        [self reloadTableViewDataSource];
//        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
    
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    
        return  _reloading;
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date]; // should return date data source was last changed
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
  
        return [arrayList count];
    
    
    
 
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return 80;
    
    
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
    
    
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 100, 56)];
    [imageView setImageWithURL:[NSURL URLWithString:data[@"picUrl"]] placeholderImage:[UIImage imageNamed:@"cell3"]];
    [cell addSubview:imageView];
    [imageView release];
    
    
    UILabel *title=[[UILabel alloc] init];
    title.frame=CGRectMake(124, 12, 190, 20);
    title.backgroundColor=[UIColor clearColor];
    title.font=[UIFont systemFontOfSize:16];
    title.text=data[@"title"];
    [cell addSubview:title];
    [title release];
    
    UILabel *description=[[UILabel alloc] init];
    description.frame=CGRectMake(124, 35, 190, 40);
    description.backgroundColor=[UIColor clearColor];
    description.textColor=[UIColor lightGrayColor];
    description.font=[UIFont systemFontOfSize:12];
    description.numberOfLines=0;
    description.text=data[@"description"];
    [cell addSubview:description];
    [description release];
    
    
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    VideoDetailViewController *vdvc=[[VideoDetailViewController alloc] init];
    vdvc.data=arrayList[indexPath.row];
    [self.navigationController pushViewController:vdvc animated:YES];
    [vdvc release];
    
    
    
    
     
    
}





-(void)createBarLeft{
    
   
    UIButton *btnb = [UIButton buttonWithType : UIButtonTypeCustom];
    
    
    btnb.frame = CGRectMake (0, 0,  44, 44);
    
    [btnb setTitle:@"类型" forState:UIControlStateNormal];
    [btnb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
   
    [btnb addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *ubar=[[UIBarButtonItem alloc] initWithCustomView :btnb];
    
    self.navigationItem.leftBarButtonItem = ubar;
    
}

-(void)createBarRight{
    
    
    UIButton *btnb = [UIButton buttonWithType : UIButtonTypeCustom];
    
    
    btnb.frame = CGRectMake (0, 0,  44, 44);
    
    [btnb setTitle:@"频道" forState:UIControlStateNormal];
    [btnb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [btnb addTarget:self action:@selector(showRight:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *ubar=[[UIBarButtonItem alloc] initWithCustomView :btnb];
    
    self.navigationItem.rightBarButtonItem = ubar;
    
}

-(void)showLeft:(UIButton *)sender{
    TypeViewController *tvc=[[TypeViewController alloc] init];
    tvc._sort=sort;
    tvc.delegate=self;
    [self.navigationController pushViewController:tvc animated:YES];
    [tvc release];
}

-(void)showRight:(UIButton *)sender{
    
   
    ChannelViewController *cvc=[[ChannelViewController alloc] init];
    cvc._channel=channelId;
    cvc.delegate=self;
    [self.navigationController pushViewController:cvc animated:YES];
    [cvc release];
    
    
    
    
    
}

-(void)passChannelValue:(NSString *)channel{
    [channelId setString:channel];
    
    [[NSUserDefaults standardUserDefaults] setObject:channelId forKey:@"channelId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self reloadTableViewDataSource];
    
}
-(void)passTypeValue:(NSString *)sor{
    
    [sort setString:sor];
    
    [[NSUserDefaults standardUserDefaults] setObject:sort forKey:@"sort"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self reloadTableViewDataSource];
}

-(void)dealloc{
    [super dealloc];
    
    
    
    
}
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
