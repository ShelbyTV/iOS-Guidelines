# iOS Guidelines / v1.0-a11

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
		- Converts Hex Color code to RGB and returns a UIColor object
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
1. IBOutlets and IBAction Methods
1. Protocols

### BOOLean Flags
Avoid them whenever possible.

### Braces, Parentheses, and Spacing
Pay attention to the positioning and placement of braces, parentheses, and to the spacing in the examples below:

- Conditionals #1

<pre>
All non-ternary statements should have curly-braces around them

// Incorrect 
if ( conditionA ) [self doSomething];

// Incorrect
if ( conditionA )
	[self doSomething];
	
// Correct
if ( conditionA ) {

	[self doSomething];

}
</pre>

- Conditionals #2

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

### Fast Enumeration
Use fast enumeration in loops as it is more concise and efficient. Keep in mind, that you can't modify the array while in loop

<pre>
for (NSString *someString in array) {
    // do something
}
</pre>

### Commenting
All code should be self-documented, which means that there should be very few **//** in the source code. The bext example of this in Objective-C are detailed, *CamelCased* selectors 

- e.g., **tableView:didSelectRowAtIndexPath:**	

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

### IBAction and Void
All **IBAction** methods have a return-type of **void**. Fore the sake of readability in the implementation file of your class, keep your return-type for your action methods as **IBAction**. 

### NSStrings
When declaring an NSString property, always use the **copy** keyword.

### #pragma - Section Splitter
Make use of **#pragma**s to split up groups of methods.

### return statement
In 99% of situations, you should only have **1 return statement** in your non-void method.

## Templates

### UIViewController Subclass Boilerplate
Look inside the **Sample View Controller/** folder for a template

### Singleton Boilerplate
Look inside the **Sample Singleton/** folder for a template

### Pre-Compiler Header Boilerplate
The pre-compiler header should contain all of your global import files. Look inside the **Sample Pre-Compiler/** folder for a template.

## Modern Objective-C (iOS 6+)
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
- Explicit declaration of **@synthesize var = _var** is unncessary.

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
NSNumber *fortyTwo = @42;             // = [NSNumber numberWithInt:42]
NSNumber *fortyTwoUnsigned = @42u;    // = [NSNumber numberWithUnsignedInt:42u]
NSNumber *fortyTwoLong = @42l;        // = [NSNumber numberWithLong:42l]
NSNumber *fortyTwoLongLong = @42ll;   // = [NSNumber numberWithLongLong:42ll]

// Floating point literals
NSNumber *piFloat = @3.141592654f;    // = [NSNumber numberWithFloat:3.141592654f]
NSNumber *piDouble = @3.1415926535;   // = [NSNumber numberWithDouble:3.1415926535]

// Boolean literals
NSNumber *yesNumber = @YES;           // = [NSNumber numberWithBool:YES]
NSNumber *noNumber = @NO;             // = [NSNumber numberWithBool:NO]
</pre>
### typedef in Objective-C 

In iOS 6, **typedef enum** declarations were given an Objective-C makeover. Below is an example on how to declare a zero-indexed **enum**, APIRequestType, with 3 values.

<pre>
typedef NS_ENUM(NSUInteger, APIRequestType)
{
    APIRequestTypePostUserAuthorization,
    APIRequestTypeGetStream,
    APIRequestTypeGetRollFrames   
};
</pre>

## Error Checks
- Never assume an object what you think it is. (Especially when the object comes back from network or coredata.
- Always add error checks and especially when the operation might cause a crash if there is an error. For example:
	- NSArray: 
		- Check for type
		- Check for size
		<pre>
		NSArray *someArray = ....
		if ([someArray isKindOfClass[NSArray class]] && [someArray count] > index) {
				Object *someObject = someArray[index];
				...
		}
		</pre>
	- NSDictionary:
		- Check for type
		- Make sure key and value are not nil
		<pre>
		NSDictionary *someDictionary = ....
		if ([someDictionary isKindOfClass:[NSDictionary class]] && key && value) {
				someDictionary[key] = value;
		}
	- NSManagedObjectContext - check for nil before calling certain methods:
		<pre>
		if (objectID) {
				Object *somebject = [context existingObjectWithID:objectID error:nil]
				....
		}
		</pre>

	- For readability & error check, don't chain calls:
	<pre>
	// Instead of this:
	NSArray *resultsArray = [resultsDictionary[@"result"] valueForKey:@"frames"];
	</pre>
	<pre>
	// Do this:
	if ([resultsDictionary isKindOfClass:[NSDictionary class]]) {
			NSDictionary *result = resultsDictionary[@"result"];
			if ([result isKindOfClass:[NSDictionary class]]) {
				NSArray *frames = result[@"frames"];
				if ([frames isKindOfClass:[NSArray class]]) {
					for (Frame *frame in frames) {
						// Do something
					}
				}
			}
		}
	</pre>


## Git and Github
### Branches
- There is only one master branch.
- Each new feature gets their own branch
- The branch's name should simply be the name of the feature. 
- Make sure to merge your working branch with master occassionally
- When your feature is completed and smoke-tested, make sure to merge your branch with master, and delete your branch

### Committing
- Commit code frequnetly.
- Make sure to always push your commits to Github
	- Example: **git push origin myBranch**
- Make sure your commits are descriptive
- If addressing an issue in Github, make sure to reference the issue number with a hash/pound-sign to the commit, including the hash as that creates a reference to the issue in the commit
	- Example: **Addressed #101 - Added new API routes** 
	
### Tagging
- Tag all releases pushed to TestFlight/Hockey/Enterprise with the version number (e.g., 2.0-a20)
- Creating a tag
	- Locally: **git tag tagName**
	- Make sure to push it remotely: **git push --tags**
- Deleting a tag:
	- Locally: **git tag -d tagName**
	- Remotely: **git push origin :refs/tags/tagName**

### Pulling and Merging
- Make sure to pull the latest commits before starting work every morning.
- If master has changed, make sure to merge with master

### Github Labels, Assignments and Milestone
Before finishing the creation of a new issue, make sure to: 

- Label each issue properly
- Assign a developer to address the issue
	- If you're assigning yourself, make sure not to forget that you're working on that issue 
- Add a milestone, if one exists.
