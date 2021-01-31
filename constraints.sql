-- Генератор команд удаления существующих констрейнтов
-- При необходимости скопировать результаты запроса в отдельный файл и выполнить как скрипт 
SELECT concat('alter table ', table_name, ' drop constraint ', constraint_name, ';') sql_text
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
WHERE constraint_schema = 'vk'
;

ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_fk_user_id FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT communities_users_fk_community_id FOREIGN KEY (community_id) REFERENCES communities(id);

ALTER TABLE contacts
  ADD CONSTRAINT contacts_fk_user_id FOREIGN KEY (user_id) REFERENCES users(id);
  
ALTER TABLE friendship
  ADD CONSTRAINT friendship_fk_user_id FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_fk_friend_id FOREIGN KEY (friend_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_fk_status_id FOREIGN KEY (status_id) REFERENCES friendship_statuses(id);
  
ALTER TABLE likes
  ADD CONSTRAINT likes_fk_user_id FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT likes_fk_target_type_id FOREIGN KEY (target_type_id) REFERENCES target_types(id);
 
ALTER TABLE media
  ADD CONSTRAINT media_fk_user_id FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT media_fk_media_type_id FOREIGN KEY (media_type_id) REFERENCES media_types(id);

ALTER TABLE messages
  ADD CONSTRAINT messages_fk_from_user_id FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_fk_to_user_id FOREIGN KEY (to_user_id) REFERENCES users(id);

ALTER TABLE posts
  ADD CONSTRAINT posts_fk_user_id FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT posts_fk_community_id FOREIGN KEY (community_id) REFERENCES communities(id);

-- При необходимости(ошибка несоответствия типов) поменять тип с INT на UNSIGNED INT
ALTER TABLE profiles MODIFY COLUMN gender_id INT UNSIGNED;

ALTER TABLE profiles
  ADD CONSTRAINT profiles_fk_user_id FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT profiles_fk_gender_id FOREIGN KEY (gender_id) REFERENCES gender(id),
  ADD CONSTRAINT profiles_fk_user_status_id FOREIGN KEY (user_status_id) REFERENCES user_statuses(id);

-- Опционально, внешний ключ на media
ALTER TABLE profiles
  ADD CONSTRAINT profiles_fk_photo_id FOREIGN KEY (photo_id) REFERENCES media(id);
