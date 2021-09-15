//
//  tableGrid.swift
//  sudoku
//
//  Created by ธนัท แสงเพิ่ม on 15/9/2564 BE.
//

import Foundation

var grid = [[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]

// print(grid)

var numLs = Array(1...9).shuffled()

func checkGrid(grid:[[Int]]) -> Bool{
  for i in (0..<9){
    for j in (0..<9){
      if grid[i][j] == 0{
        return false
      }
    }
  }
  return true
}

func fillGrid(grid:inout [[Int]]) -> Bool{
  for i in 0..<81{
    let row:Int = i/9
    let col:Int = i%9
    if grid[row][col] == 0{
      numLs = numLs.shuffled()
      for value in numLs{
        if !(grid[row].contains(value)){
          if !([grid[0][col],grid[1][col],grid[2][col],grid[3][col],grid[4][col],grid[5][col],grid[6][col],grid[7][col],grid[8][col]].contains(value)){
            let gridRow = (row/3)*3
            let gridCol = (col/3)*3
            let square = [grid[gridRow][gridCol],grid[gridRow][gridCol+1],grid[gridRow][gridCol+2],
            grid[gridRow+1][gridCol],grid[gridRow+1][gridCol+1],grid[gridRow+1][gridCol+2],
            grid[gridRow+2][gridCol],grid[gridRow+2][gridCol+1],grid[gridRow+2][gridCol+2]]
            if !(square.contains(value)){
              grid[row][col]=value
              if checkGrid(grid:grid){
                return true
              }else{
                if fillGrid(grid:&grid){
                  return true
                }
              }
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

if fillGrid(grid:&grid){
  print("yeh")
  print(grid)
  print("end")
}

