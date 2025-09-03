Return-Path: <stable+bounces-177668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B08A4B42BF4
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 23:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD26B1BC4A6C
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 21:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA9C2E7F03;
	Wed,  3 Sep 2025 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYasEFA1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BFD2EBB8B
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935004; cv=fail; b=KK1YGpYahC293oHa+l39KyEOb2CS6YJaXPhEKZlAhG5/jx8D2q+N//wwSOLdwBujl4Z2WliL6qKafHLOuPt5h1C6YlHiqwS3YIUG3ad2gF0ZIGw3eRBBn9P53fcOmE3S89fYtOrkX1Wpzwoin0IqTsr/+of/Ig1yGlY1Quvqh+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935004; c=relaxed/simple;
	bh=UK5Cns0tfRrPLC7N89C9PDc0EOqHhSxbB1uyJ+8YTPM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sz/1G7/I9j+dAzcuTV6t7brOLQsxlfbPdCWvUP1xl5oK+OphEnGQaoyvJnsso0WkS+8Dcb6DILx8KCP7lH/MrCcNBmNjE69bCfCfOSL3bk1ujJjT/4Upw/XCrAhzdhGkjd7Kea5cJ0TgEgALrnvVKDbGqlmEJDn1GCJT+cdooNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYasEFA1; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756935003; x=1788471003;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UK5Cns0tfRrPLC7N89C9PDc0EOqHhSxbB1uyJ+8YTPM=;
  b=EYasEFA1fG89mf1ncDeyLjNmaHOc+EJBMX488iLaFybD0q7QAc9u18Oo
   z3uoxxZ6MF1Iz2z/yABMXV9x/KP9HFOMvbEpLwCjY9/t1MnMpBTywJWdq
   xzvYGcwQMRUNb+Hp/3M1AnPEmMVbPABAtBdPnmP2ElxaDPyVZUKOXOpJ6
   bTJ+LrvyFrGJABCA1FSnuXLS04Ua50AQbPtkfthV/YM6pQS5+zgG+UaVO
   2JzaRUeChDJaj0okK/kDizOWnI6MAH46CI6fS9ZN+i2DE6eS/7HJv6kbY
   rU6ErvNRq5tZUglu4xp2A8GqbxnUDrcjmTcR3byZY014g7aKzztKpy2qA
   A==;
