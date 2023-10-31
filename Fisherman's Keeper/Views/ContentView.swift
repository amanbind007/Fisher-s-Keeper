//
//  ContentView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var searchText: String = ""

    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var fishbase = FishbaseSearch()
    @State private var scrollViewID = UUID()

    private let adaptiveColumn = [
        GridItem()
    ]

    var body: some View {
        TabView {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: adaptiveColumn, content: {
                        ForEach(fishbase.fishes, id: \.scientificName) { fish in
                            NavigationLink {
                                WebView(url: URL(string: fish.articleURL)!)
                                    .navigationTitle(fish.scientificName)

                            } label: {
                                FishCardView(fish: fish)
                                    .padding(.horizontal)

                            }.buttonStyle(.plain)
                        }

                        if fishbase.pageNumberStart < fishbase.pageNumberStop {
                            Color.clear
                                .onAppear {
                                    fishbase.getMoreFish(searchText)
                                }

                        } else {
                            Text("No More Results")
                                .font(.headline)
                                .foregroundStyle(Color.white)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 30)
                                        .background(Material.regular)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 35))
                        }

                    })
                }
                .id(self.scrollViewID)
                .background {
                    let darkBackground = Image("DarkBackground", bundle: Bundle(path: "Assets"))
                        .resizable()
                        .ignoresSafeArea()
                    let lightBackground = Image("LightBackground", bundle: Bundle(path: "Assets"))
                        .resizable()
                        .ignoresSafeArea()

                    colorScheme == .dark ? darkBackground : lightBackground
                }
                .navigationTitle("Search Fish")
            }
            .searchable(text: $searchText, prompt: Text("Enter Fish Name"))
            .onSubmit(of: .search) {
                scrollViewID = UUID()
                fishbase.getFish(searchText)
            }
            .onAppear(perform: {
                fishbase.getFish(searchText)
            })
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search Fish")
            }

            NavigationStack {
                MyFishListView()
            }
            .tabItem {
                Image(systemName: "fish")
                Text("My Fish List")
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.colorScheme, .light)
}
