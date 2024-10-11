Return-Path: <stable+bounces-83454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE299A548
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 15:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB491F23A33
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BB8218D79;
	Fri, 11 Oct 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TksW4L4R"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54421804
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654196; cv=fail; b=uM3BQ08xlRdJto/WeIqkEn9yVoQhM73TzWKs+L0mOAmo95BBFJxrM1iB9cUYm5qvzyADcBLbFAJddkuCxxI+tffea21Y7z2z01eQbVd7k0lg317QJ3O8cuf2M7r1du1PVp247ia5AkZlnBJchB5+pi8nCdUWXtf3kVY07msrxU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654196; c=relaxed/simple;
	bh=UhwUQKV8xybGmyL74edceE0gPBX+YfRWhfz6CYBqE5w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jAh8ShbSOKFx7d64V1ggPocGOSHikjBbbJashvM3egfGszCVsG2zJ30E7yENzTiGkxYfkxKvM2L1phvpJ0E5tO/Lirr9VagMn5c2KwdO4L0L/QVQEWDq8ujEzQarFRwRfg8KCg2VAl894+NYtNBDWi+kFUl+t7ozDrXWSPbpkRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TksW4L4R; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728654194; x=1760190194;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UhwUQKV8xybGmyL74edceE0gPBX+YfRWhfz6CYBqE5w=;
  b=TksW4L4RVtpA4lQ2i3foB0r2CXiinHFm1shi1vz1ngrrXkHxyKs2QflK
   WyGDbMfi0PMhPk+m+ysFZJjoWvz9zCaqDXJ1/KIIAF7M4i7BeejiQYiGq
   Y/1n7Oj7kdNOwgEX30aHPZeLaO2JPj1it6sMxGpeprmTzFHLhYOCZjLVW
   lgU9r+/Xdvys2LnWgZBlFL4nBUwOHv9etQ5Ay38Pf7LNnrJhSCWToR5as
   O5lWlMdPpx5SwOlojX2BL08IAMgaDAOiZRcyfxYKyLQojdlkh/DbOHI3H
   idBLmDoNYOHf3pyQJrn/IrdPRgOHhgRUjsDit8A24KeX3C4A3fXIaltxn
   g==;
X-CSE-ConnectionGUID: 4YA2Y8qNTIS9KI/FdQu06A==
X-CSE-MsgGUID: U+FLVDsxRcG0nvlpUwxa6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="53458844"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="53458844"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 06:43:13 -0700
X-CSE-ConnectionGUID: KlqMX4cCSayRWdYKr1Ck7Q==
X-CSE-MsgGUID: N13BXD7jQAmMoqoAAPUltw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="81703586"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 06:43:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 06:43:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 06:43:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 06:43:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9USoiW3b4I8CB4mp4TtbyILR0qV7pVZuvmCOFcXMReshjPCLXvVLW1SBZbG6/qW39x+9cmpIL2AiwZtI4UCIGIgjyQ49TbnKdqPCc8FVdW5j6NA/oMHfN70v8IehRwkkX+HSr0XGjmRwLQQD1iJSlJK1oC1BmG+4vNZkXQvnlq8czWbZmERWaXBqBpqE75T9CJ3uXJbLdVptWiePIxE7JrkleL6ZrGQL/8Df1Qzc/6WvxEKp23tgHxVtWQN8JOrZRW546bRjb0M8cwYV/uuPcOSqRsusCWQluR33yCMR+MzGpUlMTl6vPmvES4H1cMr9bRZdzM8F2phgwrRfjsG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pC3K/38G5tY/7Xy7Xj5NIONTy6/S64Wtyv0sF6IJsaM=;
 b=afP7FOQVZPK1dabaeQMGdrbE5VBeja5hH71Mw86W8mZ0dNZpcfRyZ3JrwY/6ofHsrVZ+FXA/z+b/QWxNFLU8qXsCQkznLWBVr67mISCidPQ/HQ1J0OXkc9FfSYrY6WNpYR6GlHgqqJKEDJ8um6d2xtC01VwjAS5nkY8gvBFApofF9HFcG3jvfWx77ZOh6aKCZIPLuoDRNXDOeR/E3Gsb+EXAMLLGZw7s656MJjUcYW02pRVwdU5YQ0SYU4FMarwnW6wW3iXNLR/DG/qFlAVAXKIM6YugNc8LIYnTijjnnumP6n+FFnUiFWar3KWqIhlBY3e2MDq9Y/IPkjIbs7Icuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) by
 IA0PR11MB7188.namprd11.prod.outlook.com (2603:10b6:208:440::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 13:43:10 +0000
Received: from DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347]) by DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 13:43:10 +0000
Message-ID: <b043c0ae-3778-4fa5-bb63-b8d9c9b4fbf6@intel.com>
Date: Fri, 11 Oct 2024 15:43:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/xe_sync: initialise ufence.signalled
To: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>
CC: Mika Kuoppala <mika.kuoppala@linux.intel.com>, Matthew Brost
	<matthew.brost@intel.com>, <stable@vger.kernel.org>
