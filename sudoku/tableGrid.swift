//
//  tableGrid.swift
//  sudoku
//
//  Created by ธนัท แสงเพิ่ม on 15/9/2564 BE.
//

import Foundation


class Grid:ObservableObject{
    
    var grid =
    [[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]

    @Published var historyGrid = [[[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]]
    
    @Published var now = 0
    
    var counter = 1
    
    @Published var select = 82

    func checkWin(grid:[[Int]]) -> Bool{
      for i in (0..<9){
        for j in (0..<9){
          if grid[i][j] == 0{
            return false
          }
        }
      }
      return true
    }

    func checkfill(grid:[[Int]],value:Int,row:Int,col:Int) -> Bool{
      if !(grid[row].contains(value)){
        if !([grid[0][col],grid[1][col],grid[2][col],grid[3][col],grid[4][col],grid[5][col],grid[6][col],grid[7][col],grid[8][col]].contains(value)){
          let gridRow = (row/3)*3
          let gridCol = (col/3)*3
          let square = [grid[gridRow][gridCol],grid[gridRow][gridCol+1],grid[gridRow][gridCol+2],
          grid[gridRow+1][gridCol],grid[gridRow+1][gridCol+1],grid[gridRow+1][gridCol+2],
          grid[gridRow+2][gridCol],grid[gridRow+2][gridCol+1],grid[gridRow+2][gridCol+2]]
          if !(square.contains(value)){
            return true
          }
        }
      }
      return false
    }

    func fillGrid(grid:inout [[Int]]) -> Bool{
      for i in 0..<81{
        let row:Int = i/9
        let col:Int = i%9
        if grid[row][col] == 0{
          for value in Array(1...9).shuffled(){
            if checkfill(grid:grid,value:value,row:row,col:col){
               grid[row][col] = value
              if checkWin(grid:grid){
                return true
              }else{
                if fillGrid(grid:&grid){
                  return true
                }
              }
            }
          }
          grid[row][col] = 0
          break
        }
      }
      return false
    }

    func solvGrid(grid:inout [[Int]]) -> Bool{
      for i in 0..<81{
        let row:Int = i/9
        let col:Int = i%9
        if grid[row][col] == 0{
          for value in 1...9{
            if checkfill(grid:grid,value:value,row:row,col:col){
               grid[row][col] = value
              if checkWin(grid:grid){
                counter += 1
                break
              }else{
                if solvGrid(grid:&grid){
                  return true
                }
              }
            }
          }
          grid[row][col] = 0
          break
        }
      }
      return false
    }

    func removeGrid(grid:inout [[Int]]){
      var attempt = 2
      counter = 1
      while attempt > 0{
        var row = Int.random(in: 0...8)
        var col = Int.random(in: 0...8)
        while grid[row][col] == 0 {
          row = Int.random(in: 0...8)
          col = Int.random(in: 0...8)
        }
        let backupValue = grid[row][col]
        grid[row][col] = 0
        counter = 0
        solvGrid(grid:&grid)
        if counter != 1{
          grid[row][col] = backupValue
          attempt -= 1
        }
      }
    }

    func placeNum(num:Int){
        grid = historyGrid[now]
        grid[select/9][select%9] = num
        historyGrid.append(grid)
        now += 1
        select = 82
    }
    
    func undoFill(){
        historyGrid = Array(historyGrid[0...now-1])
        now -= 1
    }
    
    func printGrid(grid:[[Int]]){
      print("-------------------------------------")
      for i in 0..<grid.count{
        print("| \(grid[i][0]) | \(grid[i][1]) | \(grid[i][2]) | \(grid[i][3]) | \(grid[i][4]) | \(grid[i][5]) | \(grid[i][6]) | \(grid[i][7]) | \(grid[i][8]) |")
          print("-------------------------------------")
      }
    }

    //fillGrid(grid:&grid)
    //printGrid(grid:grid)
    //// var backupgrid = grid
    //removeGrid(grid:&grid)
    //printGrid(grid:grid)
}
