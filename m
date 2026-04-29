Return-Path: <stable+bounces-241833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOvwDpez8WmwjgEAu9opvQ
	(envelope-from <stable+bounces-241833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:30:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B45C84907A8
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8AD63067772
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71F135AC1E;
	Wed, 29 Apr 2026 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ME8H2e20"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B140DFA4;
	Wed, 29 Apr 2026 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447618; cv=fail; b=ZvTvC1V7Zj6VuI0RPpGO9lrjSu2aH/KGJ26CJAiBiFzyNdoNaD2R+RVUBZfs2ZBDOOR01o3n8ULl27X+PAfwcQEl+BoWWN4OiUPJjTImS1XbNLtNQiLrkQiDy/mLRwQiehdosntbcpM3XOkn0JXHi3ZgfhBkLVY0o9F7zLKPpO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447618; c=relaxed/simple;
	bh=bkN1Oud2qFS4IfrzgnzPoty3t6H4jXHuJ9Ujtttuax4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QwW61N7PaCAxbadVOS1VXeBtm8s6BVHqMwtheCPOa6LcXbnU8+/Egy9j/KoXPfkAVjlGAvHDq3X4djJZYTy/4I8rdZ9MIrQ29eW4w3hTXSVps6xdXpC1E9+zYLICT3eOY/rkMSI1XjMF8lUjJr/u1zOJyYUf8TW74j2FE1tiJDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ME8H2e20; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777447617; x=1808983617;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bkN1Oud2qFS4IfrzgnzPoty3t6H4jXHuJ9Ujtttuax4=;
  b=ME8H2e20xtKSUNB7M2Y0q7O/pMtRoyAmrEoykAPE3Su2zHfz7jiV0ovt
   RpJFQQOnLyv4/w7H31U9oqO6yghbZ2yMPctJDMHkPk5CV4Svkgy640/QX
   HvRcEFUF/BKf9w0wL7QgAut6OI1aqh4V98h7Sp9swW8Il1OPwztAhKVPT
   HSoR9m5vWvqw6h/DexZfVk/lhjuRUSE7/aI6E2oUid/dNRx6c1nrOUcGi
   iwEDMZDRLdpGsHUofFDKx0D1RpN3p9pGSFm1Yl9cRNeZjSg0Qb4QYHIm2
   a/rdxZxBRatA0R5vfX9fT7bi6CQaBmIzDczNqcDt6huae4c+FVFLBkYCo
   g==;
X-CSE-ConnectionGUID: DBOHxTZfQVqO6Ldr1vhYqw==
X-CSE-MsgGUID: UTB9AA1dQsy7e76NM5Gl3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="95789401"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="95789401"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:26:57 -0700
X-CSE-ConnectionGUID: KyyqmZNwQnSo1RBIkmDtqQ==
X-CSE-MsgGUID: 2uv+mcuPSIKgCbb6mfk3cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="233164474"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:26:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 00:26:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 00:26:56 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 00:26:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1YjdEj6FQor3+Ed4n8jelC+42WmMMS3vii3HN4f5NWjICmdZyN3zjkmjUQZQoS2T42hArkT0+zbjPVPVGr9J995MbIerZ9erbQhz+7MkdDOeQCy4TcHz38fFvrxJ3L0V0R+DS/L46JilEN5SC4ZnCuCr9+805tNvVNAUv/qQhQ9Q6HNgvZEh93QQ3YwTIoepSdjqlQ+/T0+OLjGDeEnHyXHS8eQs25wNL22xy/29GUp1RMgiTJOwC+HWsv6FgM4Bp+8pvM0PsRhnf4+hlRwsJ8g34hghJtvhcL0G6lgasqjzWTAQ9ejy2xASVDD0BS2VrHvDTltYYa1nbgMnXrHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEtBkst+DZWqOXnpvWfm7wJhUg+bf5S/HsJV2opyG48=;
 b=nfeRiH8T3R3wM++Svvw22aem0DWJ30fI5xoeOe+U/048yXJJ5JABhhFvJGfoX38FNYkSu12glrkamvo+1GW+0a3YLYPQjDmqoS2NGdKiojeLsK+F8qSyKGGeZ7uAzPtGuKKLPj7hle+I+1aaT7pC33kIiNvSydM1VBdyhOJ+7rMYu38LZPivCHkOwiTG8772mGZ3Df/CfJq/EJTiVjS72RKMiAEm94TdxJWaTGdZOUCMNJ8cm1Qd9E+cVekuPL511Kwl3V4hblipeM0qr/M068k6mQDc2h3WGkdkl4EGSp86EBmIK1z0MML51wg0/jbCombzhYqk+BkLu83gtI+Rtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 IA3PR11MB9184.namprd11.prod.outlook.com (2603:10b6:208:570::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.18; Wed, 29 Apr 2026 07:26:54 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 07:26:54 +0000
Message-ID: <7c2681ee-a53c-402c-8947-e7a74f8720c8@intel.com>
Date: Wed, 29 Apr 2026 00:26:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "x86/fpu: Refine and simplify the magic number
 check during signal return"
To: Andrei Vagin <avagin@google.com>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <criu@lists.linux.dev>, <x86@kernel.org>,
	<stable@vger.kernel.org>
References: <20260429000623.3356606-1-avagin@google.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260429000623.3356606-1-avagin@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0167.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::22) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|IA3PR11MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: 191f7a90-6776-4379-7576-08dea5c0b021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UnkKcVijGo8EZiFeW771QwJtr7k/uq2uwnRLkmQ8nQSw9t/Zh/bqn0qM39HrKsThMQtB90/ycDcePncy7zZt6YwkGmK8YVVWno7GEmlDD7UO5wNz086yB+rQ01MG999TQu55idVkOsF6ET9hrgNIzt2e+oygj4+qFPN2B8UvzrXi19UF8SZ+SEJQOnLsh19IGkUm36W0zEczjXVFiHoVMhyHRyZk2Y8vPM85AStAXjKd69Kj3hhBYcVPdA0xBz7NtqFMtWr3NqW4qU80eSL7Fr7ZGtujFdvxDayugYn83MPidwEROL6dktNgrhbnOxPcDZsQojDPNC2EaAtcLFRD8h5MG9ga5nByMxjw7NygXHIX660fj95RbDavyNQWqZfsckoOsHgDswpjpV3uqhGlhLAvpPuB/gMO0BJnbEgWbeeNU5nOr2alGa78mcOJYDBGYFrXPOvb86Q6NiVyIhTOX6K2wxzgRprU5hskKLkI4BEJjEzpIKWAa16MWkfweGr+Gb6zCuW6hHgN6COG72exAUvzgd8rX+72LSrndURq+lxPbLMLB/IlwgdRIR4Zr9nnMaR5HmS5l3yu9aA1p82IYGpK3Rvoe4gQb18+5D3dpIauYofhmfoGxrmhVTTsTgZlkwI1I/LCKUivSiuLHfmw5ybOcu7/+7/bTK/C8dHhrII5+NB/ck6IVAvgYNGO8/D6NdcQFXOUmEcchc+89Mpj0fe+i0AZ78bhb0m+BM4kRc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlNMR0JLK0poQWxVWGFFQWV0bXd5SGdxREZBY1YyQjhyeTZxV01TUmRqNzl6?=
 =?utf-8?B?b3BQREJXNjJ4V0drakU0ZUwwTFErajdrc3pZT2xaeHNwT2phOWlSdzRVc2lG?=
 =?utf-8?B?VVp5RW9MazVKSHJnbDlxUFMzY2N3eTV1WGZTenJ0WW10MWtzVDFtTi9zdUdM?=
 =?utf-8?B?L05HTVJ6dm5UMXljR29sK1hDT1Z1QmdaaVl0Y242QVl2QXBUZHJPWU5FcDhr?=
 =?utf-8?B?RTFhUHN4K1hpa3ZoaWdjWkdXcUxwRkM4L2hHNHI1akxTcUU3ZE5RWjhHbUly?=
 =?utf-8?B?K3JVMWxCSDRxb3VDdG1LSUdpbFpQenpDNTI2eGZRaXUyRjV2SjBNMmFkeGxQ?=
 =?utf-8?B?K2VsMGg0MGlxbkRlSVZQSEpHRzUzemphNllURVBEUkFGaG51V2VtMklkTkto?=
 =?utf-8?B?Q0xadUNBRU82anBidEYzYVcwWFduMWQxeGxWOHNPMjFNTzc3YlZmakxRSUk5?=
 =?utf-8?B?MzJpSW9kZnVmSXcwWHZhWG9GLzlJd1oydTROZGlRZ2NGSThlNzRmZXIvSk9F?=
 =?utf-8?B?aElBZXA4amlMYzJ0Z08yR0dlTThSL01EdWR6RzgyWHRKNWpMbXdGalZsWDd6?=
 =?utf-8?B?QjN4KzlmWk5iLzZ2ZDllMHpYWS9GYXhzRVBQdm9HRlpTK0RmcGt6NFdZTitq?=
 =?utf-8?B?M0RGSGpCVHN3dnJsRVRLVURMeGNZYi9hU0RZT1UvQ2prVnk2VytkMHVVVkky?=
 =?utf-8?B?c2x5VUdITXEyTmlhc3JZN0Q3SVNCclZzdVMrYllqTTNReEJVL0hPSi9VQlVj?=
 =?utf-8?B?M09VVEJSRkZzUGlEYVZxLzJUSlh4S2ppcUh2OXZWTnJlMzB0aStCUWQ4RDEy?=
 =?utf-8?B?VzRjQnd3V1VjVmoxdzBvMzFyblBCZDl0UHVwQnNDTThRNWtqdGNFdS82SXlN?=
 =?utf-8?B?SEI3cnJxWVVOYlZoRnFNUHZ6SXQrRkRzVGc2SW9rME1EbUF3NWloSm16MjdT?=
 =?utf-8?B?Qm1wak1LamVOWFRsY0FEd09PNXZoVjZZOWdVdjhCaE9EZkp4eGh5SWQwb3lp?=
 =?utf-8?B?WXRxdi8yNnF1YnNMcG5Ta1pPK2QxejgyeGxzT3p4ZUQxSlBac09IRHZCSUVl?=
 =?utf-8?B?RE9PUkxLc0Jib245UGdzVjZYTktEeTRHaTNPd1NXMkdiVWpha24xZmhsSW9V?=
 =?utf-8?B?emxydUltbVc4RVRMSDBFa0ZGSmREK0NZc0w5QXc1NjJ5RFg5WSthcWRBTVlT?=
 =?utf-8?B?MVZvNVo3bzlmM1Y5S1F0K2RQODVidDhWZ1hXWmI2cXNOU3FLV2pHOWZLbWpk?=
 =?utf-8?B?ZU5IdG9mTGxhQjJWWC9jb2NLU1ArQzVrbjhucnlwaU1JT2MxY0ErQ01QRDZV?=
 =?utf-8?B?QWhQRkpwaFdTZTQ5ZUQrbHphaEE2b1hsTkgrbndkWmVrR0FpWE1RNTZDWWhB?=
 =?utf-8?B?ZVRkT1hVZFpjMC9tSWhTOS9sQnlCL0x0Z3hlMEo5aTllSFhoemlLaUluNjc5?=
 =?utf-8?B?SGlHODlaeW1oVW1PRWc0enQ3ZmwxMmE2bzloK3l5NWRHY1c5YzlOM2ZOdE9l?=
 =?utf-8?B?cW51clc4aE41dmVTTEZ6eUVTQXVDcm9FTUVYb3lwelpkaVh0WEsyTkxuOXVw?=
 =?utf-8?B?NzVQU2RhWXBlR25VcUNULzBIdTU1L3BiNk5UcjI1OWxvZHh1QUY1cTl0RllG?=
 =?utf-8?B?Wk12WUQxMXJLT1VhS0Z1aW0vczcyWm9SQjhIT1NEaHMzK1JlakRnWnJwc2hr?=
 =?utf-8?B?d0tXV3liSU1CSmw5TUVvNmxhVDB3MGZpWkd3eVlhSXJRNFBZQ09LSXJkSmJp?=
 =?utf-8?B?dzVETVEvbGo2eFlvWUVTMEpFK1h1YkxUY0ZQazRtVTlrK1dQY2Vja0ROTmNS?=
 =?utf-8?B?VG5YbTd5WDJsYzdKZ1ljcE1yRDZGeEUxVktTWmhNUFFtUEtEY3hYNUhIMm5x?=
 =?utf-8?B?Z2JMN1N6WG1rMXBZSXo5YVRkUGEyd1pFZGdrTU1MTTZDRHlIaUVPWDgwMkQr?=
 =?utf-8?B?NS9wbG4rSmMvbWdwVXJMSTVCcTFrbXNqNDZxVEVCbzJZWHdBUFh1N1B5S09m?=
 =?utf-8?B?ZmFmS211UTh5eVExc2V1dlBwWk54bkM0a3RSWWxaeGFBaW54MVZSdmVlN2xN?=
 =?utf-8?B?MkpsMXYyUkhlQU15akpLcjFlYmVuTW52QWVvcWhSalA0QnRyV0tJUE4rUnA2?=
 =?utf-8?B?NFpuMk82WVl2Q0NVSlN0SVdENUw0eEt2Q0xta0pPRW9jNlJNV3pkaFFRYU0w?=
 =?utf-8?B?VUlsVmp0cXJqakl3M2dPLy9tT0ljMWlYczBZRFVVOG8yNzJNenJWKy9lR1JO?=
 =?utf-8?B?cnMzbDJYZEZGcnpDQWJ4VHduaUhvb21heXA1N25QeTFBVjdRVWpiODI1TVhM?=
 =?utf-8?B?a0xaNytDcWNjcHFEMW0vejZ3N1J0cU9hbHFNNTBHRXJPSnk0ZHFqUT09?=
X-Exchange-RoutingPolicyChecked: axBfLMub+w14RfPeyML9CRyJXA+Zq6WpZAx9gbtIfv6Tm+o9RR7BL2XM7Z0LYJ1Uw6F72h67/Xuo5Zd8pr1SvD7OWHQIAteXhv/9MEIqYQ/sHO/CCcfHzGOgKU1vBp9RQsTBP5e7aACKQ7zE7c2B/JWGKjVUsVPoSygGoQKSdJkuWd2WKJwxIyx24tMbPM79jLNT/OaCAP91psnnG1iDQ5CzrfHHdJvo4ZUtUQw9VdO/ScfX6gtlHO8CGwEBOJbanyqPahsvxVfngytsFUOwkHy2YpNFaUm+U6WNUaSopzqWmvAuofo+E+38yx00QLE0ARo6/DPHuE781oZbWWw7xg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 191f7a90-6776-4379-7576-08dea5c0b021
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:26:54.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoV+jof4x1sI8AjyPWQt04TayuRH+GwcpG3NhQxt5Fck5r1A/dc7FNhNp8EYu3iQ076LkYu2/NUrZ4k078jA3Lsp/706q4NUnlB4TWLCt2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9184
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: B45C84907A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241833-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chang.seok.bae@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]

