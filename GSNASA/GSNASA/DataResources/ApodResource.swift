//
//  ApodResource.swift
//  GSNASA
//
//  Created by Yogesh2 Gupta on 23/07/22.
//

import Foundation

struct ApodResource
{
    func getApod(apodRequest: ApodRequest, completion : @escaping (_ result: ApodResponse?,_ error:String?) -> Void)
    {
        let url = ApiEndpoints(date: apodRequest.date).apodURL
        
        if let apodUrl = URL(string: url) {
            
            let httpUtility = HttpUtility()
            
            httpUtility.getApiData(requestUrl: apodUrl, resultType: ApodResponse.self) { (apodApiResponse,error)  in
                _ = completion(apodApiResponse,error)
            }
        }
    }
    
}
