Return-Path: <stable+bounces-192214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAC6C2C718
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 15:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0273A8606
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0B8280023;
	Mon,  3 Nov 2025 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iCZulMQG"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68E427FB34
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180376; cv=fail; b=hsWH3+nVhyo/sm9El9I1Tijy/8Vew2bg6RPNFtr1kkcHNmDyvdjnWmMgAjy61i6iPonRwvCKKdStE3L8cBoB37CKzxrUSFNUBuPL8tZIMq21ySrQFT6SvguB47CF+KEyQ/i40voOMHvGoyVM+KPzxBGfCQsRXx0DyjMb732Hwsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180376; c=relaxed/simple;
	bh=1gEXDGv+XchxOFUh6QtDRNO1uF6jsEaMn9mwOljnKBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I5p7dLM6DMdko3RlH3PpQUm1fYtb6JG8nDK3K+L3lSou8ulrA31j3qJAjGoEaPC6gMiiQgPeMtOfkqXLi0evEA8KAa0d8Z/hyedqTDLb3LUrzOxiYsgGn7jJ2UzIKg+nckn9MPoehXLKHXji5E7KuHSzcQ3axEAMLwUpMevP61c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iCZulMQG; arc=fail smtp.client-ip=52.101.53.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvOsdF3yxPralf7F57h9Zw6q32vTsHmDRrIjqO7L58GwBjRIc/L16qu1Duzg+01N3sGBMmzwpvYLCv0v5SfryeODxXcLAECCDF/2pbBN42tDxzLq2E99US7AuyWELXTiay9S4a4vVtqIpAHA/4qk+5VEotq0gBSUex6J1sx1ykMpb7br+pQOGWlsKBAJzDrKREKFkZhH/FvJw3+vZzF+LYpTk+cHoISBIiBj9PhqwcgXVa5qsYcbMexHYGVDOghKQMHbLe01N508HFNY2vnpYUYTwknNgcroz6PvdemysSiiLL2LLmms8K4BK8ZUKI4SMtUfyVL9QtrEK5oeY3Yp7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gEXDGv+XchxOFUh6QtDRNO1uF6jsEaMn9mwOljnKBw=;
 b=we8Uf3b3AoMiBEwxwx+nDUePiJzvqh0n16jxUgnQ67bxJE0UKxLIfSOGvOnU3v/LZPIsZD9N1ezDr5+oiLc99kQG8qcrRd5FipEDhY2Os1lxij/b6o9dZIgCddjawWr3KB15XHLzHJrfUAEwNmNUBD4YRSZkRKmPhKoFYlYqi63YtYDWj5zYkSxJDpFrsku5cbS1ejGHOtpeql+hXHn2CW8AvUvC5Fv+yTsZVUuX6zNtNHbXPUasHrlhNn0uupKqq2WtP03cNgm6ntraJPGfMDvywmeh8rLdbdMMmPXs3cFUoEOg+b3LI/xnOf7WNjbPN9JZYzuV0cbRR7y1HyVgxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gEXDGv+XchxOFUh6QtDRNO1uF6jsEaMn9mwOljnKBw=;
 b=iCZulMQGvU3SguOPVpLK0uI92MlquKg7fZYK9zrQdSwv4GfpVNUEPKJcriqtlpUiBSYdmQWX1qduxsGDlCaBSoZ/sm0mGHoMgxmV82ekrjj5mk3qHBLFwl21Z3uNx9n0GbFERwKMPRiUgc8i1bmLSzBYcIUMUnsb/yGetqbXX0+tq29SQeI+V0p9031aMi+miVksxUh/Sd8H2YDpxI1OcQrS6DdHusN/oQz+jAIylgMSsn9QjjIyUY3tL6g7BQb1RULNpCL8F9rqbFEThKjJvfpphKaFsTfnjn7DZBzYEicmCUo3suNd78the7/iSNcqqt6NL/y9YuuJDAbuvkewmA==
