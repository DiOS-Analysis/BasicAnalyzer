# DiOS Basic Analyzer

The Analyzer is the core of DiOS' plugin architecture. All available analyzer components are loaded into an app's address space at startup and are responsible for performing the actual app analysis. By default, DiOS provides a basic analyzer that tracks access to privacy-related API calls and collects network packages. The Broker utlizizes the `AAClientLib`, a static library that simplifies the development of DiOS analyzer plugins. It receives notifications from the controller and provides a clean interface to report analysis results to the backend. 

This is a sample tweak to demonstrate how to develop DiOS analyzer plugins. This `BasicAnalyzer` tracks an app's file system accesses and reports them to the DiOS backend.

##Dependencies:

	* theos (installed to `/opt/theos`) <https://github.com/DHowett/theos>