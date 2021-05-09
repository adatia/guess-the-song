//
//  CampaignsInformation.swift
//  guess-the-song
//
//  Created by Shayn Adatia on 2019-06-04.
//

import Foundation
import UIKit

//declares variables that store the titles, albums and album covers of whichever genre the user chooses
var currentTitles: [String] = []
var currentAlbums: [String] = []
var currentAlbumCovers: [UIImage] = []

//declares variables that store all of the titles, albums and album covers for the drake campaign
var drakeTitles: [String] = ["God's Plan", "Hotline Bling", "Controlla", "Jumpman", "Look Alive", "In My Feelings", "Started From The Bottom", "Portland", "Gyalchester", "One Dance"]
var drakeAlbums: [String] = ["Scorpion", "Views", "Views", "What A Time To Be Alive", "Look Alive", "Scorpion", "Nothing Was The Same", "More Life", "More Life", "Views"]
var drakeAlbumCovers: [UIImage] = [#imageLiteral(resourceName: "Scorpion.jpg"),#imageLiteral(resourceName: "Views.jpg"),#imageLiteral(resourceName: "Views.jpg"),#imageLiteral(resourceName: "What A Time To Be Alive.jpg"),#imageLiteral(resourceName: "Look Alive.jpg"),#imageLiteral(resourceName: "Scorpion.jpg"),#imageLiteral(resourceName: "Nothing Was The Same.jpg"),#imageLiteral(resourceName: "More Life.jpg"),#imageLiteral(resourceName: "More Life.jpg"),#imageLiteral(resourceName: "Views.jpg")]

//declares variables that store all of the titles, albums and album covers for the ariana grande campaign
var arianaTitles: [String] = ["Dangerous Woman", "Everyday", "Into You", "Side To Side", "thank u, next", "7 rings", "Break Up With Your Girlfriend I'm Bored", "No Tears Left To Cry", "Break Free", "One Last Time"]
var arianaAlbums: [String] = ["Dangerous Woman", "Dangerous Woman", "Dangerous Woman", "Dangerous Woman", "thank u, next", "thank u, next", "thank u, next", "Sweetener", "My Everything", "My Everything"]
var arianaAlbumCovers: [UIImage] = [#imageLiteral(resourceName: "Dangerous Woman.jpg"),#imageLiteral(resourceName: "Dangerous Woman.jpg"),#imageLiteral(resourceName: "Dangerous Woman.jpg"),#imageLiteral(resourceName: "Dangerous Woman.jpg"),#imageLiteral(resourceName: "thank u, next.jpg"),#imageLiteral(resourceName: "thank u, next.jpg"),#imageLiteral(resourceName: "thank u, next.jpg"),#imageLiteral(resourceName: "Sweetener.jpg"),#imageLiteral(resourceName: "My Everything.jpg"),#imageLiteral(resourceName: "My Everything.jpg")]

//declares variables that store all of the titles, albums and album covers for the justin bieber campaign
var bieberTitles: [String] = ["Despacito", "I'm The One", "Love Yourself", "No Brainer", "Sorry", "What Do You Mean", "As Long As You Love Me", "Boyfriend", "Beauty And A Beat", "Where Are U Now"]
var bieberAlbums: [String] = ["Despacito", "Grateful", "Purpose", "Father of Asahd", "Purpose", "Purpose", "Believe", "Believe", "Believe", "Where Are U Now"]
var bieberAlbumCovers: [UIImage] = [#imageLiteral(resourceName: "Despacito.jpg"),#imageLiteral(resourceName: "Grateful.jpg"),#imageLiteral(resourceName: "Purpose.jpg"),#imageLiteral(resourceName: "Father of Asahd.jpg"),#imageLiteral(resourceName: "Purpose.jpg"),#imageLiteral(resourceName: "Purpose.jpg"),#imageLiteral(resourceName: "Believe.jpg"),#imageLiteral(resourceName: "Believe.jpg"),#imageLiteral(resourceName: "Believe.jpg"),#imageLiteral(resourceName: "Where Are U Now.jpg")]

//declares variables that store all of the titles, albums and album covers for the weeknd campaign
var weekndTitles: [String] = ["Can't Feel My Face", "Earned It", "I Feel It Coming", "Some Way", "Starboy", "Low Life", "Pray For Me", "Call Out My Name", "Price On My Head", "The Hills"]
var weekndAlbums: [String] = ["Beauty Behind The Madness", "Fifty Shades of Grey", "Starboy", "NAV", "Starboy", "EVOL", "Black Panther", "My Dear Melancholy", "Bad Habits", "Beauty Behind The Madness"]
var weekndAlbumCovers: [UIImage] = [#imageLiteral(resourceName: "Beauty Behind The Madness.jpg"),#imageLiteral(resourceName: "Earned It.jpg"),#imageLiteral(resourceName: "Starboy.jpg"),#imageLiteral(resourceName: "NAV.jpg"),#imageLiteral(resourceName: "Starboy.jpg"),#imageLiteral(resourceName: "EVOL.jpg"),#imageLiteral(resourceName: "Black Panther.jpg"),#imageLiteral(resourceName: "My Dear Melancholy.jpg"),#imageLiteral(resourceName: "Bad Habits.jpg"),#imageLiteral(resourceName: "Beauty Behind The Madness.jpg")]

//declares variables that store all of the titles, albums and album covers for the rihanna campaign
var rihannaTitles: [String] = ["Loyalty", "Needed Me", "This Is What You Came For", "Wild Thoughts", "Work", "Love On The Brain", "Love The Way You Lie", "Only Girl In The World", "Too Good", "We Found Love"]
var rihannaAlbums: [String] = ["DAMN", "Anti", "This Is What You Came For", "Grateful", "Anti", "Anti", "Recovery", "Loud", "Views", "Talk That Talk"]
var rihannaAlbumCovers: [UIImage] = [#imageLiteral(resourceName: "DAMN.jpg"),#imageLiteral(resourceName: "Anti.jpg"),#imageLiteral(resourceName: "This Is What You Came For.jpg"),#imageLiteral(resourceName: "Grateful.jpg"),#imageLiteral(resourceName: "Anti.jpg"),#imageLiteral(resourceName: "Anti.jpg"),#imageLiteral(resourceName: "Recovery.jpg"),#imageLiteral(resourceName: "Loud.jpg"),#imageLiteral(resourceName: "Views.jpg"),#imageLiteral(resourceName: "Talk That Talk.jpg")]

//declares variables that store all of the titles, albums and album covers for the future campaign
var futureTitles: [String] = ["Mask Off", "Used To This", "Low Life", "Wicked", "Where Ya At", "Jumpman", "Diamonds Dancing", "Some More", "When I Think About It", "Fine China"]
var futureAlbums: [String] = ["FUTURE", "FUTURE", "EVOL", "EVOL", "DS2", "What A Time To Be Alive", "What A Time To Be Alive", "Beast Mode 2", "Beast Mode 2", "Wrld on Drugs"]
var futureAlbumCovers: [UIImage] = [#imageLiteral(resourceName: "FUTURE.jpg"),#imageLiteral(resourceName: "FUTURE.jpg"),#imageLiteral(resourceName: "EVOL.jpg"),#imageLiteral(resourceName: "EVOL.jpg"),#imageLiteral(resourceName: "DS2.jpg"),#imageLiteral(resourceName: "What A Time To Be Alive.jpg"),#imageLiteral(resourceName: "What A Time To Be Alive.jpg"),#imageLiteral(resourceName: "Beast Mode 2.jpg"),#imageLiteral(resourceName: "Beast Mode 2.jpg"),#imageLiteral(resourceName: "WRLD On Drugs.jpg")]

//declares variables that store all of the titles, albums and album covers for the nav campaign
var navTitles: [String] = ["Faith", "Champion", "Some Way", "Up", "beibs in the trap", "Price On My Head", "Wanted You", "Freshman List", "Myself", "Mariah"]
var navAlbums: [String] = ["Reckless", "Reckless", "NAV", "NAV", "Birds In The Trap Sing McKnight", "Bad Habits", "Reckless", "Reckless", "NAV", "NAV"]
var navAlbumCovers: [UIImage] = [#imageLiteral(resourceName: "Reckless.jpg"),#imageLiteral(resourceName: "Reckless.jpg"),#imageLiteral(resourceName: "NAV.jpg"),#imageLiteral(resourceName: "NAV.jpg"),#imageLiteral(resourceName: "Birds In The Trap Sing McKnight.jpg"),#imageLiteral(resourceName: "Bad Habits.jpg"),#imageLiteral(resourceName: "Reckless.jpg"),#imageLiteral(resourceName: "Reckless.jpg"),#imageLiteral(resourceName: "NAV.jpg"),#imageLiteral(resourceName: "NAV.jpg")]

//declares variables that store all of the titles, albums and album covers for the travis scott campaign
var travisTitles: [String] = ["Champion", "ZEZE", "Sicko Mode", "Stargazing", "Yosemite", "Antidote", "Goosebumps", "Butterfly Effect", "Pick Up The Phone", "Through The Late Night"]
var travisAlbums: [String] = ["Reckless", "Dying to Live", "Astroworld", "Astroworld", "Astroworld", "Rodeo", "Birds In The Trap Sing McKnight", "Astroworld", "Birds In The Trap Sing McKnight", "Birds In The Trap Sing McKnight"]
var travisAlbumCovers: [UIImage] = [#imageLiteral(resourceName: "Reckless.jpg"),#imageLiteral(resourceName: "Dying to Live.jpg"),#imageLiteral(resourceName: "Astroworld.jpg"),#imageLiteral(resourceName: "Astroworld.jpg"),#imageLiteral(resourceName: "Astroworld.jpg"),#imageLiteral(resourceName: "Rodeo.jpg"),#imageLiteral(resourceName: "Birds In The Trap Sing McKnight.jpg"),#imageLiteral(resourceName: "Astroworld.jpg"),#imageLiteral(resourceName: "Birds In The Trap Sing McKnight.jpg"),#imageLiteral(resourceName: "Birds In The Trap Sing McKnight.jpg")]

//declares variables that store all of the titles, albums and album covers for the rae sremmurd campaign
var sremmTitles: [String] = ["Sunflower", "Unforgettable", "Black Beatles", "No Type", "Throw Sum Mo", "No Flex Zone", "Come Get Her", "This Could Be Us", "Guatemala", "Swang"]
var sremmAlbums: [String] = ["Spider-Man Into The Spider-Verse", "Jungle Rules", "SremmLife 2", "SremmLife", "SremmLife", "SremmLife", "SremmLife", "SremmLife", "SremmLife 3", "SremmLife 2"]
var sremmAlbumCovers: [UIImage] = [#imageLiteral(resourceName: "Spider-Verse.jpg"),#imageLiteral(resourceName: "Jungle Rules.jpg"),#imageLiteral(resourceName: "SremmLife 2.jpg"),#imageLiteral(resourceName: "SremmLife.jpg"),#imageLiteral(resourceName: "SremmLife.jpg"),#imageLiteral(resourceName: "SremmLife.jpg"),#imageLiteral(resourceName: "SremmLife.jpg"),#imageLiteral(resourceName: "SremmLife.jpg"),#imageLiteral(resourceName: "SremmLife 3.jpg"),#imageLiteral(resourceName: "SremmLife 2.jpg")]

//declares variables that store all of the titles, albums and album covers for the migos campaign
var migosTitles: [String] = ["CC", "Motorsport", "Walk It Talk It", "Slippery", "Stir Fry", "Bad and Boujee", "Get Right Witcha", "T-Shirt", "Narcos", "Gang Gang"]
var migosAlbums: [String] = ["Culture II", "Culture II", "Culture II", "Culture", "Culture II", "Culture", "Culture", "Culture", "Culture II", "Culture II"]
var migosAlbumCovers: [UIImage] = [#imageLiteral(resourceName: "Culture II.jpg"),#imageLiteral(resourceName: "Culture II.jpg"),#imageLiteral(resourceName: "Culture II.jpg"),#imageLiteral(resourceName: "Culture.jpg"),#imageLiteral(resourceName: "Culture II.jpg"),#imageLiteral(resourceName: "Culture.jpg"),#imageLiteral(resourceName: "Culture.jpg"),#imageLiteral(resourceName: "Culture.jpg"),#imageLiteral(resourceName: "Culture II.jpg"),#imageLiteral(resourceName: "Culture II.jpg")]
