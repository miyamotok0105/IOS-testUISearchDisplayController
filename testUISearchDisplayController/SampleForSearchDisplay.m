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
    searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"武器", @"女の子", @"男の子", nil];
    searchBar.showsScopeBar = YES;
    self.tableView.tableHeaderView = searchBar;
    
    searchDisplay_ =
    [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplay_.delegate = self;
    searchDisplay_.searchResultsDataSource = self;
    searchDisplay_.searchResultsDelegate = self;
    
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
    
    
}



- (BOOL)searchDisplayController:(UISearchDisplayController*)controller
shouldReloadTableForSearchString:(NSString*)searchString
{
    // 縺�▲縺溘ｓ蜈ｨ繝��繧ｿ繧貞炎髯､
    [searchResult_ removeAllObjects];
    // 讀懃ｴ｢譁�ｭ怜�繧貞性繧繝��繧ｿ縺�縺題ｿｽ蜉�縺吶ｋ
    for ( Item* item in dataSource_ ) {
        if ( NSNotFound != [item.name rangeOfString:searchString].location ) {
            [searchResult_ addObject:item];
        }
    }
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController*)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // 縺�▲縺溘ｓ蜈ｨ繝��繧ｿ繧貞炎髯､
    [searchResult_ removeAllObjects];
    // 讀懃ｴ｢譁�ｭ怜�繧貞性縺ｿ縲√°縺､蜷郁�縺吶ｋ繧ｹ繧ｳ繝ｼ繝励�繝��繧ｿ縺�縺代ｒ霑ｽ蜉�縺吶ｋ
    NSString* searchString = controller.searchBar.text;
    for ( Item* item in dataSource_ ) {
        if ( NSNotFound != [item.name rangeOfString:searchString].location ) {
            if ( 0 == searchOption ) {
                [searchResult_ addObject:item];
            } else if ( 1 == searchOption ) {
                if ( [item isWeapon] ) {
                    [searchResult_ addObject:item];
                }
            } else {
                if ( [item isArmor] ) {
                    [searchResult_ addObject:item];
                }
            }
        }
    }
    return YES;
}

#pragma mark UITableView methods

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if ( tableView == self.searchDisplayController.searchResultsTableView ) {
        return [searchResult_ count];
    } else {
        return [dataSource_ count];
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if ( tableView == self.searchDisplayController.searchResultsTableView ) {
        cell.textLabel.text = [[searchResult_ objectAtIndex:indexPath.row] name];
    } else {
        cell.textLabel.text = [[dataSource_ objectAtIndex:indexPath.row] name];
    }
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
