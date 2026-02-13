Return-Path: <stable+bounces-216004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0POzKNtsjmnuCAEAu9opvQ
	(envelope-from <stable+bounces-216004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 01:14:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D308131F09
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 01:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC4D23048060
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 00:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F094B17555;
	Fri, 13 Feb 2026 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsFsXKm6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D081548C;
	Fri, 13 Feb 2026 00:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770941654; cv=fail; b=pDc/2Gf/cR4YaGdPEvIY7MVqHb3ovOBVAO2pb7oo3Y4nZHuf0c0gWUfvK+fmOu0ZDlv2rDFWPgY3VnvthLB8ubL9FAfpuMgjNrwRpGN2EGPak1ogrYK4/YKmrUwjIbuQhXY9VfgnsDvf2dXp1OrZl8aN00Vvvx4VGXcbW8DpB0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770941654; c=relaxed/simple;
	bh=5rUCp45fpeDvD0DeA1zy7gbp3mJM8drTWrIS1ttoYu0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MlKpHiZRAJb9R79DIG3XrX12cR3B1wVXU/B1DClJw+nquO6G2HWkDJ2NawFPPNZGVbuIowUbKzWdGsqERM7Q3cB4zr+90AkOtNmGbMKIgnFgEVYM4/K0G3/HTPDnRozM7UrIS0F4SeWsXWwlOAwYpSR9XMbVbGMj6+Ni/r+gAJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsFsXKm6; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770941654; x=1802477654;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5rUCp45fpeDvD0DeA1zy7gbp3mJM8drTWrIS1ttoYu0=;
  b=HsFsXKm61mLnfbcSLe3ItMjc9W4tG5rjbYTnVbG921xqMuWT2KMC09ll
   nS6D5TIGIyR9FAA9FzY6iwRPIfR4a511TMa3XN9vECsVKSAGWyk7pb39p
   bnZ/XAQAKGdAhcm+c71TE+BmEyPR1RJxTbiaMDU3hBmByd8cHUMXvpPsF
   6fnX3J48SWi+nbXDigM52wRHWOCJdzFBXA2tf4d7SfTCA0vcOKQtR3EUk
   0iadFX84ngg/ZgD6fqFXDHqPHhzGdLdicCb6ClCb3sDYvvUaAfV1RA9Ur
   oVE2kyOExgNWAFydNa+zF4KeEMIgT6DibtZdy5jBqSVFgMH9m09zJMuQW
   w==;
X-CSE-ConnectionGUID: 18Nt7mLXTPaazq/kxTuH5A==
X-CSE-MsgGUID: ObcBwReqTBubcz0JpqG/xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72308002"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72308002"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 16:14:13 -0800
X-CSE-ConnectionGUID: cBM93GaNQD2f7um7aQp5iQ==
X-CSE-MsgGUID: z7U74WIJStiNxqFoxco90Q==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 16:14:13 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 16:14:12 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 16:14:12 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 16:14:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGVGuR7MYth86KgduU097+rBpD3xSlIeGSCmqhOZHubAz2RxT5AGQfRQWabP9NgPN4nhOCcrOBRnTZE7Yzilsda7cj6U8Wd4DGN82aNyaIPfpUz92HoiG9j/QDm603GQimGTvbFHn7UA6urITr7grDKpuVOuj0sJdlcA7S6Iqiub3pttblSPiSIduGyNol4ntRa8b2HPshcgtNZh3VSjWNsxwPNSLlm7YPfmgJRYqFNAuIllNc+rGAnwG0dwswAHxjQt/k0+xRot8Pyz6KlspxwgIJpcSnYchVQUFP3Kb9S5myTf4eUsZbavJrg1VghpJFW5QXEQKuVS9GtBMmm+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTuB9Kis11PR59JFjXvmPgVSklfbusZOu13474za0KE=;
 b=Au047aXfQL0oB3RzPkIuMJ7emQHvHTzzVGJl+LwBOAcCARhJ7Wd3PW64Y6wHpLjd5X4tiyqSME1Z4N8Cwxvli9rDfznGRDbW4qFbYlzbkaM4ueC+R6dMeZZNkuOQtvsZgYNHv7CDNWk03cLrVCw9Q/vY/r97fRp8HipCg8SSbcUsKv8kZWwG4xiO9HXCFAchYxMNBh9Qg27sJ7o7mqnY2N8MBc4U5OQpMHQ3YiM0UDgvH+rR3VQPaG0GSAlwPrZVNR1WmwUL3U2FtidQSY6hI8Fn6T5gNK1HYty1DrDjpw7VjxX5msjD8erovnleg6CAqOIxUTnOZzVQinLcg+piEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 00:14:10 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 00:14:10 +0000
Message-ID: <57039edb-419c-4e4a-96d0-3578e233b594@intel.com>
Date: Thu, 12 Feb 2026 16:14:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] x86/cpu: Clear feature bits disabled at
 compile-time
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>, Maciej Wieczor-Retman
	<m.wieczorretman@pm.me>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	<x86@kernel.org>, <pawel.chmielewski@linux.intel.com>, Farrah Chen
	<farrah.chen@intel.com>, Maciej Wieczor-Retman
	<maciej.wieczor-retman@intel.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1770908783.git.m.wieczorretman@pm.me>
 <32fbbfc16974cfed11e7d2651bce836ba9ceaccc.1770908783.git.m.wieczorretman@pm.me>
 <20260212155808.GDaY34kOTrEYHLdoyK@fat_crate.local>
 <aY35H-VXwoSLFXoj@wieczorr-mobl1.localdomain>
 <E9F385CE-83B8-4088-B6FC-AB113F8DF55C@zytor.com>
 <A9F52EC5-EC74-43BB-BB3F-351F684BF5CE@alien8.de>
 <19d3f1c8-01aa-4a50-81e0-6af3fb7fe9cd@intel.com>
 <20260212234722.GFaY5mimfap5YbOi30@fat_crate.local>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260212234722.GFaY5mimfap5YbOi30@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::34) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|IA3PR11MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: 6073ca0e-4edc-4ecd-29fa-08de6a94cf37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zm5kN2p5ZFhrOFIycEdFK3RjUndCRVZmVzdlMnRZYjFCY3dZdnE0N2lTbkRC?=
 =?utf-8?B?NkkrWFREWm9mRUdZTlZ3VHRNcDRGVndFTXZUM1gzc0JJb0ZtLzNaRjZyVThV?=
 =?utf-8?B?VzhwdnN4L1dTTTB2TjV5RHQxdzFLNC9ERDN1aDQ3YzBFVjRrZWw1YzlZK2xp?=
 =?utf-8?B?b29UUFZtZytBOE9kVjZ1QnFMc1RLWHh2VHlvOUhMTDdoOGdWMkhlbWNNbEhk?=
 =?utf-8?B?dHRVY2dJdld2UlF5U2JVb1dYbHl3VVl4b2xnNzZjMS91akJJQTRnYzV0ZHUz?=
 =?utf-8?B?NTRacW9ScmNQVnArM2hVVzk4WTVDSkU5Sk9rcytrK2U4K2VwK1ArTVYyV3dv?=
 =?utf-8?B?MTZuWVNkV3Y2MWtxZVgxWkpBdmpnVExkVkZWKzhZYWZpVG9IL1gyYnJTcUtZ?=
 =?utf-8?B?K2xZekNxWXFWa29yendCbUcyWUpIcFBQWjdiU2YyWStyTkUveWhodVorZDVU?=
 =?utf-8?B?RXZqbW5iSFJ4N1lWU1FFcnNkOFNESXZwTkh0R24waGpnSUNpZ2pYVHBSMFdS?=
 =?utf-8?B?VlRtbTFtUHE0Tjh6RjhReHluRXRJNzRYY29YdWVoUmswZ2pDcTNXTXg0S095?=
 =?utf-8?B?aGdMN3RNVzV0UFRHRTVrODY5ek5oRDg5aXQ1ek8rTFFmUkJwSlVrMk92YXMy?=
 =?utf-8?B?WjlzTU9IMUc3Z1ZnTVlxamt5VllMK0pDMFR1VUdpdmxJNCtMcTlocHpmeklX?=
 =?utf-8?B?UW13ZUtNZTlnK25DWS9hWUNoVkVjK0NQRkVUUE13UUlPcC9Lakhnd3llZGVp?=
 =?utf-8?B?ZDVuVFBQUEhiWE0vTm1xSXpSUFJGdEhLQW9qeGJzWk5ETmw0ZXRqUGV2TSti?=
 =?utf-8?B?MTJyalhNRlhYMlp3SDIzUWRqVmJHUDB6WGJqZFVOUmNCL3lLRzFEdzlvUDFB?=
 =?utf-8?B?cE5mcmNBUjBhK1g5bVdSWlBIcC8ycm5OVlQ2azBLMU5lZkJHRi9RTzlneURC?=
 =?utf-8?B?bjhSdkx5L1lhbStIMnAwZWUxNmZDdXk1d1JZeXFLUDAxaHFhS2FNTmhjcDJk?=
 =?utf-8?B?dWx5MUE4VDd1Yk5XSUs0MFI0QVhDekNod3BhTFZ3RnNENTZROTNJYmVJZGVZ?=
 =?utf-8?B?ei9MRDJtVG1FVmpnVFk5UnF1RlVKR1VxakNnaEJXWUZDWVdqbTVRcnpPOFpT?=
 =?utf-8?B?RzE2RlV4Y2xNbHVqV25PSFV1TEdvSEpKS0RzdStaS0xiKzF3eXR6SEphcitO?=
 =?utf-8?B?R2FYUmxMZmZMV21IQU5ZTGhqc0c5Q3pEUUc3VFhNSk0zMDl3eW1jUkQ3ZVFF?=
 =?utf-8?B?bkZPWGlEUUt6SkRXV1pkbjZYanlzZENSalZtaU9MK1NEcldLaFM1c3JuN3VD?=
 =?utf-8?B?RzFoYnZvdUNac011UmxtQ2JRc2J5L2hxNHFKdkwxaDd5Tk9BWlVHRVFQZHIr?=
 =?utf-8?B?QnZrYnJsWlMwREVSUWtINUw0RktiQTdZcVhPTEpLSk9qdnh2enBZL2EzWXV0?=
 =?utf-8?B?bWhrWlRrVlM2aFVTQ2pXUE04WUdybnlQOXJ4STZoaVRtU1ZmK3ozMEdKWUEy?=
 =?utf-8?B?K0wxNU0rRDRPbnVDOVM0UHhjV3B4SGJqMEdVMkF2YUpmLzJtT1ZoeW5jZWNS?=
 =?utf-8?B?aUFjVm0yNTROdTZyYlhvZitKUnYrNit5bEZVRWpJR3NNR2xmQVYybVdaOE51?=
 =?utf-8?B?WVh2dHZxa0J2OFdISDNjdXlhN2F5c2RQcFVHcU9kRithUHhBOXgxUVBWK21F?=
 =?utf-8?B?emE3UUFiT29aa2pWbUJJT3hYUnZHYkszL1BmdXBpUDZ2Z0VJTnkvdSticDFO?=
 =?utf-8?B?SCt4WnZMYTlRdEdrdXMrVjFoamlhNHRMdTI5ZGdpSXBPcjJXRVhMS0k5WlRh?=
 =?utf-8?B?KzNSQ1ZHNVJqVTFvODhoVTQ2RElab1Zyc0lGVHh3SWFMQmJTdXJodU9OcU9p?=
 =?utf-8?B?WVpON1U0ekRyTU5obUliS1N3YlY3MmNkbXM1QnJvYkR2M0E1allvUHdQZnJ3?=
 =?utf-8?B?L2FLWjBxSkpOcWIvb0dpQlc3S0xGK3QwdjRJQVBTcGcrU2dWSld5VmVDclN2?=
 =?utf-8?B?cmh3a0trU0xibk8rVlZmaHRyV3hqVmdLdVR2d0Q5OGQrZnY4UjZIem8rSzdV?=
 =?utf-8?B?aTVSaUxZODAvTlRMTDA2bDNZWUZyTUhmQ0UwVjNOb1Vsb25TM0ZIRVk0enND?=
 =?utf-8?Q?cL8A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGhsemF3VkJoTTlQVVloSlhPYWFrK2VZSkR2VUdPSkxaWU9pT1JoYWNPWHh0?=
 =?utf-8?B?cjNFeG1sbzJJdDNIbk5aUDVkc0hqT1ozTTBlTGpQdTd0QmhPdWdIMjhZaVFy?=
 =?utf-8?B?NzNiUlg3YXlZN3IxUEZSQXpKSk5BWnl1MFlGVDNoYWlaajdvWFljUVdEdDEr?=
 =?utf-8?B?Y1lYcFRoQWlEUkZOQVFpbUQwdkpzMHFsNWlrRlpCd0xqSGpjQVRwOG14cE4v?=
 =?utf-8?B?WWhPY1doU2htalBubmVkQmVpdGJuekRaZ0N6MGVyQXFuanYvMm9YcmpxbUJN?=
 =?utf-8?B?NCtaUjViUzAxTUdSNlZGRkJvOTRkdHhJVi80bVZYVHEyL3hPSHF4KzZNdG5F?=
 =?utf-8?B?cldTdStETHg0RWw1b2g3bTRyeVdvcUo3emtZMklPU1BzYTErRTE1WVh0Q0RT?=
 =?utf-8?B?dGJVc09nYWxYRXBoRE45TDI3ckNud3V1MFBXTnpqcmRkdlh0WmQzK3lJUndz?=
 =?utf-8?B?YWllcCs5NWdHeTB5QUIyMS9nVlBwZk43ckZOV0sxdlBCN2o0dHR4dUU0SUZ3?=
 =?utf-8?B?ZUl4N0NwZm52b21GZTlidVYyb0tGMUZiQ0xvWEtaaU1wREQ1L2h6VHFCbUtZ?=
 =?utf-8?B?dUFLQnNQckM0cDg3ZzVjb1JudmNlZWtnUEdTQzlPc1k1dU0xMUhWWlNkc2FV?=
 =?utf-8?B?aFFYSmJ4djRVMU0zN0VUeUhyNHRudTQ4eVVFWFByOHEvS25wWGU5RitBZUpM?=
 =?utf-8?B?UEJvU3Bkam1mSXVUZG9yaFRBSzNSN0RwNlMyUEFGSHhxOGdsNGZ2bDgyR2x6?=
 =?utf-8?B?NkdBb05ONFJuSFNJVHYxc2RvSFJJcFhtRG45ZlMyNEs5bkhTUDJmTEMyL2s1?=
 =?utf-8?B?M0dybHJmOEI4YnpIbDZYK1dRbTVGa3RYTzF1S3BSM1duc21FblgyeW1OYjhZ?=
 =?utf-8?B?aDhrVzRTM3kra2k2Yjl2bXowWHU0VDZLZmVDOUVvUkdFRkZlTWRSZDFGbjhs?=
 =?utf-8?B?NVFtQXh2TU1aWlkxMlkyd1EyUWZsVllzM3V6K3BCY3ZidktUSGorb3dPdEZa?=
 =?utf-8?B?cldkN053Y1ZpcGYrODFnWldlMHB0RUpKakx4OFdmeGdEYmc5dHhVQldnMDNP?=
 =?utf-8?B?R0YveElCR1VvMFdCcldhNk5ESVdwRWlyVUVxMGZJbUJUTzdWZXJCZ3h6S3Za?=
 =?utf-8?B?TnVFeEgvMlk3QnpBTzVITEFwQmcwYVZsaGtQTnViU29Vd01KWTFMUGFwN3Bp?=
 =?utf-8?B?SEtGT0dxNlJSWDBRK0cxTm94dzQwbFMwNDJramRXQUExSUViRmhVWnRZWmNJ?=
 =?utf-8?B?M2F1ZEt0djA4ZTY5ay93N2RqSmtZeS9DMzZCamlmSXNIMmdNQnhGMTBsS2F1?=
 =?utf-8?B?SVV0RU5MQUdPOHdpd2hEWDdXRXpIOW9CZXBVYzVUY2Q1RWlTaGRUUkhzV3F1?=
 =?utf-8?B?YS9ZS05oL3hhUzdYbjV2Q0FicGZSbUwwc24ySXBjQlJlVTVSRXgzTHBZQUdS?=
 =?utf-8?B?d1NJNnBzZW1MY1ZsN0I1NTJhRk10T1dzM09KaC85SXNieFcwODRVKzI1VFBL?=
 =?utf-8?B?UGRuZUdSS3RPamh3UE1hVmV3NjR5Tzc3NW91dG5HQjFHTXZORURJWmN2a3VO?=
 =?utf-8?B?b0E0OXdnRCs4NHZFUkNKWlRXMzZrWEN6dDJWQWYrVzVTNVN4a3ZJQ09FTCt3?=
 =?utf-8?B?NFlSSDBUSlkrQ3JiWmM1aW5WOWU1aWo4citmK1pmdEVicUVzUGxKbnJ0L21Y?=
 =?utf-8?B?UW9MdHRJNTdlQlVYTWtDaWVGT21QSHZ6L0lQZ2pjUW5jUHRnVWYrVVVXUU8y?=
 =?utf-8?B?TmJLbGs1VVBrakg3dXJqQmw0Y1dDMlhTOXFLQ1JaT3JWQXZPKzNNMXFnZTF1?=
 =?utf-8?B?TW9oRXBOblV0UEIwaXI3bnQ1WVVDRjdLL3FGajBFVitNZUZNYTQvckhjampW?=
 =?utf-8?B?NVB2Tm9KRWJiRzlQU2QzY1BFaDFSMU5BNG5oM256NFRTUDVWSkVCWlVzSzVI?=
 =?utf-8?B?LzJPbWZOMDlNNi9JYnNpbTBEVjYxYy8xYnA2d0I3UUZkL2hRTVdvdys1TlNT?=
 =?utf-8?B?bWZtSDY1Sm90MEdjKzZzYS9FZEZkTyt6eEg2UkNIZG5PQ0YrZm9IWUd0a0hN?=
 =?utf-8?B?KzFLOUFna1lacFppL3ExbzE0SUM1WDc2S0JlaWFGS0tyWWw3cDZ6b042UHEx?=
 =?utf-8?B?dW5hWFJuell2bTBxeXYrRzF3OUxGaFcyU0dHYm5JcWRyN2ZaMnF0Wm1BUHhq?=
 =?utf-8?B?UnZRSkR1ajZpN0VKejVuekMwbTVieVdCZ2FqWDd2Sm9mRGxtNmd5eWNRenM2?=
 =?utf-8?B?dk9WUnU2RGVWbnlzd0hPcXo1KzlIVlhDUzd0dUQyYUNZL0t3b2F3N3lrcDE4?=
 =?utf-8?B?akRwZTF5ZmtvZGJVTElGOUtkK1RSellPVXNuUTVRK1RkU3NJSktPQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6073ca0e-4edc-4ecd-29fa-08de6a94cf37
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 00:14:10.1488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvAEFmMcUvaSlDZ3IcforUc15SSHr5hWgL6Tg47bk0ZdT0ix1hDLTOS0tN9v7SaQDjEeViAuZGWcgv8fZ3knkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8985
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sohil.mehta@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216004-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 1D308131F09
X-Rspamd-Action: no action

