Return-Path: <stable+bounces-161624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4535EB01168
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 04:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313251CA3466
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 02:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE97192B84;
	Fri, 11 Jul 2025 02:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgMl/vZI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B718A93C;
	Fri, 11 Jul 2025 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752202510; cv=fail; b=KsCv66nFc+oiuJtcfFdNnofGNnXmdJ/Hyeb6GAZcvdA6HI9YXbKoDXDk+8dy3ui9O3+y1yvjaa/xvgXfuCQ/NLjp6SvsE2A/GTiBBGFfxcVVELDaHVDqg8RTrq1FXsmq1fPKisDz9O4+4JCXVvfjK6j8vwdmJ4LkZ1Fqn5tl2+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752202510; c=relaxed/simple;
	bh=DZWASYGdrm2jzDBpdmI8VpBGApJMu+l9hJxg/5XLZ8Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=RCgds66RC1mncZqTUEgAMPpb2RYNtmI30q4VYIbZvix3JfGTEwLFJfpAKcvtWc8Pm75n+JRdyD55T+DHjRIulbkEz9ulXwtADlqDIEj5P5hg9w/Jdoy5IecHBjSzcbEmq4x3QGfe5wi+N0dB/4xl0zfNTvDV1zxBQOKGstd6uUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgMl/vZI; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752202508; x=1783738508;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DZWASYGdrm2jzDBpdmI8VpBGApJMu+l9hJxg/5XLZ8Q=;
  b=FgMl/vZIpjVHv8si4owt264dYiVs+anHGRRr1SLlS8ddUWv6yAuOmjlD
   4LPlqDMlDpwtCDHsbs1zWCk2y0udFaViDM9VGn38kNP6meGlQzQ1fZdpa
   EHEmXZb8KeAcBcHJQN2jVvwvZ1lWIaLMDilWLvE/WpyHdU6OpcaKEg+ts
   gzAANDZRwzkUVgDis3wBVHbJ7LyV7fCGVXqNzgW1yfZFzDTDKu6PwMonW
   7WlxVj9McvqHTCpd/EYDI+F7kxaQ63lEQ2lK8KzCY4mE8J7wZetptQURo
   Z9xFNlt9eqDDnfIl2tQaQ6dBqeyT9KWf80PZ/VZlzz8mg9gWzrUUSOPGK
   w==;
