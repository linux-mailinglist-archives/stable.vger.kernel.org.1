Return-Path: <stable+bounces-136603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1305A9B23C
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 17:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A865A4A423D
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 15:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1861DFD96;
	Thu, 24 Apr 2025 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="St0NCLt0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880271DF994;
	Thu, 24 Apr 2025 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508552; cv=fail; b=Yp6K4Ld2AcEZopLaDVRTZ1nOIRvsv8qoHVSQ0Og4naQ/1/2fslwIdtKbtiVH0WSwgSsKsTysSwGlYxsz7IE7pL10UU0Nng66FfuKw8JP8biRa7NU/o9PGpX7kKTVEI8sjB5xu+MDdVhUQdGP7VS85DR1XE1vi1jC3jETi9JT2Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508552; c=relaxed/simple;
	bh=CQ4y8MYcoMQu3Of/a0QJKuKxpPgVPG6qQGI97PQoxLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i/OM4J+8+84ueWHukL9324AHqGmDI+lWm4yGVR7j237oA7Cx/We3637njyme23mS8/41nQt+f+ilcuX5imi0CPVBzpHXb56mVmbIzvF0lJKr7kN1wV0ZXZIBS7jxgk2yZKolkxwT5GP58xGj9Na/e65h7qnajipBg5QnnUz/G4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=St0NCLt0; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745508551; x=1777044551;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CQ4y8MYcoMQu3Of/a0QJKuKxpPgVPG6qQGI97PQoxLo=;
  b=St0NCLt0LwQzJqGHqXXjphdINBDl7SLYfK1dw+PJYWebr3099yFV1WX+
   20xdbGUjdx0a3JtEd33W/uIsJFGuUTOhwcMP+FXZnH7ZMU19R1kauF1tA
   x/SvMbYJY9D5EIe6H3ZI3LP1rpzCOq3F6A+1/JUXJcrzSmzWzuZYtRV0F
   +GP+4bn0UoFfOILN0hRPEMwMBM1+LVwzB9rcD8pxGXdIoy2OCpyrnI84K
   WdZGfc3M/fduP4Dw7Uwdec+QlgtCJ1+8/+vnqvLitOb0qnaEBGtI959Fe
   1HqBs3Es7QuMUexV6+TiM8j/yRMZq6WuQASiqUp7gErvWTL2seRhK1g93
   g==;
