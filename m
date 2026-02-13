Return-Path: <stable+bounces-216006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCd6GgdyjmmrCQEAu9opvQ
	(envelope-from <stable+bounces-216006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 01:36:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A0913217D
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 01:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16169300E485
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 00:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B648A1A5B84;
	Fri, 13 Feb 2026 00:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVcyGRAU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E509EBE5E;
	Fri, 13 Feb 2026 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770942978; cv=fail; b=GXjqoqXndKY4SvGz4F8IOVdmFNrJ+pLGBqKlElWgd21OPQcACuzZtmZ0hI9XKrbs3Go+5Oy0uZL9NifqQnVSzAVMFEFa8Cfedu5y0k7zcbVOOTzg46URUBQAd7W8J+zlJINZW1tg3+sm/niGe4cfFCMObdg6BKbBaLiAciNTZAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770942978; c=relaxed/simple;
	bh=x3eKAaAg9Q/vrKAyzSsQPu0Lm9E++GLxAsYi+W7NbaI=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uAb4Nru+hcJ9TjLRk7a8S3jAJ9bE5BndHdFUGXICO4LIZkZiRs8AjWqvahPayKMrsIAZXPhey6tKgP6+m2CkrFYsQv9luSN14Zmq56ZDN6JU7iWePjPmSfCEIewQZDIYRGoQJwq7Azy2garRx/E0ebNtFKnsCxlQXqySTrE/9CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVcyGRAU; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770942977; x=1802478977;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x3eKAaAg9Q/vrKAyzSsQPu0Lm9E++GLxAsYi+W7NbaI=;
  b=WVcyGRAUrLRuNNE2037uSc0/aKlfYx99KRTkZNg37Cm5bjVLOdbWaOnx
   Ok27LroU76gQ/LIRk6R/+9eXo7DoYuYEqnW6dEWG5XdJYE2JtxfdQMn9f
   /YQ5ayGeu/U7Z874pqU7JbNvXtk98gp+XqbwZ3ayqSqQ3xr1szDog9V++
   XO8e5HgwJSAoxz51Sbwnx88hEHt8XW69OvsM2OqkMXt5TrP00SIUvzNjY
   k8pP6bmnLXAHndhwemSk5K7uyYOMaVeqiONylKP8b+5qkKa/lp8i0aEF8
   dELikRk9PZyn1vxKYtTCnGjlDws5YBL2bYSiVhRy8Bxg4hx76YMHsAuxG
   Q==;
X-CSE-ConnectionGUID: dfGR42dhS/SSPYe6mRLAGw==
X-CSE-MsgGUID: Oo4N6Uw8S0icTVtS734Qgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72021732"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72021732"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 16:36:16 -0800
X-CSE-ConnectionGUID: Mo+HvHTETH28X+0wsVAHWg==
X-CSE-MsgGUID: Gu8veoaUQjaJAoiqHb94/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211970118"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 16:36:16 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 16:36:15 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 16:36:15 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 16:36:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMctnDdsf0+/fYv3bGVJh4j3onJe2tGQFLczUPHw/cdkakUe/stSpyjC+U8ugy9e/Bpl8bQ3HysGeBLVgoxb/HZvIYvVqC5GfcDDPk+9xhNhHcCfWLAb6mhtPMM4CpcQpv4xUwPtMlb6/tXq4b68Jvu21pIKjpelxdvDvBfyNmg5QWFzFibh0cBHYdlaoBHFr+sUGxILDeWZofEIlb4nmuULSMgcmBEwLwJ6Qf+1MfLFv9b0IcztfYt4C8hOPL4BdnuIt9g2/Oj7J8PLOG/Ht4e2Jtg+Ii7uVsTNld0sMUzU1kL2yhrGL587smfxbEf9hjCd0p81bTuFPDcD1AH4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEbIy3qt/C3C5vXbD72IDvUgWN1Lq9L75ATkWdaTScY=;
 b=oREgZ2e+x66cVf6oPPih9tWRO9JfAL8OFAzh4z8tp7ebyXSjMuQI4ssdPexy8LmObknmrnPc2VzPCXuEVrjlM6VsLFCHd86kOivitZd7BG3mjBZlZQ4kwEHXY+cd857GiN391emngMrYQctYVQJ+SD910HI2kowLS++FpVEaXGmqXHhdaYTpTdvS9/aj4MWDyRn9JanX47vIDB+yajVA+bLEPPH9fRSKdZsQTJev65PjR1Q5JWMO7RCatfhHUkpBHdVaEXWmaCUIKAZJWRjo9nQ/8Lmvdnk4GNixXH2YIatbQZFuNMdD6LKXku5Dt2pCS5Zdeud1gN0wVe2+RcSfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by PH7PR11MB6769.namprd11.prod.outlook.com (2603:10b6:510:1af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 00:36:09 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 00:36:09 +0000
Message-ID: <fa74dfe4-ddcf-49e8-b621-f5d3b8761da7@intel.com>
Date: Thu, 12 Feb 2026 16:36:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] x86/cpu: Clear feature bits disabled at
 compile-time
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
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
 <57039edb-419c-4e4a-96d0-3578e233b594@intel.com>
In-Reply-To: <57039edb-419c-4e4a-96d0-3578e233b594@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|PH7PR11MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf496da-5049-4f6c-d32b-08de6a97e023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REtxVkwrSndramUzYUhBY0ovdHl6RXRUWDFld2NDWTgvZDAxS2tCcmdpY3NT?=
 =?utf-8?B?djJuRlJGQmtrVjJ3Z2hpbkw1YjU4L1JZVlpEU1hxOXh6YWx2d3lhem1CMlRh?=
 =?utf-8?B?V0RnRkhaWXBqUWw4NUVrUFFPTysyZnNHSUJFQzNQOGRWckRjRktWYjlKWGpE?=
 =?utf-8?B?TzVrTm5Qa0F0eDZ2K1NFZzRrM204bzFkSmp3KzlySm1BUDNQM0ZTbkNFRE1M?=
 =?utf-8?B?L0ZEbUFWQnpTc2h0MjBjMmtwN0dnS1VoVmQwYld0alpETVZqN29rVTNyOXo2?=
 =?utf-8?B?OXZCY3AwQ1krN3NwcjYvZ005RS92ejYxVFRBcFBWWDk4OTMxU3c0YjRBRFJw?=
 =?utf-8?B?b2syeVBOOE5rT20wNnR2V3FSdWlXV1M1OERzZGxWdmp1eGlVSUo1S0p3YnRI?=
 =?utf-8?B?djdJSGRNMzREMFlUVlFNVE9lcjRxcHJ0TTZTWUJRLzJtM2s2TlRyaUhSMi9M?=
 =?utf-8?B?KzFuOGRobHlkM1dkRlNaSUt3bnlMRnBEdHdWV1VvZEtFRnhValcrdE5CMk52?=
 =?utf-8?B?UkdQZCtsMkNoQTgxQzI2RVNJV002VTR3d3l1SlJpOTErTVhCb01adHJBanFU?=
 =?utf-8?B?L0djQzdJRzF4TnBQaWJlRjVBdmZocUk1ZU5wc0drN213eTcwNlV2N3VWTkpT?=
 =?utf-8?B?ZWkzQkJXL0VIUGZkTklPUXp5TG9raFd1eHB5U2h6TmQzTjBqMmpCY21UTUho?=
 =?utf-8?B?YURSMmRQODRJQ2FLRVZTaERYMUUrdXVhWGhYNVdUcWpwbjBOUXFPcEdOMmVJ?=
 =?utf-8?B?MTVBaTRmSFo5YVMreDY1ajFtRHZxMmRiQllCbnBOb0lwSjFqMG1KZW15b0lH?=
 =?utf-8?B?YnpWUjMrckpNV2RMbEhUcWFIR1hXdVkxaTJGOHNYYm9ob0lSTTk3bThsSFMr?=
 =?utf-8?B?R2dKVUl4Z3puQ0JBcTBENlZvRlU5M2pLUVVUU0xCMmdWRnk5VVFBZHRMYnNa?=
 =?utf-8?B?akJCdk5NN0pSYmNMUk9qYXU1RGZtc0JUNkhCYUMwQkd2bG1KOHlnSGRkQm5k?=
 =?utf-8?B?RGdjR2RwSGZDMllWeDFyZS9DdDZDZWVyalRETU9IbDZTU05TSTF4TTY2MlRH?=
 =?utf-8?B?UG9YYkZZb0dPaUFlZExmdFAya1lqTXNzTVc3WG1zeFdkNlJVblNKUTFoMnFa?=
 =?utf-8?B?TGluVVBqVng3MkFxdGpuOWVhWEtkSkhDQXdqc0tsdzFjTHQwUDRkTGk1Mkpn?=
 =?utf-8?B?ekR3bVZWS1E1em5aSEV0dnpqRE0rSVdUUndBY28xaHBDWWJ5dVFocnpGWm5E?=
 =?utf-8?B?V3lxQWwvTE1qNEVJRDZYdVhyU0c5TEVJRTFQcHVkK3RxNXBBQlk0QXNFakFJ?=
 =?utf-8?B?Vk01ejIzWFhqWWFmME9aalYzbWdDMzBtTXE1RVQ1aDdLNkZJb0hmQ3VyVmJy?=
 =?utf-8?B?ZE1oMG5nMDBNWmtNbnVmWDRlNmwrZmJjdkh6U3JDRStQYll1S21TS0ZVaWp0?=
 =?utf-8?B?N3I3eFA2YjNvNDJXSUh0TEc5c2VkVFdZUDY1Y01WbzJsNGVveGcrYXVCaHlB?=
 =?utf-8?B?MGFoV0lUODZWRFRYMXVlZ3pSR0thRjNxbzRkcGlvd24xcml1dE5hVXhodVZO?=
 =?utf-8?B?M1FMWFQ4UHlHNzBSNFVSYkJsaXYxUjNuK2tBMks4K2tlSndSWDBEakFLVkRl?=
 =?utf-8?B?UC9iUzJtZXJadFJiR3A2S3ptcUloR0VZV2c0T1pLMGNtQi9IU3dvdFB3SGdR?=
 =?utf-8?B?WGxUOStHWkEvMTlqRDFMSjJROG5zWUxaTEREUEEwNE9GekR5OTEzSEhJSlJi?=
 =?utf-8?B?V3dpcnhuWjE2aTdjaVRIbWhpN1pJd0k3QnlUZitJSUFOWGZCMWVQL3N5dlhw?=
 =?utf-8?B?NmkxdHpnOFFUK2NOMEowRTFTNGdkVW9SZEtVbk1zeFhRd0s4Y3AvZjRGRkNJ?=
 =?utf-8?B?ZTBzVjg3VXgzQWYxdjJhSFpkYWU0aVdidlh0Vm5uditOMW5sUDUvWUxLd1Mr?=
 =?utf-8?B?Tjd0VThrWWJQU3Q3S0RwQmtZbm9xYWtJS3lmYWlpZnZvSUkweVllSWZzNlYr?=
 =?utf-8?B?cmowQ1FJZko1V2ZuUUJpUEVnd2xsRERMT3ZSTndxNGpITkpXZEVaaTNVOVNj?=
 =?utf-8?B?a3p3NWFPRjU5Vko3ZE8yZVdMc29EckttMFdwRHhTU01kZ1o3MCs4UFAzcVZS?=
 =?utf-8?Q?buQ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2lrVGx1N0tLRmF1RmJDQVEvbUkzVzlIMmcwVEhMcERjSittTXJCZnFSc3Zr?=
 =?utf-8?B?cHpNcmJjZU1mQmk2WnI0VFNtWFJ0R05vdTFOVnRjOFVzdWJuaUxxeUV4bm05?=
 =?utf-8?B?QUxvK0xMV3kwRE9FdHBZRjEwQ2tIVGNKM0dkd0lFaFRpZmZFdmNsNmozQlpG?=
 =?utf-8?B?QmV1bTVBeDEwY3JhMEdDa2E2eXRTZFA4SkdxWmh6MEM5b3plOUpJZFNBL1dW?=
 =?utf-8?B?OFlFV3Z1VEdUWklTcnNTakxGQXFDSlFmWmdKa1hVamthcGNNVVlsbzgwZlhF?=
 =?utf-8?B?alhKVkg1eldPTXZQNzB0RmZES2pBdEpIYXBITCtEMk5mREMvdG1iQTY5T25s?=
 =?utf-8?B?NjAxZ0hvRFRBRlFYMDR4WVB5dlk2S2t5SUs0WlFRNmR5ZVZYK3hqSzFXTVZy?=
 =?utf-8?B?NEVMTTMwVDNIQzk0d3dzTERVZlUrWEdIUmFmeEhpRXFpRkNkdmNMNkJhc1di?=
 =?utf-8?B?czNSMG9qa3pIcVdyWGJMWGFaeHZTWGN4Z21lSGcyeGNuUm1vVmU4QVVHc2Q5?=
 =?utf-8?B?Y0J0czR3eVNjamEzaEtmWGRzd1B6akJFQ1VrZTBFTzhVWVRDa2VUd21mZ3l1?=
 =?utf-8?B?SGcyKzNYNkZFUmZud0JFMVV6OW5IOTlPUjRzekU3aWpLS3V2Z2lLNGFKQjNT?=
 =?utf-8?B?UStHWmtKakovOXJjeEFSUlRoOHVwREI3UmhoelNVRk9oQlR4bzhXSFNSM2R1?=
 =?utf-8?B?eWdHQ3B6UW1NTnJlYVBzZUdKdndKYlhpK2ZUd01HWjVPZGxZTkUyQlVUeTcz?=
 =?utf-8?B?cld5YTVockpLaUdhQ1lFTEJ5ck4rMVNRMlhNZm5EV3hFMnczc1p6Z0tEVmhZ?=
 =?utf-8?B?bWFpbTRSQUUvRlF1VC9MQ2FWaW9tbDBFcEI2VjVwYWFvRVRTK05pamhvcVJk?=
 =?utf-8?B?MFAyOEhHR1lJSHlPOXZuWFpLUzVBcWd5OXBycFFrREtSOHpxcUxGSjdWcTZv?=
 =?utf-8?B?OHFsK0Z4OU1mbEMxUHRlUHZnL3d6aWo4SFdVM0FRcXFHU1hQOW1YWGlEMVNv?=
 =?utf-8?B?TytDcVpsdnk0dzhwK3plUFhySHdhRndUUGN1QkJhRGNSSUxxaHhNeVRrcFNv?=
 =?utf-8?B?Y25NRHlrTzE1bk53UHBhVU1ENDMyZ3JFWFRmTUl5TFpMd1hmdlNCb3VHUjlp?=
 =?utf-8?B?ajg3akFZOXNONmFpVDFhemo4alBnd1FjSEttV3dTbzEra2c5dGl2emV3Vyt1?=
 =?utf-8?B?MDc0Wi90NjM2L2tNVkYrejh0L3VIZHZqV0Y3bitiSjBDR29ZOWlROHhxS3J1?=
 =?utf-8?B?YTluaEZyekJvL0VOc0tSbWNpaHZrNVhKZ0hYNmFmNFpoMUFLTjU0SVJVdkpk?=
 =?utf-8?B?bExHMmpweUZUejV6d3JzclRCQmVZNk50OWp3VEIza2QxV1dSNXNab1NmcWhG?=
 =?utf-8?B?cXcyWWF4TWlPN0svaENwTHNsMmFNaXh4T01OeXBIWk1GL200WUM5UG5jLytH?=
 =?utf-8?B?TW1uaDVUdHYzSzlUdUVKdFM5MDlQNHlKdTJJZTBmTmNYNVdydnBpdVpyWTBa?=
 =?utf-8?B?eFVFQUhVUlFBVGFMbmE0RW01YUgzQ2JtU1RyV3VkdkNCRUNXa2xOc3EvNU9Z?=
 =?utf-8?B?dFFwTGZyUFJGb2ZiWERGVHRpUlA5c3ZacXVxNWQxczJiQ0kzVGVuS3BqRGJx?=
 =?utf-8?B?QlcrWlBjQno5akJ3K2tocjBkVThvREpUYzdwaHl4UHFKNGErZlNhV3NrTDFO?=
 =?utf-8?B?T0R4cW9saVFKMmNUM3Y5aWJTd0taSG5ZWHBrQVRiS0kxRFl3SjJqUlJoZXQ5?=
 =?utf-8?B?Z1FsVXVZNUI3VFdhQnpwdkJEN2tDbkJJaVFqOVlYdnlFejZTek1XZTN0Rmpw?=
 =?utf-8?B?SExKMUVoTlF2L0NXYWtZVzdjNUlTUmJaS21QcytoOWRZL1lkMnJpaTRJOVJU?=
 =?utf-8?B?L0g3eUpES3l4T0RhaDVrWVhTa01zN2NqL0g0bFo0V2NNSlBhZmZUdzhEV2E4?=
 =?utf-8?B?aXRnV21GR3lIQzNoU3diM3g4SE9KSHQrLzQ2UXlYWlJVYW1aNllRNFk5QWFt?=
 =?utf-8?B?VGxVTXdSeGQ5eFJNNURaVmNpalpINWZBMWpUdUtnL2NGQ0I5ZmZLUGxING9Z?=
 =?utf-8?B?ZFQ2dnNiZGpHZ1dxdVc5c1IyREgvYTg4emhUeUI2RDE3QlNxTVZSSlY5cGFi?=
 =?utf-8?B?VlE2TVJ2cW1uN3d0RFkyK05rUTlmMHdBN1o1Y2RpeVFnWndUZ1U0bVlsU0Uw?=
 =?utf-8?B?UG5GelRWUlBKM0d2YVRkeGh0eE5FbTdPRFBXZG5UcVgzZnBBZ3JCbzNRSVUw?=
 =?utf-8?B?dWdhVm8xT2UyMFg0QWw4cXRVdWx4Wm94N0ZmQkgzYytndTJhbDMzSzhoTVV5?=
 =?utf-8?B?dkhPcGdsOVphM0JkN3dNSGVKdlp6enhVWnY3WVlWNlhMYThWOEFxdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf496da-5049-4f6c-d32b-08de6a97e023
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 00:36:07.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nN2icerKzU8MJgKnDYFGPkZc39zZCsvEoqPQWDRNTfuCF8cWKbHrsTfjAm3suQP/jvgJeH3RRczEfKuDtySyTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6769
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sohil.mehta@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216006-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 84A0913217D
X-Rspamd-Action: no action

On 2/12/2026 4:14 PM, Sohil Mehta wrote:
> On 2/12/2026 3:47 PM, Borislav Petkov wrote:
>> On Thu, Feb 12, 2026 at 03:04:44PM -0800, Sohil Mehta wrote:
>>> Can we just deprecate the "Flags" bits of /proc/cpuinfo at this point?
>>>
>>> No production software can be using this meaningfully.
>>
>> Before you do, grep glibc sources.
>>
> 
> I meant freeze at whatever we have today but stop adding to it. As
> described below, it has been buggy for *some* features for a long time.
> 

On further thought, I realized that it would be impractical to implement
such a freeze. And maintaining the two separate interfaces could become
a lot of burden.