References: <20241011133633.388008-2-matthew.auld@intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@intel.com>
In-Reply-To: <20241011133633.388008-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To DS0PR11MB6541.namprd11.prod.outlook.com
 (2603:10b6:8:d3::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6541:EE_|IA0PR11MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 3feedc23-5ffc-4866-98d4-08dce9faa527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1ZSUlR3Q1ptM2ZsR2hFMHZLS0kxc3lpTG02SW1ibWdlQWpMcy9RQnB5UzQy?=
 =?utf-8?B?ZnA5ZGI2eFhMOWpqVDQ4VmxUcjZmTDdQWnBKU3V5dGdyNkJud1dGQnoyeGRW?=
 =?utf-8?B?dmVoelRxL3FLdjJtVC8wdUZ2VnhoaXVScjhNTThJSnhKSjhCKy9Hb09DUDRz?=
 =?utf-8?B?ek9NWHhSczQxeDBibHpGaUpRY2FMU0tONmo2NDFVaFE5c0t2QXpXRm1QeXdJ?=
 =?utf-8?B?WTQwOEZzVVI2d2NPNWxQeThXU3lMdnpnWHd0WVhJVmc2VVV1UmtjS1R3c3Av?=
 =?utf-8?B?R0pkajE3UnlvTjZ4cStpalJlcFYxUFFsa21TTGQycHkrSG5VbloyR0R0Q1Fx?=
 =?utf-8?B?Z0NRc3JIeDh1dU1UcjEybnpNd2F5dUFoekdjMm1NUklzWUd0TGQ2cE54OUxz?=
 =?utf-8?B?Mi96SVJ4Z1FOQ0dxa3h1RWhNMVRDTG04N2F6eHVhK1AxWlNuMGpqbGlGMDFL?=
 =?utf-8?B?OFRlV2ZmdmlzV00xNllJYW9Cak82aUhwRUhEaktTclpsUXd6d3IxV2Q0a2Fx?=
 =?utf-8?B?OVc4Y3oxTlJRNWlwSi9sOURuaHJNamY5c1VISEVxQXcrcjRmazFyUVdCTUt2?=
 =?utf-8?B?SUx4NDd6cUZlNUxENWVwUGM3MVU1em41dzFRTGhJai9zV0pGdis2a281RHRR?=
 =?utf-8?B?UmxqOXJEcUkwZGRORk1ETDlGMUFleEdrWXJPemJ4MFU5d1dBbWdtd2FYekdu?=
 =?utf-8?B?L2ZKRnI5cDJ1TDdVeVZGSmVZS1RhL1pHcnRqbFlWeW8zYjFiSm9NZEN3bHNj?=
 =?utf-8?B?QWJ2OGlHcWpzanFNY1haKzMrTEZzbHRaeHhOSWxzU0dSb2J4Sk1nL1lxNDdW?=
 =?utf-8?B?dTQ1K3IxRE5XRDRNOWQxdE8vdmpGajBlTlcxc0xmTHZpZ1lMd0JSUmlTb1Rx?=
 =?utf-8?B?MWdwam9QYWV3THdLaVlrN1ZtWVBEdFRNcW00cFRibGx2T2ExR1h3ejAvYzYy?=
 =?utf-8?B?bzdqWkw1NU9KMVl0cnowa2dodDA4SGFRa2VROU5WQ3pLVlhRcTN0U3BjNVYy?=
 =?utf-8?B?T3Rlbk9hWGNFVDE4QzI1bFk5dTRjTktsc0p3WjY1OC9HbjVqQUNtOEY2bXhu?=
 =?utf-8?B?TWdGWUwzRlZuZHlQS0JNQnBIaGt4UTI1dnhwWG1aaWYyUEZVdFh6RCtLNjVv?=
 =?utf-8?B?a2UzdmpRbFhMK1MwMVJTZXhnZC9iOVlQS1hpeVFIc0VrVFZ1Y2x3U3VQVkd3?=
 =?utf-8?B?cE5RY3hPenVnWWtBUm03ZU9tdG5STi9uTlVQdGdoYnp3NWNlUmxwK1o3eld0?=
 =?utf-8?B?OEJuR3ZVUExkU1QvRlBMQk5DbnB4eDRuM3NmdThvdFFSZ0NSd21ONEEyeTFu?=
 =?utf-8?B?aXhCMHphTzlkdFJjS1NMdUVhenhqRTUraitIcmkwUTM4SkZCN2xldENTWjNo?=
 =?utf-8?B?aUVZVkhzeGh5SnFaaTM3Z0dGbzFZSVI0amxwem5iME80QTBFK20vL3U5NUNI?=
 =?utf-8?B?b3lZbnpUR0NYWnQyekNBVXlUK2w3SHQ2STc0N202Sm1BQVNxS3RWcjhjNVdP?=
 =?utf-8?B?NFZSSE0zM2NtM0RPZWEvWm9QZFNQbzJtTjVMRXRUM2dKYW56bDhWcHhZR1Bw?=
 =?utf-8?B?YlNwc1gwUjZyWFY3OUhQSWlITFQ5c1dpdkpIdnd3eEg2ejlPVlNMcGI1V2E4?=
 =?utf-8?B?YlZidGJiWjBxSGw5NVprNWJsb250RlUrZGJjSjdTZTBxMFg5SzZTVlUzeEMy?=
 =?utf-8?B?UXlVNHJsdDhCelV6NGlxSWdVd0x2RmsxQ2tiTFpKWW1xQlZQSmNrZXJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6541.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3JDMU5UNHdUOEpydkhGV1RLY0VTdHBXTCtPMERoYUd4NmJMODVPRUpvSkZ3?=
 =?utf-8?B?djhTUkt4cXd3eTYzYS9ncXEvV0tCemp1b0Fkb09lUE4zSW9WcWJWNGp6aG5F?=
 =?utf-8?B?VGdDcjg1OXdYekltUnlLdlVoRUZWRUVpV2FFMEVON2poaGdNK1RBTkd3c2N4?=
 =?utf-8?B?QVBMU0swTkhNdTQ5RzlvZmtlV1JWdExXVVI2SUgxVkhvZDFvUnROTW1YMnBW?=
 =?utf-8?B?REtMNTlvVTFEdnQxK0lCQTBUdElza1dKTVR0U2c2R3VpL1JjYnpSbEhPMTRI?=
 =?utf-8?B?K3Z4YW1wMG9ZaTh5TWtlMnZYNU0zOTRBV0ZEOU0yWGR5azZnQW45ZldVcEp1?=
 =?utf-8?B?Z2had2dQd3lJaFNiYWQxUFNnQnpuREtiTWIvVENURzdWYWhmOU11N2pnNi9x?=
 =?utf-8?B?SVFMd0lUeGlmRWk1eDM2L2xvbDFTU2toeDRGR1dKa0RwYndwMmRLNmNJdWJM?=
 =?utf-8?B?NkpEZmR0RWs2cDFzOCtjQnllQTFGVDNJQVN5b1ZhVWFQMzV4eFdsNWR6VTlt?=
 =?utf-8?B?UDd2SXhRWGFuK3hpZFcyeEZjN0NVSXltQU91cURNVll3WW5ZQ25uSW9BVGgz?=
 =?utf-8?B?TXdPTS9TM2labFlwckRoSENpdkxjVzFGY2ljeXp0TEhJZEE4Ulh0bkxOV2lF?=
 =?utf-8?B?Um5jS2QwNEFGTVFpT0dvYWdQeHR5WE9yQ3VpSnlhdVdIRGFJTmhid1BLSjJa?=
 =?utf-8?B?S0wyNGJETXZSeW5BZkdJNzNZWDQvRHZJQmR4Z2ZXVTJyV0FEUlpidTZTUE85?=
 =?utf-8?B?aDBPaFRKSDlva08yTlZ1Q3dZbktZUURHaENBYnZFeWgxUElySXU5akt6YTJD?=
 =?utf-8?B?RVQ1SUs1b2VmZjFtdHhQTnBHRmhDNlQ0UGFNMkdWdlN1K0R4VnpWQWpXVzZD?=
 =?utf-8?B?N2xBUDB0WlQzUml2bGFrRjM4QnFPcVNsZzkrWGs4bE4yY2tEb1JmVU0rdTJK?=
 =?utf-8?B?Q0VmVWdPbE5oeS9JUWovTnE3SHRxOHBSZXZyT1lyKzNVMzRmYytnOHEvTHE0?=
 =?utf-8?B?SGRCMW5WeCsrcDU0UlVMZEtZQUtKQURtUXBvcllqSzBqaWY2OWFJeitBODln?=
 =?utf-8?B?RzZkU3B6VFN6R0FFaGFVV2FublI2SXI4cFluTUs1NS9HamFxczJOS1FhcjBJ?=
 =?utf-8?B?T0VETmxZSEVpTHpMa2duemJWcmsvYnJVdTI1Rkc5VTVMUlVWNmpDaFF1aE1F?=
 =?utf-8?B?YnoyV3U5dEdpV29jeEJNcXVoQzdCWmJuMFpBWTVXbTdFZlMyR01sUTE5b1l0?=
 =?utf-8?B?ZDVCMmo1elRiakg0ODNQdTJKODQ3dHJzVGZ6OVZMa0VGanQxRmduMU1hWXFk?=
 =?utf-8?B?bGMrTTE0MUdjOWpMNkV6R0xzT2xVSU4vc2xvaFc5R2pKTDVFLy9tdVpLOEdy?=
 =?utf-8?B?YVZJWTkvdzRaVUN4N1JJWFVhTEtBb0RvTWlDMHQ5RkI5ZUxDUldxemJBaVlN?=
 =?utf-8?B?SitTcW5MMU9odzhFMHZabWxJRzBNMzU4Z3VqaW50L0pxNnJFZEI2UVp5SldE?=
 =?utf-8?B?YkZyc3JHUERsdDFtNnU3cnFpamRiU3RYdXlRWTFLSjl3UzlFbFVQR0NGN05D?=
 =?utf-8?B?U2xnV2Q0SEpXUjNEYUFrUzZEYUYwYXhFOGJGK01uOGZXR1NzT2ZBMTJZTnRz?=
 =?utf-8?B?SldwaUh0UyttSmJRRzZXVzhDSlVwTjNBaEhWRHRhU2VMMUZTQWNTOVZhQ3pN?=
 =?utf-8?B?VldQRHVrQTNQUzVFTzRFYmozS3dZMitLVWVjQUVUNXVBZTRMV3FhZUVEWFBO?=
 =?utf-8?B?elJqMFUrU0JuTUl1VlAxVkRoeTZZRnVSK2o3RW1zQVJzTXhBTlFsQ0VwOEg3?=
 =?utf-8?B?SmJ5aWFibEhQWkJRUll0R0RJNFNPdUNiZVAyUmcwU3lGSFRVcTZrRnFSZ2Nt?=
 =?utf-8?B?QTFXWEcxSWxhT2ZhMVZnbzAvVHBRSTRqVVZuWkVFSVlxMk5UaTVBYW9uQUdy?=
 =?utf-8?B?dm93TGNQRktEK1BKSkhVWGV4OU1MWlRRU2xFYTE3QU5mZUFZcE5UUHBUbEVH?=
 =?utf-8?B?c0t2eUhwZFA2UkhuR3lvclJPdnh6TFlpYjdQSnBlcjhVQ3VhdEduci9Ob1RX?=
 =?utf-8?B?Y1RZMnJBZmliaUF5M0R0L2VJZXQxZ1ovb3AwSlZKdi9pYUpGRUJKVlRjTzRz?=
 =?utf-8?Q?qyCgBXx2bQ9H6cOpHJbei724p?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3feedc23-5ffc-4866-98d4-08dce9faa527
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6541.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 13:43:10.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mREqs8qVOOlafy6Fhfb0ruV12XG7H+itqo1af6AUF4Kfj+0py3mW8fhnZnDaj5HfMKzOehvfkaHtyZqfBPsrsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7188
X-OriginatorOrg: intel.com


On 10/11/2024 3:36 PM, Matthew Auld wrote:
> We can incorrectly think that the fence has signalled, if we get a
> non-zero value here from the kmalloc, which is quite plausible. Just use
> kzalloc to prevent stuff like this.
>
> Fixes: 977e5b82e090 ("drm/xe: Expose user fence from xe_sync_entry")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
> Cc: <stable@vger.kernel.org> # v6.10+
> ---
>  drivers/gpu/drm/xe/xe_sync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
> index bb3c2a830362..c6cf227ead40 100644
> --- a/drivers/gpu/drm/xe/xe_sync.c
> +++ b/drivers/gpu/drm/xe/xe_sync.c
> @@ -58,7 +58,7 @@ static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
>  	if (!access_ok(ptr, sizeof(*ptr)))
>  		return ERR_PTR(-EFAULT);
>  
> -	ufence = kmalloc(sizeof(*ufence), GFP_KERNEL);
> +	ufence = kzalloc(sizeof(*ufence), GFP_KERNEL);
>  	if (!ufence)
>  		return ERR_PTR(-ENOMEM);
>  

