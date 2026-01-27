Return-Path: <stable+bounces-211898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C01KT42eWnwvwEAu9opvQ
	(envelope-from <stable+bounces-211898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 23:03:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1333B9AE39
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 23:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93141300E3A3
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 22:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F1E27B34F;
	Tue, 27 Jan 2026 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chlB+NRl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E1321B185
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551419; cv=fail; b=n1yLmHdfj1o4yR52GasYgSRiO/Kmv1oV+9l7NzDVytCoFB4mKvI0v4kBqLybUtXQ3SBuv1KjmjGzuJFH9nd9spS1kfAPK7rAlDmWnRidDKlyD0R8+IPBy2GAORAQwDOsyB8KhjETvuo0EoAVI0K6uBKTEgEAYtWWtpi6xUKu0aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551419; c=relaxed/simple;
	bh=/47H4oFFaKjTdod9fN28icbSHmPDhZYhVRlu5u8PHsc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bStYY7CRwU3B+k+03JwdR5Dw9qVRbXkTyMhs0XoUOt6KQpro9dO+ZINqXZzJFfrOWKV41+s69/WS4So9Lv6nUt6qAPN5QK2ApfD5xigtn1wWBVGeyBxPMZy8kSFWl3tIUVdBpS3dB86M4u3FCo/vNGDUcP16DcvWKKF/3PTptwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chlB+NRl; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769551418; x=1801087418;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/47H4oFFaKjTdod9fN28icbSHmPDhZYhVRlu5u8PHsc=;
  b=chlB+NRlXb2hK38ldxkn+maO7Ci5OCxfcziAgiwJZbJB7PhXH6v7fktL
   a22KNdbfxPTIj+ED7XGbd7qNvUtFD0r3jNMS3L70Ave02oBTuyjbc8M/w
   6ToiNaYdWsBmFiiRskpXybxwJKeFbKhayRBwvMIfRrZnu0QskpfxNYm4l
   tUltou2QyOnh4m3306YMr7eMgRpjqMi0/xRZst4Om1KEjknTxi6rA1Rnq
   B03fyQgo8BkjjKo0jWSETn/pE7Dw4Eb/B1tR9N7YKXK8UCx74SJfbjHtu
   +2V3WBB4Yw7wXnM2cfgh5NKNaSCT0Miw0bd4gyL1qWTjl6a74aDj7SUgj
   g==;
X-CSE-ConnectionGUID: QMCoi8bFTB6jZSoUi/QlcQ==
X-CSE-MsgGUID: zgqlBLAKR5eVC87EGYAtJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="69958624"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="69958624"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 14:03:38 -0800
X-CSE-ConnectionGUID: T2V98QRXSTCH/Rfvgyihpg==
X-CSE-MsgGUID: l5G7p/HjRiiIOjVfAHy2JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212947124"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 14:03:37 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 14:03:36 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 14:03:36 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 14:02:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnfEXjhw7PCKjmJL3Lux0L/8BajYCV6vxKergX9EXSLdUS2HEHEnO0l255DSCh7vkmzALFQkzZ4vsI4uLMZMsNIhlx9J29CvOmFLztma7vg8tu8SApsk5iHWEXUok9AC8OupGH79HCvxJJ+3lqv0uxQjtgDd5GxDwKW4ZXJOnTvtPpwxnZqWigSG/UUmQDuuW38wyXq0/TgqhOjWCGIA0SHdZfsTbuAX8dQL4Q1rm/MZ+jHtsD01G6iK87ZEJDN2IDADd9AJK/gQ3eXWKcKQZgoZLmT8LhGjWizoGKwz8IDw5QStcOAoUr0oXZV2X+/zFCCen+GRLRMsmIAbvGeADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6h+aXgf92l7TlEraj5TH8G9g3eUaFn38XfFJ087aEs=;
 b=R20LjpHr2kPPLVtEfDzoILEod+75DycxPsq157Hjrme+9h/xva5a1BQmw2/tBFBGoOTNexvznFK4y5lRsXauhB3r25nqbLBIMxHjOYmb+JIUuyrRIytZGiVPyrRFx7aCX62EXKbD+rbf/v9ZxlsLgn81aSyGdn11bw0muH4Nl7wsAeMXOS5G622Y+7aFv5x00j4QzOntUE4T/ZWy6/tJbZEG7d9pVRCP0cIGPcyNI2+NxnNyQpu75Q1Zsq230ivQe1QhaAejHs5xPjHRE2+NNz/AGrV1U0md27W3chcV48J/5FsJRc6TLGg3YKDbxrj7eki6Vuez9A2kI1PtYmBOoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by PH3PPF76AA2D882.namprd11.prod.outlook.com (2603:10b6:518:1::d30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 22:02:46 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811%3]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 22:02:46 +0000
Message-ID: <0d5a5fc7-10e6-44c4-810e-071c10c45cd0@intel.com>
Date: Tue, 27 Jan 2026 23:02:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] drm/xe: Trigger queue cleanup if not in wedged
 mode 2
