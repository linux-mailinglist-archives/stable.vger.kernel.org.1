Return-Path: <stable+bounces-110315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEC0A1A940
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892E8168732
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 17:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452E6153BFC;
	Thu, 23 Jan 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxSpJbjE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC22156861
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654667; cv=fail; b=d3aTKXN2R7olEQz2IBEc3/r9lVuUiF4IQJm5mi3t9b5pZDa5ATRJIaTIfhgwL//yS84turvhPUSNlZpJeMX2JnOmrgB+qwR0LRufWvWmZSDTFMdFkPy4EUwo26F8T8OSmDvoi+3sh8oQJMM12uXVtSpXA62Ain72KJXK5+mQeis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654667; c=relaxed/simple;
	bh=jM2TD4cpFR85ytkYdqvUPoUMprFqDcRn1XOimBxIFPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QkI4t1JzHsIRIeJkJ3p3rKW/u3o5XUzatN6Al9tpYR/56FDMabBecXB+y2UCsCwndcKUPumywl32sDF7GAlJaKESQVoIBkVO7gA2IL2c0O1i7wydP0IuVE0eW/4IlCjQDHD+lKpMDEh7E+w7ErOpPMheLiFxI3kEaB9QkLAV2zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CxSpJbjE; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737654665; x=1769190665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jM2TD4cpFR85ytkYdqvUPoUMprFqDcRn1XOimBxIFPc=;
  b=CxSpJbjE9wHDwGryZZFr978xawqbmI1WsQ/L6otiZbXH6vOxZXCaXj1u
   omw6PLfdxY2QT/fdK53Mdce0tfnA00bj98pssSEVfm1TRA4RxZi76aBkl
   U19vbmc05nFqpgykMNGqvDSRw2Fwng3XCQ9iZ6kNwi4xV4tgofce10Omj
   AI/EOaG4LYDBFqy/w+G1grsylUVnBCWfTXn+VID3Lpd1n8pnnHcf09cQE
   6GbopOBhdAw32OWCK6Q41htaaYNymPgNCSiPetUUkuZaVq9ifp5TEJbgI
   YYs3O7zynK0Z/Uth3d7rhpIXtItPr93eECmmyWd3AX9xJk4k8vFkp/knV
   A==;
X-CSE-ConnectionGUID: skrNA420SOuWn8u0GIKkFg==
X-CSE-MsgGUID: fmPbnkCPRzKBODAkz370Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="25773592"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="25773592"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 09:51:04 -0800
X-CSE-ConnectionGUID: cTZd1uHxQDmjlSytrHYpxA==
X-CSE-MsgGUID: oEUBBODVTFWDfp9QJFG1Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108406663"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 09:51:03 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 09:51:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 09:51:03 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 09:51:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUS1CalI45PBqT93nGcK3efBq5uN/rEOSNFcr81YovL6MtCjR+hMCRGkO1kY21ZAI/5gCK35lBeCrRp8l7hAdOrLd9G6J23fBz0WqQnwakIFUP+wtMASOIcHPTEWbDYmX1ZPEa0wrEa9OBYIOzhr4s+oFmDsnvlfgLoYlZGmfa12UqACouFcECtnl4sPTPXsYFDhkw0Pw2k3+OIFs5cRSRg+auRh+of8eqoNgQ2krE0WdQdf1J41djD6ip3h9gZjEeNlQR2CN1qlZdY+vnYpwzTplOHKAjWRudJAy9vIs3Hhjyg0vK20wXhPI3nDEAqQDUSS2Ew4zBLnVZQPxrawDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jM2TD4cpFR85ytkYdqvUPoUMprFqDcRn1XOimBxIFPc=;
 b=EihrqKhak68Hq3EyGjetFn9RJiAVVTjbzvB+MAsqHLtT/XNvsNdPf9DHIJK3QWnHjwSqUzy8pmZ2nyStaxgsDdGPNzsn4rk2w5ZecRAylbNPo/agjuWy3skMPs5sk4+YEEbdHMFb2mzV0W2t7+D62896iamnTRdYS4FHFiVikHlPMpG8OjyU3MBsq+i4GPx1umKTF1Uz60jIg2ykeYHtKO8aPVHYMtvBhp1RhEoYBBYrDy5Ks3QUTzkLyMjpfWlsGZCbUEIM9XL0/LkENM7oqGLj4Zo7WOC6nPz7h9mh7rU3yTHRhzloIat8Xp8PbZReqd6j30ttz57zEGhy7Cv5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by SA1PR11MB7697.namprd11.prod.outlook.com (2603:10b6:806:33a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Thu, 23 Jan
 2025 17:51:01 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::f5c2:eb59:d98c:e8ba]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::f5c2:eb59:d98c:e8ba%5]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 17:51:01 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "De
 Marchi, Lucas" <lucas.demarchi@intel.com>
