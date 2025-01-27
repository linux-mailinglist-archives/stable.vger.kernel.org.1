Return-Path: <stable+bounces-110871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE91A1D7A5
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 15:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579457A2132
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BD55672;
	Mon, 27 Jan 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwsmv5EI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D7825A643;
	Mon, 27 Jan 2025 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737986602; cv=fail; b=FqLil3AYYyXMcHzu8W6KnJgZD3blZueUarWj1aGsNj7xHH3IvQcS86fOyVDeOzELZVKg84TPSeu3fqIpNOxrY0j8MRkHcIO+T9ifrwhAWQ7X6ncCPKvRc8Tvq/FFnC/NsOMFlC+lzNR4oMPMWo6SblhByPRJhjE8XTANQsvsMPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737986602; c=relaxed/simple;
	bh=fhebTwGf0Wr4AbfW44rIfUbyBHm9ADX3zqO7d0convo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oAh4DFqIbTDgtEnKrCaWM0G5mz7YKad4scmmBe/YJ4+bTPY6j3zqB8nNRFF8dVVVZt3rtxPQe1vYzt9NG9t3+Q7G3vjqr35l+ukdXSwkgM501YVY+FYWAktU/ds8ngmMl7T6vhl27++3C6mBofIxtpina08XVtS9x7kJ86RqoVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwsmv5EI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737986600; x=1769522600;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fhebTwGf0Wr4AbfW44rIfUbyBHm9ADX3zqO7d0convo=;
  b=nwsmv5EIonBAs2AI9TvfpkoFt5RTNvMyWGJlOPNb0W3mHqH6kK9WnVTo
   u+3qFMjBI3GhHlxZqrbZepYrZy5OcaydTT4Xls4XSk/6BEJvRmzCiS2Z+
   AuBpGIvvWw0vaSx/3b4yedqpEJ86AHZcU+PM2L/D2NT3BLLnAblH+6lJy
   uiBNHYCGxXRZ03pRurUM/M7YVah0PUCUZgYXhS4MDleDL05NvLTcyKnws
   k3FRYc+BETjbSdkJDUlKAZ3qfzZ+WzRwJnr9ozobLbSKoDJwW5QJ3VDzX
   Is8zk/CmDBE7tJlSzRJrI0RRGOO5/8tRCnohvplUDwJbWOuQsh7+uZMMq
   g==;
