Return-Path: <stable+bounces-211618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH5uJKpwd2m8gAEAu9opvQ
	(envelope-from <stable+bounces-211618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:48:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 187B089126
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 355323044B9A
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D84433AD8E;
	Mon, 26 Jan 2026 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDJJJDt3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D6532825B;
	Mon, 26 Jan 2026 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435009; cv=fail; b=BKPRxAAJhkVzwheaZ/K2x0woMMG1YD4EF7fkY82/9kJ+mNY9hFGyTx54Dg/qy4fT98JmbyD2j4NaB9U6nu17jmYENdpFuNmbWZ2fR6dGRX4kBYP4EIlRcnWmEgaUeejoWnhMiF/QbokQURBZQ0SWBH2yeWeqKkRbY9NbHjKbQZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435009; c=relaxed/simple;
	bh=psSyokMi2aM1lPHNKwDUxh3c1RG2cYVK5gtA/ji0cQs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jA27QXxD7jtonPrtVj3w55HSkRVAwG0tiLsVTfJkLSw6pNgNdnyh4OTrYopD1GlOpl6rx6jjwEh59CDWf2z/voJnG+wz6QTmAvr4CBHQIiC5zAIfWB2c7R+2HKqgQy7p3P3aAux0rFkZGBVlsn2hmLS630ao7gze7xMNJ7KAz2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDJJJDt3; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769435005; x=1800971005;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=psSyokMi2aM1lPHNKwDUxh3c1RG2cYVK5gtA/ji0cQs=;
  b=iDJJJDt3IuU+lGK3jIqubp9VnJgL7HqXtzyiFRVtrXfKLcX0NuxF1y2I
   KOr03k3XuuFlwqlieUxIVWCFCZ5Hfrjg8KHUvtcV6DWci1n8ZA2jHFsvC
   tGFRn9b/8a2rnPH1tHm5xdVcXmyinfSjKZTrr86NSYR1pg27ob6N/xLSB
   8s4jSgeDSJR0q1uO0lweUMRLX6n1XUoNUBs2Ydrf32I6tztbIGrg4kWZ0
   T0ZP5HgyuWmF5/mw2mPhUsA2T8cii0lss9XPwk7zR4jv6omX9NNR5KqJw
   QxCiIIPmGetEsLn+sCrFI1wUk1DqBN81FVio7ib41dvULj5ItMMtQeF7B
   A==;
X-CSE-ConnectionGUID: 5QXgOHVGRV6Q0JZBbhelOQ==
X-CSE-MsgGUID: zUKhmxfDS5mjU06KV8cTMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="58184569"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="58184569"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 05:43:23 -0800
X-CSE-ConnectionGUID: e0IxnB3pTau5yjK5MtuI/w==
X-CSE-MsgGUID: UKoWwRYnSkS0uoBCPPMtbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="212224091"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 05:43:22 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 05:43:21 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 05:43:21 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.63) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 05:43:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QW0wXtNjoDoHAd8LXdzzqCVgbIeavihrd+rsIQCYoko42KZ/RfoGdmQdYvxl2V02eD22lFoiRnhjyzUcDAaMbknUnqHKnq1TIHyAbsCiOks5XO5ppoin90zFdcBKuf1NxUhILK6Sqf2u5q6ggJbux7H0ORS2h2K+bHxh9WHSSWMqtnLp27iMLLlIWfNykwdrwdOrz4cCdNu8bunl5Hce/edpeVpshkj0GbDkc0tYCYjMQ11srN/ji+25tXR0ON7+/vhyMZNr6Z/QyhIbpjtNwA8912tvRx5D/LRAnwkP8rwVTH5IWxhBnXezax75TqwfKgdFikS0nswvY+N3X4EQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KA4ZLHBmvCRdhZm/4K+FENlZTN6mraQ6XR47MYr5oSg=;
 b=E8SQzrZ7RqaQFv0j347QWHMz3pEkiuw9Nzb45lbEqkDQYtTb+M88rRTaFRBd0RRYvb5xO6ISxati9jWwyWC98ynhlnUoDiSevxRz24P3ufK/bldgklluWljdbpCkJOojMJk/nv+xlAouuIE+yszGJ98E0VEanNglKE+5V3TVRxwg/TIeVwdMatlANUMO1/3lumou2anund+mcQGwvNxmPX/HOKAyYdt8yzhw8ADu/Hi3r+j5OWTVz5UfJhiX7bXvgbXTiaAwwdZFW4BVHRsJYDCoVgwwylhL7QJUFQKZx0rcWQXNhoMyOfwqPkZAhgYJTQqdP4/bgXXjVkAA4j6DRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 13:43:19 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 13:43:19 +0000
