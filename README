# SG Bus Routes #

First and for most, this solution is referenced heavily from [Cheeaun's effort on SBRE](https://github.com/cheeaun/busrouter-sg).

There's data generation component and a client component.

The data generation component is a bunch of scripts written in a pipeline, where one script output is another script input.

Once you run the data generation component, you can run the client component and see the latest updated SG bus routes.


## The rationale (Why another project?): ##

 * I am a rubyist and I don't want to install node.js. (Don't feel like installing due to some pass horror with compiling it.)
 * The solution cheeaun proposed are custom json format. I wanted a KML format similar to the bus routes from http://publictransport.sg/.
 * I want to feed this to the KMLViewer from Apple's sample project. (In hackish mode so didn't want to write a parser for Cheeaun's data structure, although it won't be hard)

## Limitation: ##

 * The final data structure by Cheeaun is superior than the one provided here. (Although you can reconstruct back the data structure by modifying the merge-bus-routes-with-bus-stops.rb a bit.)
 * I do not differentiate between the different bus routes (route 1 and sometimes route 2) in the final output format, KML. (I don't know if KML can do that or not though)
 * I have very limited knowledge of KML so implementation might be hackish.
 * No shebang. :P

## Steps to generate data ##

    # 0. Make sure you have all the gems
    bundle install
    # 1. Get bus services
    ruby get-bus-services.rb
    # 2. Get bus routes (Dependent on 1)
    ruby get-bus-routes.rb
    # 3. Get bus stops (Dependent on 1)
    ruby get-bus-stops.rb
    # 4. Merge bus routes and bus stops into a KML file.
    ruby merge-bus-routes-with-bus-stops.rb