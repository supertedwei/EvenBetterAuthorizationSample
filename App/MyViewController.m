//
//  MyViewController.m
//  Ninja Mode
//
//  Created by Ted Wei on 2/14/17.
//
//

#import "MyViewController.h"
#import "AppDelegate.h"

@interface MyViewController ()

// for IB

@property (nonatomic, assign, readwrite) IBOutlet NSTextField *  taskNameView;
@property (nonatomic, assign, readwrite) IBOutlet NSTextField *  taskLengthView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)startTimerAction:(id)sender
// Called when the user clicks the Get Version button.  This is the simplest form of
// NSXPCConnection request because it doesn't require any authorization.
{
    #pragma unused(sender)
    AppDelegate *appDelegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];
    NSString * taskLength = [_taskLengthView stringValue];
    NSInteger intTaskLength = [taskLength integerValue];
    if (intTaskLength == 0) {
        NSLog(@"Task Length is either 0 or not a number.\n");
        return;
    }
    
    NSLog(@"% 4d | %@ \n", intTaskLength, [_taskNameView stringValue]);
    
    _taskNameView.stringValue = @"";
    _taskLengthView.stringValue = @"";
    
    [appDelegate turnInternetOn];
    [NSTimer scheduledTimerWithTimeInterval:intTaskLength * 60
                                     target:self
                                   selector:@selector(timeUp:)
                                   userInfo:nil
                                    repeats:NO];
    [appDelegate closePopover];
}

- (void)timeUp:(id)sender {
    #pragma unused(sender)
    NSLog(@"timeUp\n");
    AppDelegate *appDelegate = (AppDelegate *)[[NSApplication sharedApplication] delegate];
    [appDelegate turnInternetOff];
}

- (BOOL)canBecomeKeyWindow {
    return NO;
}


@end
