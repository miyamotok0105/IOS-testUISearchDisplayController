//
//  RootViewController.m
//  testUISearchDisplayController
//
//  Created by USER on 2015/06/06.
//  Copyright (c) 2015年 USER. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MENU";
    if ( !items_ ) {
        items_ = [[NSArray alloc] initWithObjects:
                  @"SampleForSearchDisplay",
                  nil ];
    }
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController setToolbarHidden:NO animated:NO];
    
    // 繝舌�縺ｮ濶ｲ繧貞�縺ｫ謌ｻ縺励※縺翫￥
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = nil;
    self.navigationController.toolbar.barStyle = UIBarStyleDefault;
    self.navigationController.toolbar.translucent = NO;
    self.navigationController.toolbar.tintColor = nil;
}

#pragma mark UITableView methods

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [items_ count];
}


- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString* title = [items_ objectAtIndex:indexPath.row];
    cell.textLabel.text = [title stringByReplacingOccurrencesOfString:@"SampleFor" withString:@""];
    
    return cell;
}

- (void)tableView:(UITableView*)tableView
didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* className = [items_ objectAtIndex:indexPath.row];
    Class class = NSClassFromString( className );
    UIViewController* viewController = [[class alloc] init];
    if ( !viewController ) {
        NSLog( @"%@ was not found.", className );
        return;
    }
    [self.navigationController pushViewController:viewController animated:YES];
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
