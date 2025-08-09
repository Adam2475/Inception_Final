DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

build:
	mkdir -p ~/adapassa/data/db_data
	mkdir -p ~/adapassa/data/wp_files
	@docker compose -f $(DOCKER_COMPOSE_FILE) up --build -d
kill:
	@docker compose -f $(DOCKER_COMPOSE_FILE) kill
down:
	@docker compose -f $(DOCKER_COMPOSE_FILE) down
clean:
	@docker compose -f $(DOCKER_COMPOSE_FILE) down -v

fclean: clean
	rm -r ~/adapassa/data/db_data
	rm -r ~/adapassa/data/wp_files
	docker system prune -a -f

restart: clean build

.PHONY: kill build down clean restart