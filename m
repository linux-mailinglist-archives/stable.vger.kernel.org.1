Return-Path: <stable+bounces-206208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE245CFFF21
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 21:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BDF730F4B63
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 20:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE12A1DED42;
	Wed,  7 Jan 2026 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PsTbBjvK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCC226FA5B
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767816097; cv=fail; b=bGXC0wMXoXj424PESvl41osEGtTzH2PA/Q+OuT+2x8tK36BVaz83jpak0mdgiIiZp5S7DvNoRzxZm0dqZHzROwpcgA57nbIycHP6Aw0BH4RKcnyfk66A9CQ/f31y4KJEnaOItxErTZNCYctEhVQoMxvFEoO+UCxqtsgzdUiSgk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767816097; c=relaxed/simple;
	bh=Zxip1v3JFREM6RWxYG8UuWmBg9r+MQ0fAfKYvi+He3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rG4CzjM6yjZrPAHyycbX6plXQjC0ip/nCAEpUQOvVH9odS3RttodXGLPjUhIERWdWi8EVcS9IOwVJARAHhNrGV7tTkGZtxdWgnpDqAqJTp6Hyk0NsADRnyimK/+5fDDvTAyd/jOEMbQpJi1tSZjpkW6q4z67gMeLILje+cheuGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PsTbBjvK; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767816094; x=1799352094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zxip1v3JFREM6RWxYG8UuWmBg9r+MQ0fAfKYvi+He3s=;
  b=PsTbBjvKuUN3VzTA3gn330S93Mj8fpzLQyRmEjVUrhLMQTXUzCRFfmK1
   m64Ydhwp8wpiw8IoxENPjXXP5J6B6IqTTYcuf3Lkl8kpLZIyB9cb+82j0
   pLMk8oa+szkaSfYQGVXTqM0btO/RiG3S08ONSH2d8wJjo6HSvhSBWMEDi
   JVkFEos1Kso09rUAqzr0SUjTEQPEqgGFYuuR4jGBEG7oGVLOy9v9PzNEQ
   z7+A9I1hgyrabH8GXqdQUFSJAdnpzJYlIXjMDKgdrfGd3v3x4qgxOuv11
   2rSO/MVJresdYDaYfJRPoKskQzFq1Kw14T6f6UvTlwXS+pftetySyevrt
   Q==;
X-CSE-ConnectionGUID: tTYzOcSWQ82avjKlkV7WLg==
X-CSE-MsgGUID: ia6wg72sQtqGmDMgIEXlpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="69128916"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="69128916"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 12:01:33 -0800
X-CSE-ConnectionGUID: KO5Z8Z7uSyKCzYpWJ5bE7Q==
X-CSE-MsgGUID: dxY8uVYST62usFX/PZVOSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="207543058"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 12:01:32 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 12:01:28 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 12:01:28 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 12:01:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deBwsQ4sb/yeX6ltxbd9+1vKQKaAr+B498jBAquIxUivLnyihPkenMiEcqhwpvFOlB3fP2MmpbqaPIcl7n0RYmuu7XGQBROhjWU/1r1tSR79WRHAH9kHP5freWrmsv5Pf/r/NZsEVbwwNdQjp+45pq0PYPVTRIHnJHQd/crG6ZEIZq0HgBqpVq8b5CT5VOgafYwz0WjGPBEUZU4vkhNVI3ebGBjF8LcNx5SebMUmQer99R9ucsT8OscBdlqoKdWiPBy9Sq4u0rcSw3Vg8hm4IB94zrbGqhqoU3tuv124Ed/DdStXIavz8Biv83lgqkvkb11IZvVAUTuohEp3XPxhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zxip1v3JFREM6RWxYG8UuWmBg9r+MQ0fAfKYvi+He3s=;
 b=NOMWi5Kp7rX8h/bbATRWsR7nlGgEb1OMFUf+NQvzJE1z37JTf9OQnGiw3Z+Rkog/UniPV9mg3zVKNEBpi1tBganvwNJkHlx8Bl9EL9rnz3QiLUbaX1LWzM6YVPfOZ+fh00X+8QXgNQzVHT7ENumde3F3yoxZNk480Uz3v6w61rVuPzTRm3bfiTo3NaAmcVJvU7xgKt2gwnxhUMy49SoVX5phwiNdYuv5tqR7hdarwvk0lakamP+q0r8ExsvcrnPcN6zwnpSyLXeWW9unNcTscj0Yv2LEWFrRMQyh1gVeg08v1h+Lt+5n9nVDf5l4JCI595fqvBYbPWRFQHR29I7F3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 SA1PR11MB8543.namprd11.prod.outlook.com (2603:10b6:806:3ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 20:01:13 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::6a14:6aa3:4339:4415]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::6a14:6aa3:4339:4415%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 20:01:12 +0000
