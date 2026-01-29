.PHONY: help install setup dev queue vite npm-build migrate migrate-fresh seed fresh rollback test test-coverage pint format check cache-clear optimize optimize-clear clean clean-all up upd down restart shell sail-install tinker key-generate link

# Default target
.DEFAULT_GOAL := help

## Help command
help: ## Mutasd a segítséget
	@echo "Elérhető parancsok:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

## Telepítés és beállítás
install: ## Composer és npm csomagok telepítése
	./vendor/bin/sail composer install
	./vendor/bin/sail install

setup: ## Projekt első indítása (env, key, migrate, build)
	./vendor/bin/sail composer run-script setup

## Fejlesztés
dev: ## Fejlesztői környezet indítása (server, queue, pail, vite)
	./vendor/bin/sail composer run-script dev

queue: ## Queue worker indítása
	./vendor/bin/sail artisan queue:work

vite: ## Vite dev server indítása
	./vendor/bin/sail npm run dev

npm-build: ## Frontend assets build
	./vendor/bin/sail npm run build

## Adatbázis
migrate: ## Migrációk futtatása
	./vendor/bin/sail artisan migrate

migrate-fresh: ## Adatbázis törlése és újra migrálás
	 ./vendor/bin/sail migrate:fresh

seed: ## Seederek futtatása
	./vendor/bin/sail artisan db:seed

fresh: ## Adatbázis törlése, migrálás és seed
	./vendor/bin/sail artisan migrate:fresh --seed

rollback: ## Utolsó migráció visszavonása
	./vendor/bin/sail artisan migrate:rollback

## Tesztelés
test: ## PHPUnit tesztek futtatása
	./vendor/bin/sail composer run-script test

test-coverage: ## Tesztek futtatása coverage-dzsel
	./vendor/bin/sail artisan test --coverage

## Kód formázás és minőség
pint: ## Laravel Pint code formatter futtatása
	./vendor/bin/pint

format: pint ## Alias a pint-hez

check: ## Kód ellenőrzése Pint-tel (dry run)
	./vendor/bin/pint --test

## Cache kezelés
cache-clear: ## Összes cache törlése
	./vendor/bin/sail artisan cache:clear
	./vendor/bin/sail artisan config:clear
	./vendor/bin/sail artisan route:clear
	./vendor/bin/sail artisan view:clear

optimize: ## Alkalmazás optimalizálása
	./vendor/bin/sail artisan config:cache
	./vendor/bin/sail artisan route:cache
	./vendor/bin/sail artisan view:cache

optimize-clear: cache-clear ## Cache-ek törlése

## Tisztítás
clean: ## Temp fájlok és cache-ek törlése
	./vendor/bin/sail artisan cache:clear
	./vendor/bin/sail artisan config:clear
	./vendor/bin/sail artisan route:clear
	./vendor/bin/sail artisan view:clear
	rm -rf bootstrap/cache/*.php
	rm -rf storage/framework/cache/*
	rm -rf storage/framework/sessions/*
	rm -rf storage/framework/views/*
	rm -rf storage/logs/*.log

clean-all: clean ## Minden generált fájl törlése (vendor, node_modules is)
	rm -rf vendor
	rm -rf node_modules
	rm -rf public/build

## Laravel Sail (Docker)
up: ## Docker konténerek indítása
	./vendor/bin/sail up

## Laravel Sail (Docker)
upd: ## Docker konténerek indítása démon módban
	./vendor/bin/sail up -d

down: ## Docker konténerek leállítása
	./vendor/bin/sail down

restart: ## Docker konténerek újraindítása
	./vendor/bin/sail restart

shell: ## Bash shell a Docker konténerben
	./vendor/bin/sail shell

sail-install: ## Sail telepítése
	./vendor/bin/sail artisan sail:install

## Utility
tinker: ## Laravel Tinker REPL
	./vendor/bin/sail artisan tinker

key-generate: ## Új alkalmazás kulcs generálása
	./vendor/bin/sail artisan key:generate

link: ## Storage link létrehozása
	./vendor/bin/sail artisan storage:link
