Return-Path: <stable+bounces-108034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BB1A065F9
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 21:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE3B67A1014
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 20:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C51F2010F6;
	Wed,  8 Jan 2025 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ne/kw3iz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035FD1AE875;
	Wed,  8 Jan 2025 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367805; cv=fail; b=DVoFJGh6HwF6m787/pEotX3zPWFARCH2hO7l1oNHfMTzsy3HdfpOImM5f2PhelcP5qi1XnIjvubIV+RFhkLl1nT0cHkJqY2e4wW7ZCP8ckyRMmF3VtDg8jG4tX2AKsKnyrxgwbr+pb/TaEP10F0+e2pH5W3cBT9gi0jiuwNktuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367805; c=relaxed/simple;
	bh=Y99f/i3RQsWsTAMedVaA5lNC1ElRJh7iWfs7hMBEztw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jjy0rEd0rR/B3nONBS8GOv6B08ZYi75q9RK6SVPN5zJ4pu/xvWZ1HDo6sQi9Uw9r9sMM4e4E+DRBo4slYH1M5nextEOdFlrimgex9FLAvOeQREejgYGjAtgCb47wdMy/b04tK4+S3IQQLarE9/1qdxF1VRcI1KjtvzoxidADwwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ne/kw3iz; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736367804; x=1767903804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y99f/i3RQsWsTAMedVaA5lNC1ElRJh7iWfs7hMBEztw=;
  b=Ne/kw3izUfNvxh50nZLTI1w0M73bG3+d40AOqTA2qAiUm6rZpQyxeo3l
   mpkPzfaY9yBkesO6rA4fbQTmASaHdGVBC4yCi93IUULTIkUwuk2KVVGjo
   MKOFEdFh63MSPy63SwL2lyzsQVlnHSYKr5/WfpV32iJKxoaq2+1719NkZ
   v+JRQUyVx9nNz7cHRI5VDc4Tu4gjhvD6m4yhhDKAiEbdWPelIO1IUwE+9
   ClwBdoINjtUpzdASDLPBKVm0Zbkc7Cy4y3YVqBwNud+yx5nuVne4qhu8e
   giH0msk8Owl0rYiWoSP5tu3q5Za3XnFvsx6F1RjVyvBSqLyv+cjlJ4rHs
   g==;
X-CSE-ConnectionGUID: 6M8xkrxLTM+7Wb40/Ba66A==
X-CSE-MsgGUID: z2ku9KTCTBmYQaMCXI/TmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="54028268"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="54028268"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 12:23:18 -0800
X-CSE-ConnectionGUID: kAru+lrfQMmoLeyoUM0csg==
X-CSE-MsgGUID: gAfr5Hc7QMSw3pphfgxJOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="126496161"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 12:23:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 12:23:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 12:23:16 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 12:23:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSGBCnr6SOI8fKMksZyyBxXlt2D6KAux3Vaa4T01S2KyaqgmBQBaUHeQuIjCplYsS+pNqXOyb1B5WLHqnVdxIz0seymykAUYklyJ5Z9RZge26z0r8w+HKYut3PtIWPDQdNDrojpaLQUuY/30R4THVo1PQqzuzhwuf+X1aMc0g08VN9v9nTlYYvctRfaXxclo9PWWeqkZ4GVegmfot9KW7m/UCoQpv1oQHFzM4+aGmz8yAjubq0QcINRZP7PFyVPvz/XFQqAstAfNnK6Xbt8y02BePijqxyfmhnbARIGxTjdU9aN25jng6vJis0Bg2tb8JXXyAQVhh09PzOaMlfrUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y99f/i3RQsWsTAMedVaA5lNC1ElRJh7iWfs7hMBEztw=;
 b=cQMko9ZeyIlAu3yTFYcF3CRxgheiGYwGtFfvTQ5r4a/oeaQ3NpvxvrLfSyHDuWK68VzRoE/O2laJvlHqnx36OEb05pupknhMJ2IrT04HB5MLr926RgLUP4qTmdlrFb7nU8/P2fOpgmCEEcJK1nAhqwq8cFbpccyjVODt34OYfqZhLfOwmsBh3iasoWs0PlKUqCzPOnEpRdeYR5+Eeg1ZX9aA/wlD7rz0l2RkqvXkNIoSZpWVerGlcRX6alK/tzqBof7yYLNbkROqon2eMfRycdKXQT1bnwHtBqv/ieUEJz3M55snOfeJ5VlnsxBp/BxSwb1G/qu9XFdTNe2JV6Xryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH0PR11MB5784.namprd11.prod.outlook.com (2603:10b6:510:129::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 20:23:14 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%7]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 20:23:14 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool
	<vitalywool@gmail.com>, Barry Song <baohua@kernel.org>, Sam Sun
	<samsun1006219@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH] mm: zswap: properly synchronize freeing resources during
 CPU hotunplug
Thread-Topic: [PATCH] mm: zswap: properly synchronize freeing resources during
 CPU hotunplug
