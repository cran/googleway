#' Google Directions
#'
#' The Google Maps Directions API is a service that calculates directions between
#' locations. You can search for directions for several modes of transportation,
#' including transit, driving, walking, or cycling.
#'
#' @param origin  \code{numeric} vector of lat/lon coordinates, or an address string
#' @param destination \code{numeric} vector of lat/lon coordinates, or an address string
#' @param mode string. One of 'driving', 'walking', 'bicycling' or 'transit'.
#' @param departure_time  \code{POSIXct}. Specifies the desired time of departure.
#' Must be in the future (i.e. greater than \code{sys.time()}). If no value
#' is specified it defaults to \code{Sys.time()}
#' @param arrival_time \code{POSIXct}. Specifies the desired time of arrival. Note you
#' can only specify one of \code{arrival_time} or \code{departure_time}, not both.
#' If both are supplied, \code{departure_time} will be used.
#' @param waypoints list of waypoints, expressed as either a \code{vector} of
#' lat/lon coordinates, or a \code{string} address to be geocoded. Only available
#' for driving, walking or bicycling modes. List elements must be named either
#' 'stop' or 'via', where 'stop' is used to indicate a stopover for a waypoint,
#' and 'via' will not stop at the waypoint.
#' See \url{https://developers.google.com/maps/documentation/directions/intro#Waypoints} for details
#' @param optimise_waypoints \code{boolean} allow the Directions service to optimize the
#' provided route by rearranging the waypoints in a more efficient order.
#' (This optimization is an application of the Travelling Salesman Problem.)
#' Travel time is the primary factor which is optimized, but other factors such
#' as distance, number of turns and many more may be taken into account when
#' deciding which route is the most efficient. All waypoints must be stopovers
#' for the Directions service to optimize their route.
#' @param alternatives \code{logical} If set to true, specifies that the Directions
#' service may provide more than one route alternative in the response
#' @param avoid \code{character} vector stating which features should be avoided.
#' One of 'tolls', 'highways', 'ferries' or 'indoor'
#' @param units \code{string} metric or imperial. Note: Only affects the text displayed
#' within the distance field. The values are always in metric
#' @param traffic_model \code{string} - one of 'best_guess', 'pessimistic' or 'optimistic'.
#' Only valid with a departure time
#' @param transit_mode \code{vector} of strings, either 'bus', 'subway', 'train', 'tram' or 'rail'.
#' Only vaid where \code{mode = 'transit'}. Note that 'rail' is equivalent
#' to \code{transit_mode=c("train", "tram", "subway")}
#' @param transit_routing_preference \code{vector} of strings - one of 'less_walking' and
#' 'fewer_transfers'. specifies preferences for transit routes. Only valid for
#' transit directions.
#' @param language \code{string} - specifies the language in which to return the results.
#' See the list of supported languages: \url{https://developers.google.com/maps/faq#using-google-maps-apis} If no langauge is supplied, the service will attempt to use the language of the domain from which the request was sent
#' @param region \code{string} - specifies the region code, specified as a ccTLD
#' ("top-level domain"). See region basing for details
#' \url{https://developers.google.com/maps/documentation/directions/intro#RegionBiasing}
#' @param key \code{string} - a valid Google Developers Directions API key
#' @param simplify \code{logical} - TRUE indicates the returned JSON will be coerced into a list. FALSE indicates the returend JSON will be returned as a string
#' @param curl_proxy a curl proxy object
#' @return Either list or JSON string of the route between origin and destination
#' @examples
#' \dontrun{
#' ## using lat/long coordinates
#' google_directions(origin = c(-37.8179746, 144.9668636),
#'           destination = c(-37.81659, 144.9841),
#'           mode = "walking",
#'           key = "<your valid api key>")
#'
#'
#'## using address string
#'google_directions(origin = "Flinders Street Station, Melbourne",
#'          destination = "MCG, Melbourne",
#'          mode = "walking",
#'          key = "<your valid api key>")
#'
#'
#'google_directions(origin = "Melbourne Airport, Australia",
#'          destination = "Portsea, Melbourne, Australia",
#'          departure_time =  Sys.time() + (24 * 60 * 60),
#'          waypoints = list(c(-37.81659, 144.9841),
#'                            via = "Ringwood, Victoria"),
#'          mode = "driving",
#'          alternatives = FALSE,
#'          avoid = c("TOLLS", "highways"),
#'          units = "imperial",
#'          key = "<your valid api key>",
#'          simplify = TRUE)
#'
#' ## using bus and less walking
#' google_directions(origin = "Melbourne Airport, Australia",
#'          destination = "Portsea, Melbourne, Australia",
#'          departure_time =  Sys.time() + (24 * 60 * 60),
#'          mode = "transit",
#'          transit_mode = "bus",
#'          transit_routing_preference = "less_walking",
#'          key = "<your valid api key>",
#'          simplify = FALSE)
#'
#' ## using arrival time
#' google_directions(origin = "Melbourne Airport, Australia",
#'          destination = "Portsea, Melbourne, Australia",
#'          arrival_time =  Sys.time() + (24 * 60 * 60),
#'          mode = "transit",
#'          transit_mode = "bus",
#'          transit_routing_preference = "less_walking",
#'          key = "<your valid api key>",
#'          simplify = FALSE)
#'
#' ## return results in French
#' google_directions(origin = "Melbourne Airport, Australia",
#'          destination = "Portsea, Melbourne, Australia",
#'          arrival_time =  Sys.time() + (24 * 60 * 60),
#'          mode = "transit",
#'          transit_mode = "bus",
#'          transit_routing_preference = "less_walking",
#'          language = "fr",
#'          key = key,
#'          simplify = FALSE)
#'
#' }
#' @export
google_directions <- function(origin,
                              destination,
                              mode = c('driving','walking','bicycling','transit'),
                              departure_time = NULL,
                              arrival_time = NULL,
                              waypoints = NULL,
                              optimise_waypoints = FALSE,
                              alternatives = FALSE,
                              avoid = NULL,
                              units = c("metric", "imperial"),
                              traffic_model = NULL,
                              transit_mode = NULL,
                              transit_routing_preference = NULL,
                              language = NULL,
                              region = NULL,
                              key,
                              simplify = TRUE,
                              curl_proxy = NULL){

  directions_data(base_url = "https://maps.googleapis.com/maps/api/directions/json?",
                information_type = "directions",
                origin,
                destination,
                mode,
                departure_time,
                arrival_time,
                waypoints,
                optimise_waypoints,
                alternatives,
                avoid,
                units,
                traffic_model,
                transit_mode,
                transit_routing_preference,
                language,
                region,
                key,
                simplify,
                curl_proxy)

}









