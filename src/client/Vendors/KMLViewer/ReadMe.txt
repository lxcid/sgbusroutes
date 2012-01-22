### KMLViewer ###

===========================================================================
DESCRIPTION:

The KMLViewer sample application demonstrates how to use Map Kit's Annotations and Overlays to display KML (Keyhole Markup Language) files on top of an MKMapView.

Information on the KML file format can be found at:
	http://www.opengeospatial.org/standards/kml/
	http://code.google.com/apis/kml/documentation/

How to create a KML file -
KML files can be generated from Google Maps website.
It turns out the url to view a Google Map is also the same url used by the Google Maps API to access KML files.
The process to obtain a KML is as follows:

- Go to: "http://maps.google.com/"
- Click "Get Directions" link
- Type in the start and destination addresses
	(for example)
	Start = 451 University Avenue, Palo Alto, CA 94301
	Destination = #1 Infinite Loop, Cupertino, CA 95014
- Modify the route as you wish.
- Click the "Link" to this page link.
- Copy the email/IM link.
- Paste the link back into your Safari's address bar.
- Add &output=kml to the end of the url and press the enter key.
- The KML file will be downloaded to your Downloads folder.
- Move the new KML file from Downloads to your Xcode project.

===========================================================================
BUILD REQUIREMENTS:

iOS SDK 4.0 or later

===========================================================================
RUNTIME REQUIREMENTS:

iOS OS 4.0

===========================================================================
PACKAGING LIST:

KMLParser
- A simple NSXMLParser based parser for KML files.  Creates both model objects for annotations and overlays as well as styled views for model and overlay views.

KMLViewerViewController
- Demonstrates usage of the KMLParser class in conjunction with an MKMapView.

route.kml
- A KML file describing a bicycling route between Cupertino and Palo Alto, exported from maps.google.com.

===========================================================================
CHANGES FROM PREVIOUS VERSIONS:

Version 1.1
- Localized xib files, editorial changes.

Version 1.0
- First version.

===========================================================================
Copyright (C) 2010 Apple Inc. All rights reserved.
