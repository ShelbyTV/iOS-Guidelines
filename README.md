# iOS Guidelines / v1.0-a5

## About
This document should serve as a guideline on how to structure an Xcode Project and write clean/readable Objective-C code for all current and future Cocoa-Touch Shelby projects.

## Xcode Project and File Organization
### File Hierarchy 
Cocoa-Touch heavily follows the MVC paradigm. Therefore, it is best to organize your files in folders according to said paradigm. You should have the following folders in your project
<pre>
- Models: All classes that notify Views, Controllers, and ViewControllers of changes
- Views: All UIView subclasses
- Controllers: All classes that manipualte data 
- ViewControllers: All UIViewController subclasses 
- Categories
	- UIColor+ColorWithHexAndAlpha
		- Converts Hex Color code to RGB and returns a UIColor objecy
		- Downlaod: https://github.com/ArtSabintsev/UIColor-ColorWithHexAndAlpha
	- All other Objective-C Extensions 	
- Constants
	- Constants.h
		- #import all other constants and structure files. 
		- For example, Constants.h file should import constants files called:
			- APIRoutes.h - Contains all API Routes used
			- ColorConstants.h - Containts all colors
- Supporting Files
	- Pre-Compiler Header
	- I18n files
	- Default and Icon PNGs
- External Libraries: All third-party libraries
- Assets: Image assets and fonts
</pre>