Received: from CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 14:32:49 +0000
Received: from CY5PR12MB6526.namprd12.prod.outlook.com
 ([fe80::d620:1806:4b87:6056]) by CY5PR12MB6526.namprd12.prod.outlook.com
 ([fe80::d620:1806:4b87:6056%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 14:32:47 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "ardb@kernel.org" <ardb@kernel.org>
CC: "airlied@redhat.com" <airlied@redhat.com>, "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "lyude@redhat.com" <lyude@redhat.com>,
	"dakr@kernel.org" <dakr@kernel.org>
Subject: Re: [PATCH] drm/nouveau: set DMA mask before creating the flush page
Thread-Topic: [PATCH] drm/nouveau: set DMA mask before creating the flush page
Thread-Index: AQHcSoEh8dWTlveQmEOccXmfjOLePbTgoGUAgABn+IA=
Date: Mon, 3 Nov 2025 14:32:47 +0000
Message-ID: <90e049a497896aadc126d8de83478572d6a83704.camel@nvidia.com>
References: <20251031161045.3263665-1-ttabi@nvidia.com>
	 <CAMj1kXFigMpbzWAVz2gOSQxmtMYU22LRWQWVwkd4QeQy8J6Kqg@mail.gmail.com>
In-Reply-To:
 <CAMj1kXFigMpbzWAVz2gOSQxmtMYU22LRWQWVwkd4QeQy8J6Kqg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2-4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6526:EE_|PH7PR12MB9102:EE_
x-ms-office365-filtering-correlation-id: 392c3bd7-8030-4cc5-87e6-08de1ae5dbdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RTIxRnl1WE1mTGlnMytocmd4U2NPV3FtRkhLQ1BFZFNtdUdkLzM2RG5peXFh?=
 =?utf-8?B?ZFltQUtZaHhyWjdUUy9CdHFUcmhjMmlNM21LVk4xQ3JKRVdzdGowZmtvZjZH?=
 =?utf-8?B?ZTQxVXYxaDRzR0t3Z25UVzRjTlc1azVSNmZuYzEvNFppK21CYlNBbHMvTkNS?=
 =?utf-8?B?TUlDeUdqcVUxeWZ2OHpUV3VpcWkrVUtlSFZ5czJYMWc5NDRJcW04WWxMWStv?=
 =?utf-8?B?ZVU5U1IxblU5V0JpOUovTncreE0zK2RHQXoxK254eTNMdnhSWGwwbmRSUVF3?=
 =?utf-8?B?bm91bTRZVEFhcU83UFp1NHF2dnFtNGhUWDlodEkwcVROTWxKQm13Nm5FQ1My?=
 =?utf-8?B?VkJNVDhoYXZwcGlYTW9yaTFvTGQ0Ymt6YlRjMlN3VkExYUxsc2lVZ20rTjJQ?=
 =?utf-8?B?Y0FyOVk1YW1tMUlucC8vZTRWUkNsdDNrYXhDeWZOcmt3QlpNS0QyYWNZWktG?=
 =?utf-8?B?c2thYnFtN2xPNzhqUkF2NUlnS3NjZXdDekZCT1pMb2UwdDdGQWsyM3hKN0ht?=
 =?utf-8?B?cDhBcW94c1JWNDlPeWR3RFgwUjdLYThub3E1VDhGYkJJSlpqLzdQK2lidE1E?=
 =?utf-8?B?Q3pjODNLNzlwT1g3cWhPOENqV0lhSEM2SHVkZktlUHhjOHR1RUcyVWpKeU9h?=
 =?utf-8?B?Q29wWG93Mnh2cUlsbk5ySStKaWJueTQySFNyVVN6azB5RC85bGUyRFhsRDFT?=
 =?utf-8?B?THlNWkd0S0xZakxVT091T3lIU2hqLzhLNnJiUjYwL0lreFJ3NlRYdnZNWWtX?=
 =?utf-8?B?Y25JZmJGOVAvQVRYRm9janBHZWszQ3QwbXU0WkVmcXdBZzZ0enk0MWQ3NDN0?=
 =?utf-8?B?UkduN2FjWjJVcGZpSS96bkhCWnAyRFBMV0FXYmg4R09aMHNBWHlOMkE3Rlh3?=
 =?utf-8?B?RUNUbzJSMnpMQ2NjQXZjdFBvNGlrYmdwUHkwa1huTFZGaFEzaElqeHBPSUlk?=
 =?utf-8?B?YVZhblVRKzd1RWl1MFBRQ3hhQU9YODNCdm9YUTl2V3duK1M2cGFZU1AwS2tH?=
 =?utf-8?B?NEtKRjlkMTZxU0hQZW9rWEtRUzlBU3diMWZYQTRxVnB2c3l4ZldEaVZ6Kzl4?=
 =?utf-8?B?UUcyUURtRjhNWnRXT0FrSTBCRjBsSmRnUmgvRG1FZ09GOTlBYndoYzRWOWVX?=
 =?utf-8?B?N1J1cnpkZE43NVFoV25WTHZhZTREUUw0YXVoNk5MOEZPZUxLMWhqT0ZUNDM0?=
 =?utf-8?B?TFNsamFoRzNyK215cDQ2SnJxdWRFbURzMzBtdTU5NFVkMXZXaEFZRmwxOVQx?=
 =?utf-8?B?VFlQQ1BCN0hIWUFpOHdETlllQlgwU3pTUTd4SE92QUNVTDQ4cXB3RXBESHJD?=
 =?utf-8?B?L3ljRmJ4MExTNXhWUklTVGlVZFpIck8wWXRPTG14RHFoMHhTdUl3a2RwR2pJ?=
 =?utf-8?B?YUwvaGMzd2ZOa1FpcXdvT2RNRGYyd0k4bHg2Y0tsdk13L2NEdi9LM2czLzFi?=
 =?utf-8?B?U2ZVcFFCZ1BWN3lyaGhEVjRkVzJJTVhuY2xwemduRGhVZVN4RmVVa3lLU2pK?=
 =?utf-8?B?emFtS1BpUHRTZzJpM0xuNXYyelRpMjRKWFlEQjV2TCs5WUt3Nm1EWWtRVDNv?=
 =?utf-8?B?MHNBUnl2OW1FV2VxMkpFVEQvcFhlV1ZuV1dDUko3SXBOOGtxdGdENHd4bnNX?=
 =?utf-8?B?T2szNHNNblBpNy9uWi8rMWwyTFZtSHpPM2VzOEdHcmJ0dGo3Z1FKb2RTK3Vh?=
 =?utf-8?B?U3ZCS3ozMmZrYnlHczlveEE3RUFjL1ZsUUIyaGRGNHNob3pMTE5xOGRZbmJi?=
 =?utf-8?B?Q2tTVUpLb1Y2eGI5Vnl3dFhqd3k1bERlaCswRVVKN0pQb0p4UHU1aWxoR2w2?=
 =?utf-8?B?c1E4bjRnMzZzMVVGMmNRa3l5T2ZPK2FKbWNPNk1OZUpBMXp5RHlZZS9MekRa?=
 =?utf-8?B?aVRTTFBQMDFubEV0eWhQNm9FVm1PN0hmL2xTaS9FVUhRVE9WRFZmMHlhU1Rv?=
 =?utf-8?B?L24ydHZ5VlhiMHFmN0hYOERLenZ6ZW04d0dqKzAwZ3JWN2phMElPK0NWekV2?=
 =?utf-8?B?SktkaW9Ua1kzKzBTL1lFallxRTBNTWlHWDRJb2t6NHFReGRUMnlkM2ViS1BD?=
 =?utf-8?Q?uiX1JS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6526.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFdrMWFFU1lUZDIvS3R3MjRDYktIYUEyTmNPYmQybXErSllZSUJBL2JKeUJw?=
 =?utf-8?B?dm1CcHIxSmMyUmNCMmtCU0tFUVVadU1lTFVKZEYrNzJqYnU5RW9NVEJPMnpx?=
 =?utf-8?B?VW4yeHlGeDZKOXhpT2pRdHNKOEhjTVVkV3c1S1hzWWp3Y3dLM21EZjFSVEJJ?=
 =?utf-8?B?ckFGU3VMQWxKYlRybG1oZkVBbzhtYU5hcUNocC93RTVDVGh3bU5OTlBhYjRD?=
 =?utf-8?B?S1R6RDNPMjB5SE9NM0hOUXUzRkx0a0luVksxMk96WjNvTUZPMVAxYVlpMEk3?=
 =?utf-8?B?Y2hiSVlaL2NkWnBqNWFsTG5iVVV3RFRKNnFpcWhXQStKSkQ3c1YwQkxMQVdG?=
 =?utf-8?B?d2sraFdkWFRJMXQzQXpuc2tkd080WHpZNnUvTmZ6Q3dmaGJpcjg3OUNnZU5n?=
 =?utf-8?B?MElzNVhiajIvVURHM084TFE0cXhhdzVhdi9ZbVpxUFZCb2ZaTm5hSWZTdWhB?=
 =?utf-8?B?Mm5qTlVBbDNTOFlZbXFwYWZzQWtIMmV2enhrSlo0NHZ5cmpiK2FxRlRoc0tU?=
 =?utf-8?B?czVzSXJKWHh0MTJsTDRxc2ZDdkY1OUVKNUJBQTBuMnd6ZTNrampYU3FNYmsy?=
 =?utf-8?B?dENLNW5VaFliYjQrQ2lKOFhqN0drNFZTeTIvb0dpeVhkamY5WnZzRWRjNnFO?=
 =?utf-8?B?UXZyUEtJMVo4SjRpdFFQVWpXTGh4RHcrSWdHUE95dTcwbE5PMkJPa0hSaXp3?=
 =?utf-8?B?ZTlBUjZMdUFxY1IvNmo3SVdkdmx3TkNJbzEybnUxUG1ZSmJwTk14Wi9OQkZG?=
 =?utf-8?B?aTNocmNaZEdlTkFSNFpOMGZXdlBVRTFKUHVWR1NLcWVEbkdrTTVLb3lvTzEy?=
 =?utf-8?B?NkpKWlZmaVV1SmtFRnJlcC9NR3czTVFoUUhIemt2YzAwSzFudS8xOHZJZHFG?=
 =?utf-8?B?UUQyK3Z6eG16NHNHMVlRRE5ySys2c256U3JyWEppM3dFa2FVVDJRajVVN2NX?=
 =?utf-8?B?QUZ4WVptdTdOR0hwRExnQ1lYb2haSDVJck1OeUVva0psbG1IY2Ribm92bWIv?=
 =?utf-8?B?T3FRSXErY1ROU3Z4N1EyN1ZXUVJMTnpNUHljWm82c0lkdllDbklPVkNIVG1q?=
 =?utf-8?B?RUpCb244elRNWWtQeG5aZFhYVDZBc1U3eTR2bXg1ZnBVSFRIMXFDbDZHeUtu?=
 =?utf-8?B?eVRNdjlKVWtUT0hlbGhJWVVGdG5ZMk5Obi8xZXpXSEw1SjJpR0lTcVBKMy9L?=
 =?utf-8?B?WnBoUUw3Y0QwK3ZmQ3NzSEo3N2d4TWZ5dWRLNmZieldjZDBVTnZ1M3NWK0Y3?=
 =?utf-8?B?NDJreDlzWkFLazVkWEhZTy84elFZbHVoeXJnak91bVh2YXh4N09NV2R1SGxj?=
 =?utf-8?B?amNUZWVTaUNncUN4RHo0VWRpY2hMRzVHejl2V0c5NC9laDJNWjQrckNacHdv?=
 =?utf-8?B?eEZlV0hPWlZqMHZnUUpJbmF6aVQwU25VMXBJcW5OUnFFaS9zalBpcURTV1Ir?=
 =?utf-8?B?SExZUzQ1N1pXT1VSa21WZkRYa2NOaEp3OFk2Y3ZZUXlXc01BTmJKZWQzWThI?=
 =?utf-8?B?cm1MQllQRi9ENkZ2NlFsTFBpaDNhMG1TV2ovWGQ3T09JbXZiUGNVSnhSNkth?=
 =?utf-8?B?OW55a29ScHR0cWZNc2lDUmJUZ0QyMDZRTWpDcExJcll1VXhtUmRTd0t0cmhC?=
 =?utf-8?B?VCtZbS9QSmxmMVR5K3dDemYwaTRrOHNERnZONTdaL0pobThxVml5dXVzMGZW?=
 =?utf-8?B?NGxqM2xKbHhQVkx0TVhzV0MrUnVyT0FnWnFadDJhOEVTOEJMaCtSWjFtTWpu?=
 =?utf-8?B?Y3lMenVvaWRMelVuL3FVdDJZQ1lJVndoUFc3M1VIay9vbVVpbUMwdHJmNnBk?=
 =?utf-8?B?R2EvVG02bTNyeWVab0ZwakRFaU5uYW1Ma1VLN0dhV2RhWHNYYktPR24xNmxH?=
 =?utf-8?B?WW1qdHBKZjQ1ZnA4Wisvc1NZcnpFeGxack9BYzVhd1hZNUVOaWVubGpkVWJo?=
 =?utf-8?B?dk9SSDBwZFEzN2Q2VzRha0Z2YzM3ZWZ3YXI0RzdvRkZQTWdhZzJEM2lRcnN0?=
 =?utf-8?B?bkpSb25XSlZHeXJxVjhTZWNVbWhhalEvZkxGbXVoWHU4Q2RaNXpERU9PTmg1?=
 =?utf-8?B?WE1CMWlmaEliN3BlWnMzL0tYQUhuYWRBS3pHZTZlMFpReXdSSlA4c3UwTzlH?=
 =?utf-8?Q?mlRR8ojyIwQvANTU0u0oQUvrA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <083C01690A3F014989AE82CC8538B037@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6526.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392c3bd7-8030-4cc5-87e6-08de1ae5dbdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 14:32:47.1022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfB24rkuMHOmCpslo1QI+cIYfmm1KMRxmJ+NAaURuFSX42vRmfL5XgkO9MaYTLpESksGdQjtjoFKnBZmX7TizQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102

T24gTW9uLCAyMDI1LTExLTAzIGF0IDA5OjIwICswMTAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToN
Cj4gVGhpcyBpcyB0aGUgdGhpcmQgdGltZSB5b3UgYXJlIHNlbmRpbmcgdGhlIGV4YWN0IHNhbWUg
cGF0Y2gsIHJpZ2h0PyBPcg0KPiBpcyB0aGVyZSBhIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgdmVy
c2lvbnM/DQoNClNvcnJ5IGFib3V0IHRoYXQuDQoNCkZpcnN0IHZlcnNpb24gd2FzIG1pc3Npbmcg
YSBtYWlsaW5nIGxpc3Qgb24gdGhlIENDOg0KDQpTZWNvbmQgdmVyc2lvbiB3YXMgbWlzc2luZyBh
IEZpeGVzOiB0YWcuDQo=