CC: "Harrison, John C" <john.c.harrison@intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Filipchuk, Julia" <julia.filipchuk@intel.com>
Subject: Re: [PATCH 2/2] drm/xe: Fix and re-enable xe_print_blob_ascii85()
Thread-Topic: [PATCH 2/2] drm/xe: Fix and re-enable xe_print_blob_ascii85()
Thread-Index: AQHbbVVORikimYJOzEqaTvy0CrIj/bMkpAwA
Date: Thu, 23 Jan 2025 17:51:00 +0000
Message-ID: <61cab659f30c947a28ad7de239fb9ea5ec2e174a.camel@intel.com>
References: <20250123051112.1938193-1-lucas.demarchi@intel.com>
	 <20250123051112.1938193-3-lucas.demarchi@intel.com>
In-Reply-To: <20250123051112.1938193-3-lucas.demarchi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|SA1PR11MB7697:EE_
x-ms-office365-filtering-correlation-id: d1d7b6d4-f8bc-4496-8bca-08dd3bd67fc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bmJYR2t5cXplMjVpa1pQbFZQNUIwTUdhTkY3M3lzWWlXMUVWY0lDeFJ6Skh0?=
 =?utf-8?B?QjdKbkROMEhyWWREZmVzNDgwQnFycHZrVXllUjR5MUV5RVRrNHFxMnBPaFBJ?=
 =?utf-8?B?bTNDZkZLZkNia0MvVkpqMDBrNDhiVnBCWExpWEt0ck9iYzczOUFUVHRodVlj?=
 =?utf-8?B?QjRGbk5MeDVoNlJnTW1vOURCTFM4VHM0Wmp0VDZQd09QZmZnZ3VTR0RPSFht?=
 =?utf-8?B?ZWtiVnNNWExBRHYxZlRhQXRvb1lWTDZiS3hyMGlNTG5oWWZCVkpuUEdRcEtk?=
 =?utf-8?B?bmh4R2liS0piRXVTekJjaUE5d1ZlejZRVlNocmlsOW1kZDlHR0s5eGZ5cC8v?=
 =?utf-8?B?TW9lbDNXbUJIbTI2Zm1UQnZYMUhkNEFqSUMvZTE0N2t6ZU9WNnlBREtlSDBO?=
 =?utf-8?B?b2lFNDNTTW80MTZOQUdZNHNTTDNkbVc3SjdiYlVJZnZQbENDRDU0dk5zTWRh?=
 =?utf-8?B?ME03b1BXeG4yeXNyNUFxc3hFMEFvdWtWVFVWSWp3UVp3UWt0dHdac0VFS3V4?=
 =?utf-8?B?SXJqeHRUMGplY3lQRG9qYUt6TUxSaWxEV3lOcWUwU1FQWndHbGd2YUI5VGll?=
 =?utf-8?B?QlFmQ2J0eUErNGxFK1hGcnpTTGM2bEczU21uays5UkpPVnFuTVdqbzBFNDBt?=
 =?utf-8?B?UDgxUTBUVnRPRHhUNkVsR2c0U2locW02Z0tYcFdraCtmN1lXVldveGN3cnlO?=
 =?utf-8?B?Ynh0bXVQbU5TN2dxeVAxWlR2d0lJZG8vWlpCZkhzZnczRHMzc1FzZENXeXBP?=
 =?utf-8?B?VGxvY0IvZ1R2bkFvS3EyWEliWldWVnZhNjM4ckkxNVR3bTdHb2I3VmRUM2Jl?=
 =?utf-8?B?bXFoTDlFVUNRRVdUc3c1OURvSDUrSEdNN2djdmhIVnV4aWtKbHZwUnh0MzBK?=
 =?utf-8?B?K3hrOWhuMGkxRGJoWnVnSkhqTFQxdGk4ZStqMGREMDJlTlpHbGZFOEFWLzha?=
 =?utf-8?B?clBBZnFQR0FMZkZwMDF4c2QvZzVxMEpabWtKOExraVdadXdjZi9VRytjT0RS?=
 =?utf-8?B?eGFNVUsxL2tIbEhpT3lTck8ralpsM0xsQzNtTHdVUnZKR1RsdmpRL1N0UEVv?=
 =?utf-8?B?alNJcUpPYXNIUTRzUEpWdDBnRlhSSlhlMit3bkRGaDZ5SVZHZUdQZ1p3TGhV?=
 =?utf-8?B?TUJpdWE0eHY4Y0pONkhnc2tFSWhEVHovT0ZSZ0s4dmR2dFM5WmE1Q3d6N2RH?=
 =?utf-8?B?QnpjYkk0TnB1UDNTSXZPRksxRTVsMjFKN3NHeko1NGNsc1R2NDV6STFRb3Nv?=
 =?utf-8?B?N3NlVnBXWXdBL0JuY3M3ZmVBZUlzaVhwYVo1N1N4TmtKUkp0MlU1M25xMk12?=
 =?utf-8?B?QWVFSy9wY3JEaDkzWXpxM1ZvV01BMHhJZ1hoU3BLZ01FNmVqenFicXowZzdD?=
 =?utf-8?B?SWtqMUJUWjM1M3pTTm1PckdVOVFpV2htaU1GRWNLeXB2c2p5bUo0NjRzdm5k?=
 =?utf-8?B?R0FmNlpzTkhGQzc0a0oyRC9xUUxmOGwwVmVNZjhNdnl5d0xwOTNyeHRRMnVP?=
 =?utf-8?B?bmFDUE5DYU1mdkRuMFBzNm9qU2NmZnVDRWh4Mm42VkNGK0ZJVFhsUmhaSFl4?=
 =?utf-8?B?VXRxRDlNa01waGlGcmtTYnMvL1JaV2E5L2o5MkFWN0tRWW9iWkthaUQ5T2sv?=
 =?utf-8?B?RW1KTktpT1B4Z205Y3F6cnlhV1VTWEdVeHFtNms2TnljQUZDZHRzZm1HOGVS?=
 =?utf-8?B?a3Q2ZGhwWHFPdjNiVkJEOEdhaUltMjc1cXdIRlBxczBUMVZpRkZaZmdKRXlj?=
 =?utf-8?B?aGtOamtVVWFKV041alBLQXQ1a29GMW5ESGUzSTV1S0dXdXpJWC9qeFNCR0xq?=
 =?utf-8?B?Qkp6SjNrTnhkSG1zTjgzd2NKSkVkNU83b3N2dHVjdEVGcEZHTTJYSFhnTVlO?=
 =?utf-8?B?bDNpL0huaVZMMkhZUUJzcWd5N3RzRURyd1RwcHVvVVpKdFgvbjIwZ254dk9j?=
 =?utf-8?Q?xoesKn/WNFKCRIL+6MeWyI4IXwgScEpl?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXRxdmFrMnZ3Sy9YdWFGWDNwTWd0UUNoVGZsMVpoMWJDNzh3MU5xa0NxRHdk?=
 =?utf-8?B?TU9LU2ROSjNjTXBCWUNHSFFET200aUIvMDViTCsvcDFReExiK1JEK000eVlP?=
 =?utf-8?B?YVozVmJFbWxzbVhDS1V3TER3QWg1YlUxTU12SFIwZGN6Y2Rpb0JiVTlSNDlw?=
 =?utf-8?B?VDd6VG1MTkxPdy9xWkU4UWxESEZxZUpQK3VnanBKcVBBWFUzeEpmbmRWUVlC?=
 =?utf-8?B?Vm5BS1BTdVE5WjM2WEpybVBrdjJ1L0d6bFlwaS9EU3VZN1B1STRvMmFQajhN?=
 =?utf-8?B?eG5qSEhZM3VVdVUwdmpvZkp3ZTI1aGc2dUgxcENYT29haUZWN0xkN1Y1TGVJ?=
 =?utf-8?B?RFdnLzZIclAwd2pMQm5VNEh2RGdLbkgxbUl3TGRkbGtxTUtRT2pNcTc4TWto?=
 =?utf-8?B?ZWYwNnUydENZaUJaNWJrOGw1TC9Rb09DamZIQnU3VUlQY0VtUlJ5WTZuUmJn?=
 =?utf-8?B?VllPdVZNMTFEc2U4MFhIcEFzczlzSTkra0FLWDhIeGdNOW14djFiN0JzZEY2?=
 =?utf-8?B?MFgrMHNkNmxMV1kzcjlpZWdKZXdJdWhUb0U5Y3pVakMrTlBQQ3pHN0w1S0NR?=
 =?utf-8?B?bjc0aFlSTS9BWXk5RSt4OXQrQkF5K0hQeHdUMzgrOVpiM2tXZmh2eW5DRDlD?=
 =?utf-8?B?Mi9vblByeU9abm9vUkkra0ZPaEgzSEJTQlhtVGt1RXcrc1oyNU1DbEtENkpR?=
 =?utf-8?B?eW0yT2ZRcGhJK3VRTC9GSDUxSnJmaDBDUEtWcFR1N3FKOFRZMUg5R0U5TXNv?=
 =?utf-8?B?RWN1V3JNMi9BRjZTaStuSEwycHlkWlFzQVNqb3JsaFVpWDAzUVFWUHFrL3kv?=
 =?utf-8?B?aWQvUW9GN0c2MW5GR1NmdFhFcjljTmdJelhpektyMWJvRjNwaERxUjNJL2Zp?=
 =?utf-8?B?Y1JjUFEwdG55Q0I3V3ZOTW9peUo1enJXTEZCYWhTVjNZWVMrdmU4VEUvR3h5?=
 =?utf-8?B?Q0x1N3FLcDQ3cndXckRPZTYrdkI3eUlrYzkzS2VDTEtHRDBDdEdUaUNXSm5x?=
 =?utf-8?B?ZlBaVkhsL3QzeUtOU2ZOYURNQUxwbWQrSDlvdkhydkE5T3VFdmpSSWNKTzZ5?=
 =?utf-8?B?Q3BPOWxMMWxiR3hTbUhRZGtDOHhrVEMyMmNOdkY5cCt5TDlEenoyV3dRWGhM?=
 =?utf-8?B?dVRaWEFxSVBiLzhObk9WSUY1ZFk3a0lORURyTWhNWW9ldy9YK3VCN0NaQ3Y3?=
 =?utf-8?B?Sm1OUFg3M3ZXcXlodEo2VENnZnkwK1Q4MGh5b0VneWxrTUkvL3RXNWlOclhn?=
 =?utf-8?B?RER6R1pYeENJMWV0aWxQa1JuQ3BzVzFpVW9JTnZBQjZEVk0wb0dydUM5VEVx?=
 =?utf-8?B?TWU4bnBzTUdlZThJVE9OU2dzVmVWU3RDcWpReU55MUwwcXZlRGlRdWt2SjNC?=
 =?utf-8?B?ZDFnTFVyblY4eHdYNEU1OTBRdmltd3kxOXpncDVPRTA5VkFmQVQwNlNYTGJh?=
 =?utf-8?B?R05iT2lCalUwRlpWL1JSVDN6cGE1QnRjdGgyVDdPSUlHQmNnUmlyWUYrVHJm?=
 =?utf-8?B?eWtrOXRMRnpEaituZS9nZ0ZVQVNLa2pBOFJERm1TOTMzS3Q2YU53REdhQlhN?=
 =?utf-8?B?dERiUjdzQ0t3YVk0MEViaVhXS2pEY2NGaVJ2WDJRNnBwL2YwWFZJRlVBVllK?=
 =?utf-8?B?WUJUbUZxbXBXTlRQTjBFZ051Qk1DWE1DOVFlWUUrdy8xNnhHUUtwVjZlaGhO?=
 =?utf-8?B?QXJLdDJ1bzlLTUNRZGxTQjU2U0ViNUJ3L3B4djl4MzltbDNvd3BKNHBQajJD?=
 =?utf-8?B?Z2tyMHNqbFVKYkZvMVE4c0lqTCtFYSt3TCtWSnFGOWZkZU45bDV6MFBNQmFo?=
 =?utf-8?B?eTVsdTRrclh1NkF6aHVZaHE5ODFNMGRya0U2bi9LV3UveTZJaXZReG9iYTJ0?=
 =?utf-8?B?YzdRZ2xZREIrT2hybDZDVk5PaTBZaUY0c1hVajM2VnNWUU1pTllralZCMGxo?=
 =?utf-8?B?MjFsMHRadkJFNXB3Q3ErV2srZDM1UmduR0ZRNmJkWFlJMFc0YWd6bUM1eDhC?=
 =?utf-8?B?bkRJdWIxd2xqRW15eGZiWS9yQ2J2S3p3UXovRlg0WHU1ZVY5VmIzaERCem16?=
 =?utf-8?B?SndrYTJQcWE2NDk3clcwWDlsVnZ6WU56T1lEVEVIMVFRNGYxdWUrOGxGZnht?=
 =?utf-8?B?ZWIxUWRqODFVKzk0THdaL1c2cGRSSGNQZTRseUFaMUhqZnJNNkdIa3pnRkJP?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECBA38112294D84E98D6F0B135C55601@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d7b6d4-f8bc-4496-8bca-08dd3bd67fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 17:51:00.8901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KuopU3Lg+pmlbOAtiBfdy4iutykkQdHIWzZqmtVKVfoRYhfbbkMGebG8jbFNkocWzkm5Mf3BOEp0pWVjyOknbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7697
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTAxLTIyIGF0IDIxOjExIC0wODAwLCBMdWNhcyBEZSBNYXJjaGkgd3JvdGU6
DQo+IENvbW1pdCA3MGZiODZhODVkYzkgKCJkcm0veGU6IFJldmVydCBzb21lIGNoYW5nZXMgdGhh
dCBicmVhayBhIG1lc2ENCj4gZGVidWcgdG9vbCIpIHBhcnRpYWxseSByZXZlcnRlZCBzb21lIGNo
YW5nZXMgdG8gd29ya2Fyb3VuZCBicmVha2FnZQ0KPiBjYXVzZWQgdG8gbWVzYSB0b29scy4gSG93
ZXZlciwgaW4gZG9pbmcgc28gaXQgYWxzbyBicm9rZSBmZXRjaGluZyB0aGUNCj4gR3VDIGxvZyB2
aWEgZGVidWdmcyBzaW5jZSB4ZV9wcmludF9ibG9iX2FzY2lpODUoKSBzaW1wbHkgYmFpbHMgb3V0
Lg0KPiANCj4gVGhlIGZpeCBpcyB0byBhdm9pZCB0aGUgZXh0cmEgbmV3bGluZXM6IHRoZSBkZXZj
b3JlZHVtcCBpbnRlcmZhY2UgaXMNCj4gbGluZS1vcmllbnRlZCBhbmQgYWRkaW5nIHJhbmRvbSBu
ZXdsaW5lcyBpbiB0aGUgbWlkZGxlIGJyZWFrcyBpdC4gSWYgYQ0KPiB0b29sIGlzIGFibGUgdG8g
cGFyc2UgaXQgYnkgbG9va2luZyBhdCB0aGUgZGF0YSBhbmQgY2hlY2tpbmcgZm9yIGNoYXJzDQo+
IHRoYXQgYXJlIG91dCBvZiB0aGUgYXNjaWk4NSBzcGFjZSwgaXQgY2FuIHN0aWxsIGRvIHNvLiBB
IGZvcm1hdCBjaGFuZ2UNCj4gdGhhdCBicmVha3MgdGhlIGxpbmUtb3JpZW50ZWQgb3V0cHV0IG9u
IGRldmNvcmVkdW1wIGhvd2V2ZXIgbmVlZHMgYmV0dGVyDQo+IGNvb3JkaW5hdGlvbiB3aXRoIGV4
aXN0aW5nIHRvb2xzLg0KPiANCj4gQ2M6IEpvaG4gSGFycmlzb24gPEpvaG4uQy5IYXJyaXNvbkBJ
bnRlbC5jb20+DQo+IENjOiBKdWxpYSBGaWxpcGNodWsgPGp1bGlhLmZpbGlwY2h1a0BpbnRlbC5j
b20+DQo+IENjOiBKb3PDqSBSb2JlcnRvIGRlIFNvdXphIDxqb3NlLnNvdXphQGludGVsLmNvbT4N
Cj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gRml4ZXM6IDcwZmI4NmE4NWRjOSAoImRy
bS94ZTogUmV2ZXJ0IHNvbWUgY2hhbmdlcyB0aGF0IGJyZWFrIGEgbWVzYSBkZWJ1ZyB0b29sIikN
Cj4gRml4ZXM6IGVjMTQ1NWNlN2UzNSAoImRybS94ZS9kZXZjb3JlZHVtcDogQWRkIEFTQ0lJODUg
ZHVtcCBoZWxwZXIgZnVuY3Rpb24iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBMdWNhcyBEZSBNYXJjaGkg
PGx1Y2FzLmRlbWFyY2hpQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0veGUv
eGVfZGV2Y29yZWR1bXAuYyB8IDMwICsrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0veGUveGVfZGV2Y29yZWR1bXAuaCB8ICAyICstDQo+ICBkcml2ZXJzL2dw
dS9kcm0veGUveGVfZ3VjX2N0LmMgICAgICB8ICAzICsrLQ0KPiAgZHJpdmVycy9ncHUvZHJtL3hl
L3hlX2d1Y19sb2cuYyAgICAgfCAgNCArKystDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDE1IGluc2Vy
dGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS94ZS94ZV9kZXZjb3JlZHVtcC5jIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RldmNvcmVk
dW1wLmMNCj4gaW5kZXggYTc5NDZhNzY3NzdlNy4uZDliNzFiYjY5MDg2MCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RldmNvcmVkdW1wLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL3hlL3hlX2RldmNvcmVkdW1wLmMNCj4gQEAgLTM5MSw0MiArMzkxLDMwIEBAIGludCB4
ZV9kZXZjb3JlZHVtcF9pbml0KHN0cnVjdCB4ZV9kZXZpY2UgKnhlKQ0KPiAgLyoqDQo+ICAgKiB4
ZV9wcmludF9ibG9iX2FzY2lpODUgLSBwcmludCBhIEJMT0IgdG8gc29tZSB1c2VmdWwgbG9jYXRp
b24gaW4gQVNDSUk4NQ0KPiAgICoNCj4gLSAqIFRoZSBvdXRwdXQgaXMgc3BsaXQgdG8gbXVsdGlw
bGUgbGluZXMgYmVjYXVzZSBzb21lIHByaW50IHRhcmdldHMsIGUuZy4gZG1lc2cNCj4gLSAqIGNh
bm5vdCBoYW5kbGUgYXJiaXRyYXJpbHkgbG9uZyBsaW5lcy4gTm90ZSBhbHNvIHRoYXQgcHJpbnRp
bmcgdG8gZG1lc2cgaW4NCj4gLSAqIHBpZWNlLW1lYWwgZmFzaGlvbiBpcyBub3QgcG9zc2libGUs
IGVhY2ggc2VwYXJhdGUgY2FsbCB0byBkcm1fcHV0cygpIGhhcyBhDQo+IC0gKiBsaW5lLWZlZWQg
YXV0b21hdGljYWxseSBhZGRlZCEgVGhlcmVmb3JlLCB0aGUgZW50aXJlIG91dHB1dCBsaW5lIG11
c3QgYmUNCj4gLSAqIGNvbnN0cnVjdGVkIGluIGEgbG9jYWwgYnVmZmVyIGZpcnN0LCB0aGVuIHBy
aW50ZWQgaW4gb25lIGF0b21pYyBvdXRwdXQgY2FsbC4NCj4gKyAqIFRoZSBvdXRwdXQgaXMgc3Bs
aXQgdG8gbXVsdGlwbGUgcHJpbnQgY2FsbHMgYmVjYXVzZSBzb21lIHByaW50IHRhcmdldHMsIGUu
Zy4NCj4gKyAqIGRtZXNnIGNhbm5vdCBoYW5kbGUgYXJiaXRyYXJpbHkgbG9uZyBsaW5lcy4gVGhl
c2UgdGFyZ2V0cyBtYXkgYWRkIG5ld2xpbmUNCj4gKyAqIGJldHdlZW4gY2FsbHMuDQo+ICAgKg0K
PiAgICogVGhlcmUgaXMgYWxzbyBhIHNjaGVkdWxlciB5aWVsZCBjYWxsIHRvIHByZXZlbnQgdGhl
ICd0YXNrIGhhcyBiZWVuIHN0dWNrIGZvcg0KPiAgICogMTIwcycga2VybmVsIGhhbmcgY2hlY2sg
ZmVhdHVyZSBmcm9tIGZpcmluZyB3aGVuIHByaW50aW5nIHRvIGEgc2xvdyB0YXJnZXQNCj4gICAq
IHN1Y2ggYXMgZG1lc2cgb3ZlciBhIHNlcmlhbCBwb3J0Lg0KPiAgICoNCj4gLSAqIFRPRE86IEFk
ZCBjb21wcmVzc2lvbiBwcmlvciB0byB0aGUgQVNDSUk4NSBlbmNvZGluZyB0byBzaHJpbmsgaHVn
ZSBidWZmZXJzIGRvd24uDQo+IC0gKg0KPiAgICogQHA6IHRoZSBwcmludGVyIG9iamVjdCB0byBv
dXRwdXQgdG8NCj4gICAqIEBwcmVmaXg6IG9wdGlvbmFsIHByZWZpeCB0byBhZGQgdG8gb3V0cHV0
IHN0cmluZw0KPiAgICogQGJsb2I6IHRoZSBCaW5hcnkgTGFyZ2UgT0JqZWN0IHRvIGR1bXAgb3V0
DQo+ICAgKiBAb2Zmc2V0OiBvZmZzZXQgaW4gYnl0ZXMgdG8gc2tpcCBmcm9tIHRoZSBmcm9udCBv
ZiB0aGUgQkxPQiwgbXVzdCBiZSBhIG11bHRpcGxlIG9mIHNpemVvZih1MzIpDQo+ICAgKiBAc2l6
ZTogdGhlIHNpemUgaW4gYnl0ZXMgb2YgdGhlIEJMT0IsIG11c3QgYmUgYSBtdWx0aXBsZSBvZiBz
aXplb2YodTMyKQ0KPiAgICovDQo+IC12b2lkIHhlX3ByaW50X2Jsb2JfYXNjaWk4NShzdHJ1Y3Qg
ZHJtX3ByaW50ZXIgKnAsIGNvbnN0IGNoYXIgKnByZWZpeCwNCj4gK3ZvaWQgeGVfcHJpbnRfYmxv
Yl9hc2NpaTg1KHN0cnVjdCBkcm1fcHJpbnRlciAqcCwgY29uc3QgY2hhciAqcHJlZml4LCBjaGFy
IHN1ZmZpeCwNCg0KanVzdCBtaXNzaW5nIGRvY3VtZW50IHRoZSBzdWZmaXguDQoNCldpdGggdGhh
dCB0aGlzIHBhdGNoIGlzOg0KDQpSZXZpZXdlZC1ieTogSm9zw6kgUm9iZXJ0byBkZSBTb3V6YSA8
am9zZS5zb3V6YUBpbnRlbC5jb20+DQoNCj4gIAkJCSAgIGNvbnN0IHZvaWQgKmJsb2IsIHNpemVf
dCBvZmZzZXQsIHNpemVfdCBzaXplKQ0KPiAgew0KPiAgCWNvbnN0IHUzMiAqYmxvYjMyID0gKGNv
bnN0IHUzMiAqKWJsb2I7DQo+ICAJY2hhciBidWZmW0FTQ0lJODVfQlVGU1pdLCAqbGluZV9idWZm
Ow0KPiAgCXNpemVfdCBsaW5lX3BvcyA9IDA7DQo+ICANCj4gLQkvKg0KPiAtCSAqIFNwbGl0dGlu
ZyBibG9icyBhY3Jvc3MgbXVsdGlwbGUgbGluZXMgaXMgbm90IGNvbXBhdGlibGUgd2l0aCB0aGUg
bWVzYQ0KPiAtCSAqIGRlYnVnIGRlY29kZXIgdG9vbC4gTm90ZSB0aGF0IGV2ZW4gZHJvcHBpbmcg
dGhlIGV4cGxpY2l0ICdcbicgYmVsb3cNCj4gLQkgKiBkb2Vzbid0IGhlbHAgYmVjYXVzZSB0aGUg
R3VDIGxvZyBpcyBzbyBiaWcgc29tZSB1bmRlcmx5aW5nIGltcGxlbWVudGF0aW9uDQo+IC0JICog
c3RpbGwgc3BsaXRzIHRoZSBsaW5lcyBhdCA1MTJLIGNoYXJhY3RlcnMuIFNvIGp1c3QgYmFpbCBj
b21wbGV0ZWx5IGZvcg0KPiAtCSAqIHRoZSBtb21lbnQuDQo+IC0JICovDQo+IC0JcmV0dXJuOw0K
PiAtDQo+ICAjZGVmaW5lIERNRVNHX01BWF9MSU5FX0xFTgk4MDANCj4gLSNkZWZpbmUgTUlOX1NQ
QUNFCQkoQVNDSUk4NV9CVUZTWiArIDIpCQkvKiA4NSArICJcblwwIiAqLw0KPiArCS8qIEFsd2F5
cyBsZWF2ZSBzcGFjZSBmb3IgdGhlIHN1ZmZpeCBjaGFyIGFuZCB0aGUgXDAgKi8NCj4gKyNkZWZp
bmUgTUlOX1NQQUNFCQkoQVNDSUk4NV9CVUZTWiArIDIpCS8qIDg1ICsgIjxzdWZmaXg+XDAiICov
DQo+ICANCj4gIAlpZiAoc2l6ZSAmIDMpDQo+ICAJCWRybV9wcmludGYocCwgIlNpemUgbm90IHdv
cmQgYWxpZ25lZDogJXp1Iiwgc2l6ZSk7DQo+IEBAIC00NTgsNyArNDQ2LDYgQEAgdm9pZCB4ZV9w
cmludF9ibG9iX2FzY2lpODUoc3RydWN0IGRybV9wcmludGVyICpwLCBjb25zdCBjaGFyICpwcmVm
aXgsDQo+ICAJCWxpbmVfcG9zICs9IHN0cmxlbihsaW5lX2J1ZmYgKyBsaW5lX3Bvcyk7DQo+ICAN
Cj4gIAkJaWYgKChsaW5lX3BvcyArIE1JTl9TUEFDRSkgPj0gRE1FU0dfTUFYX0xJTkVfTEVOKSB7
DQo+IC0JCQlsaW5lX2J1ZmZbbGluZV9wb3MrK10gPSAnXG4nOw0KPiAgCQkJbGluZV9idWZmW2xp
bmVfcG9zKytdID0gMDsNCj4gIA0KPiAgCQkJZHJtX3B1dHMocCwgbGluZV9idWZmKTsNCj4gQEAg
LTQ3MCwxMCArNDU3LDExIEBAIHZvaWQgeGVfcHJpbnRfYmxvYl9hc2NpaTg1KHN0cnVjdCBkcm1f
cHJpbnRlciAqcCwgY29uc3QgY2hhciAqcHJlZml4LA0KPiAgCQl9DQo+ICAJfQ0KPiAgDQo+ICsJ
aWYgKHN1ZmZpeCkNCj4gKwkJbGluZV9idWZmW2xpbmVfcG9zKytdID0gc3VmZml4Ow0KPiArDQo+
ICAJaWYgKGxpbmVfcG9zKSB7DQo+IC0JCWxpbmVfYnVmZltsaW5lX3BvcysrXSA9ICdcbic7DQo+
ICAJCWxpbmVfYnVmZltsaW5lX3BvcysrXSA9IDA7DQo+IC0NCj4gIAkJZHJtX3B1dHMocCwgbGlu
ZV9idWZmKTsNCj4gIAl9DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS94ZS94
ZV9kZXZjb3JlZHVtcC5oIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RldmNvcmVkdW1wLmgNCj4g
aW5kZXggNmExN2U2ZDYwMTAyMi4uNTM5MWE4MGE0ZDFiYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3hlL3hlX2RldmNvcmVkdW1wLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3hl
L3hlX2RldmNvcmVkdW1wLmgNCj4gQEAgLTI5LDcgKzI5LDcgQEAgc3RhdGljIGlubGluZSBpbnQg
eGVfZGV2Y29yZWR1bXBfaW5pdChzdHJ1Y3QgeGVfZGV2aWNlICp4ZSkNCj4gIH0NCj4gICNlbmRp
Zg0KPiAgDQo+IC12b2lkIHhlX3ByaW50X2Jsb2JfYXNjaWk4NShzdHJ1Y3QgZHJtX3ByaW50ZXIg
KnAsIGNvbnN0IGNoYXIgKnByZWZpeCwNCj4gK3ZvaWQgeGVfcHJpbnRfYmxvYl9hc2NpaTg1KHN0
cnVjdCBkcm1fcHJpbnRlciAqcCwgY29uc3QgY2hhciAqcHJlZml4LCBjaGFyIHN1ZmZpeCwNCj4g
IAkJCSAgIGNvbnN0IHZvaWQgKmJsb2IsIHNpemVfdCBvZmZzZXQsIHNpemVfdCBzaXplKTsNCj4g
IA0KPiAgI2VuZGlmDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjX2N0
LmMgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjX2N0LmMNCj4gaW5kZXggOGI2NWM1ZTk1OWNj
Mi4uNTBjODA3NmI1MTU4NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2d1
Y19jdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9ndWNfY3QuYw0KPiBAQCAtMTcy
NCw3ICsxNzI0LDggQEAgdm9pZCB4ZV9ndWNfY3Rfc25hcHNob3RfcHJpbnQoc3RydWN0IHhlX2d1
Y19jdF9zbmFwc2hvdCAqc25hcHNob3QsDQo+ICAJCQkgICBzbmFwc2hvdC0+ZzJoX291dHN0YW5k
aW5nKTsNCj4gIA0KPiAgCQlpZiAoc25hcHNob3QtPmN0YikNCj4gLQkJCXhlX3ByaW50X2Jsb2Jf
YXNjaWk4NShwLCAiQ1RCIGRhdGEiLCBzbmFwc2hvdC0+Y3RiLCAwLCBzbmFwc2hvdC0+Y3RiX3Np
emUpOw0KPiArCQkJeGVfcHJpbnRfYmxvYl9hc2NpaTg1KHAsICJDVEIgZGF0YSIsICdcbicsDQo+
ICsJCQkJCSAgICAgIHNuYXBzaG90LT5jdGIsIDAsIHNuYXBzaG90LT5jdGJfc2l6ZSk7DQo+ICAJ
fSBlbHNlIHsNCj4gIAkJZHJtX3B1dHMocCwgIkNUIGRpc2FibGVkXG4iKTsNCj4gIAl9DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjX2xvZy5jIGIvZHJpdmVycy9ncHUv
ZHJtL3hlL3hlX2d1Y19sb2cuYw0KPiBpbmRleCA4MDE1MWZmNmE3MWY4Li40NDQ4MmVhOTE5OTI0
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjX2xvZy5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9ndWNfbG9nLmMNCj4gQEAgLTIwNyw4ICsyMDcsMTAgQEAg
dm9pZCB4ZV9ndWNfbG9nX3NuYXBzaG90X3ByaW50KHN0cnVjdCB4ZV9ndWNfbG9nX3NuYXBzaG90
ICpzbmFwc2hvdCwgc3RydWN0IGRybV8NCj4gIAlyZW1haW4gPSBzbmFwc2hvdC0+c2l6ZTsNCj4g
IAlmb3IgKGkgPSAwOyBpIDwgc25hcHNob3QtPm51bV9jaHVua3M7IGkrKykgew0KPiAgCQlzaXpl
X3Qgc2l6ZSA9IG1pbihHVUNfTE9HX0NIVU5LX1NJWkUsIHJlbWFpbik7DQo+ICsJCWNvbnN0IGNo
YXIgKnByZWZpeCA9IGkgPyBOVUxMIDogIkxvZyBkYXRhIjsNCj4gKwkJY2hhciBzdWZmaXggPSBp
ID09IHNuYXBzaG90LT5udW1fY2h1bmtzIC0gMSA/ICdcbicgOiAwOw0KPiAgDQo+IC0JCXhlX3By
aW50X2Jsb2JfYXNjaWk4NShwLCBpID8gTlVMTCA6ICJMb2cgZGF0YSIsIHNuYXBzaG90LT5jb3B5
W2ldLCAwLCBzaXplKTsNCj4gKwkJeGVfcHJpbnRfYmxvYl9hc2NpaTg1KHAsIHByZWZpeCwgc3Vm
Zml4LCBzbmFwc2hvdC0+Y29weVtpXSwgMCwgc2l6ZSk7DQo+ICAJCXJlbWFpbiAtPSBzaXplOw0K
PiAgCX0NCj4gIH0NCg0K