X-CSE-ConnectionGUID: oQu98W+kQ3+d9qUeAcy7ww==
X-CSE-MsgGUID: Pl6Lio5ATeyDa8DjIMvo1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="26047505"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="26047505"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 06:03:19 -0800
X-CSE-ConnectionGUID: CDuDD/D8TyG+0/3cpiu6pw==
X-CSE-MsgGUID: FKVggsUxSCCTDzAuWNWwnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="139297062"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2025 06:03:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 27 Jan 2025 06:03:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 27 Jan 2025 06:03:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 27 Jan 2025 06:03:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rtn9QNtsxrnnpG4J87KL+zcCdHEr56klS3RtULYH7r3q89jo/7zHouhq3QkU01Rdvv4erKRURIj6Te1R6+ftXYrEqUcaVD3dD0uRcFuG3mfkJGcYouxCGSHntxWbzTfiHpl7qJts+liPv2gcMEum3v70BJbBgUrng4r5HO1te7nx9+lzUHBZffWHXLRTLyD4L3b98Y01EPJExamFTlQIkYMXTvv/bxEuLEHm/gz/jZw8zz8HiCUXLNcLML331PcStGyBgjjwCvtI4zHm+hCLZkfWtzNO0jQzdP84i4BEePMY0lMcBUWm5xeOl7ox7GAK3lMovkQ9fHBqhduKGOShMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMDBaqY4yGknV4RM8GkaNtBUvtEKe+JB3zJKXzFPr7c=;
 b=w1OB6dDjceoVAmLBq1pGfQvZTbgitycxBusP9flQhAXHD4Lq+zTfjxxFGjKVyT914HQt6wd+t2dqrfUV9+pwxgpaBxm1bnh0ViS9BMMf4MH7nVuzMj6S6vmb7xe4Z9QWWZ1ij1LsKLVFJliIIwqUjFBLbD4/MLwr5MmvK88JtC9w4p/aL2vTN0ZYeIdcmgilbUXF5D4flF1WOUi/GwTM70TUiExjuOc7t1qQkrwLOBK0yudauWqfyZ5LNUIRnG55pUKO6p1DBUvcc+4yAE/doepF730Ju0gzCxGKVn0UXhL0HUSbiQcnYzzq0JdFtCGzVTpm9BZaF8rfJo5X9xH6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by DM4PR11MB7304.namprd11.prod.outlook.com (2603:10b6:8:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Mon, 27 Jan
 2025 14:03:14 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 14:03:14 +0000
Message-ID: <c96e691c-09e5-425f-804f-054c57b4ec2f@intel.com>
Date: Mon, 27 Jan 2025 16:03:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch"
To: Josua Mayer <josua@solid-run.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Judith Mendez <jm@ti.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rabeeh@solid-run.com>, <jon@solid-run.com>, <stable@vger.kernel.org>
References: <20250127-am654-mmc-regression-v1-1-d831f9a13ae9@solid-run.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250127-am654-mmc-regression-v1-1-d831f9a13ae9@solid-run.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::7) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|DM4PR11MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 543dd478-c878-4cba-dec0-08dd3edb577c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OE9GenMyU2dDdGM5aGxnd1lUUUdLelRDTFlrdVBkdExsR1U3L2s2N21GRVJw?=
 =?utf-8?B?cGIvbkdhendYcVZDTDN3M3JHcTNwUFFZaXdzcURINFVXTVduUkJua2V4eE5Q?=
 =?utf-8?B?T3pyUWMwR2NjWEZVK3pjWmxabmYyaXMxZStBMXV6V1dpbkR1d1hEcVJobXBB?=
 =?utf-8?B?SGtlbmkxNTFMUUlFeFdHaW1nSk0wekNMSUdicHdaa04wQmFNeWx4cmN1KzBu?=
 =?utf-8?B?ZmdWWGt2eDl2N0dST054ZjIyak9iQnVxeGhFdkRnK3B2aUd1ZGlxUnNKNWty?=
 =?utf-8?B?QzdZUzErbHo4Z1FLeTdUVE9yUmtpOVhmUlJMK3N5bWxyOFkwQm1VbUdyR0pL?=
 =?utf-8?B?QWYraWxpbzRBeE9VK0FnS3lHREdiR1l5ZXVVdUFCcG45RXFvdHY4L3VuSy9a?=
 =?utf-8?B?aEhhd3lVTXRUbkM1N0wwZnF3aEZGMUJxQ2tuRXRKM29sYjF5ejhSWUYrbGxI?=
 =?utf-8?B?M2d0RzRUQ0JURDR2VG5Ea29JNUlLaEtGMnlCZmNBaHo5SGVVckQvMzZ5Mi9J?=
 =?utf-8?B?dm13ZER0OUgzbDByOVpvbE5UTmlxVUJqK2JEQ3NqZHlwSVpxVE9mWlhmR0sx?=
 =?utf-8?B?WkJxMFErTlZoczN5blNOUjVFODFibXIrenFTS3ZHdHk4OVB0MVNYdXN2NmZn?=
 =?utf-8?B?NjVEeGs1WWY1M2cvb292M2NWeHl4YTJ0a2dKRWVyZm83eEVCQ0lBR3EvbFBI?=
 =?utf-8?B?U292NzlNWGEvWWMzc0UrYWhhZ1RUbVRjbGRSM3JMMW5zd2EwN200NDJnSks1?=
 =?utf-8?B?eXg3QlVDNkI3Z1JOQ1RWUDNLcWZ0ektCa2dOZTY0MHl2N0tZZGVzMUFPTHEx?=
 =?utf-8?B?aTJIZjNmTk4weFJsdVp4Y1VuOC85c3dpRkpOSkMzNVhhUnlUaHB6dGFIakpz?=
 =?utf-8?B?dDRobWpTekhSN0pmWkNycW00aEdVd3V0YmRSbll6Qkd5MkpTb3BUWVByZTFt?=
 =?utf-8?B?Z1VoMGxRK1pyQ0NncDFzbkNrTTBCUTZmL0pqWkRhV0lNbmFLdi9kUnk1VXZk?=
 =?utf-8?B?eXNCdmFKd0NrWitqMDVvYW5ROG1KalNhdjdHUTNWRThJZlNKMm56aGhHQzlV?=
 =?utf-8?B?eG1aWU96S20yWUQ1U010ZGcvNHlPRTZnYURKS01wZm9FWERKUXBsbkJaMWJY?=
 =?utf-8?B?czZob3BlNlczcGhKM2FaeEJ4NURZc1M3bHZCTHlLLzZzNmRrTnZHS0FYOGRK?=
 =?utf-8?B?bHhiMFNxK0F6ZFlkbjB5M01XVXd6U3E0VWxVWVFtcDBJekVrdk1BeGZweUl1?=
 =?utf-8?B?VkxvSndVTk13VnEvaUtoaFVIb0hrM3RTN09OOTB3VHNpNGJXbytGNnpGY3po?=
 =?utf-8?B?cEZpS3BpLzBrenFodE1BdWlXQWN5OWc3Z0dSTHV3Z0p4ZHpPaWtyLzh3b3p4?=
 =?utf-8?B?OWxOS1R4YThqbUlwSm9BOC9HMmY2RENwOWxWYnhTM204VXNYbzRBdlIybTdB?=
 =?utf-8?B?VXVqR3gxSzVrUG9EYk9CdzdpamVRblN5M3I3dkZMTXhpYWdWR2ZZUFc3WEtC?=
 =?utf-8?B?UlY0dmtKcGR1bllWQ2lkMXJQK1VwNVprMkx4RWNia1ZzSWFqQkQwK2VVN2Jw?=
 =?utf-8?B?K0pzSi9HVEU1andMVWVGNE8xL0VpWk5aL1NQa01QM0J5WnhqUk1YMHhzT2pS?=
 =?utf-8?B?VnBiSkgxdThoU2pJYnBTSU5pWC9EYzc0TVJlcG83bnVobEtKRHRoWjNmbzVL?=
 =?utf-8?B?TTBJUHR6cFpoMHR6c3ZhcWJYOWN3TGxjZjZtOEhnZ1RLWVVNQzVzVEJJWjd3?=
 =?utf-8?B?R2NSNWFvWGp5aXJ6eFBvTkY3ek9iTjQyallyekFxWG5oSGFGMW1OcnRyYmww?=
 =?utf-8?B?MUMwUStWaFFNTnZJQnIxclppMzJib09LTGcrcWd1aEtqMmllVFY0YnV5K1pO?=
 =?utf-8?Q?no+u9YcZzZL3T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejhYRlAzbFdVRUN6QmlzV0l2SklWNWh3R2RCU0paSFNUN0xDd3RJSXNhSzRi?=
 =?utf-8?B?WjBJblo0OUZNdW9nY2VkR0hIeGdrSzNleHhUUitUNmVybkc1WHhLMFYrT2s1?=
 =?utf-8?B?REh1MTBrZHRLMTM0OVlLTEdMdWJ3R1RYT283emtteWUydFFBK2VyVkZBUzBD?=
 =?utf-8?B?SVpBM2gzQTRzc3NJaHY3TXpGR1ZGNVltRWFTNDRPb2V6c1EyTS8wSDl6eG5l?=
 =?utf-8?B?Q0xERGluOVVWZ2tjRVpNdVA0MVUyc2I2K3A3QlY0bzg4dC8zUHN4YzBlVmxO?=
 =?utf-8?B?YjdlbnY3YjNOWVJMb2JkWHFPNGphb2lvNEQxTEtOVEdpSVlNNnF2NW54RWE3?=
 =?utf-8?B?Nk9LN01GSzVUTkpKS09CMEEwcG5ac3Z6MlZaL0VGZVNkWFg2NUgxWDdGc285?=
 =?utf-8?B?MnJXSEFkM1BWSnJDUUI2MkUyT0s3SXEzWHhFc0JIVmxLOVFFcTgzd0hacE9T?=
 =?utf-8?B?MEltVXhJRUVDdkpoUWNVdTJZeGhsdWJJbWpaTTRqMlEzdHcxREE0WTN2Smk5?=
 =?utf-8?B?L01JR3l6YkZQc1FjRm9YTDErV0QwUkJvREN4UTdkaDVTOVNkbFg0YTVEUEpw?=
 =?utf-8?B?Y3REL0hkdGttTm43OU5IWFZHTmgybmczUUZkSnJxZDk4U0oxVFhhNzFuMWZW?=
 =?utf-8?B?L2x3WVcya2hQb2k4Q2MvdlpEU0ZrRUFVRjQ0ZzFVZWVBZ0tpUEY1V1FLYThE?=
 =?utf-8?B?UVJ2eStreGM5QUw3S3FBeS9Jd0lGZjgvQ09RQWF6N3lON2djU3ZZenIxS2dl?=
 =?utf-8?B?NGlRNUVmUTZiRDJIa1hkM2lldDVaU0NJMGZYdmJ4ZXRkTldQYm1Sd2RIczdQ?=
 =?utf-8?B?L3JDUlhwbUdSVHl1SHR2Ni8wd0lieUE0eHplMWxYV1RrUGJURDA1VmRJNlJU?=
 =?utf-8?B?OEpFZWlhbjhkbWdKQk9LWUVsUytTTEpkVGtLNEF1Ykt4V2hQYTFKWTMrRTVo?=
 =?utf-8?B?Qyt5N25pam9taHFkbStsWjJKOU9ObHR3MXEvb1g5WTJoOVFBWHJ6eUszblN3?=
 =?utf-8?B?OXdUSkFydWQxenNncnlUa20zdEdFTTZQQzJzU2IxWHFxbVBWcEVsVkowYWky?=
 =?utf-8?B?YlluSklacUJmdUFkOGhLQWIzSkFFNHd6cS96anNUdUovbWlvWGRKcXB3c0s0?=
 =?utf-8?B?OWhwaEZuNCtGU1hUMVdUdjIyL3Nyc2RZSkV1SnNtTDZ6WU9wNlhMZlFGWjM1?=
 =?utf-8?B?ZnpoTUN2K0h3ajNvdDd4dms4V1hleDVIMCtlSFRWSnVSNGRhTFFjaFdRcCtP?=
 =?utf-8?B?aDdHSytaOVg5dU0wU1FpTHR1dWRiUFR4cHZVeGh2VFBoK1Y4SzhLVVZyTjVU?=
 =?utf-8?B?UEhWbGpMR0VtYmFhRm5sc1pseUY3cGVxb2YvR1h3cFdXM2dkMDExR0NMNVU4?=
 =?utf-8?B?TmJQWXVUVmdtK1FkaTVTMHM0U0VVaDR5ZTdramE4U3hIWXBySEFMWGRGZG1C?=
 =?utf-8?B?ODBmUzhDN2xKb25PdzN0TlVXcDVVN2tOaFZNZERUZ3F1U2M2Z0x5Sll3bHVP?=
 =?utf-8?B?dzdKdExCVG1oeDY2UDNDNkhDVkZiemZISlh0WXU4NWtXWGFXaDBaYldYVUM5?=
 =?utf-8?B?ZDlnT3BPNDJ1eDh6KzFKVEVmNWIvK2VyNDVpSXY1WWpVU3dhalhySlhybWht?=
 =?utf-8?B?aldjTVlwZEFONmNFUG11QzJoTmRJakRmdzk1NDVWaWpBMTlHZlRwOWw5R2M2?=
 =?utf-8?B?K0E0V25JRnp5TDBIdnZxd2FReGRzWmhmTHpMNCs2bzQ4dUw1QlFJak50K0Zq?=
 =?utf-8?B?M1NFUk9QclJPZU1LbmtPaVJrcTk3T2xpOWx5MWJmT0xiR2w3L3prdmVUL0Fu?=
 =?utf-8?B?a0EzV2N6K0xTcUJLMzBtTGZBN1NIMlZTaDBwN3JDNUxLNzJPQzIvWjNpcVBo?=
 =?utf-8?B?VFoxWFlSR2gxMm1EK1M5dDNpSGt0aTBySzhSb3UxZ1hLL1BERkxwR3RkRDND?=
 =?utf-8?B?b0NYbmUveFh3emdSWXd1MktjOGZWczRhMkNYK2xmY2JwNVpXL083M1Y0RGZ5?=
 =?utf-8?B?cWx2ZzVDRU9UempxK0tmSFRCYS80RWF1M1RWSzNCdmplVjFRdGhqVjlNd1li?=
 =?utf-8?B?RkFWWTJMcmlkUnFnQXJoQlJ2cnVLUURnWVJiNjJ3R1loN1FvVm14U08xTkxW?=
 =?utf-8?B?SVlzMUFSRWJoS094aUFyWVRBN2RnU3puc0g0ODl4YzlFQnBqREZjUVczME5P?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 543dd478-c878-4cba-dec0-08dd3edb577c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 14:03:14.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkLC06pt4vrjWzHVCwx3d3RYCD2M3peLakewsKgetTQDrVEYsb+sGnAO81iWQxaIuihwmzfR/9ncBpD4UK5Iow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7304