### Versioning
#### SemVer
We utilize the [Semantic Versioning System](http://www.semver.org). Visually, the semantic versioning system is: X.Y.Z (e.g., version 1.2.5). A short summary is provided below:

- Major Changes (**X**.y.z)
	- Backwards incompatible changes are introduced to the public API. It MAY include minor and patch level changes. Patch and minor version MUST be reset to 0 when major version is incremented.
- Minor Changes (x.**Y**.z) 
	- Backwards compatible functionality is introduced to the public API. It MUST be incremented if any public API functionality is marked as deprecated. It MAY be incremented if substantial new functionality or improvements are introduced within the private code. It MAY include patch level changes. Patch version MUST be reset to 0 when minor version is incremented.
- Patches (x.y.**Z**)
	- Backwards compatible bug fixes are introduced. A bug fix is defined as an internal change that fixes incorrect behavior.
- Pre-Releases (e.g., Internal Builds) 
	- Alpha: **X.Y.Z-a#** (e.g., 1.3.0-a1)
	- Beta: **X.Y.Z-b#** (e.g., 1.3.0-b1)
	- Release Candidate: **X.Y.Z-RC#** (e.g., 1.3.0-rc1)
	
#### Xcode Version and Build
- The proper use is to have the build number increment by one, every time a new archive is made. 
- The current use is to have the build number be equal to the version number

## Code Readability
### Encapsulation
All declarations should be in a private namespace within your class's **implementation file**.

Exceptions (e.g., declarations that are allowed in the class's public/protected interface):

1. Declarations that need to be used by other classes
1. IBOutlets and IBAction
1. Protocols

### Curly Braces, Parentheses, and Spacing
Pay attention to the positioning and placement of braces, parentheses, and to the spacing in the examples below:

- Conditionals

<pre>
if ( conditionA ) {

	// If conditionA is true, do something.

} else if ( conditionB ) {

	// If conditionB is true, do something else.

} else {

	// If conditionA and conditionB are both false, do something crazy!

}
</pre>

- Methods:

<pre>
- (void)myInstanceMethod
{

	// Code goes here 

}

+ (void)myClassMethods
{

	// Code goes here 
	
}
</pre>

### Commenting
All code should be self-documented, which means that there should be very few **//** in the source code. The bext example of this in Objective-C are detailed, *CamelCased* selectors 

- e.g., **tableView:didSelectRowAtIndexPath:**	

### IBAction and Void
All **IBAction** methods have a return-type of **void**. Fore the sake of readability in the implementation file of your class, keep your return-type for your action methods as **IBAction**. 

### NSStrings
When declaring an NSString property, always use the **copy** keyword.

### return statement
In 99% of situations, you should only have **1 return statement** in your non-void method.

### #pragma - Section Splitter
Make use of **#pragma**s to split up groups of methods. Example in the next section.

### DLog, not NSLog
- DLog is an NSLog macro that display the file-name and line number of your NSLog statement in the console.
- DLog is included in the Pre-Compiler Boilerplate
- **Always, always, always use DLog!**
<pre>
NSLog(@"Syncing the Queue") 
// output: Syncing the Queue
 
DLog(@"Syncing the Queue") 
// output: [CoreDataUtility syncQueueRoll:] [Line 600] Syncing the Queue
</pre>

### UIViewController Subclass Boilerplate
Look inside the **Sample View Controller/** folder for a template

### SIngleton Boilerplate
Look inside the **Sample Singleton/** folder for a template

### Pre-Compiler Header Boilerplate
The pre-compiler header should contain all of your global import files. Look inside the **Sample Pre-Compiler/** folder for a template.

## Modern Objective-C
We are making use of modern Objective-C syntax that was introduced in [WWDC 2012 - Session 405](https://developer.apple.com/videos/wwdc/2012/?id=405). A summary of the changes can be found below:

### @property, auto-synthesis & iVars
**@property** declarations now default to **(strong, atomic)**.

<pre>
// Strong Nonatomic Declaration
@property (nonatomic) NSObject *anObject; 

// Copy Nonatomic Declaration (e.g., NSStrings, by default)
@property (copy, nonatomic) NSObject *anObject; 

// Delegate Nonatomic Declaration
@property (weak, nonatomic) NSObject *aDelegate; 

// IBOutlet Nonatomic Declaration
@property (weak, nonatomic) IBOutlet UIView *aView; 

// Primitive Nonatomic Declaration
@property (assign, nonatomic) NSUInteger anInt;
</pre>

**@property** declarations now declare the iVars and auto-synthesize your variables for you.

- Explicit declaration of iVars is deprecated.
- Explicit declaration of **@synthesis var = _var** is unncessary.

### NSArray & NSMutableArray Literals
<pre>
// Declare an empty array
NSArray *anArray = @[] // = +[NSArray array];

// Declare a non-empty array
NSArray *anArray = @[objectA, objectB] // = +[NSArray arrayWithObjects: count:]; 

// Declare a non-empty, mutable array
NSMutableArray *aMutableArray = @[anArray mutableCopy]; +[NSMutableArray arrayWithArray:]; 
</pre>

### NSDictionary & NSMutableDictionary Literals
<pre>
// Declare an empty dictionary
NSDictionary *aDictionary = @{} // =+ [NSDictionary dictionary];

// Declare a non-empty dictionary
NSDictionary *aDictionary = @{keyA : valA, keyB : valB} // = +[NSDictionary dictionaryWithObjectsForKeys: count:];

// Declare a non-empty, mutable dictionary
NSMutableDictionary *aMutableDictionary = @{aDictionary mutableCopy} // = +[NSMutableDictionary dictionaryWithDictionary:];
</pre>

### NSNumber Literals
<pre>
// Integral literals
NSNumber *fortyTwo = @42;             // equivalent to [NSNumber numberWithInt:42]
NSNumber *fortyTwoUnsigned = @42u;    // equivalent to [NSNumber numberWithUnsignedInt:42u]
NSNumber *fortyTwoLong = @42l;        // equivalent to [NSNumber numberWithLong:42l]
NSNumber *fortyTwoLongLong = @42ll;   // equivalent to [NSNumber numberWithLongLong:42ll]

// Floating point literals
NSNumber *piFloat = @3.141592654f;    // equivalent to [NSNumber numberWithFloat:3.141592654f]
NSNumber *piDouble = @3.1415926535;   // equivalent to [NSNumber numberWithDouble:3.1415926535]

// Boolean literals
NSNumber *yesNumber = @YES;           // equivalent to [NSNumber numberWithBool:YES]
NSNumber *noNumber = @NO;             // equivalent to [NSNumber numberWithBool:NO]
</pre>
### typedef in Objective-C 

In iOS 6, **typedef enum** declarations were given an Objective-C makeover. Below is an example on how to declare a zero-indexed **enum**, APIRequestType, with 3 values.

<pre>
typedef NS_ENUM(NSUInteger, APIRequestType)
{
    APIRequestType_PostUserAuthorization,
    APIRequestType_GetStream,
    APIRequestType_GetRollFrames   
};
</pre>

## Github
### Branches
#### Minimum of n+1 branches
At any point in time, there will always be at the very least, n+1 branches, where **n** = number of developers. There is the **master** branch, and a personal-master branch for each developer, named after that person.

For example, if n = 3, we'll have 4 branches:

- master
- arthur-master 
- keren-master
- dan-master

Each developer should always work on their personal-master branch.

#### > n+1 branches
If a new feature is being developed, and the developer doesn't feel comfortable working on their personal branch, they should create a new branch. The branch's name should simply be the name of the feature. 

#### Committing
Commit code often.

### Merging

- Make sure your personal branch is merged with the lastest **master** commit before starting work each morning.
- Before merging your personal-master branch to **master**, do the following, make sure they're at the latest master branch.
	
### Tagging
- Tag all releases pushed to TestFlight/Hockey/Enterprise with the version number (e.g., 1.0-a20)
- Make sure to push the tags to origin (e.g., **git push --tags**)
