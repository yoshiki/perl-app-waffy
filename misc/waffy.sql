DROP TABLE IF EXISTS timeline;
CREATE TABLE timeline (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  service TEXT NOT NULL,
  screen_name TEXT,
  name TEXT,
  text TEXT NOT NULL,
  status_id TEXT NOT NULL,
  in_reply_to_status_id INTEGER,
  in_reply_to_screen_name TEXT,
  created_at DATETIME NOT NULL
);

DROP INDEX IF EXISTS timeline_screen_name;
CREATE INDEX timeline_screen_name ON timeline (screen_name);

DROP INDEX IF EXISTS timeline_created_at;
CREATE INDEX timeline_created_at ON timeline (created_at);

DROP INDEX IF EXISTS timeline_status_id;
CREATE UNIQUE INDEX timeline_status_id ON timeline (status_id);

DROP TABLE IF EXISTS period;
CREATE TABLE period (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  service TEXT NOT NULL,
  last_crawled_at DATETIME NOT NULL
);

