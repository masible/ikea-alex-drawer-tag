all: ikea-alex-drawer-tag-63.5x33.9.stl images/render.png

ikea-alex-drawer-tag-63.5x33.9.stl: ikea-alex-drawer-tag.scad material-cutter.scad
	echo "use <ikea-alex-drawer-tag.scad> label(63.5, 33.9);" | openscad -o $@ -

images/render.png: ikea-alex-drawer-tag.scad material-cutter.scad
	mkdir -p images/
	echo "use <ikea-alex-drawer-tag.scad> label(63.5, 33.9);" | openscad -o $@ -

clean:
	rm -f ikea-alex-drawer-tag-63.5x33.9.stl images/render.png
	if [ -d images ] ; then rmdir --ignore-fail-on-non-empty images/ ; fi
