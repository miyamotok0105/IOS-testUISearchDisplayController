//
//  SampleForSearchDisplay.h
//  testUISearchDisplayController
//
//  Created by USER on 2015/06/06.
//  Copyright (c) 2015年 USER. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Item : NSObject
{
@private
    BOOL weapon_;
    BOOL armor_;
    NSString* name_;
}

@property (nonatomic, assign, getter=isWeapon) BOOL weapon;
@property (nonatomic, assign, getter=isArmor) BOOL armor;
@property (nonatomic, copy) NSString* name;

+ (id)weaponWithName:(NSString*)name;
+ (id)armorWithName:(NSString*)name;
- (NSComparisonResult)compare:(Item*)aItem;

@end



@interface SampleForSearchDisplay : UITableViewController <UISearchBarDelegate>
{
@protected
//    UISearchDisplayController* searchDisplay_;
    UISearchController *searchDisplay_;
    
    NSMutableArray* dataSource_;
    NSMutableArray* searchResult_;
}
@end
