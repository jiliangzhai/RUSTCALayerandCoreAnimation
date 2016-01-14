//
//  ExamplesTableViewController.m
//  CALayerAndCoreAnimationDemo
//
//  Created by rust_33 on 16/1/14.
//  Copyright © 2016年 rust_33. All rights reserved.
//

#import "ExamplesTableViewController.h"

@interface ExamplesTableViewController (){
    
    NSMutableArray *exampleNames;
    NSMutableArray *classNames;
}

@end

@implementation ExamplesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    exampleNames = [NSMutableArray array];
    classNames = [NSMutableArray array];
    
    [exampleNames addObject:@"图层绘制方法1"];
    [exampleNames addObject:@"图层绘制方法2"];
    [exampleNames addObject:@"core animations"];
    [exampleNames addObject:@"core animation转场动画"];
    [exampleNames addObject:@"UIView封装动画"];
    [exampleNames addObject:@"UIView封装转场动动画"];
    
    [classNames addObject:@"ExampleViewController1"];
    [classNames addObject:@"ExampleViewController2"];
    [classNames addObject:@"ExampleViewController4"];
    [classNames addObject:@"ExampleViewController5"];
    [classNames addObject:@"ExampleViewController3"];
    [classNames addObject:@"ExampleViewController6"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return classNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rust"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rust"];
        cell.textLabel.text = exampleNames[indexPath.row];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class targetClass = NSClassFromString(classNames[indexPath.row]);
    if (targetClass) {
        
        UIViewController *targetController = [targetClass new];
        [self.navigationController pushViewController:targetController animated:YES];
        
    }
}
@end






