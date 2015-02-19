//
//  variables.h
//  Lab07
//
//  Created by developer on 2/17/15.
//  Copyright (c) 2015 developer. All rights reserved.
//

/* Variables globales para almacenar la informacion obtenida del JSON */
#import <Foundation/Foundation.h>

@interface variables : NSObject

extern NSMutableArray *maUbicacion;
extern NSMutableArray *maNombre;
extern NSMutableArray *maLatitud;
extern NSMutableArray *maLongitud;
extern NSMutableArray *maHorario;
extern NSMutableArray *maImagen;

extern  NSString        *strSelectedName;
extern  NSString        *strSelectedImg;
@end
