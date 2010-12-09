/*
 * Copyright 2010 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

#import "S3CopyObjectResponse.h"

@implementation S3CopyObjectResponse

@synthesize lastModified;

-(void)processBody
{
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.body];
	S3CopyObjectResultUnmarshaller *unmarshaller = [[S3CopyObjectResultUnmarshaller alloc] init];
	[parser setDelegate:unmarshaller];
	[parser parse];
	
	self.etag = unmarshaller.copyObjectResult.etag;
	self.lastModified = [NSDate dateWithISO8061Format:unmarshaller.copyObjectResult.lastModified];
	
	[unmarshaller release];
	[parser release];
}

-(void)dealloc
{
	[lastModified release];
	[super dealloc];
}

@end