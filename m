Return-Path: <stable+bounces-177663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1997CB42AE5
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 22:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81D45831B4
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 20:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5C32D9EE2;
	Wed,  3 Sep 2025 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9pFNudA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EEB2989B5
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931323; cv=fail; b=Bw7RQ89uFKu600fdbUP9/4laYTcxDf0Ye7itFnDBImUYH+LOAs/Wf8xCQoyD6M/YJlPFOzS49AwN0FPrLvOIIQXY9v2xV3gZg8D5o+IqxaHXi7hxO8atQvZr1f1vEqxq2CUp/8nZY7uCqEL+WxdgH6zzYQ3TyS1Zezccz6f4oQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931323; c=relaxed/simple;
	bh=q4gcBPshosyLpi1fJe395YLfAz9Li8WOabcmVW2z5FA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sF/1K5FmPwJF9xUzDi5TCYeHWbHyWUmQprkFWpzPtZTJBA9v8LWwSDqvpQtulTA9eBMXYYLQNTqxcg4XlXFFzQbX2tnzMCpDVSj5ba202TdpokAPU7ZRzS4HV8YmRmTUjNNfpF9eSanHYPBlQ7GE+NG4V1/0O5K6QB60o6gTjoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9pFNudA; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756931322; x=1788467322;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q4gcBPshosyLpi1fJe395YLfAz9Li8WOabcmVW2z5FA=;
  b=j9pFNudATW1MFhMZvpsB8ADtx/LIPmorQ1EAmtuUaxav95Ixahb3ysU4
   gJ2sQs42CA0a9sXUjQ3JRqTnK+wCFj3Fq9fhhYVE0+tTEXyYijyFVjC1i
   XwxGsqrM+WHTEQsSPFFoOe5XJeh64fOTDLdX2mT1fbPrDLlxTLjTO2K3X
   JSjrvs5+1e8+PYHfLWksm2W1aj5DGKSK46r/zbt8BYc9X383MMxvF9rF7
   YCWK0to3o0jGyllYH6aq9iAx2i9mv1BbwUqj/LZ1a+f9BYh3fqiEiPyPH
   Umc17/r2QE98kqKD3sRyYmKkvkNDjpotokurny4mD5TkQJgGutFaqhoXU
   g==;
