Return-Path: <stable+bounces-107794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBDDA0375D
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 06:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B55162223
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 05:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2259F1DE3D9;
	Tue,  7 Jan 2025 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLF3IJFG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F010199EB2;
	Tue,  7 Jan 2025 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736227881; cv=fail; b=IP9mgvh5UPeUGYxDXIl7blXSJXHvGdLhA7+qq3ITEyeHLLyDsqabkwiR4nFpFqS0d56GWwe0CZ6MrFdR+Cs5BAVZBuAOuYR3Isk45IuW0uXsK7Db3xMV575dqy2U+i9DxWthMX9UwMqmP0PtNV49QfLO9mR0UV6UcjpblXJFAdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736227881; c=relaxed/simple;
	bh=+dRfovbsQXTF7w3ovrWiJxQYNRNibhQ3xvonI3nrSbA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ro69LHTUILeL1nPoeC+OuUiQcBw8vCyaifva5rnV3xTLR1vRV4Iml6YWzyoUaW5anV2tF+YnmgivehN1qDDo17fJXsmj6JHF56AtdtqIdTwimS8Vg6mZraP9S4TFgXpFiDSW7NNeP4SKpHQXDJux80XY4e+EkdsNoeRus0mYh0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLF3IJFG; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736227878; x=1767763878;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+dRfovbsQXTF7w3ovrWiJxQYNRNibhQ3xvonI3nrSbA=;
  b=CLF3IJFGUQv9OP8/WaLcLHgNxZ5ahdJk+x+s4ovQljS8a5AidDrZHcCv
   mD6JXgaxa6CBF7J7BmOaAulWmTZRu3lDKBwlhErt+NSMbNTmRffCKITkr
   En4EZpJ5ryzataqI9rRuV+dv5+Xa2JShcvLYTKekjYdH3dxhCt87CS488
   0D4KiKIPAB9rDDPLF+v9GeqifUW4BWnuIrYZkWMjTuL17zs0SyYF9AW2M
   ayj4GiJRSU6d/DgBFc2cenzFy2Prd1MzNAYRdu1uNpL9snil28PZo+RzS
   0a5UgQvoTClRStvT9as7SDBak7aBS8vR+u95n6r0X1274jWYwvnyk+sKu
   w==;
X-CSE-ConnectionGUID: PCUAFaDnRf6TR+wAsIVH4g==
X-CSE-MsgGUID: N7utlL7BSNu8ddUUvWosFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="35692644"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="35692644"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 21:31:16 -0800
X-CSE-ConnectionGUID: ODRTfoDoQpmp6GFyHD4yyg==
X-CSE-MsgGUID: bVwiUbpeRB2dYO62pskzLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="133516307"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jan 2025 21:31:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 6 Jan 2025 21:31:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 6 Jan 2025 21:31:15 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 6 Jan 2025 21:31:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVxARsW/R6ByOYiab5Kh8OMa8eIxv6f7R0R2vup9+1jU6pKXgp19qWPv1yZhTiTR75qPzlNachLPIW/Hn3/AVe5of2oU7zFE9o0YtajhJw5gbqMDr3iP725x1lVtK7aEfXbw7rpYKvu/66D5doO8IhuUMTOq7jH6gO9RjzZgVZE5kC3PvCxoSw1iy0WOPjyd/ecIEmFxc4LmTCK/Y2SQS7CvUBcXltvUEZT5W3ZEz6A60RzYDv0qlzeWL9vglRusaFBUEziZopWQ+PTeo+GwU63wpclIaHXUjWXVK5wwfQeT2HonMfft0uHBx1sekkeDlOM61EJShKNhwfwHDX7ZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdIxp0n4vwiA/9GCDOmV4ui8N68W5VMyy3dJBJn88ek=;
 b=RJUOnAsiiEcEe18En2hSEGzOIgN3Lp2e0FtTtGwXFOLgZ2jRE4e5C+HGp0rJbK3h3US8QUBRddr2w4v+p/28BwnbX0Q+gmk7biXR05cIeqZlErOxI8rwSS//SvzWmhNWp6WyvTRjwfL8XCH08NuLPXnG9ZQ4NOyL5SAk6HOhG4U2tc+ofnT0zzV5OMf4q3KxNVqTGhWdZo4d3VSC+uCEtzwaWur7IJneZlbGIiqAYn5gz4dN+6RQyJZKIlogJCbXmIPGtlMaACz8DnmypFxyKsWyUD8mZ+ZCy+gXBcNQp2kfTOaPKAsd2kwSGW7+6cEbGmgfhb2mAinHm13p+0QPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by MW3PR11MB4746.namprd11.prod.outlook.com (2603:10b6:303:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 05:30:53 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 05:30:53 +0000
