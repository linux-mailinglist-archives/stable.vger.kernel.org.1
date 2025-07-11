Return-Path: <stable+bounces-161622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3268B01159
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 04:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860D11C44BF7
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 02:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA05713AD26;
	Fri, 11 Jul 2025 02:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UROA1beh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D1F10E9;
	Fri, 11 Jul 2025 02:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752202024; cv=fail; b=XmA4P0X64PTr6bLvy191aRw8YKT6s9VC3G+5pmPy9gH7SQBmKhYGSFEnrQDl9tl3POT0ZqOBT8qMOFmZAf+TxAkWWglny8l12g4iqypBLnRzFt7cpU260KgHV20MMLGETSi/ARsrXILP9vz9G8zV8ApkXeSdTUS8j6nklMrTXCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752202024; c=relaxed/simple;
	bh=Hb7diLOT0+JRmxhrmKev/ogzecjBH2h47GbuzrfnLD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tod9JSm+1mPtD0AS0BJ0IYpXKBexlth31hvSQ6G2XrUJNMj3VUNxHentIUiE2yd02hQ1QmvvWDz/FTh75xFHKDRh2xx0FHMzb00kIpimtEhEgmuMYIR88sW06zDUOP75MPIYm1vD9LAyZhsaXRfah+Ot7HEcM+I6xH2RIR/WEn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UROA1beh; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752202023; x=1783738023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hb7diLOT0+JRmxhrmKev/ogzecjBH2h47GbuzrfnLD8=;
  b=UROA1behNmAGMQU8xA/cE/yaLI0XG6ck4xTYOBFxLZ+d9PG98zocGxEA
   zO5/zDfVDdqDXji3SaS8cS7MWUyA3uqVMpPP6Vs30nk68AwDcYqiS63Kf
   IOPdpMA1eEEoQpl742cNq7SEiiJovwV3Sg0H2hMS3QqX3kRaGfIoSLXJo
   yP5kCAg+jG0V1UCzWQpbL0sXElah1paSS+nImPmn2/AtG7/PLCrNZce/d
   zCTmNS+89eE2ZQmEtdRgz2dXnDhorXb/ud42NVFnT48Om4Z6KmPqPlaFB
   fhlIYfyNYAJLzMP/jcJJD6ZwWh/gMD7DIp7TxHJZ8zINx8CdnCH/T8Nko
   A==;
