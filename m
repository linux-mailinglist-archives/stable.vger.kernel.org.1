Return-Path: <stable+bounces-119776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C10D3A47074
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 01:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3C2169153
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 00:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1BBC2EF;
	Thu, 27 Feb 2025 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXyAsEy4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54511CA0;
	Thu, 27 Feb 2025 00:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740617064; cv=fail; b=S7s3IdtQuTXZ9tKLxfo+fR77nr8yAK/GWoy69AYa+ZPqn9ZlC2JK70B8zLEL2zdQpQKC98KfI1sN/cWVRIrsj1t5OLzrSeSL17Qe82zJ1fEGMLv45fnJAiMAkx/faIuvV8jhOUXy3ihRGHqPvT9f6dfqPC7wUhm4MQzsQcLfE7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740617064; c=relaxed/simple;
	bh=0PLd2n88NdRneWVl1/ZD7y0nU7F2l8TkQ6GTqc5Fmxk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eU+mG7QCusjkGIo6fF3zDIC1C378XvEn6pOmdeZmLnCIRlPln/2/aMshPanXLpyABCaoc2iv2f4KBXQmo4pJDBOhp3EZM0la1crZ08ihlK5axUuclNs8vKjNdDFgZQBeAP3IYBiUFdf+R3HAoBgGugmF+5ruOIBUNk0MGZ+UxBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXyAsEy4; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740617062; x=1772153062;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0PLd2n88NdRneWVl1/ZD7y0nU7F2l8TkQ6GTqc5Fmxk=;
  b=LXyAsEy4WHCC+s0ulGkSssK+JBp9QV6CIXM1HvfY2Yq0lFQ96Ek89cUO
   rxo5YA1BQhgHHfmbelcPX+K+fy6kwrJGIQZY+1tiSJXPrk9RIV4C8glrt
   xcq6A+NC0oqcmNbUNcnUK/9LWUh8cFRj/RVGQ01eGPxsSsI1uJMkFQQ83
   fTMyxSVVfBAtfQK2PHX0T5s0GMnCb3L/fThjfZzjQN8wiE0up3InhAgW3
   VR3kcz6bpeaP194q9BuzGVTAvgdrJlqukRDmxh31TSPKHYJ05eYPxXyaW
   LbBd6pn6T/Xx+XeSj+rr8H2Lyc6HRKDfpH7EUfTPRAdSAZV/tui0+4sHR
   w==;
X-CSE-ConnectionGUID: 2aYJ+zXMQoynBZvWAhUtNg==
X-CSE-MsgGUID: rrAU9WH+T4S7L8qFPPVi2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52127571"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="52127571"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 16:44:21 -0800
X-CSE-ConnectionGUID: K/Wq0TqRR1m3z9dmO9eJog==
X-CSE-MsgGUID: IpjYDWu5TWKj7O2WrhgNYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="117501603"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2025 16:44:20 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 16:44:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 16:44:20 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 16:44:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpcbVX2PbAKMsYNDdM63ODNZmg3T0t4/pNvL7QbLd/Q4mj0BEb/EO5nfxG1qj1C4HixbjJpqUW3XQXLDQwuUt83z2Yoj7Z5N83TUYdQkvib3wjkg9x246QwLdTOdoYzoNM4e8yY9RVYe0XgbSZ9rJeD+K7YXLN2xjQR23igL4E0dayO4DWq+FNEmprPOjx0TSSmfFUmMSia9c4UrUVsp+Wke8b22ZwXBRT5aEGRy2tgrSqumXGYzFgRH04bDhfGqDodqkcvdcVrMe6jbuF1UMTk/WqdJnaUPvR628yN/pWG8vsLu1N1pbiXTpqHwNQ2OaFcetH3L+xJzb1VxffQYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+u8AmicAvpoOFsz3p1gMZ+ONSBxacIPiRLHGi/V0TM=;
 b=GgRlFUy4haGNWyqTZBpT/fdqhtcU5cu9Jr+ihEA8qfp5C62cD/R+8cnPMJu8XE8ZHG2oJX/lqGZ3rwiT0nTAySg8jYuykRFASyvdaU6Jlv2neuG59lwRPI3puGxSgjjpobYIW3fDLOHin2P5TnrSLYlewPJniJi+Rzfl7OpvHBtlXrpM7q6fmOHqb6HBiBTKy1wYaU/f3tGeCLTLSd++LeXu+LtdzT6gV4WPk6Z17+3iq5G4dBZMbt3qiEg1y4OFCi3F2dsGsB7oi53TLlMMXMDBxjiTDRwOisMrk5+xK9SdxazClgRppaZXYI2UfoTBRLk3GioLHyo9DGMOWkGDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7920.namprd11.prod.outlook.com (2603:10b6:208:3fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 00:44:03 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 00:44:03 +0000
Message-ID: <8ff78832-006d-47da-8e27-12c70ac82a8f@intel.com>
Date: Wed, 26 Feb 2025 16:44:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] gve: unlink old napi when stopping a queue using
 queue API