Message-ID: <ea9b90d6-127c-46e1-8978-f984f77c57fc@intel.com>
Date: Mon, 6 Jan 2025 21:30:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netdev: prevent accessing NAPI instances from another
 namespace
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<stable@vger.kernel.org>, <jdamato@fastly.com>, <almasrymina@google.com>,
	<amritha.nambiar@intel.com>
References: <20250106180137.1861472-1-kuba@kernel.org>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20250106180137.1861472-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|MW3PR11MB4746:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d442561-f1f7-4dd6-cacc-08dd2edc7411
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTQ5ZVRmcnBzMVpHL2s5Wi9sMDArSVBOQ2x4Y3Q0VnhSQ0s0Rkg0Rlg1QUVr?=
 =?utf-8?B?UFdTeWwvV3Fmblp2KzZXbkpqR2NHaE5QZys4eFVjSEVsUm9ralg5cW00MTE3?=
 =?utf-8?B?N01CdzcwQUExTzJWWHNTZjVyenc0K3BGMFF1Rm9HTFVKWTEvUUcxUE1PdU84?=
 =?utf-8?B?dlM0aXVxVEhxMkMxcnpSM0hLTUV1S2V0NURzOGVhelJ1ZndjcHZsdGl4Y0dw?=
 =?utf-8?B?NjdnSk5QWXdibEhZNFRlUHljeldxNElRY1l3Y0JTWWc3bXV2ODJIZ2MvRGZM?=
 =?utf-8?B?OVhEMURId0piQ3lLUVV6MW03b1hOeXNxZkJtem5JbnNONnlNUEVqUTFiT0Vv?=
 =?utf-8?B?Um9NNUw5Qk1OZGlsSTlMM0tHb3dQVWwvTitQYjhGZXk3WWUrMXpxLy85MUpw?=
 =?utf-8?B?OWxhV2ZReHZzZG4yS3hMdUlVbnBLMFIvd0hjdWlWRGE4V1ZsbFgyd2VLbEZO?=
 =?utf-8?B?MVZ4bnhqdjkxa1h2RHI1M2MvSDV3TmlUT29ORHJSeDlKU29NemhjWUNuV2g4?=
 =?utf-8?B?SE5HcU8zcUhnY1B5Q1BZQlU3NzlYakZaUklLOER5RGhleW1RU1UxYU5uRGI1?=
 =?utf-8?B?S1VRWEdzaUxSZjJ5b1hTekREbWNDaXBhUUdMcFVmaitwVTNVVTdLclZHNmJN?=
 =?utf-8?B?SWEyY09SYUIwV2x2bGZldG1jYWpTbXRuK1RPLytNTjFRbm5tQm9ZbUdQeWY5?=
 =?utf-8?B?aEpLejJHUFRFWGVrL3dXemMvSUJlRkdnbFJOTW40UnJoUm1ndVpLNDBDR1pD?=
 =?utf-8?B?anVadXpmZEowNXBIcHZINldVb2VMNTFhTFhRamUyOWR2OStSV2hhTVcxZ3RZ?=
 =?utf-8?B?MW0zV3BabEpuaUIwNWp0cVE0aUZQc0x4MEoxM212YlEvVi9WMUUxNCtJMWZt?=
 =?utf-8?B?b1dFN0VGQ1dOeXNjZDg5V3dodlRxaC9PYzh2RUVVMmRqa0JyMjdBZDc1Nllq?=
 =?utf-8?B?R2JUdStZT0RrTDB5OWtQRGdkOS9jaFozZVE3NXJQTVE3WktreEZMekJ5ZzB5?=
 =?utf-8?B?N1ZTSHA5ZVpmdTlYdFVuSnpZY0ZubzdQNjc0c3dGQ3RQQWNEaGtYeHl3NlZo?=
 =?utf-8?B?R1ZjZzNhQUVUZW1hR2pEN0VuelpTQTlvWFVSZC9yTFdmaVFReWYxWjJqem9B?=
 =?utf-8?B?UVd5eUVid2dhNEkzazU3SGoybjFIaXUrZjQxajhVbys5WFE1SVNUWmtDaktu?=
 =?utf-8?B?am1hMTc5enlDQkZSOWtmKzhaTTk0R05WTWwzYXJCQ1hlZFVCcGEvU3YxekZj?=
 =?utf-8?B?RE9JaUE4ZzgvNXFkVjlPdXBieVBoamhNVml0QTcvblgwcGN5dkxxVER6WXl1?=
 =?utf-8?B?bFhtTzNIWlJSMUxqTWdScEoyV01zUFQ2cCs2NDhIT3o3SnRzWDZ1Tno1alR0?=
 =?utf-8?B?RVZISitUem4xUjZqUWY1MWxrTTVCMmRQRzBjS1l1SUVVZUxCNnphZHhNcHdw?=
 =?utf-8?B?WWVNK3dzSDZHL3lXNllWRWxEV2lqZGRZY2JVOS9FMmdVOVc1YlZ6L0ZqRDZi?=
 =?utf-8?B?TTZVZWw0OU5tNENhVDZmOVVxVDE0eGhTdmJGcTNsOVdwVjBEYkNWY0p6SUdG?=
 =?utf-8?B?ekFESlV0TjBNS3ErTnFYNjE3Nk9WWkkwVk1yUHNWUW14dmNoODFLbVVON3Zq?=
 =?utf-8?B?R1hUM3BhZVRDQnA0Qi9FZjhCQkprNEhPWStUOW4wVVJNYVZUNi8ydWdyYThq?=
 =?utf-8?B?a3hCWjNXYk1ScXNIV0NtSjd0Zy9IMElPQkJ4WjRwVHA4Myt6eUtyQkJTMUha?=
 =?utf-8?B?SGVxUmFlMGV0aHFHbndxYWVuclc0SmxGM0FWRTBkUnIyNkdqRXpKQzY5MTFL?=
 =?utf-8?B?KzE1dDFRamFCQURBZy9PWXdMenA4ci9HYTVkT09CMFo0SXBpRmxXYytzMVpI?=
 =?utf-8?Q?deQxMtxZoKoA0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXNBVGdmcDQxN1BkV3E2UjBpYktJNmp4aUJtRGV0ZDhkdXFyUTR0bDRPWkFj?=
 =?utf-8?B?b0UwNlBrcmU3anlIY09UaE5KWUQvRUJTV2dOSkQ5ZzdrNGt6eU1KaFNCb3JI?=
 =?utf-8?B?TStGY3RseHJlaythbCtuYnhlRS96V05vK2FVcVdxN0xZMEVnYkZyS3ZwQzYw?=
 =?utf-8?B?djkwbUZCM095VVdrY05pUTRzY290VTNnSEs3MWNFa1MwQmVoVlF3SWdBL2Rk?=
 =?utf-8?B?ZU5QL0hKWi9TUzNSK1FhbUhiYnhkV05iTFV2ZUFZVUVtcGdaMmFtTjg2Rm9I?=
 =?utf-8?B?a2RHenROUlcyeU1LOXJVL2FZN3l5M1MxUVhLbS9TRXF2dDRuYi9Kd2ZrVEdP?=
 =?utf-8?B?aWlwL2twYkZMSVU2M2NYTDlqelVBUGVxU294Ri9UM1ArcXIxcko5KzlRaHBW?=
 =?utf-8?B?TXZxcVY1eG45WU56QU5tM0s0Nno2dkxLR1o1ZkhVbFlCTTRobXNKT3pDR2U3?=
 =?utf-8?B?NFAra2pQTmY0bllselVsdndlN2JNaGVIUUxwODVrRWl4MzBsSkRiQnYxUXdo?=
 =?utf-8?B?RG5id2UzVTZKWHZxU0pPRDZ1WHN6eEZOMXpvcUZSZklwSzRqL2ZhWEpFaTR1?=
 =?utf-8?B?eU9za2JkVFIvYVZmTlZSTkhHeXNCa2oyQXZnckhXSkpqekx0Y0F4eTVyN2hz?=
 =?utf-8?B?RGdLRjZJQTlPOG5ZS3JXQ21rbkNvOHJKQmkxSk1xUWNad3FzcDA3MlpDZ0tn?=
 =?utf-8?B?WU5UcElHYnJ6cmU1V3BTbnp1R0VvbGVUUCsvcXJqOXdub0xvR3hyMDArK1Ax?=
 =?utf-8?B?VjZ4TVJxTiswTGhVQnU2UTM4bVRwb3RrNXVvdEhzMVYvOUpQY3NHckkxVTNE?=
 =?utf-8?B?OE5kQ25jUUh4Wjd3L1MwQVpqNHBLNjJFQ3h0WGhtcjI4bTFibjk2OWpjT3Vx?=
 =?utf-8?B?cVFVNm84U08wTURsOTcvbk84UHBnSUljeHlNNW5nMzlHNDRmSitsb3NGNVp0?=
 =?utf-8?B?bVhFdm93bWJ3Q2U1aXlxMExPQzgzbHorZFhSNzBhVTRRZlNrQVRXV2FqVE1x?=
 =?utf-8?B?Q2FNallXQUNBcXVjUHNhd2RzaWs2QmQ5UU1SbW95NUZaOVdJQnNmeVVNVUlr?=
 =?utf-8?B?bDVJRXg3dzdpVUs5OFVHQ1dYOVpjNGFHaHpXeWR1RjZSaERaSHlZVGdXY3pN?=
 =?utf-8?B?bzVEVHlCV2dQcFZiM3Z4YlVyV3ZmOWRGNlN2Nm5tZVE1NU9VanM4c2dxVVlU?=
 =?utf-8?B?eWdzdDNsUHlNaXNLMmRjRllSTVlheEFJUTlVek9yazlYOEtRRllKQnRlMndG?=
 =?utf-8?B?cW43TXRmN2NBQzB0MWtOMTNtOTFPSXZqN3B5VHZ0SC90R1ZQSGZPczl2SkR1?=
 =?utf-8?B?KzY2WGdpVnM0SmkvSnNNMmdSOUN0aG5aTldUSU9XTVJTcGgxM25QMVFWYTMy?=
 =?utf-8?B?bGhnOUxKWFlzSlVlVytlUzR3cHB1eVp3Z1l4dmhZZnFUS1NNUHVuUkF6S29C?=
 =?utf-8?B?YzhMQ2lsTVF1YnVxaCtEM29VV3cvUGdJNHZuWEFhTUMxc0p5UVppSjRKb2pi?=
 =?utf-8?B?UEc3bXV0QktsRHR2VjZBNGZqZDB1K2F0OHhjcThZdXVnbmxpWGg3NGZIcDE1?=
 =?utf-8?B?MGUzNnBYcm56VGQ3Qm10UDRnaEQ1QTBzL29wRThVY2wvS0YyaW5Hc2VFaFlW?=
 =?utf-8?B?c0R5MmpzSXlMdnAzZlBxUXU5LzllWVQxaUtlSVllWXV4UlRiSWdHSWNXbk9x?=
 =?utf-8?B?MnEySGQva05Qamg5Z2V6a2QraVhnbGIwZ05JM0liL3JONVJtS1NPdVNCaVBN?=
 =?utf-8?B?dmIwQlVNWS9UQUx0VzNsWFM3R3NhWFF5MFFaK3hRRG1NaGFrOGlOWjZvUnRR?=
 =?utf-8?B?SE1JNWRMQmgwRUVQTHJtdjQ4dTdDVlRVaVpTRm45bjBHQ0VUaE4rNzFVZ29Q?=
 =?utf-8?B?V3d3QzU0ZnNIdDI5NjFPTm1VQk5aVVJUOHpPWU1aTzY5UVpMS1NXKzdQblpP?=
 =?utf-8?B?WlVMSjg1QkRnMW42Y2I0TXRuK1huZ2toV3Q0Sm1vNDVjaVcxdnpxY1NrdXZW?=
 =?utf-8?B?N1pEZUEzWXVSQkpXVkZwRFFrbzF3TWFNeWJCZEp0OGkxTEp6azZWTXNCU2d1?=
 =?utf-8?B?TVJjai95QVBrZ3N0cm81djBBelF6bUNyZVpjcjI5NERyRlVBZ1pGcHlBcnN1?=
 =?utf-8?B?T0hhVGZMYmdUMStVaDYrSlY2R0xtaHVwdUNLa3h3aS9Ca2hQR3lTNFRHRy9z?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d442561-f1f7-4dd6-cacc-08dd2edc7411
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 05:30:53.6690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFsvUHCYU5YkE7eNHY1sixRphEbvAVHCJ4JP7PAkZ+SpR5iPZ6oXF6FNa7Obpu6Q8QgPkqxBsxwtujvdFvnpaxgrEeD9fDUuiZqhav/DS8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4746
X-OriginatorOrg: intel.com



On 1/6/2025 10:01 AM, Jakub Kicinski wrote:
> The NAPI IDs were not fully exposed to user space prior to the netlink
> API, so they were never namespaced. The netlink API must ensure that
> at the very least NAPI instance belongs to the same netns as the owner
> of the genl sock.
> 
> napi_by_id() can become static now, but it needs to move because of
> dev_get_by_napi_id().
> 
> Cc: stable@vger.kernel.org
> Fixes: 1287c1ae0fc2 ("netdev-genl: Support setting per-NAPI config values")
> Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