To: Zhanjun Dong <zhanjun.dong@intel.com>, <intel-xe@lists.freedesktop.org>
CC: Matthew Brost <matthew.brost@intel.com>, <stable@vger.kernel.org>
References: <20260127170455.618616-1-zhanjun.dong@intel.com>
 <20260127170455.618616-4-zhanjun.dong@intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <20260127170455.618616-4-zhanjun.dong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0006.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::11) To MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|PH3PPF76AA2D882:EE_
X-MS-Office365-Filtering-Correlation-Id: c38464f2-ae70-4c3b-a756-08de5defcda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmJoOGozd21QcU8rSTB0OExzNlRuODNHOUllKzB4QTFzQ3dycGZJSjFjYm00?=
 =?utf-8?B?bjhEUHA5dGU4cTcrdUorRjByVExrb21MV3p4TUVwa1pPL2F2b1RiMUNQRC9a?=
 =?utf-8?B?dGgyTWhJdmxYc2tUem5QOGZ5ZUY3Vm9VaGNvMDUzY2FpZFdOczF2YjBjYmsz?=
 =?utf-8?B?ZU1GUUthWW5pcjNhWnFrTU1ScWY4ZkdrWmRKM1BvbkZTYWVXMWlMbjJINXBn?=
 =?utf-8?B?UCtXajhwbVRpdzFNeFVOb0ExV2NjQTFWRVBFNHM0VVBaejZuZmM0Sm5IdHdh?=
 =?utf-8?B?eHJSSXRLWjlrU2tTTkZUSk41TG8rNmdRSnZjc2llYlI1OFkydkptSTB1bFZa?=
 =?utf-8?B?dWF5cDZsUCthUnVtY2M3b0JnNXRPWUt4QTB5QTYwWExJRDYwRGlHdzkxSXNq?=
 =?utf-8?B?czFkT2JQVVI4NzhkWElDNElWWlJxTFArTTdzaDdsd1RBZm4xenFUK2RGK3pv?=
 =?utf-8?B?eWNWU3pQdWs5V3lvZU5UWkR4ZkloR3NoSkFKWEE0eGNTdUNzV09UL01qV2ZB?=
 =?utf-8?B?TWE2ckhvWFNIWTNTbkdVV2lNT3ZFN3RpeWhtNUFvUVA1ZG1QZWVMWWh4cHV1?=
 =?utf-8?B?YTUvYlFrc0FTdmVSTnJFb3JYVEsvMGNMU2ZRckwyVWxkak5yWC9MakxvYzZh?=
 =?utf-8?B?dzBnd21VWTF1QnA5WTJUMmlvUXcwODdpWHRTT3hDbmdZVW9QMHJEQ3JseU9p?=
 =?utf-8?B?bXNHZXBVMkJ1VWJ3MDlob1ppT0g3NVRxOWNFZXdyeEJCVldydkdLblBybGlM?=
 =?utf-8?B?VXYzUjVZV3NGbHpybEtiamlEcG5Oa0NoRFFnU1phZitway93ejZ3TzFzZVJM?=
 =?utf-8?B?QWVUd1dlbkdQclVyQ3VzZjFTK244RUVoZW1JZzBZaG8yR01ScllpakdpVGZ3?=
 =?utf-8?B?aCtLYkI4YTkvTDRLMlM1dFdLM2k5endtaU8rd0phUTAyOVBwQ0NoeEtNOXM2?=
 =?utf-8?B?WStUSWZBZFBGanNGVHdtdTdSZUxEQjFncko5SCtrT01BV0lIY25qdEdMdHZi?=
 =?utf-8?B?ZUJhT2F0Z3p4UE4wR3Z0b3hRdCtmZFQ0d1d4NWRaVlg1a1dJT3dkRGpWVEsy?=
 =?utf-8?B?cW1RcGU5NEg3ZlhFLzUxcGNheFdNUVN4Zk5CS3ROM0hKOFVhSWs5ZWdNL0Nw?=
 =?utf-8?B?TXFQemtxdzZJcGhCbVk2bXRUdnBVMEdRWi94dExoeHp4eFhBYWNTR2VEV0ow?=
 =?utf-8?B?NEx5RDE3Mk90UEVjbWdTM1hJMDNvcWl4djJJeHAyTTB1RU5HdDJwaDRWOHhI?=
 =?utf-8?B?dFg2dlpBeUV0V21MSXRlM1dRcFR6Qm5ET2VvdklQZ3VzZU9qVnhVS0xOaEdu?=
 =?utf-8?B?WHlIN04xcGhQdURCWTZYdWpWU3dLVG1lSTk5aUtpWGNEZUZrTVZwT01xcTc3?=
 =?utf-8?B?VDUvUnVDUHlzNXZQSXlHSDBrSlBqZUZWeW9PSDc5OHdoTGNJbE96QkpIcXBI?=
 =?utf-8?B?bE5Vem5LaThGRUl4azhZemp2cDY1R1R4RHoxbG1ITGYzSE52bVNkRjRYY05F?=
 =?utf-8?B?aUJ2ZjNoOUQwUWlodHZGeVpBUDF2cHNBVktxZE1kdThCQ2NBb04vUHNtM2s3?=
 =?utf-8?B?UFBCNHE2czJDcGtRWUdaNGlhNzFuL2xMVVg4SWpYYld3WTc3U1pPTU5wNkY0?=
 =?utf-8?B?dllYMHNGQ2FLZTRtcUNHQTZkQTlxWDUzVWRlK1dEUEFCUHF3T3pvWlptVHR3?=
 =?utf-8?B?MVR1ZEsvZjFYSlR2VkdaZTllZ29VWUN6a2RyR24yaFFGRzdtK1hPelNNTVdo?=
 =?utf-8?B?ZXVsUTMwQzRQSFV6OTdLNjExSEpLTnNsZDlDN21yaHpUbUQxdkdaSDkvaGox?=
 =?utf-8?B?aDMvV2d6NlAvTXZBUll5eEpCcUNFdWEvWVJtcFpwMFlYWHBjWkZJUkhnYTFG?=
 =?utf-8?B?bk5aanlJQ1lJWjJ1T1FxcWhqK1c0M2VOQmp3Uk5NUW1xVlM5VDRPT1BjNGxQ?=
 =?utf-8?B?SGYyZERzTVQ3Sk1Gd01kam5PdFVoK0FkTWorbGNUZDhxN2hBR0o4Y2oyazlR?=
 =?utf-8?B?STB3eHRCNjBxS1dyVnA3bzVPOFRFOExpWEFBemd6eExWYVREQUZHdkFBY0pN?=
 =?utf-8?B?RWdYTy9GTjNjV1ZNWHphSkJsdEpTMWRtcHU3K1hXZkU4VUI2OG9nV2x3RXFl?=
 =?utf-8?Q?Hs60=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6011.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a282MVJaQVBDUHZMTVM5WERvdXRjSWxubkhPK2VhMlc3TE1rc2hYbThCWVJF?=
 =?utf-8?B?cXhmZ2kzQlZaYit5bHB6cml0ekJRdnBQSmhaODBlamlUTjV4Tjc2amVZck5H?=
 =?utf-8?B?SEF6ZVpveXdsbDJVUjdzVE1vWFJITWh3bnpsNDBTUzhCV2dCSmVvM29NVUFO?=
 =?utf-8?B?cXp3Z2V1TnRtQWhkSDF0bi9vcjF5U3pWNFZxdE0xb3lFSlZGSXoxaVdPalFW?=
 =?utf-8?B?ZTZWNEpVckNvVkZmK1FoSEhxVG9YWW5pOWh4TDRGZ3l0NTZGOEFUS2drRWxY?=
 =?utf-8?B?eTFNUEljbmVOam8rU3BrZ1oyNjZxZzR4MWpBOTN2WXF2R29HZ2dmdGVkL3Nu?=
 =?utf-8?B?aVRuZGtqU0xoTCtQVy9RUUo3SkZ5bHZtTEFpUUw0OStaWXR2WFQ1RXg4MXlT?=
 =?utf-8?B?eEhwd21ORjJQM3psTDg2d2FSTlFWZitvQnFzRGUwOVczOWRUTHlLSEFFc0ZW?=
 =?utf-8?B?MzdJdGNMV0c1MzgxS0E3RWpmM0hKT3F4Q3RUMU1lQ2NKY21lNjgzY3ZkbE9x?=
 =?utf-8?B?RFNFTjk5T0M2SHFhanlraGQ1U3VnU3gvK2dKbFN3THRSK2s1VHBuN2VGSmxQ?=
 =?utf-8?B?a21ydHJoeWpIRVN1WkxaelBxWGE1WGNYamVPSnNZK1QxSTl0QXNzT1hLVnIv?=
 =?utf-8?B?d0ZaMHRISlZQMGhFMndRcVZyY1lwZXZNcWU1b1NXb1hqQnVIMXNkVTQ3WWpV?=
 =?utf-8?B?bHZFSDN4Q0JWQ0dwakY3Q3dnVlJuazNwQ1B6cGd0L2ZFYzRiNnUvNC8wSnBu?=
 =?utf-8?B?RERoazFHTk5JT1dIckVaY3RUSWNQREpES1BNUDdTdDd3N0pINUlOWFlDcm5x?=
 =?utf-8?B?UkQ2OHBwckZBV0hKSkhmK3c5Sll0RjRiYUF2TW1rbHVnQVlKZlhpTXpJaFIw?=
 =?utf-8?B?cW1PMnBPYVZPaTBFYUtUTVprUUVOSHdiMUNUY3hteG9CZ2llclF4QzJoY0Nj?=
 =?utf-8?B?UjhkeVQ1VUViU1FDdmdYOFQ3OU9XNHg4VExxMDJqNS9uQVcvcVpsZjVUUjJa?=
 =?utf-8?B?VjR6TWM5VFlRcE1TbFVSTm83THhab1BOMnFoTWM4WDhtVlNDYktPSkV5Q0V6?=
 =?utf-8?B?dnNIOC9UbVR5NUJ5M0E4SVY2SVhwMytRb1g1Mmp3cnBvQTBZZ3JkaHVYZ0dn?=
 =?utf-8?B?TzdJVU9xTXBnY0tvS1AyWlZEbUFLckliQ2JLTDhlRy9Qb25XV3hHTzZEQm5K?=
 =?utf-8?B?SDZNZWRRT1VNUmhpVDgvOS9ZVXA3bkg0UHV0SHp2UDg3RmFqWkpJUVFFUWhY?=
 =?utf-8?B?OTl4R3hJNFNSeis0VWlscmhjYllNNlNNWlgrZ1U3bitNamM4VkVxZ1NQMzk0?=
 =?utf-8?B?elpZUXN5NjgzRWRGOXVxb3dxK1plemhhZzZ1cWlkWlUwNFA1ZVkxOGZXOUsz?=
 =?utf-8?B?cTExVUpyMk1ZNk9oZEtqVGdmM3pIbUNRc3dkSUhiOEpSY0R4MkpVcWgvNzRU?=
 =?utf-8?B?NmhGbmpEemxsdXZhbFNsTGNmUkw4NEQyNUJsbVJUNGxEcmtTUG96TGs5SjBu?=
 =?utf-8?B?TGxHQi9NWUQ5REtTMUEvVlRlZDgrQ2ZOTG0xTzVGTEVMWEt4d2lPa1c3eTZv?=
 =?utf-8?B?cjJ0T2FBSk0rMk5BRmJINmcxWFR6U01TZG81dzc5d3RVdExiMkRhanlMblRE?=
 =?utf-8?B?bmhDVHdGYnFma1J4VGhzNXlYMjc5RHM5djhxWkk3QVlNcFR4d29WanJpZ2ZM?=
 =?utf-8?B?TmZMdm1MRkk4L1lJdWN6WWJFbXlkQWxxUzh3cUlSTzlHeVdTU040WVNXRWJO?=
 =?utf-8?B?a2xsa1lPeng5WC9uZHM4b3VrWmQ0S05BTDRtL2JvanAyZ2dZQ0t5aFNrdGdr?=
 =?utf-8?B?NlRqdkRyQmhjNDZNOVc1VEhRWGx6U2lJSEwwRTNWN3JPc0JnbWl6L2N3elcr?=
 =?utf-8?B?VnZWMzRSMGdld3BtWHlQcU5xalJBSFpPVE1jS1d3M0I4d0ZERC9XNkdhWm0w?=
 =?utf-8?B?dTdUVmFIL0FxWXErdzl2NElmMnlleXFyRE5xMC9SODlsS1FaTXpRK084a1F4?=
 =?utf-8?B?OXpDaERrcE1aLzQwSEs0UytobzBvN0EyajZUVkxJZVNJTGFmMzg1L0E1eW5S?=
 =?utf-8?B?TGt5amc1dWxBQVU1SXU0ZDNiTElUUnBudWFJU2QyeGQzd05zWHhrRk1VNUI4?=
 =?utf-8?B?RlFsK01JODJxRVNQaXBaZWFHcUxERElDQjRSUlh4Y2VyZk4yRklraVByRVVP?=
 =?utf-8?B?Y3FxeG9mUE92eVluOEdodnlnUDNlc1V5aUI5WkRWM21QdFp4cXRaa2Y2SXov?=
 =?utf-8?B?OUs5R2lIdlBZUGJySVF6MG5tRjRLUFBVYWJlMlRsUkoxRmFoT3IzM3FuQ2Jn?=
 =?utf-8?B?QUxPVWg5bi9PeFI0aWxYbitrYUxoaU1YVmpNc090NWc3UThCRmZ1aTlDYnhS?=
 =?utf-8?Q?OZ8RP6kAhMIlWHr8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c38464f2-ae70-4c3b-a756-08de5defcda5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 22:02:46.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOG0QqEtZ1pyfbGtA4X4L4EJRCCITIBJESFB9pb9wz7kNqx7bB3oyZ3Ou0AJTEIyaUAEc/7NEvSUynml9HMQ4gUuYmIxCBYFtJX7JuddGHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF76AA2D882
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211898-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.wajdeczko@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1333B9AE39
X-Rspamd-Action: no action