X-CSE-ConnectionGUID: VmYiAoG5Rd6fUzOiMbS7nQ==
X-CSE-MsgGUID: DsF0GLygTa6ABKub5jDUaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59198837"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="59198837"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 13:28:41 -0700
X-CSE-ConnectionGUID: Cl/Fylo6SWKBt2ga/x2N7w==
X-CSE-MsgGUID: BfxNpqi9QmuToxPOccJxzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="171249453"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 13:28:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 13:28:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 13:28:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.82)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 13:28:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrDu2vZy1l+gAe7PGLDFDrV2+ATEecuRZJCS4Lwfw64sOEIzxN/sRfFSf1GJHKwbrhIxLWFJ/945Q13IjonvwnD/UbKPL6eukGG9zO8XzG1acm9Ub8Ew7dGVQJ5ZnerWoNiRRCWfTuTDxzixpP29Jd9UqUP68csFGqfTsbJPIusKwF5/0P4dD0RKlTQCqqLkdykbG4nfRxXhqvebtsSknwodoNGIBTI9CAECmNczXfG7nnIRoBnpu4FZcM2o4AtD0HPMmFLuHT6evYgZ+ar7ToVuGU7wpoWPK5EfRHJoZ1TNuo1nBqtdAFS9wb2KbWxbORlCDehyH5RwN6all5MdTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLwj292eN09W9Hu8oAheyiqi/RX6TvvHvbwz2kQGPss=;
 b=n8deI4zpNi4bYArVwv5SjGLBGigFiC2dVsbf5uDb2oZHUSdA03f3Yei7lW0jEAcJvCp3P6YPKaeo/U4UROrJDDk07v/4FPKP2EVdmdr8Lf2eDfeoN6P59PEzr1Qd0FK4SEBX+Z99z5hk6Gg96TZgv5bnFZ11dCrvgaxiOh7lu3Wqza26v5hUhURvqFqiuyiRJ657MynAHTk+2105yU6J8gltk0ceYGMg9RlybQJGEPI0GzRNF8p/9+or3so7iieCw0/LDINJMcBWCzKjdJjLJtaZgkCLlPddLge3bqGdUaeJXpCfObhShc6cP7W6j+l1Wp/fVXW2sOtWA0FtpAyynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6391.namprd11.prod.outlook.com (2603:10b6:930:38::21)
 by SJ2PR11MB7716.namprd11.prod.outlook.com (2603:10b6:a03:4f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 3 Sep
 2025 20:28:38 +0000
Received: from CY5PR11MB6391.namprd11.prod.outlook.com
 ([fe80::d1d5:6fa6:9a2d:92e2]) by CY5PR11MB6391.namprd11.prod.outlook.com
 ([fe80::d1d5:6fa6:9a2d:92e2%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 20:28:38 +0000
Message-ID: <2cc4dece-7bdb-4fdf-a126-d9e311ca74e6@intel.com>
Date: Wed, 3 Sep 2025 13:28:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe: Extend Wa_13011645652 to PTL-H, WCL
To: Julia Filipchuk <julia.filipchuk@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Vinay Belgaumkar <vinay.belgaumkar@intel.com>, Stuart Summers
	<stuart.summers@intel.com>, Daniele Ceraolo Spurio
	<daniele.ceraolospurio@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, =?UTF-8?Q?Thomas_Hellstr=C3=B6m?=
	<thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	<stable@vger.kernel.org>
References: <20250903181552.1021977-2-julia.filipchuk@intel.com>
 <20250903190122.1028373-2-julia.filipchuk@intel.com>
Content-Language: en-US
From: John Harrison <john.c.harrison@intel.com>
In-Reply-To: <20250903190122.1028373-2-julia.filipchuk@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:303:6b::14) To CY5PR11MB6391.namprd11.prod.outlook.com
 (2603:10b6:930:38::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6391:EE_|SJ2PR11MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 6886ad5e-55ef-4cd5-cde3-08ddeb2876dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vm9Ka25DaHlvYXJHWGhNaDYxUWtNbFA1ZGxBcXo1aUprTUpEeERsR0tCcG5S?=
 =?utf-8?B?OHJiUEVnc0g3NWJxS2NmZnJRbm44bE5CZjdNRnJVMndqZ3k2WCtDbUYxcUEx?=
 =?utf-8?B?dzd6blJzWHpBbFFzUk4xV2dGTTU5WDN3R0FUVFpOZE54Y1haTDFBVllTVkVO?=
 =?utf-8?B?S25ESW5pVFlyZWtZQ1RXTGliYS9kTGlqZ0JnOWpzMS9RZTB5bXY1clZob1dh?=
 =?utf-8?B?MlUyUlZXQXdOWlRxQVp0NkFsVjk1SDRIZjNzYjFjZFJ5NHlzSVk3R0d2bmxO?=
 =?utf-8?B?Z29uem9jdStuYWN3dmNUWkJzdmNtQ0xGWkdvSTZQZFE3cVFCY1ZNdXQydkJD?=
 =?utf-8?B?V1NRUGk0SzI0RVdwRDZYam8rcEo5U3JDejJlZGdjTmpvekFmM3Mxc2ZLTC9F?=
 =?utf-8?B?T2p3Y0RIZXp1TmF3Ky84SGcwZG8wWk51aG9Yd2psbXYxa0JNTkdRZHRJTFRR?=
 =?utf-8?B?Zmd4UVNOQVd1eXZhNDlsUkNxdHRsdXZqZXYydjUyM3hudXlhbm0zUW5sZWVn?=
 =?utf-8?B?RTkrQVRIbWt5TjB6QytOVHp0SVdOWlVaVjYxNDFtSkU5ZWVJdDlJZHlxVS9u?=
 =?utf-8?B?N2dGVk11NFRySGVMZ0p6L3VwUHFHNExMMU5MYUdyU2ZlbHEwTmxFQnVoSUVL?=
 =?utf-8?B?SGlOU2tWcEJkVjF4ckRoLzMwZDBxTG9uQ2FndlAzN21PeTV1M1Z4dHNqZ1Qr?=
 =?utf-8?B?R3Nuck5XWXFTTGhCd1JmVW9tS0VlNEJiMXlwVzJ0TkdNbWdLRHdPOXF0c0NE?=
 =?utf-8?B?ODZMYWZ2TW81OUpiTkZYR0orbjZlLzhvMVlZQXVUejNNTFBHNGlXRHhkSW5t?=
 =?utf-8?B?OHdhRlVnODVDcFVYVlhiUE8rNTByLzFiT0xTN01oL1IwS01yYzZBbEE4UkFT?=
 =?utf-8?B?Q0dZbUJqR3lRaFhOK01MMHkzYVZYWW9PWGFRVzA2UzV5S09RVWxLR0h5Q0l0?=
 =?utf-8?B?M2RFaUxRekRuKzV4TmF0dlFjNXU1N0lmbm9VcVQwaXduRzJkRkMvZkpJM2lX?=
 =?utf-8?B?Zmt6djRsOXRsZzNZTyt1MFl6VEV3THR6ZTczcHovSDk1ai9oaVBySUhnOHA5?=
 =?utf-8?B?RG9nZFMwRVZaYVZXZEFOVGVwd3V5eVN2RW8vbGtvdmI2NmZyOE4yVHVtQUNk?=
 =?utf-8?B?dlNicG1YOXB1amZkc0dpV1dxVW91SWpaZjhOSkxIdXdIZEtLK3lWYjNRbERK?=
 =?utf-8?B?VWN4YnM3Q0tDVjVMZnN4Sis5Y2JxODcxN0FaMUVZWG52S0x0NTc2a1d0UXEr?=
 =?utf-8?B?akIrL2x5dmorbGJsVW51SDZOT1RXSGh3bU1HdjNGZ1kyOVpORnZuZkQzMTV3?=
 =?utf-8?B?eEtvVlp4cmRFRXNIYndrM05RYWszWG9TeEYxamo5amZFQWFybkZWcTVLZ0VO?=
 =?utf-8?B?aTlJbWI5dHYzK25xb25TNEtXdTN6cWc2K0gzbktrVzhRTmMrTHdqcnVQOVd4?=
 =?utf-8?B?aU4wUHhGc29wUkJkUE01T1BET1RTaFFsUStBcVIrS3VBUlVYNm1STEc5U3VY?=
 =?utf-8?B?YXhIbEYxaHV6RWVZVnYyTVhuSVZQazgwVkF6MEkrVldGdU9sSTR2TE5QZzVM?=
 =?utf-8?B?ZHo0U29xbmdnK3NmUEUwQms4NEkxSnZwdVp4K2tLODVHcHdTVys2ajNNcjFu?=
 =?utf-8?B?M29XM3hQQWRWTDE3bTNucW5qejhKYUhLMVg1RWtmOEZFYlB0RUpUYjl2QlZT?=
 =?utf-8?B?a2c4QmkwOFZoMytha0FtUHpXQmtWQVRldUtXR2s3bVdhT2dGSkRZNlBPbkZP?=
 =?utf-8?B?TjY2MjBvR0VaYm1OZUVnSWNKNUlGN3FvWEg3L1VYdkVHUlNuOVZrMG9TRVpG?=
 =?utf-8?B?TWZSYjhJZ29xVUlWUERXN2tOVFZRWGlJbEI1WW53QlRPZ3BSaE52TUZ3MXVX?=
 =?utf-8?B?aHoycFE5ZXpjVFQ1WUU4WkxLRTc0MGVjMlpITHZ2ODZhYzFrc0Q5WUJldkRN?=
 =?utf-8?Q?maMQQqvj0Rw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6391.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXZvTzNVQlZnVEt1MXBMZ2xDaEtEWllFc2ZPM1JsVUZMWHZSWjE2ZmxveWFF?=
 =?utf-8?B?Q2JSajJGTXpPSkJJWHJFRGdURnF2eXhnR2dmRnVMTC8yNGFZNXl3WDRrUmxn?=
 =?utf-8?B?Q1dIVXlkbDYzZi8ra3VTd2tJK0lYZGFiU3Ewc3U1dHFHODhwWi9GMHNzcEsw?=
 =?utf-8?B?UEpCS29wKzgwUmw4bEFydFg3U1ZGTXJsR2FWMGx0R3VTeExWV2FxazBGVUZM?=
 =?utf-8?B?bzF1c0hHRUVLWjNyZC9udVNrUFpSYnhFenVtWHRrUTRmQnUxS3JsQUl1OW5m?=
 =?utf-8?B?a2laK0lSSXFwbHFiUEtpMXdyRVFuTm5OTkxFT0ticWhULzBZbkVzRkNDTGoy?=
 =?utf-8?B?aDRIYnNwYmI0OEEzUE0xVVVzeE1JdDZVQjdKcFBlWm5YZkxjQ1NoUFRoTlBn?=
 =?utf-8?B?cmIvNEVXMThOT0JXZ1Q5bXJFemRGK2kwZ2lLZy9DZjIwVGJEekNqVUkrZWFr?=
 =?utf-8?B?QVkzZndNWHc0SXBZbkgwZG9JUzFtTVU4ZTVESnZ6c0d4bXMyTUpUY2FUbzg2?=
 =?utf-8?B?TE9GWE5DczFuSXNXeERobHluYXd2VWFOa0R5RXFidk92V0FkYTczMmU2b2ox?=
 =?utf-8?B?R0dDc0NhYzFQSXJhWjFEZWdjdkNsb2F4V0JCUXpYSTlBcFgyOW1FRm84Q0hh?=
 =?utf-8?B?TFBnWFNXblQ2TW43T3pNU2w4eE01VkpYVjFNZ2hHOUVQNno2MVVYUXZrbG1i?=
 =?utf-8?B?Vzk5TjJEalpDZVc0ZmZWMTlPSWRJR1JSdk9nQmdVVkl3Zm9kL0ZyS2lwa0Uy?=
 =?utf-8?B?NU1IcG9DZWxUK0U5aUJwL0hqOHk2V0NXZkVRcis2eHhsR2RrMGRkNTkydy95?=
 =?utf-8?B?WU04SSsybkZuUUdlNC9vN3h0ZTFtUlR0ZzIrdVJ1Y0hqZ3JXbklZLzFrMG1t?=
 =?utf-8?B?R2NVUVBlZnFCaDIxQ1JCQzc5bldiTnk3bUZCalBJTTBpN3ErdXB0MmR1K0dy?=
 =?utf-8?B?VlplRXdzVlZyQlFqeVZ0R0taWXQ1QURvTzFDUzAyU2ttdTEwWjg2d0xJOFNy?=
 =?utf-8?B?a0JxTlhnemh2ZG9WZDR5YkUwNnN2TjIzMWs1a241aVNqSGRlZ1IxV3lnV3k5?=
 =?utf-8?B?SDZXeDMyMXdiT0ZOV2dCREh3WmJjSTBYRXh6MGdVR3Vmc09tczRKbHRteGpj?=
 =?utf-8?B?Yi9lZGJCWS9ZUTJDUWxLaGNIRTVRd2ZUQ1ZadlBkblU2MmZKWUVmOWU5VDVB?=
 =?utf-8?B?VWg5MEY5WXphenlQVWdmbGlQemRqUnpaSWZORU9PT0FlQURsV1ZUWWllZmtO?=
 =?utf-8?B?MDdReENqbEdKWWlHSStBbUFBN25oeklzMitJT3lpSFV6aVlmSG41NzRlQlBx?=
 =?utf-8?B?QnBkMFhlbGh5VUdnc0t6a2NYcDlmaFZRU3F1RGNkekRXSkhnVk1sMHgzeVVp?=
 =?utf-8?B?NjkrTk5PZE1uWm9MWTFmZHhySUNvQ2pSTCtJVVFHTU9EOHpZQnpRWUF4aElO?=
 =?utf-8?B?Z2F6YU5oby8rZFNBV0RMdHpCOUp3YlptalJJZDZVREhITElpL1c3NSs2ajUz?=
 =?utf-8?B?RWZDYUtVSFFFbDRvWTdTOGtpc0NBQzNOclE1S0JBaHNTR3BLd2MwNlJWdEpL?=
 =?utf-8?B?V25lMVFtNEh4Nis1Nk13K09raGhOc3I1S2lHVnlJZTZBZDNTcXFPNUs2cWdt?=
 =?utf-8?B?Qjk4Y1hWTUliNGpjVWhMT1UvRmx6MFUrbUluVWV1T2hqajR4RjlZb0NGRFF5?=
 =?utf-8?B?QncrK2tGdEEyTjF2N240MzJQdkp6NDlOZ0lBUDNJdmViL3FOOGJldXFxWG1o?=
 =?utf-8?B?SmRkbkVsMWQ0L2ZZUnFuRFB5MjdNQWU2TUdJZXpTZEhCdXQ1dVg4M213QlhR?=
 =?utf-8?B?VElVOXhHays0Y0JhSGlWYThlV2hpMlc0QXhWYnNhVmp5cFpXT3RxcGc1ZDZt?=
 =?utf-8?B?ZERiMERRT2JtcEdXcnJqSnEzam1MbFZwalFndDhVeWpLbTIzUlE0YWk2aTVS?=
 =?utf-8?B?YjJqVS9pcEIzbUNUVnUrVnBmM2YxK3RkOTllYnNERUlqc2grYkVUWU43QjRK?=
 =?utf-8?B?RXAxRlRZN0JLYU5hSFBJTE4vYVdBSndUV0E0MTVDakJuV2xFMXpJaUpuaDBM?=
 =?utf-8?B?VHVkTDlmVHk5Y3JFVGVENFp5Qm5HVXFTVy9DTERQSUFlQWxLcEU0K2UvZi94?=
 =?utf-8?B?VVY0Z3lqVi9EVUNWTzlCWExHakJLanZWZk9OeG85K2p6cGpIekIxSENqT0ho?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6886ad5e-55ef-4cd5-cde3-08ddeb2876dd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6391.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:28:38.3468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //guIFXpTZ4yKPCQn5zb/NAk3vKwUyKb3d/68Dxye4VL3A0izUPHgX+EHLucPMlgB9AKOkFNvUAZhIBHUhi95c2HPWF3YQS1tc3hmTWB6zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7716
X-OriginatorOrg: intel.com

On 9/3/2025 12:00 PM, Julia Filipchuk wrote:
> Expand workaround to additional graphics architectures.
>
> Fixes: dddc53806dd2 ("drm/xe/ptl: Apply Wa_13011645652")
Does this count as a fix? If we are just extending a workaround to apply 
to more platforms, that is not a bug fix of the workaround. It is more 
of a new platform enabling patch. Indeed, if you send this patch as a 
backported fix to older kernels, those older trees might not support the 
new platform. Which is therefore unnecessary backport work and extra 
confusion because the tree is now claiming to support a platform which 
it actually does not.

John.

> Cc: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> Cc: Stuart Summers <stuart.summers@intel.com>
> Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: intel-xe@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.15+
> Signed-off-by: Julia Filipchuk <julia.filipchuk@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_wa_oob.rules | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
> index e990f20eccfe..710f4423726c 100644
> --- a/drivers/gpu/drm/xe/xe_wa_oob.rules
> +++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
> @@ -30,7 +30,8 @@
>   16022287689	GRAPHICS_VERSION(2001)
>   		GRAPHICS_VERSION(2004)
>   13011645652	GRAPHICS_VERSION(2004)
> -		GRAPHICS_VERSION(3001)
> +		GRAPHICS_VERSION_RANGE(3000, 3001)
> +		GRAPHICS_VERSION(3003)
>   14022293748	GRAPHICS_VERSION_RANGE(2001, 2002)
>   		GRAPHICS_VERSION(2004)
>   		GRAPHICS_VERSION_RANGE(3000, 3001)


