set schema 'device';
INSERT INTO "wake_word" ("id", "setting_name", "display_name", "account_id", "engine", "insert_ts")
VALUES (public.gen_random_uuid(), 'hey mycroft', 'Hey Mycroft', NULL, 'precise', now());
INSERT INTO "wake_word" ("id", "setting_name", "display_name", "account_id", "engine", "insert_ts")
VALUES (public.gen_random_uuid(), 'hey jarvis', 'Hey Jarvis', NULL, 'pocketsphinx', now());
INSERT INTO "wake_word" ("id", "setting_name", "display_name", "account_id", "engine", "insert_ts")
VALUES (public.gen_random_uuid(), 'christopher', 'Christopher', NULL, 'precise', now());
INSERT INTO "wake_word" ("id", "setting_name", "display_name", "account_id", "engine", "insert_ts")
VALUES (public.gen_random_uuid(), 'computer', 'Computer', NULL, 'precise', now());
