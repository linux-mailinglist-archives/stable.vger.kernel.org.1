Return-Path: <stable+bounces-176567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9176B394BE
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 09:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3C1189F744
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 07:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAB62D839D;
	Thu, 28 Aug 2025 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZC/cDPe4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04582D739F;
	Thu, 28 Aug 2025 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364887; cv=fail; b=uWNpK1kv+lW+ho9pKOp3xjrb+6A4SnVp+hZUdl7HdGvXM8OWZfV585p8mLoiteGeTFZZIHW44mnWmHAeCo3t94jP7CnviIlaqbfEyaRJ8XnUYWaSET885/WG+OUmk08BDKNEfqMVqaw9QcVLvvJ6BYvlolQIwE2v6WMlac4UgYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364887; c=relaxed/simple;
	bh=cuysTOEQOd+OchFqpB795dbkKWq0xon5KxZBJFlk3Sk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QgLosldb7hCddLfvlC7tUyFV8Tj4XZ5+TDfa2e8QzoCdCPgRj6VprXbU1GG99SmCCYHE9g3sselMfU+X591Z60fcHpjCMxJs3i2Pncp6tKlMf/8goFduPuZywUS4ts/HfuQiXvNXI3q8OH0J/8neZb5gq3Y2nLICUM3NLrRvUsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZC/cDPe4; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756364886; x=1787900886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cuysTOEQOd+OchFqpB795dbkKWq0xon5KxZBJFlk3Sk=;
  b=ZC/cDPe44dBhe1Mch2Wg4wHuvYHGdcutjQMl67v6xNCSrzsHvboK8hrc
   k58R83B2MlY6hKB5Gm+M6yjI3f5ArFica5lSn9rOpOYc/JtrEP/ginJXI
   WrHiapLzDGHvkoSByAnj/DTH/VVUM1C9MnVdEKUNsH7ICZGgc2l8TcnZ+
   MxmRtgVH8Z2BcdOuH+dsZopdJYqiTTP3IDeQq1uUMOohsjAkCsSt4D6bR
   zJLMLTmcL/P6sKukXQyqhIMukfyedz3zR0JOsB6EYqRWKrZw5SkL1f9hx
   eyzY4fgj02XyzqKJGFwhURSKQPjEwkaX+PRhmA77manE13MKbLfkKk9oB
   w==;