X-OriginatorOrg: intel.com

On 27/01/25 15:35, Josua Mayer wrote:
> This reverts commit 941a7abd4666912b84ab209396fdb54b0dae685d.
> 
> This commit uses presence of device-tree properties vmmc-supply and
> vqmmc-supply for deciding whether to enable a quirk affecting timing of
> clock and data.
> The intention was to address issues observed with eMMC and SD on AM62
> platforms.
> 
> This new quirk is however also enabled for AM64 breaking microSD access
> on the SolidRun HimmingBoard-T which is supported in-tree since v6.11,
> causing a regression. During boot microSD initialization now fails with
> the error below:
> 
> [    2.008520] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
> [    2.115348] mmc1: error -110 whilst initialising SD card
> 
> The heuristics for enabling the quirk are clearly not correct as they
> break at least one but potentially many existing boards.
> 
> Revert the change and restore original behaviour until a more
> appropriate method of selecting the quirk is derived.
> 
> Fixes: <941a7abd4666> ("mtd: spi-nor: core: replace dummy buswidth from addr to data")

Angle brackets < > should not be present, and the commit
description is incorrect.

> Closes: https://lore.kernel.org/linux-mmc/a70fc9fc-186f-4165-a652-3de50733763a@solid-run.com/
> Cc: stable@vger.kernel.org # 6.13