Message-ID: <39569ebb-d9a2-4f81-9abe-aec98f3c9f67@intel.com>
Date: Mon, 26 Jan 2026 15:43:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mmc v1] mmc: core: Fix bitfield race between retune and
 host claiming
To: Penghe Geng <pgeng@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260115214648.168365-1-pgeng@nvidia.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260115214648.168365-1-pgeng@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0063.eurprd06.prod.outlook.com
 (2603:10a6:10:120::37) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ec7b96-fb68-4e51-b2d3-08de5ce0dd49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFR0M2oyb0g2TDNXVFJXZGQxblpwSkF6N3gwd2VaejVtQXo2WjltNFM5VWRn?=
 =?utf-8?B?M3ZEb0hjQWcxcm1UOVV6ZFpyNjJieVdRclFGcnJJTnovajl1RjE2UlNnTERO?=
 =?utf-8?B?TS9lSWVzQXlmdWlvTFBqeEl3VmF0aHljMlExNHBqVk41SzBPTGRVeERRU0hZ?=
 =?utf-8?B?M29JRnlPbnBoOXl4Z2ViV2JhUXEzNzdDUDUybHlld0dUcFlIKzkzUlBlWFV3?=
 =?utf-8?B?dldYODNIUExQdDhHUDdJS1VITDlhdXZTRXVZcWdLeHNQRXlYRkVDU2xBNVpS?=
 =?utf-8?B?bnpva24vbFNQYy95d3p2dHhzckNKb2lMMEgxa1ZpK0dEK01vQ3JVTDR4aVJY?=
 =?utf-8?B?cTlZa2dYc3ZWcTg2ZnVpT1FOYTJXMXVKbVVEUWN1L1FEMGkxczQzVTF2d3FK?=
 =?utf-8?B?ZHJjd1QrblFoTjVtWmNVS0tEY2tTNDBBM3JRbjNNcFBWNjBabTJnNHJsQjVO?=
 =?utf-8?B?TEZIMkVrUENWYTNlMnR3eW9CVXlsM1RqTER6cXo4Y1VxZ1NBL3lpK2QzUlNi?=
 =?utf-8?B?T1oxQVJpQUg1cDB0TzYydjYzVlZGTncvWDBWK0Q2RTVGRG43ejlyTjN2ekFB?=
 =?utf-8?B?YWQ4NEMydGZSYVcxZXNScG5SZkxYMXQwZ2JjVllsREkzUEcxTXZWbXMrZ3pZ?=
 =?utf-8?B?UkNtSUVwSklLOVZJVmZKeC9PeVFpbkVSbzkybFR1dmtKKzY1RnR3SSt6TDdN?=
 =?utf-8?B?Zi9FRE1YMVVsYUFwVFJiN1FIQnlpbndSN3ZoaEhMdWpicmx2N2RxR25ja3dM?=
 =?utf-8?B?UzhoZEZyU2FEdzRBTEgxYk5GNXRJa1ZPaGg3QlJ6SlNlOU55RTdxcjRQMHR3?=
 =?utf-8?B?MFBHN25pMWVKSmNHWHNaNlNhWWU4QnkyQ1RXbTBQd1dlMnRpSFBrSUJnVTFE?=
 =?utf-8?B?U0RsbW1FQnZkdDVMR1loZ0dWcGdONVZzaHVBVGFxNzZqTEdaNTIwcnloTlhL?=
 =?utf-8?B?R29iVnVrZlM2c1R1MFVzTWZXRloxM25YRGRYRnA4Q0dQUFRXRmxlbTRHQ3RR?=
 =?utf-8?B?Q3FLSDA1azlGcVQrZlV2NXFmRmVHWUtYY3BNWUtXUTZiSHNXSjlHazJ1VjBx?=
 =?utf-8?B?TUtmeGxqbk9aSXFpbWE2SitRYldDQ3RiTGwxaEpsdDd5VDZ6VDNLaVJiVlpF?=
 =?utf-8?B?VmFtdTc0KzNXRDlDOExVTVBDLzZ0T3dRYkJraGJIMWlHUnRVSVVIOWxjSzhv?=
 =?utf-8?B?Ukk3Q3p2d09hZlBITEhxZUprV1oweXV6b1BXU2F4QUdhUTBtYjNqcnN4TVh3?=
 =?utf-8?B?dW1hd1hWY25ZdjNKL1I0cUY4bEJ2SnhEblFwT2xKMlkxVHRIYXYvWUE5UUZP?=
 =?utf-8?B?Q3U4WjNEbTB2ak4xMFI4NG8yd0ZpRkx3am1vQlE5eGFjZVVBNUlVNlZwSm12?=
 =?utf-8?B?V29teENXQ3dHWnM4bGcybHNVcGNkSFMvcXlrSDFFWi8yNmFFUGVtOUJib1Y1?=
 =?utf-8?B?QTZhdzkrN1d3d3ZZOFc1Q3grTHFBRWtUSEZZOE1HWkFJN0VxV0R4R1ZMYnNV?=
 =?utf-8?B?TTJSam5acm1XV3F2ZDlzNmJ2czRrTzZVSXNsYmJESW1Jb21BcTJyUmFHVk1p?=
 =?utf-8?B?WjN3MjV6VjN3NlVVcDhGbzRsbXd2M0tQeUJhR0ZoVkRnTTUwbEFFZ0N4STA1?=
 =?utf-8?B?VVF6b0xqR3U3eWgyZ3c2R1grYVRsbzVsRkpLeG9aT0kvbjFDd2FhenpsT2Jy?=
 =?utf-8?B?NFVvYmF4ZXkwU01BM1pYcXVXcERCTnk2OXFieWF4WlpTUE1WSmNheFBHZlJ6?=
 =?utf-8?B?c2tvKzNQc2dqNnF6ZGVIWHlJb0Y2T21XZkFCWitDZmVJdW9EZGJ1clFFUGtR?=
 =?utf-8?B?N0o0SXZDVDdleEdvc29QeGNXbG13bmZzeVRqaEh3c2JWZDVBa0RGRlk3VDRy?=
 =?utf-8?B?ZHlqZmpyZzRQRFovR0xzdTNqT1NqTVRTU1YyZkx0c2ljRFJ1TnU4NldXVlYv?=
 =?utf-8?B?aStsR2ZZRWxMdVA3RXY4dGRIS0R0QWtpZkNNRTQvVitBemtXaDY4VitaSVdo?=
 =?utf-8?B?cmRraEhEQUtWWTBScmdVVkoySjAxYTRVSnZaT3pLcDhNTzZqcWFjNGQwVkU4?=
 =?utf-8?B?RUZaRmJVbHFBUlR6ZHQ3U3VwbEl6VXAzaE5FcFlzbzVZVUp4VnphL1FFWDIr?=
 =?utf-8?Q?f8AU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFlrWWVGRkR2Nmk3ZkVmaGVTbXBXc01kQk83Y2RSRUMwSU5FVU9qSXY0Y0dv?=
 =?utf-8?B?UjdkS09TbGJVc3NYTlQ0dG5LcXoxUHhSSk85V3dWUDRKc2paTE1kYnJZd3Jv?=
 =?utf-8?B?K3JyWUltSXFsZzBYaHBaOU56cTNhKzJDcWNsQmlVNVZiNWkyWGZLTFIxZ0hD?=
 =?utf-8?B?bkdSUm1VdWxielhOcXNWdXlGRGdkaXY4R3hPeE5YN2ZObkh1cG5nQURYMFZs?=
 =?utf-8?B?a01UUnB4eFMvay9odkZSZjU0ZWJZUCtXNWVsWnE1R3pxM1ViL1c5UUF2d3Zu?=
 =?utf-8?B?Sk05aUVqL3o3TnhFTS9UeGpXd3p1S296NFc4REpDb2hBak03dFFTZ2R3clY1?=
 =?utf-8?B?YkNzZzZ2TG1SdkhuKzRlaTl1UFR0V1hERUxUcW5FTzU5UzVqZ2NiMSt4WW1h?=
 =?utf-8?B?ZUZReG9wVHpreE1STDc4NHNFZmdCMk4zQWdTd0JTMnhCcDRrZmNKZDUvN2Fh?=
 =?utf-8?B?cGJYdzlnQUJVTkN6V1ltalZYU1JqU3lsL3hLSDlFbXZYWmpnSTQzUDkxQUgr?=
 =?utf-8?B?S3poTVcrNjJNM2trY1hFeEtTSTZWeldVWitiL1owTXdHd0lZcmxBZjYxQ2NM?=
 =?utf-8?B?TEpaWitJSkxhc0JoSTd5dzFxSElYeHZ5b1BDaXdlMWJrMlhHRWtHYXZNSFFW?=
 =?utf-8?B?SWl6cm1Xa1dyRjFuazJ1U1Q1OVFBVWs0OHY0ZXFCVnI5b3ZBdWkyalhlVGQv?=
 =?utf-8?B?d3hVZGR6VzhiWjNML0ZxQWRuSHhrQS8rY2Rhd0JTcWZSeUhvSnZHdTAzeXBX?=
 =?utf-8?B?WnlaQThUZ3BtalRkSWFLdDBuTUVIWm1uaUQwQ2s2NkR1SnVZOVFUcjUwYzho?=
 =?utf-8?B?bVR5TDZjcXdJMlZ0eXprVDNjZXk4aGl3QStKbEhaeU5GeDBqMjdHdldVQ0lY?=
 =?utf-8?B?WHFEQ2JnbzNjN2draEU4WURRb2RYb3lET2c2YktYN3B3QU9qbHlPZk12Q3pT?=
 =?utf-8?B?Q3RQYUlna1dnMWFtc2R4a3N4VU02UzZHYThiTkMwK2lCOHN2bWJHOHFWNUk2?=
 =?utf-8?B?SkhLZUlDNmcvdDdtNjBhZ2kyQkgxbWdNWTlncHRhWkJ5bnErejFlaW1sV1gx?=
 =?utf-8?B?VE5mZFAxcU1jQUtuWG5peS9UK1U3eml5Q0JPa0RNZHdjNzEvOVZKYUFSSUZm?=
 =?utf-8?B?WWlNUGRIeER1MzdlYjdON2o4dkl1bWxjYTdqK29sdlFGdG1kMWNBaDFDZ2gw?=
 =?utf-8?B?SjhBbFcvdkZmWlFtVVZzZjNUSWprL1VTVEpJOHAwSFIrenRWdGozMmI1cFU4?=
 =?utf-8?B?eGZFMGhFTzBYUFNodDE5ZmlMMndGZWg3Y3ZrMTdVOGpPOGkzQU0vSHJndEcv?=
 =?utf-8?B?ZmY0ZGMzMGJCQjlpQUNOQ3hnNStsZVNvSTFxNUdDS2xPRWF5M2w5aTcvRlJH?=
 =?utf-8?B?UkM0MnNHNWU2VG0wWVZLZXJROTZ1S0luT3pScGFRc0g5Qi9KazFpTGhaakdD?=
 =?utf-8?B?cnpZclVKN0JvQXBiY0R4bklQbHpKRFRyN0tOMHd6VFlqLzI4NEppZncvMDM5?=
 =?utf-8?B?Vm43QUNIK0lXWkZucmR4M0FucE1mdXkvU251WEx4Y3Y1RDBFbUtiQ0c0NGd2?=
 =?utf-8?B?YUE2SDhSQ2tsZ1lEbkpWNFloR0N1elBKUitYeXNRWUFlckN2dDdFZ0o4UkZM?=
 =?utf-8?B?RTV3Lzd3MGhRQWEyOHp3L2pTQW1IREZOS29xWnVMMUdFVExMNmZKREdnOGhv?=
 =?utf-8?B?NFpKak12bFVGQVJmaG1PQkNMZjAwNFBXcVZIWjNiUnFwbWVEUStTWUd4Y2Zn?=
 =?utf-8?B?SHVUUkxZdWdpbGE4d0UwSC9tMGlzNTRYQmh3M1B3TjZuZllSTFdmcnRLWGFH?=
 =?utf-8?B?bE0zZVNrSU4vVk9Xbk12RklZOHVZWkJ2WndmMG9UTE5YMFE4NXE3Z0dvelpU?=
 =?utf-8?B?NmtZb2hvZ2Yxc2tacDl3TTIyazJMU2VZNEZWMzk2b3pHRUFqODVmQ3VxTHY5?=
 =?utf-8?B?a25jbTZZYUh0ZnQyWHpUcE5RMUtZQ3hLZzZCQ1FLZ080dGtoemxSK3MvUVps?=
 =?utf-8?B?RDY5L0N1d2c5bWl0UkwxVnRQVWcwOENiRTVtTFNWNVI5ZXFic25WUk9lNnhq?=
 =?utf-8?B?aDlhTGtZY3RGLzdlelBQblk0L3dwMWZyb1YrSVhEYndMVkNDZmExOG0wZURt?=
 =?utf-8?B?bW5UMlg1YkpoM0NwYmJCR0QzeDM3UVFKVEh0ZnZNTlZLVUkxMUhjbG5DLzYw?=
 =?utf-8?B?VzZNMEZ2RW5yeHYvNnlKMDRCNnFFZ29IWDVOWGZXdGNKV2ptQmF6UWhtUlhr?=
 =?utf-8?B?eXE4anppVGxTSHAwaER3MGRLTUpCR2NNekMzVkhYR3JQQVIxU3FjWE1qamxI?=
 =?utf-8?B?MWF6M3h0cVcrblBWQm5NenE3ZDEyVDd2QUZONlNXY203T3ZEUnU3QT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ec7b96-fb68-4e51-b2d3-08de5ce0dd49
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 13:43:19.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlznEGTZBvVl6UCCCOyqvVIqQR2HPEUu8gItChX+5EyNle2GstHenpqFAoyqghbuwTKJQGBmu3lGek0SdhoHkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211618-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 187B089126
X-Rspamd-Action: no action

