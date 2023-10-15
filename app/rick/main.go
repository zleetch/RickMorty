package main

import (
	"net/http"
	"os"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {

	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/rick", func(c echo.Context) error {
		return c.HTML(http.StatusOK, "Hello i'm Rick")
	})

	httpPort := os.Getenv("PORT")
	if httpPort == "" {
		httpPort = "8001"
	}

	e.Logger.Fatal(e.Start(":" + httpPort))
}