To: Harshitha Ramamurthy <hramamurthy@google.com>, <netdev@vger.kernel.org>
CC: <jeroendb@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<pkaligineedi@google.com>, <shailend@google.com>, <willemb@google.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250226003526.1546854-1-hramamurthy@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250226003526.1546854-1-hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:303:6b::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c75e043-3ad1-4fd4-846a-08dd56c7d527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFMzWkhjb21Ea1JEc0pzQjlvZmR0NW9FMVo1UFh1cFZHYlUzTU0xRXNsTnJo?=
 =?utf-8?B?NXh6Q1FMN3E2YUJ6RUQ2M3N5NE13SWh1RUxWWkZkdG50S0tyWXpwbFg5S0xG?=
 =?utf-8?B?M2l4Z0w1dWlzRW1kMnhWc2lDY0NkQ2tZdHpOd25QZUk4VW0vcHFXeC9aZzMz?=
 =?utf-8?B?WXNyU0FKNktsVmczTGJtT2VBRU1MREdKU3RTQWRUWXJWVUZxOVExb3RnSU5I?=
 =?utf-8?B?a0h1b0JMMFB5SHRIRTJwU2ZkMlJYbUdLcFRFSmpnKzg1dUd3eVVGNlI0YXFS?=
 =?utf-8?B?S0RhNFZubm9uT1NlVm1TK1ZzVTd6a1drOVVqTnFGcE1oSytoNnpoR0lIeld5?=
 =?utf-8?B?S2l3TWdtRkdHRkdWQUNoWUZZMjRZY1pjaHl2ck9ZTytUTzc5T3FzY29yV1lM?=
 =?utf-8?B?NkJTSnBzTm9sY3BaNnF5K1k2clcvWkFBaHZMeENLOVdtazg3RGc3ZHc3OFVK?=
 =?utf-8?B?TDNhK25qU24xZVdqVGVuUmFDYXpMdzhzMm13cWhsU3RXbnVSWDRCUkdXdmVX?=
 =?utf-8?B?UHRVYXhSKzNFUVpPQlpSdTVHbFNLT1lIUkRqVk9PN3BjWFpJV2IzN3Rna2lD?=
 =?utf-8?B?NWxyRVVEUjIzZ1lncDBDUWgrMUFieVB2UnMyblJGNnIrN3YvSGhUSGorZGVM?=
 =?utf-8?B?U2pyUFdISjQwcC9CaUg0Zm1mSnptQ0pYcmR6OVA3SEJvb3hseHRURWpBc0Jk?=
 =?utf-8?B?R29xbUdKcTJhMmluTDZ5cVRRKzFQb2hEOXoyMktOQkNCdEVNci9BRXhWNHhC?=
 =?utf-8?B?MVgwOXhvV0FxSVJTT0RCMzdkb2ZtbEErcVoxWTV2NXpPV3ZpaXd0WnFOaVZ6?=
 =?utf-8?B?YTZ0aVQyNVNZSjliSjcxaHRReXl3TjdNc0tmSlBkVWNZR0VBbWlsbS9yV2lO?=
 =?utf-8?B?L0lJL29iQzhpVi9NODhNQk5wVUFmMlBLazI1TWFzMWMwWDY3c1Rvems4U3B0?=
 =?utf-8?B?SHBsWnV6aVdObkdFZFM2MUVDbkJCZVNvWk1naVF2Uy8zYWpOR1FWZnJKajYy?=
 =?utf-8?B?RWRSVkoxZFo3VkdFL0NNYnJoY2FqeWcxdmJSelRCenFIb2ZVL3hyMlFwYldr?=
 =?utf-8?B?aXRvZTBUUEhoeE1pcXJUZnViOXlWS05EMWIySTE5QjJoeWNPcVhrOC93dlJM?=
 =?utf-8?B?elptbnJOY3lCY1dZcUxxZGxRdGs1SXFwVHBCcmgvUzRibFJEMkF3eUM2Q2Nk?=
 =?utf-8?B?T0V5bEMvdktEZHA1WXkxU3RSa2lNdjFxQStJL1JtM21HS0NTSWc1d0pUVGpK?=
 =?utf-8?B?YzBDWHR6UFNGcXp3N2dqUzBxWmU2anR0K2NxdURDMENpL290Qm1JWVZlN1Mx?=
 =?utf-8?B?N0daNERtaUhQZDQxNER2UzZmUjRqQW03Qk1TYlRzdGRUVGNkNmxPUkVqcmpy?=
 =?utf-8?B?VTVZZ1VnUFpqazI0dzhJMUUyYVlVaGJvL3NnR2F2TGZQRHh1WkhmYXhEM1A5?=
 =?utf-8?B?akJleFlhOGorRHJFVE0vNlZiTi9VQjNmaXpZaWlhMjhFQlV0dG93TnFHdXBo?=
 =?utf-8?B?NU82RGRHUXNSMG9senpCaFVUQmkzYlRqWDZmYWhUbGFkQVJQZm1laXdCdURK?=
 =?utf-8?B?ZXkwT01vL3VaSDhHcy95V0lYYTZhcFNWTzZ2MmFZem5sQjNSa2VjSFFJUmMv?=
 =?utf-8?B?SDlTcHkxTzQxSGc1cEZ3Q3RydXowUERSMlRqSjlxUHlrNkpwRG82dU9keDV6?=
 =?utf-8?B?cjZGaHRUbVdYUXZyckZTNEIzZjYxdjl5dXRRa25BQy9wekx4YXcyZHBUbVRE?=
 =?utf-8?B?RU16YlJZL2VjOFNYeVkyVGNsQmlkMlg0U2pMN1pnN2hmTFF0VFkwWjNvVlVv?=
 =?utf-8?B?eWFScFRneHIyNWZoK3g5VTZCZXlRbnpVdnZ4R20rWk9MNStQRXdoK0dnUnRl?=
 =?utf-8?Q?U5vgEpiQHrXA/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGZDSDFlUkpyT05QMkxMT0lmSVhTOEhRRnBkYkt6R09ITmViZGVNa09FeUlj?=
 =?utf-8?B?ZnRtMld0eDRBaWc1eGZ4bzJwZExRUWI3SEVaU3pJWkRsR3Z1dURrazUzYnZP?=
 =?utf-8?B?SVkvL1RqMWpMcEFWbEtuYjl0NjM3cmxTQ2pWOExJcWE0aitXOEliei9TRFAz?=
 =?utf-8?B?Z2pXT2hqK2VkbFM1QURzczB5aTB2Sm9RRVlSQUhmaUFoejVrV1ZhVVB2WDFp?=
 =?utf-8?B?bHJYTHJReVpkb3h6MGd3TWNjUEN0RmNjQ0g3ZlF0Wi94RTJUclNTZTZmVzdQ?=
 =?utf-8?B?RmphNyszclpMaUxEZlI3VWhTU3lxQllpN0tWTjh1S3I4Wm5WOUNoMlo5RGlu?=
 =?utf-8?B?YU41L0hzZzhucGtoRXhFUWtaaW1ib0dmcDVNeW5McEYzb2VPeGZqTkZXL2E3?=
 =?utf-8?B?UWRpbWZPK3pqOVIvdE5ZZU5EK2xHVHdSc3V6WHBIdmhZWmFWU08zL1BGNXJP?=
 =?utf-8?B?d1lRQkJvbW82Y0NEQ1o4TTBJK3BkUFRlU3lZaGQ3eHZoN01wdmR3cU04RzVC?=
 =?utf-8?B?dnFjbkt5eHJQWFArSUdKWkRNQUVoMWpPeTZFckhHeDFzUGU4bzBUVGZ0aW8v?=
 =?utf-8?B?Vkp5bHlveDVqamQzMVcvWkdnVWJHT25NbTd1QW9UdzV3TmpZQUlhdEZvMmpN?=
 =?utf-8?B?ZGFPekw1aDV4NFltKy82N0Q1aW52UTl0TjloRkpyOEh4RkNrNXVrc0ZVTUZj?=
 =?utf-8?B?MmphT3hMVkdvQml0QkU1QldOQjlzbDdZUUtRUnVoRkljRzlLK2w4aGFrcDR3?=
 =?utf-8?B?TU10TjRCZURZM3dKcEd2bzREcS9nbjYvV0VBbWsyL2JBbENIVEcwZ0E1VTZk?=
 =?utf-8?B?ampZdnhTdGJiZmhEK2YxdUY1S1NCNWkzcEw4aW1QaTlCZ08zVTUrcHlKdGVq?=
 =?utf-8?B?WVNGVWFvSjlibGUrRVlHL0hib1FvT3YxRkEzTFRUSWdSWk9BaVZCQWhGRjlR?=
 =?utf-8?B?YTVEUDViYXlRR21DTVZtSzI4cFhWRndNSUQ1WXVCNzQwd2hkRVpiT2VvdmdP?=
 =?utf-8?B?RzVlbEdwcFJFQjRLUjlaanRQdXVxa2lPY2tXQXhuWDJtbjB5Wmd0cmhUUnR4?=
 =?utf-8?B?Z2Ntb1lLZGZQMWNrY2FoL0ZTaUY3bTE5ZytlallyaXlLbitSSVV2U0diejFP?=
 =?utf-8?B?UlQ5YlBpNVBRNUJFR3IrdGYrUWtudEcya1c5TXJMWXhwcXZ3TEpMVk1QRHFZ?=
 =?utf-8?B?NUlpUHl2TUZVdE5kL3lJRXFxc0RxMVVlZXRmOU9BaVFmbEFVbUlmTVlTOFdU?=
 =?utf-8?B?MHhhekNYNW82UFlHKzdYQkZGRmRzNmtpUUMzeXlCNzNzQVczTWpHeHVKQndo?=
 =?utf-8?B?Skt4MmdmR1hnOVhZSHliK2ZrTm4yTERVVy9FV3JIbG5ZOTVka3p0SkNNZDZ4?=
 =?utf-8?B?eDhnb1RvTGYyNTlSZ3J0YldpT0tlRzFVYXU0N25mTXNENG1RRWN3OVUrQ0pm?=
 =?utf-8?B?VFlpYXBlVE41N0orZG14dUIvZFE5bkViaVdiUjZEU1J5WXk5K0J6ckNveGk4?=
 =?utf-8?B?ZmhDTWQ2RlhqZlBDUStVVWxvK1hsSE5sSWRTMFZCdCtudllFeEFnTUp6cmRv?=
 =?utf-8?B?MGd3UTFHNFlUbU1RaFk4dHRmWU5wQXl6cHhEa2RoTnJwRXhnNjZXOER5aFUx?=
 =?utf-8?B?a0NSWU83bS9NWUNrVW5wZmV1c1hPSXdxSGlaWk9VWDlyUERxOExPYi9PTmtL?=
 =?utf-8?B?YUpIbjdaMVAwa1l4aWN5WHgzcytPZllXcWN1L050WHZBNEhsa3RZYmlaZHBN?=
 =?utf-8?B?MnZhdFNVb21qZ3oyTUViRHBDeVQwb0FRN1hBOWMrcE5Bek5LKzBZcUptSG51?=
 =?utf-8?B?UzkvcWE2MGV1bkcvbkd4ZWl3bWl4M3hoSnJMQzlzalJLcG5Ob0NRMXRBOXpi?=
 =?utf-8?B?cGVHcUxzUzBHYnl6M1R2RXFZSWNPa1dJT0tDVEUzS1ZzTU5Oc2N0dm1TZlA2?=
 =?utf-8?B?dG9uUDlYSWlRdkFxbVBSWW1GdmtINHphOVNzZnd3c3YxZkF2U1h6Wjh4djlH?=
 =?utf-8?B?UEpuaWltRUJVNjE2c2o0a2QwbTh1cnoyUmlqVTlaS1V3VmtZb2xiU1JybXNB?=
 =?utf-8?B?WWdMKzFtbHVWS2tTRDUyY1dqU3JLLzNpUnR1eUlnNy9hcTNub0thck8wZXJm?=
 =?utf-8?B?TDFoNVVHa3IxLytJNEJ4akdaNDFGaHhRTTdLaWVUY3k5aWhNekc3RFV2dzkr?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c75e043-3ad1-4fd4-846a-08dd56c7d527
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 00:44:03.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohy/9SiVSUwtUmpupht0nZfehFaQ/B6G7b6GW0pb98KbqjWYCjZG+QEj/uefeBcncawfyKINUvVcuI5LvaN+HegSkt9UQz1mwbhSGSymGmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7920
X-OriginatorOrg: intel.com



On 2/25/2025 4:35 PM, Harshitha Ramamurthy wrote:
> When a queue is stopped using the ndo queue API, before
> destroying its page pool, the associated NAPI instance
> needs to be unlinked to avoid warnings.
> 
> Handle this by calling page_pool_disable_direct_recycling()
> when stopping a queue.
> 
> Cc: stable@vger.kernel.org
> Fixes: ebdfae0d377b ("gve: adopt page pool for DQ RDA mode")
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> index 8ac0047f1ada..f0674a443567 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -109,10 +109,12 @@ static void gve_rx_reset_ring_dqo(struct gve_priv *priv, int idx)
>  void gve_rx_stop_ring_dqo(struct gve_priv *priv, int idx)
>  {
>  	int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
> +	struct gve_rx_ring *rx = &priv->rx[idx];
>  
>  	if (!gve_rx_was_added_to_block(priv, idx))
>  		return;
>  
> +	page_pool_disable_direct_recycling(rx->dqo.page_pool);
>  	gve_remove_napi(priv, ntfy_idx);
>  	gve_rx_remove_from_block(priv, idx);
>  	gve_rx_reset_ring_dqo(priv, idx);


