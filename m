Return-Path: <stable+bounces-224520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKtPG81IsGnFhgIAu9opvQ
	(envelope-from <stable+bounces-224520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 17:37:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2B6254EFF
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 17:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1522831459E7
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA6C3C5544;
	Tue, 10 Mar 2026 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lY9e7xmM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C4C3BC663;
	Tue, 10 Mar 2026 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160621; cv=fail; b=rWMekLvAlCVV0lz66V4/1c17pS4/TPetxo4ipjE8b9Hr38B/HXlgo/iXVQ3Ty0N+HhPlF7+5RMAAQfbJG7biPn3D/tagAH3TEgYlji0t97/w0Nx9RBTt0SNYM33xOSlpP5sTyrk0QeAvwDpoIUs8cJDbRP61IVnOA7Ul5tgK2MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160621; c=relaxed/simple;
	bh=b89XO0O7BTcOscwE30ezkCOqSz/PFaoYJPNtS4dxkC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K9hW4fzJpNXleTxt6/poZh8XXLf+04rVQ9Rih5eo7IcrQXo+n+gk9gF2K6K5Qy0bEOpR4x7e2M8Kgg/SZtcRZoWnGWibbvqXNQZWyznEsM2ckwkli3WOQTf2v7MggTjRKKGe8Uph0VieM2UhB+o90FdJp7EsXUSwjNwKXTYWr6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lY9e7xmM; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773160619; x=1804696619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b89XO0O7BTcOscwE30ezkCOqSz/PFaoYJPNtS4dxkC0=;
  b=lY9e7xmMMXPlQsJOBJXxNQYvZdIbijo3EwdiDpO+HpKdUF4mbbnbFXCi
   9St+oL7DjXS7S65RRpp4AO9UcxqV+s8jLOPmwd7vMnrO4udUZIprnITTL
   6ZeDiyZ0n8+GCzKQwjRetGFF7un45Qv86CCnSYAMG3ZiaoG8Phsq+2lQK
   NCi7LVTi+bnyQxOjw10w/fK56Av9SjRHymKqoypTYUwcT96TuoOekuIR8
   gi+OKO5RFj9jVgb5q5GLBrpCT6zeH6rcWb0nXIkzUkFKPsttHSvlBVa0P
   C3Jeibs0Ss6QZXBoJQ1B1Y7Pl0XP1nZKi3dI6vyzgxWM7+j8fIa1uKJEO
   w==;
X-CSE-ConnectionGUID: q4X72eOmSdCNJYI1dYCpww==
X-CSE-MsgGUID: e+PeiuEtSq+avs3Oq4qZfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85305789"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85305789"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 09:36:58 -0700
X-CSE-ConnectionGUID: 8DgKc0iKRJeA3zZ6dJbJOA==
X-CSE-MsgGUID: CTepTGvmSOCoJS8LnYcEfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="217698521"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 09:36:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 09:36:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 09:36:57 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 09:36:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLet/Qf5RkpwzZIOKOZ+tYk7gsgXGEwwMKUuvr2t0rwjuVjvPfENc9FMsHuOG0TUanioeNnRKsNqXAi2ZCEBrK2hNmOhOXm+HA0qUh1jkmko/Sl/bgixC6PWnl7/gz1TEBNBMKine1PJVLMVxW7YTIFkDkXtdMkw3GiXuuV7TvhVbUdVG5OwLIpVCinMVEuLMHhG3d7V5kqRrvChBQm2DN02N2eSR2LQKG/jiIAoEZJ6uMjOxpHKSxy4Nd0WCTNUzmY5HsNkZcYaHn0I/EElWkGdBZrcyV6eiFhSwp989OIHMrGY0g+NNAfpcy6Fqz5CgW/lrr7l+89U9J9MR8ucLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b89XO0O7BTcOscwE30ezkCOqSz/PFaoYJPNtS4dxkC0=;
 b=DnNAPa3ZnYPiyFy9s6EGt+b6TI1rwm0NVZX91FDFY3Bk+U+txuOVn1BlA98N/cnGpSUa89q9Q4q+QDqYvO8BWedfz33Ey7dwJebeM3jqWY3UgqQkFUuxZ86FHBQI/vZa9DJkcEHFaoPGo453fYZ3ritoEP68Oqzn634osUbpG7VaD02iqM5DGjo+PTgHY8ud9VkpXoJJJbbz+kPWycXxY32fJj3/nU8IIyCS4nEkUKK7Eo5LdLuseSY/hVBzYbULyMYaYXVoRvqmTaJ8EUQySIGNv7+g86nDSqxGmowH3IyrJiNXKLiwc+aI3dkBPVgShopK9o/m9uqHyG/KlBe0NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA2PR11MB4842.namprd11.prod.outlook.com (2603:10b6:806:f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 16:36:55 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 16:36:55 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "Huang, Kai"
	<kai.huang@intel.com>
CC: "mingo@redhat.com" <mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Topic: [PATCH] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Index: AQHcqi6VnrQj2eoJJUyFZAbVY/MSfrWmck0AgAD1v4CAAG1DgIAALogA
Date: Tue, 10 Mar 2026 16:36:55 +0000
Message-ID: <4512921c8a248e0193cca3660b96e721e289b11d.camel@intel.com>
References: <20260302102226.7459-1-kai.huang@intel.com>
	 <e762ca34d2e3f3555490e158cab82292c6122857.camel@intel.com>
	 <88b3637c84737136da1fe373cde43801845bd062.camel@intel.com>
	 <abAhne3A5WNARgZo@google.com>
In-Reply-To: <abAhne3A5WNARgZo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA2PR11MB4842:EE_
x-ms-office365-filtering-correlation-id: 27655864-eca6-4926-4dff-08de7ec33dc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: lIYr2C1DAjquJTCj/D/9ifmeG2wim0cAEzTtFqrvdyTbuFTmRePdFWWtBxsENHi8j7vsm8ia/UCFKKJ0ivsfYQxI0HS29pn6ClkbAmIOWqDwea2CKvDwqh2+TXFc4CxAEwbQjNLFqfFGexKDIdSHKmS8bVcGLmVVsafPxGajhmSqd3rP0FHwq5pwLtT6oA20WWvG1DxGt6ikuKrwFZW9mbdElW3BTNSeMtjSyDpuizSwG/j8DL+hhghdNQEbzfsKa84/0WEFe7L3V1Nii1T6ihUA2Kk9AXiPaISNj5joNz/YEJLX8GlumctULuRg/zdw3X/FFspeps1zjrgb2wWO7478SFl3pgIgw5PInfWCzo+DVBJ64JetGya9Z+B7Wn0xpRHrAK3wc+jeGsK8T8fIS1iTcRWzWjySmnKW78Vzl1bN3z4yqnQW0BVctr8GAWYP08xeDtAdv3LJyjOIjz64vGLsafoQtC3NBxMZZpl3dEZXkvvjtpob95jE8KApsJPVJKIArIXldRP9HJZ44aLTCNygeU3GjFZtLaDVx55pTxHs3J8RHgh86+OP4knijhudgKrDvkAO0f4oc2EkiFuafXaTCTnmK8q4iMYBBYhkRV40yPUtNHg37HK1x5vibFxfY7/CmrPd2QaVVtj0wXnsu94xnfTzpaVXuHBgkT6V9mfND5qDfuCsDsngBtdhxZCHhGtFVchK4B+qRL6SyO7//R12PY35J83i7CfwEXzBfLhhCeDvhrpp0f5Hc9AYPqiPZybY112L4iRxV1e8Wo82N4J47E7IYrvQeEDkRl58irE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWkvVXhqYWhPZkhwM0E0b0tiWm5uQ21KbCt2WWxzZTY5TkYvUmNBY1Vabjhu?=
 =?utf-8?B?bGZqLzRzb0NzSzBqYXNabXg4ZXpvc0F3UG1scTFvU3AxYlpLOEduYXp0NklT?=
 =?utf-8?B?WFlxbzFUS2E1emtTT2VhSnZjQnF3Nk1WMmJvVzAwcXBpeUd5cHh2ZWYrQkFD?=
 =?utf-8?B?U3ZHclFCc2JMelNOZnRhTTVIT1I5RHhQZFFYV2hYc1d6cjl0RzBhVWNnRTZH?=
 =?utf-8?B?c3hBNkJ5QzVyQ1o3TW5jL3NiNzNjb3NucER5VkVLQ3FhT09QdS9wTEVTcHpS?=
 =?utf-8?B?eTkxYlJ1ZFpMSWhkazZQRk4rcmxFOUxFTmJUOXJya2dMN2ZYUGxTaFBhSU5o?=
 =?utf-8?B?WGFpcG51QzJwZmlpbk5RUGoxZkU5UlBEUFRZQkJPZmNjakFHSzJXays3WXg4?=
 =?utf-8?B?c1FJQm5iV1NZWU5jelV4Y3JjVVNCSUZWUlZzOSttVXV5NDVjL3QzSmJFSzJJ?=
 =?utf-8?B?dTZuK055L3ptRGVmSlRqM1R3ZWNGeXhoa09yUTlLZjV5RnByNjdjN2VyTmo2?=
 =?utf-8?B?QXFrN1FnenFWUE4vYVJPVGlYaDF6aWhLVXc5Rmd1VHVwTkdSQmZHMGNKdHBx?=
 =?utf-8?B?dGRmZmhMSjYwNEMzWGtYbFg4cmtoVHVKRExYUmc3OGc1d3R6SEVtN2VEaFgz?=
 =?utf-8?B?NW9uSE5nSEZ2TGY5SlNydXhabGQ2T0NSeXA3R01PZVhMdk8xaE1heW1VZkZ0?=
 =?utf-8?B?STdkUUFSTVRzOTFKbmYyQVo0c2YybWFSd3FqVVZvSFNQV3dzcWtrQ21QdnA2?=
 =?utf-8?B?UlBKeTJNMkx6VTYwNGpKVHZVZ1J3VW15aGJsYnF6c3BTOW9GTm5wNmRpbWEv?=
 =?utf-8?B?TktnTFhha3V3U0NKRVJTT1dyZ0dOY2tsdzdmYnZSclNhVjB5aUZ2aUtNK3RH?=
 =?utf-8?B?ZmJYV1JrNTRmTjBBUjB3cFR4VzdSeEpkSlUrbW1FWWxkN1ErdVZoUUdpNzN2?=
 =?utf-8?B?V3dDSS9Lb3J1QkFoaDVXQlZJT1RKaU1RVWpKWmR0TmVqTGtuaGN4WkZqK1Zm?=
 =?utf-8?B?TmI0KzdTQytUTUZpMWcrVXB0eUVtWURKN2pNWk9PaGV5eVFIeVlXZGxjVUc1?=
 =?utf-8?B?V1pnT0FtQjFXUGFZWmU0dzhhVFB1eTVqWVlIa2F5MVpUZWxCT2VCNjNpVU41?=
 =?utf-8?B?RXE0bmJkNHNqazQ0ZVNvamoxb003VUtrUVVsU0E4LzJsTTdwZ1NiQWNKejE4?=
 =?utf-8?B?WFVYdEJ6RUI3ZE9XVEd2L1FEV0xtUDBlYlR1a2lSSnFsUmpyaWo0Sm9SOGlj?=
 =?utf-8?B?djB3VjZvdE1xWndJdlQ0MW5mcU9QbVM0dlN0c2oyaEtCQWFFcU1udDRqM1JD?=
 =?utf-8?B?U0xlN3VwSER2dm5hSnU1dXg0VmdOK1NibU13V3dOZzlGVzNBd3VwMjJXeTNB?=
 =?utf-8?B?SDhLdmt5SGh4ck1oa05CaXR5R0d6QWdOK0hCVDZWYy9JQS9LeFBqTjJNZGp6?=
 =?utf-8?B?NUVjc3A3RFhwV1k0QkozTHJzV3BVamdXME1tb1BHc0t6NlhaL0pFUTBjNHND?=
 =?utf-8?B?UEtvWExUenQwd3ZqQ3V3SS81NUp5ZlVNTWdwWHIyRkFEeG1OSEk5WmI4R2xQ?=
 =?utf-8?B?MmhLQ2diOHR6U2ZMOUVXUjhjb0dpZHBEZ1JIbEdCTmM3L2ZkK2RJRGVDVmFP?=
 =?utf-8?B?RUEyUFFLakVUWnZqanJGTmZSY2ZIL042M1VZNENEQTZWWHFuR3l1WkJ1TDlP?=
 =?utf-8?B?U1BCeW9td0c3L0lxRWMzY3Bvc2hwaUJuY1IyTnhZb095SjkyZnFybmFuMHlO?=
 =?utf-8?B?bGpSRjRXZSt4NExzQTVsWFRDYzZoaEdOdkZ6WW1JYWlXS0FVOWhOT2lQY0xl?=
 =?utf-8?B?Z1UyV2xuWndnYmRHd3VnaUZ2WnBMbzVBdVpNTWNvWWp1Q3RQZW0xZTZNVXhx?=
 =?utf-8?B?ZVlvR1BnMDU1Q1dCVUFUTGp2aHV5UkVKeFRhYjBBYVhmQlJCVlR5TTBXQUpk?=
 =?utf-8?B?YXVqS3JYbDBSRFY3REZvMS8xd1RncW1nTlNYbDNCU3ZlYzdRNm9MM0pBQ0lv?=
 =?utf-8?B?S0tjaWN3SzhEUE45MU5sWVJHdGtlRmR0MWdiYktJc09ZV2ZobGlhY1NJY2Zv?=
 =?utf-8?B?SUxCTHE4ankzSkMxWFJoL01nc0c2cG43MjRTcmxNSlJ6SlB3b3pDNThESk1C?=
 =?utf-8?B?WG9scnBuSnFINHlvbGswTUpTYTRpb2hOblRvU05tZnJwU1FSeVczNEpPRW5T?=
 =?utf-8?B?cjBGK2NVSDh3aWVudS93a205dmdKWDJpMTlxSUFBcnJIR2hhSklrcGRjUVlH?=
 =?utf-8?B?QVY3TVJjNUgzUGVhSDhiWC9CZ0ZzUWlleUl4UzVhR1o2WjlwVkI4T1JrYkNW?=
 =?utf-8?B?b3RFSXNPT1lGMitkTEM1K3N6cnVsMmZoS2N0WTEwWkxiMzAybStTbGViRnZv?=
 =?utf-8?Q?jWQ4PJPdtBsYfyx4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0998D8F021F6A042B6E2BEBB9AA9FC34@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bSp8JAgU0ajhakmtVe8dbOa5TLLWeBTqTTwgFuG9uI7ZC3DmnCkot5qmievh3tV/rZCWYnq45eu8bdq6uZxERTpK9KoPXTl28m9i1B2M1aZTrFuOQ/p+8R6NOp5QwLm3/xuGss353LFg5+rZ2UlUPOy2FXSx3zJkd7xHiMAjoSeF/6kKogLt38z6pOh/CnPH415WzwM/JuJojV+tmrOSYpI7ajuK1PMZ1c1d2mWqrcfeMa6Q56ZVTN817baPaVAMCs+mn1kN68E2N1OkMaJJi9hToZF2qzpc22Ss6Wld/d8SwOxcTb7yJbhgstxhPmG2p8pYit8TiT41724rx7teMg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27655864-eca6-4926-4dff-08de7ec33dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 16:36:55.3068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UKq5pfLRf6Z11WLkDhnIbqWDVnWXoU/LNIANICD4OxzM4B9l4FjlfIX0OtzV/V6gA/1F1hOP9hu7+b2tnNXsEwJfRFDdbqHO46ADf2eQg2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4842
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 9A2B6254EFF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224520-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rick.p.edgecombe@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAzLTEwIGF0IDA2OjUwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBFdmVuIHdoZW4gdGhhdCBzZXJpZXMgY29tZXMgYWxvbmcsIEkgd291bGQgcmF0aGVy
IGhhdmUgX190aGlzX2NwdV97cmVhZHx3cml0ZX0oKQ0KPiBpbnN0ZWFkIG9mIHRoZSBleHBsaWNp
dCBsb2NrZGVwX2Fzc2VydF9wcmVlbXB0aW9uX2Rpc2FibGVkKCkuwqAgU2ltaWxhciB0byB0aGUg
V0FSTg0KPiBhYm91dCBJUlFzIGJlaW5nIGRpc2FibGVkIHRoYXQgZ290IHJlbW92ZWQsIGV4cGxp
Y2l0bHkgcmVxdWlyaW5nIHRoYXQgcHJlZW1wdGlvbg0KPiBiZSBkaXNhYmxlZCBmZWVscyBsaWtl
IGEgZGVzY3JpcHRpb24gb2YgdGhlIGN1cnJlbnQgY29kZSwgbm90IGFuIGFjdHVhbCByZXF1aXJl
bWVudC4NCg0KQWdyZWVkLiBJdCdzIGp1c3QgZ29pbmcgdG8gY29uZnVzaW5nIGlmIHRoZSBsb2cg
dGFsa3MgYWJvdXQgYSBLVk0gdW5sb2FkIHBhdGgNCnRoYXQgaXMgbm90IHRoZXJlLiBUaGUgc2lt
cGxlciBhbnN3ZXIgaXMganVzdCBtZXJnZSB0aGlzIGZpcnN0Lg0K

