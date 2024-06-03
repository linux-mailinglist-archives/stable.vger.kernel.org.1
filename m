Return-Path: <stable+bounces-47893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8798FA574
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 00:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7992874C4
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 22:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE1013C805;
	Mon,  3 Jun 2024 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBKScBj2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F5522E
	for <stable@vger.kernel.org>; Mon,  3 Jun 2024 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717453150; cv=fail; b=tStzZOIkSThs+kexeHI3wOLpAsagcdfwcnYWtUwgWr8pP/WZqwMpfxV5SfLoU4mw6PVUqSy3tBq2CI6I0e/3kC1srI9lwIKldOclgcMkX+yKrpYBILT2FFOAflaZ0cQ7gWMF+XXkrQWXxP32Qgs4syHcSWzV09OtlqlLvJig38k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717453150; c=relaxed/simple;
	bh=Rm3bgs6gjVEKgEWBLCxTkusUpGTsdWAz4T55jYQR2iE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vf7Z04rFGxAcRXJFX3+AU3N3gxm3Fl7d0k6bfjPNCFlSaUosvCTztfGzyA9AYCWIA/eFLd8CBRDNLWuVf5ZYGsqzeYBdeTUQwUo3pLedQAKW0xBU1gv4r/Gbt442ymcKLjCGEn43b48HboIgItBZCMYyeFVY/ZuAFqV7nvAtsSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBKScBj2; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717453149; x=1748989149;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Rm3bgs6gjVEKgEWBLCxTkusUpGTsdWAz4T55jYQR2iE=;
  b=QBKScBj2PeyIZniEHeBwJjg5cxEobJJE30kVaNrxcNM9gZoJ4sd/5E+g
   c+Mhzimy8FxHZc7SDrRX23/sx3339QWywkaTz4iWtDjYyyRDh2CFMl6ux
   3nFppeZrOydrq9FVxbCvECvk5qAZ/jEWahJwZ+0bszB5VIjTma9hGw/N7
   BlmyFxDtWzd5vG8Q/ymtCF1SSZi2nnLC1n4wxOAOal1IWpP8lSvsvoapo
   O2oE1bvA3KpcvUrXpLQz5F5tdn60aJBE4D15RqVkU3oMpFWEzkez5/DN8
   X+zq0ydfRxrnsb1w4VwYGKQ5V60jgqYFfVI6KFI7ifJfefUKX59mHifEY
   g==;
X-CSE-ConnectionGUID: LKM3YP1YQl6M+qFDe9Hv9g==
X-CSE-MsgGUID: mtxsJtENR1qiqD5VfElioQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="31501938"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="31501938"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 15:19:08 -0700
X-CSE-ConnectionGUID: LtyrX7KYTQmMlBph/pVZkA==
X-CSE-MsgGUID: MXCX0o4KTKyhjDarreNCHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37134429"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 15:19:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 15:19:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 15:19:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 15:19:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrf7F9A57KAxQIqXnRQrZjZgCv2QSuk87uUfTz+zuhj/Lw5/EZtdxtezL08sO7OkPmXkIZXqyvpxYwsbMf0C65HnT9i0XTUgitIKzeBARXWTRwQ6cLlUSWEtnfXZfJ/ClH/cbXveUUWk9WT3XccCNcJZpZq8VTEB5ojwEVPM8o5FCM5MGgNW/I1M4TnP8UFhWar/Uj2i3W8tUV7Ly5qbaddozQSSrzf41b9yJlE2IAnoaKeJdVn054OP01JyPb2I8Sht4rT6VVEJJpmzCtGInG9wA9UBqdtpr4BTI4xDdBK+d4mvVuEgHbXdc3wIugXClziuBoTgbRnqUBcpxD5B8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5QP/TMxhoT1kSfo8Hc1v3W/BFms54LbsGt/Du9czmw=;
 b=XhPCWrb5AyFyUrJVDd0ImUQN42RH3yrrCc7wpwevUKgb8B2yMG70xx1K2kJJMIHeIr0Bq+u4zgdpGx379ey1Id5/EJZrtWw00AofVydKwqaD4kQ14g3RokK0eBvsCtwng1kMuiceNnjVPA0YIljndCL8h5K/kyqYEz5p9Nh0vofM37HHPtmsl4WQW0mKxk1ssNLkVBP369MZys7hRaDDW1aT3tfmadqCqLN+idaA4g1J3WuIxVnRaiA+miciTqgwe9dmbEBx7PJCN0+HchVqFQQ/45SZRrmmu6Is4cWH8Jk9OIpbgEtSwwWx7FS3AIU6luTIdNVjOeUfN0n7gOhKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by PH0PR11MB4808.namprd11.prod.outlook.com (2603:10b6:510:39::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 22:19:04 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%3]) with mapi id 15.20.7633.018; Mon, 3 Jun 2024
 22:19:04 +0000