X-CSE-ConnectionGUID: UHYrf3zYQx+Fv3Je121J0Q==
X-CSE-MsgGUID: cdjbwE0hS4qAKZZXuTRn/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54586444"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="54586444"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 19:54:21 -0700
X-CSE-ConnectionGUID: buoGmCXlRXKPetsGq9Oxnw==
X-CSE-MsgGUID: VN3DdZlNS1asPcDLAEmvsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="193463770"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 19:54:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 19:54:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 19:54:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.81) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 19:54:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpB7NxjCJ2GkHJrtjCNOlXjW/jCObxqW4NXUuQ5qtF2K7m3TN6SkS8442k4u6sHRYQkfIcib3Hv6JashnBP6T5y3Y8zpDyR5MLGpIBezTmVLPGK4eXNOVQp9zcbDo+I3gic3yy+7N8ucHRi5EOcjTMfaswMVxfgIgCEsS4tLf6KZwOFx+L5Mq/sI33s98Td5Vg5plehPdDRs+llAhF9a8xTQKAW+0Y84/kSnTw7PDi4gR5cq40GLZ9J8IO14tSB6idtsJjz0YKinimDm8aVY9+YLzfErrod4jGLBlAEX+Sva4kdS1cliwHWnErSMShZjXYTExHVX2H5OErMVmf1Bug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZWASYGdrm2jzDBpdmI8VpBGApJMu+l9hJxg/5XLZ8Q=;
 b=wOx3YD9XvfYAVgpEX7gQ9siNN+e8TuadSRfawnh7+LUpXYFd610vu150NUDf8j1yrvDjOmJZIXfauVDGiY2LOsbjJv540EOJzktXRxK3ULIcNCfN6u1qHdGPEPwctinXRQpFkvSmvfDYx2sLLZvf0lpjHVu1BpBk/J09GZUsCxQYqBXnIj14sQpbfYGYRoX4B91m54gRh51ePrQAtfHOgrNsCV1Yqub9azlUI4e+WfBIQYu3Y90hY72HuoLOot2eqax/8G2XjYu6dloqzjWvmlDaQAhp9EhFj1+gcYkotbIZ14TLmpNPBchtqm68WFF3SMqR5ceB8FsoYIUji5evCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8229.namprd11.prod.outlook.com (2603:10b6:8:15e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 02:54:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 02:54:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jann Horn
	<jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple
	<apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki
	<urezki@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Andy
 Lutomirski" <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "security@kernel.org"
	<security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Topic: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Index: AQHb8JsDhmo0nc9lxUeepqGM5I/6nbQp63CAgAC0NoCAALJYAIAACDAAgAAihACAALa4IIAACRPA
Date: Fri, 11 Jul 2025 02:54:17 +0000
Message-ID: <BN9PR11MB5276141D37C09E9898F4AE518C4BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <ee7585bd-d87c-4f93-9c8e-b8c1d649cdfe@intel.com>
 <228cd2c9-b781-4505-8b54-42dab03f3650@linux.intel.com>
 <326c60aa-37f3-458d-a534-6e0106cc244b@intel.com>
 <20250710132234.GL1599700@nvidia.com>
 <62580eab-3e68-4132-981a-84167d130d9f@intel.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8229:EE_
x-ms-office365-filtering-correlation-id: 6514de93-3d62-4d3d-142d-08ddc0263a8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R01SM1ZNUGtoUW5xYTd2NFdYL2M5c1MzNGhlVERreUJyTkRVZVZoREJXMjBa?=
 =?utf-8?B?ckprSXNGTCs1VUlZUHVyZFRZeDU5WFE2U1IvZk9mandOWmxJYzJMMmJRRzJ2?=
 =?utf-8?B?cHpSZFB1cGFKbHk1UkIxdlZJMzIwb1R5OUVKSGI1VVo1VlB4TFN1VnZLVmtH?=
 =?utf-8?B?b2lBc0libVhsRjhTUUVCaENLcklBN3B2VVN3MEVoWFplSzBSNGJpZEFYM2Zt?=
 =?utf-8?B?QTZGZVAyM0tmbjNtTmt5UUxsZ3dHTnVKMEpaNlJXbjVEdXAyYmcwRGlSRFMv?=
 =?utf-8?B?OENCWVp3Z3M1RSsrOXFZSUJzSUJ0YkZHWDU3MVBDcCtSalFNenlCWS94N21R?=
 =?utf-8?B?N1JnT0N4RmF6Rmk3NmRVcXFIN1FXdk9tVExSN1BLb1pwVmxYQ1pDSWcxQWRs?=
 =?utf-8?B?U0RQOE5EQm5vamxTbmpBckIyZVVJN3V1cHhYc1d2TVNPUzB2aTNSQ2VrSWpU?=
 =?utf-8?B?TUEvV09HcDFrNW1uVXNocUQvVzNBa3BPTFFTRXFwY1lWSkdRampwMXpUUFli?=
 =?utf-8?B?ajNVSE85NmxoZ2djbnRkM0h1S1hsUVhmTFd0cVNabERkVEZyRnpmY0FEV1Iy?=
 =?utf-8?B?TEdtMmd1OStDZ2wrOVBnUDhUQzNtMy9KdTBJeHBJN3pMelp6b2k3aVZiYzVY?=
 =?utf-8?B?elBhMzRpOHArU0tUQmxTdEY3UFlKeHFsWGl2Vy9Tam1BQkJZSG5FS2taSlZz?=
 =?utf-8?B?c3lxbU5vNVdkdlJYSGhHTU1ualNFNlFGT0crVGpLcDc4azVYMHJRMzVyOGEw?=
 =?utf-8?B?TmRiK0hIT1JnbWhSWHJ6L3MrQ2R0ZzBtWmFTaE0vUzhaTnZxZnpQeXFBbXAy?=
 =?utf-8?B?ZlV0VU5jbnBPTUZKSmYvWEhIaWM4QWQyQStseGMwRndvS1I4UFh6NUd3M0lW?=
 =?utf-8?B?V01lN2dBeWRXd3VPbVJwU3pmNVZuOXg2Z2hqYXQwOGZCSGl1MVlSb3RHR3dV?=
 =?utf-8?B?b0RrMVM0anpUV2F4RUxpdWFVbllGWm5PTFc0RGc4ZUVlMVJyY2Rxdm9kMVNR?=
 =?utf-8?B?SkhnZTdtajhOMkRQMkxXa0k5QVpySjBVZjNvV3dBU21ybG1WSm8xNnRjMjJK?=
 =?utf-8?B?TWRWQUw4Ujh6S3paK2FxOWUwbDZ6V20wR1FGU2IrN1FOUDlpV0RqdzlDS1JX?=
 =?utf-8?B?cXNUNnllYkI0eVhjU3Awd0JnL0dmb05KbDd5bVNMWmt1ZUticmZVMlhZelI3?=
 =?utf-8?B?Q1cyOW9vMzF1cVlBVE0xNllBdmtwOE5qRHMzSFQxMUpjNWdUN1luYzJsUDUr?=
 =?utf-8?B?UmRJUVJPN2hUWDBSQ3diZDhMek1pSE1MVE0xNFZCSlljM1VvSWpxQ2dtNTEv?=
 =?utf-8?B?cTJQeEVUbHJWaVh3cXpKb042SGJNY01QUXYwQUpkdkphRTM5K2VBSDRmekFi?=
 =?utf-8?B?UkFWUmcxdHBRMlF6Z1lCRUhhaUhvdjFZTGlzSUxEZUdINFJwM2VkQW1TRzdz?=
 =?utf-8?B?cDVXQk9BZ1hJTkp4RnFpcmxvUHVuay9KYUF5d1U5WjlyZkRxUDJSemtzT2FL?=
 =?utf-8?B?bVJFbnB3aW5CbXpHT0xzbW5uVjdXL2ZUZWZaQjV6K3lIeGF6TTZaOUxiUmRq?=
 =?utf-8?B?aUswMk1RTkYzbE1tM1hLaWNvKzZZTTFkQS9hY09Pdk5pNzhFdnJsdmptVHg0?=
 =?utf-8?B?Q01RWllYQzl3ZFcrbjJKc1gxRGl2THV1TU9VUnJtVDlFNHVKK1F2SlMyQzNy?=
 =?utf-8?B?RUduNHpDTEhvSzlCZDY0aU1kRG01Z280SnY5THlPekZmVGo4Rmw4clVzQnRF?=
 =?utf-8?B?NUxjNXJSTzBWL0dsa2ZRRU10VlZmZnBQbEUwOXZtZVBiN012dHFsTVF2TFZI?=
 =?utf-8?B?LytNRURwbThFS1BtS0cyMkhLOGNGVkM5Mk9KQ3hkRmxxbS9nODVMc0lCN3Vx?=
 =?utf-8?B?T3VlUE5aTGx1ajVpZzNwZnZUSlR6TWgrQUJaNWNPc2FWc3o2dHJtSFpPVFdJ?=
 =?utf-8?B?WmpUUWpjYlcyaGlVaUJHdDNkZVVWaTdlVUVObHl4T1VLWTVrZ1BCUFF6U2xa?=
 =?utf-8?Q?A3QUTE+p1xW9tYVOqZBEsxuq5HpOzc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUppVS8wdFFteUdua0g4ZG1YMUZLc1lRR0JsMHFIdGtPNHNoWjhRTTNXZkY3?=
 =?utf-8?B?TS81N2hSUTJrczJxbmY0NkUvTkNrTHI4RldSaWZLNGRQVjdGQmdFbHJaVHVV?=
 =?utf-8?B?eWY1Mm4wck15RC9OdXViMnc0SWVjd2RCVmdiRlVXTktjeHFlZnBGNjBrZXVk?=
 =?utf-8?B?T0taTW80cVJIV1c5MU5Qc3g3M1dQbXFQeDBRaTkwWWxObG4zcjJOci9EUDRa?=
 =?utf-8?B?N3lNNEpNTlZVY05iUXllNkZDM005eUhkck03eWl0V3JnQjdzYlI5bHpNRWdx?=
 =?utf-8?B?YWZBaWh0ZHh1cFI4TGYxdjA1MUQ4MklxSDdYamE3UllYTjJHdm1aWWx0K3NU?=
 =?utf-8?B?ekJuSWxFZFlnc1hqT1g5RFV5eWk3eGV0WVUxb1lLVGFNUjJFdlRmbnFMVVJl?=
 =?utf-8?B?UXJMbmczelFtVFZNWjJCeGVNamNpK2xMVkJnbHNmbm56QitCN0pFRTBBUVI0?=
 =?utf-8?B?bjdQTDdWSDh6aFVNRDdCWGpIWXRFQ1pGS1Rid2tSVTFGTCszTjhZOTNNN0dq?=
 =?utf-8?B?ckdGNC9oVnFpS21UbmJBaHg4Z2hlZEpHOHRubWZWYnJkNkcxZXNsNUczRk9o?=
 =?utf-8?B?RFBuOTd4MHFFRm82R29pMHBCYnM5cGY4cm5KcXQyVU1xbFlSb0dpbjNGMEg3?=
 =?utf-8?B?N2hxWWZOSXJkNU5JRXBrc212RGc5cnd2VVV2T0hweWIrcys2WUUwdUJ2aml0?=
 =?utf-8?B?bHZjOWY5VFdDbm9IdEtnVmY3SlhaQTBXUXUwVVZlb2VKZEZNdHYzQ1FuOGVE?=
 =?utf-8?B?eVhMSEpNY2tSOE1BeCtYaE9YczZIWWk4MExCdEd0eTZrYTZHajZ4Z3JQT2gv?=
 =?utf-8?B?OVNBM0RWK0s2cU5rV0V3bklPWmFZQjl6V2k2azdpb0cyS3BIZEdFQnRxbUtt?=
 =?utf-8?B?cVU2dVFMN09wcWJkNllzeWJQelJ5d3lhcnZoNnlCOEZWaWpwYThEVXpwY1Nl?=
 =?utf-8?B?MnJIblZNUGdCQW1HUENpUFFFRytKbHJ6U1l1bEpZRnBDd0hCSTdFQ2NSUGZv?=
 =?utf-8?B?NTY2Nnd2WFhQREwydU8yUE1GL0h2dTVsVERpVzZZZ01yalB4dVNiVnVuaFM5?=
 =?utf-8?B?em9VTTFsSE9MVGtYeDkxb1R2S3NIc0JrMFdnaDdlbEFDbFV3Wkt6Rjc5cmhW?=
 =?utf-8?B?SW1YblV5VmRHTU1JUzF5Z2JPZnlHd3JzczlhZjUzMFpKRXZ1c1VQU3hKVTV1?=
 =?utf-8?B?WWowVWg2UkkrQUhuVlRDUUptODd4d0hnZHIrbVZKYWJVVi9FSEZ6ajhmTXhp?=
 =?utf-8?B?TTJJSkNwbG50Uk5uR3dIRmFOYzc3b29TQk40U0I2dmwzY2o5bVlMd3lwUkVm?=
 =?utf-8?B?Z1N5cDVaTDJOOHkwY2R5eTgxakxqK3VFUkxuY0RMZ2RiVFBNbSs4ZzJsVmZ4?=
 =?utf-8?B?YWkya0c3alNPVUIyaGYxS2p5bGRrN2NGYlZHeWRKRDkwQ3QzVG1TZE5wQXNi?=
 =?utf-8?B?a2s5aTRRZVN6bTVULzBxNTlaQmRzNzBzTU1oTHV1czRtTVYwSU8rREsreU9W?=
 =?utf-8?B?U0toL0pDSGxNVVk4R2EvV25UV21SZjZua2dSVzFVU3V4QmxsbWN4N0plQlNS?=
 =?utf-8?B?V2w5RW51cEsyK2pyaVVKdERLSGxISnBMblVWeVo5cC94NzFFUmh2cXQ5U3Z5?=
 =?utf-8?B?WGVXM1lvTUZ0TGloVUlSbHBObFg3SXhGckxZLzFmaWcxWVdVZVVaeC94ZkFt?=
 =?utf-8?B?eCthbHZmSHE2ejJ1TGsxTElIY0tZZlJZQ2NmeHptZEJsUTBWL01LV1FSekli?=
 =?utf-8?B?TmtxT28xb1N3cXJMcnJHc0JOVEdyeXZSOGJjUWx0SmFZZWxBYU9yNkQxZDhU?=
 =?utf-8?B?RVlvd3NVOU5yWkRYdDMxenJSQjdCclhSVnlSd1p6VSs0MGd2dVpPanp1Njdn?=
 =?utf-8?B?dmt2YkdEbktTY2p0SzNrMzJDYmsrdjBpLzZDcm0wMHo1bytHcmp1ckt3M1RH?=
 =?utf-8?B?UUJHeGs3TFh4eExQaG8zeUl0WmdoTXlWVTNnc0NZTUtSSEZGNG9xMlk0cnNp?=
 =?utf-8?B?RHROb2xnT1h3TjRDTGVic3o1QjVyQ2xCZVVlZm53djlkNmhZYi9LbjQ0ZURJ?=
 =?utf-8?B?Wm9jLzRlaFhnekhwa1pRUXNXZnVZYVBjOEU2bnZ2SkF3WlNYRldsZG1iNHZV?=
 =?utf-8?Q?bcyM6AQFUjxPUW+ejRmpKLZSg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6514de93-3d62-4d3d-142d-08ddc0263a8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 02:54:17.9667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNnGxN+yqXUfCZkBMd82JEZOKX5vavOxnWdx+RBCnbQQaLceWmWnKx5PVSQwB4ihGevfBAvUij+mv7gTH92QQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8229
X-OriginatorOrg: intel.com

PiBGcm9tOiBUaWFuLCBLZXZpbg0KPiBTZW50OiBGcmlkYXksIEp1bHkgMTEsIDIwMjUgMTA6NDYg
QU0NCj4gDQo+ID4gRnJvbTogSGFuc2VuLCBEYXZlIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+DQo+
ID4gU2VudDogVGh1cnNkYXksIEp1bHkgMTAsIDIwMjUgMTE6MjYgUE0NCj4gPg0KPiA+IE9uIDcv
MTAvMjUgMDY6MjIsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiA+PiBXaHkgZG9lcyB0aGlz
IG1hdHRlcj8gV2UgZmx1c2ggdGhlIENQVSBUTEIgaW4gYSBidW5jaCBvZiBkaWZmZXJlbnQNCj4g
d2F5cywNCj4gPiA+PiBfZXNwZWNpYWxseV8gd2hlbiBpdCdzIGJlaW5nIGRvbmUgZm9yIGtlcm5l
bCBtYXBwaW5ncy4gRm9yIGV4YW1wbGUsDQo+ID4gPj4gX19mbHVzaF90bGJfYWxsKCkgaXMgYSBu
b24tcmFuZ2VkIGtlcm5lbCBmbHVzaCB3aGljaCBoYXMgYSBjb21wbGV0ZWx5DQo+ID4gPj4gcGFy
YWxsZWwgaW1wbGVtZW50YXRpb24gd2l0aCBmbHVzaF90bGJfa2VybmVsX3JhbmdlKCkuIENhbGwg
c2l0ZXMgdGhhdA0KPiA+ID4+IHVzZSBfaXRfIGFyZSB1bmFmZmVjdGVkIGJ5IHRoZSBwYXRjaCBo
ZXJlLg0KPiA+ID4+DQo+ID4gPj4gQmFzaWNhbGx5LCBpZiB3ZSdyZSBvbmx5IHdvcnJpZWQgYWJv
dXQgdm1hbGxvYy92ZnJlZSBmcmVlaW5nIHBhZ2UNCj4gPiA+PiB0YWJsZXMsIHRoZW4gdGhpcyBw
YXRjaCBpcyBPSy4gSWYgdGhlIHByb2JsZW0gaXMgYmlnZ2VyIHRoYW4gdGhhdCwgdGhlbg0KPiA+
ID4+IHdlIG5lZWQgYSBtb3JlIGNvbXByZWhlbnNpdmUgcGF0Y2guDQo+ID4gPiBJIHRoaW5rIHdl
IGFyZSB3b3JyaWVkIGFib3V0IGFueSBwbGFjZSB0aGF0IGZyZWVzIHBhZ2UgdGFibGVzLg0KPiA+
DQo+ID4gVGhlIHR3byBwbGFjZXMgdGhhdCBjb21lIHRvIG1pbmQgYXJlIHRoZSByZW1vdmVfbWVt
b3J5KCkgY29kZSBhbmQNCj4gPiBfX2NoYW5nZV9wYWdlX2F0dHIoKS4NCj4gPg0KPiA+IFRoZSBy
ZW1vdmVfbWVtb3J5KCkgZ3VuayBpcyBpbiBhcmNoL3g4Ni9tbS9pbml0XzY0LmMuIEl0IGhhcyBh
IGZldyBzaXRlcw0KPiA+IHRoYXQgZG8gZmx1c2hfdGxiX2FsbCgpLiBOb3cgdGhhdCBJJ20gbG9v
a2luZyBhdCBpdCwgdGhlcmUgbG9vayB0byBiZQ0KPiA+IHNvbWUgcmFjZXMgYmV0d2VlbiBmcmVl
aW5nIHBhZ2UgdGFibGVzIHBhZ2VzIGFuZCBmbHVzaGluZyB0aGUgVExCLiBCdXQsDQo+ID4gYmFz
aWNhbGx5LCBpZiB5b3Ugc3RpY2sgdG8gdGhlIHNpdGVzIGluIHRoZXJlIHRoYXQgZG8gZmx1c2hf
dGxiX2FsbCgpDQo+ID4gYWZ0ZXIgZnJlZV9wYWdldGFibGUoKSwgeW91IHNob3VsZCBiZSBnb29k
Lg0KPiA+DQo+IA0KPiBJc24ndCBkb2luZyBmbHVzaCBhZnRlciBmcmVlX3BhZ2V0YWJsZSgpIGxl
YXZpbmcgYSBzbWFsbCB3aW5kb3cgZm9yIGF0dGFjaz8NCj4gdGhlIHBhZ2UgdGFibGUgaXMgZnJl
ZWQgYW5kIG1heSBoYXZlIGJlZW4gcmVwdXJwb3NlZCB3aGlsZSB0aGUgc3RhbGUNCj4gcGFnaW5n
IHN0cnVjdHVyZSBjYWNoZSBzdGlsbCB0cmVhdHMgaXQgYXMgYSBwYWdlIHRhYmxlIHBhZ2UuLi4N
Cj4gDQo+IGxvb2tzIGl0J3Mgbm90IHVudXN1YWwgdG8gc2VlIHNpbWlsYXIgcGF0dGVybiBpbiBv
dGhlciBtbSBjb2RlOg0KPiANCj4gdm1lbW1hcF9zcGxpdF9wbWQoKQ0KPiB7DQo+IAlpZiAobGlr
ZWx5KHBtZF9sZWFmKCpwbWQpKSkgew0KPiAJCS4uLg0KPiAJfSBlbHNlIHsNCj4gCQlwdGVfZnJl
ZV9rZXJuZWwoJmluaXRfbW0sIHBndGFibGUpOw0KPiAJfQ0KPiAJLi4uDQo+IH0NCg0Kb2gsIHBs
ZWFzZSBpZ25vcmUgdGhpcyBjb21tZW50LiBJdCdzIG5vdCBhYm91dCBmcmVlaW5nIHRoZSBleGlz
dGluZw0KcGFnZSB0YWJsZS4gaW5jYXV0aW91cyBsb29rLiDwn5iKDQo=