From: "Summers, Stuart" <stuart.summers@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Brost,
 Matthew" <matthew.brost@intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Alvi, Arselan"
	<arselan.alvi@intel.com>
Subject: Re: [PATCH] drm/xe: Tie page count tracepoints to TTM accounting
 functions
Thread-Topic: [PATCH] drm/xe: Tie page count tracepoints to TTM accounting
 functions
Thread-Index: AQHcf2uz4bf8US/0XUSIkOTrIn0JsrVHIeQA
Date: Wed, 7 Jan 2026 20:01:12 +0000
Message-ID: <b019bd43e7f71676e6ac2970253a073af45d8438.camel@intel.com>
References: <20260107002154.1934332-1-matthew.brost@intel.com>
In-Reply-To: <20260107002154.1934332-1-matthew.brost@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5573:EE_|SA1PR11MB8543:EE_
x-ms-office365-filtering-correlation-id: 6de09987-8a99-427d-8f3a-08de4e278243
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?c2ZWdEE2M1FTTTArS2lsQnBqT1AwWlpZcDR1ZDgxVXVqZGF2ZCt0N1JTODVo?=
 =?utf-8?B?YVJqREh4QVR6NjdSRUd3RHVQQUt2OG5xRHIzUDJIc1NEV0FWdUxrRXNXWFFD?=
 =?utf-8?B?R0cxYUJrMFpPelZHK0ZJUUdTdm1OMFNoOFBPZkxHcnhRZTdLUy9ObGRTU0Zx?=
 =?utf-8?B?NVNhS1A0YUdQbFJGdHBiQ0h5ZWcwK040WlQwQnA2UWVtVmYwWnlBYmt6dzAr?=
 =?utf-8?B?bkIxNGNnbTNvcXBzTUdvcUdrTG9rUWZZQ0RmaXNONGlJZjEwZGJTMFhDb0xk?=
 =?utf-8?B?TnFsdllCTmFJcWRVWHcxRE9QMDFYMmhFL1Bxb0hxYWxYeFZuL3BnRGIwMEln?=
 =?utf-8?B?Q0VkY1JrR2VzeDM5bU5ORWc4LzdBclBBWjZEY1B6aGVQaEVFSjQ5MG9Zblpy?=
 =?utf-8?B?RWRGR2hxOUs2WjhBRkhiMDQzSkQ2NDI2SU5LSE9CTHp0dDEvdDFvSHNSeGxm?=
 =?utf-8?B?M3ZEaG51cmg1cG8xcEVheGFWUDZsd3lxalJNVHp1dXlvdExzaFk4RUk5TG1E?=
 =?utf-8?B?YmtENURnY2tuRW9BbFdnUDlNRzVVSmNmaVYzeGtjUUc2Z1pEMmF0K29XdUFF?=
 =?utf-8?B?a1JZSzdDMGNQeFkzeHJrbFBMQWRTM2JGR3dJNm1FZExiNjYweWM3b3V3Zi9I?=
 =?utf-8?B?dzJmWWVSakVtamNYMmM5dk5LZ2ZvNGpBb0gwd2x0cVh6RlVEK3Rqa0N6MC9k?=
 =?utf-8?B?ZGdxNUU1anhtekxlMDliQXZKUkxZd2xYUjMwQU1vcmkwUHpPR0tRWlJ4aXkv?=
 =?utf-8?B?b2Q1ZnFMZU1qUm91eURJTmFIV3k3VTlOODQxV3hiQy9JRTBlbUYxZjQ3MDJH?=
 =?utf-8?B?MUxMelVZaEh3Sncrc1Yvc0hxaXNGYmRJMXNHTkJWQWN0am9nRVBPc1pKZXZD?=
 =?utf-8?B?OGxXcGFuWkdxRVRVMWh4SllBN09WUkxOVWN6aTA1YVVkS1RWS3hKRW1VcGVI?=
 =?utf-8?B?WElDd1FVTHZDOUNqcU9MTm5kUnd6NWk4NktaUldQTVlYMytpM25USkgxbzF4?=
 =?utf-8?B?RjYzRU1uTVV6WC85QVZodjVCdldkZUx2S3hCdkRkMHlJOUloS2pEb01GRm9Z?=
 =?utf-8?B?M0JmbCswdDhvZnBvQzRkWU43MklXYTF4OUxPd0FjYVprUVI4ZU1TaVFRbkpy?=
 =?utf-8?B?VzBEQWFSalJWcTlST29hejdlamZFdGFkbHQrNVdhZUJ6OWVsTS9Rb2RabkRj?=
 =?utf-8?B?dTVCd3RsZnc3N2pubWoyd0RSVTJxdGRoZE9RUzhOekpiVWZwQUJ6QUZyOFJt?=
 =?utf-8?B?aVp0RzFmVTFVWlI5RUJnQ1NOamkwclA0Wnk0MlVYL1JxN1daOXFJTER5b3lL?=
 =?utf-8?B?RU1xdFh1US84enlKVnBQcVpleW1ydWZJOFc2SEgzMjhDRU1hMjZLTlQrcUUw?=
 =?utf-8?B?RTd3TnVYeUIweVZmU0gxQkxVeVZLMk8vOGNxUTZXWXAwNUhYUWVKZWx2YXJE?=
 =?utf-8?B?cTZUZkl2bU9MbEhBT09pN0IzNFZ2cDBTYjQwWlJkSWNMRDZXL3MwbHlFTGpO?=
 =?utf-8?B?OWxZeW5WVVZ6K01FSG9YMk5BTkVzazRZMDI0Tk9jZjJPbUtSK3hUaGdiUTJQ?=
 =?utf-8?B?SE43MFY4MXZ0Wm1yYXVnZXp0UWVWTnhUeXFGaVhrakRJTTE1bFpicHRYM1RL?=
 =?utf-8?B?U1V0Um9URWQ5dVFvbE5rODh3OW9aa0FZOGhZMzB5dG5jZlplakhOZUVnS2Js?=
 =?utf-8?B?ZWFHVzZZbllDcWJZcGxhVTlhU05WczBVb3k2blZ0RnRxUFIyR1JHclpDY0JN?=
 =?utf-8?B?Tzgrbk9tTHpObk5NbHVVTlNLNUxQYW92dHljczluME9GeDEwTkNONE9adkRK?=
 =?utf-8?B?N2pSdWhWUTVBVlRsVzhsQXRNUFY2NGY5TnhEMlpKV0d0N1NvSFFJcXpjUkhr?=
 =?utf-8?B?am9wc01XSFNJd0Y4clY2OE14aTNpTWdtNVN2UU9kVkl3S3RESTBsMHh4NkpY?=
 =?utf-8?B?dTRVU3p4VHQ5b2liYTkwSkVkZHN0SjZvblpjWUk0ek1VTHFuMUdPWUhZTzJw?=
 =?utf-8?B?WVdHVnU5MXRVWmdUTVZMQ2pwWFYvd3NhMWhsR2RuTUtnbFVaRGJLeGQ1TExp?=
 =?utf-8?Q?kYKXNz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzZBVEtQaU1vaDZkTUN2RCtsWmtUVDNQc2ZCOWVwcU1sWVNMTldweDl4LzA0?=
 =?utf-8?B?bW1tY1F6aGlWUW9IUkFHR2VrQjV1ZEs4aW9hUXFYWlJ5ZDlXY2YzNlpNVDRs?=
 =?utf-8?B?eDUzcmxPRFRlTHJObE5kYldTMGVsMG93VGVGVE5TL2l2V00vakJ4MEVHTlpy?=
 =?utf-8?B?Ull3QXIrcTJFNEt6TGVTS0JYZ01DM0pMSFUzbW91bzVnU2tsVDlkZUd6NG92?=
 =?utf-8?B?ejJwU3hnSEtycE9GN01CSG5CZ3B6SCtPN25JakFFVlVoSGwyTnhoQXk0bXJk?=
 =?utf-8?B?bFNmTFp0R2h1eXdTVnBmOHBjSnI0aFh0N2J4NjhudXBSNHZ4a0xmMkxKdEl6?=
 =?utf-8?B?TXVaNWVwSTBmbzZZSkNkTE9vYlA1V1RRNUZSbTNMKzBBUHFaT1N3Y01ZQlFQ?=
 =?utf-8?B?eExXQ2xyTTZHSE5LQlA4b25XWUV4OUMwMVJ1Mjl3Qk9mTjN1dEdUVTdQWm4x?=
 =?utf-8?B?UUh5Rnk4T2NHeHk0MzJQTG9IcUZwYmNSZ2hkSFNKcmJnbVU2OHVsWXM4cloz?=
 =?utf-8?B?NlVPVGMzUk5PMXNWQk1RM2hXcXQ5VHl3VVVPb21Oc1hxYVZnSkZ6WmplNHFz?=
 =?utf-8?B?VTNMKzZSc05CL0YzdTI2d3hudDV2Nk9QM2JYNUoreHRsOG5TbDMxVjhJS2M5?=
 =?utf-8?B?cHdLcUI3S1IyWjgxYkhZUG05elVNUVM3K1NjSGxaV2w4S2JjdjJmeFdvK2NZ?=
 =?utf-8?B?amFmejVyRHJBeXY1aUdPV3JOM0FVTkJIR2RFYjlWaFJCMWtZT1JYcW9mSjNt?=
 =?utf-8?B?SHpHOWt4c0VLSjN5QUVjMmJ4TUkra2xzbGZkY0JaSkU5VU1IZnpjTnB5UC9r?=
 =?utf-8?B?NndBeERsSlBueWo4VkJVVTk5dWlTWkszbkRUTlBUWmY1aWdiT0VLM0NwK1Vu?=
 =?utf-8?B?UnpJSzZxT0xhRllQN0dScXBMUlBId3owMWdFUnlwYUM0L2VOYjhqR1ZTNHFH?=
 =?utf-8?B?V2lhTHcrOUlIbC9JY1JaeXRudHN0OTg1T0JFcS9VMU1MRFlOVVptR24zdWFs?=
 =?utf-8?B?MlhETnh4RGc1dHpGaUFHanhQNUpqRWducVBBOWdLVVdRZDFodE9lc2JoRm5Z?=
 =?utf-8?B?bUFEbjFhRTE5UzZVZjNsaURxTXZlcFZDZUZ0bC9Fd2sra0VCTm5PckxycEhx?=
 =?utf-8?B?ZVZ4Tm04Ym5OU1dWNWtMcC95RFhYUDlibm1ZeHlZV2hHU29vWUpWaVJHMDlv?=
 =?utf-8?B?cER2NGp4cWswMzRtL3VFMi9SeVJ4bkxoUjRpTGlKTEg4SmpzWWxSOUxzMnEy?=
 =?utf-8?B?Qzl1YjNIaUlWZmNYNnV1RHpKZFlzenpZMnpvMXN3STRhRVJNbFM4aW5VVzNZ?=
 =?utf-8?B?VWk1dFhiOURSRlhqNzJNM1dBUmN4S0M5ZVNsbVVRNVo5R29mZ291S3FyOEVs?=
 =?utf-8?B?eHlRdGorRVlkbnZnMkxZTnFzSkFRSjNjMlpjQTl0eEVpSFFIQjdsQkdEZ25J?=
 =?utf-8?B?VWppNmptWDl4S25wL2FhckVIaVRPRHBJRHl5VTJEVC8zd3FQd3lEcE8vZTY0?=
 =?utf-8?B?L0F6aGlWaVdVOEhPT1M1Y21hV3hrNzcvNFdHTDlCSkd2N0FUdWIzUkkyRWZI?=
 =?utf-8?B?UTBoYTM2Y1B2Rmk5T2h1dCtwTGlXOVlSc0FuTzRyekJ2SVE5NCtnR2tyZFMx?=
 =?utf-8?B?d0toanBZUmdFM1duMEZWbUpOQXpOMFZyQ2VwK1MxTDhFL1pDVHp3NmdUVFBF?=
 =?utf-8?B?cUVzMXRTVGRrazJ5eDF4V1l4aWI3enZaVFdXajcrcGRSSGR6cVN5UmJFeTMr?=
 =?utf-8?B?K3NoZDQ2R0gwZWpuaGk4WGM3MG1hbDdrWjA0MkxWUkx2SUcyOVlFYUM1UmRv?=
 =?utf-8?B?YS9DMmxNcXRKdFJLc1hTd00wZEIySzM3b0dLNnFwM1Vjc0c0ZWFjd05VYnE5?=
 =?utf-8?B?a2djRmRGQk1SRkp3UkVLazZGemFzdkx5Yjg3cXIzODBtdnhkTGlzaFE0SEpv?=
 =?utf-8?B?TWRpbmo1dzFUS1RERFJydFUyRkhWZEdoRGZUbmRBb1VJYVZ1Mk5JV1M0ZG52?=
 =?utf-8?B?TUJra1doUVJGWjJlUXlzOWtxM2xsV0NjNEhrWGdwOFk2OVhoWXJpMWI3cDdt?=
 =?utf-8?B?ZEU4cTExT0FMeXk1d3dzM291cHRrNDZ4cjRBQXBubGVqZVhvZHJZRndNaW9n?=
 =?utf-8?B?d01ENFVUdWlac3ZVbVEyK1AxWTlEZE0vTEhzTW11RXdCWDRhS1M2Nk5ZeHY0?=
 =?utf-8?B?cUJYclN1YmJXK0puZjlQVDlkK3lYMzdzRUlnbkd5eHJyZlFMUFBReDdvbndm?=
 =?utf-8?B?YWpnVS9KWmFGTkh5M1pXVU9yQnkwbDNWL25qZzR3R2dkSDZCUVFBdFpVMnNM?=
 =?utf-8?B?Q2NSWVMzdFRJNE1GK001dHVUaXY5SDJ2eS92MXY0cm9iU2w4MGFTRzhtRElV?=
 =?utf-8?Q?/cz8ELR7IhhtY5Hc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6C00980F563CF498C8ECE3B24C8A52B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de09987-8a99-427d-8f3a-08de4e278243
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 20:01:12.8418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yp0HbKfLLXLZqmz7YMHn0kyYwvetZBlCpxcND9+4WlXo8ZAqXE1WLDc/PNyPykqFocVjWs8NrT0BFU92wplhi5uAoFKGL3P0ZcrE7kIA64o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8543
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAxLTA2IGF0IDE2OjIxIC0wODAwLCBNYXR0aGV3IEJyb3N0IHdyb3RlOg0K
PiBQYWdlIGFjY291bnRpbmcgY2FuIGNoYW5nZSB2aWEgdGhlIHNocmlua2VyIHdpdGhvdXQgY2Fs
bGluZw0KPiB4ZV90dG1fdHRfdW5wb3B1bGF0ZSgpLCBidXQgdGhvc2UgcGF0aHMgYWxyZWFkeSB1
cGRhdGUgYWNjb3VudGluZw0KPiB0aHJvdWdoIHRoZSB4ZV90dG1fdHRfYWNjb3VudF8qKCkgaGVs
cGVycy4NCg0KSSBzZWUgdGhpcyBpcyBnZXR0aW5nIGFsc28gY2FsbGVkIHRocm91Z2ggdGhlIHhl
X2JvX3Bpbi91bnBpbiBmdW5jdGlvbnMNCndpdGggYSBjaGVjayBmb3IgdHRtX3R0X2lzX3BvcHVs
YXRlZCgpLiBEb2VzIHRoYXQgbWVhbiBhZnRlciB0aGlzDQpjaGFuZ2Ugd2UnZCBnZXQgYSBkb3Vi
bGUgYWNjb3VudGluZyBpbiB0aG9zZSBjYXNlcz8NCg0KVGhhbmtzLA0KU3R1YXJ0DQoNCj4gDQo+
IE1vdmUgdGhlIHBhZ2UgY291bnQgdHJhY2Vwb2ludHMgaW50byB4ZV90dG1fdHRfYWNjb3VudF9h
ZGQoKSBhbmQNCj4geGVfdHRtX3R0X2FjY291bnRfc3VidHJhY3QoKSBzbyBhY2NvdW50aW5nIHVw
ZGF0ZXMgYXJlIHJlY29yZGVkDQo+IGNvbnNpc3RlbnRseSwgcmVnYXJkbGVzcyBvZiB3aGV0aGVy
IHBhZ2VzIGFyZSBwb3B1bGF0ZWQsIHVucG9wdWxhdGVkLA0KPiBvciByZWNsYWltZWQgdmlhIHRo
ZSBzaHJpbmtlci4NCj4gDQo+IFRoaXMgYXZvaWRzIG1pc3NpbmcgcGFnZSBjb3VudCB1cGRhdGVz
IGFuZCBrZWVwcyBnbG9iYWwgYWNjb3VudGluZw0KPiBiYWxhbmNlZCBhY3Jvc3MgYWxsIFRUIGxp
ZmVjeWNsZSBwYXRocy4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVz
OiBjZTNkMzlmYWUzZDMgKCJkcm0veGUvYm86IGFkZCBHUFUgbWVtb3J5IHRyYWNlIHBvaW50cyIp
DQo+IFNpZ25lZC1vZmYtYnk6IE1hdHRoZXcgQnJvc3QgPG1hdHRoZXcuYnJvc3RAaW50ZWwuY29t
Pg0KPiAtLS0NCj4gwqBkcml2ZXJzL2dwdS9kcm0veGUveGVfYm8uYyB8IDcgKysrKystLQ0KPiDC
oDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2JvLmMgYi9kcml2ZXJzL2dwdS9kcm0v
eGUveGVfYm8uYw0KPiBpbmRleCA4YjY0NzRjZDNlYWYuLjMzYWZhZWUzOGY0OCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2JvLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L3hlL3hlX2JvLmMNCj4gQEAgLTQzMiw2ICs0MzIsOSBAQCBzdHJ1Y3Qgc2dfdGFibGUgKnhlX2Jv
X3NnKHN0cnVjdCB4ZV9ibyAqYm8pDQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4geGVfdHQtPnNn
Ow0KPiDCoH0NCj4gwqANCj4gK3N0YXRpYyB2b2lkIHVwZGF0ZV9nbG9iYWxfdG90YWxfcGFnZXMo
c3RydWN0IHR0bV9kZXZpY2UgKnR0bV9kZXYsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbG9uZyBudW1f
cGFnZXMpOw0KPiArDQo+IMKgLyoNCj4gwqAgKiBBY2NvdW50IHR0bSBwYWdlcyBhZ2FpbnN0IHRo
ZSBkZXZpY2Ugc2hyaW5rZXIncyBzaHJpbmthYmxlIGFuZA0KPiDCoCAqIHB1cmdlYWJsZSBjb3Vu
dHMuDQo+IEBAIC00NDAsNiArNDQzLDcgQEAgc3RhdGljIHZvaWQgeGVfdHRtX3R0X2FjY291bnRf
YWRkKHN0cnVjdA0KPiB4ZV9kZXZpY2UgKnhlLCBzdHJ1Y3QgdHRtX3R0ICp0dCkNCj4gwqB7DQo+
IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgeGVfdHRtX3R0ICp4ZV90dCA9IGNvbnRhaW5lcl9vZih0
dCwgc3RydWN0IHhlX3R0bV90dCwNCj4gdHRtKTsNCj4gwqANCj4gK8KgwqDCoMKgwqDCoMKgdXBk
YXRlX2dsb2JhbF90b3RhbF9wYWdlcygmeGUtPnR0bSwgdHQtPm51bV9wYWdlcyk7DQo+IMKgwqDC
oMKgwqDCoMKgwqBpZiAoeGVfdHQtPnB1cmdlYWJsZSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB4ZV9zaHJpbmtlcl9tb2RfcGFnZXMoeGUtPm1lbS5zaHJpbmtlciwgMCwgdHQt
DQo+ID5udW1fcGFnZXMpOw0KPiDCoMKgwqDCoMKgwqDCoMKgZWxzZQ0KPiBAQCAtNDUwLDYgKzQ1
NCw3IEBAIHN0YXRpYyB2b2lkIHhlX3R0bV90dF9hY2NvdW50X3N1YnRyYWN0KHN0cnVjdA0KPiB4
ZV9kZXZpY2UgKnhlLCBzdHJ1Y3QgdHRtX3R0ICp0dCkNCj4gwqB7DQo+IMKgwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgeGVfdHRtX3R0ICp4ZV90dCA9IGNvbnRhaW5lcl9vZih0dCwgc3RydWN0IHhlX3R0
bV90dCwNCj4gdHRtKTsNCj4gwqANCj4gK8KgwqDCoMKgwqDCoMKgdXBkYXRlX2dsb2JhbF90b3Rh
bF9wYWdlcygmeGUtPnR0bSwgLShsb25nKXR0LT5udW1fcGFnZXMpOw0KPiDCoMKgwqDCoMKgwqDC
oMKgaWYgKHhlX3R0LT5wdXJnZWFibGUpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgeGVfc2hyaW5rZXJfbW9kX3BhZ2VzKHhlLT5tZW0uc2hyaW5rZXIsIDAsIC0obG9uZyl0dC0N
Cj4gPm51bV9wYWdlcyk7DQo+IMKgwqDCoMKgwqDCoMKgwqBlbHNlDQo+IEBAIC01NzUsNyArNTgw
LDYgQEAgc3RhdGljIGludCB4ZV90dG1fdHRfcG9wdWxhdGUoc3RydWN0IHR0bV9kZXZpY2UNCj4g
KnR0bV9kZXYsIHN0cnVjdCB0dG1fdHQgKnR0LA0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgeGVf
dHQtPnB1cmdlYWJsZSA9IGZhbHNlOw0KPiDCoMKgwqDCoMKgwqDCoMKgeGVfdHRtX3R0X2FjY291
bnRfYWRkKHR0bV90b194ZV9kZXZpY2UodHRtX2RldiksIHR0KTsNCj4gLcKgwqDCoMKgwqDCoMKg
dXBkYXRlX2dsb2JhbF90b3RhbF9wYWdlcyh0dG1fZGV2LCB0dC0+bnVtX3BhZ2VzKTsNCj4gwqAN
Cj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOw0KPiDCoH0NCj4gQEAgLTU5Miw3ICs1OTYsNiBA
QCBzdGF0aWMgdm9pZCB4ZV90dG1fdHRfdW5wb3B1bGF0ZShzdHJ1Y3QNCj4gdHRtX2RldmljZSAq
dHRtX2Rldiwgc3RydWN0IHR0bV90dCAqdHQpDQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqB0dG1f
cG9vbF9mcmVlKCZ0dG1fZGV2LT5wb29sLCB0dCk7DQo+IMKgwqDCoMKgwqDCoMKgwqB4ZV90dG1f
dHRfYWNjb3VudF9zdWJ0cmFjdCh4ZSwgdHQpOw0KPiAtwqDCoMKgwqDCoMKgwqB1cGRhdGVfZ2xv
YmFsX3RvdGFsX3BhZ2VzKHR0bV9kZXYsIC0obG9uZyl0dC0+bnVtX3BhZ2VzKTsNCj4gwqB9DQo+
IMKgDQo+IMKgc3RhdGljIHZvaWQgeGVfdHRtX3R0X2Rlc3Ryb3koc3RydWN0IHR0bV9kZXZpY2Ug
KnR0bV9kZXYsIHN0cnVjdA0KPiB0dG1fdHQgKnR0KQ0KDQo=

