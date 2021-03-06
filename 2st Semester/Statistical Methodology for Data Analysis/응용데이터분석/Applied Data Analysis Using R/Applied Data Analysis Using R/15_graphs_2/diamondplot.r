diamondplot.1 <- function (x, bg = gray(0.6), col = rainbow, name = "", ...) 
{
    if (!is.data.frame(x)) 
        stop("Argument has to be a data frame")
    opar <- par(no.readonly = TRUE)
    par(bg = bg)
    prop <- 0.8
    scale <- 5
    deg2rad <- function(alfa) {
        (alfa * pi)/180
    }
    normalizza <- function(x) {
        x/max(x)
    }
    coord <- function(x, prop = 17) {
        n <- length(x)
        alfa <- rep(NA, n)
        for (i in 1:n) {
            alfa[i] <- 360/n * i
        }
        c.x <- sin(deg2rad(alfa)) * x * prop
        c.y <- cos(deg2rad(alfa)) * x * prop
        list(x = c.x, y = c.y)
    }
    segmenti <- function(n, prop = 1, labels = NULL, scale = 5) {
        plot(0, 0, axes = FALSE, xlab = "", ylab = "", main = name, 
            ...)
        for (i in 1:n) {
            alfa <- 360/n * i
            x1 <- c(0, sin(deg2rad(alfa)) * prop)
            y1 <- c(0, cos(deg2rad(alfa)) * prop)
            polygon(x1, y1, lwd=1)
            text(sin(deg2rad(alfa)), cos(deg2rad(alfa)), labels[i], 
                cex = 0.8)
        }
        for (i in 1:n) {
            alfa <- 360/n * i
            for (j in 1:scale) {
                xa <- (sin(deg2rad(alfa)) * (1/scale) * j * prop)
                ya <- (cos(deg2rad(alfa)) * (1/scale) * j * prop)
                points(xa, ya, pch = 21)
                et <- round((1/scale) * j * 17)
                text(sin(deg2rad(0)) + 0.1, cos(deg2rad(0)) * 
                  (1/scale) * j * prop, et, cex = 0.8)
            }
        }
    }
    n <- dim(x)[[1]]
    k <- dim(x)[[2]]
    segmenti(n, prop = prop, labels = rownames(x))
    for (j in 1:k) {
        polygon(coord(normalizza(x[, j]), prop = prop), lty = 1, 
            border = col(k)[j], lwd=2)
    }
    legend(-1.1, 1.1, legend = dimnames(x)[[2]], lty = 1, 
        col = col(k), cex = 0.8, lwd=2)
    par(opar)
}


