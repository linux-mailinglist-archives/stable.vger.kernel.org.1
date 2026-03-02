Return-Path: <stable+bounces-222569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNrVN1FnpWmx+wUAu9opvQ
	(envelope-from <stable+bounces-222569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:32:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 675AA1D6914
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22DBD310FEDA
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 10:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09B73A63E2;
	Mon,  2 Mar 2026 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djgtjHNv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1E33A0E81;
	Mon,  2 Mar 2026 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447177; cv=fail; b=reFPqsWLpwmT6yVwKrzw0wH7ZLJ+sGMpZX3BvY6VCDXkc3T8rgOmvFKrejl5EEIQlPk+ApBlM7cZNKJ1FRWQuaK8F1wEpORMDWI9tfxLH3yHcxgM29nesNB4crXjaWuTJ6kLmsHzIFdLbvZvSCriuiCWcV3oH43LLXRmXRyqB4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447177; c=relaxed/simple;
	bh=CIulVARYhHa2AoLLdihR/W0IFaUaOK31yo3jsYF6e1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VXY9kYKwpzrjybNC3UCPa+VwHnjLy5vcghZwnRjtZ5PVO8Z4+9Qo/tjbyxsYIIyhSXWLHC6pfICt9KBXKklnpQN20kttE/VlcVzF5xKD6H/o4gwuiYGE+3uu0AsY9qjtmAF3NBTeUtrdr8OKLgcsyexVa6jlAlsLFlo0H5nqSqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djgtjHNv; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772447176; x=1803983176;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CIulVARYhHa2AoLLdihR/W0IFaUaOK31yo3jsYF6e1E=;
  b=djgtjHNv0/WAfraUoEmKH8gGe+J0lc/EqMiAv99x3qM2ygybmV3VQlvV
   AE759olDZhcspEuKZR4DAiz9oRc4nrMKkn2ynGm5e+sV2uKbzplC7gU7g
   kBg4O6UtH6FoXy7cg9w/nqPCX8k5uo/+MWgvQPirO53ri8CfOEOHK4/yP
   3IrdDtDLCN9+N+x2l0hgRI9UkL05jCX6fpmOtQOV3khQRRWJRBBMqF8bb
   bMlH+L1iwRLUpUw+qrJafIIIgDN8QHrV7jFzs3w3FVxsw6GRP7486IyVK
   JsKjsRYqwNz53ln9eddPT63p0bcTtiTKLHP+07LfF7Z/Q3GVRkxR3I2HL
   Q==;
X-CSE-ConnectionGUID: l71VwgvNS0Sk2wwio8Unyg==
X-CSE-MsgGUID: oBO7EeO1RFeeNBnTM53soA==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73414563"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="73414563"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 02:26:15 -0800
X-CSE-ConnectionGUID: eSzob3ONQ5muLKm2exy0bA==
X-CSE-MsgGUID: gsppOrMrR4C3rr43KG6qzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="222245126"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 02:26:15 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 02:26:15 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 02:26:15 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 02:26:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBYrk5bY0t1oxQL0OX6vqnrNGifhvp4Z7zErI1hPkstSr5yDan9wwUqFb4MCTv8WBP8HfKBzG7xIvU24RagXaTFh8m0N2Uqba9bNcBw7UkRmJNpMpODHjGK2YxUS+P4gOBo/Ir7x4Vhz4ODbFTH+6CfRjgVKHVeZwnv1VpJ8ANZhyi6hsUu4JxChQsJiue5qVnM0gf/Y5xQ0mYm6bqr8V4n6KEOMi2M+1qWAmXRG1ctCUifhrnsjvTcQHRIKg8xi9ZhWeUIAP/P/iJ1qOESJ7Z014vhLVkwB8c9bm8Zk4rflR9NrwnItz1mEsTx8ipLvtPQp1110dnSsdutriDg7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIulVARYhHa2AoLLdihR/W0IFaUaOK31yo3jsYF6e1E=;
 b=Sjgra2YVIf1GPQLELTZae9Tl3q4Sym0FR9NjRBsIOOLQNu5m+25GCpKXlO3x/qWSHcCAi2n5SPx0YXJawLplIBm5bYJ2kQ37PrdWeEziVueduZDVZk5oCapNlywFiRQ2b9A9ZI+O4e/O2A7Nw0KaGac/ggBhjxEOQU54d9pRnXAfrUjfaUsBv/KXQQ82KGYu4HRfOaPQZobaHCDJb2ShUDCvp88nRVUbifG9bZ3gpimj5QmPRZq5LkHaXTZgfEpc7V79+v6TihJ5G9HMjjHDFfpksUFiXVsjscjUkCh8aL7exEIzZTW4+HsQe3QtCr8jQ2Z3df8fxZwZ/drP4Lu2ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CO1PR11MB4962.namprd11.prod.outlook.com (2603:10b6:303:99::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.21; Mon, 2 Mar 2026 10:26:06 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 10:26:06 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Verma, Vishal
 L" <vishal.l.verma@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Topic: [PATCH v2] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Index: AQHcqi6XsnrexK/sl0+dSWKh02Fmb7WbCZOA
Date: Mon, 2 Mar 2026 10:26:06 +0000
Message-ID: <1e505ca5cc188fea9ad70c9b6aa1478bf25823f1.camel@intel.com>
References: <20260302102226.7459-1-kai.huang@intel.com>
	 <20260302102226.7459-2-kai.huang@intel.com>
In-Reply-To: <20260302102226.7459-2-kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CO1PR11MB4962:EE_
x-ms-office365-filtering-correlation-id: 434928f2-e184-46d1-6ac6-08de78461d22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021;
x-microsoft-antispam-message-info: KjE3r+zCA7qLTeZ16iKqMCmXmz6h2e0Wabr0DwKSpKsaueae2225eMeAsXMhgiMwh3YcSiE9nHgiD87LktUDeSQzCtIeYvfcGOl3gBDBcbg6WFhWcZgIycAJastIaLskK06peapf/OS/NPHqaJeuZ8JSUGWsZY9GLoOVaL4TqC6yaOj5E+PZ3gfZfRtlXblYzAoFwxmz716OPabgJ8cvxGqb80kPxGjHCqZiyMb+eqwMcGrVfEWHeXSPNSpO6aRXMZ/2w417WTyAetlwOJN41e23O4UWTCamtnUR6drUYFsiQV1MNPRSHCUgkBtwjSG5XJpwinI6o6RMxrIH4H+V/9z4fuRDVRWLqwDeFX+LcQxX2ERSMy1Og3o0iOQK9f90v84IRKzsOQPBDrTYC9v2+saJeWv2RzwF6/R+6F1soKCm91akRW3uN3Q8/lruBdfetEo6G9Voh5c/r87fY4EtvIkOVuQyVp316JFXUF7cobZ0BGILqYzeqzsNqsXedXY8UDwhjuBVWmlbr+LG3/Z0Xsy7oBuK1eh60AKeqIyYYmRTFsO0NP4/mVAARfppE+M7Kt2dAj3tVYF5iskzVmoo8tF4N4jVr+ACGmfNM79M9WxRrWRiR/TQPJzB87sCN87CKDW+dREf+M9rWwB7AgG3NJj5ZPW1bWfiapMb4+kJC/HF69q9nV2X9O6iWcWvt+gq2fJXECptFMKsPBtcwiMJTtHSFJQxCfldA7AR6MYZby+tFEpR7Sd5Oxrh5Tr6DXUPXt1++a2Q7Pi7Ji00IZSqurfrq/cYygRhD5V6iPPG/60=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTdGM1hlTjhSTG1velVyOEFLT0l5VU9oSVYvTFJRc0srWXdOMGxqS3RCeGZ5?=
 =?utf-8?B?TWFObEZ6ankwemJueVQ5REZPQ3l0Q3pacUozbVdLeG55b0tSL2xQZDF3NTc0?=
 =?utf-8?B?S1ZBKy9hSUFoTStsTnA0eVZIMUxLQTAyTDhETDdHandHUlp1MGtNWFpWNzZL?=
 =?utf-8?B?TWJmWG82NGN4QXFreUtWUitnaU5ic1Q3bzNuYWlZNWlPQVo2K0NkNjVsVURX?=
 =?utf-8?B?TGY2SjJDanpybUpwdFYybUVGWHpaSkVxend0UE1OTTZDbmtVM3djYXl6NzMr?=
 =?utf-8?B?UFcxbTdLZ3NRMXhZek5tTVhRNllObUMyanM2Zk9XeGo4RXJrRzdRQmE0WVhJ?=
 =?utf-8?B?QnJISVZ0TEw2eGcrc1lvNVNEdHljdktuYU1ZM0lweGxFWTVtelNyd1RMZitW?=
 =?utf-8?B?SnBoakxqeHp4Y1FhZ1BucWhheWtBZjc1UUxMck1haXRwMVdNcjByNWVWaCth?=
 =?utf-8?B?RStFQ2V0RjdxaVozNXNINVdGeitPRWk3U29EWlNWaVl1QmszK3ZLaWVZL0sz?=
 =?utf-8?B?SVZQMk0xUzJtOHErZDhJSUhFVmkxYldUTW5GV3dydk1jQitnTVdFaHBaeWZB?=
 =?utf-8?B?cWtCZVNvWU5LRWdZTGVxM2dVdmZMcGpOYVBnd0lzT2tLSlFnaHd0TTRCME1h?=
 =?utf-8?B?dDMvcHJnTnQwdC90d0RVM00xekJGM2U3QU5BQjZhb2tZZE1ySjhCRXNZRlpM?=
 =?utf-8?B?NXlDTmI1N2R3L1BTVzVUd3FyOHJlV1dwTTloQkVsVlZuWHlkNGlieFNBUGE0?=
 =?utf-8?B?VHIxbUx6NWhGdVJhNC95RTRFNGk2amFNSlVoVmErQVJ3WmVoK0pSZFh5dEd1?=
 =?utf-8?B?eklESXJ0RGxwUjVsSUJjR0Q5WFlmQmRoTDRyTVZJRG9QNy8yWndJUml3a1ZG?=
 =?utf-8?B?T1E3ODVhT1JiUkNhTkJzZ1ByVWJCUlFBRzEwZHVGS3N5WHdoa0lNSHNVeklj?=
 =?utf-8?B?aEtYQnRMTWNxei9GOHdCaEJhTzV2VzFRa0w5ekhYdzhqcFRMMkZhNVNmMWFF?=
 =?utf-8?B?L2h1TVlNRlFsV1MvSUd5ckhzRk5YNEJSVTNMTzl4UFg1b3h0T3pLckN5bFBq?=
 =?utf-8?B?RVc0STh5QWZrcW82UldFcE4xZEs3bWFBNjBMVVJmd1d1ZXBXRUJsV3hReTZB?=
 =?utf-8?B?WkZXRVdRS1hBM2ZzTVhzKzhMaFhSQ1diNU9lL1pmYTdCcmo1dXF3UlMweEZi?=
 =?utf-8?B?clB5U0xWcGtjbGp4Qi93bGUzcjVxT0xXaGd5WEI3SEk4SThBeTZjd1ZlRVoy?=
 =?utf-8?B?RDBRelErRlVkNWFqR0t3TE5SbmZtdzN0dEJwcGFwYmVsbFVwRzYyS0JJVTRT?=
 =?utf-8?B?bDIrbFR1SWV6aDYrSE1RNEE1enU0NmpldktELy82WjJodHNoT2tXamxzdU5Y?=
 =?utf-8?B?bTl3OVhFZXhlS0NGQTRuUzRYREV5VVpRQ2xvNCtIbEJCOEozVUNNcUFoUlFm?=
 =?utf-8?B?elJaVkdzcEZlbzU3S3IrUUhxN2xGc1hsSlB3dStEUlExSjY3enlRU1pDdmRz?=
 =?utf-8?B?VFVGVW1pR3U5eDRXaVNMWWphN2V5dm5VeGhRTlVlcE1WRERkMm1VUDdHTkMr?=
 =?utf-8?B?NHg1cjVFRE1aSWI5Ny9yVEdhc0hvSDNsNkNVelVhZERZTHVDdnljZ01xNzhD?=
 =?utf-8?B?dW5TMk9XU1lCRXR0YmRPeVZKSkpZb1dXL2tTbFA4d3p4MnJJRzBuQzdTb3o1?=
 =?utf-8?B?U0Z5NnBUWWlwSUt2NE0xdnI5UUFyZ2lVNEFJc3NQTmpxNXNiYkRjUzhZaFk1?=
 =?utf-8?B?aTk4SGVBRlR0dmZZRkNjVXdBYzR0am5Eb2pSLzI3VlUxY0RmblRac2J6SlFu?=
 =?utf-8?B?NHVqckVva1dnTWlubnB6dFU5d2tZYXh1ZWxMbjJmV3VtbzY3cGZiaWsvLzAr?=
 =?utf-8?B?U0Y3Uy8rNlBLZm04dmk2MnBROE1TSGYvWmVyQXVwVk5BR1c5c1JhLzlQVzVK?=
 =?utf-8?B?VURRRXBTcUNuSHlQZkVDelpXc2hrS1F4QjlkQ1IyYWMvMGN6czh5UFNIZGVr?=
 =?utf-8?B?Y3lBdlBPd0k2a0paYnFzZ3l2QXc3cDlhOHV5cGcvYStlMUZha2lvSTlFN2lt?=
 =?utf-8?B?ZlhucUtZeXlwNkNneWwvOHdDdEFYbHY2MjdEaTkvZWQ3d1BxbWNFcDhLdEI0?=
 =?utf-8?B?K2pOeUZLV2hHRCtLSTRPOUdMZk0rME1nZDVtamZMK2dLdU5XcW5QUnlnTFVt?=
 =?utf-8?B?alhkYmV5ZzArMnlLM3pUM0NZMFBmZldzV2MydnZhT3d0MUloN2s2MzAveHNM?=
 =?utf-8?B?alJDWk1zUXJTTzZkWjEvQnRHaWFXcVBFWW9SMWplbVJQUXdiSGVqYTdCZ3p2?=
 =?utf-8?B?d0c0bEhKbmtkVVpTYkZlWXN0QzJiU2JpUlAwN0kvdUd1Z0dHMkFIUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A80C0A278893548902F2C526D33B860@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434928f2-e184-46d1-6ac6-08de78461d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 10:26:06.4958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9iPo9USG/P/XqPswrEmSxGXk3gZkIInBb3ojHPVTd/sy58/kUjhxDp0jyZrhEjSJ16IYhp/8/Hc45W+46CHYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4962
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222569-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 675AA1D6914
X-Rspamd-Action: no action

PiANCj4gdjEgLT4gdjI6DQo+ICAgLSBJbXByb3ZlIGNoYW5nZWxvZyBhcyBkaXNjdXNzZWQgaW4g
djEuDQo+IA0KDQpBcG9sb2dpemUsIHRoaXMgaXMgdGhlIGludGVybmFsIHZlcnNpb24gdGhhdCBJ
IGZvcmdvdCB0byBkZWxldGUgZnJvbSBteQ0KdHJlZSwgYW5kIHdhcyBzZW50IG91dCBieSBhY2Np
ZGVudC4NCg0KUGxlYXNlIGlnbm9yZSB0aGlzLg0K