Date: Mon, 3 Jun 2024 22:18:22 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Restrict user fences to long running VMs
Message-ID: <Zl5BLh6OSbj4W0EX@DUT025-TGLU.fm.intel.com>
References: <20240603175312.1915763-1-matthew.brost@intel.com>
 <e772bf3fe4577f66f56a969ee261e218b8daf738.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e772bf3fe4577f66f56a969ee261e218b8daf738.camel@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::26) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|PH0PR11MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: 6136ab76-8138-4034-d2fe-08dc841b2dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?e5Gh4nxKAhMWUM6NPsSovc6TmPy0+388wcTRHJhZbq+nEDAyNszIdMqIEg?=
 =?iso-8859-1?Q?HXbtK2FRIDAF7zjrOnedOZ6wgIwoja5smmT2LkdJJ/IkXxp+/AOVW8IOsq?=
 =?iso-8859-1?Q?5RZkx4y62itweMADkpsZ2CU3pnctXnD80Q6RU1eN0F2WUK3NlVDjpQtQyZ?=
 =?iso-8859-1?Q?m4M6DQpO+hR+sOOgVtQBXYqQ6nY7+F5tr0CfAWtsuID7vJwn+EGT1lvr/a?=
 =?iso-8859-1?Q?rL1e4b1JJxwHsmoU1RnJ4z++MFCG7ZP8BzqZ4WSIDid4F4CRLMfZZK4USQ?=
 =?iso-8859-1?Q?PNCIay8JZJYWSRu9l8P1qpa87QC79s90dhLTNk+LAulrAIwGUKtCSv7GP4?=
 =?iso-8859-1?Q?2/ybhFAJiK/0YOA80Kq2CS2UmuHst2Tlbyoj4t85kGSrF6SdAYYzSkrvWx?=
 =?iso-8859-1?Q?JecBjDBPNxO2zEFftTqmPbg3OOSycHRHdoVFBwaPYZW9YtN9bv3QoGp6kg?=
 =?iso-8859-1?Q?ubuCoAFgy4iULoTsHqYt59v8z56l3I63IP9QjrrzYPlyBZMDwVBU8pefT1?=
 =?iso-8859-1?Q?nC9/N6Gq2VzrPn2Fe1e3YO3yrG07hMJUiiTDmC7Rr3l4yXMPiZMplAv404?=
 =?iso-8859-1?Q?YF4GcMLrxTmmGujfjr3BtbV5MNInaLdX/pRYhua/xn0tAizaA2cHiBndPl?=
 =?iso-8859-1?Q?vk9+g0XY7cViXJrHcb1Yhebxd+bsP7v2A2pa7BdAI5SE/W6NqTvQE/wQTy?=
 =?iso-8859-1?Q?Pr3xa0LZwOI0Hp0Hgi2TjS2NDvuMlYYuiG+EtB7MJtm4NDgoneg4sq/zLB?=
 =?iso-8859-1?Q?hNhJApeasq3FoZ2H7F3H2A4HppAQUHBoIbgDYuwo+NdW8VNHBnb5A0Ni7h?=
 =?iso-8859-1?Q?7JO5ZmIDCtkeMe1UzvTScgILYgz/Y3rsoK+V+OuQG3Rr7sfOh/EkPzU4Gq?=
 =?iso-8859-1?Q?tYeC2KDbr6Qp5tb4tYCHBhA7KATOA86NlP3hzKN2MRVAtt23N3us7/spuY?=
 =?iso-8859-1?Q?JGAAEtldqzHaOgNqjKd0qk7qLoHAAKNMJHAyuOKfKr2BbM31mZcOyYYwmm?=
 =?iso-8859-1?Q?1bQ/fIZnp54LXONE80zrEF7/HI7D+BC3kjfzAbhKdyOfiqKgkz3vXkqGya?=
 =?iso-8859-1?Q?43Y8VMFewHichJjfjly0ffxpmZeFgP5Md74BH5yHUzARisZd6FblwH/Wf0?=
 =?iso-8859-1?Q?gk0Gb85CP5iq8hame2OVRhVUKOwEG6YS/E0PkzzhnbZzEvB2RTRK5ImK2g?=
 =?iso-8859-1?Q?7uw4kvvCNYTzie907nhjsXe3JYcW/f7+jaIK0wbfO7rnraFRkb/SndqI9E?=
 =?iso-8859-1?Q?euzU5b7CUcnhNfSfkKZyAtT2jFDKsPRBjbmNeqZ2aC8vBEoLSRsZjmNLyI?=
 =?iso-8859-1?Q?mUaHwltr8dKjCElJcac+D8OBwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?X06zpqu5eGjH1D5cVuyxtoS/YnJqZAX+J48oi5Z2AeyLpDgmRByiketJrC?=
 =?iso-8859-1?Q?LaVZruzXibthF4KR3rO5yZoiNOw0hewx4YCCzS7xvseIr2VmmlxTNl1VSp?=
 =?iso-8859-1?Q?cCVyYFzNnIf17OuhQWH9s8I59wHOp9ieXkIU7cpQHUwo/yChfQBE8uesn5?=
 =?iso-8859-1?Q?MIgrKEL7uBI445GcdJKlzXNWPZn0+TrpBlKsUF5H7Dlnqae2fgkbdtJMWJ?=
 =?iso-8859-1?Q?wd8d9f8KbybVZbaJDJQDua0BtpIlKMouWOyrouQVssVi6AlIh1KEJQj1HW?=
 =?iso-8859-1?Q?PxDlOAl39QeoPmG4inqtqauT6dIdhbPS8J8BFa36lltOeH2hOQSuonQG4V?=
 =?iso-8859-1?Q?is/80cakz5vposIMQp0xqzsy8wKV+LoJZ+DXEhqjQGu42akyz/hTKvEraE?=
 =?iso-8859-1?Q?JWb3PBCoMzrAKL+kNECjYULg2j+XgHo/PNNmRYNtb/66NyaN95stXITal6?=
 =?iso-8859-1?Q?VZ87AyYB25hhgfUAuD/yyUMvkhUb8vC4zUS5gyyhEihehyuE7lxxR/qTD9?=
 =?iso-8859-1?Q?fVcaA9QpRwGqCPTdT6s1X/Szp5SVVS5mMaO4qLxIJUptHiNxuH+Q457Fsd?=
 =?iso-8859-1?Q?zEP4CyO1wQYce5KpoEkpqL9jnNjg3DLEleHMHJ3Qgoeg2NEtvu0BKclFfQ?=
 =?iso-8859-1?Q?YRrMmjPhqrgtfmOtvSbB0uRjS/01ntYO3jfxdSr6kYAVRUOBLwnnAniay+?=
 =?iso-8859-1?Q?Mm/L2zTd1B+2UrJlAW97SVIMyCdkBFPxNZFUCSTIdL5szIbFkg/XPN8TYM?=
 =?iso-8859-1?Q?o5TILbqgX/5W8UnrWbSm2bwAv+hl1h4ztH8j+OpNUzJy/zey3waeBYYLzD?=
 =?iso-8859-1?Q?aH3+n/qB4psjGMguOVYKS5lUBY9pUaXVNXtK77G68FbQ5vmd9L1XP3bNEe?=
 =?iso-8859-1?Q?TvV5JXjtWn2QELp/C5RTlaLM+3nTVJ7ERlp7et6FXFFzu5oDvIIAz7Xp/a?=
 =?iso-8859-1?Q?x0OFRB5zcctTjKgCo2IxUqDlg1YGvjW2jI70g61/HlkBgJ/Xn4wyrx0uPw?=
 =?iso-8859-1?Q?WNZXAAJdVD36O9xtTmaphdjpSorKS/8OARduvnNqrz1J2ICfqHU0vSzyrP?=
 =?iso-8859-1?Q?LqGBNlBSG7Pq+4rfKc+PM4Q1fUjSvy7SD/4bTv///t5nwaQ2g4E42/VMMc?=
 =?iso-8859-1?Q?HMqOj2dyimxFEgW9HxaKTQzU1TFC54BLakPofELXoWZ+QLtT6bJrpc8AxY?=
 =?iso-8859-1?Q?H/sGuVg0FfNmhzhps30jC/VQ/+lqteE/W0bNHnfGr2NsBHLp/DJBblmqdF?=
 =?iso-8859-1?Q?bj6UITNUCYy33IQlmMlMX07kphpIKW7x73DTMbDFR4FXIb1uX771zgFaTw?=
 =?iso-8859-1?Q?0e3S3ZlqGkVkRq2iADmbswL/GSZ+awG2T0dpbZTiyP+KlW5DHAkP0m6qIj?=
 =?iso-8859-1?Q?1+AYMYd2TvD54ClTALDP8KEj7Kqkpiwh8/KM5jlsSbKZSovRYWEBOTjdv1?=
 =?iso-8859-1?Q?YbfWcHjaPPEUnbX51yBTB0Yy5+uFlZnF65NduTPLvMMvzKJ2rBE5xhhGPL?=
 =?iso-8859-1?Q?P6dsMKfAWCiXJdSmmO0Xe2e4Iabm4/wZo8SdiNCLjYV8yGiCyj6MXdsFWP?=
 =?iso-8859-1?Q?/RCdL+6n30a4ERHDjz3f4HFWlbhIhYQ2qR7sck+b7Gnip8bNfEb90kssff?=
 =?iso-8859-1?Q?LHDD7WELZpzJvoI5/HMn/sj4JSgJtunxOWeTXVjbR5qjOcnbtexdVY9g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6136ab76-8138-4034-d2fe-08dc841b2dd2
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 22:19:04.8393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kDWgK7/cD/h4SP5oWC2VCxNKIPlgjjaUFEGKhatC/9lzlahLDfXPAWbYBn+ocv7CZM2LwUnQKHydtmMZpK6nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4808
X-OriginatorOrg: intel.com

