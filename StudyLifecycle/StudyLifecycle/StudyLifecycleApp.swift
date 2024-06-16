//
//  StudyLifecycleApp.swift
//  StudyLifecycle
//
//  Created by Jaehwi Kim on 6/16/24.
//

import SwiftUI

enum LifecycleType {
    case scenePhase
    case notificationCenter
    case appDelegate
}

@main
struct Main {
    static func main() {
        @State var lifeCycleMethod: LifecycleType = .appDelegate
        switch lifeCycleMethod {
        case .scenePhase:
            ScenePhaseApp.main()
        case .notificationCenter:
            NotificationCenterApp.main()
        case .appDelegate:
            AppDelegateApp.main()
        }
    }
}

struct ScenePhaseApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { _, newScenePhase in
            switch newScenePhase {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                print("background")
            @unknown default:
                print("unknown")
            }
        }
    }
}

struct NotificationCenterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { (_) in
                    // Active 상태
                    print("did become active")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { (_) in
                    // InActive 상태
                    print("will resign active")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { (_) in
                    // Background 상태
                    print("did enter background")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { (_) in
                    // Background -> Foreground 상태
                    print("will enter foreground")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { (_) in
                    // 앱 종료 시
                    print("will terminate")
                }
        }
    }
}

struct AppDelegateApp: App {
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        // Not Running 상태
        // 앱 실행시 최초로 실행할 코드 (ex. firebase configure)
        print("Not Running, will finish launching")
        return true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        // Not Running 상태
        // 초기화 코드
        print("Not Running, did finish launching")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Not Running 상태
        // 앱이 종료되기 직전에 호출
        print("Not Running, will terminate")
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Scene 설정
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Background 상태
        // Scene이 백그라운드로 갈때 iOS는 리소스를 확보하기 위헤 Scene을 삭제할 수 있음
        // 특정 Scene을 Foreground로 가져올때 다시 연결 가능
        print("Background, did disconnect")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Active 상태
        // 앱이 실제로 사용되기 전에 마지막으로 준비할 코드
        print("Active, did become active")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // InActive 상태
        // 앱 스위처 모드, 전화 왔을때 (ex. 음악을 듣고 있는데 전화가 옴 -> 여기서 음악을 정지)
        print("InActive, will resign active")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // InActive 상태
        // Background나 Not Running에서 Foreground로 들어가기 직전에 호출
        print("Active, will enter foreground")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Background 상태
        // Foreground에서 Background로 갈때 호출
        // user data저장 -> 앱이 종료(deallocated from RAM) 되는 시점을 예측할 수 없기 때문
        print("Background, did enter background")
    }
}
