NOTICE: This class is forked from https://github.com/cwRichardKim/RKSwipeBetweenViewControllers. This has been updated in order to provide with dynamic page creation feature (by using delegate), so the changes made this project not compatible with original project anymore. I might send pull requests to original repo, but I thought, in some situation (specifically it has static content), original class might be more suitable. So I decided to rename this and treat it as another project. With a respect to the original author, I left prefix 'RK'. Thanks for your great efforts, [Richard](https://github.com/cwRichardKim) :)

I added some features like looping, scrollable fragment (above tab buttons), navigation controller integration as well:


<video src="https://dl.dropboxusercontent.com/u/14547225/_ext/RKSwipableViewController.m4v" width="300" />


RKSwipableViewController
===========================

UIPageViewController and custom UISegmentedControl that scrollable and animated in synchronized manner. 

##Pod
	pod 'RKSwipableViewController'
	

## how to use 
(check out the provided AppDelegate to see an example):

__Programmatically__ (preferred)

1. Import RKSwipableViewController.h
	
	```objc
	#import <RKSwipableViewController/RKSwipableViewController.h>
	```

2. Initialize a RKSwipableViewController (Below is a sample implemented in AppDelegate. Class of `self` should declare RKSwipableViewControllerDataSource)

  	```objc
	RKSwipableViewController *swipableVC = [[RKSwipableViewController alloc] init];
	// customizing things
	swipableVC.isSegmentSizeFixed = NO;
	swipableVC.segmentButtonMinimumWidth = 50.0f;
	swipableVC.segmentButtonMarginWidth = 25.0f;
	swipableVC.segmentButtonEdgeMarginWidth = 10.0f;
	swipableVC.shouldSelectedButtonCentered = YES;
	swipableVC.segmentButtonHeight = 44.0f;
	swipableVC.segmentButtonBackgroundColor = [UIColor colorWithRed:0 green:0.4 blue:0.7 alpha:1];
	swipableVC.segmentButtonTextColor = [UIColor whiteColor];
	swipableVC.selectionBarColor = [UIColor greenColor];
	swipableVC.segmentContainerScrollViewBackgroundColor = [UIColor colorWithRed:0 green:0.4 blue:0.7 alpha:1];
	swipableVC.dataSource = self;
	swipableVC.enablesScrollingOverEdge = YES;
	swipableVC.isScrolledWhenTapSegment = YES;
	swipableVC.doUpdateNavigationTitleWithSwipedViewController = YES;
	```
	
3. implement RKSwipableViewControllerDataSource delegate
  	
	```objc
	- (long)numberOfViewControllers:(RKSwipableViewController *)swipableViewController {
	    return NUMBER_OF_SWIPABLE_VIEWS;
	}
	
	- (UIViewController *)swipableViewController:(RKSwipableViewController *)swipableViewController      
	                            viewControllerAt:(long)index 
	{
	    // VC source should be initialized before execution path arrives at here.
	    if(_vcArray[index] == [NSNull null]) {
	        UIViewController *vc = [[UIViewController alloc] init];
	        vc.view.backgroundColor = [UIColor colorWithWhite:1.0 - (index/16.0) alpha:1];
	        _vcArray[index] = vc;
	        UILabel *label = [[UILabel alloc] initWithFrame:swipableViewController.view.frame];
	        label.text = _vcMenuTitles[index];
	        label.textAlignment = NSTextAlignmentCenter;
	        label.font = [UIFont systemFontOfSize:36];
	        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	        [vc.view addSubview:label];
	        vc.title = label.text;
	    }
	    return _vcArray[index];
	}
	
	- (long)swipableViewController:(RKSwipableViewController *)swipableViewController
	         indexOfViewController:(UIViewController *)viewController 
	{
	    for(long i=0; i<_vcArray.count; i++) {
	        if(_vcArray[i] == viewController)
	            return i;
	    }
	    return NSNotFound;
	}
	
	- (NSString *)swipableViewController:(RKSwipableViewController *)swipableViewController 
	                        segmentTextAt:(long)index 
	{
	    return _vcMenuTitles[index];
	}
	```

4. Use the custom class (or call it as the first controller from app delegate: see below)
  	
	```objc
  	self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
  	self.window.rootViewController = navigationController;
  	[self.window makeKeyAndVisible];
  	```

.

.

  
__StoryBoard__
(Will be updated)


.

.



### Areas for Improvement / Involvement
* Background blew out when pushing a view controller. Make the animation more natural.
