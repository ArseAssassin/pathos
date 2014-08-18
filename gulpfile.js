var gulp        = require("gulp")
var clean       = require("gulp-rimraf");

var coffee      = require("gulp-coffee");

paths = {
  test:   "./test/",
  lib:    "./lib/",
  src:    "./src/"
}

gulp.task("default", ["build"])

gulp.task("clean", function() {
  return gulp.src(paths.lib, {read: false})
    .pipe(clean({bare: true}))
})

gulp.task("build", ["clean"], function() {
  return gulp.src(paths.src + "**/*.coffee")
    .pipe(coffee({bare: true}))
    .pipe(gulp.dest(paths.lib))
})

