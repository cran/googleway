% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/google_place_autocomplete.R
\name{google_place_autocomplete}
\alias{google_place_autocomplete}
\title{Google place autocomplete}
\usage{
google_place_autocomplete(
  place_input,
  location = NULL,
  radius = NULL,
  language = NULL,
  place_type = NULL,
  components = NULL,
  simplify = TRUE,
  curl_proxy = NULL,
  key = get_api_key("place_autocomplete")
)
}
\arguments{
\item{place_input}{\code{string} The text string on which to search.
The Place Autocomplete service will return candidate matches based on this
string and order results based on their perceived relevance.}

\item{location}{\code{numeric} vector of latitude/longitude coordinates (in that order)
the point around which you wish to retrieve place information}

\item{radius}{\code{numeric} The distance (in meters) within which to return
place results. Note that setting a radius biases results to the indicated area,
but may not fully restrict results to the specified area}

\item{language}{\code{string} The language code, indicating in which language
the results should be returned, if possible. Searches are also biased to the
selected language; results in the selected language may be given a higher ranking.
See the list of supported languages and their codes
\url{https://developers.google.com/maps/faq#languagesupport}}

\item{place_type}{\code{string} Restricts the results to places matching the
specified type. Only one type may be specified (if more than one type is provided,
all types following the first entry are ignored). For a list of valid types,
please visit \url{https://developers.google.com/maps/documentation/places/web-service/autocomplete}}

\item{components}{\code{string} of length 1 which identifies a grouping of places
to which you would like to restrict your results. Currently, you can use
components to filter by country only. The country must be passed as a two
character, ISO 3166-1 Alpha-2 compatible country code.
For example: components=country:fr would restrict your results to places within France.}

\item{simplify}{\code{logical} - TRUE indicates the returned JSON will be
coerced into a list. FALSE indicates the returend JSON will be returned as a string}

\item{curl_proxy}{a curl proxy object}

\item{key}{\code{string} A valid Google Developers Places API key}
}
\description{
The Place Autocomplete service is a web service that returns place predictions
in response to an HTTP request. The request specifies a textual search string
and optional geographic bounds. The service can be used to provide autocomplete
functionality for text-based geographic searches, by returning places such as
businesses, addresses and points of interest as a user types.
}
\examples{
\dontrun{

## search for 'Maha' Restaurant, Melbourne
google_place_autocomplete("Maha Restaurant", key = key)

## search for 'Maha' Restaurant, exclusively in Australia
google_place_autocomplete("maha Restaurant", component = "au", key = key)

}
}