X-CSE-ConnectionGUID: 10GAgQHtTHmuezisGg+ZiQ==
X-CSE-MsgGUID: zszSZfDOQw2QBVrVYXjH7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47281787"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47281787"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:29:09 -0700
X-CSE-ConnectionGUID: 9oefM6iVTnmu0C2ZAeIMLg==
X-CSE-MsgGUID: ziB4tXplSyKk0Fawyw/oVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="169863940"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:29:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:29:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:29:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:29:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODuN2gO2TX67Il/3Hhg4q8fsRIphokC1BBlyPMMgKmwNm+AC9cIJ/hBImlcpSQ8eRd7eYxDF0HddyvuK1pwC3OTzB7qmVh3YWr/gVrQYfOJ/mod3+m11zkDevBfq4ngYKM/8FWOrEpcAwnhtdC6gyHd2JRVzYq/CIrBHmzD4g8UcjSv4IsnVy5H0FxSnRFZXBm2iAJ2kEG/DNef1yJu4hL1vC8+aC3UhvgegpDSvPniXECygaKEHpkw4UTcbECQnAAVr4HmDYnVkCyF9Os7EbFby5yI78mF57/XrMIsVJ7l3uyP1XjH9cGHqGabzxpg6TcKvDyZFpXjest0cNMkM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ4y8MYcoMQu3Of/a0QJKuKxpPgVPG6qQGI97PQoxLo=;
 b=O5B3p5RPK94TlRGwH0RBmy6wVEoJyR/iDYohyMvi+Bp/zorfPt8O4vne2ecgF7HWf4LIegDVLNIZBuoO+JG4lb5hVNbIECkSCIL3/ZeM8lGzoRanJpLNwM1OykZACKQnxLmL6f9rjE4wbmXArOUCni2UeUbaBwRu/eYHUl/YhgBg3jSBBnZm8+ctOu4Vw15fwi+leiHYl6PaJ+vj0klmHOtarz2N+fbsP3AQsaq1IS7a2FUu19L9qTjl+XIU5Yrv4FnsJRp0bXZBFVCEaKLNnknSCS7U6pl/oe6g3fmKiOv/ZStSzd6pomeGkkIRRmtXSIxFVf+ODnvWkEQp8TqSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SA1PR11MB8394.namprd11.prod.outlook.com (2603:10b6:806:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Thu, 24 Apr
 2025 15:29:03 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8655.025; Thu, 24 Apr 2025
 15:29:03 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Badole, Vishal" <vishal.badole@amd.com>, Paolo Abeni <pabeni@redhat.com>,
	"Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "Dumazet, Eric" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "Thomas.Lendacky@amd.com"
	<Thomas.Lendacky@amd.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Raju.Rangoju@amd.com"
	<Raju.Rangoju@amd.com>
Subject: RE: [PATCH net V2] amd-xgbe: Fix to ensure dependent features are
 toggled with RX checksum offload
Thread-Topic: [PATCH net V2] amd-xgbe: Fix to ensure dependent features are
 toggled with RX checksum offload
Thread-Index: AQHbssaDqNP9IBUADEChxEkeqksmWbOvzpEAgAEWigCAAaI3gIAAQ9mAgAAqcPA=
Date: Thu, 24 Apr 2025 15:29:03 +0000
Message-ID: <PH0PR11MB5095BE6E3FBAC90901DD6EB9D6852@PH0PR11MB5095.namprd11.prod.outlook.com>
References: <20250421140438.2751080-1-Vishal.Badole@amd.com>
 <d0902829-c588-4fba-93c0-9c0dfcc221f6@intel.com>
 <c1d1ce25-8b5f-4638-bcd3-0d96c3139fd7@amd.com>
 <d5114fb3-4ca8-4ab8-acb2-120a7b940d6f@redhat.com>
 <98c62087-0a95-4d4d-9e9f-9d62a530af67@amd.com>
In-Reply-To: <98c62087-0a95-4d4d-9e9f-9d62a530af67@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5095:EE_|SA1PR11MB8394:EE_
x-ms-office365-filtering-correlation-id: 974ebda9-4b74-4353-749d-08dd8344be84
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TDVjemxURjFaMjhRdisvQ0VEQW9yWVpHbVkrdG44QktBVmwzaWFoajRWK1cy?=
 =?utf-8?B?U2FYWG9Kbk5zUnlVZDJHZkhmblZtUVlzK29QQ3RNUVBIQTB0TDVmQ3hVWko3?=
 =?utf-8?B?ZGxVeWVYYWVRKzJRUGp0Z3E2dGxBYlA2T053T3QvaGt6MlBKbTREV05naWpr?=
 =?utf-8?B?cWhpRUFjaXBjY25JcCtQcGtrZXZzTG1VM1o1ZFlXOEhNcmZvYkNWZUwzd3ls?=
 =?utf-8?B?K2ZzM01jYWdVL25Hb2ZBYlJCWkVRTERsdzV4WFNzZjN0SzR2RU4rM3RzeHZQ?=
 =?utf-8?B?Tmhlc01tR09wclkrcU1TWkQyWndKbWFnTzFEald5WTg5RnFObUdyWlpaUXZ6?=
 =?utf-8?B?eWtGbjgwMU1zdDljTWd5ZDVYUXZta2NIbmozYm93Vkcrb0RMMFJjbjFZVGEw?=
 =?utf-8?B?QXNlNkdRTFZpM3FPcWNsSWpiQ295RTVTR2Fkc3dWdnN1Qlh5ZnVQRVRlbTJX?=
 =?utf-8?B?NGNNYUNKLytaVktQbEZDOTM3Um94ekY4RnJadElkZys1YmlTVnNuYUVYYXp0?=
 =?utf-8?B?dElHSFQwM0t3TXVneVFnTU1GQVdIa3pQdStzTFA0WWh3bGhwTnZ3K09UVzJ5?=
 =?utf-8?B?dGllTEJKZFl5SjVFL3VYaHVxRVRXTXc1cDZ5NEFpV2RNdUtWaFFQMTFFaUxl?=
 =?utf-8?B?WEJCb2RlSjFhWDVxV0kvTE1xajAzN1gyN2Y2eUtONUhFUkt1UmNPcFJ6bGYx?=
 =?utf-8?B?VWpQTXdsUHBEUGgzekdRZXB2RmdUaFhucjdrNXZjVFhkc0xpM3J2TldtUHlE?=
 =?utf-8?B?anA5aXppRmpTdXlYTDdoR2hYK0szV3BFNjJIRzZBTERaQmFUNmkrQTB1OVdi?=
 =?utf-8?B?czhGR1dHQ215Rm1adUMzaitjbEYzN0lrOCszVkYzd0IwWmxxR2xoS0JULzAy?=
 =?utf-8?B?cnN6Mmp0YWZqeVFGZllaWW1uOHE4TEF3L3Z3YllUOVVTY1ZLRTJtOXpsRllD?=
 =?utf-8?B?V0JaV0JiT2l2bXZaZWdrS3JOc3lLVitDeHA5aEh0NmNXWVVGUkNyQ1pXWXdJ?=
 =?utf-8?B?NVlNY09PcUJUSFlOUlBGUHNZVEFkSjQ4dkx1bE0yOW9sMGo1QUw1K1EzcHF4?=
 =?utf-8?B?NFE5Qlo3N2FSNVFONWNFNCs3ZDhtd1I5eG9HNUlTN2tkalZ6MjhIQkVJRzht?=
 =?utf-8?B?K0tza09FK25uSmNVN29ZNXQ1QllYa1U5ZC9WSG1jMmd6Z0htb2tvYVN3U1Ir?=
 =?utf-8?B?dWJtKzFXYWlBc0Z1YVlWYVFsUFpiUUE3dXhaUCs0QnpGbkFiVmRTL2NzVnRH?=
 =?utf-8?B?Zlo2TjJlSzVOZytkRTRhZ3Y4VzdOTVNRT1NMQlNzeUcrTTBSVWxpV242eHpu?=
 =?utf-8?B?TENpMVVVSy9KdmNhTURrZ0F2alJORytQdzIzM3hCMnY3aEdrQU1ROXk1LytM?=
 =?utf-8?B?RHdIQTNuaHAyZXhkazNyRkVCeDZKUW55UkhtQWFZQnVSektMcWpxcHpaWmpw?=
 =?utf-8?B?QjByeUlaVXAyT2FZNmwwS3FDNTZnZ1JqZHpKZkRVdGl1MXZPamY1eXAzWFRa?=
 =?utf-8?B?bGpuSzBNL1NXL2RJcDJvT3B3dVBNZ3NCNVQ1blRmb0RxUzBUVXZyNi9GaGFQ?=
 =?utf-8?B?VmxoQUp6K2poUEZFZ2NCSGhkNy9tdzVhVmxIcXNOSXpVU0RqUVhlOE94UTk2?=
 =?utf-8?B?NEZFZTdzZG1TR0F3bEVxWHc5ZU1WN3VrV2ZDU0kyeWZiNkZJNDVaZitPK25T?=
 =?utf-8?B?cG96MzhCR3RYeDVZcDU1TWJoOWp6NjNTeko1bnUzYjdQaWIxY3g1UWRETkVC?=
 =?utf-8?B?ZGZ5KzZ3K3ZkU3hWdGV4dUdkZE5obmR2M2hnZFlsaS81aUcyN2RMZ2FmWFhs?=
 =?utf-8?B?NDNhT1QyOElJV25SMlhRWHJyaWFiaERrRUsrMHZkYVlDVHdsR1RCUWZUU1pV?=
 =?utf-8?B?eFNTcGpuR0FGaWhTVHFUZU9VS0ZEbGNLQzkraE8xZTZSb0dUdEZqSEZUTWRP?=
 =?utf-8?B?RnJ6a25UVXoxVWpORXhnc3h4cnhBNmtVQ2xDSThkTXlySi95Qy8rWFI1aWc3?=
 =?utf-8?Q?a51+mL2vWjKgzSZnOZBSxGbeMP96SY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1VvTTI1WDlzM0Iwb3R3UFBuU0lwTXovRFVJSnJVcU5iMUV5TGRwRUpBU2M4?=
 =?utf-8?B?bGJBY041YlltSnhELzV5MXVTQ3hNTVRsVjN6cmFqN1k5SFV6L2ZQeHFWTWdq?=
 =?utf-8?B?QUN1Yys3Zit4MUJJSTFiNTgxVVZOaEpoVllFcUxsRnVqWkRWSTJ4MFRPRDhP?=
 =?utf-8?B?ZnZjQkhlSFVwbm9YWDNBT2pYK3RQeUVUd0JQUVcxNVpVZHpGWWtuSnNISXIy?=
 =?utf-8?B?OUJoZmRXeEJSc2hkOE9OYzRZb1pzdHJSak5RYlU5d3RpekZkbW1DUk5SeGFY?=
 =?utf-8?B?MzRpR0pFMGZEdWFMY0xWZTNRaDVLenlXbjhGOGp3bDZNWFdNNXpOOXZmbVk3?=
 =?utf-8?B?cFdRUWlkeGdKL2hndGlVbDlyU210bHZNV3RGY1ZOc2NoQXl6M0lFeUZZRTF1?=
 =?utf-8?B?SmdiT21FY3hEVjBVV1BCbkdGa3N3SHNYanRPa3VNVzBLYmJpMUg4enNLaXJY?=
 =?utf-8?B?QTVuajZTbTlycWh2a2V5WnZzZGtSM3pQcDBtaCtaRnJsMzBMK0dianpJTlpR?=
 =?utf-8?B?T1JpZjFqZ25PSHZSY2hTd2V6dERldXAvY0h5bUpHZURFUXJGbEkzR2xaVmdB?=
 =?utf-8?B?TzJqMWdTeldVM0xPNi9JeGNXTTNHUmlITEpqaFI0N1Q3S3E3ZWRKYTJYWitP?=
 =?utf-8?B?TmVUaUNRZng3d1p0aFFRTytud2JkU3dpSlovTWVyb2hPOGdtYno4MUsrQkVH?=
 =?utf-8?B?SDM4OVZwK05nSmtPU1hDWkFPaWhDT21JN2M5N1pSQUoxK3lERUpOQUtib0p2?=
 =?utf-8?B?S0lVajROZEQwVm00aUgvL0lUUTJURHYvU2dNMFRKN2w4bDh4ajFyVXd4WWVh?=
 =?utf-8?B?dlNtSzZOVG5aOWNDYUIvVk1aY0ZHeUtEZ0NhSkxiaUR1Y2xxcWQ0dktpTlVI?=
 =?utf-8?B?SDE1SE9hYTJuOE05UyttYS9VbUkxU1RQMlF2MzA3cWd5TXZpY3BXZEhUN3NS?=
 =?utf-8?B?bG5ZbkNScUlWNmkvYWZGZFZCeVlXWVpqT2J5UnVJdEluam00ZzM1endCdDRI?=
 =?utf-8?B?ZFBmZlI4NDljM0JvOTFjaHBSY2N5Z1hGRkpEQm9PM2trM0ZWa05aUU9aM2pw?=
 =?utf-8?B?WUVSZ0dseVh1SGMzWklnM3NzVU5BWGxRc0k4aFh0T3JjNjloTGFQK1JrTTRZ?=
 =?utf-8?B?OTk4bndmN29ad0NGd1NsYy93QkVPMS9UNnpmTUptM0VPSktJTjU2aVlHaUZE?=
 =?utf-8?B?R3JSa08xVFNiT0kzU1EzOUlPc2xMNHhpSE5ZOVZtWXIrTjdJSTgveG4vRzJK?=
 =?utf-8?B?enRaSzJKdDg0QUlZMHViVU9VaEs3MG8wSWRwYURBbG5jVzN6NDk4ejBOQzhP?=
 =?utf-8?B?a0ZJZ0ZEL1hEUFoyazlTRjFkU1VLT2wyU2V4VzNOREpqSXpGTldnMTRaVGFI?=
 =?utf-8?B?MDl3eHM4elAxY29GSVA5VE5KV1RTb1ZDK3NCY2tVTy9IalY3RGViWkJoU0J2?=
 =?utf-8?B?RlVOTGNVSjV4VjBBZit0R3J6MDZwblB4MGUrVzNQNlVhKzl5WG84R1A2cUZl?=
 =?utf-8?B?TFhadEl0SU1rZkhjcFlWVDRwRkVCWDl4MlVNbWhUekhjdFZ0UVpTSnVKaUth?=
 =?utf-8?B?SmVkdzFVbW8zbEowZnM1TmQ1ZDBpYmp3ZzRKQ21hZzVTaU8zOVNiSDV6NTF0?=
 =?utf-8?B?djIzczJEZS9DOTNYMTM3RmZ6cFNmK1F4dXZwOGJJSGFoREpKRGlMY2JRVjMx?=
 =?utf-8?B?LzY0emlYVnE4R3F3N1NZL2pDdXRMOUxsclJ4WEY1bnc1NjN5T2NRQkx3ZTU5?=
 =?utf-8?B?OWR6VGY4S0RDa2lOTGlDUjNaSXBEWG5yck5yaEExRVJRODl6ZkxsMEdGczFT?=
 =?utf-8?B?Slg4NWR5Nmp1Z0NRR2MrNTlqazZYeGZiZjFuSjNLTHljS3ZwT0IxWTRlMTRu?=
 =?utf-8?B?UW9oeUZCOG50NUpxeVRMbnFFWlNHMEs0akd3MnJTMXhESnQ0Vk9xYUF3K3Fk?=
 =?utf-8?B?VlgyRzVZQTN6RFpaWlpueWVVNHk0azJ4ZFF3aFE1by9BWWRoNTAwd0k5Wk9X?=
 =?utf-8?B?eldvaUNSa29jU1FvZWRHOStGZ2plMjhGa1IvaUloL1JGTVNSalMrVjZFbXBF?=
 =?utf-8?B?LzZKZ3hmZEpkUXRlVmcxYjU5YzFZNkVhL0EzRnpwSXE4L1pyOHVHbnNacTNL?=
 =?utf-8?Q?FOru68LgU9YI2GebmYRiWd8lY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974ebda9-4b74-4353-749d-08dd8344be84
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 15:29:03.3662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyE0hLITNwzDz5G8IXZuPrwGj4CporcB2aJ8SZjTveNyNodSqC4+rIK2dya7NAA7oXN2+O1GV42K453pVbZsE/KFHZWD6lnjua5ThFQ0s+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8394
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFkb2xlLCBWaXNoYWwg
PHZpc2hhbC5iYWRvbGVAYW1kLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDI0LCAyMDI1
IDU6NTcgQU0NCj4gVG86IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IEtlbGxlciwg
SmFjb2IgRQ0KPiA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgU2h5YW0tc3VuZGFyLlMta0Bh
bWQuY29tOw0KPiBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IER1
bWF6ZXQsIEVyaWMNCj4gPGVkdW1hemV0QGdvb2dsZS5jb20+OyBrdWJhQGtlcm5lbC5vcmc7IFRo
b21hcy5MZW5kYWNreUBhbWQuY29tOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBSYWp1
LlJhbmdvanVAYW1kLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCBWMl0gYW1kLXhnYmU6
IEZpeCB0byBlbnN1cmUgZGVwZW5kZW50IGZlYXR1cmVzIGFyZQ0KPiB0b2dnbGVkIHdpdGggUlgg
Y2hlY2tzdW0gb2ZmbG9hZA0KPiANCj4gDQo+IA0KPiBPbiA0LzI0LzIwMjUgMjoyNCBQTSwgUGFv
bG8gQWJlbmkgd3JvdGU6DQo+ID4gT24gNC8yMy8yNSA5OjU3IEFNLCBCYWRvbGUsIFZpc2hhbCB3
cm90ZToNCj4gPj4gT24gNC8yMy8yMDI1IDM6NTAgQU0sIEphY29iIEtlbGxlciB3cm90ZToNCj4g
Pj4+IE9uIDQvMjEvMjAyNSA3OjA0IEFNLCBWaXNoYWwgQmFkb2xlIHdyb3RlOg0KPiA+Pj4+IEFj
Y29yZGluZyB0byB0aGUgWEdNQUMgc3BlY2lmaWNhdGlvbiwgZW5hYmxpbmcgZmVhdHVyZXMgc3Vj
aCBhcyBMYXllciAzDQo+ID4+Pj4gYW5kIExheWVyIDQgUGFja2V0IEZpbHRlcmluZywgU3BsaXQg
SGVhZGVyLCBSZWNlaXZlIFNpZGUgU2NhbGluZyAoUlNTKSwNCj4gPj4+PiBhbmQgVmlydHVhbGl6
ZWQgTmV0d29yayBzdXBwb3J0IGF1dG9tYXRpY2FsbHkgc2VsZWN0cyB0aGUgSVBDIEZ1bGwNCj4g
Pj4+PiBDaGVja3N1bSBPZmZsb2FkIEVuZ2luZSBvbiB0aGUgcmVjZWl2ZSBzaWRlLg0KPiA+Pj4+
DQo+ID4+Pj4gV2hlbiBSWCBjaGVja3N1bSBvZmZsb2FkIGlzIGRpc2FibGVkLCB0aGVzZSBkZXBl
bmRlbnQgZmVhdHVyZXMgbXVzdCBhbHNvDQo+ID4+Pj4gYmUgZGlzYWJsZWQgdG8gcHJldmVudCBh
Ym5vcm1hbCBiZWhhdmlvciBjYXVzZWQgYnkgbWlzbWF0Y2hlZCBmZWF0dXJlDQo+ID4+Pj4gZGVw
ZW5kZW5jaWVzLg0KPiA+Pj4+DQo+ID4+Pj4gRW5zdXJlIHRoYXQgdG9nZ2xpbmcgUlggY2hlY2tz
dW0gb2ZmbG9hZCAoZGlzYWJsaW5nIG9yIGVuYWJsaW5nKSBwcm9wZXJseQ0KPiA+Pj4+IGRpc2Fi
bGVzIG9yIGVuYWJsZXMgYWxsIGRlcGVuZGVudCBmZWF0dXJlcywgbWFpbnRhaW5pbmcgY29uc2lz
dGVudCBhbmQNCj4gPj4+PiBleHBlY3RlZCBiZWhhdmlvciBpbiB0aGUgbmV0d29yayBkZXZpY2Uu
DQo+ID4+Pj4NCj4gPj4+DQo+ID4+PiBNeSB1bmRlcnN0YW5kaW5nIGJhc2VkIG9uIHByZXZpb3Vz
IGNoYW5nZXMgSSd2ZSBtYWRlIHRvIEludGVsIGRyaXZlcnMsDQo+ID4+PiB0aGUgbmV0ZGV2IGNv
bW11bml0eSBvcGluaW9uIGhlcmUgaXMgdGhhdCB0aGUgZHJpdmVyIHNob3VsZG4ndA0KPiA+Pj4g
YXV0b21hdGljYWxseSBjaGFuZ2UgdXNlciBjb25maWd1cmF0aW9uIGxpa2UgdGhpcy4gSW5zdGVh
ZCwgaXQgc2hvdWxkDQo+ID4+PiByZWplY3QgcmVxdWVzdHMgdG8gZGlzYWJsZSBhIGZlYXR1cmUg
aWYgdGhhdCBpc24ndCBwb3NzaWJsZSBkdWUgdG8gdGhlDQo+ID4+PiBvdGhlciByZXF1aXJlbWVu
dHMuDQo+ID4+Pg0KPiA+Pj4gSW4gdGhpcyBjYXNlLCB0aGF0IG1lYW5zIGNoZWNraW5nIGFuZCBy
ZWplY3RpbmcgZGlzYWJsZSBvZiBSeCBjaGVja3N1bQ0KPiA+Pj4gb2ZmbG9hZCB3aGVuZXZlciB0
aGUgZmVhdHVyZXMgd2hpY2ggZGVwZW5kIG9uIGl0IGFyZSBlbmFibGVkLCBhbmQgcmVqZWN0DQo+
ID4+PiByZXF1ZXN0cyB0byBlbmFibGUgdGhlIGZlYXR1cmVzIHdoZW4gUnggY2hlY2tzdW0gaXMg
ZGlzYWJsZWQuDQo+ID4+DQo+ID4+IFRoYW5rIHlvdSBmb3Igc2hhcmluZyB5b3VyIHBlcnNwZWN0
aXZlIGFuZCBleHBlcmllbmNlIHdpdGggSW50ZWwNCj4gPj4gZHJpdmVycy4gRnJvbSBteSB1bmRl
cnN0YW5kaW5nLCB0aGUgZml4X2ZlYXR1cmVzKCkgY2FsbGJhY2sgaW4gZXRodG9vbA0KPiA+PiBo
YW5kbGVzIGVuYWJsaW5nIGFuZCBkaXNhYmxpbmcgdGhlIGRlcGVuZGVudCBmZWF0dXJlcyByZXF1
aXJlZCBmb3IgdGhlDQo+ID4+IHJlcXVlc3RlZCBmZWF0dXJlIHRvIGZ1bmN0aW9uIGNvcnJlY3Rs
eS4gSXQgYWxzbyBlbnN1cmVzIHRoYXQgdGhlDQo+ID4+IGNvcnJlY3Qgc3RhdHVzIGlzIHJlZmxl
Y3RlZCBpbiBldGh0b29sIGFuZCBub3RpZmllcyB0aGUgdXNlci4NCj4gPj4NCj4gPj4gSG93ZXZl
ciwgaWYgdGhlIHVzZXIgd2lzaGVzIHRvIGVuYWJsZSBvciBkaXNhYmxlIHRob3NlIGRlcGVuZGVu
dA0KPiA+PiBmZWF0dXJlcyBhZ2FpbiwgdGhleSBjYW4gZG8gc28gdXNpbmcgdGhlIGFwcHJvcHJp
YXRlIGV0aHRvb2wgc2V0dGluZ3MuDQo+ID4NCj4gPiBBRkFJQ1MgdGhlcmUgYXJlIHR3byBkaWZm
ZXJlbnQgdGhpbmdzIGhlcmU6DQo+ID4NCj4gPiAtIGF1dG9tYXRpYyB1cGRhdGUgb2YgTkVUSUZf
Rl9SWEhBU0ggYWNjb3JkaW5nIHRvIE5FVElGX0ZfUlhDU1VNIHZhbHVlOg0KPiA+IHRoYXQgc2hv
dWxkIGJlIGF2b2lkIGFuZCBpbnN0ZWFkIGluY29tcGF0aWJsZSBjaGFuZ2VzIHNob3VsZCBiZSBy
ZWplY3RlZA0KPiA+IHdpdGggYSBzdWl0YWJsZSBlcnJvciBtZXNzYWdlLg0KPiA+DQo+ID4gLSBh
dXRvbWF0aWMgdXBkYXRlIG9mIGhlYWRlciBzcGxpdCBhbmQgdnhsYW4gZGVwZW5kaW5nIG9uIE5F
VElGX0ZfUlhDU1VNDQo+ID4gdmFsdWU6IHRoYXQgY291bGQgYmUgYWxsb3dlZCBhcyBBRkFJQ1Mg
dGhlIGRyaXZlciBkb2VzIG5vdCBjdXJyZW50bHkNCj4gPiBvZmZlciBhbnkgb3RoZXIgbWV0aG9k
IHRvIGZsaXAgbW9kaWZ5IGNvbmZpZ3VyYXRpb24gKGFuZCBtYWtlIHRoZSBzdGF0ZQ0KPiA+IGNv
bnNpc3RlbnQpLg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+DQo+ID4gUGFvbG8NCj4gPg0KPiA+DQo+
IFRoYW5rIHlvdSBmb3IgeW91ciBvYnNlcnZhdGlvbnMuIEkgYWdyZWUgd2l0aCB5b3VyIHBvaW50
cy4gRm9yIHRoZSBmaXJzdA0KPiBjYXNlLCBJIHdpbGwgcmVtb3ZlIHRoZSBhdXRvbWF0aWMgdXBk
YXRlIG9mIE5FVElGX0ZfUlhIQVNIIGJhc2VkIG9uIHRoZQ0KPiBORVRJRl9GX1JYQ1NVTSB2YWx1
ZSwgYXMgY2hlY2tzdW0gb2ZmbG9hZGluZyBmdW5jdGlvbnMgY29ycmVjdGx5IHdpdGhvdXQNCj4g
aXQsIGFuZCBJIHdpbGwgaW5jbHVkZSB0aGlzIGNoYW5nZSBpbiB0aGUgbmV4dCBwYXRjaCB2ZXJz
aW9uLiBGb3IgdGhlDQo+IHNlY29uZCBjYXNlLCBJIHdpbGwgcmV0YWluIHRoZSBhdXRvbWF0aWMg
dXBkYXRlcyBmb3IgaGVhZGVyIHNwbGl0IGFuZA0KPiB2aXJ0dWFsIG5ldHdvcmssIGFzIHRoZXkg
ZGVwZW5kIG9uIE5FVElGX0ZfUlhDU1VNIGZvciBjb25zaXN0ZW50DQo+IGNvbmZpZ3VyYXRpb24g
YW5kIHRoZXJlIGlzIG5vIGFsdGVybmF0aXZlIG1ldGhvZCB0byBtb2RpZnkgdGhlaXIgc3RhdGUu
DQo+IA0KPiBUaGFua3MsDQo+IFZpc2hhbA0KDQpTb3VuZHMgcmVhc29uYWJsZSB0byBtZSwgdGhh
bmtzIQ0KDQo=

