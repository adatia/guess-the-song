//
//  MultiplayerInformation.swift
//  guess-the-song
//
//  Created by Shayn Adatia on 2019-06-03.
//

import Foundation
import UIKit

var mPlayer1Score = 0
var mPlayer1Lives = 6
var mPlayer1Vinyls = 0
var mPlayer1Name = ""

var mPlayer2Score = 0
var mPlayer2Lives = 6
var mPlayer2Vinyls = 0
var mPlayer2Name = ""

var mVinylCrown = false
var mPlayerTurn = 2

var isStartupFinished = false

var mBackup1: [String] = []
var mBackup2: [String] = []
var mBackup3: [String] = []
var mBackup4: [UIImage] = []

var mFirstLoad = false
