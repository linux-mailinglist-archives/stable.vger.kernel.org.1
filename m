Return-Path: <stable+bounces-100541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0139EC5C8
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1577162EFF
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AE01C5F39;
	Wed, 11 Dec 2024 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9x4hCz0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6171C5F35;
	Wed, 11 Dec 2024 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902987; cv=fail; b=A1TNwsGeZy6X1yUinm+V8dRtOOV67x//QrB5+hVdxgDSqpCbcpReBZf7eTizsE35RDWgWZuMxKxBlzl5LpkpqNV/RC8i/CXA17iWVjH2ra1QgDMX+NpWipsT234xOsf9FM+FdXkrFWGaeNBVdhs8fc6686dgjoYSJj37kghau2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902987; c=relaxed/simple;
	bh=ligOMGrKKn1KUhcf8n/qG+m9cA+LGtp/stYZNnaNZ0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BzZwjZvAzh+P4ECA9JtweJftibwmyJBfeZvfh2lArkkpvZfx2+61G+EnNawWyL920nKTwr3q2Lzoe7zWij8NRRyzDhwAHMy07hqrMUokuBJcbkHdZdquLlX+vVS22erMogy8nFCPmyAfjUZM96VUzk+5q6poXF9L2clvDnRTjAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9x4hCz0; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733902985; x=1765438985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ligOMGrKKn1KUhcf8n/qG+m9cA+LGtp/stYZNnaNZ0o=;
  b=G9x4hCz0tUEFkImW76vb1U6I4n/jiyhuYRD/OMn5XHi5L3f2F0GMJMsi
   5vXqF2LqC/w5WpOiQFHKldX9Yv7OAjQzeaVNb+XfCRSvYQe28+RQRzaOM
   xasAb2SChNziAxvxOUsld/Z+cMvzeuKnnNii6oEJr/GhKx2ArLC9G78ob
   DNnfQ30xwNmuW7KVgf6Y/PcXOp55fB/PxJQOG3suP4vhBqOY4YHF5GOd4
   BjjgPbEKSiojiNyKWS/UQFW5OkjCmu8f8cAn9yx7XYQW/4Kp4mCue5KzN
   0h53Jpt0EnoQHtsk/y4bh+29edx9BMAdDlx1G1rXn2rmt/BY43w+1ohHD
   A==;
X-CSE-ConnectionGUID: lQme541BQ3+axezoPDlRZw==
X-CSE-MsgGUID: egeWDeQuScahW1oUOFwT1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38201119"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="38201119"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 23:43:05 -0800
X-CSE-ConnectionGUID: dgXAGckVTGCs+pOv02cgRA==
X-CSE-MsgGUID: bazHCZTPRnWzfVQkLsvWcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="95404845"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 23:43:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 23:43:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 23:43:04 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 23:43:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6beSF18WfvqLkXkSq5BSK1blXnaBhXFvH6nwY80jSoGrj4VS7O2mTPScphSNgM++1OUG45a+hKAr23QHy/zWSML1bg+PccuE3rn3pmoDrUohb28+wrL++qfZ0n2OlhO8Vn1hta2elI1PH0DDz82fCkN5YwaCJiuKTwgNLVIT9ZLadMURpD+2AonyFmdnEPeL3yZh2CvwC5LMFCTBVx5qMXw3q/I/spVvSTYr7HGXPPqSnu/9PpyMbLKa2ii0cJhEfGi1/aER87+U1j1pYhO+cqGUkE5VRZvQqPX2z63jiQD0Vnd9ot1Zdf09r1vphBZgUxfdLvnHm5JcNZxmMh8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ligOMGrKKn1KUhcf8n/qG+m9cA+LGtp/stYZNnaNZ0o=;
 b=iHf9VmhspNrOpbUV/9pUAFQkYxeUitMOJSJ2tsakzPMTBk0gAqvSZkmqmjpIYUySI2n8rbVolk/7GUvh7mlkZ94t2xjDESuLanuX7BxPCxt/onF8vKu6CIjD+Qhj6HS6VQYEnGofgpDxneAn6+mKIFB/dZWUbjJV7J3U5UEEIV6ehm+MMXfTyMcZ9zjYmiIana5hP3fuH64R2IP5cJFDEZILIq0NuLF6IlzWzhxIm91/dY0cKKf+W8+8kc40mH1P1UInNO9LWlgxkRddMm0JZWXHPrUT8w3khGPITqtIoAZKRx1vYnKh+hC02828k0TfTI20J2cT+D2bptCR0mf2+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.22; Wed, 11 Dec
 2024 07:42:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 07:42:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] iommu/vt-d: Remove cache tags before disabling ATS