X-CSE-ConnectionGUID: WcjBTGt3Quul4GaWgUM0gQ==
X-CSE-MsgGUID: MM5OQFpyQiOBQiyUdhk+gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65945614"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="65945614"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 19:46:45 -0700
X-CSE-ConnectionGUID: uM3Al0/BS/qo9Ks2OEcU7w==
X-CSE-MsgGUID: 86CveLG2S7OoQJBnSRATGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="156744089"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 19:46:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 19:46:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 19:46:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.86) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 19:46:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiHgoA7qLrAicQeJ66DKXEkjBLMbEQvW4+ggViTqieF18/bNsuctpu8LezJUjGcyMHA4edRxR22kOsiU3nDRMs1Gh0M3KwZd8OddC2cYd922FnddVp8EEYweXFwfOVAFPN+d/ofNqFNRugDI7fYeRtkiIxqxvsmuj3/wtoTd5H57l7rGzSDyqEjeJSZ2Kw6Fz7w/DZdXm4KVYGtB6calioJnFFoVYh/molB3FEew+FQmHkUbCOaYhz+yTYY1z8j7XConiaY6ea5+DHiwxsfglxNIzY900D8z5Rpu3yM/09x4JanL/oiXjZVR7wprf/X0KIMjk4+4MmG6Y+lOAzPm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb7diLOT0+JRmxhrmKev/ogzecjBH2h47GbuzrfnLD8=;
 b=ZVGxSo7vYb/5/aZ4VxgF7UzaObzhy9y11+TRVo6Y+SIBAoeRRcmYJAS4RSgW7TJvQ+5oSDMkPOi9fuK7W3qAQ0wH4Oxn5AIr4DY7ijmjMqLiBMRihzHnUnCwkYYr/eAEbby0ZhS3AAoZke3RpSxoDijdMeOMWpPjbcp81SmeyW5FX1pywsD3ewZoxSwE/C4hNgXdlUi7Qa5MxgbGEyobdNi0Ej3W0LNkb3nYZoWKvirnaJ/SdXbn59T5jCGFQkLjd4yTGJjoftOpp4sslznpatIwSgjbRKBXABGgey8uOB6mF0xtOVJNe6PAwNMM0ELSbskNZewg6cAZMxoepaDNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4897.namprd11.prod.outlook.com (2603:10b6:303:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 02:46:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 02:46:23 +0000
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
Thread-Index: AQHb8JsDhmo0nc9lxUeepqGM5I/6nbQp63CAgAC0NoCAALJYAIAACDAAgAAihACAALa4IA==
Date: Fri, 11 Jul 2025 02:46:23 +0000
Message-ID: <BN9PR11MB5276CCBCAF8796A8EB238DCC8C4BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <ee7585bd-d87c-4f93-9c8e-b8c1d649cdfe@intel.com>
 <228cd2c9-b781-4505-8b54-42dab03f3650@linux.intel.com>
 <326c60aa-37f3-458d-a534-6e0106cc244b@intel.com>
 <20250710132234.GL1599700@nvidia.com>
 <62580eab-3e68-4132-981a-84167d130d9f@intel.com>
In-Reply-To: <62580eab-3e68-4132-981a-84167d130d9f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4897:EE_
x-ms-office365-filtering-correlation-id: 0f67d6d3-ae32-4e28-d8c9-08ddc0251f90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NGRtc1pwK004aDM1WE5FcVR4Rk1ybzUxTFoyaGd0dmtESXUyZkdGSUFuUjdh?=
 =?utf-8?B?YTgrb05pQXc4V2lJZ05aYVJqcmw2WDRkSTlxdlY3Q0psQ3RuSDI3eTJub0o3?=
 =?utf-8?B?L3J6SXBvYlBLUE1WOVlRSS9uRi9YNmJpdmdlVTF2SzlNa1FYdXFPREpmUCtp?=
 =?utf-8?B?UDh5S0I3UWRjWlQ1d1QwYXVpcjhpb0NBUUd3UTkyU1REM2tYMFpmb2ExUTZu?=
 =?utf-8?B?SnJTa1NuZnE0LzBSTlVpb015ay9ESmxSWU45QzEzdHNaRVpMSTk4bjFzMCtZ?=
 =?utf-8?B?MmJMSmMwZlJETXgyWkR5Ymx3K29OaWhlMThuY2VBTEQ2Mk1Nc0V4SEhLUHc2?=
 =?utf-8?B?M2F0OFBoVEZxanRLN1BLRmJFeW96SnJnSW9SUGJ4MjU4dEQyWVpYa3JrWXJR?=
 =?utf-8?B?UUJwdFBoVUdaWjRVSTJWTmZpdVB1YUhzOFJEZ3kya2VoTEhGL2NmeGowcUhs?=
 =?utf-8?B?RExrbHRFNHlZS3dlNWMvYWp1RDM3YVB1TzF2NFEzYURLYVFDdkx3K2lXYWRx?=
 =?utf-8?B?TlZQNG8rYW1PZ0RmRXpWVWtzR0sxVXVxVXp6L1ZRK0NMUnh1WXY3eGxxaWlB?=
 =?utf-8?B?SFlkYU1BMUxRN1d0eE1nZXZzYjkvcWlDSkgvN3pHSXZ4YVpSNnNrS0Y2a3p3?=
 =?utf-8?B?UWgxcjVJM05LSUcyaDFXakNZa1ZSUGF2bC9uUmlVVkNzd2dZTzV6UXlobER0?=
 =?utf-8?B?YnExNFpnZEoxd2N2eUJkbDRmd2YxeTFsck9acDdOdjR2ZjFscUVOQzh5dzhN?=
 =?utf-8?B?RjVUdlViMlNRUmVRQ2VEOFdYbEg5Ti94a0owOWZ6WnBxRFVXMW0vSWRlbVZx?=
 =?utf-8?B?a1pYekE5cDdSLzRmNjNFQnVsQUxFbXNkSlhtZHVGQWVpQnFnbVd0Ny84ejNR?=
 =?utf-8?B?TTVDMFNNdjRYY2JWM3Q4dXZNS2lpVks2b1U3RWZZaGlJWGFsOFp4dlMra2dQ?=
 =?utf-8?B?VXllTm82TkR0anhaTVA4WVFrSjViVC9NVDgxTGNUclRpbXRjVHExWkZ4eStz?=
 =?utf-8?B?MHg1OUpTb09Mb25iQVdNRnRLbSs4OXNVUDdZeWFSRERLUFdmVzR5UVFkU2Fx?=
 =?utf-8?B?WFVTbklIVVJvZGFIODU3M0FjQlNUMTBoc1YwbWJNT1kwMk92dFhJMktoOUdD?=
 =?utf-8?B?MkpwSjNHTTZqU1p4WWlCcVVTbVkxdHpJeFRXa2dENlc4QldsREFraU9YNVFN?=
 =?utf-8?B?UWkraVR4MjRSbFhHMnpYNmhxVWpSK09ybnVMVEhMYmFQQUQvZ3lkQzdCblpK?=
 =?utf-8?B?RmQ1MkdEWlJQNnY5WVErTHVPUjBOWDlBb3JYMG1TOHpDa0FYMkZxL0VlZTd2?=
 =?utf-8?B?WEYzWG56R2g0QWtVNjBCUVhlc3llWUtZTFJkZFFTd0tFcTlnSlQ5NVJYaUdV?=
 =?utf-8?B?NXZSMWR1Y2pPL1BmMWFOV3BBUzJCNU1RS2oxd1BURWhDWlZrMGhOT1U1Ykxz?=
 =?utf-8?B?MVM3OXpaWkhFUDVLZ25xNXUrZzdXSHdHQ1pvUjduU0J2cHVrNlFkYjQ2ZHdl?=
 =?utf-8?B?aVpocGR6UWZjYStxK3NxalVLQ0F6YlZGelBzMWZCR094Rnhvc2h6NWk5QW82?=
 =?utf-8?B?MzRjSk45cWcxLys1ZmtZUUZKbDVWYXJkMEF1MS9HcWpqekpJL1JxdjE2dFZD?=
 =?utf-8?B?dTNvNnVaeFM2N2l1UERvQ3VKUXVKaGpXY0NRNCtKQjR3UkpDYUZsTEgrUWh6?=
 =?utf-8?B?NkpXNGdXWmZ3aEZrZ3VTSzg3K1RGQUdyS1hOZHlKSzNQeDdnVVpRWU5ya3N6?=
 =?utf-8?B?VXl3RUdHMmhXU2RENjF4VWJFMDJEVXpsZnNjMEhZekd6ZGg4RktoRlJoaVdE?=
 =?utf-8?B?RVJWWERBcmRLOGpXRGFuODExdFpUbDlDTS9mM2x0NjJjVllSK2hWZHUvQlZy?=
 =?utf-8?B?RmwzeGdyUUFuSytsUVpsVVBXRFkrUHljWlNXWnZuYVQwUlZGM0dDM2k1QzIx?=
 =?utf-8?B?TnBqZWluNnM4eG16RElMKzc2UFZXTWhFU3VrT0xZSTh5alFSRjJOVmdHeFlS?=
 =?utf-8?Q?+8+VXr+LUSTaWzAG+Ck5yfr2v1ZHHI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2grbFUwcUpXaVpkdEJ3K3lHK0R3WUhYbXJhOXI1aEJEeFljUE96aENCNjQ5?=
 =?utf-8?B?WlNjMjhkUlV2WFQzZVR1Q2kxa2xhNllHUVFGSElzcjkxS2FLSi80aC9vNDRu?=
 =?utf-8?B?TEtQbVpsU252UnFEMzRYbHVCdC8zU0tCOHJmeVZPS1FKeUVnenc2WEFUdTJq?=
 =?utf-8?B?bEVQR0lwdkpWZkthSWhwZE5IcTZ0NjQ4Q1JjUVdmTGdqa20wbVgvcXMvb3BL?=
 =?utf-8?B?NEQ4V0UxdXRKRzJqaHMxclhleXFLdVVjWXJ6Y0JqdlNHYkt6K0wxaDdoWStL?=
 =?utf-8?B?alVoMmx5V3NMOFpoZHhRY3hRdU5IOStuaFc5ZVF6cE1ROW1za2FxMW5obkpV?=
 =?utf-8?B?ZmtYRmtOS3FqSHAyNnAwcTVhL2ZWUmtSeG9LaXZsR00vMnpiblhUdXNQMXkr?=
 =?utf-8?B?ekJvZ1pvSkVDUkQzSW1NUU1QZ3R1clYwZE9VL0g2N0ROcHYxVURwdFVkNE1o?=
 =?utf-8?B?NHRhUm9MbGZOZ2lCTTBFYXRXa1VoY0doTG8rdk90a3lsQXc1UlZkdkhkdmlT?=
 =?utf-8?B?NE1ZemgxRVBYQUR0OFEzQXAvVkdDZzhabG5CeGMwaTlVVmw3eEc0czVBNHZK?=
 =?utf-8?B?S3dDZk8wT0NxanFoZzd2bWtMT2poNFJEdU5QbnVuRXU2QUMzV25NaVF5RFY3?=
 =?utf-8?B?bEFBQ1lJd1pUWXFOanR2bkk3Y21GSWlZSzQ0SXM3WU5NQTVUM05MZ2lNdXZF?=
 =?utf-8?B?b0JDVjZ1Y1Y3Smp3YzV2NUZqYms5MTlhZ2FSbXlVOHN1UjgxM2ZSYzdiOURF?=
 =?utf-8?B?K2ZmTFBrcXd4RVpjMmFweTNGZXJxSStlSDF6VlhlQ1Q3dTJSN1k5allFTFJZ?=
 =?utf-8?B?ODFwU1d0TE9ta01sT1ZJVEtCOHNjdEhOOU9mYXFxVDZrbXM3ZnBrZTNhNVM1?=
 =?utf-8?B?RTdGMVFSaUxHcGdyUUxDYjlZbVRmUmlMZzdCOWplU0JXMVRVNTdHQ29DMXJX?=
 =?utf-8?B?NEFMU2NvZjJxdWJmK1J2VWVYV0d1amxac2tTYVJnL1lFdGJWLzdGL3R1NGRl?=
 =?utf-8?B?WTI3dzhCN240UzVOUzY0VHlodGV4OTl6dHBHVEVYN2p4bi9VRmIrOEVKM0lK?=
 =?utf-8?B?a0JPaUxLVFBpcDZNRlVndnNNZTgzeXcxZWN5eXhMVk92a0pLVmQ2MEF1ekxy?=
 =?utf-8?B?QTBnSTFvZGJGWUE5emEwY2xneXBoQUdZREdaTUpoTVlyUU9yNGFoSlpsWWZB?=
 =?utf-8?B?SGMzYXo1Q1VUc2g4eVZXOUVCNWg1djByVlM3QnR2NnRGcFVqZlBtRUtzTmVH?=
 =?utf-8?B?OVVZMFZKaUJCblU1WjZselNOUEFWeHkvYUIrVmFMTEVsQTQ1QmJTTURvYit4?=
 =?utf-8?B?aitrWW13cTdhS1hzSHFucW1MM1NEc3QxalJ6TFU1aTJIU1l0M2o1c3p2ZDkx?=
 =?utf-8?B?Qk51RFV4R3EzOWkxM2pMaXVwbGJBQW9FS0xDUkJRZGxiR3JWOTZtYVB4VmVJ?=
 =?utf-8?B?ZkV2cGhkSy9mMldQeitOc3NnODlmY1NYN1FEbDdxWnV5bjVCYlRVMlNkb0Ux?=
 =?utf-8?B?U01CVWNpNEVCYTlEM1dTWUdBTEYxRXZSVE9id2FibDNqc0NaVlBNbU5Hd2x2?=
 =?utf-8?B?ZUxMc3gvOXNkNmhaR1RZV0lsVWFZWHVQV3RTLzFNVFJTRGxqQUorU1VuaTNw?=
 =?utf-8?B?NnRRRE9yV3l4Z3BWdXhuMUl6a3JZSjlEaXNuek9SWnQyNWl0WlR3RTBETEcx?=
 =?utf-8?B?Z0hWMGpSUkJYcFREbXRFWkYveHZHaVN0dlkwaGF5REZ0QUE5KzFWa0haeDVt?=
 =?utf-8?B?RE1wQTBhVWRNVnlHRldiVzhRenBKUXdpa3BDd2s0dnhFT2xmMmQ3cjVvTVph?=
 =?utf-8?B?SjY2QThOR1BrM0VHNndSN0hSWmdtQm1URUplSjBuWU5DYVBQSDNFckVZNFU0?=
 =?utf-8?B?Q3hPMjZTc1cwMFVlUzV4SXViS3M0L0IwRjBjb0ZvS1hZTEJQNFBSOURncVR6?=
 =?utf-8?B?VFFZVDFQaG9GcGxOanVkQmV2dGJYdzRacHBkYnliZkdNamtta2VkOURqQ0tU?=
 =?utf-8?B?VlFGZDdSTENsdjN4c3A4Wm55emxZOGhBWjhmeUhtdDVzbk04aEcxenU3eEha?=
 =?utf-8?B?aHlJWTd0a2E3TXZRa1kvbFlKdjVIVTltYi9qRE5MMW5RckhGY0hGWkZXd1px?=
 =?utf-8?Q?NUj3OU2yKT7e/HaMyJNZW3l3W?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f67d6d3-ae32-4e28-d8c9-08ddc0251f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 02:46:23.1840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9GJ0Wm4XiSYJcMYC5fzxul4fBaU8kNwiTfR+EenkNR5KNwlZo/tJgyvg+mF0aGA8uSQecIFEsFg8Jq/nJuuQdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4897
X-OriginatorOrg: intel.com

PiBGcm9tOiBIYW5zZW4sIERhdmUgPGRhdmUuaGFuc2VuQGludGVsLmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEp1bHkgMTAsIDIwMjUgMTE6MjYgUE0NCj4gDQo+IE9uIDcvMTAvMjUgMDY6MjIsIEph
c29uIEd1bnRob3JwZSB3cm90ZToNCj4gPj4gV2h5IGRvZXMgdGhpcyBtYXR0ZXI/IFdlIGZsdXNo
IHRoZSBDUFUgVExCIGluIGEgYnVuY2ggb2YgZGlmZmVyZW50IHdheXMsDQo+ID4+IF9lc3BlY2lh
bGx5XyB3aGVuIGl0J3MgYmVpbmcgZG9uZSBmb3Iga2VybmVsIG1hcHBpbmdzLiBGb3IgZXhhbXBs
ZSwNCj4gPj4gX19mbHVzaF90bGJfYWxsKCkgaXMgYSBub24tcmFuZ2VkIGtlcm5lbCBmbHVzaCB3
aGljaCBoYXMgYSBjb21wbGV0ZWx5DQo+ID4+IHBhcmFsbGVsIGltcGxlbWVudGF0aW9uIHdpdGgg
Zmx1c2hfdGxiX2tlcm5lbF9yYW5nZSgpLiBDYWxsIHNpdGVzIHRoYXQNCj4gPj4gdXNlIF9pdF8g
YXJlIHVuYWZmZWN0ZWQgYnkgdGhlIHBhdGNoIGhlcmUuDQo+ID4+DQo+ID4+IEJhc2ljYWxseSwg
aWYgd2UncmUgb25seSB3b3JyaWVkIGFib3V0IHZtYWxsb2MvdmZyZWUgZnJlZWluZyBwYWdlDQo+
ID4+IHRhYmxlcywgdGhlbiB0aGlzIHBhdGNoIGlzIE9LLiBJZiB0aGUgcHJvYmxlbSBpcyBiaWdn
ZXIgdGhhbiB0aGF0LCB0aGVuDQo+ID4+IHdlIG5lZWQgYSBtb3JlIGNvbXByZWhlbnNpdmUgcGF0
Y2guDQo+ID4gSSB0aGluayB3ZSBhcmUgd29ycmllZCBhYm91dCBhbnkgcGxhY2UgdGhhdCBmcmVl
cyBwYWdlIHRhYmxlcy4NCj4gDQo+IFRoZSB0d28gcGxhY2VzIHRoYXQgY29tZSB0byBtaW5kIGFy
ZSB0aGUgcmVtb3ZlX21lbW9yeSgpIGNvZGUgYW5kDQo+IF9fY2hhbmdlX3BhZ2VfYXR0cigpLg0K
PiANCj4gVGhlIHJlbW92ZV9tZW1vcnkoKSBndW5rIGlzIGluIGFyY2gveDg2L21tL2luaXRfNjQu
Yy4gSXQgaGFzIGEgZmV3IHNpdGVzDQo+IHRoYXQgZG8gZmx1c2hfdGxiX2FsbCgpLiBOb3cgdGhh
dCBJJ20gbG9va2luZyBhdCBpdCwgdGhlcmUgbG9vayB0byBiZQ0KPiBzb21lIHJhY2VzIGJldHdl
ZW4gZnJlZWluZyBwYWdlIHRhYmxlcyBwYWdlcyBhbmQgZmx1c2hpbmcgdGhlIFRMQi4gQnV0LA0K
PiBiYXNpY2FsbHksIGlmIHlvdSBzdGljayB0byB0aGUgc2l0ZXMgaW4gdGhlcmUgdGhhdCBkbyBm
bHVzaF90bGJfYWxsKCkNCj4gYWZ0ZXIgZnJlZV9wYWdldGFibGUoKSwgeW91IHNob3VsZCBiZSBn
b29kLg0KPiANCg0KSXNuJ3QgZG9pbmcgZmx1c2ggYWZ0ZXIgZnJlZV9wYWdldGFibGUoKSBsZWF2
aW5nIGEgc21hbGwgd2luZG93IGZvciBhdHRhY2s/DQp0aGUgcGFnZSB0YWJsZSBpcyBmcmVlZCBh
bmQgbWF5IGhhdmUgYmVlbiByZXB1cnBvc2VkIHdoaWxlIHRoZSBzdGFsZQ0KcGFnaW5nIHN0cnVj
dHVyZSBjYWNoZSBzdGlsbCB0cmVhdHMgaXQgYXMgYSBwYWdlIHRhYmxlIHBhZ2UuLi4NCg0KbG9v
a3MgaXQncyBub3QgdW51c3VhbCB0byBzZWUgc2ltaWxhciBwYXR0ZXJuIGluIG90aGVyIG1tIGNv
ZGU6DQoNCnZtZW1tYXBfc3BsaXRfcG1kKCkNCnsNCglpZiAobGlrZWx5KHBtZF9sZWFmKCpwbWQp
KSkgew0KCQkuLi4NCgl9IGVsc2Ugew0KCQlwdGVfZnJlZV9rZXJuZWwoJmluaXRfbW0sIHBndGFi
bGUpOw0KCX0NCgkuLi4NCn0NCg0KdGhlbiB0aGUgdGxiIGZsdXNoIGlzIHBvc3Rwb25lZCB0byB2
bWVtbWFwX3JlbWFwX3JhbmdlKCk6DQoNCgl3YWxrX3BhZ2VfcmFuZ2Vfbm92bWEoKTsNCglpZiAo
d2Fsay0+cmVtYXBfcHRlICYmICEod2Fsay0+ZmxhZ3MgJiBWTUVNTUFQX1JFTUFQX05PX1RMQl9G
TFVTSCkpDQoJCWZsdXNoX3RsYl9rZXJuZWxfcmFuZ2Uoc3RhcnQsIGVuZCk7DQoNCm9yIGV2ZW4g
cG9zdHBvbmVkIGV2ZW4gbGF0ZXIgaWYgTk9fVExCX0ZMVVNIIGlzIHNldC4NCg0KdGhvc2UgY2Fs
bCBzaXRlcyBtaWdodCBoYXZlIGJlZW4gc2NydXRpbml6ZWQgdG8gYmUgc2FmZSByZWdhcmRpbmcN
CnRvIENQVSBleGVjdXRpb24gZmxvd3MsIGJ1dCBub3Qgc3VyZSB0aGUgY29uZGl0aW9ucyBmb3Ig
Y29uc2lkZXJpbmcNCml0IHNhZmUgY2FuIGFsc28gYXBwbHkgdG8gdGhlIHNhaWQgYXR0YWNrIHZp
YSBkZXZpY2UgU1ZBLg0KDQpzb21laG93IHdlIG1heSByZWFsbHkgbmVlZCB0byByZS1sb29rIGF0
IHRoZSBvdGhlciB0d28gb3B0aW9ucw0KKGtwdGkgb3Igc2hhZG93IHBnZCkgd2hpY2ggc29sdmUg
dGhpcyBwcm9ibGVtIGZyb20gYW5vdGhlciBhbmdsZS4uLg0KDQo=

