Return-Path: <stable+bounces-72964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A95196B21D
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 08:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF09CB20BF7
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 06:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23317145A05;
	Wed,  4 Sep 2024 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IiP7EYV5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA64DA13;
	Wed,  4 Sep 2024 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432559; cv=fail; b=ofXpX2xzeu9ngVyQeA23zc+bSNVtqY/c3vLKSTd0ZpRFf7rABQ9aETw32OI7ZxN6B8WFkKIIcsXnOYm3b4bXr576AV/C9VUOceVBhXVI8zfivsG+qpaSmTpi3vE7H+lwOaPLFOLwo8bpkAylAAXwLqKdsMSyN4DCN4Rwe18qRQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432559; c=relaxed/simple;
	bh=b74U4FBj0Cr5CuPjopisTolmdX3iWV8r/WmZuHAtKA4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J0EFewTb9dXVfmhNuTa/WSMWMEABDy2iKwCMM3x3zgIQOEgDnBujvT+SCdVmreXWirwfwtDXGn/+S71QRnTi1wnPIQ/Vklu563wpEZXx3De15qQPkovhe5n4Dmg2+aITvHUGMH7POoAyIzSKSPnzeSlrwT6OhOIbZa40xB+CiVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IiP7EYV5; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725432558; x=1756968558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b74U4FBj0Cr5CuPjopisTolmdX3iWV8r/WmZuHAtKA4=;
  b=IiP7EYV5DRKGBpyUwytNCG6KA+kBBMGntpXERvJE2/ZtUloaQf1PK7Wh
   Fo7CB+D5/rss61b/E0o9gJkDh2fpQoxvTNaYlPE44EEUJLc+M/UKnheYD
   P0QKhOYrNGGVfDZzivlu4n81DYtgslbqCPlz7PzeaOmlJZF2SZlCdWvM6
   fH6JzumwhuvQn2G2PPOxE0aKXKSJyLX5ASRpvhJf2kGib2RjOQz4oZA34
   sRn/TAk/LLsl4muYIH7Z5yfI1R4AlFhzgNdi/lW8gtC3lh0qYUnis1YbD
   72Qqrp9FnvwsH45TD3gFtJSRGzuw4jsKN5eV99ZcjMhJVrHkI1ao8hNar
   g==;