On 1/27/2026 6:04 PM, Zhanjun Dong wrote:
> From: Matthew Brost <matthew.brost@intel.com>
> 
> The intent of wedging a device is to allow queues to continue running
> only in wedged mode 2. In other modes, queues should initiate cleanup
> and signal all remaining fences. Fix xe_guc_submit_wedge to correctly
> clean up queues when wedge mode != 2.
> 
> Fixes: 7dbe8af13c18 ("drm/xe: Wedge the entire device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_guc_submit.c | 34 ++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index 92ea32423838..f29ed62d2b12 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -1326,6 +1326,7 @@ static void disable_scheduling_deregister(struct xe_guc *guc,
>   */
>  void xe_guc_submit_wedge(struct xe_guc *guc)
>  {
> +	struct xe_device *xe = guc_to_xe(guc);
>  	struct xe_gt *gt = guc_to_gt(guc);
>  	struct xe_exec_queue *q;
>  	unsigned long index;
> @@ -1340,20 +1341,27 @@ void xe_guc_submit_wedge(struct xe_guc *guc)
>  	if (!guc->submission_state.initialized)
>  		return;
>  
> -	err = devm_add_action_or_reset(guc_to_xe(guc)->drm.dev,
> -				       guc_submit_wedged_fini, guc);
> -	if (err) {
> -		xe_gt_err(gt, "Failed to register clean-up in wedged.mode=%s; "
> -			  "Although device is wedged.\n",
> -			  xe_wedged_mode_to_string(XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET));
> -		return;
> -	}
> +	if (xe->wedged.mode == 2) {

wedged.mode is now an enum
you should use XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET instead of plain 2

> +		err = devm_add_action_or_reset(guc_to_xe(guc)->drm.dev,
> +					       guc_submit_wedged_fini, guc);
> +		if (err) {
> +			xe_gt_err(gt, "Failed to register clean-up on wedged.mode=2; "
> +				  "Although device is wedged.\n");
> +			return;

if we want to continue, shouldn't we call just devm_add_action() here?
some default cleanup will be done later anyway, no?

> +		}
>  
> -	mutex_lock(&guc->submission_state.lock);
> -	xa_for_each(&guc->submission_state.exec_queue_lookup, index, q)
> -		if (xe_exec_queue_get_unless_zero(q))
> -			set_exec_queue_wedged(q);
> -	mutex_unlock(&guc->submission_state.lock);
> +		mutex_lock(&guc->submission_state.lock);
> +		xa_for_each(&guc->submission_state.exec_queue_lookup, index, q)
> +			if (xe_exec_queue_get_unless_zero(q))
> +				set_exec_queue_wedged(q);
> +		mutex_unlock(&guc->submission_state.lock);
> +	} else {
> +		/* Forcefully kill any remaining exec queues, signal fences */
> +		xe_guc_ct_stop(&guc->ct);

this was already called by xe_guc_declare_wedged() before calling us here

> +		__xe_guc_submit_reset_prepare(guc);
> +		xe_guc_submit_stop(guc);
> +		xe_guc_submit_pause_abort(guc);
> +	}
>  }
>  
>  static bool guc_submit_hint_wedged(struct xe_guc *guc)