X-CSE-ConnectionGUID: Xsnfl0jcT1uCRLHixjTxCA==
X-CSE-MsgGUID: 6zaj1326QuihHZU9KtGliA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="62908134"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="62908134"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 14:30:01 -0700
X-CSE-ConnectionGUID: 8iT1P6P7QiWTF9qePA6i7A==
X-CSE-MsgGUID: WBNz64iPTwqNXGeT3bnzGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="172073739"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 14:30:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 14:30:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 14:30:00 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.62)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 14:30:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELLRCV6AjP6vC/DlXJBts1/LD0TaaoHr7PYI1K9y5LaWLTVHeN6woMFFdDlk3ztKGltE807TB1zzRyHSZsJTWXrspsVXAqO0Akdi4tDUIn3j1QvwqRGuXqmAycgX6uVdcjd0NpP89fCH2xOhSzv17EZc8zG1ntV0TdTc+XT2xPmB8OkodUeM9TjSUdsMwH24qoYcR4ZsheIa3Hq/daAskzmWcUNCYfphl+IBivyjL8zKT5aFzERbHkFfqBuP0OrOQklPNfHXbeh8kQWT7eREnhdnYbqMyRROnFlTaeP5cxSyeFlvhJz0pK4WkSSJExBBp0te1OXe8VFIY1ST0fnU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UK5Cns0tfRrPLC7N89C9PDc0EOqHhSxbB1uyJ+8YTPM=;
 b=nFJgHUkJteAvRly0kAPDFhB+VoAPqO6w983Ez/a/dplz3zwKZ3F2cW8qdZczPbc0iw14KiNH4LWKMA6gSv6V75M3nZ29qA2qZBQAQ4VBqkCYmqgfh4tdxSC+NYfQshsM/SueU4I/kVSAj0secMCzE73SqH9WcEOVkLQT2QYbCoqkEV7sskwng+9UcZtDRo83ovl6ypQVB4k0jwYLeIhtro/k6w+hbhxVFYN0V02lkyKgwlpPhDB972MlUNKosKmooEfeOloxu7t4HxwIm+zIhkD6Xmw9qa8CHQmXwDjt2LIe+5JeWoZImDfxzqU9u2V//LKAjPVnDFXTz5MSunG6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7821.namprd11.prod.outlook.com (2603:10b6:208:3f0::22)
 by PH7PR11MB6721.namprd11.prod.outlook.com (2603:10b6:510:1ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 21:29:58 +0000
Received: from IA1PR11MB7821.namprd11.prod.outlook.com
 ([fe80::2ca4:29ad:f305:6fc0]) by IA1PR11MB7821.namprd11.prod.outlook.com
 ([fe80::2ca4:29ad:f305:6fc0%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 21:29:57 +0000
Message-ID: <52d8cd5a-a3bc-4ffe-84c6-4facda290cdf@intel.com>
Date: Wed, 3 Sep 2025 14:29:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe: Extend Wa_13011645652 to PTL-H, WCL
To: John Harrison <john.c.harrison@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Vinay Belgaumkar <vinay.belgaumkar@intel.com>, Stuart Summers
	<stuart.summers@intel.com>, Daniele Ceraolo Spurio
	<daniele.ceraolospurio@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, =?UTF-8?Q?Thomas_Hellstr=C3=B6m?=
	<thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	<stable@vger.kernel.org>
References: <20250903181552.1021977-2-julia.filipchuk@intel.com>
 <20250903190122.1028373-2-julia.filipchuk@intel.com>
 <2cc4dece-7bdb-4fdf-a126-d9e311ca74e6@intel.com>
Content-Language: en-US
From: Julia Filipchuk <julia.filipchuk@intel.com>
Organization: Intel
In-Reply-To: <2cc4dece-7bdb-4fdf-a126-d9e311ca74e6@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:303:b9::30) To IA1PR11MB7821.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7821:EE_|PH7PR11MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8321b9-c833-444e-344a-08ddeb3107e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHVsUmlzZHFNZC9UWXdTNWQ2dW1MaVZCQ0F3NmtONlFxWG5wdFgxL0ZLM0R6?=
 =?utf-8?B?eXV4MFN5TTRmd2NySHN6ckN2MFRzcVVlcTJING9iY21wRGJUOFhtVnNwdVFz?=
 =?utf-8?B?d3NlM0ZQVTdNUkcraGxOci9RdEZUUUhxR0d5WDNBVlpuNzQvSUpvK2JFdFk2?=
 =?utf-8?B?RnBvNm1PaFJOanc0UUg4WHRSNi9QU3owRnZBWDdPUVdBUGpVeW9aQW5zT2dx?=
 =?utf-8?B?ZjJCSnRWc09uc2x1SU9CUkcvNXJxTjFvdzVma3JuWjJLaSswTWl3cjA3SmRL?=
 =?utf-8?B?OEF4akhIVUVsNURnbEVLSmx1aWY0RnBZcFllbmdraGhyTGpvOXRHL2plMmkv?=
 =?utf-8?B?Q2Q5U3VXSngrcDJLNWszeGN2c3dFeWdsY1Q5bEdsaG9wdDBSaW9IUjhNL3Fa?=
 =?utf-8?B?MThEL0M5ZThQQ1RJVDZPYmNjYVJUODRib2JEN2tsaVFSSTVDTEZuN2xUbEs0?=
 =?utf-8?B?Q1FHcWI4V0xXYzhLb3MwSUxqMEV2dml0MzNUZEIyZWFjamxDb05NWWY1YytM?=
 =?utf-8?B?aFNNbnpUdDlHVUtER1NKOHFFbXVuUVVqOC9YaHRQYk9rdmxiSHk0SWJvOTdP?=
 =?utf-8?B?MWp0UVlDNXhRUlFWbFIxSGEvL0NrZlZJLzRQRE42N2RvdmllMFdUWE0yVEZT?=
 =?utf-8?B?dEdTcGVRcnVhUGxjcUxRbFRDQXZyVnhZdnRkSEw0aXJEcGM1MDBJSzRoa3hR?=
 =?utf-8?B?akhKdjJSSGJUQy8xbnJ5eWI2bnBybVBtN3NrVXNCY0RUaWFyeFIwVnhCMWxu?=
 =?utf-8?B?ekNuNU96VFRVVDNSamx0Vm5zcmJianEwaTcyRlJBb0I5N1RCSnlDWi95V3Zv?=
 =?utf-8?B?ZWh0Wnk2T1pFNndZMkc5b0ZmbGpZU0FRWlA1cE1aTDhJamNFOUxBd3plaFhD?=
 =?utf-8?B?eE90SW1GTVlQQWowUW50RXFSMkQrcjRnaFpwVFdxTllnUXB1M3ZwNEtqY0ZV?=
 =?utf-8?B?Yk96WkM1bjN1cCticUJmTU14RVJiMzhMVmNyNFZOL0lTazBJbnJPRmUyQ2ov?=
 =?utf-8?B?UUhwNUdlQjczQ2htVWdiV0lmcWhPUFVaQk8vWlRRT3k0SWNha3F2anorQUJu?=
 =?utf-8?B?RTdVUVQrUCtSQnR4eU1HYW1jaEJMYlV1K2ZXVjhHMnpPWWJRejFnUWNreU5H?=
 =?utf-8?B?T0grN2lQdmg0T213Y2pBNEc4YXdVb0tXZDVZS1RxbmFrK3B6OXVTMTkvOTJJ?=
 =?utf-8?B?SW5jWTd3RnhYOUZUOWcySldHYnpOWllqOGRVNUhyOHpTeDMvVzUzWC90dU9W?=
 =?utf-8?B?RmRpL1JvbjBzalY4Y1JIeUtHSzkvS0diNzVjNjhsaEJyTmhjamJwNEozdllr?=
 =?utf-8?B?L2hsajJPa1JiVDJ4OFVWeDZMNWhhY1hNbCtRMUoveCttVXhDeVdDaTB3dVRr?=
 =?utf-8?B?c0lQeW5IMEtmK2VaTitDdTc3MkdpUXNjMTNmK1l4WFpWN3BRdDFoU0w0QkpN?=
 =?utf-8?B?ekVhTXVPUUxoWlkxVnhxNE85MTBkUGxoZWsyeUxpMmovMU45bzJWUmFDUWJI?=
 =?utf-8?B?ZVRvRTluWGZXNGw2N1ZLbVd1amtPY1RiRlNvck1INUFscEtKM1dQMkhLTXc0?=
 =?utf-8?B?dldOVDFzTkp2U0NIWkg5eTNzZ2Vud2NyNEdDQ01QUlpWenFKTUFsYytIUjdv?=
 =?utf-8?B?WGNGRWxZU0ZjcGF6aHd5OGJFeGxILzVuZWpiK2ZZOXF6SE1LL0U2MTRVVUtl?=
 =?utf-8?B?STVhYWpoUzdleDEvMlVKVEJySjd3bTBGQWFSM3BCNHR3ZlU4SGpLTG1LK0Ix?=
 =?utf-8?B?Q0tJdkJOdDZnZlFSMWx2VWgwdWsydkhtZytnTHljVEhqckZNOXBTOVpaU1Rx?=
 =?utf-8?B?TjNkS0NwZDlhamNPSm9ZSkFBWWVKL2FQeWk2TGJIU0duTHJYY3VzdXU5ZWkw?=
 =?utf-8?B?bFVDbUxtMExkRDZBcWRkNEVhZVRETUtlNng4YlRBRzFzdHl1c1FtOTE1alFh?=
 =?utf-8?Q?JU4KWJi4+es=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7821.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW90Unpqc2lkejZvbjVMUFNEVU1rRmhkTk5MdGw0dXBmTFRqZ1ZvelNCaWFw?=
 =?utf-8?B?QXpaNHpHdlBXbStmaGNSVGJQbjAvNDNhdStGRzNRcXR1NEdtMDBaaXBDSFho?=
 =?utf-8?B?Yyt0WkZuakVtZENwcFgzb2VWSkJRRDFtTDhtZlBWSm1kVWsrSVpYS3RvejNI?=
 =?utf-8?B?S0J0d2tFeDV3cy9SYW1INGlpUWVVUHdzTXFzbHRIU29VNHI5bTRIK1pyYTVs?=
 =?utf-8?B?U0ZIcTZ3cGkza0x0c0E3QmRxd0grRFZHanJnNWtTTTdianZNN05FZUNRYzdZ?=
 =?utf-8?B?c0VsV2s2Sjl4UFVFem44SGY0MkF2bDN6YU5KdXc2dFRwdDZLdWZDY2xLb2xM?=
 =?utf-8?B?NnZVYXhSZlVncTBuaCtnUEpGczFoZnZwWE1RdVJmamZoTkczNFhHY1VGa2JZ?=
 =?utf-8?B?L3oxUzBqSnAra3dlTS9rdmpRU3NUcXdMdSthMUNUOEt0MHdwSUZMOElCTm12?=
 =?utf-8?B?OVBkck9BOWkvbkErcGVKeEs5OFpxeFFlRytrTXJHYnBxYkNacUdvNGdWTlho?=
 =?utf-8?B?WktmUm1jbVJJeHRiZWRKRi81d1BiSGFEU0VFNXFTeGwwNVVoZVNubXNnSG83?=
 =?utf-8?B?SGMxUGtRb0w3eHZVK003WVZRakVFQkNqR2xXc28yb2JHWGZEdXRYcjVuMy9S?=
 =?utf-8?B?S2xlbHB6TmxvVGJxT1pNaXlqWEx2V2F0NFF0cjZwKzcwLy9pc0tkVkdHc0Np?=
 =?utf-8?B?MlVsVG1IRlRkeTZncUIzUHNHS3pNL0tXcXdrMzdJTHVsaW04Q1c1UFUwQVFT?=
 =?utf-8?B?bGtLcGp6ZEg3WTdWYmhDK1RtcUJkQXR5Vkc1RU53N201VDJBb1lnVUhrL3FM?=
 =?utf-8?B?SDY3UHRIR0FCY0REWkxxMVBYL3VWWnNqMFRCakttY3pYRkZoSU1IZDErV0Vv?=
 =?utf-8?B?WmEyb0NiSzc3dG80TGNybnJoY3ZFRU54Wko0QXgzbkUrYXNoODZmUnk4dnRi?=
 =?utf-8?B?N1RxOGJlSXpkUlBrdXowOXlBWG5wMzRPdHVEME1ocjR3UEFZVmx6SjBNWVVm?=
 =?utf-8?B?Z08wMEJhV3hwNTYrTTh4YXNZUDJHV0ZZeDR2ZTRpalNGdzF6N2ZUR1RYSTdl?=
 =?utf-8?B?eTFiVjV5aFF1VW9UNXhjVHdnVzhseG1MU2NzQUc4SnE4Q1k5L2h3cCtQUGlh?=
 =?utf-8?B?Yml3U0xZaUpodkgyMlBNdVpxWHU2YzFjTDhnZUIxRDVZUkJrTHpLb2RuNnBU?=
 =?utf-8?B?TFAvdmc3VkJMWit5cElBazZ6NG5SckJsUDFpclpJTEYxZE5WT3B0bnAyWGZW?=
 =?utf-8?B?VDIyL042RjZiQzdLRlFaZXJia2xxOUFxMEFOKytraS9hazJYbHVlRTBRUDVH?=
 =?utf-8?B?VlAycVhTbHV3NkhKb3hKZUpIT1dkV0ZnTVVCdXdVZ0o2S1JodTErajE0MFBV?=
 =?utf-8?B?cEFsUjRyMVpka3kzcnhqaXA2eG84LzJVdmhUdjFkUEgvMEkvbU1yeHB0OTll?=
 =?utf-8?B?MkpxUEhZL2dlYTY1RkljVW55MU1NK1dLZXNYSEZDa3Iwd0M1STRSVFpzV1kr?=
 =?utf-8?B?bFhCak1pajVQbXJmZkVyVmNKcjhKL0VCRDZqVTh0Tk5EblB1OTY5dFNaRHh1?=
 =?utf-8?B?K005cnE2Zi9GdlZ6WVFSQmY1b25CczI1QVFXSmNmSzEvenJsRnorWGsvSjR5?=
 =?utf-8?B?NnlrSFp6b0ZrVUVEb2Z4YUs3VDNLa3g1dUV0ZDRROExsbDA5cUNRNSs3b3Jh?=
 =?utf-8?B?OXVyblZraHVsdEtrNU9JRVlLTHArMVVQUUhCS0lGbDRsa0pjd1owZmF2V1kr?=
 =?utf-8?B?Nkt5N3pNaUF5amxqTFc4RlRFOFVrVXlScWtiemVmelVRRE45eWFxejRjdUZw?=
 =?utf-8?B?ZkN0NVlsWUY5N1REUEJEWEx6R0VMalh1MER3R0tXNzJFOGtGL3RSMGFOTFNI?=
 =?utf-8?B?NGJKTXBzL1JEZWRWTkMxeW1Ya2VkamxHSlFHd2Y1eTBaTkhPelE1UlRyaTg0?=
 =?utf-8?B?Vmh2dlJ2cGhLZjRoaUlEcjJta0JxUnZOZTlvdEJCa0tiMDl0aFk0UGhuck01?=
 =?utf-8?B?MTB3eFhzYTVCMFhHQVdlWWZqaXVYSEptT2R0S3AwdUpEMFh6VDRJRjB0RmtC?=
 =?utf-8?B?TDViYlgrWVQ5dHRkM2NJczROTnIzUVFmRjZOM01qUXZWeEE1dTdqSnlEY2dy?=
 =?utf-8?B?aTQyTUZCQWZPSDNuNnlhRWE5WlB4SGloUXJJZjRhMzRjbFhDWkpJNHVwUy9L?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8321b9-c833-444e-344a-08ddeb3107e8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7821.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 21:29:57.7977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6RnKdelqv8I0Qal43rh9lCUQO4WlTWp0+MXhqvKFI/tDtTHGGHX7iMDfUxUvqLLDozGQwYfzJmL596jvk+0/GrthXzKwg2mPIuw3DNE2sI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6721
X-OriginatorOrg: intel.com

On 9/3/2025 1:28 PM, John Harrison wrote:
> Does this count as a fix? If we are just extending a workaround to apply to more
> platforms, that is not a bug fix of the workaround. It is more of a new platform
> enabling patch. Indeed, if you send this patch as a backported fix to older
> kernels, those older trees might not support the new platform. Which is
> therefore unnecessary backport work and extra confusion because the tree is now
> claiming to support a platform which it actually does not.
Possibly not. Just intending to send this to the current mainline 6.17 with
backport not necessary. The workaround would still apply if ever loaded with
older kernel.