With a Fixes tag, better to leave out "# 6.13"

> Signed-off-by: Josua Mayer <josua@solid-run.com>

In the absence of an alternative, we have to revert, so:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_am654.c | 30 ------------------------------
>  1 file changed, 30 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index b73f673db92bbc042392995e715815e15ace6005..f75c31815ab00d17b5757063521f56ba5643babe 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -155,7 +155,6 @@ struct sdhci_am654_data {
>  	u32 tuning_loop;
>  
>  #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
> -#define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
>  };
>  
>  struct window {
> @@ -357,29 +356,6 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>  	sdhci_set_clock(host, clock);
>  }
>  
> -static int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> -{
> -	struct sdhci_host *host = mmc_priv(mmc);
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> -	int ret;
> -
> -	if ((sdhci_am654->quirks & SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) &&
> -	    ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> -		if (!IS_ERR(mmc->supply.vqmmc)) {
> -			ret = mmc_regulator_set_vqmmc(mmc, ios);
> -			if (ret < 0) {
> -				pr_err("%s: Switching to 1.8V signalling voltage failed,\n",
> -				       mmc_hostname(mmc));
> -				return -EIO;
> -			}
> -		}
> -		return 0;
> -	}
> -
> -	return sdhci_start_signal_voltage_switch(mmc, ios);
> -}
> -
>  static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
>  {
>  	writeb(val, host->ioaddr + reg);
> @@ -868,11 +844,6 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>  	if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
>  		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
>  
> -	/* Suppress v1p8 ena for eMMC and SD with vqmmc supply */
> -	if (!!of_parse_phandle(dev->of_node, "vmmc-supply", 0) ==
> -	    !!of_parse_phandle(dev->of_node, "vqmmc-supply", 0))
> -		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
> -
>  	sdhci_get_of_property(pdev);
>  
>  	return 0;
> @@ -969,7 +940,6 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>  		goto err_pltfm_free;
>  	}
>  
> -	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
>  	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>  
>  	pm_runtime_get_noresume(dev);
> 
> ---
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> change-id: 20250127-am654-mmc-regression-ed289f8967c2
> 
> Best regards,


