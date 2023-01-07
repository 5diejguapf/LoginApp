//
//  User.swift
//  LoginApp
//
//  Created by serg on 7.01.2023.
//

import Foundation


struct User {
    let userLogin: String
    let userPassword: String
    let githubUsername: String
    let userInfo: UserInfo
    let userRepos: [Repo]
    
    static func getUser() -> Self {
        let gitUser = "5diejguapf"
        let user = User(
            userLogin: "URS1",
            userPassword: "1234",
            githubUsername: gitUser,
            userInfo: UserInfo(
                name: "S",
                surname: "S",
                birthDay: 1,
                descripiton: """
                Hello! My name is S. This is long text from internet.
                First and foremost, the people you’re meeting want to know who you are.
                Share your name, department, role, and any applicable background information.
                In smaller group settings, you can even take your introduction to the next
                step and share some fun facts, an unpopular opinion, or recommend a favorite
                movie or restaurant. Bringing these things into the conversation can help
                stimulate conversations with your new coworkers down the line.
                """,
                imageUrl: "https://avatars.githubusercontent.com/u/121379398?v=4"
            ),
            userRepos: self.getRepos(username: gitUser)
        )
        return user
    }
    
    private static func getRepos(username: String) -> [Repo] {
        // DONE: get gh repos
        // https://api.github.com/users/USERNAME/repos
        /*
          [
            {
                "name": "ColorPipet",
                "full_name": "5diejguapf/ColorPipet",
                "html_url": "https://github.com/5diejguapf/ColorPipet",
                ...
            },
            ...
          ]
         */
        var repos: [Repo] = []
        let url = URL(string: "https://api.github.com/users/\(username)/repos")
        let semaphore = DispatchSemaphore(value: 0)
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]]
                if let reposJson = json {
                    for repoJson in reposJson {
                        if let name = repoJson["name"] as? String, let repoUrl = repoJson["html_url"] as? String {
                            repos.append(Repo(url: repoUrl, name: name))
                            print("repo: \(repoUrl) - \(name)")
                        }
                    }
                    semaphore.signal()
                }
            } catch {
                print(error)
            }
        })
        dataTask.resume()
        semaphore.wait()
        print(repos)
        return repos
    }
}

struct UserInfo {
    let name: String
    let surname: String
    let birthDay: Int
    let descripiton: String
    let imageUrl: String
}

struct Repo {
    let url: String
    let name: String
}
