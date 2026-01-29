.PHONY: help install setup dev test clean migrate seed fresh optimize cache-clear serve queue logs pint format check build up down restart shell

# Default target
.DEFAULT_GOAL := help

## Help command
help: ## Mutasd a segítséget
	@echo "Elérhető parancsok:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

## Telepítés és beállítás
install: ## Composer és npm csomagok telepítése
	composer install
	npm install

setup: ## Projekt első indítása (env, key, migrate, build)
	composer run-script setup

## Fejlesztés
dev: ## Fejlesztői környezet indítása (server, queue, pail, vite)
	composer run-script dev

serve: ## Laravel szerver indítása
	php artisan serve

queue: ## Queue worker indítása
	php artisan queue:work

logs: ## Pail log viewer indítása
	php artisan pail

vite: ## Vite dev server indítása
	npm run dev

build: ## Frontend assets build
	npm run build

## Adatbázis
migrate: ## Migrációk futtatása
	php artisan migrate

migrate-fresh: ## Adatbázis törlése és újra migrálás
	php artisan migrate:fresh

seed: ## Seederek futtatása
	php artisan db:seed

fresh: ## Adatbázis törlése, migrálás és seed
	php artisan migrate:fresh --seed

rollback: ## Utolsó migráció visszavonása
	php artisan migrate:rollback

## Tesztelés
test: ## PHPUnit tesztek futtatása
	composer run-script test

test-coverage: ## Tesztek futtatása coverage-dzsel
	php artisan test --coverage

## Kód formázás és minőség
pint: ## Laravel Pint code formatter futtatása
	./vendor/bin/pint

format: pint ## Alias a pint-hez

check: ## Kód ellenőrzése Pint-tel (dry run)
	./vendor/bin/pint --test

## Cache kezelés
cache-clear: ## Összes cache törlése
	php artisan cache:clear
	php artisan config:clear
	php artisan route:clear
	php artisan view:clear

optimize: ## Alkalmazás optimalizálása
	php artisan config:cache
	php artisan route:cache
	php artisan view:cache

optimize-clear: cache-clear ## Cache-ek törlése

## Tisztítás
clean: ## Temp fájlok és cache-ek törlése
	php artisan cache:clear
	php artisan config:clear
	php artisan route:clear
	php artisan view:clear
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
	./vendor/bin/sail up -d

down: ## Docker konténerek leállítása
	./vendor/bin/sail down

restart: ## Docker konténerek újraindítása
	./vendor/bin/sail restart

shell: ## Bash shell a Docker konténerben
	./vendor/bin/sail shell

sail-install: ## Sail telepítése
	php artisan sail:install

## Utility
tinker: ## Laravel Tinker REPL
	php artisan tinker

key-generate: ## Új alkalmazás kulcs generálása
	php artisan key:generate

link: ## Storage link létrehozása
	php artisan storage:link
