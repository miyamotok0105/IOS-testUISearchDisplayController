//
//  SampleForSearchDisplay.m
//  testUISearchDisplayController
//
//  Created by USER on 2015/06/06.
//  Copyright (c) 2015年 USER. All rights reserved.
//

#import "SampleForSearchDisplay.h"

@interface SampleForSearchDisplay ()

@end


@implementation Item

@synthesize weapon = weapon_;
@synthesize armor = armor_;
@synthesize name = name_;

+ (id)weaponWithName:(NSString*)name {
    Item* item = [[Item alloc] init];
    item.name = name;
    item.weapon = YES;
    return item;
}

+ (id)armorWithName:(NSString*)name {
    Item* item = [[Item alloc] init];
    item.name = name;
    item.armor = YES;
    return item;
}

- (NSComparisonResult)compare:(Item*)aItem {
    if ( aItem == self ) {
        return NSOrderedSame;
    }
    return [self.name compare:[aItem name]];
}

@end



@implementation SampleForSearchDisplay

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"タイトル";
    
    UISearchBar* searchBar = [[UISearchBar alloc] init];
    searchBar.frame = CGRectMake( 0, 0, self.tableView.bounds.size.width, 0 );
    [searchBar sizeToFit];
//    searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"武器", @"女の子", @"男の子", nil];
    searchBar.showsScopeBar = YES;
    searchBar.delegate = self;
    self.tableView.tableHeaderView = searchBar;
    

    
    NSArray* weapons = [NSArray arrayWithObjects:
                        @"大島優子",
                        @"前田敦子",
                        @"篠田麻里子",
                        @"板野友美",
                        nil];
    NSArray* armors = [NSArray arrayWithObjects:
                       @"渡辺麻友",
                       @"指原莉乃	",
                       @"柏木由紀	",
                       @"松井珠理奈",
                       @"高橋みなみ",
                       nil];
    dataSource_ = [[NSMutableArray alloc] initWithCapacity:16];
    for ( id name in weapons ) {
        [dataSource_ addObject:[Item weaponWithName:name]];
    }
    for ( id name in armors ) {
        [dataSource_ addObject:[Item armorWithName:name]];
    }
    [dataSource_ sortUsingSelector:@selector(compare:)];
    
    searchResult_ = [[NSMutableArray alloc] initWithCapacity:dataSource_.count];
    searchResult_ = [dataSource_ mutableCopy];
    
    NSLog(@"Load searchResult %@ ", searchResult_);
    NSLog(@"Load dataResult %@ ", dataSource_);
    
    
}


//検索テキスト変更時
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    NSLog(@"root searchBar");
    
    [searchResult_ removeAllObjects];
   
    NSString* searchString = searchText;
    
    for ( Item* item in dataSource_ ) {
        
        if((searchText == nil || [searchText isEqualToString:@""]))
        {
            searchResult_ = [dataSource_ mutableCopy];
            break;
        }
        
        if ( NSNotFound != [item.name rangeOfString:searchString].location )
        {
           [searchResult_ addObject:item];
        }
    }
    
    
    [self.tableView reloadData];
    
    NSLog(@"Load searchResult %@ ", searchResult_);
    NSLog(@"Load dataResult %@ ", dataSource_);
    
    
}

//
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    
    NSLog(@"Load searchResult %@ ", searchResult_);
    NSLog(@"Load dataResult %@ ", dataSource_);
    
}

//検索キャンセル時
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"root searchBarCancelButtonClicked");
    
    [searchResult_ removeAllObjects];
    searchResult_ = [dataSource_ mutableCopy];
    
    [self.tableView reloadData];
    
    NSLog(@"Load searchResult %@ ", searchResult_);
    NSLog(@"Load dataResult %@ ", dataSource_);
    
}


#pragma mark UITableView methods

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"root tableView numberOfRowsInSection");
    
    return [searchResult_ count];
    
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSLog(@"root tableView cellForRowAtIndexPath");
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[searchResult_ objectAtIndex:indexPath.row] name];
    
    return cell;
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
