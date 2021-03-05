#' Retreive a U.S. state composite map, optionally with a projection, as a simplefeature
#'
#' The \code{proj} parameter is intende to simplify usage for those using base
#' plotting. If anything but \code{longlat} is specified the composite map
#' will be pre-projected to those
#'
#' This is what's the object looks like:
#'
#' \preformatted{
#' Observations: 51
#' Variables: 14
#' $ geo_id              <fctr> 0400000US04, 0400000US05, 0400000US06, 0400000US08, 0400...
#' $ fips_state          <fctr> 04, 05, 06, 08, 09, 11, 13, 17, 18, 22, 27, 28, 30, 35, ...
#' $ name                <fctr> Arizona, Arkansas, California, Colorado, Connecticut, Di...
#' $ lsad                <fctr> , , , , , , , , , , , , , , , , , , , , , , , , , , , , ,
#' $ census_area         <dbl> 113594.084, 52035.477, 155779.220, 103641.888, 4842.355, ...
#' $ iso_3166_2          <fctr> AZ, AR, CA, CO, CT, DC, GA, IL, IN, LA, MN, MS, MT, NM, ...
#' $ census              <int> 6392017, 2915918, 37253956, 5029196, 3574097, 601723, 968...
#' $ pop_estimataes_base <int> 6392310, 2915958, 37254503, 5029324, 3574096, 601767, 968...
#' $ pop_2010            <int> 6411999, 2922297, 37336011, 5048575, 3579345, 605210, 971...
#' $ pop_2011            <int> 6472867, 2938430, 37701901, 5119661, 3590537, 620427, 981...
#' $ pop_2012            <int> 6556236, 2949300, 38062780, 5191709, 3594362, 635040, 991...
#' $ pop_2013            <int> 6634997, 2958765, 38431393, 5272086, 3599341, 649111, 999...
#' $ pop_2014            <int> 6731484, 2966369, 38802500, 5355866, 3596677, 658893, 100...
#' $ geometry            <list> [-112.53859, -112.53454, -112.36895, -112.35769, -111.41...#' }
#'
#' A reference GeoJSON file is provided in the following location (i.e. you can use
#' it in any mapping program):
#'
#' \preformatted{
#' system.file("extdata/composite_us_states.geojson.gz", package="albersusa")
#' }
#'
#' @param proj if anything but \code{longlat} is specified, the shapefile will
#'        be pre-projected before being returned
#' @export
#' @examples
#' library(sf)
#'
#' plot(usa_sf()) # these take a while to render
#' plot(usa_sf("laea"))
usa_sf <- function(proj=c("longlat", "laea", "lcc", "eqdc", "aeqd")) {

  # us <- readOGR(system.file("extdata/composite_us_states.geojson", package="albersusa"),
  #               "OGRGeoJSON",
  #               stringsAsFactors=FALSE,
  #               verbose=FALSE)

  us <- readRDS(system.file("extdata/states_sf.rda", package="albersusa"))
  # saveRDS(us, "inst/extdata/states_sf.rda", version = 2)

  proj <- match.arg(proj, c("longlat", "laea", "lcc", "eqdc", "aeqd"))

  if (proj != "longlat") {

    proj <- switch(proj,
                   laea=us_laea_proj,
                   lcc=us_lcc_proj,
                   eqdc=us_eqdc_proj,
                   aeqd=us_aeqd_proj)

    us <- sf::st_transform(us, proj)

  }

  us

}