# NewsReaderApp

NewsListView - NewsReaderApp
NewsListView is a SwiftUI component designed to display a list of news articles fetched from a public news API. It allows users to filter articles by category and navigate to detailed views of individual articles.

Features
Category Selection: Users can select from predefined categories such as General, Business, Technology, Sports, and Health to filter the news.
Asynchronous Data Fetching: The news articles are fetched asynchronously from an API, with dynamic updates as users switch categories.
List of Articles: Displays a list of articles with an image thumbnail, title, and description.
Navigation: Provides navigation to a detailed view for each news article.
State Management: Uses @ObservedObject to manage state and handle data fetching with Combine and SwiftUI.

ArticleDetailView - NewsReaderApp
ArticleDetailView is a SwiftUI component designed to display the details of a selected news article. This view provides more information about the article and allows the user to either read the full article via an external link or bookmark it for later reference.

Features
Article Detail View: Displays the full article image, title, and description.
Read Full Article: Allows the user to open the full article in a browser.
Bookmark Article: Provides functionality to bookmark the article for future reference using the app's bookmarking system.
Dynamic Content Loading: Uses a custom AsyncImageView to load article images asynchronously.

BookmarksView - NewsReaderApp
BookmarksView is a SwiftUI component in the NewsReaderApp designed to display a list of bookmarked news articles. Users can navigate to the details of a specific bookmarked article, manage (delete) their bookmarks, and toggle between viewing and editing modes.

Features
Display Bookmarked Articles: Shows a list of articles that the user has previously bookmarked.
Navigate to Article Details: Allows users to view detailed information for each bookmarked article.
Delete Bookmarks: Enables users to remove articles from their bookmarks using swipe-to-delete functionality.
Edit Mode: Includes an edit button to toggle between view and edit mode for deleting bookmarks.

NewsAPIService - NewsReaderApp
NewsAPIService is a singleton class responsible for handling API requests and fetching data from the news API. It provides a generic method to perform network requests and decode the responses into Swift models.

Features
Singleton Instance: Provides a single shared instance to ensure consistent usage across the application.
Generic Data Fetching: Handles network requests and decodes JSON responses into Swift types conforming to the Decodable protocol.
Error Handling: Provides error handling for invalid URLs, network errors, and decoding failures.

NewsViewModel - NewsReaderApp
NewsViewModel is an observable object used to manage and provide news data to the user interface. It interacts with the NewsAPIService to fetch news articles and CoreDataManager to manage bookmarked articles. It handles fetching, bookmarking, and updating news articles and bookmarks.

Features
ObservableObject: Conforms to ObservableObject, allowing SwiftUI views to observe changes.
Published Properties: Provides published properties for news articles, bookmarked articles, and the current category.
Networking: Fetches news articles from a remote API based on the selected category.
Bookmark Management: Manages the addition and removal of bookmarked articles using Core Data.

CoreDataManager - NewsReaderApp
CoreDataManager is a singleton class responsible for managing Core Data operations related to bookmarked articles. It handles saving, fetching, and deleting articles in Core Data.



