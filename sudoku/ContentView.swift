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
            ForEach(grid.grid.indices,id:\.self){row in
                HStack{
                    ForEach(grid.grid[row].indices,id:\.self){col in
                        Text("\(grid.historyGrid[grid.now][row][col])")
                            .font(.body)
                            .frame(width: 10, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(10)
                            .background(Color.blue)
                    }
                }
            }
        }.onAppear(perform: {
            grid.fillGrid(grid: &grid.grid)
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
