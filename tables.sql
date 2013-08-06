USE brightsign;

DROP TABLE IF EXISTS heartbeats;
CREATE TABLE heartbeats (
  snum     varchar(255) NOT NULL,
  int_ip   varchar(255) NOT NULL,
  ext_ip   varchar(255) NOT NULL,
  version  varchar(255) NOT NULL,
  fw       varchar(255) NOT NULL,
  ts       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY  (snum)
) ENGINE=InnoDB;