X-CSE-ConnectionGUID: QyMawj0AQdirXR3FuwvP/g==
X-CSE-MsgGUID: 27ItXaDTTMu91VkeRSsZ5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="57824081"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="57824081"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 00:08:05 -0700
X-CSE-ConnectionGUID: z0/MLhGERBC2FDQXSWJQQw==
X-CSE-MsgGUID: wNxde7ywQmuB7/psyvt8Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170425830"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 00:08:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 00:08:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 00:08:04 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.73) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 00:08:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uu0ISreUbpTnpCDYEvGCyBQe2LCv5CdnFjl+HGOwRlCZZpKAxVXF/7k8vjKgfun6HjWx33hrhBhVlIQ2grVIIldS15oqr9utgJkNLNXLKVKg7ya3wJhNkNszevLAk6q1jaFw6Ind1cAyG+t7F6fM0ahCGAoedzXpaCnTMTVvtiBCiAlvfc4hDU6dH2yQ/9F7Q+TFI5BEylKpKKPDGwv60sGI8EEaVplY6rDZEHcNfb2D7NZqfjJBSA4TO6/a1/3LE8UihzOOITIzVrAyWnwAZYmBNjTYjzkYXcLqhLynHnXcc2NnIBSwmxm8sRgE3oPh2iJUZLrrSLy4qSyBELT/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuysTOEQOd+OchFqpB795dbkKWq0xon5KxZBJFlk3Sk=;
 b=O+7pLUmGsKKpdqmhKmPUyK+rpxsTG8i6FpObmEJ9BGLaCAJivp8k+dAbjRKfrLYkM5nWVKdXJecg/5GUECAcy7t7mmbp+iAtpk7PLUNJ1Mez2mY6riUhMNl5fudWq2mdp+ZP6fbKQ0VJjbbcr2R2BZ48pByc8Qu3gYCzdMx6SOtkfp/oipPVUCyXfTxLtuXOYu7vLhGvLeGXacC/ubVYDgRmotCRWAZN2h/370idR4sp7qHWdHcA7wWNTnHBAU3yAX9mvxMgYiC/6m+n7sqHpnIMZeXj+ScnLgF0ILwbywrvMrH2y9dyt2goCsW2TWqEJZyfKvqmYe3yoFGsANU8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV1PR11MB8850.namprd11.prod.outlook.com (2603:10b6:408:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Thu, 28 Aug
 2025 07:08:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.9031.023; Thu, 28 Aug 2025
 07:08:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jann Horn <jannh@google.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>, Peter Zijlstra
	<peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>, "Lai,
 Yi1" <yi1.lai@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"security@kernel.org" <security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "vishal.moola@gmail.com" <vishal.moola@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: RE: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Topic: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Index: AQHcBpLRgrfnVjVEu0GV5qP87jgc6rRVuXIAgAANmoCAAANigIAAAUgAgAAHBQCAAXKbgIAAVvcAgABvkhCAD/fEgIAEtghggAL0soCABGXugIAALw2AgAAXmICAAMGDAIABWVEAgADSmYCAAGR1AIAAE6zQ
Date: Thu, 28 Aug 2025 07:08:00 +0000
Message-ID: <BN9PR11MB5276FCF7D5182D711E135BB78C3BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <20250807195154.GO184255@nvidia.com>
 <BN9PR11MB52762A47B347C99F0C0E4C288C2FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87bfc80e-258e-4193-a56c-3096608aec30@linux.intel.com>
 <BN9PR11MB52766165393F7DD8209DA45A8C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e321d374-38a7-4f60-b991-58458a2761b9@linux.intel.com>
 <9a649ff4-55fe-478a-bfd7-f3287534499a@intel.com>
 <b0f613ce-7aad-4b1d-b6a1-4acc1d6c489e@linux.intel.com>
 <dde6d861-daa3-49ed-ad4f-ff9dcaf1f2b8@linux.intel.com>
 <b57d7b97-8110-47c5-9c7a-516b7b535ce9@intel.com>
 <c69950ee-660b-4f51-9277-522470d0ce5d@linux.intel.com>
 <400cf9ab-de3f-4e8a-ab0a-4ac68c534bb8@intel.com>
 <ee44764b-b9fe-431d-8b84-08fce6b5df75@linux.intel.com>
In-Reply-To: <ee44764b-b9fe-431d-8b84-08fce6b5df75@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV1PR11MB8850:EE_
x-ms-office365-filtering-correlation-id: 9e458bbd-874e-457a-83c3-08dde6019fa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VWNpOVZINFRROG40U0oxcEZqYUJMcWpuejl1bU5lcWp1MlBRb0VmczYza2Jh?=
 =?utf-8?B?MHo3QUUxdDVscWpJYlNpUkZ6UTVFK2dOa3hrbk1aZGFVOUVaTGxEbS8xeS9O?=
 =?utf-8?B?L00zNVBYWk44SE1xV29qT29WRkluRlJrbG13aGExc2MwOXVLcURJOFhkd1o1?=
 =?utf-8?B?RzZrejVyOXQ4QnR6aVEyb28xQlpkcmk1LzZSZDdob3VZRDBYSWhvb2MrZGxN?=
 =?utf-8?B?OW80WHUzVm5rdHFUbkVUaTRuZnNmZTRpTVpSVlRpR2VrUW5GSnZWRjUxZngw?=
 =?utf-8?B?RWtZeXYvblN0UVFVVWFPclBJSG41Rm5LdUs5UkwxMjZDbmhocW5aVzE0RXFp?=
 =?utf-8?B?d2hROGJzbThLaUI2d1o0bFVTZngvTWRKVDA0dE54S3JlYS9oSGJURXI1Rk42?=
 =?utf-8?B?aXJOcmpSMDJiWEFQWnlXYnhibytNK21tdXRrLy9iMjRHenBNZE5Sc3JtdnFH?=
 =?utf-8?B?c2JraU5ITFhJaWg2Z1FaQkFPaFBpQ3F0bkcyaklPUWx4TFUrcFdXclIwSDA1?=
 =?utf-8?B?aVM1RHFXbkluNmNJRi91UExvNDdsTHBHZnFRT2o5S1ZEd0RkcUdsRjlrMlZy?=
 =?utf-8?B?WHZtR3ljQzJLUStyZkxXbE8rUlhlTTIvTVB2TktEa0kvUkdRQlNlTHRGSzQ0?=
 =?utf-8?B?L3JmczNkM1lZVDNxZU9ETnR3by8wWXZEZVRTMUJncjhrby9PcENuOHp0dkVh?=
 =?utf-8?B?M0ZRdnR3a09FRDlQUTIvTm5SVVBUc2k2ZHhTaEdMVWFsNHJtOVJTY3RNSDdH?=
 =?utf-8?B?aFhGUUdob0htUEV4MVV5M2pqVWFPK2ZRalFNNWNadk0zamNaUjlpQkVkNFd3?=
 =?utf-8?B?V0UwYkZBT093WERhUzdsRUwzVUxPVlNTS0hDa3dKVG1jbnlLS3JLSGxkUVY1?=
 =?utf-8?B?WkcvK2ZQNkhxN1FZVkNNTlE3aVB3R29Wc0JUY0pLMCtyK3kxaldjcHF5TTRJ?=
 =?utf-8?B?V1Via0hLVVNyMmpTeEJWem52VGw1ckt1UElaeS9BdEJzUlZUaXFSSHB2R0N1?=
 =?utf-8?B?RzFoZEs3V210R0RPYktac1BLQVlucDBoRmgxa0puZzRNUUlNOE53eTlUQTlL?=
 =?utf-8?B?a0VjUWdUeGo5dC9yMEtqNU9pRytBS1RSMjl5Ui9nMG5xM252bDlLQzRLT3Ja?=
 =?utf-8?B?T0UyZEpzR2VXcjNuSTFTMlBGTlBkV1I4aXhhbHpXS2E0NUhsNGZLSy9NejRT?=
 =?utf-8?B?MWJNKzAxSEVBMEFXdlV3TEdTZ0djNTlheHBZNERraDhNWFRzWHFaNkZDL2xw?=
 =?utf-8?B?L2NCdnRwR0E0Vk9kU3M0WFZzZHAyQ09vd0VPZU10amNsK2l2QXc0OUQyNWtk?=
 =?utf-8?B?RFM0U2F0Tkc1VDJSd1VoVUcyNzR5L1RMS08zdjYyUDBJZzNoU2FpTVJBTWxM?=
 =?utf-8?B?ZkN0YzVOcVBrZ1VYL2dMbGU1dUt6RFpVTWhHR3VkVTlNTGE2czUxTHEwNFdQ?=
 =?utf-8?B?Q2FneThaMDdkQ21lM2UvZTBzSUc0WDl6SXlEMDlteFdjMnk5aTQ4R2E5SFJq?=
 =?utf-8?B?VHpxM2oxRUdhK1ZKUThobWo1LzRBT0FkZjhuSnBNSFJaTDVXTzd2c2pXT1F5?=
 =?utf-8?B?V0FPTk5LYUI2QVNOZFQwcEpvVGxRNkFibmNTdVVZU0MvaGt2RS92WExxU2ti?=
 =?utf-8?B?dFh2eTlaVFVSYkhzMGFmVDRydHR2UXkyQ25QYkw0aTZpWStpU0tJbEtsK3RU?=
 =?utf-8?B?RlkxMnRZbUFPVE5tR0FCeHhOOHNaYkJIWjhYUHppbXZyT1dLN203S2ZEZk5v?=
 =?utf-8?B?MDBnUms3VGpSeWtoRXRqWW4zcksyZXAzU2l0QTBHb0w5TDlDenlwMFprNGxz?=
 =?utf-8?B?bWpRZzhoOVFIQS9BV05kemtRcFJDQVh4dHY1N0k1NW54ZlU1ZkdGQ09aaW9L?=
 =?utf-8?B?am8xVmw1Q2VSQ0FpelJ2UEFKTVBMa0t3aExTbnMwOFNhUmF5bVJUS0o1K2hH?=
 =?utf-8?B?eWxlcFpjQTlEUmZ1ZHlTZzRGT0U4TGEzRXo1MnZXcTdIbFJJVDNweHF1aC8r?=
 =?utf-8?B?WUtkT2IrQXpBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU4rOU1kaHg3YzZkbzNzNUpabEFyYk83cEowV0QzQmRZNTZTMnFCdWpXUkFW?=
 =?utf-8?B?bjFwUTJhQkVVdUJxTjE1R2kvLzB3TWJMYkpNY0dvQ2xMZWNPZ2hrMTkzcW1y?=
 =?utf-8?B?TjZIRVpyaEkrM0lkbm1WQ0tLY05lK0NVSUttNDNRUnQ5S3VHeE1HMWJSUjZq?=
 =?utf-8?B?YmpCOHVHVS9lUzBaT3JqNlk5RUZFbW9TMzgzanBFb3NBT0FhN1c4RGQ4VWFp?=
 =?utf-8?B?NnVoWmNGMTdZQlZGWUM1TlRYYmtlc1dSSEl4QVhzL1VSOC9EalhuT1o5NWJp?=
 =?utf-8?B?OTRWSG5vRklOcHArU3JHZmlROWpUZ0Z4QS9Jd0ptMTQzVVpOSTdJRlRUWjJU?=
 =?utf-8?B?eDV2WTNXTmMwdTVCTUthT2NVaDNSb1BFU0FZR05vQnhLOWhIbVlVdHpqZlBX?=
 =?utf-8?B?eG9MVVU5emxvLzRuRUE2K0YwNk0vcE1NaTZvM3ZUZUgwNjArNDgvQklFUWJ0?=
 =?utf-8?B?ZUwrWHJIUlVyazNsTTlESFpDMDBwd0Y2czc2ZkhnQUpNWE5XL05ZT2RENGs4?=
 =?utf-8?B?WXErRWoxNCsvMnJVWWdHdkJ6eXFtTVBncEppditRVG9FbmROeWdZY1l3eit5?=
 =?utf-8?B?TklBLzE0VEZhQk5oZnhNbG1XZjZlWVMvdVpKNE5wS3ZRL2hSYlhGYXp0QWZr?=
 =?utf-8?B?RmlyUTRIcysvV1lDSzRka2Yya3RDREZVaXkzRnJNL2podEh6aHQyU3JXYnJN?=
 =?utf-8?B?NEJsYXFYNjkxZlFrUVh6cEdqVHV4ZFh0UWpYYnM2Y0RzQTZFYnRrd3cvYVJk?=
 =?utf-8?B?Z1lqWURmTVNnTGdETmRDUExVQ1ZwWTVhUWRybTBiNFg4OUlDSVNzRUlscHdB?=
 =?utf-8?B?L0w3a2RtZlFjc3Q0Qzl5RXpqZEJoMWNVTDJINnY0WjAyR3lnL01RL2w0VHpV?=
 =?utf-8?B?cUZ2K0NFUUhFdEY5YzJaSmNoclltNjhKRUFKV2dVN0xwOFhtTlFGaUtpWG9j?=
 =?utf-8?B?VlZaajJQYUs5cGg0MEptbkRydVlZNDM0eXF6Y1BtNmo1VGFaUFBheFlWMk83?=
 =?utf-8?B?QUh3bnFCRnR3MG9qTXN2bDlTY0ZWenBIcFdpYWJ0U21uQnAzdmRoeUpWWHFz?=
 =?utf-8?B?SXVOYTJ5UG15UEJnNmpIU3FmeUNqZDlwVWxneFhCRzlmREU4dHVWVnBBSGwr?=
 =?utf-8?B?b2NHZkhPNHBLR0UyMGFka2NoNGZlQmFCcGMwNzRva1A0RzZLd2tPQmtjWFB0?=
 =?utf-8?B?bUVSazRHazVDQjVBTk5KbmVRRlA4NG81LyswMUUwcWFwbTdIM1Z1NzNSTUkr?=
 =?utf-8?B?Y1ZqTXVtWmdUcXM4aHNKeUVkRXpPbVpwM05ZU1pSYS9JMXp4U294R1RCSk1S?=
 =?utf-8?B?ODhIc1BFTTVNamFYSjJPSmVMZFJwVDhXcHFHTlExSkdzcTZoNHFKd1RlU2Ur?=
 =?utf-8?B?aVJuL2lvUS9CQnd5bUhvNEtzRmhwYmkvTzNBQ1huSzJjY1NncU5BbDYvZW5P?=
 =?utf-8?B?U2JRVHg2MjJnM2pSVko1NXRianFJZWh2a2dDNFBCdFVwYkoyR0RtYThlYUdp?=
 =?utf-8?B?ZnpqdnVnZmJOeXRLS0NLUXNUWTl5TGo0M2hURHVlaVlrMndSTmFFNkxzVjdh?=
 =?utf-8?B?N1VtY0dETXN0eUI4MDIrMVIxYW9vODh0ekJXNjZTa2JOU2lyQk8ycFVsOXRt?=
 =?utf-8?B?K0NSSDVDZWVjalVnSjdKWXB4RVQrZ0NINFZ4bXV1YjYxZmJaTFBKRGlncXlK?=
 =?utf-8?B?UGFjYnRaTEhVR2I3QjJEYm1EeWhRdmYrL0wwME0rdXFWU212KzBaVTZKYndy?=
 =?utf-8?B?aVl0UkJKclZHb09mTHBNZ3pwbTNEUFdVcFR1TlZZbmJURGdBRW9CN1FMc0lE?=
 =?utf-8?B?cEx0VTFSclE5cU5lc2lyMzBhZDlpOWU1bWUyZmZiekh4RmdNdXA0UW5GUkNk?=
 =?utf-8?B?bWc5WTBOVmVnd285NUF6WjJjZkhHdi81ai9Va2RscEIxWm9kOGZ3V1VmTXRy?=
 =?utf-8?B?L3hnQVVPZUdSQnJUamo5K0c4bzg1K3dOSVpjTFoxR1FaTU10dkYxbEQ2TktN?=
 =?utf-8?B?Um5aZzRiZUJKeU00bk16SWtMU3pSV3A5TVE5L0w0KzhEMEs1ZkQ2cytnVGhh?=
 =?utf-8?B?TG5IR2xtNENjbzVmV1NUOTFyeklCaEMzVGt3c2JOVG85QmRiK0NwRTZMY2Zx?=
 =?utf-8?Q?QtwPETnVxTp2wir3ckOrD3fle?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e458bbd-874e-457a-83c3-08dde6019fa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 07:08:00.3559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FqReonQNS5BONIo6NRwFO3/67yXVHOc8lX3OsrU18N/IlPSMdG1sLqhcZr55Dze7clbacMNhVd/nrGqGFDmFAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8850
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgQXVndXN0IDI4LCAyMDI1IDE6MzEgUE0NCj4NCj4gQEAgLTQzOCw3ICs0MzgsMTAgQEAg
c3RhdGljIHZvaWQgY3BhX2NvbGxhcHNlX2xhcmdlX3BhZ2VzKHN0cnVjdA0KPiBjcGFfZGF0YSAq
Y3BhKQ0KPiANCj4gICAJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHB0ZGVzYywgdG1wLCAmcGd0
YWJsZXMsIHB0X2xpc3QpIHsNCj4gICAJCWxpc3RfZGVsKCZwdGRlc2MtPnB0X2xpc3QpOw0KPiAt
CQlfX2ZyZWVfcGFnZShwdGRlc2NfcGFnZShwdGRlc2MpKTsNCj4gKwkJaWYgKElTX0VOQUJMRUQo
Q09ORklHX0FTWU5DX1BHVEFCTEVfRlJFRSkpDQo+ICsJCQlrZXJuZWxfcGd0YWJsZV9hc3luY19m
cmVlKHB0ZGVzYyk7DQo+ICsJCWVsc2UNCj4gKwkJCV9fZnJlZV9wYWdlKHB0ZGVzY19wYWdlKHB0
ZGVzYykpOw0KPiAgIAl9DQoNCkRhdmUncyBzdWdnZXN0aW9uIGlzIHRvIGNoZWNrIHRoZSBuZXcg
cHRkZXNjIGZsYWcgYW5kIGRlZmVyIGluDQpwYWdldGFibGVfZnJlZSgpLg0KDQpib3RoIGhlcmUg
YW5kIGFib3ZlIGNvdWxkIGJlIGNvbnZlcnRlZCB0bzoNCg0KCXB0ZGVzYy0+X19wYWdlX3R5cGUg
fD0gUFRERVNDX1RZUEVfS0VSTkVMOw0KCXBhZ2V0YWJsZV9mcmVlKHB0ZGVzYyk7DQoNCj4gQEAg
LTc1Nyw3ICs3NTcsMTQgQEAgaW50IHB1ZF9mcmVlX3BtZF9wYWdlKHB1ZF90ICpwdWQsIHVuc2ln
bmVkIGxvbmcNCj4gYWRkcikNCj4gDQo+ICAgCWZyZWVfcGFnZSgodW5zaWduZWQgbG9uZylwbWRf
c3YpOw0KPiANCj4gLQlwbWRfZnJlZSgmaW5pdF9tbSwgcG1kKTsNCj4gKwlpZiAoSVNfRU5BQkxF
RChDT05GSUdfQVNZTkNfUEdUQUJMRV9GUkVFKSkgew0KPiArCQlzdHJ1Y3QgcHRkZXNjICpwdGRl
c2MgPSB2aXJ0X3RvX3B0ZGVzYyhwbWQpOw0KPiArDQo+ICsJCXB0ZGVzYy0+X19wYWdlX3R5cGUg
fD0gUFRERVNDX1RZUEVfS0VSTkVMOw0KPiArCQlrZXJuZWxfcGd0YWJsZV9hc3luY19mcmVlKHB0
ZGVzYyk7DQo+ICsJfSBlbHNlIHsNCj4gKwkJcG1kX2ZyZWUoJmluaXRfbW0sIHBtZCk7DQo+ICsJ
fQ0KDQpXZSBtYXkgYWRkIGEgbmV3IHBtZF9mcmVlX2tlcm5lbCgpIGhlbHBlciwgd2hpY2ggZG9l
czoNCg0KCXB0ZGVzYy0+X19wYWdlX3R5cGUgfD0gUFRERVNDX1RZUEVfS0VSTkVMOw0KCXBhZ2V0
YWJsZV9kdG9yX2ZyZWUocHRkZXNjKTsNCg0KPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBwdGVfZnJl
ZV9rZXJuZWwoc3RydWN0IG1tX3N0cnVjdCAqbW0sIHB0ZV90ICpwdGUpDQo+ICAgew0KPiAtCXBh
Z2V0YWJsZV9kdG9yX2ZyZWUodmlydF90b19wdGRlc2MocHRlKSk7DQo+ICsJc3RydWN0IHB0ZGVz
YyAqcHRkZXNjID0gdmlydF90b19wdGRlc2MocHRlKTsNCj4gKw0KPiArCXB0ZGVzYy0+X19wYWdl
X3R5cGUgfD0gUFRERVNDX1RZUEVfS0VSTkVMOw0KPiArDQo+ICsJaWYgKElTX0VOQUJMRUQoQ09O
RklHX0FTWU5DX1BHVEFCTEVfRlJFRSkpDQo+ICsJCWtlcm5lbF9wZ3RhYmxlX2FzeW5jX2ZyZWUo
cHRkZXNjKTsNCj4gKwllbHNlDQo+ICsJCXBhZ2V0YWJsZV9kdG9yX2ZyZWUocHRkZXNjKTsNCj4g
ICB9DQoNCnNhbWU6DQoNCglwdGRlc2MtPl9fcGFnZV90eXBlIHw9IFBUREVTQ19UWVBFX0tFUk5F
TDsNCglwYWdldGFibGVfZHRvcl9mcmVlKHB0ZGVzYyk7DQoNClRoZW4geW91IGhhdmUgcGFnZXRh
YmxlX2ZyZWUoKSB0byBoYW5kbGUgZGVmZXIgaW4gb25lIHBsYWNlIChyZXZpc2VkIG9uDQpEYXZl
J3MgZHJhZnQpOg0KDQpzdGF0aWMgaW5saW5lIHZvaWQgcGFnZXRhYmxlX2ZyZWUoc3RydWN0IHB0
ZGVzYyAqcHQpDQp7DQoJc3RydWN0IHBhZ2UgKnBhZ2UgPSBwdGRlc2NfcGFnZShwdCk7DQoNCglp
ZiAoSVNfRU5BQkxFRChDT05GSUdfQVNZTkNfUEdUQUJMRV9GUkVFKSAmJg0KCSAgICAocHRkZXNj
LT5fX3BhZ2VfdHlwZSB8IFBUREVTQ19LRVJORUwpKQ0KCQlrZXJuZWxfcGd0YWJsZV9hc3luY19m
cmVlX3BhZ2UocGFnZSk7DQoJZWxzZQ0KCQlfX2ZyZWVfcGFnZXMocGFnZSwgY29tcG91bmRfb3Jk
ZXIocGFnZSkpOw0KfQ0KDQo+ICtzdGF0aWMgdm9pZCBrZXJuZWxfcGd0YWJsZV93b3JrX2Z1bmMo
c3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiArew0KPiArCXN0cnVjdCBwdGRlc2MgKnB0ZGVz
YywgKm5leHQ7DQo+ICsJTElTVF9IRUFEKHBhZ2VfbGlzdCk7DQo+ICsNCj4gKwlzcGluX2xvY2so
Jmtlcm5lbF9wZ3RhYmxlX3dvcmsubG9jayk7DQo+ICsJbGlzdF9zcGxpY2VfdGFpbF9pbml0KCZr
ZXJuZWxfcGd0YWJsZV93b3JrLmxpc3QsICZwYWdlX2xpc3QpOw0KPiArCXNwaW5fdW5sb2NrKCZr
ZXJuZWxfcGd0YWJsZV93b3JrLmxvY2spOw0KPiArDQo+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9z
YWZlKHB0ZGVzYywgbmV4dCwgJnBhZ2VfbGlzdCwgcHRfbGlzdCkgew0KPiArCQlsaXN0X2RlbCgm
cHRkZXNjLT5wdF9saXN0KTsNCj4gKwkJaWYgKHB0ZGVzYy0+X19wYWdlX3R5cGUgJiBQVERFU0Nf
VFlQRV9LRVJORUwpIHsNCj4gKwkJCXBhZ2V0YWJsZV9kdG9yX2ZyZWUocHRkZXNjKTsNCj4gKwkJ
fSBlbHNlIHsNCj4gKwkJCXN0cnVjdCBwYWdlICpwYWdlID0gcHRkZXNjX3BhZ2UocHRkZXNjKTsN
Cj4gKw0KPiArCQkJX19mcmVlX3BhZ2VzKHBhZ2UsIGNvbXBvdW5kX29yZGVyKHBhZ2UpKTsNCj4g
KwkJfQ0KDQpUaGVuIHlvdSBvbmx5IG5lZWQgX19mcmVlX3BhZ2VzKCkgaGVyZS4NCg==

