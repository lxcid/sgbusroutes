![Status: Inactive](https://img.shields.io/badge/status-inactive-red.svg)
![Maintained?: No](https://img.shields.io/badge/maintained%3F-no-red.svg)

# SG Bus Routes #

First and for most, this solution is referenced heavily from [Cheeaun's effort on SBRE](https://github.com/cheeaun/busrouter-sg).

There's data generation component and a client component.

The data generation component is a bunch of scripts written in a pipeline, where one script output is another script input.

Once you run the data generation component, you can run the client component and see the latest updated SG bus routes.


## The rationale (Why another project?): ##

 * I am a rubyist and I don't want to install node.js. (Don't feel like installing due to some pass horror with compiling it.)
 * The solution Cheeaun proposed are custom json format. I wanted a KML format similar to the bus routes from http://publictransport.sg/.
 * I want to feed this to the KMLViewer from Apple's sample project. (In hackish mode so didn't want to write a parser for Cheeaun's data structure, although it won't be hard)

## Limitation: ##

 * Final format not pars-able. (Although I can spend some time updating the data structure)
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
    # 4. Merge bus routes and bus stops into a KML file. (Dependent on 2 and 3)
    ruby merge-bus-routes-with-bus-stops.rb