X-CSE-ConnectionGUID: o266Bs49TiyeSJ8v/dNshA==
X-CSE-MsgGUID: b+kCTu97SzuhS60GM4SowA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="49474010"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="49474010"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 23:49:17 -0700
X-CSE-ConnectionGUID: Lni35bWdToecMFnoqYMQPw==
X-CSE-MsgGUID: 2f+ELcDzRo+MDHtJaGxX+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="64846571"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 23:49:17 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 23:49:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 23:49:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 23:49:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDjAqxm0UqCyaymibXIIrJExbfyvP9Sr0GU70P9UM+QMP/CNT/mhLS4plPwup7Czeq7DF2o/3Gecw1vF2o/NI3SIMgEM4//Pg6VIPo/g1UUnJ8vlaLKXKij6tFTtzNzHHpWZxypTsW+RyeYgy44VL73fGohiHItShxl+RL42bBxh0Su56aCC7l+6oPn9JjeO/qXQl9D7Rb4K1UuNxOvOw9yd/6eBxk4lrQ1+WLg5AEGBvssfQo9qmMa2yyErNtmdvAjq+8G3xJ3XdjF7Pi+pCpoZOIQyFkRfg5O/u1I4qdKMkpp1aPxo2swBKWgaBx2GPgEHT4Ed5gYWwOq9WBmq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b74U4FBj0Cr5CuPjopisTolmdX3iWV8r/WmZuHAtKA4=;
 b=QjuFyMu/IonfeSkAQt1fGATov4RQGzRj2jGgKiD55KJIBej+Cw/c6TOLI6ooghYdtH48RuPC9lY+0Baxv/F6+v2BMJHcgG6P9iI7PnOGZgXMv16QG7YiVtxm764UWjDaW2/MaW+ba322ao0IAhqENqJ00ZKiPzYGZ8xDHLdnop+OZD4y3vgVZNVzzYvYxGKf668HnQvBHAD/BW/kZzL8UZRsC+wzcpVLbjMbxnUg67VlMRCCizO4hH2CqrJ2zYSxOajMpv8AYkBgVl2iULKP6C6uWUaXH3edfsqMJS/H1Ieo1Pv2UFtp0KeUqYwF1PRPjlPnA5dGtsepKIHMDog/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6689.namprd11.prod.outlook.com (2603:10b6:303:1e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 06:49:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 06:49:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: "Saarinen, Jani" <jani.saarinen@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Prevent boot failure with devices
 requiring ATS
Thread-Topic: [PATCH 1/1] iommu/vt-d: Prevent boot failure with devices
 requiring ATS
Thread-Index: AQHa/pE/SLFuiOczDEmMh4cqZcgkZrJHK0KQ
Date: Wed, 4 Sep 2024 06:49:11 +0000
Message-ID: <BN9PR11MB5276428A5462738F89190A5A8C9C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240904060705.90452-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240904060705.90452-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6689:EE_
x-ms-office365-filtering-correlation-id: 2c036786-6e77-4975-166a-08dcccadaeba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?pad8Cit/hXN3xUa8/f1NaSBRDVG+D/I0+46GlmyOdHURMUUWylFoWVuleUqp?=
 =?us-ascii?Q?blSil4RpcLSDTeNIHvrkMmkznwk2NBk+BDcs3uZ6aSnUdzVuB+wvn8KlpEmR?=
 =?us-ascii?Q?4Az+ZZdnn6nsdByHOOZTYDZUYJu6evMb5dx1A36mEGbWdIXH7wVOtPbMWzXF?=
 =?us-ascii?Q?OXrWEj4ivK0MSQWDt8rEaEIF2W/Q2njtAbcMHOaJYlOYLyIxiE1Unx5OLIOW?=
 =?us-ascii?Q?sqRLHR/e8ppSKUXQbMJBuEIeiFTV2edDu1fKpBBkVzWb3tTwJtmj5g3ZhC+U?=
 =?us-ascii?Q?jIIVX8/OeVTSAvosAr5Yu1LPDSsAj70FNtvgv/3T244CRgpakcYqP4RMo2he?=
 =?us-ascii?Q?kEypQu+GF2rRuWE/Kbz+gd3OP72A4dirVsP2eN++uc5ksp1D0/VlaxGrn8qt?=
 =?us-ascii?Q?3FGrEwIkCl+3MbLm0dJtvYEKN9B0PAg0936XiYIJ2JFBCPZHbMrKrZcAyQ67?=
 =?us-ascii?Q?sV5gt11W0OMpriZbn1w0erKEUhbhi2L9ubEoHq6o5O2WQPDVml9op3xemWaI?=
 =?us-ascii?Q?Mzr2fjSi9dy99tbu98L8/CYaDL8FNHCHXsv63eVe7XVGzC69nSwOSsID2QaK?=
 =?us-ascii?Q?484CM4Lmx5ojQbWEHfpxH0KZ+YH7Rd0dihuki+q/VgQP5laKAgPiqyBGf32I?=
 =?us-ascii?Q?tUGUYTUWr6AFSLfMUEYjaKlWQUIYLfHExGSp4p17xLwoCAZ7KZE9c8ZGUDf3?=
 =?us-ascii?Q?W4H8lYb+PkZALxEO4ST9hHrRikLuj8grRTmhueYF7yeufYQVxWFvTyHOHvoV?=
 =?us-ascii?Q?HBPZfOwWoihY+joDCboO+f/rjqmx0Oy0kraNjP0Uv7QzW7UrAc0wMAwZTk01?=
 =?us-ascii?Q?9C5sl80em/gUwKOF/lE7LcBUMZzf+uBlRn7ahTdjLQGtyEaLbZbQxR59yJXU?=
 =?us-ascii?Q?lFkn9T751cXgge3hO57ZJaAgVnY2wlJ/Jkb3K5gMH5uywMGu72S+w5M4Vg3x?=
 =?us-ascii?Q?eXt7qw7qUefGccVVjn0HY5ZT6XqhzxZa8KsWeR+z5tdQKEjsnFHvPmSAokr2?=
 =?us-ascii?Q?WFHEZpBSIxDiWxM/FITZo+Qco4Naml54qznNAJAMsA5kE3wxZ/ihYaWkIX2k?=
 =?us-ascii?Q?UHxVqW21O2K5M0IZCIMQyjksh2FSYGLUVXcg5u6aUuh2cpk3zM2888wYCyhN?=
 =?us-ascii?Q?J8KiMUqVN8hpsT4sfHeFha+TPR8FrGtun2ypGZRUBhf0hVinr2wdGNSB2uuJ?=
 =?us-ascii?Q?lF5sCpbxgldwhdmNTmAZfEV+JzpzqR4mBPCO3S9FKD9cGbhuk7Q7DCkgtgBT?=
 =?us-ascii?Q?0J/yTLe//SzxrteGCH121Ms3MAMMkB4Tnwa8QyLihfu/RbPPkdSIjEa0UhYI?=
 =?us-ascii?Q?DKBMuDKdRHzdKY1ech0a9YTspQ0xPLkvhtvYqI+zgIzT4F3AHAuoePfGXePz?=
 =?us-ascii?Q?vLEd7ien6NvuhGIjrltA7ct6CKGON9qNpZ4WMEq7oXjnUDzKFg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aYwniJi7yifFj25m+lZHA0edsh970Fxo+v7r1oz5/43ZA+Xcp+OF9ThsNw24?=
 =?us-ascii?Q?AA8nwEBugsyPyoXZHkpBv2GyGFGWKFrAd5qdbbAFMCml0GYFkfkQnCxKw4Fa?=
 =?us-ascii?Q?7/TVoW8prSTPSLlJO5PD57KkrTK+8/qUK3vhG5P3m+gkbwblWFsfEa2QAaV7?=
 =?us-ascii?Q?zqhpiVEtwy+xCUG6EB+egcriL5PXVeuI3kKha5UfI5QW4YD2dn4jRQ+Dblbr?=
 =?us-ascii?Q?C0hBeN5I06w0HdFgxOhwsrITz8TnCrc1+pHXJZ7cjgAB/fUy6wq2iIBytWCE?=
 =?us-ascii?Q?QLTdYkCpLMUyaMC1HwTHERPGOdZ0fCeWACkHwCdddU2dVJ7oePyoAXR4a7/8?=
 =?us-ascii?Q?RbPBS82UJ+KrmzTvqytj5CntaWNdtjon7eu1xqbCZXGbYeK6XB38tqXAwcnC?=
 =?us-ascii?Q?QWCNMWd61UK6Sf7B7NBR4Vi3h0CPfTA1XkW273OkohpAZojPFaS9FU84UeTQ?=
 =?us-ascii?Q?bNAqUcul0APPcOL4nOSKDgRXP11cRKo/GcWMK4JjWN72zL0aTtL9yF0MpQXy?=
 =?us-ascii?Q?HWUQxY+1rKMh3nunqTcnyHe4eBme7LE/lGgXQvr85V2I8naFGQPF6J5n/bqA?=
 =?us-ascii?Q?KC9FWCGRzWYBHGICcRRSGBVzT/pMZP66VOP4FQaPkGIaQTnJLEM1ariA4bme?=
 =?us-ascii?Q?CPz18OtWqDDry5dGyvjjxxYKRMT6o3JdFKMTsyNXXEk39/0lQG21+EpaSz4r?=
 =?us-ascii?Q?8xwJelXTYQxwd4ElZAph3BxNFkrcvfYDiS0vce6qz+/mH7jotK0QPvgAtDk1?=
 =?us-ascii?Q?SCydpt9L5TtrjCa6Mwnl6HBJzXwx5bdYLcmuJqBkGQvPFTJ6HLk9zMBKwXun?=
 =?us-ascii?Q?v2Gvgt3T3GXwgMgCUZdOvmGZp8Meoi17a+T6yZqjSIuEmqkmj9e+np3tclaw?=
 =?us-ascii?Q?vYkZh2WDMv43qmoQeQhPAegI9oRodJISeZMZUtUwkDJNKujhv1/r3H16+6ax?=
 =?us-ascii?Q?gbP/6ZNezpR7sLCxG+aFWzThDIIu0R2ix8Nu7EylBPxFkR8JmoVdCuSwTnKW?=
 =?us-ascii?Q?AhgHjedOJXSnGAD/y1OeXZcyHi2/tVSoqKf/LuxyEIEUzPvPON98YQO3UC1f?=
 =?us-ascii?Q?LrWm/98s7cMcPRTmrMkPvcle6XYdpUoxPIdEhIjIHcyMOW2tDwMS/qdcGM5l?=
 =?us-ascii?Q?KGjQyODkcTNMtXDrHWZ2GV638Rsus6FtEAUJ/+WCfFCPJL2DLn8VvT4M1FH6?=
 =?us-ascii?Q?/5fpajrUyLem8SvZqMK6x54K4yRYb1OvTxEru8aL5iwtvQArhIGSiErb8mYi?=
 =?us-ascii?Q?R82aVUpzga6f+4wIf9SphPpRBpk3LEBKU49iVBGn3wiN4H67D+UU+3NE7rrr?=
 =?us-ascii?Q?9efAh75BJFilhLErU9DamhBjjx3XL5PYHYoKKT4KRFN3WOcHEFbNhuVAoJCv?=
 =?us-ascii?Q?iSqL98KcRtn+C3UK4enZ4Q7mYEolIRBCogt29xfs1JH4O82Q3y0ddCHC9fPg?=
 =?us-ascii?Q?HjlxUHsA1ajx+smP/4kBG0Q+Z1jdp7XrqtmMus0EtrBgb7ZsIDL/5+p6dBJ+?=
 =?us-ascii?Q?j9pzlOom0l418w12xbhkYI0XQIBaW+5QNUNGgRv66ASbwodg4nBUA8r4qd5N?=
 =?us-ascii?Q?oFcfoLcw0aY0nDQT7Boxo+On0sGwg3A/lTzU+7HQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c036786-6e77-4975-166a-08dcccadaeba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 06:49:11.2354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sS7Xz55xctcopzcT5IMJvFtmrmGGolZwhMrO3/6WxvtrBs3B5gLnamFxl9WyCKJYr4C4DImyyJaVI1+s8sGkAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6689
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, September 4, 2024 2:07 PM
>=20
> SOC-integrated devices on some platforms require their PCI ATS enabled
> for operation when the IOMMU is in scalable mode. Those devices are
> reported via ACPI/SATC table with the ATC_REQUIRED bit set in the Flags
> field.
>=20
> The PCI subsystem offers the 'pci=3Dnoats' kernel command to disable PCI
> ATS on all devices. Using 'pci=3Dnoat' with devices that require PCI ATS
> can cause a conflict, leading to boot failure, especially if the device
> is a graphics device.
>=20
> To prevent this issue, check PCI ATS support before enumerating the IOMMU
> devices. If any device requires PCI ATS, but PCI ATS is disabled by
> 'pci=3Dnoats', switch the IOMMU to operate in legacy mode to ensure
> successful booting.

I guess the reason of switching to legacy mode is because the platform
automatically enables ATS in this mode, as the comment says in
dmar_ats_supported(). This should be explained otherwise it's unclear
why switching the mode can make ATS working for those devices.

But then doesn't it break the meaning of 'pci=3Dnoats' which means=20
disabling ATS physically? It's described as "do not use PCIe ATS and
IOMMU device IOTLB" in kernel doc, which is not equivalent to
"leave PCIe ATS to be managed by HW".

and why would one want to use 'pci=3Dnoats' on a platform which
requires ats?