On 2/12/2026 3:47 PM, Borislav Petkov wrote:
> On Thu, Feb 12, 2026 at 03:04:44PM -0800, Sohil Mehta wrote:
>> Can we just deprecate the "Flags" bits of /proc/cpuinfo at this point?
>>
>> No production software can be using this meaningfully.
> 
> Before you do, grep glibc sources.
> 

I meant freeze at whatever we have today but stop adding to it. As
described below, it has been buggy for *some* features for a long time.

>> We have always said that the *absence* of the feature doesn't mean anything.
>> The feature could be disabled or the kernel doesn't know about it.
>>
>> And now we've realized that the *presence* of the feature in /proc/cpuinfo
>> doesn't mean anything either.
> 
> How so? The presence means, the kernel has enabled it. See
> Documentation/arch/x86/cpuinfo.rst
> 

The commit message says:

"The features are also visible in /proc/cpuinfo even though they are not
enabled... Examples of such feature flags are lam, fred, sgx,
ibrs_enhanced, split_lock_detect, user_shstk, avx_vnni and enqcmd."

So, as of today, if one of these features shows up, a user can't be sure
whether the kernel has enabled it or not. Right?

My suggestion is that:
Instead of (or maybe along with) fixing this buggy interface, would it
be better to put this information in something like debugfs/sysfs? So,
at least new user software can start using that.

