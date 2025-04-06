CREATE TABLE Users (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) UNIQUE NOT NULL,
  first_name VARCHAR(20) NOT NULL,
  surname VARCHAR(20) NOT NULL,
  date_of_birth DATE,
  email VARCHAR(50) UNIQUE NOT NULL,
  password_hash VARCHAR(100) NOT NULL,
  bio VARCHAR(160),
  profile_picture_url VARCHAR(255),
  location VARCHAR(50),
  website VARCHAR(255),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Tweets (
  tweet_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  content VARCHAR(280) NOT NULL,
  likes_count INT DEFAULT 0,
  retweets_count INT DEFAULT 0,
  comments_count INT DEFAULT 0,
  views INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Advertisements (
  ad_id INT PRIMARY KEY AUTO_INCREMENT,
  advertiser_id INT NOT NULL, -- Renommé pour clarifier
  tweet_id INT NOT NULL,
  budget DECIMAL(10,2) CHECK (budget >= 0),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (advertiser_id) REFERENCES Users(user_id),
  FOREIGN KEY (tweet_id) REFERENCES Tweets(tweet_id)
);

CREATE TABLE Reports (
  report_id INT PRIMARY KEY AUTO_INCREMENT,
  reporter_id INT NOT NULL,
  reported_user_id INT,
  reported_tweet_id INT,
  reason TEXT NOT NULL,
  status ENUM('en attente', 'validé', 'rejeté') DEFAULT 'en attente',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (reporter_id) REFERENCES Users(user_id),
  FOREIGN KEY (reported_user_id) REFERENCES Users(user_id),
  FOREIGN KEY (reported_tweet_id) REFERENCES Tweets(tweet_id)
);

