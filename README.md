# Making Miso Soup with ReactiveCocoa 4 and Swift 2

This project was developed using Xcode 7.1.1.

## Installing and Running on Your Mac

Clone the repository with

	git clone https://github.com/dz1111/Making-Miso-Soup-with-RAC4-and-Swift2
	
Add the submodule using

	cd Making-Miso-Soup-with-RAC4-and-Swift2

	git submodule add git@github.com:ReactiveCocoa/ReactiveCocoa.git
	
	cd ReactiveCocoa
	
	git pull origin swift2
	
	./script/bootstrap
	
Add the OS X embeddable binaries under the General tab of the target in Xcode.

* `ReactiveCocoa.framework`
* `Result.framework`
    
Build and run. Enjoy the soup.