Thread-Index: AQHbYeiepCw+ZvDG0kypagsSfUtV6LMNT5zA
Date: Wed, 8 Jan 2025 20:23:13 +0000
Message-ID: <SJ0PR11MB56781DA3F7B94E44753FAB51C9122@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20250108161529.3193825-1-yosryahmed@google.com>
In-Reply-To: <20250108161529.3193825-1-yosryahmed@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH0PR11MB5784:EE_
x-ms-office365-filtering-correlation-id: 4711bf39-b5ab-428e-26df-08dd30224750
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TFA5OVJhRzBvakdsclBlU2s5TlQyRTFTQ1VaOTN3cWN5aExNSkRCY25Rdjcy?=
 =?utf-8?B?cXlhS2xBQzVWQStPVlhsb01yb1RrWUNTcmlLZkhQaWVXS01GL0ZsRGcrK2ln?=
 =?utf-8?B?Ym5Ja1AzSytsdXNUemlmVEpkdzN1eHNIUVdyUjY5UlB3MWtiN1llalVjM3ZK?=
 =?utf-8?B?TDUyVUdvU0NEdTR2eENUNTN6clcweUcxbndTYjA3UTlMak0zc1pSdmUvVkRt?=
 =?utf-8?B?NHVja1ROUEoxWUY5ejFtbCsyemR2bENnMUhXc1FzbWczdTQ1OEo4aE1uUWlr?=
 =?utf-8?B?TjNlV0E3bXZucENpN0hjdHN5a2l6Ni9wUndHcTh3YmRWRXFDLzlKQ1dzUlZR?=
 =?utf-8?B?Y1hUR1c4WU1PdC82ZUx4cUNabWc4c2FPb2JVYU9FZkZUZGdCR09lVnJzYkM0?=
 =?utf-8?B?NkFBZ0Vtcy9nYkdpQlhmOXd1Y0N1UWlvM2RaK2MzelhJeE1tRUhySmF2MHpO?=
 =?utf-8?B?SHAybEtER3dOWjlnU2J1QlRJKzNFUmF1QkJrZ1RQTGFTeDJmZjBMblhiby9D?=
 =?utf-8?B?V3ZZVEduamN5VlRKQ2Y0TUNtcEZia3BFNUhOS0ExMWpTcVBwa3RxS0FhR2gy?=
 =?utf-8?B?NzdRMTl3ZEg3Wjk3T3lFekRTY0xLanhtRW52V0dPSm5WdWtOZWJXSzhCMWJm?=
 =?utf-8?B?QzlaRGhYZzNMZVg5TnhvazAvUzEzQ2VBNTFwNXVXcDlEb1dKVUJiekNFV0Nr?=
 =?utf-8?B?TmNsV0tjaTZ3MVJldDJ6MUx5Vnc3dXJQMS9mY0Z0MjY1dVZxeGZyZ3MwSGRt?=
 =?utf-8?B?YlJIcURkWDhlQjV4Vmhob3FmcjBQL2ZWZFA1cTNGSHdPUy9lWGVMMHZPQ3Av?=
 =?utf-8?B?bTR0SG1OKzhWUHRha0ZXMWs0MWx1cUZ4VTVtVGc2QkZxZHVhWU1UbzRaalhU?=
 =?utf-8?B?ZFl4MHZEQnJxSW1TN1IzdDZjYlRQMXdJRmNLZFV3OGdwYzdGVjF5eUk4eUxy?=
 =?utf-8?B?MDJZZ0xSRGdqZDBmbEcyTURWaEg3dmsvSGp0YS9GV0thSExhT3J6VXNGWUwy?=
 =?utf-8?B?NzduKzUraEplMllwMnBjdzh6MndIejR6cUVwSHBaL29qMFlKTFJ4YW9lbyt3?=
 =?utf-8?B?b1VhZXhaRkxVQXJKdWIwTVh3NFp5OG05OCs5a1IvYm5qS295NDlWSDFxS2FD?=
 =?utf-8?B?Rml1eGwxSXQ4WGtiY3NRZzExL0wxSVdNdzZnYitrN1RiSHA5aEgzQS90dXV0?=
 =?utf-8?B?R3k4bGJDUGhqcjE5WmpHSkpBeTJPVWpTNGUwellxQk05bXAzbzduMVlKV2JN?=
 =?utf-8?B?WG9FZzY4WEVHN0o0WGdXRjJVTWRpNTYrU2pUd0FJaEdkTFRjeWJRcDd6dGpP?=
 =?utf-8?B?MTBXQlVRZkpjbHJkd2RIc2xjZGNJWXBKdytQREUwYUNLQzJ1djhzbkRQeUlY?=
 =?utf-8?B?MFpPYStZdVF0emJsQ2NhbCtKdmVSZGZlYmh0U3ZyZmNkbUZpL2pnbEZPSUJx?=
 =?utf-8?B?V2wwcVp6NkRQU2hRRCt6TENwVjIwMUlJQnZXTnpVYjNPWUR3UFhlaDJ1akZO?=
 =?utf-8?B?NWY2RWZWQVgrb1FNdDJBTDdvVEl5TXROQzhHdTc2QTNEUlV5RXZuRUJSTmxO?=
 =?utf-8?B?bHQ2VlBOTjk1RmRLR3dJUEZJYWNSK0MrSDNmYUVXNThaUUVCWDVaMDh4bnk4?=
 =?utf-8?B?b0p4Tk5ueGgyenQza2YxeUlnelh1eWNqaTd0ZnkxVm5aR0ltUVBZSTJabzc3?=
 =?utf-8?B?bjlYNkZuR25DTmt2dkpDbGxBN3R6c0ZHOW9obVY2aitXeTFqNS9uVHVWeHhJ?=
 =?utf-8?B?WnlGdXJpYTc2YkpzZjRaTUR6Yzhzek1LNWp4OHhOVE93ZU9JWDNTQmY2MW1q?=
 =?utf-8?B?cldMRnZISEU5Q21EQ1BhRElMWUEvNTRrQzBCdCtlQm84aU9tUHFMektLSkE5?=
 =?utf-8?B?OVhIdWlTbytWeWUvM0ZPQ0phUXAxZnd2aFNDMkI4QkJ0N1JJVWp2WjQwZE1N?=
 =?utf-8?B?c0Uxa2pvZXF1TkxCYlIrQ0FvV3FOQjhWQzdxNWZhR1h4RmJQQ1N2Vm1uT2Jr?=
 =?utf-8?B?WGNWM1FNS2NBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmdZZDYwNko4ZmplUjA1TldIaTBlSU5kaEhNVEM1WEszSGpXdWVTQ0JMTEhR?=
 =?utf-8?B?V2hUMS90RFd0dW50Znl3SXBzQXVKbzlNdU9UOHIxQ29aU3d2UWRqZHRPTE9V?=
 =?utf-8?B?ZGlsS0NSV2p4OVA0UXlPeGtjVHVYRUROc2prMkJoV2huc0JNSTJEUGFMY2Vx?=
 =?utf-8?B?NUtydmU0aVc4a3phSVJ2eDN0dlNKdFJ2QkRhSzAydjRSSW9OTmFES2Zmalhl?=
 =?utf-8?B?M0dKYzh3VGcvQ0xkQVlZenh2YkVQeU93VUZWZjNGR0xRYkhwN0Z5eGhTbWRq?=
 =?utf-8?B?b0x0TE9uZ0VDVEgvaFQ2VGYzbGRRM2VaMXZvOCt6ZCt4OHRNQXRaSlk5ZUdz?=
 =?utf-8?B?V0tHeEFvQ1lCSjBQMjJGUFl5ZUhWckgrdU94UDlGbm9LT2JjQVQ4ejBvSUJs?=
 =?utf-8?B?Z3FTS3hGR2ZuZlBOMHdZdy9meGZqa05kMENvcXBJR1JqT0E1ckl6STVrT3Ir?=
 =?utf-8?B?QXVPWFNwbU1NL0pjK255T1N5T1hCeThBWnNxeGVRUmpVK2Ruc09GUGhWWmM1?=
 =?utf-8?B?dzVnR0VOcFZzQ2RzRlFPait5clY0MDk1eDhuK3Nhc2tya3FDaXYzZmJiRnVY?=
 =?utf-8?B?ckZOTEJLOEg3aExHK0VabHArK2M5djBZcVVzUTlCN3pudjhUUDBmRENZZ2J3?=
 =?utf-8?B?ZWp1bWRBK01BNEJtSjlQYUs0YjRMZ3BVZDBNNUNxRlIrUlJXbHVFcUN0TzVv?=
 =?utf-8?B?azBPcTdDT1Zta1h6TlJVc0VXejFOZlBYYWJmK3IzV1JOS3FnQ3dWRDMwaDZv?=
 =?utf-8?B?RFRJelAyYnYvdUdqNDk1NC9iL1dTMlhJK0ZVbjN0VXZsZXhqQU9SU3JoZERp?=
 =?utf-8?B?OHh1d05MTGJlc05OdnhUeEdrc3pxck9OZFRiMnpFRHVpb0pFVkU0TEQ0VFEv?=
 =?utf-8?B?eUZzMEhlNm8zYmFGVndpYnJYMi9MMGlwOGFOTGFaRXczajJnRC80REI5Z01R?=
 =?utf-8?B?RHY1ZHNZWFZ3M3BrN1djanl3SkhHb0poMlRybk40NjBwV09SRDZ0TWFybC9j?=
 =?utf-8?B?aGp6Y3pHcHBXcXNnU3FUL1VZQ0tETzRJOHdjRnd6SHlzb3lCbEpBZEY4c2wv?=
 =?utf-8?B?aFp5TUhzMDNNRVA1VkNYZkptRVI3WDEzaGpTYjBPb3loRWRqcHd5MkZ1Umc4?=
 =?utf-8?B?dU1Ld1NvZldEaStIVXk0c1owVnJDNy8vdDRINElMeU1YclNvRW9TazdMd3ow?=
 =?utf-8?B?TmZpZ3NXdWFYTENHQlZBekVoZW16ZkRZQ250cTZPeWREaUxjQ2kxdGZJN2pH?=
 =?utf-8?B?aWtHaWVIN2JoQ3dkK1hDSjI0ZnlWMzNYNEFnTlBhM0ljZmFCc3Z6OFJnYTJX?=
 =?utf-8?B?KzRQTURmcWZWcGlMMG5Xdmh2MXF2bDZIZlB2eEFUU0VuYnhyRXpOZ1NNSXVR?=
 =?utf-8?B?QkFQNDdDN25pK2hEVHhCOXRrM04yUW1TTnlRVythV0N1YndaQS94Y0JtUG5t?=
 =?utf-8?B?T3k4M2FOLzN3RHFUMXdMQmF6ckNjQXhZaFBlM0d6Mms0Y1QvenpLNEl3ODNW?=
 =?utf-8?B?bGd4WU5WakxoUWQxay9rdEt2bFAwZVNiZVBRaEt3bE1lSmltbUt0K2F4dVY5?=
 =?utf-8?B?ODZxYlk1Y2RMZzhQalNqNVlUeHVSdWx4dDlmK3Jpd2R3d3hQcUcyWHZqQmUx?=
 =?utf-8?B?NWlDQ0lXbC94Qk50c2o4MmdmVGFCbHFIWGRFOFBTSDd4UXV6L3FYVFZRWHFV?=
 =?utf-8?B?N2xQMFN1WUNPOUszWHJuMHZTYm5XK1gyS3labHNoUEw4Wk45YkxiU2ZMM0Iv?=
 =?utf-8?B?anVBQVdOWWlnSHQyblBEekRpMXRRWUNRR2lvSnd5Z2MxVzI4cUM3MHZwWDZQ?=
 =?utf-8?B?N0N6R0VnK3FkZFd6V0NRRExaV253c2ZuZUh5UnRQTytOc3UwU1FWWDN2cDRt?=
 =?utf-8?B?bVFDVm1ONWtaZXF1QmdQNGZaSkZKWlh5bGF2eStsejdSN21TK0NYTnprNlhV?=
 =?utf-8?B?eExRT0JRMFlTRTVhYkk4WDF5RFRaeWlSb0Y4ZjI5dlF2MlFodTA0QlBRcnYw?=
 =?utf-8?B?TTJSVWJ2eVJuU2xFd1RNRUtSa2lySHgyNEtyZG1NbTRJNkV0WkJ6U1psWlo3?=
 =?utf-8?B?MGpORGFLUnVNSVZkMUlRck9qUTZmZ1dienkvRHlDUmxLd0tucGdsMUloUHYv?=
 =?utf-8?B?VDlJOENxQzhqUUg4SllvNjQxajdYT1FUUjJSdml6SDZLbzlRTGdtRzFkUHc4?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4711bf39-b5ab-428e-26df-08dd30224750
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 20:23:13.9861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXV0krW+5YH/pMg6XlCkZZonS1bmLQl1GaQdiImh/R0p6zX4cHs4kqSrjh/tNPYMfcJCJS6NqSggNpLkYWuW9/dehkn2oNpBuXcjejRQi48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5784
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSA4LCAyMDI1IDg6
MTUgQU0NCj4gVG86IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+
IENjOiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz47IE5oYXQgUGhhbQ0KPiA8
bnBoYW1jc0BnbWFpbC5jb20+OyBDaGVuZ21pbmcgWmhvdSA8Y2hlbmdtaW5nLnpob3VAbGludXgu
ZGV2PjsNCj4gVml0YWx5IFdvb2wgPHZpdGFseXdvb2xAZ21haWwuY29tPjsgQmFycnkgU29uZyA8
YmFvaHVhQGtlcm5lbC5vcmc+OyBTYW0NCj4gU3VuIDxzYW1zdW4xMDA2MjE5QGdtYWlsLmNvbT47
IFNyaWRoYXIsIEthbmNoYW5hIFANCj4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+OyBs
aW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBZb3Ny
eSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPjsNCj4gc3RhYmxlQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBbUEFUQ0hdIG1tOiB6c3dhcDogcHJvcGVybHkgc3luY2hyb25pemUgZnJl
ZWluZyByZXNvdXJjZXMgZHVyaW5nDQo+IENQVSBob3R1bnBsdWcNCj4gDQo+IEluIHpzd2FwX2Nv
bXByZXNzKCkgYW5kIHpzd2FwX2RlY29tcHJlc3MoKSwgdGhlIHBlci1DUFUgYWNvbXBfY3R4IG9m
DQo+IHRoZQ0KPiBjdXJyZW50IENQVSBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBvcGVyYXRpb24g
aXMgcmV0cmlldmVkIGFuZCB1c2VkDQo+IHRocm91Z2hvdXQuICBIb3dldmVyLCBzaW5jZSBuZWl0
aGVyIHByZWVtcHRpb24gbm9yIG1pZ3JhdGlvbiBhcmUNCj4gZGlzYWJsZWQsIGl0IGlzIHBvc3Np
YmxlIHRoYXQgdGhlIG9wZXJhdGlvbiBjb250aW51ZXMgb24gYSBkaWZmZXJlbnQNCj4gQ1BVLg0K
PiANCj4gSWYgdGhlIG9yaWdpbmFsIENQVSBpcyBob3R1bnBsdWdnZWQgd2hpbGUgdGhlIGFjb21w
X2N0eCBpcyBzdGlsbCBpbiB1c2UsDQo+IHdlIHJ1biBpbnRvIGEgVUFGIGJ1ZyBhcyBzb21lIG9m
IHRoZSByZXNvdXJjZXMgYXR0YWNoZWQgdG8gdGhlIGFjb21wX2N0eA0KPiBhcmUgZnJlZWQgZHVy
aW5nIGhvdHVucGx1ZyBpbiB6c3dhcF9jcHVfY29tcF9kZWFkKCkuDQo+IA0KPiBUaGUgcHJvYmxl
bSB3YXMgaW50cm9kdWNlZCBpbiBjb21taXQgMWVjM2I1ZmU2ZWVjICgibW0venN3YXA6IG1vdmUg
dG8NCj4gdXNlIGNyeXB0b19hY29tcCBBUEkgZm9yIGhhcmR3YXJlIGFjY2VsZXJhdGlvbiIpIHdo
ZW4gdGhlIHN3aXRjaCB0byB0aGUNCj4gY3J5cHRvX2Fjb21wIEFQSSB3YXMgbWFkZS4gIFByaW9y
IHRvIHRoYXQsIHRoZSBwZXItQ1BVIGNyeXB0b19jb21wIHdhcw0KPiByZXRyaWV2ZWQgdXNpbmcg
Z2V0X2NwdV9wdHIoKSB3aGljaCBkaXNhYmxlcyBwcmVlbXB0aW9uIGFuZCBtYWtlcyBzdXJlDQo+
IHRoZSBDUFUgY2Fubm90IGdvIGF3YXkgZnJvbSB1bmRlciB1cy4gIFByZWVtcHRpb24gY2Fubm90
IGJlIGRpc2FibGVkDQo+IHdpdGggdGhlIGNyeXB0b19hY29tcCBBUEkgYXMgYSBzbGVlcGFibGUg
Y29udGV4dCBpcyBuZWVkZWQuDQo+IA0KPiBEdXJpbmcgQ1BVIGhvdHVucGx1ZywgaG9sZCB0aGUg
YWNvbXBfY3R4Lm11dGV4IGJlZm9yZSBmcmVlaW5nIGFueQ0KPiByZXNvdXJjZXMsIGFuZCBzZXQg
YWNvbXBfY3R4LnJlcSB0byBOVUxMIHdoZW4gaXQgaXMgZnJlZWQuIEluIHRoZQ0KPiBjb21wcmVz
cy9kZWNvbXByZXNzIHBhdGhzLCBhZnRlciBhY3F1aXJpbmcgdGhlIGFjb21wX2N0eC5tdXRleCBt
YWtlIHN1cmUNCj4gdGhhdCBhY29tcF9jdHgucmVxIGlzIG5vdCBOVUxMIChpLmUuIGFjb21wX2N0
eCByZXNvdXJjZXMgd2VyZSBub3QgZnJlZWQNCj4gYnkgQ1BVIGhvdHVucGx1ZykuIE90aGVyd2lz
ZSwgcmV0cnkgd2l0aCB0aGUgYWNvbXBfY3R4IGZyb20gdGhlIG5ldyBDUFUuDQo+IA0KPiBUaGlz
IGFkZHMgcHJvcGVyIHN5bmNocm9uaXphdGlvbiB0byBlbnN1cmUgdGhhdCB0aGUgYWNvbXBfY3R4
IHJlc291cmNlcw0KPiBhcmUgbm90IGZyZWVkIGZyb20gdW5kZXIgY29tcHJlc3MvZGVjb21wcmVz
cyBwYXRocy4NCj4gDQo+IE5vdGUgdGhhdCB0aGUgcGVyLUNQVSBhY29tcF9jdHggaXRzZWxmIChp
bmNsdWRpbmcgdGhlIG11dGV4KSBpcyBub3QNCj4gZnJlZWQgZHVyaW5nIENQVSBob3R1bnBsdWcs
IG9ubHkgYWNvbXBfY3R4LnJlcSwgYWNvbXBfY3R4LmJ1ZmZlciwgYW5kDQo+IGFjb21wX2N0eC5h
Y29tcC4gU28gaXQgaXMgc2FmZSB0byBhY3F1aXJlIHRoZSBhY29tcF9jdHgubXV0ZXggb2YgYSBD
UFUNCj4gYWZ0ZXIgaXQgaXMgaG90dW5wbHVnZ2VkLg0KDQpPbmx5IG90aGVyIGZhaWwtcHJvb2Zp
bmcgSSBjYW4gdGhpbmsgb2YgaXMgdG8gaW5pdGlhbGl6ZSB0aGUgbXV0ZXggcmlnaHQgYWZ0ZXIN
CnRoZSBwZXItY3B1IGFjb21wX2N0eCBpcyBhbGxvY2F0ZWQgaW4genN3YXBfcG9vbF9jcmVhdGUo
KSBhbmQgZGUtY291cGxlDQppdCBmcm9tIHRoZSBjcHUgb25saW5pbmcuIFRoaXMgZnVydGhlciBj
bGFyaWZpZXMgdGhlIGludGVudCBmb3IgdGhpcyBtdXRleA0KdG8gYmUgdXNlZCBhdCB0aGUgc2Ft
ZSBsaWZldGltZSBzY29wZSBhcyB0aGUgYWNvbXBfY3R4IGl0c2VsZiwgaW5kZXBlbmRlbnQNCm9m
IGNwdSBob3RwbHVnL2hvdHVucGx1Zy4NCg0KVGhhbmtzLA0KS2FuY2hhbmENCg0KPiANCj4gUHJl
dmlvdXNseSBhIGZpeCB3YXMgYXR0ZW1wdGVkIGJ5IGhvbGRpbmcgY3B1c19yZWFkX2xvY2soKSBb
MV0uIFRoaXMNCj4gd291bGQgaGF2ZSBjYXVzZWQgYSBwb3RlbnRpYWwgZGVhZGxvY2sgYXMgaXQg
aXMgcG9zc2libGUgZm9yIGNvZGUNCj4gYWxyZWFkeSBob2xkaW5nIHRoZSBsb2NrIHRvIGZhbGwg
aW50byByZWNsYWltIGFuZCBlbnRlciB6c3dhcCAoY2F1c2luZyBhDQo+IGRlYWRsb2NrKS4gQSBm
aXggd2FzIGFsc28gYXR0ZW1wdGVkIHVzaW5nIFNSQ1UgZm9yIHN5bmNocm9uaXphdGlvbiwgYnV0
DQo+IEpvaGFubmVzIHBvaW50ZWQgb3V0IHRoYXQgc3luY2hyb25pemVfc3JjdSgpIGNhbm5vdCBi
ZSB1c2VkIGluIENQVQ0KPiBob3RwbHVnIG5vdGlmaWVycyBbMl0uDQo+IA0KPiBBbHRlcm5hdGl2
ZSBmaXhlcyB0aGF0IHdlcmUgY29uc2lkZXJlZC9hdHRlbXB0ZWQgYW5kIGNvdWxkIGhhdmUgd29y
a2VkOg0KPiAtIFJlZmNvdW50aW5nIHRoZSBwZXItQ1BVIGFjb21wX2N0eC4gVGhpcyBpbnZvbHZl
cyBjb21wbGV4aXR5IGluDQo+ICAgaGFuZGxpbmcgdGhlIHJhY2UgYmV0d2VlbiB0aGUgcmVmY291
bnQgZHJvcHBpbmcgdG8gemVybyBpbg0KPiAgIHpzd2FwX1tkZV1jb21wcmVzcygpIGFuZCB0aGUg
cmVmY291bnQgYmVpbmcgcmUtaW5pdGlhbGl6ZWQgd2hlbiB0aGUNCj4gICBDUFUgaXMgb25saW5l
ZC4NCj4gLSBEaXNhYmxpbmcgbWlncmF0aW9uIGJlZm9yZSBnZXR0aW5nIHRoZSBwZXItQ1BVIGFj
b21wX2N0eCBbM10sIGJ1dA0KPiAgIHRoYXQncyBkaXNjb3VyYWdlZCBhbmQgaXMgYSBtdWNoIGJp
Z2dlciBoYW1tZXIgdGhhbiBuZWVkZWQsIGFuZCBjb3VsZA0KPiAgIHJlc3VsdCBpbiBzdWJ0bGUg
cGVyZm9ybWFuY2UgaXNzdWVzLg0KPiANCj4gWzFdaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvMjAy
NDEyMTkyMTI0MzcuMjcxNDE1MS0xLQ0KPiB5b3NyeWFobWVkQGdvb2dsZS5jb20vDQo+IFsyXWh0
dHBzOi8vbGttbC5rZXJuZWwub3JnLzIwMjUwMTA3MDc0NzI0LjE3NTY2OTYtMi0NCj4geW9zcnlh
aG1lZEBnb29nbGUuY29tLw0KPiBbM11odHRwczovL2xrbWwua2VybmVsLm9yZy8yMDI1MDEwNzIy
MjIzNi4yNzE1ODgzLTItDQo+IHlvc3J5YWhtZWRAZ29vZ2xlLmNvbS8NCj4gDQo+IEZpeGVzOiAx
ZWMzYjVmZTZlZWMgKCJtbS96c3dhcDogbW92ZSB0byB1c2UgY3J5cHRvX2Fjb21wIEFQSSBmb3IN
Cj4gaGFyZHdhcmUgYWNjZWxlcmF0aW9uIikNCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3Jn
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBZb3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPg0K
PiBSZXBvcnRlZC1ieTogSm9oYW5uZXMgV2VpbmVyIDxoYW5uZXNAY21weGNoZy5vcmc+DQo+IENs
b3NlczoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MTExMzIxMzAwNy5HQjE1
NjQwNDdAY21weGNoZy5vcmcvDQo+IFJlcG9ydGVkLWJ5OiBTYW0gU3VuIDxzYW1zdW4xMDA2MjE5
QGdtYWlsLmNvbT4NCj4gQ2xvc2VzOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL0NB
RWtKZllNdFNkTTVIY2VOc1hVRGY1aGFnaEQ1K28yZTdRdjRPDQo+IGN1cnVMNHRQZzZPYVFAbWFp
bC5nbWFpbC5jb20vDQo+IC0tLQ0KPiANCj4gVGhpcyBhcHBsaWVzIG9uIHRvcCBvZiB0aGUgbGF0
ZXN0IG1tLWhvdGZpeGVzLXVuc3RhYmxlIG9uIHRvcCBvZiAnUmV2ZXJ0DQo+ICJtbTogenN3YXA6
IGZpeCByYWNlIGJldHdlZW4gW2RlXWNvbXByZXNzaW9uIGFuZCBDUFUgaG90dW5wbHVnIicgYW5k
DQo+IGFmdGVyICdtbTogenN3YXA6IGRpc2FibGUgbWlncmF0aW9uIHdoaWxlIHVzaW5nIHBlci1D
UFUgYWNvbXBfY3R4JyB3YXMNCj4gZHJvcHBlZC4NCj4gDQo+IC0tLQ0KPiAgbW0venN3YXAuYyB8
IDQyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvbW0venN3YXAuYyBiL21tL3pzd2FwLmMNCj4gaW5kZXggZjYzMTZiNjZmYjIzNi4uNGUz
MTQ4MDUwZTA5MyAxMDA2NDQNCj4gLS0tIGEvbW0venN3YXAuYw0KPiArKysgYi9tbS96c3dhcC5j
DQo+IEBAIC04NjksMTcgKzg2OSw0NiBAQCBzdGF0aWMgaW50IHpzd2FwX2NwdV9jb21wX2RlYWQo
dW5zaWduZWQgaW50IGNwdSwNCj4gc3RydWN0IGhsaXN0X25vZGUgKm5vZGUpDQo+ICAJc3RydWN0
IHpzd2FwX3Bvb2wgKnBvb2wgPSBobGlzdF9lbnRyeShub2RlLCBzdHJ1Y3QgenN3YXBfcG9vbCwN
Cj4gbm9kZSk7DQo+ICAJc3RydWN0IGNyeXB0b19hY29tcF9jdHggKmFjb21wX2N0eCA9IHBlcl9j
cHVfcHRyKHBvb2wtDQo+ID5hY29tcF9jdHgsIGNwdSk7DQo+IA0KPiArCW11dGV4X2xvY2soJmFj
b21wX2N0eC0+bXV0ZXgpOw0KPiAgCWlmICghSVNfRVJSX09SX05VTEwoYWNvbXBfY3R4KSkgew0K
PiAgCQlpZiAoIUlTX0VSUl9PUl9OVUxMKGFjb21wX2N0eC0+cmVxKSkNCj4gIAkJCWFjb21wX3Jl
cXVlc3RfZnJlZShhY29tcF9jdHgtPnJlcSk7DQo+ICsJCWFjb21wX2N0eC0+cmVxID0gTlVMTDsN
Cj4gIAkJaWYgKCFJU19FUlJfT1JfTlVMTChhY29tcF9jdHgtPmFjb21wKSkNCj4gIAkJCWNyeXB0
b19mcmVlX2Fjb21wKGFjb21wX2N0eC0+YWNvbXApOw0KPiAgCQlrZnJlZShhY29tcF9jdHgtPmJ1
ZmZlcik7DQo+ICAJfQ0KPiArCW11dGV4X3VubG9jaygmYWNvbXBfY3R4LT5tdXRleCk7DQo+IA0K
PiAgCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gK3N0YXRpYyBzdHJ1Y3QgY3J5cHRvX2Fjb21wX2N0
eCAqYWNvbXBfY3R4X2dldF9jcHVfbG9jaygNCj4gKwkJc3RydWN0IGNyeXB0b19hY29tcF9jdHgg
X19wZXJjcHUgKmFjb21wX2N0eCkNCj4gK3sNCj4gKwlzdHJ1Y3QgY3J5cHRvX2Fjb21wX2N0eCAq
Y3R4Ow0KPiArDQo+ICsJZm9yICg7Oykgew0KPiArCQljdHggPSByYXdfY3B1X3B0cihhY29tcF9j
dHgpOw0KPiArCQltdXRleF9sb2NrKCZjdHgtPm11dGV4KTsNCj4gKwkJaWYgKGxpa2VseShjdHgt
PnJlcSkpDQo+ICsJCQlyZXR1cm4gY3R4Ow0KPiArCQkvKg0KPiArCQkgKiBJdCBpcyBwb3NzaWJs
ZSB0aGF0IHdlIHdlcmUgbWlncmF0ZWQgdG8gYSBkaWZmZXJlbnQgQ1BVDQo+IGFmdGVyDQo+ICsJ
CSAqIGdldHRpbmcgdGhlIHBlci1DUFUgY3R4IGJ1dCBiZWZvcmUgdGhlIG11dGV4IHdhcw0KPiBh
Y3F1aXJlZC4gSWYNCj4gKwkJICogdGhlIG9sZCBDUFUgZ290IG9mZmxpbmVkLCB6c3dhcF9jcHVf
Y29tcF9kZWFkKCkgY291bGQNCj4gaGF2ZQ0KPiArCQkgKiBhbHJlYWR5IGZyZWVkIGN0eC0+cmVx
IChhbW9uZyBvdGhlciB0aGluZ3MpIGFuZCBzZXQgaXQgdG8NCj4gKwkJICogTlVMTC4gSnVzdCB0
cnkgYWdhaW4gb24gdGhlIG5ldyBDUFUgdGhhdCB3ZSBlbmRlZCB1cCBvbi4NCj4gKwkJICovDQo+
ICsJCW11dGV4X3VubG9jaygmY3R4LT5tdXRleCk7DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICtzdGF0
aWMgdm9pZCBhY29tcF9jdHhfcHV0X3VubG9jayhzdHJ1Y3QgY3J5cHRvX2Fjb21wX2N0eCAqY3R4
KQ0KPiArew0KPiArCW11dGV4X3VubG9jaygmY3R4LT5tdXRleCk7DQo+ICt9DQo+ICsNCj4gIHN0
YXRpYyBib29sIHpzd2FwX2NvbXByZXNzKHN0cnVjdCBwYWdlICpwYWdlLCBzdHJ1Y3QgenN3YXBf
ZW50cnkgKmVudHJ5LA0KPiAgCQkJICAgc3RydWN0IHpzd2FwX3Bvb2wgKnBvb2wpDQo+ICB7DQo+
IEBAIC04OTMsMTAgKzkyMiw3IEBAIHN0YXRpYyBib29sIHpzd2FwX2NvbXByZXNzKHN0cnVjdCBw
YWdlICpwYWdlLA0KPiBzdHJ1Y3QgenN3YXBfZW50cnkgKmVudHJ5LA0KPiAgCWdmcF90IGdmcDsN
Cj4gIAl1OCAqZHN0Ow0KPiANCj4gLQlhY29tcF9jdHggPSByYXdfY3B1X3B0cihwb29sLT5hY29t
cF9jdHgpOw0KPiAtDQo+IC0JbXV0ZXhfbG9jaygmYWNvbXBfY3R4LT5tdXRleCk7DQo+IC0NCj4g
KwlhY29tcF9jdHggPSBhY29tcF9jdHhfZ2V0X2NwdV9sb2NrKHBvb2wtPmFjb21wX2N0eCk7DQo+
ICAJZHN0ID0gYWNvbXBfY3R4LT5idWZmZXI7DQo+ICAJc2dfaW5pdF90YWJsZSgmaW5wdXQsIDEp
Ow0KPiAgCXNnX3NldF9wYWdlKCZpbnB1dCwgcGFnZSwgUEFHRV9TSVpFLCAwKTsNCj4gQEAgLTk0
OSw3ICs5NzUsNyBAQCBzdGF0aWMgYm9vbCB6c3dhcF9jb21wcmVzcyhzdHJ1Y3QgcGFnZSAqcGFn
ZSwgc3RydWN0DQo+IHpzd2FwX2VudHJ5ICplbnRyeSwNCj4gIAllbHNlIGlmIChhbGxvY19yZXQp
DQo+ICAJCXpzd2FwX3JlamVjdF9hbGxvY19mYWlsKys7DQo+IA0KPiAtCW11dGV4X3VubG9jaygm
YWNvbXBfY3R4LT5tdXRleCk7DQo+ICsJYWNvbXBfY3R4X3B1dF91bmxvY2soYWNvbXBfY3R4KTsN
Cj4gIAlyZXR1cm4gY29tcF9yZXQgPT0gMCAmJiBhbGxvY19yZXQgPT0gMDsNCj4gIH0NCj4gDQo+
IEBAIC05NjAsOSArOTg2LDcgQEAgc3RhdGljIHZvaWQgenN3YXBfZGVjb21wcmVzcyhzdHJ1Y3Qg
enN3YXBfZW50cnkNCj4gKmVudHJ5LCBzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPiAgCXN0cnVjdCBj
cnlwdG9fYWNvbXBfY3R4ICphY29tcF9jdHg7DQo+ICAJdTggKnNyYzsNCj4gDQo+IC0JYWNvbXBf
Y3R4ID0gcmF3X2NwdV9wdHIoZW50cnktPnBvb2wtPmFjb21wX2N0eCk7DQo+IC0JbXV0ZXhfbG9j
aygmYWNvbXBfY3R4LT5tdXRleCk7DQo+IC0NCj4gKwlhY29tcF9jdHggPSBhY29tcF9jdHhfZ2V0
X2NwdV9sb2NrKGVudHJ5LT5wb29sLT5hY29tcF9jdHgpOw0KPiAgCXNyYyA9IHpwb29sX21hcF9o
YW5kbGUoenBvb2wsIGVudHJ5LT5oYW5kbGUsIFpQT09MX01NX1JPKTsNCj4gIAkvKg0KPiAgCSAq
IElmIHpwb29sX21hcF9oYW5kbGUgaXMgYXRvbWljLCB3ZSBjYW5ub3QgcmVsaWFibHkgdXRpbGl6
ZSBpdHMNCj4gbWFwcGVkIGJ1ZmZlcg0KPiBAQCAtOTg2LDEwICsxMDEwLDEwIEBAIHN0YXRpYyB2
b2lkIHpzd2FwX2RlY29tcHJlc3Moc3RydWN0DQo+IHpzd2FwX2VudHJ5ICplbnRyeSwgc3RydWN0
IGZvbGlvICpmb2xpbykNCj4gIAlhY29tcF9yZXF1ZXN0X3NldF9wYXJhbXMoYWNvbXBfY3R4LT5y
ZXEsICZpbnB1dCwgJm91dHB1dCwNCj4gZW50cnktPmxlbmd0aCwgUEFHRV9TSVpFKTsNCj4gIAlC
VUdfT04oY3J5cHRvX3dhaXRfcmVxKGNyeXB0b19hY29tcF9kZWNvbXByZXNzKGFjb21wX2N0eC0N
Cj4gPnJlcSksICZhY29tcF9jdHgtPndhaXQpKTsNCj4gIAlCVUdfT04oYWNvbXBfY3R4LT5yZXEt
PmRsZW4gIT0gUEFHRV9TSVpFKTsNCj4gLQltdXRleF91bmxvY2soJmFjb21wX2N0eC0+bXV0ZXgp
Ow0KPiANCj4gIAlpZiAoc3JjICE9IGFjb21wX2N0eC0+YnVmZmVyKQ0KPiAgCQl6cG9vbF91bm1h
cF9oYW5kbGUoenBvb2wsIGVudHJ5LT5oYW5kbGUpOw0KPiArCWFjb21wX2N0eF9wdXRfdW5sb2Nr
KGFjb21wX2N0eCk7DQo+ICB9DQo+IA0KPiAgLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKg0KPiAtLQ0KPiAyLjQ3LjEuNjEzLmdjMjdmNGI3YTlmLWdvb2cNCg0K