On 15/01/2026 23:46, Penghe Geng wrote:
> The host->claimed flag shares a bitfield storage word with several
> retune flags (retune_now, retune_paused, can_retune, doing_retune,
> doing_init_tune). Updating those flags without host->lock can RMW the
> shared word and clear claimed, triggering spurious
> WARN_ON(!host->claimed).

Thanks for finding this!

The design is that those members are protected by the host->claimed
lock itself.

mmc operations are primarily single-threaded, protected by the
host->claimed lock, although the block driver does allow multiple
transfers at the same time in some cases.

There are also other contexts like interrupt handlers.

Can you provide some information about when WARN_ON(!host->claimed)
is being hit?  Including the stack dump?
What kernel version?
Is it eMMC, SDIO or SD card?
Is CQE being used?
Are there any I/O errors happening also?
What controller driver is it?

In any case, the use of bit fields seems to add complexity unnecessarily,
so we should consider converting some or all of them to bool.

> 
> Serialize all retune bitfield updates with host->lock. Provide lockless
> __mmc_retune_* helpers so callers that already hold host->lock can
> avoid deadlocks while public wrappers serialize updates. Also protect
> doing_init_tune and the CQE retune_now assignment with host->lock.
> 
> Fixes: dfa13ebbe334 ("mmc: host: Add facility to support re-tuning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Penghe Geng <pgeng@nvidia.com>
> ---
>  drivers/mmc/core/host.c  | 60 +++++++++++++++++++++++++++++++---------
>  drivers/mmc/core/host.h  | 35 ++++++++++++++++++++++-
>  drivers/mmc/core/mmc.c   |  6 ++++
>  drivers/mmc/core/queue.c |  3 ++
>  include/linux/mmc/host.h |  4 +++
>  5 files changed, 94 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 88c95dbfd9cf..0b6b4a31f629 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -109,7 +109,11 @@ void mmc_unregister_host_class(void)
>   */
>  void mmc_retune_enable(struct mmc_host *host)
>  {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);
>  	host->can_retune = 1;
> +	spin_unlock_irqrestore(&host->lock, flags);
>  	if (host->retune_period)
>  		mod_timer(&host->retune_timer,
>  			  jiffies + host->retune_period * HZ);
> @@ -121,18 +125,31 @@ void mmc_retune_enable(struct mmc_host *host)
>   */
>  void mmc_retune_pause(struct mmc_host *host)
>  {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);
>  	if (!host->retune_paused) {
>  		host->retune_paused = 1;
> -		mmc_retune_hold(host);
> +		__mmc_retune_hold(host);
>  	}
> +	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  EXPORT_SYMBOL(mmc_retune_pause);
>  
>  void mmc_retune_unpause(struct mmc_host *host)
>  {
> +	unsigned long flags;
> +	bool released;
> +
> +	spin_lock_irqsave(&host->lock, flags);
>  	if (host->retune_paused) {
>  		host->retune_paused = 0;
> -		mmc_retune_release(host);
> +		released = __mmc_retune_release(host);
> +		spin_unlock_irqrestore(&host->lock, flags);
> +		if (!released)
> +			WARN_ON(1);
> +	} else {
> +		spin_unlock_irqrestore(&host->lock, flags);
>  	}
>  }
>  EXPORT_SYMBOL(mmc_retune_unpause);
> @@ -145,8 +162,12 @@ EXPORT_SYMBOL(mmc_retune_unpause);
>   */
>  void mmc_retune_disable(struct mmc_host *host)
>  {
> +	unsigned long flags;
> +
>  	mmc_retune_unpause(host);
> +	spin_lock_irqsave(&host->lock, flags);
>  	host->can_retune = 0;
> +	spin_unlock_irqrestore(&host->lock, flags);
>  	timer_delete_sync(&host->retune_timer);
>  	mmc_retune_clear(host);
>  }
> @@ -159,16 +180,22 @@ EXPORT_SYMBOL(mmc_retune_timer_stop);
>  
>  void mmc_retune_hold(struct mmc_host *host)
>  {
> -	if (!host->hold_retune)
> -		host->retune_now = 1;
> -	host->hold_retune += 1;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +	__mmc_retune_hold(host);
> +	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
>  void mmc_retune_release(struct mmc_host *host)
>  {
> -	if (host->hold_retune)
> -		host->hold_retune -= 1;
> -	else
> +	unsigned long flags;
> +	bool released;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +	released = __mmc_retune_release(host);
> +	spin_unlock_irqrestore(&host->lock, flags);
> +	if (!released)
>  		WARN_ON(1);
>  }
>  EXPORT_SYMBOL(mmc_retune_release);
> @@ -177,18 +204,23 @@ int mmc_retune(struct mmc_host *host)
>  {
>  	bool return_to_hs400 = false;
>  	int err;
> +	unsigned long flags;
>  
> -	if (host->retune_now)
> -		host->retune_now = 0;
> -	else
> +	spin_lock_irqsave(&host->lock, flags);
> +	if (!host->retune_now) {
> +		spin_unlock_irqrestore(&host->lock, flags);
>  		return 0;
> +	}
> +	host->retune_now = 0;
>  
> -	if (!host->need_retune || host->doing_retune || !host->card)
> +	if (!host->need_retune || host->doing_retune || !host->card) {
> +		spin_unlock_irqrestore(&host->lock, flags);
>  		return 0;
> +	}
>  
>  	host->need_retune = 0;
> -
>  	host->doing_retune = 1;
> +	spin_unlock_irqrestore(&host->lock, flags);
>  
>  	if (host->ios.timing == MMC_TIMING_MMC_HS400) {
>  		err = mmc_hs400_to_hs200(host->card);
> @@ -205,7 +237,9 @@ int mmc_retune(struct mmc_host *host)
>  	if (return_to_hs400)
>  		err = mmc_hs200_to_hs400(host->card);
>  out:
> +	spin_lock_irqsave(&host->lock, flags);
>  	host->doing_retune = 0;
> +	spin_unlock_irqrestore(&host->lock, flags);
>  
>  	return err;
>  }
> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> index 5941d68ff989..07e4f427fe15 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -21,22 +21,55 @@ int mmc_retune(struct mmc_host *host);
>  void mmc_retune_pause(struct mmc_host *host);
>  void mmc_retune_unpause(struct mmc_host *host);
>  
> -static inline void mmc_retune_clear(struct mmc_host *host)
> +static inline void __mmc_retune_clear(struct mmc_host *host)
>  {
>  	host->retune_now = 0;
>  	host->need_retune = 0;
>  }
>  
> +static inline void mmc_retune_clear(struct mmc_host *host)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +	__mmc_retune_clear(host);
> +	spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> +static inline void __mmc_retune_hold(struct mmc_host *host)
> +{
> +	if (!host->hold_retune)
> +		host->retune_now = 1;
> +	host->hold_retune += 1;
> +}
> +
> +static inline bool __mmc_retune_release(struct mmc_host *host)
> +{
> +	if (host->hold_retune) {
> +		host->hold_retune -= 1;
> +		return true;
> +	}
> +	return false;
> +}
> +
>  static inline void mmc_retune_hold_now(struct mmc_host *host)
>  {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);
>  	host->retune_now = 0;
>  	host->hold_retune += 1;
> +	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
>  static inline void mmc_retune_recheck(struct mmc_host *host)
>  {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);
>  	if (host->hold_retune <= 1)
>  		host->retune_now = 1;
> +	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
>  static inline int mmc_host_can_cmd23(struct mmc_host *host)
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 7c86efb1044a..114febd15f08 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1820,13 +1820,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  		goto free_card;
>  
>  	if (mmc_card_hs200(card)) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&host->lock, flags);
>  		host->doing_init_tune = 1;
> +		spin_unlock_irqrestore(&host->lock, flags);
>  
>  		err = mmc_hs200_tuning(card);
>  		if (!err)
>  			err = mmc_select_hs400(card);
>  
> +		spin_lock_irqsave(&host->lock, flags);
>  		host->doing_init_tune = 0;
> +		spin_unlock_irqrestore(&host->lock, flags);
>  
>  		if (err)
>  			goto free_card;
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 284856c8f655..5e38759c87f5 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -237,6 +237,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	enum mmc_issue_type issue_type;
>  	enum mmc_issued issued;
>  	bool get_card, cqe_retune_ok;
> +	unsigned long flags;
>  	blk_status_t ret;
>  
>  	if (mmc_card_removed(mq->card)) {
> @@ -297,8 +298,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		mmc_get_card(card, &mq->ctx);
>  
>  	if (host->cqe_enabled) {
> +		spin_lock_irqsave(&host->lock, flags);
>  		host->retune_now = host->need_retune && cqe_retune_ok &&
>  				   !host->hold_retune;
> +		spin_unlock_irqrestore(&host->lock, flags);
>  	}
>  
>  	blk_mq_start_request(req);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index e0e2c265e5d1..e7bddbafd1da 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -713,8 +713,12 @@ void mmc_retune_timer_stop(struct mmc_host *host);
>  
>  static inline void mmc_retune_needed(struct mmc_host *host)
>  {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);
>  	if (host->can_retune)
>  		host->need_retune = 1;
> +	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
>  static inline bool mmc_can_retune(struct mmc_host *host)