On Mon, Jun 03, 2024 at 10:42:19PM +0200, Thomas Hellström wrote:
> Hi,
> 
> On Mon, 2024-06-03 at 10:53 -0700, Matthew Brost wrote:
> > User fences are intended to be used on long running VMs, enforce this
> > restriction. This addresses possible concerns of using user fences in
> > dma-fence and having the dma-fence signal before the user fence.
> 
> As mentioned in a separate thread, We should not introduce an uAPI
> change with the above motivation. We need to discuss potential use-

Sure. Agree this is really an orthogonal change to the other thread.
Just noticed we didn't have restriction when typing in that thread.

> cases for !LR vms and if there are found to be none, we could consider
> restricting in this way.

IMO we should strongly consider this as conceptually gives a clear
seperation of synchronization between non-LR and LR VMs.

Matt

> 
> /Thomas
> 
> 
> > 
> > Fixes: d1df9bfbf68c ("drm/xe: Only allow 1 ufence per exec / bind
> > IOCTL")
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> > GPUs")
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_exec.c | 3 ++-
> >  drivers/gpu/drm/xe/xe_vm.c   | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_exec.c
> > b/drivers/gpu/drm/xe/xe_exec.c
> > index 97eeb973e897..a145813ad229 100644
> > --- a/drivers/gpu/drm/xe/xe_exec.c
> > +++ b/drivers/gpu/drm/xe/xe_exec.c
> > @@ -168,7 +168,8 @@ int xe_exec_ioctl(struct drm_device *dev, void
> > *data, struct drm_file *file)
> >  			num_ufence++;
> >  	}
> >  
> > -	if (XE_IOCTL_DBG(xe, num_ufence > 1)) {
> > +	if (XE_IOCTL_DBG(xe, num_ufence > 1) ||
> > +	    XE_IOCTL_DBG(xe, num_ufence && !xe_vm_in_lr_mode(vm))) {
> >  		err = -EINVAL;
> >  		goto err_syncs;
> >  	}
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > index 26b409e1b0f0..85da3a8a83b6 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -3226,7 +3226,8 @@ int xe_vm_bind_ioctl(struct drm_device *dev,
> > void *data, struct drm_file *file)
> >  			num_ufence++;
> >  	}
> >  
> > -	if (XE_IOCTL_DBG(xe, num_ufence > 1)) {
> > +	if (XE_IOCTL_DBG(xe, num_ufence > 1) ||
> > +	    XE_IOCTL_DBG(xe, num_ufence && !xe_vm_in_lr_mode(vm))) {
> >  		err = -EINVAL;
> >  		goto free_syncs;
> >  	}
> 

