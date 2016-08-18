import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {

    // MARK: - Variables
    private var pageViewController: UIPageViewController?

    // Initialize it right away here
    private let contentImages = ["music1",
                                 "music2",
                                 "music3",
                                 "music4",
                                 "music5",
                                 "music6",
                                 "music7",
                                 "music8",
                                 "music9",
                                 "music10",
                                 "music11",
                                 "music12",
                                 "music13",
                                 "music14",
                                 "music15",
                                 "music16",
                                 "music17",
                                 "music18",
                                 "music19",
                                 "music20",
                                 "music21",
                                 "music22",
                                 "music23",
                                 "music24",
                                 "music25",
                                 "music26",
                                 "music27",
                                 "music28",
                                 "music29",
                                 "music30",
                                 "music31",
                                 "music32",
                                 "music33",
                                 "music34",
                                 "music35",
                                 "music36",
                                 "music37",
                                 "music38",
                                 "music39"]

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        setupPageControl()
    }

    
    private func createPageViewController() {

        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self

        if contentImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }

        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }

    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }

    // MARK: - UIPageViewControllerDataSource

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

        let itemController = viewController as! PageItemController

        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }

        return nil
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {

        let itemController = viewController as! PageItemController

        if itemController.itemIndex+1 < contentImages.count {
            return getItemController(itemController.itemIndex+1)
        }

        return nil
    }

    private func getItemController(itemIndex: Int) -> PageItemController? {

        if itemIndex < contentImages.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! PageItemController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = contentImages[itemIndex]
            return pageItemController
        }

        return nil
    }

    // MARK: - Page Indicator

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return contentImages.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

    // MARK: - Additions

    func currentControllerIndex() -> Int {

        let pageItemController = self.currentController()

        if let controller = pageItemController as? PageItemController {
            return controller.itemIndex
        }

        return -1
    }

    func currentController() -> UIViewController? {

        if self.pageViewController?.viewControllers?.count > 0 {
            return self.pageViewController?.viewControllers![0]
        }

        return nil
    }

}
