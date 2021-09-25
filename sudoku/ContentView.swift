//
//  ContentView.swift
//  sudoku
//
//  Created by ธนัท แสงเพิ่ม on 15/9/2564 BE.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var grid = Grid()
    
    var body: some View {
        VStack{
            Spacer()
            ForEach(grid.grid.indices,id:\.self){row in
                HStack{
                    ForEach(grid.grid[row].indices,id:\.self){col in
                        if grid.historyGrid[grid.now][row][col] == 0{
                            Button {
                                grid.select = row * 9 + col
                            } label:{
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: 30, height: 30)
                            }
                        }else{
                            Text("\(grid.historyGrid[grid.now][row][col])")
                                .font(.body)
                                .frame(width: 30, height: 30, alignment: .center)
                                .background(Color.blue)
                        }
                    }
                }
            }
            Spacer()
            HStack{
                if grid.now > 2{
                    Button {
                        grid.undoFill()
                    } label:{
                        Text("undo")
                            .font(.body)
                            .frame(width: 60, height: 30, alignment: .center)
                            .background(Color.orange)
                    }
                }
                Spacer()
                if grid.select < 81{
                    ForEach((1...9), id: \.self){num in
                        if grid.checkfill(grid: grid.historyGrid[grid.now], value: num, row: grid.select/9, col: grid.select%9){
                            Button {
                                grid.placeNum(num: num)
                            } label:{
                                Text("\(num)")
                                    .font(.body)
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .background(Color.gray)
                            }
                        }
                    }
                }
            }
        }.onAppear(perform: {
            grid.fillGrid(grid: &grid.grid)
            grid.historyGrid.append(grid.grid)
            grid.now += 1
            grid.removeGrid(grid: &grid.grid)
            grid.historyGrid.append(grid.grid)
            grid.now += 1
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
