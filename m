Return-Path: <stable+bounces-158380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD2FAE638B
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 13:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA473B3E26
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCDC28D821;
	Tue, 24 Jun 2025 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FumPB/76"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B9827FB31;
	Tue, 24 Jun 2025 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750764603; cv=fail; b=FYpnElHWRBd/QKz0GmHtU0onS7XWA7JEviiOGAOTJm45XFTrVfMUWVJ4Rl7TJoTc9SVm+6tGlmb41NT8Ci0YVb5yYswZJ15z1XyI1JqsIabXftIbRZTY/zsov8fXZmUhEfInCkLQQCQ9AYZulxZsUbnyMelMRCjAXELienKZzWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750764603; c=relaxed/simple;
	bh=kN81sP5h2SxkoYXWopmUYJqDIsi315nY5ooFJONClHk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=apTGrKCIprcJ/pp3ryehsRyWvhih7mX+dGBjw8Ehn3715e8xVrlbyiNxgBzEF2uXWP3JxfTOeQs0beZt40UuDLeX4DBWKBb+Fu0RN80bGVKHySd322Sffa06smSh3SejCl5HLL5rUsGPm/KgpqMl7Uy2W+sV5qoKKWbwhV/9BGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FumPB/76; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750764602; x=1782300602;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kN81sP5h2SxkoYXWopmUYJqDIsi315nY5ooFJONClHk=;
  b=FumPB/76Ur6STs2h/AOEgtTk4bPdvoCUwjs/nnSnzClhFgGa38x1i3+a
   3Kc6QqjQTPfDqqU69t5lchNaoSM+r3JcXsb7LlNp7vyXeldoZGW31SjEY
   FQNTA+JashICPJKROI7MeWM4MWtYfdmJUNOOjycZXTjCfb5bUm1Jf9fFk
   BRFekboWxQ21/a4Daqed9RZxUesMCbPkGlhWFq3SDyqD10Cr0vBF6xTPM
   xLUxBQYIRVJZO00r0i1nnng/QOKCpF3yDm7kCD4DNUKJhALiXuWwTBsd6
   5Vwx641+D5uF98oLLY43NTbbyGkUbqkFMdXCtX3s1KUT1F26JXWWfMhYp
   A==;
X-CSE-ConnectionGUID: o+pOcnl3QdqpQg8ZMMJWZA==
X-CSE-MsgGUID: njdY0n2ATbSlVhJSmqx/aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="70421559"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="70421559"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:29:56 -0700
X-CSE-ConnectionGUID: CYao6hMhQbC7wYdLdEtQgA==
X-CSE-MsgGUID: A+iUv9TRRGCBGgoce8JcmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152415993"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:29:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 04:29:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 04:29:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.83)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 04:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFIeB7RvlJxo5CDSe7QP5t2pd/felCOgPQ5abtpcjIoyawX9r3VuE44+6Y+UK/300gLi0UeXdMTcV3H2h+s9GB9D0dXcvhzaqSr82pBLbr930tTZGWukqKD8gesLpDG7IuGX9e1v3N7Mp73MyAg8sSJFtsp09hCmchYyige9q2nA8/rp+NZ1+QSgCoqD87ATgthjFTeinO0FO+ebJyNjQp+9anSAcH4jfD0j5iY8nK5a2BZoF7dDaVw8CaEZdrfKwy1JFtAufSf3oYzVFCecj1rHJ9tUGlFx9xPiYKanK9XmJCEZQn3hEewKJ5n5CZjCQDp1LVJdXpRpejKseGfGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI3cqYmTEDtvppxl6UCzL0MbWSUMlk6O8vwvE4Nyv7E=;
 b=xrrwcy1Uxe4h0wmlIZuIo0U5vV5wu5wvdWiLa3QqBWhU0raolnUxeuIvM+p1OuGID5MDW7YRatV8YfvMNgLSD/WceJpeUkhE9g4aACSDFhHJbSUU2wvjYXSSK66eAvcYxWarapXRDjpIwST+ipEN+ziOcKhUnqSh/JlLoN9rgQiujj8pC9x17AAMGVCKrAeXpr0FDxy3a+ifJkzz3aE5ld3eJQGIRVYZf8L+aQaaO4wSE4+oPFZt6EKHFEtQW8etZKrjsyg+4EbfBXXvNTO5CM3h7svctt74r78v3ldBPR7FtpnS4tWzED0Md3cJtUdZBH5pbbwZKs5vzaZG/CthAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2708.namprd11.prod.outlook.com (2603:10b6:406:a9::11)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Tue, 24 Jun
 2025 11:29:52 +0000
