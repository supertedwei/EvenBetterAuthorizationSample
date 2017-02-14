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
@property (nonatomic, assign, readwrite) IBOutlet NSTextView *  textView;

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
    
    [self logWithFormat:@"% 4d | %@ \n", intTaskLength, [_taskNameView stringValue]];
    
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

- (void)logWithFormat:(NSString *)format, ...
// Logs the formatted text to the text view.
{
    va_list ap;
    
    // any thread
    assert(format != nil);
    
    va_start(ap, format);
    [self logText:[[NSString alloc] initWithFormat:format arguments:ap]];
    va_end(ap);
}

- (void)logText:(NSString *)text
// Logs the specified text to the text view.
{
    // any thread
    assert(text != nil);
    NSFont *systemFont = [NSFont fontWithName:@"Courier" size: 12.0f];
    NSDictionary * fontAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:systemFont, NSFontAttributeName, nil];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[self.textView textStorage] appendAttributedString:[[NSAttributedString alloc] initWithString:text attributes:fontAttributes]];
    }];
}


@end