On 4/28/2026 5:06 PM, Andrei Vagin wrote:
> 
> The reverted commit broke applications that construct signal frames in
> userspace (such as CRIU and gVisor) if the frame's xstate size is
> smaller than the kernel's fpstate->user_size.

In the extended state area, the sigframe embeds the hardware-defined 
XSAVE format. If CPU A and CPU B support different XSTATE features, the 
layout (size and offsets) differ across systems. However, within a 
system, the layout is invariant. Userspace can query CPUID to obtain the 
exact offset and sizes, which effectively defines the ABI.

On top of the XSAVE data, the kernel appends metadata (e.g. the xstate 
size and magic values). In particular fpstate->user_size is written by 
save_sw_bytes() at signal delivery. On sigreturn, the kernel validates 
this, which is a symmetric and straightforward check.

Because the format is hardware-defined, arbitrary size mismatches should 
not be allowed. The sigframe should match the CPU-defined XSAVE layout. 
So the change in fact strengthens the sanity check.

> Furthermore, this introduces a critical issue for checkpoint/restore
> tools like CRIU. If a process is checkpointed while inside a signal
> handler, its stack contains a signal frame formatted according to the
> source host's xstate capabilities.  If that process is later restored on
> a destination host with larger xstate capabilities (e.g., a newer CPU
> with more features enabled, resulting in a larger fpstate->user_size),
> the kernel will look for FP_XSTATE_MAGIC2 at the destination host's
> larger user_size offset instead of the offset encoded in the frame's
> fx_sw->xstate_size.  This causes the magic2 check to fail, forcing
> sigreturn to silently fall back to "FX-only" mode.

It seems that userspace could translate the XSAVE buffer from CPU A's 
format to CPU B's format during restore. If so, the frame can be 
consistent with the destination system without modifying 
fx_sw->xstate_size, and the kernel-side validation would continue to 
work as intended.

Thanks,
Chang