Thread-Topic: [PATCH] iommu/vt-d: Remove cache tags before disabling ATS
Thread-Index: AQHbQgNTcXtiehtWr0+Kz5LMkuaPH7LgtcIggAAErQCAAAGroA==
Date: Wed, 11 Dec 2024 07:42:34 +0000
Message-ID: <BN9PR11MB5276FC1759F1119C718802848C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241129020506.576413-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52766D13B14053E5B6CFE7D48C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <0899838f-7845-48e3-a5b6-7a2d00ce0bac@linux.intel.com>
In-Reply-To: <0899838f-7845-48e3-a5b6-7a2d00ce0bac@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7925:EE_
x-ms-office365-filtering-correlation-id: 91869cb3-dd66-42bf-d6f9-08dd19b7608f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MURKRXpaSjNtbEFyaUJKRExhYUh3TDVNUUJ5RjNzQS9UL0ZEbHhGaFB4eUky?=
 =?utf-8?B?YlppT1dHdEpLZ0NsMkwzNDJiZ3lKSFlEQlBicXlUSEpMMjZ5MWU1ZDF1UUY2?=
 =?utf-8?B?WXhQL2JXZk12bUFMSzcyWCtYbUp4VUM4SWhCOE5pOTEzSXR0bmVWcm5kZGRt?=
 =?utf-8?B?RTFJa1pydGtQLy9ZTEUvMTBMOUlGVDJlRnhJRmV3TmZBT1F6OFRWSDA3Vllu?=
 =?utf-8?B?b2x4cU9VQ2dZbXowYkRXb05zK01mblVtQmdCTzFFRVp1U01VWXQzNjdTTjk1?=
 =?utf-8?B?dEZ1RGRaa1RFbjlhQVpkNXNsQlRRZzFBb0p6eGlCK0JyazB4U0NsR3hzTzJB?=
 =?utf-8?B?M3MveDZBTEtRWHpHWTJ0elA4elFrMXgxVEl6T09VVTY3SzUxcktTakVkYUZP?=
 =?utf-8?B?TXJMYlpxYUVRMjRTSzBVOXBxSjhKdVB0QjRXcHRnUDBsNU9VRHVMbjJxUG9Y?=
 =?utf-8?B?RUQxeXFBY3N5TC9GdzFmU043eHpkOCtLVmt0d2lyS3RRcEo1R1A2S05Xb1lM?=
 =?utf-8?B?UlhjWGRoSlB3L08rcndudWJHWUlva1VaRnNwQ3NMeWU0SkdoYitvLzdzckNZ?=
 =?utf-8?B?VHpGanZuRnVPSXJXWnJVRGZhckRGb1VTTW5yZGQ5T0Y3M01VMU4ydGlkNFp5?=
 =?utf-8?B?Yk5DeGZxMDczZWtET3RkcGs2a0p1ZkZuMEkxMHQ3a3lxckxPc2lXT01Nbk9Z?=
 =?utf-8?B?VTdZaVhNbHhFYjVvYllKNlloeVdzQkYzUElEajFad2ZUMCs4Z2N1MlUrWlN1?=
 =?utf-8?B?L3Rqd2FxM1FzeStaSTJ4LzJJY1F2WXpJYWY5d3piYjd4T1o4UlA3OWdoUDRq?=
 =?utf-8?B?YnhlLzV0NTR2MllrRSs0UjJUTUlza3ZpYjAwbGRLVHJGa0NRVTg5d0R5UHk2?=
 =?utf-8?B?cmlXWk9DejZDa29ZUVhFUEVtU1pZZWZMSFBRa3pYbmJtOXY0NDVjNklzLzhZ?=
 =?utf-8?B?S00zQS80TGd5UmxRZDhiTVJDR3VJRFk3ci80amovUTlGR1lzYjczSjgrUGxs?=
 =?utf-8?B?RHBBa2FMcnFFc2R5TkVleElCc2NUNzN4QTZTbDlzSkYxYWgzS3d6MGkwRndk?=
 =?utf-8?B?VnY5cXNGcGRQTGxUbFRjazVhZThYd2NhaHhMQUQvTmxtdC90M09HeEVoTmpH?=
 =?utf-8?B?MUJIQ1BodHlDTWgveFJaWU9uV0ZOUmExM0lsNzRwL0dIdnR1dWRMWFNWK2pn?=
 =?utf-8?B?bU5pUlYxQTFlYmtBZXU0eXhvcDlwbDV3SnYrOUN4YlVvYUZnSlZCMndMSWFn?=
 =?utf-8?B?eHprdGIwdkxycUxFMWlqeFFwbTBJTkpQUGVLRlg2aHlSNWVhTzM1a3pZZ0Jt?=
 =?utf-8?B?bjYxbXRDcjFRd0R0ZlMwOEluN0h3RUU3TDVjcXpyanA4UmpmY3RxaGZ1R08v?=
 =?utf-8?B?a3dSTEZ6NHNqNG9lTWowbmFydmtBUThKbFdHZ2R4RXNYeERuRkNHNFY3NGdX?=
 =?utf-8?B?NDl2REFxZUxtZGUyNHpIbWJHczlkb1FUV000cGoxSGNCSER6ZDcrVHdXOE80?=
 =?utf-8?B?YnpITWh3S1dSMmhOUUFJMCtjOUl1MEhqWTFpNDN0WkRQb0c2RzVXNGl6bEV6?=
 =?utf-8?B?NXRIYnk5NFF3NFdqa05SbnpqU0VadGZoQ2tDbDlkWVhzT1J6QVFpS2RtNWdL?=
 =?utf-8?B?cTdja0RNbmpyejNwcGRaWFR5SFptWE9vRmw0Rll6eHlWWEJyaDNQMzVwTUxW?=
 =?utf-8?B?eWdYdVhsWmpyQkdCQ1k4OUNDdWNCVTJaMFNXdmNEVkFkM1ByWk9reGYyd3li?=
 =?utf-8?B?U29UNCtUV1hGbFFqQUkzY0ZBNTAvWFBWV3JPQ0JkRGRxZDFnaWVSejl1eFk4?=
 =?utf-8?B?QnJMQktlVWRwT1I3VE1zM01mSTF4SzExUUNCMWs4a2ROQzNTVFZYekJEMXM3?=
 =?utf-8?B?ckxBMmZLamZ6ZlVrRUtlMVNmM3JxRUcvclRmdmVHbElyREE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2F4ZjFqMklJMWJITUdzdmZrUjY1UGlaMW5HbEkzUjdxMTdZZTc4Wk1hSEhi?=
 =?utf-8?B?d2pLcTNiaXQwelBGOWRWcmZmMDdBNDZmR0grVHlBZ3VrM2tYeVNxSWs1bWZN?=
 =?utf-8?B?Ymczb1p3YWU1OVEzM3E3aTlRdis4WmptRlVQZE5ValdsWWFYeG1BdUNqaXBZ?=
 =?utf-8?B?TDF3eEw2SWhpUFh3QzNhd1BZWmNiMitnR29NNVpEOHpmbG5LdmdIbzB1Ynds?=
 =?utf-8?B?cUJ6akNpdUhHU2xRYk5jWmovTCtjMW01SDFWa1Nob0ZJNHpWM0tQMWtndXpT?=
 =?utf-8?B?UzVZbkR4SUtuUmxOS1NBWmlEVm5EaXJCT2V4aHZBaU9CZVN1VHgrb0lSMm5r?=
 =?utf-8?B?ZnlsZSthOG5UZUppdWpIWjBFekR1VUJabXJuRzNuQnRNclhybWdtdlJQRGZW?=
 =?utf-8?B?UncyMWJqaGFYYWpOSVJMMm1MUW05dHJlZTBPbm1lOWtxbnZzcEtSQmlGU3NN?=
 =?utf-8?B?blhQMEJwTlkzTTljMFBHdEdKbDBiMlRNSkk0akNYeGdpZDIvNFhLWU51WVlV?=
 =?utf-8?B?MmJWUjZKQzJJd0tscGovV3hURVF5ZVBsRlI2alZDNDhEUE5jWkY4R25FMnNR?=
 =?utf-8?B?dUJzZ0YyTGR6RU9nSEE2VWVyaG0zSjhuL29PZG1iQ0ZZRmk2K2dPMDNYMkJL?=
 =?utf-8?B?R1FpS0l3VWM1cEVSRVl1YlVkTjVzVWJNc1Z3VC93QTN1NVdFdVBFaXFwa1Mz?=
 =?utf-8?B?NHh5VVVqTjNyOGFJTnhvZFlENFp2VjE1V2ZWRng1dVZOcHRFZWwyWHlDcG5h?=
 =?utf-8?B?cyt6dVMrNWN6WXFyNTV3aVJOL09xbVhKOEhzL1lZdDAybkxIRm1UQjUvZWR1?=
 =?utf-8?B?eFV3MWs5K3lJREl5WXRnWkFrT3QrK3BWUURvQnlZTG9rdUlTakpESUYxTE9N?=
 =?utf-8?B?UTdpd2pjOG15d1NlZFE5TmNIeVJhbEo3dTBINWZrcFZKOU9EcmcwamdVWk1V?=
 =?utf-8?B?UnNJTzVYTVZGanloT3lETXRSUmM1bzhCbVNvV0JIR2xBVjlnT0RJbVh4blF3?=
 =?utf-8?B?dmE5ZTd4V0x1cElkZWsvYzFDdCttbmZ6VFp0WER1NE02Z2xOajcvODVlMlh0?=
 =?utf-8?B?RGpac3Y3SHdIUG15eVVzRklZamh3YmkvN1N5azZINHNScDcraXY4NVQ5b3JZ?=
 =?utf-8?B?V3Vpd3BTZ214L0YyL3lBOE1CcnJabXFyQmNKem0xS25jOTBmaHlMQ3NtZEVR?=
 =?utf-8?B?cTlRSU5FbHJNUzJ4WDF0V3Q5ZFp0Sm1VUU1nQ3NTR3E4U1liVzc5YVMweWpB?=
 =?utf-8?B?SDdJRHovQ3k1VlY2TDJWc2VxWlBJWnlKRDUxRjFsVUJDSlljRC90M2lPVFpu?=
 =?utf-8?B?eUpDdDNTd2J0SGl3VkY5RndzcGpxdkpaTHBJM3YwamYrZGJWYnJ0ZXgvbml6?=
 =?utf-8?B?YUl5ZzA3SWJOWkZzT2pBcXpwVlBwQkE5Z2ZodHZVY3l3UHhrbE9OTGMyc2xJ?=
 =?utf-8?B?bjZ1ZWt4ODIrcFl5TnpXMWxuNURRMVdudmc0NkJ0UFVSZDJxRXJqc05DKzN3?=
 =?utf-8?B?YTQ0WFZod2hrSkVMd1QxdTFxOXBuc0NzMmlUVURyRkJBRDZDdWl1MWdONk5O?=
 =?utf-8?B?Ykx5Um9WS1hmbm0vdkZFanFYR3o5eDdhV0lvREMzbytscHZMTXkwQVl4bTl1?=
 =?utf-8?B?VWNoTW9KT1FYeUJHUXRvaVhEbmFZQ292MzVDbFkzbkd5Ykh2aVpYVi9wMWxa?=
 =?utf-8?B?RGdwQ3lwRmtNRFB3TG5UWHczMGZ5S1hXNHNMaFJnaEtBLzdpQUJmSkxZei9i?=
 =?utf-8?B?dzllQU9TR3dCYklhMk43SXZ6d09hVUdqbERvNFpQWkhtdWcyWGp1QnZ4YVRu?=
 =?utf-8?B?QkExdkFRL21weE5HNm5HbkZNeWwzcllxdU4wOHdMOWNQNEJzejNSNThONm9N?=
 =?utf-8?B?OTVZYjJUaTUxUVYySXlINTZJUnJSdE1jV0lBd0laWmdQbERFZEVTV2ZpMXh3?=
 =?utf-8?B?cXZWbDZmcDN1R29iTlExbVYvY212K2ZSNVNHK1ZYVnU5eUVGT2pza0twQU1U?=
 =?utf-8?B?VUIyZnhUNTVMY2pPQUYwalRSSVNkYlA2WjlpcHRVSFltekYyRDlhWExGeWpO?=
 =?utf-8?B?dkVzMHNnalJNMjA5dWYvaVBXQ2s2UVJLUkVwSnU4cmhxOXRSYU13bnVQMzA3?=
 =?utf-8?Q?+imZs0+dpJ2Q7riZmcPsiknTB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 91869cb3-dd66-42bf-d6f9-08dd19b7608f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 07:42:34.5979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzHLh67qu7vQF3yZCqQV9mn5VyA+tf6Fig8cHaCr+Q2baZiIk5aQjbgZTcs0uXIQoYlrtBB+pDNacOk2M2d0cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7925
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIERlY2VtYmVyIDExLCAyMDI0IDM6MzUgUE0NCj4gDQo+IE9uIDIwMjQvMTIvMTEgMTU6
MjEsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdTxiYW9sdS5sdUBsaW51
eC5pbnRlbC5jb20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMjksIDIwMjQgMTA6MDUg
QU0NCj4gPj4NCj4gPj4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gcmVtb3ZlcyBjYWNoZSB0
YWdzIGFmdGVyIGRpc2FibGluZyBBVFMsDQo+ID4+IGxlYWRpbmcgdG8gcG90ZW50aWFsIG1lbW9y
eSBsZWFrcyBhbmQga2VybmVsIGNyYXNoZXMuIFNwZWNpZmljYWxseSwNCj4gPj4gQ0FDSEVfVEFH
X0RFVlRMQiB0eXBlIGNhY2hlIHRhZ3MgbWF5IHN0aWxsIHJlbWFpbiBpbiB0aGUgbGlzdCBldmVu
DQo+ID4+IGFmdGVyIHRoZSBkb21haW4gaXMgZnJlZWQsIGNhdXNpbmcgYSB1c2UtYWZ0ZXItZnJl
ZSBjb25kaXRpb24uDQo+ID4+DQo+ID4+IFRoaXMgaXNzdWUgcmVhbGx5IHNob3dzIHVwIHdoZW4g
bXVsdGlwbGUgVkZzIGZyb20gZGlmZmVyZW50IFBGcw0KPiA+PiBwYXNzZWQgdGhyb3VnaCB0byBh
IHNpbmdsZSB1c2VyLXNwYWNlIHByb2Nlc3MgdmlhIHZmaW8tcGNpLiBJbiBzdWNoDQo+ID4+IGNh
c2VzLCB0aGUga2VybmVsIG1heSBjcmFzaCB3aXRoIGtlcm5lbCBtZXNzYWdlcyBsaWtlOg0KPiA+
IElzICJtdWx0aXBsZSBWRnMgZnJvbSBkaWZmZXJlbnQgUEZzIiB0aGUga2V5IHRvIHRyaWdnZXIg
dGhlIHByb2JsZW0/DQo+IA0KPiBUaGlzIGlzIHRoZSByZWFsIHRlc3QgY2FzZSB0aGF0IHRyaWdn
ZXJlZCB0aGlzIGlzc3VlLiBJdCdzIGRlZmluaXRlbHkNCj4gbm90IHRoZSBvbmx5IGNhc2UgdGhh
dCBjb3VsZCB0cmlnZ2VyIHRoaXMgaXNzdWUuDQo+IA0KDQppdCdzIHRoZSByZWFsIHRlc3QgY2Fz
ZSBidXQgaXMgIGEgYml0IG1pc2xlYWRpbmcgd2hlbiBjb25uZWN0aW5nIGl0IHRvDQp0aGUgcGF0
Y2guIPCfmIoNCg==

