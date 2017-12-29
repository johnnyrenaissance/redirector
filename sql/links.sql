CREATE TABLE links
(
  id   INT AUTO_INCREMENT
    PRIMARY KEY,
  code TEXT            NOT NULL,
  link TEXT            NOT NULL,
  hits INT DEFAULT '0' NOT NULL
)
  ENGINE = InnoDB;

