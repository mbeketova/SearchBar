//
//  ViewController.m
//  SearchBar
//
//  Created by Admin on 21.05.15.
//  Copyright (c) 2015 Mariya Beketova. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayDisplay = [[NSMutableArray alloc] init];
    
    NSString * stringValue = @"One, Two, Three, Four, Five, Six, Seven, Eath, Naine, Then";

    
    self.arrayValue = [stringValue componentsSeparatedByString:@", "];
    [self.arrayDisplay addObjectsFromArray:self.arrayValue];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    

    
}


- (void) keyboardShown: (NSNotification * )note {
    
    //метод, который показывает клавиатуру
    
    CGRect keyboardFrame;
    [[[note userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keyboardFrame];
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.height -= keyboardFrame.size.height;
    [self.tableView setFrame:tableViewFrame];
    
    
}

- (void) keyboardHidden: (NSNotification *) note {
    //если клавиатура спрятана, развернуть таблицу на всю вью
    [self.tableView setFrame:self.view.bounds];
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayDisplay.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * simpleTaibleIndefir = @"Cell";
    
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:simpleTaibleIndefir];
    
    cell.label_Value.text = [self.arrayDisplay objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    //метод, который ищет в массиве строку
    
    if (searchText.length == 0) {
        [self.arrayDisplay removeAllObjects];
        [self.arrayDisplay addObjectsFromArray:self.arrayValue];
    }
    
    else {
        
        [self.arrayDisplay removeAllObjects];
        
        for (NSString * string in self.arrayValue) {
            
            NSRange r = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location != NSNotFound ) {
                [self.arrayDisplay addObject:string];
                
            }
            
        }
    
    }
    
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//прячем клавиатуру после нажатия на кнопку Поиска
    [searchBar resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
