# Making Miso Soup with ReactiveCocoa 4 and Swift 2

This project was developed using Xcode 7.0.

## Installing and Running on Your Mac

Clone the repository with

	git clone https://github.com/dz1111/Making-Miso-Soup-with-RAC4-and-Swift2
	
Add the submodules using

	cd Making-Miso-Soup-with-RAC4-and-Swift2

	git submodule add git@github.com:ReactiveCocoa/ReactiveCocoa.git
	
	cd ReactiveCocoa
	
	git pull origin swift2
	
	./script/bootstrap
	
Add the OS X embeddable binaries under the general tab of the target.

* `ReactiveCocoa.framework`
* `Result.framework`
    
Build and run. Enjoy the soup.
