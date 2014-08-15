//
//  ELCLoginViewController.m
//  ENotifyV2
//
//  Created by Cuong Pham Ngoc on 8/14/14.
//  Copyright (c) 2014 PCuong. All rights reserved.
//

#import "ELCLoginViewController.h"
#import "ELCAppDelegate.h"
#import "ELCMainViewController.h"
#import <CommonCrypto/CommonCrypto.h>
#import <AFNetworking/AFNetworking.h>

@interface ELCLoginViewController ()

@property (nonatomic) NSString* authToken;

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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    id nextView = [segue destinationViewController];
    if([nextView isKindOfClass:[ELCMainViewController class]]){
        
        
        [[ELCAppDelegate sharedAppDelegate] setAuthToken:self.authToken];
        
        NSLog(@"Good");
        
    }
    else {
        NSLog(@"Bad");
    }
}

- (IBAction)loginButtonTouch:(id)sender {
    
    if ([self.nameTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""]) {
        
        [ELCAppDelegate alert:@"Đăng nhập lỗi" otherValue:@"Hãy nhập tên tài khoản và mật khẩu"];
     
        return;
    }

    [self authenticationDidStart];
    
    NSString* accountName = [self.nameTextField.text uppercaseString];
    NSString* password = self.passwordTextField.text;
    
    NSString* combine = [NSString stringWithFormat:@"%@:%@", accountName, password];
    NSData* combineBytes = [combine dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    if(!CC_SHA1([combineBytes bytes], (uint32_t)[combineBytes length], digest))
    {
        NSLog(@"Không tạo được mã SRP");
        return;
    }
    
    
        NSMutableString* srpHash = [[NSMutableString alloc] initWithCapacity:CC_SHA1_DIGEST_LENGTH];
        for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
            [srpHash appendFormat:@"%02X", digest[i]];
        }
        
        NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
        [parameters setValue:accountName forKey:@"userName"];
        [parameters setValue:srpHash forKey:@"srpHash"];
        
        NSString* query = [NSString stringWithFormat:@"/Login?an=%@&srp=%@", accountName, srpHash];
        
        NSURL* restUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [ELCAppDelegate sharedAppDelegate].baseRESTFulUrl, [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        NSMutableURLRequest* httpRequest = [[NSMutableURLRequest alloc] initWithURL:restUrl];
        
        NSError *error;
        NSData* postData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
        NSString* postLength = [NSString stringWithFormat:@"%ld", (long)[postData length]];
        
        [httpRequest setHTTPMethod:@"POST"];
        [httpRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [httpRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [httpRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [httpRequest setHTTPBody:postData];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:httpRequest];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary* authResponse = (NSDictionary*)responseObject;
            NSLog(@"Authentication response: %@", authResponse);
            
            [self authenticationDidStop];
            
            NSObject* eResult = [authResponse valueForKey:@"Result"];
            if (eResult && [eResult isEqual:@0]) {
                
                // Lấy giá trị Token để cho quá trình giao tiếp dữ liệu về sau
                self.authToken = [NSString stringWithFormat:@"%@", [authResponse valueForKey:@"Token"]];
                
                [self performSegueWithIdentifier:@"showMain" sender:self];
                
            }
            else {
                
                [ELCAppDelegate alert:@"Hệ thống" otherValue:@"Tài khoản hoặc mật khẩu không đúng"];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [self authenticationDidStop];
            
            [ELCAppDelegate alert:@"Hệ thống" otherValue:[error localizedDescription]];
            
            
        }];
        [operation start];

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
