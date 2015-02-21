---
title: "MTcars Data set"
output: html_document
---



```{r}

```


```{r, echo=FALSE}
plot(mtcars$hp, mtcars$mpg, xlab="HorsePower", ylab="Miles Per Gallon", main="Relationship between Miles Per Gallon and Horsepower")
abline(lm(mtcars$mpg~mtcars$hp))
boxplot(mtcars$mpg~mtcars$cyl, xlab="Cylinders", ylab="Miles Per Gallon", main="Miles Per Gallon by Cylinder")
```