Received: from BN7PR11MB2708.namprd11.prod.outlook.com
 ([fe80::6790:e12f:b391:837d]) by BN7PR11MB2708.namprd11.prod.outlook.com
 ([fe80::6790:e12f:b391:837d%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 11:29:52 +0000
Message-ID: <a0343926-1495-4766-a7d2-108d40fe9ea1@intel.com>
Date: Tue, 24 Jun 2025 14:29:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mmc: sdhci: Disable SD card clock before changing
 parameters"
To: Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Erick Shepherd <erick.shepherd@ni.com>,
	<stable@vger.kernel.org>, Jonathan Liu <net147@gmail.com>, "Salvatore
 Bonaccorso" <carnil@debian.org>
References: <20250624110932.176925-1-ulf.hansson@linaro.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250624110932.176925-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::25) To BN7PR11MB2708.namprd11.prod.outlook.com
 (2603:10b6:406:a9::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2708:EE_|DS7PR11MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 8442b7f1-12da-4e77-3bd1-08ddb3126f75
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkxOQlBzOXhYY3plRWhHVE9ZdXB6ejBlRFFkRlJGVDY1L2N4Z1ArY3FVMmJt?=
 =?utf-8?B?M2k3M2dlVmJRazFXakRsSW5iaG5RajEvUVdNNmFtYnYrQ255V3dhQ05Lbi9v?=
 =?utf-8?B?NFlCUDlUOSsvTzl1QlRsQ0MwdStpQkFpdmxKTXA0RmIxODF4OHdGdm9DZWd2?=
 =?utf-8?B?ejVPdHRPTmNIQkEwTmU3cUNpM2VjQktDdUxSVWNHV29SUDBRU2QxK0hGZmZ0?=
 =?utf-8?B?czdWQjcyeG95YXJhbWgrck9OT3JjQWpyY1M0TW53Vzl4Y05DQmQ5ODcwazlo?=
 =?utf-8?B?L3pJT2hPMHhsMkYwVHg4Ny96UFNROUlUaThXdGhaUzFmNk1BRWlDSXE0VnVD?=
 =?utf-8?B?ZnM3QkdoY0tGM3VnamZRcUVSVWdDUVZXYmRiTHI0THdHd0dHSk9ybkVaejFU?=
 =?utf-8?B?ekVIL0NZQm1sQWdabWRieFF0dDFsRUFmZVJXOHZIWWovTUZ5ZjZRN3FBOWhE?=
 =?utf-8?B?WnVJTTdwTUpsOS9MUnMzeW5FU0E2eHV0cTk5bDdSWXNaZDByVFpwUEtJQnRt?=
 =?utf-8?B?eUYvTGhqWDNpcXE3c0NCTHBzL1VZZlNuZjZEZ0dpM0d3U0VRK3Z5OGplR25l?=
 =?utf-8?B?ZUxkS21nM1BNcFFKZm03Z3Yvbk41M09uQnhSamU3V2NzTEpBcnNyWmIxZXJW?=
 =?utf-8?B?bGVEcndTcDBzUWpmUUowWnJBdHROUllzTXp1eTZhZGVFbEJzTk5IaHN4V0Fr?=
 =?utf-8?B?bjRYSjE3MUtML1g1Y2dUK080dkxZL3BGRWhLODM0c081SWkyVmtvLzA5WjBY?=
 =?utf-8?B?b0xIQlRIL2NZYmFBckRHSENBdXY2cjVyVW9KR094NEhmTFRVV3F4VURKWHJX?=
 =?utf-8?B?ZE9taXdVNkNtTW5STzBYNmRPQkIrUktRQ0VxUUl3SEVhZW9wbUhVOWxpbVQw?=
 =?utf-8?B?aHpoQU42NG1DeVdGd1BZdWNzSXJ5WEpDcmZMQlRaN1lKM1kwNkpDYlZ3bXRS?=
 =?utf-8?B?dUNwUS92dW00TG4xODEwVnYrdS84OGdralM1ZkllQklIQStPekYyZmlSVG91?=
 =?utf-8?B?Y0tBR1J6RVJmSEhFMjFIWGtuVEZnMkkzYmZNMUQ5d2lSTmVEeFUrMThWMHNv?=
 =?utf-8?B?U0NDSWk2dFEyYmlNTFhpZE9mdmMxdFQvUU00b090dVJ6bEtBOTQ1bFdoczJq?=
 =?utf-8?B?MjlTM1ZOZE9ZbEVrV0trOFB2Z0hseHZybnVpUzZVeWpJbGhxR3pwMWNhOGd0?=
 =?utf-8?B?UmRJdGFGdFpOdmlSTFJRWDNUZytlNkdHZlFhYVJDUzZGdEJtUmpiVFk0YURw?=
 =?utf-8?B?Z0Iybmx2RmkzdStwcm5sSHNOUGRSNGhuNCtldWN0TWxLSUxoYVhOU0JnSEp6?=
 =?utf-8?B?V1owelNCUlRuZnU4UGVRVWU1U1ZqK1lnVkNBa3VUTVJrQ3hPSExlTDRKWG44?=
 =?utf-8?B?RzZiVmNtZFM3YjBvUkRQbDhJTTdxU3d6dXMrY3ZLU0dqVHNZcEJ3eUNGeTZo?=
 =?utf-8?B?azlQRTcyS1Z5TUpudHlJbVJsazZyYiszaW4wSnFGZ1RseTIrOG93aElLQXMv?=
 =?utf-8?B?QTlNNTFFdTl4SlZvVDQ5QkFnWHVTSDN6a3FocHlOaktIdTlkNGFvQWRrS2xl?=
 =?utf-8?B?c0tRaEZqOFhkTGZlK2hWU2psWHE4QXIxQ25EdklQenVhSFVQRTkyU0w3WERq?=
 =?utf-8?B?emhqWUliQkw4THBuNzF5MWQ1M0xOc3VGZld0eHZQcEJ5NmRvVFVZUEJ5dllw?=
 =?utf-8?B?L29UUTV1RnVpRmpZaW10Wm5iNFVMZUNpOVlBSjNYdTU5eUZnLzFaN1FzUFFS?=
 =?utf-8?B?bG9CUVB5T0VmeGY0NjM0Yy9xeDczL3BMazg1a1VaV2RWdzRhY0trMzNiaU5F?=
 =?utf-8?Q?NWaEyRCH9+ueGBDxEddpbqNdAC4uDgmCkUe74=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2708.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHRjRGpYWmdURHhMeXV4OTBRWmFHUkFYbGozS1NhbGx1RE5MZzBkenl5WXBy?=
 =?utf-8?B?bm92cm0xY01IbkYwTjlnVFpNN3lWNTBOVmkwb3VqdEdmR1o0MlpYMHNFSXJw?=
 =?utf-8?B?MEY2SVpWb05DQjNLREZUY0gveDFEMEdBRmFSR3NCWmh6ejdmbmFsdmtIVG56?=
 =?utf-8?B?MkxLWTJmdmY1Y2tmRUFLVlJ0NzB2NWJidWZpaUo1SnBMRU1IRVJ2V1FXVWdq?=
 =?utf-8?B?YW5DYXVFN25yZ2xQOTZmVE9SOTRoNXQ2eVhVbmxpVndVMUZPRzRsSmV3cDBQ?=
 =?utf-8?B?OTZBNzE1NHBVMEhpWFdMY0pGRWJjbEljSURGSjVZeHc2ZnRpam45N29GL1dy?=
 =?utf-8?B?U2N0bUgzaFZ0eWtGeEdhYTJqUnZabWdYVjNDektraW5DNlhyYkdTMHJ4MGNq?=
 =?utf-8?B?NTBUcnd2SkVKc0VlWHI3Y3BHYVVhaFlWYXdSTUdLc0F6NG1uUXcxTkR4d296?=
 =?utf-8?B?dk1EYm9lK2FhWnZYSVV2S0FvaFVnSGgzdGFyM2JSQTNRdEFpQzFpTDNwRjhM?=
 =?utf-8?B?VHdYMkQ1Nlgrc1FwZHZxa254UGxLVjAyWTAyMXNSMFM5N3NWUEVoT1IvQU1a?=
 =?utf-8?B?a3duVGhjOXBUUHBTQWRSaEt6Uk1CcWZxQzZzdzlRZDFYdFpUUnBVYjNOeEhr?=
 =?utf-8?B?eSs2cnRjdmlRdTY3TnRtWmp4c2ExeTRmejdEUmFMTDA5WThjK3JINktXT1pS?=
 =?utf-8?B?UFJFNGEvbzFuNkVoSFVOVStwbjNVd1ZYNUtGZ2I2WVE5dVl6eEMrK2ZONHdm?=
 =?utf-8?B?ZHBaaFhITWs4R0twNFQ5SDRMZWZhdEcweC9XdWRRWU1NSjNQWEN5Rm81ZkNk?=
 =?utf-8?B?V3lzS1dxbHhBdkhxWEo2S3lMQ2RxYzBzTC9IRGREMkpVajI0U1FMY1VSZXVZ?=
 =?utf-8?B?eEJtU0wyL1lwcG02WC9yRm05MEl2MDZkZ2VMbzFnbElMdXdLTUx5WTFtZm5X?=
 =?utf-8?B?Wnd0RDJ2YldYbWVjNW0wandnTllEY3lnTjNOdXR1K3BZODIrTmxldFNKa3hv?=
 =?utf-8?B?bHFxT3lzQVhEMGxhZDhnRE5ib0xhaHdocnYrUFM0V3VHd3MrUUVoT3k2Z3o4?=
 =?utf-8?B?RzF6YnRZT1NXUDNKaFhRTHQxSFhCb2M4WTdHcnBWNjBzYlFDYUV2TDFuOUd4?=
 =?utf-8?B?L1dJWlB4dEdWb3FJc0ozd1cyYmFmbDdWZWhpbVg4SklFUUZKQ0loUHUwUjMr?=
 =?utf-8?B?c1djK3lvS0dtREU3ZmtaVjQra0VCM2V5bXBZR2w1Ti90NjRqMEgwZ0RpcTZx?=
 =?utf-8?B?VUVDcm90QTV0VE13L3JZZGNtUTN4eVpMRmF4MCttOVExRXpJK1ZkTHl1L2hz?=
 =?utf-8?B?VmFTclk4bHFJdTZqbEpiVEZhYmJST2lKTHQvelRNclVvdE4zK1kyWkVpQUFM?=
 =?utf-8?B?TkxsTi8rTitPR1RoM0xKWS9CY3JjRXdIbGVzY0t0UjlmRzdrVjBRak1PK3BU?=
 =?utf-8?B?TGE4VlNGNmVRbW1zM3pSeEF0WTRJdW1VS01DVGFBbDBBU1BRb2ZYajJubXp2?=
 =?utf-8?B?ZXlpREQ2cllNemtQeFZrMnFYVGVRbU5jc3FjbGwxRmNZcml1Zm1GRzVkNWNT?=
 =?utf-8?B?SjJDM0xNd25JOXJZc3k3NTdTQW44L1Fxa3h1VzI0cXJCZjZnRjdsOUZ5NnQv?=
 =?utf-8?B?TjU2UTNvSlB6eXRIa2daV29WSnpMMjVvZloyV2pVN3VyT2E1czNGblJGMWlk?=
 =?utf-8?B?b0hrT1Y0Z1pTWkxFUThvWDd0dmdxeUlILzAvRXJnUW0rVHh6R1JISG5JbkRR?=
 =?utf-8?B?aEtoanVFZUtNOHpXcHM4U3JTSjJGY0UrblpiNlBJeDU0OVkxV0gwMUNQd3NR?=
 =?utf-8?B?V3NsS1NnYXNuY2VNSUtONG9KWU5pbnl1VTYrODFKdzZDZGJFZTFkU2paUk1k?=
 =?utf-8?B?M0RzTWFyZ2JrSkZLUWZrczllbWtQNE5GcDlVY3A0ZXRHYWhLNFN6WnRYNTNx?=
 =?utf-8?B?Wk9VVlpkb1dyWDh6K24wRzdBRElBSlR0aTJ3WStLZjZVaWxjb2VvMlhZdDls?=
 =?utf-8?B?SkkxS3Rvdy9KUktibUpCL2tML3F1TnMzbEZKUXg3c0ZVWEQ0ditBS2c0T0g5?=
 =?utf-8?B?M2tIblNrRTk3d2RKTWVGOGhzQi9USlA1Z0lkZi8yZjhTajBvVmdMV1NPVVFF?=
 =?utf-8?B?bVNQNTFrb1k5dWpZY0E5Tk0zUm1LVnJlUHhOUFhmZ2xTMEhlYk1MRm9KLzhD?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8442b7f1-12da-4e77-3bd1-08ddb3126f75
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2708.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 11:29:52.0665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dm1mU+jRh6O5fX9YVCiETPAUlQ+V3gESnvbxomwxwsN9Iyp7tcWi8R3Ult3TYK7yN06lTeVpOQ+bfmkNNeAJmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-OriginatorOrg: intel.com

On 24/06/2025 14:09, Ulf Hansson wrote:
> It has turned out the trying to strictly conform to the SDHCI specification
> is causing problems. Let's revert and start over.
> 
> This reverts commit fb3bbc46c94f261b6156ee863c1b06c84cf157dc.
> 
> Cc: Erick Shepherd <erick.shepherd@ni.com>
> Cc: stable@vger.kernel.org
> Fixes: fb3bbc46c94f ("mmc: sdhci: Disable SD card clock before changing parameters")
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Reported-by: Jonathan Liu <net147@gmail.com>
> Reported-by: Salvatore Bonaccorso <carnil@debian.org>
> Closes: https://bugs.debian.org/1108065
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4c6c2cc93c41..3a17821efa5c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2065,15 +2065,10 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  	host->mmc->actual_clock = 0;
>  
> -	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -	if (clk & SDHCI_CLOCK_CARD_EN)
> -		sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN,
> -			SDHCI_CLOCK_CONTROL);
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>  
> -	if (clock == 0) {
> -		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +	if (clock == 0)
>  		return;
> -	}
>  
>  	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
>  	sdhci_enable_clk(host, clk);


