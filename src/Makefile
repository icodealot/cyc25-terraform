.PHONY: build run

build:
	docker build -f ./app/backend/Dockerfile -t cyc-backend:latest .

run:
	docker run -p 8080:8000 --rm cyc-backend:latest