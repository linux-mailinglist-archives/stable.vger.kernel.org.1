Return-Path: <stable+bounces-215684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL9mBnZii2nDUAAAu9opvQ
	(envelope-from <stable+bounces-215684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 17:53:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E38AE11D726
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 17:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5664300B2B8
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662EC320A04;
	Tue, 10 Feb 2026 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNKhJZoQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6D630C60D;
	Tue, 10 Feb 2026 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770742381; cv=fail; b=oQgLuOjNnjpzBe7RutA8VJc+7G7RZ1h6YSL7E4dWmPGyZ+n0aIsbAxRpVO6Tf+C4LI0aXfBlTFRd3eH1yEkwI80AFJrXZfC2lTQHH5LpZO352OIwNp+IC2rzSqZqCDCVFoStwuxUY/VpJe5gVvlm6NfXotDCc7J6i5FzgsF7HDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770742381; c=relaxed/simple;
	bh=yCJ2rjCp15HpZox8WWhvLW+fl6RVU4+oDlrKFChZqZM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yru9b1gzy+5Gh9oLwHDHK39nNx1i8q4L+8jtAapHwWRHfstxhMO7Kq+iQodwsDH22+a45CC0Fq7Qk73O7/gi+x8dT+h8XKCiYdgv4PY+lOeAZI1kcXQsPe1IBZMAlPf3CrC5umluQ0nIYN1+mjnrq5R9Rhz/Zxi3wAcYTTDmzQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNKhJZoQ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770742380; x=1802278380;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yCJ2rjCp15HpZox8WWhvLW+fl6RVU4+oDlrKFChZqZM=;
  b=GNKhJZoQS25yEn5iHEbFNrhrNrMgT+k1mnehPbQS2CJsYCJr03VUcn2s
   eN4AKNQ4XwmW5M8HK4SIZDjVDvbUslE/iVk97T4C/IQ+O7eGdxnx3fKxL
   SDzha1a+l4ABw3y0YEYOlWoEoekrdTjm6CyDmeMdosHam14GsfQVKZhlH
   /PIJieFqZpqFhvrQOW0oiNA/u1sGZQS8WvQ6+kzYso1gS6iJlVNUzHGHk
   0HHHoMuVJei1h5eM4P3qUKi+2CheomMeScoKQBcR2TKB2NvPHixZyAXJP
   H4XCOnVxwUTzfGwKk+pXKPGSXPGKVVYn4vVI2xPboCsuX8P9f+lU0h713
   A==;
X-CSE-ConnectionGUID: 9c09jn6ITeiqnFmN5WT8kA==
X-CSE-MsgGUID: AxjeATxNSkKdkU2Ono7zrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71978838"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71978838"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 08:53:00 -0800
X-CSE-ConnectionGUID: 1bLxSIoDR1O/WB1vpq2mgA==
X-CSE-MsgGUID: wVzndM7vT3iSauaxIGOFog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="241905795"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 08:52:59 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 08:52:59 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 08:52:59 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 08:52:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhMQJ+C1fxJ94rz0asN41281Gtfht2rmsOKsqno9k9zvIe02smNSnkEJ2rDzlVEDg+SE+Qi6PXniO5+2JMNJYo0OntiCYmsm0zn2D1tplIvaI9J9EvqQdAKiGs9clPZhK4TgHKGLbISk9x1GxTOAClRCpl6oxSfdijIkmQJlGxBZ4TAwhHwqdQuHU/rr2d8gpSmSLorSn88ArACb3twZLI3IEuDM8HtTlkx/QnJWAgCYMzRb9TLlT+2pEIlB0fZR5VO3B4Ko62wD0AHj6AyzbLVQLXukKJCg/utn32QY6VL/F7LbmpdNnlYpx2qlb2FS/Ro02N2sFmmlWssDkropCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avLu17t4YkshSbCFcckNcnvQ5Uf8+CPMK3zOK5ChRqQ=;
 b=BTblL5EY7oQDpCGJATzinQFBhOiycIKYjQxPYOUJ+wA6ucLb9PPUA9DdoU10FtijvR7s785leuOJxX9BJgNvUs3O9uxScg6ZXRLmCwhqlJbyq2v33QT/HHGO7rCFY9Vb8ZvyxnhapwpsfJHRGFcyOiSuMeXfDHelTz4kmClmL8FoF9Zz5Fysoj9H1MSuWm944+FaTWfOOLHLwAWcH1DIxysi1kHg5miIl/UBWsHVQV1RrjIFUL0tE0nbZNgMV2zlnCRF3kHFapTZNSzuCyvuJhHTOHP1KeRfeLWZErzD6RX7ywNrRng5902g6sciK7cotRDwqn+2LxPRxCAV4Jbe6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4933.namprd11.prod.outlook.com (2603:10b6:510:33::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 16:52:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%6]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 16:52:54 +0000
Message-ID: <f235df30-7b88-4ae7-88f8-399437e85461@intel.com>
Date: Tue, 10 Feb 2026 08:52:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Add per-scheduler IMC CAS count
 events
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, "Adrian
 Hunter" <adrian.hunter@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, Babu Moger <babu.moger@amd.com>, "Tony
 luck" <tony.luck@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260210005225.20311-1-zide.chen@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20260210005225.20311-1-zide.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:303:b5::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4933:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b97280b-1e1c-4b41-ef34-08de68c4d5af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NE9FMTdmcGErbFNVVUhvVDVJNlByczh1T3prd0VwNGROOGxPSzRwM2JVaXNB?=
 =?utf-8?B?ZnB3MkRJTFF1c1lQMWd6NWFNVStTdk9mZ2ZEMk5Ob2VGYmFwQ2V0SlRkK0JN?=
 =?utf-8?B?MndaN3gvMXVhTFRmNlhiaFRHMmhwZ1pHZ09wVm9xTE0yWmJzNmlCYjBzZnV5?=
 =?utf-8?B?cVNJZ0NPNkRQSDl2R1lNUzY3Smd4TUVDM0pPczJUbWxJVzFJcVNwaXlkWVZt?=
 =?utf-8?B?MDFNV20rblN4RVVXWWo4SnJabHBEczlLdkI1c2VRckVyNERHY3lTeGtMekZ5?=
 =?utf-8?B?OVh1WHRydnFJdFJaUXdUcXJyM1RyMFZiRHVSR3JnK3EwV3Q2dVJSWkg1dEFT?=
 =?utf-8?B?WDN4SFRrUFJsUmhJVFBvcVJ6S2xuVEI0VStnais1Wmd5cjYxQ0Q2ZjlzRDAv?=
 =?utf-8?B?Rjd4UXk0MU1teVowNFQxVGUyYmNjeGc4U01NTkNOQ3l6b2lpUjB6aHdWeUxp?=
 =?utf-8?B?a3BFdXdTYklCeDBMemk4bnRCNjhGM1pSLzRoMWNuUk45MGlVSEVDNUE0c2E0?=
 =?utf-8?B?WVhBM09VSFpkdHZwTnZYcFF4NkZxdUJYS1RxVmxyNTdtZm9Ob3pkN2orUVU4?=
 =?utf-8?B?d2huVjk3blFEbHpqWkVEMVZYVk4ydTR5anZld0JtR1hCcFlkYVZWR2E5SlNG?=
 =?utf-8?B?US9jdVhzZWIxVXlTdzV6UmlTc1lJOHRET3UyUHBUYW5wZldFTnc5ZmV1cnJJ?=
 =?utf-8?B?QTRqNFFWTzlCRzU2V1hpWlhDODVBUHNIVlpaUDNLU0J6cmpWV2JEcWhYcFlO?=
 =?utf-8?B?bjJKS1RmV0dRTzh6SGdxNG05RXJHSGVSeHlnNnBFSi9rUzdZWWZVRURXaHVH?=
 =?utf-8?B?T0hBQW02V1hjWkthU3JPUUorYkpnVThCc1BBVk1OUDZ0REMrd0czZGttdnNl?=
 =?utf-8?B?WlNTL1hsd21CdXNPM3RTZDBDNFNmVkNTWHRUYkkzamZNc1ZyVXgvejZLb3RR?=
 =?utf-8?B?ZW9RdDRXMTZYL25Fd0FlVXY3dkVheC8xblN5RG1hRWZvMUZKdkJ0d0NTUGpV?=
 =?utf-8?B?MVFnYnpycktoSCsxN2NESUNTTjZUblZ2NE5ieWZGMC9iWHZnNDJvZVJONXZM?=
 =?utf-8?B?TzhPU3JRS0c4eVFwUk5ZTWE1eFc0RE9RMGFyWlNRQjFUMjgzSzJxbk13TTZW?=
 =?utf-8?B?bkVDM3pUK3FOajN4Y0JWWHF6NWJmZDdQVzVTbmZLOXpzdVYydzhMbWtRVzUv?=
 =?utf-8?B?c2FOSzNoMjhRd1JzbnR2NjYzYUJ6aHA3R2U4WTZZQXpSRXJIT2c5RDJXY2ZD?=
 =?utf-8?B?eHVxU0hSbzZ5Uit3SzNSTFREMEQrS1plaStYb0lDTFBiaHNtaUxhZ3RvQ1Z2?=
 =?utf-8?B?Nlk5V3BnZFZGcTl2VVVKNmRzZFRnOFlYaUFZV2JLSTM0UGVrSUV0TUExM0d5?=
 =?utf-8?B?R3FNblNLY3RhbmxEa2ROY1dYc2lxV1M0czNvaXpsQ1B5cGZ0ZklqM0NuR25O?=
 =?utf-8?B?cHhUZ3l3YitTSDdhWi9UQkp4RG1aVDhIWWRDNFZuNEpJZEJmRGZVMjd0Qkdn?=
 =?utf-8?B?VG1Wd3hxRUlsV0FQNUNjYStHNVdwSTM3Wjh6SHJpRitCYzl5WEtwV2w3NmJh?=
 =?utf-8?B?dnM4dVVCR211ZjU2ZUd0T2lCUHV1bG5nNHk1REVVeFp5QkNGelBVcDBwbGtn?=
 =?utf-8?B?VDFRSXVLbm90d3F4eG95YzJ0VXp3L1NYTHVrRXd5Y0RKSUs0azZ2WENwQnJw?=
 =?utf-8?B?cENlMUR6RWRScElneHQ0VjFHVUYwQ1M1S0pBZmlPOGZEbXRMUXhqSzZ2Vndz?=
 =?utf-8?B?L0lhRzZ6ODB4V3lLWEtBTUR3Y2hrVzNNSk0rM2ZickVZeDJqU095WWJiWHE5?=
 =?utf-8?B?b2dJcWg2eng1dzlxeDFEdERHK3N5ekJ4K0hJOWtyMGVoMWNMNE9CRWtzRmd2?=
 =?utf-8?B?WDNzb0pxc20vQnlKMWViNGFYbFdDbnQ3d2U3NXJMS0xseG83WElGUWdGTWpK?=
 =?utf-8?B?WHVEemh5Qk1ZV2FaWFhURVdEQXczV0ZvSk5FSElLVHk4ZUhlTDdLTkx4ZjJp?=
 =?utf-8?B?VkFibVJhQ2h6YnY0VnpJSm1zMFQvcWk2dUZPalhhZkRBY2dTZzB5MFlYZmdz?=
 =?utf-8?B?cXFkTnp5VmVnMU5TMWNtNy9BQ2VySkwzNE43WjVQSWJWWTg4VUZhajRQQmxF?=
 =?utf-8?B?dXhncUZyVDJaS041V2lEd1lBQlArL2xzWXRPUFNnMlowYnBSanF2Qm1OU3Ex?=
 =?utf-8?Q?oVwxo/1cQECh9sdfHSnPBFo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE50SXRoNXVTSTlNZHNPRjJ0NGhCOVpkSmJmWGl5M2ZVZ1UvYTJOcnBwZGQr?=
 =?utf-8?B?TU5YZlkrbjVPMXFpbllLN1IwQlNxSkFqOGIyVFVZUmh0S1Ixd00wbC93MWx1?=
 =?utf-8?B?c1FhSkRkMVNwejVVYS80ZVgwbG5jSnFvNDltT3BaUHJZelZHTExzLzFPcXdE?=
 =?utf-8?B?WThkallMVGYxQXhUWmFXVHpFekxsTXNOZ0ZBdGtDTXBVT3gxWUhUcXppODlz?=
 =?utf-8?B?NHlqMU9ZSVRHZlJzNTExeHNiZ2k5OFdFbWlPL3UxcVVncVp0YnhoK1EyS2hi?=
 =?utf-8?B?MFhPKzJhYXdXM3Qxb090TlhXa002aVMvNHpmQmtZamd1WEdaRDVnUWJaeVZ0?=
 =?utf-8?B?ejkzdE1acWhsRXo2STN0cDdZMHMwZkJyOGdaTGhMTTZpZ1h0NVNtY1h6T1RX?=
 =?utf-8?B?dXp6ZGpsRnQxZE1wb0FuWTRKL3k1NEJ6cmNxbHVZRkZhME5Ca0lNOUYrYXo5?=
 =?utf-8?B?VFQvaTVDZmNPWTQ4SUtmOVBsdEY2UlU4OFZxVHF4UHBXUHE5UzhsYUlWeGtB?=
 =?utf-8?B?ZUhBQmlvYVU1SUxFMlZtRGcra0dyNGdOQVJZM1UxUys0U3IxMDB3SCtTSjVW?=
 =?utf-8?B?YUZXTVRINUlKMjRNc0dEMjJlb21LbE5DLy9YcjdKY2lXTHNUOVp1NGpsT2NG?=
 =?utf-8?B?RUgvbG5KT3hOd3ZuQlJIUEo1cUp2MlY1ak9raGh5OEFHMVFGWGJRV0FzZTVq?=
 =?utf-8?B?emltRUFTajVrYmZnTFpDSi9ORTlVNUhHZkdJV2JYSFNPQWViYkRNMmh4Wi9o?=
 =?utf-8?B?R3lwNlR0a2tIUk9NQmJja3V2OW9uSGkvYXNxUzhPTGFYR25hUnpOblp2VUwr?=
 =?utf-8?B?c3ZpZGpBczlZYmk3T0t0RlcxbGxoUXhMQ1YwVERmeDFvQTdVdEFLSVpMSGli?=
 =?utf-8?B?N3ZMbnc2djFSNWpBVlkrWnNlM0lZVnJjMFJSL255c21udWpjR0ZYTEhVU3hh?=
 =?utf-8?B?Q3NMdGtzWkxBeitKN1cveTFVSGFoRm8zb281dVVXT0dUZnd3d2xFeEszdXl6?=
 =?utf-8?B?Q0c4c3JOeUVNWnRhZDQ1RjExUTk4Z05OQmdEeklKN2tTNVduMzhvUXpQMGUx?=
 =?utf-8?B?V1c2YTVIUEJSMFBLQU5LSHVPSk9UVHlkNUdHM2Z1dXMzZ3ZZMTJYMThETzFN?=
 =?utf-8?B?aGJpQm8vSzh2NzdBVFAxdUdxMmYveWJZZUhBZDNyRWN2ZTc1THhDOVFDTFpP?=
 =?utf-8?B?N0gxa0VRQ0Q0cm5NaTdkSy9aU2NLR0pkVy9pY2tNRWt4WTNxTlVVb0NhM3RR?=
 =?utf-8?B?ajUraldWOFhMZVdHRC9yejBOTVZOTkpEYSs0bGdVdndBTU8rV3JPZU03MXpr?=
 =?utf-8?B?djdoR3RxdTN5SFVCTkoxdElqMDdQcGJnSlJQdWZnWXppYjJYRUZBT0J0UnRa?=
 =?utf-8?B?aDZHejdYZWhKUFIramE2Yk5oWGlhWFowMmR5SGFMdGNWT1dURDFzSU9sSEs4?=
 =?utf-8?B?cThyYXYzd3JVTmE3aVg2UlZMcG5sNlRORXNwVmplN28xTXloMmwyOXV4NVp3?=
 =?utf-8?B?aDNaKzI1V0pHdGp3dloxVUx3VFpXdjVCaVR2b3ovUnRBYStJeFdzTkZXbmxz?=
 =?utf-8?B?c0dTYU1zcTBCRU1aa1BITzllK3dXUWQ5QzJ3OHVMYlIycXdQUHA4UVRLMUl4?=
 =?utf-8?B?cGJoSUNpb3NPQis5aXc4Zjg4MllSeFE1R0pJN2hzT3J5Rk51U2ZSVUZZY2VH?=
 =?utf-8?B?U21DRE9KOVFFK2lCc2RDdXZKSmxtMlM3WW5TdVdqbllMM0poVTVsaCt5WFF3?=
 =?utf-8?B?cGtweHFYNC9GR3NodDA3L0lIam5xUTA1Q0tObmk0U3EybTloV1B6NGNpblRW?=
 =?utf-8?B?b1dHc2tyOGpUSTBaYXdGVjVJOEZjQ2QwU1V3bEphOWJVeDhudFRsa0kxMlFk?=
 =?utf-8?B?d010TXBWaThMMTZJSUcwSFkyY3ppbm1XYWlpRDE1MnAyOEYrZ0hxdjlqUU5L?=
 =?utf-8?B?NnArMHhwSStsb1A1WmtYb0dxbE1qL2drclhVaUNvY1hGWEJQL0FFbjQ1eXRV?=
 =?utf-8?B?UDZzWVpYckp5ZzhJSGtNNjV0a3NSNmY4dDV3eWZueVhtTGRjMUhZVkRtV3lF?=
 =?utf-8?B?OFZZT1JJOVp6bmhDaHU1ZFdZZ2svcXhxNmRyaE1GZzFWd1hWK05LdFRwRGdT?=
 =?utf-8?B?clp0eXB3OFE0ZnluVk9hSkpGNVNNbTNDTlpRQkIwSDk3Ri9BcXQwbHRIcFlX?=
 =?utf-8?B?aVNCeW9GRGUxWDlGSVBkcjFDbFdkUjRjZG5Bc3FlSENNRkRiSnlrTW9GVUVK?=
 =?utf-8?B?dzRYN01WU29ya2hMQVNnNXBpOGtuUi8wSlJsRmZpVE1DNThuM3hQZ2VRSEhP?=
 =?utf-8?B?MkZ1VXkzaW52WG1vMUU2TVJRaHlZOU1FMGxkNkNtZEFucWdJQnN3Qms4a2M1?=
 =?utf-8?Q?/jtmGIL4fTVj3riI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b97280b-1e1c-4b41-ef34-08de68c4d5af
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 16:52:54.2330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSKJL5J5cbnvuAgE9GuSWlO/8aUCMPWp8Dy9vujihAg28zTc9cCGNw2JwPFbFxkxENOe824J1s5J8pebXkZuntQa3DHL7Hq04czbQXnHx1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4933
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[reinette.chatre@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-215684-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: E38AE11D726
X-Rspamd-Action: no action



On 2/9/26 4:52 PM, Zide Chen wrote:
> IMC on SPR and EMR does not support sub-channels.  In contrast, CPUs
> that use gnr_uncores[] (e.g. Granite Rapids and Sierra Forest)
> implement two command schedulers (SCH0/SCH1) per memory channel,
> providing logically independent command and data paths.
> 
> Do not reuse the spr_uncore_imc[] configuration for these CPUs.
> Instead, introduce a dedicated gnr_uncore_imc[] with per-scheduler
> events, so userspace can monitor SCH0 and SCH1 independently.
> 
> On these CPUs, replace cas_count_{read,write} with
> cas_count_{read,write}_sch{0,1}.  This may break existing userspace
> that relies on cas_count_{read,write}, prompting it to switch to the
> per-scheduler events, as the legacy event reports only partial
> traffic (SCH0).
> 
> Reported-by: Reinette Chatre <reinette.chatre@intel.com>
> Fixes: 632c4bf6d007 ("perf/x86/intel/uncore: Support Granite Rapids")
> Fixes: cb4a6ccf3583 ("perf/x86/intel/uncore: Support Sierra Forest and Grand Ridge")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---

The resctrl selftests compare the read memory bandwidth reported by
iMC PMUs against resctrl's memory bandwidth monitoring (MBM) numbers. These
tests are failing on Granite Rapids and Sierra Forest because the tests use
the event/umask obtained from 
  /sys/bus/event_source/devices/uncore_imc_N/events/cas_count_read
that only measures about half the bandwidth reported by MBM.

When using this patch and adapting [1] the resctrl selftests to use the new
interface to learn about the additional events it is possible to get the
accurate iMC PMU memory bandwidth measurements that match values reported by MBM.

Thank you very much!

Tested-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

[1] https://lore.kernel.org/lkml/cover.1770406608.git.reinette.chatre@intel.com/

