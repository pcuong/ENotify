//
//  ELCLoginViewController.m
//  ENotifyV2
//
//  Created by Cuong Pham Ngoc on 8/14/14.
//  Copyright (c) 2014 PCuong. All rights reserved.
//

#import "ELCLoginViewController.h"

@interface ELCLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *authenticationActivityIndicatorView;

- (IBAction)loginButtonTouch:(id)sender;
- (IBAction)backgroundTap:(id)sender;

- (void)authenticationDidStart;
- (void)authenticationDidStop;

@end

@implementation ELCLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.authenticationActivityIndicatorView.hidesWhenStopped = true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButtonTouch:(id)sender {
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)authenticationDidStop {
    
    [self.loginButton setEnabled:TRUE];
    [self.nameTextField setEnabled:TRUE];
    [self.passwordTextField setEnabled:TRUE];
    
    [self.authenticationActivityIndicatorView stopAnimating];
    
}

- (void)authenticationDidStart {
    
    [self.loginButton setEnabled:FALSE];
    [self.nameTextField setEnabled:FALSE];
    [self.passwordTextField setEnabled:FALSE];
    
    [self.authenticationActivityIndicatorView startAnimating];
}
@end
