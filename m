Return-Path: <stable+bounces-118548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F21AA3ED4C
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 08:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB5A702443
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 07:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410371FECC5;
	Fri, 21 Feb 2025 07:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fySkrlCk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7791FE443;
	Fri, 21 Feb 2025 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740122582; cv=fail; b=utMyKduSPA+ZLoQyqpCXYwvdyYfDLKoxVhuxdAHEi3PyaOwnniVDwA569K8xzH6gLkv53dit+I7DSA428Tjx39LEyPF9oYKF4meyKV2CpspDwHFdCdEhFzvBUz8LTfadikQ3qHdF3AxIdveunHUVNaoewYcUI/WfduLeKg0dHpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740122582; c=relaxed/simple;
	bh=x9aphIzspkpgof2uqKiRbJpGoCNqA9kwPbWM77BWuGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TyC8XAdjLzQc4IRbY9h4ur8zEgX9BjH0Aa3YTQjHd3pAJiKGjS7E2yKQ/tzcyZC9bTyfKuILY2bFyRMyPt9BFP3Q2eg5tFQJLi4RxM6DgSJR7LG3TwKhkQZdG2ejaBYjj0vpFZrYYOn9z8a0GJdjggBTp6OQ+NF51kBUA801hHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fySkrlCk; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740122578; x=1771658578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x9aphIzspkpgof2uqKiRbJpGoCNqA9kwPbWM77BWuGw=;
  b=fySkrlCk4I3ctVycAg+pAg4wVI9Hk/83ht3rwi6JS6txz6NjfGaJziCb
   uOH0u7mIx2pEy9lATqSgSUCnC0BGYio0Cu+rE5EY7UWE2HImykudIl/z2
   PPyno/C5RD36sRC4P+HhhYqiFEdqvByo3hnyBgaNWkaWgDMQnJyzBqyJY
   U2ETr5RLKvNq46tcOaw+X8Camdpzf0RCbYoHhrPIj2wUtc6k2b9ve2qpA
   M9YKbsALaQ7MbXR2hhf7UUjKmP/dFdW5y/Uo3PUvfF8GwAcgaAYsBzO9G
   5AkH3+MI43wocyUf2rYLU9A+Mq4Fln7sbIexTDQoZiprPuqtOJ4RM0fgk
   w==;
X-CSE-ConnectionGUID: gc5lbVqKSpm/oIGkJtf+XQ==
X-CSE-MsgGUID: x4uNlxonQKu1057SgFm7kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40944165"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="40944165"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 23:22:58 -0800
X-CSE-ConnectionGUID: tDSX4CMsQwql7UhdJGyl4A==
X-CSE-MsgGUID: YuVSMvuMQ9y6d618S15Frw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="146156216"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 23:22:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 23:22:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 23:22:57 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 23:22:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7BojGArxDpu2SBcVATq6h7HzDGwtTtV41g1SZMs+rM0IaPTJTtynr1+RiS6FXnoQPJLjsNYQFv3usl2i7Qky3qg4nbhaOG3aCuDbD+4rEu5cMbZNB5KHY8cj1QJbZUhMrmItMoeaHl8e96KUBVl6rbWB5a2FdMR0INoujyIfbopmyq/NOqeU3Yjh3uyLwwCfHKEuRUNDG+qkm51lrH6oysJHGWYlJMeRyR6YWtyaHip/uzsPENPxZFka/y4OHT43dgiWuUW0zcdt0xXeS72KqnbaBJQkLMwp30j+kEhpld2Wwxmvuh+JlhXg/3fYp1PSO5loEXYQdcHtbJNufT72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9aphIzspkpgof2uqKiRbJpGoCNqA9kwPbWM77BWuGw=;
 b=Qz9zJte+kDoXtKcGCE3JDcSPHUYEaifGPBucuHrkribK5vzEHsCUfOV5AVhSnvLEUbg5E8hH/VVvCcHCQ4hMOFnXuI5d00gbnhqJWqXl5iIp2KKmi7dUOH9HomvkBex2cyJqKDI3UF3uGU7PZ9mIy0ShcVgo0QrlXPavu3jvEMwNuWFgOSInD8PLsSnKZc1oLdF/ruyXKV+eLRPWrbvRkqbJX0mY738KP5ykl7BWVkEngE/63Vh738a86XCGAsrgtgcTjwKTXn5h3CnCwDRPp9Rp7jrgFKyzRS6hsacKysABNEswXWyWM7x3fJ8cZYEhPzxrv9r7HJghQWB8DMeoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4805.namprd11.prod.outlook.com (2603:10b6:510:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 07:22:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 07:22:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: Ido Schimmel <idosch@idosch.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Fix suspicious RCU usage
Thread-Topic: [PATCH 1/1] iommu/vt-d: Fix suspicious RCU usage
Thread-Index: AQHbgaw8QEOwhHOax0C7HUdP59MatLNPzFgQgABIL4CAAUn3QA==
Date: Fri, 21 Feb 2025 07:22:54 +0000
Message-ID: <BN9PR11MB52768DA79ECE2C5F9D14DC8C8CC72@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250218022422.2315082-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276EEC28691FD6C77EC493A8CC42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7d58c0bd-2828-4adc-8c57-8b359c9f0b9f@linux.intel.com>
In-Reply-To: <7d58c0bd-2828-4adc-8c57-8b359c9f0b9f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4805:EE_
x-ms-office365-filtering-correlation-id: 638b3c66-c2b7-49c2-e489-08dd52488f29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dFltbytLbEdURWFYaG5uU3QxM3dWN3VWTG1MRDBVVjVkenoyYXRXZjFxb1NY?=
 =?utf-8?B?TkxGL1dMSk9DUjlGN1MvMWFjTjBjaWkxWi9NN2pzVlNBTmtOSkJ3VzI5NE9E?=
 =?utf-8?B?bmxuSXp4VGc3a0FQNzRybGlVcThGMzZ5cTFiREZ5T1orY1dieWZGWE15NTZN?=
 =?utf-8?B?RE0wMGlFSEpiUENQaDVha3BiV3hpNkJ2VWc0UkFLNEdMeStCbUV3SjJTeGNO?=
 =?utf-8?B?Y1dHV3lIaWJjOGVpWS9BeGhPeWtnVlFvSzZpVEp1NVpFZ0RCSms0V1pzQkdC?=
 =?utf-8?B?L0psbDJuRWxWZUYzVWRxZXluMGVLbzZYcmZDYXVUZE1PSmIvb1lSdUNKbXZu?=
 =?utf-8?B?ZWxzVVBKSnBGYVhhUjBZenI4aHZZcVAwZU1PRU1uRnVxL2tYU2N0QzQ0VXRO?=
 =?utf-8?B?eGRnUlFDdUZQL3VyZ3N5WndMWXV1Y05kY093ZFNBK2ZocjVqZUVDWWZ3KzVk?=
 =?utf-8?B?MERWNlRaR1R0QXUyYm1DN3p2SU12NXlCWjJqR3VpZnpmK0Uwc2crYmJlbDcz?=
 =?utf-8?B?dm1ySy85YW1YU2hnM3ZLcnpwWVJlTHVKNzQxQ2Fpd0N2Z1NPQVJlTnNSNjQz?=
 =?utf-8?B?SkFrR0hCL0NNakpmdGZaN1NWL1dxNWU0UmlkMVhnWHh0ZElZbCtiQmI1OUs1?=
 =?utf-8?B?QlZPRTdabXpURTAxRU90MmNabkxCWit3OEtScHM4VUp6NWh2SlMzMmw5V3dT?=
 =?utf-8?B?UHhua1NETnk1M2tPTHRQQzM0Uk1Jdi8yRHpLVHJ3aGE4ckRKbCtKMGhSaWh2?=
 =?utf-8?B?UkdSSlNRY05ZQk5ndWdkQStTSlpyMGpYNHF5UWgvUmRQSUN2bUFNYURCUk55?=
 =?utf-8?B?V2ZoOEVIaWsrQ0Q5dDdoN0xVVi9uZFcvbFFKOFJDQ3NkbGxEVkptOHRWUnd1?=
 =?utf-8?B?ZTZreFNualNBWXA3TVltdys5U1UvYmF5Vm1wWnMvTVVOQWM0NnJ5MmhybHZ1?=
 =?utf-8?B?b2dHN05HNUlwQjliUmZWM1Z4VlIvL3BmY3VUeVpjTmFaYVduc2dMaElXVnhD?=
 =?utf-8?B?MGx0U2lzYm1yTXdDUmRxZWZuZDdNNHZGMjR0bkhsYVlrRmh4SGQxK0NYMjRE?=
 =?utf-8?B?MHJESy9YQmRZVUtqR1U3WVpxMnBHQ2R3L3hCVDJqSWpNb1ZEWWhibHI2Q3JS?=
 =?utf-8?B?aGRmVEViM0JRRm94SC9YbEtGTUp2dnorNHNYNE02Y0tpT0o3TytIMExiNHNo?=
 =?utf-8?B?SXhCZzFNNHRNQ3JtMm1ubmJQUmlINWRZWG56SDFTWjVYM2l5VGRxZWk5eVhw?=
 =?utf-8?B?dGVodzVJNzFVUW5Nb1YxNjcxZ3MrNUpQTVRYN3lCUGNTWDdpTFZxL0c3V1Zq?=
 =?utf-8?B?Rm5sd2dzSE8wRGdKNEtQWHB0NUFFbWU2am1zOWxkVlg5QklPUkp3bFpVd0I4?=
 =?utf-8?B?K2w0NTBHaGNwaWR2M0NsZzQvRXJxbVRGSWF4clZRMzV6dUhaMHRzS2QvbnZ4?=
 =?utf-8?B?MzJFV2UyRFVWQ05qakhWa1pmVThXQXl1YUFXdWkzVU4vL2FPenZxUFFyTzVM?=
 =?utf-8?B?bUdCTEh6dEpLaWFZNzBXaithM1VvZzUzU2ZUM0hUaDJXQ2pWY2J6Wjk3MWpk?=
 =?utf-8?B?OVFod3pmQnRDWk8zamt6Y2p4T3p3YmVXZGp3WWNJSDhSTFFCSVUwdnBLVCtX?=
 =?utf-8?B?RjlEOUZTU0FtNHFOdy9keGhzTHhoZDByb253UytvcnVqZDhHS0d6dzJUQ1kz?=
 =?utf-8?B?aTM4Y2hRRjA2NVhmNEF1T2FUOWRQRVRTS095QXRHMW40U0hJSzNrZEFHVk1B?=
 =?utf-8?B?RE44dUtabFpleWcxZFA1b2c1NkpwQWhnN1E2ejZWNWhTUUE3aFN2bElHN2RB?=
 =?utf-8?B?M1owWEFwMDlQYlFEa1JKcDZmNW5Ua0pIQzZDbWRITkI5dWxkZUp2SGphN0hF?=
 =?utf-8?B?UTUyY1U0L1ZQbmZuRHBiM25BMkVEWFc5cVh4Ny9QbXRsNVQ0ZEFySUErSTUw?=
 =?utf-8?Q?SisIXdODWiAqtr6NbBPNWcbcY2b//VCk?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0o3aUVLWDZTWHhxN21HUysyME9pNS81M21HK2FNakVVSENwbjdWc1VIbFoz?=
 =?utf-8?B?QWUvM0pSdkt4Tm83ODF0eGpqSHB6WXlhamdQbFVEcllkRWJUS3lLTjh6aXFs?=
 =?utf-8?B?SEVLR1plNDJ2R3RxV002ZzRIMGYyV2prYkMrNHJqcVU3OUlzZ1FhMUFMVjlX?=
 =?utf-8?B?UXJTWmtRcFNFWS85T0dJTWhXUTR0VEdQd3pFcnJIREpFMzlYcUJTOEcvdGFH?=
 =?utf-8?B?cW1zSGZiMURYYTY4SUQrTUV6azN1UXdmaVRJZTZoY2Y3ckcyOVphSHUrTm85?=
 =?utf-8?B?akxjV3hXSVZPdmlIUzhsODFZbk8zOGVicDJRdE51aWhFWnp1NUFvWUFoVjkv?=
 =?utf-8?B?UXlvMDM3b1lzVXZMZzBTallGbkphVzRLVVNOTVV0MTBBY0l6cWVVQ1E1S3da?=
 =?utf-8?B?WnB2MFZqMGU0SzgyWjRjZXQvNGhITDhSSDBFWU1kckVOb2pIcU5aVWxTVThG?=
 =?utf-8?B?cDhOK29NcUUrVXZla0xuRU1YVTlLRnZvYWpISk8vM0RQeFhXVTJvNmttdjhL?=
 =?utf-8?B?N0F5NXdJWFpBdU56VG1YQlY1eDYzL3JONHF5SkJhM2ZzOHdBNk9lTXU5YXpR?=
 =?utf-8?B?RUh0R1R4K21qWHpYZVZKSy9CUlpLdmtJRm9VME4yWlRBZDk2M2tzRUZrNktC?=
 =?utf-8?B?U1p1b1RCd3cvcFVoSm0vNGNMUGc3SVdTUUtIN0I4UDRCQmRUK29TMzliSFFh?=
 =?utf-8?B?c1ZxeVVzSzF6OXBqK2hlak4yTVI2bzJSSnpZcS9Fdkp0Sk5NMkh6VnNLalNE?=
 =?utf-8?B?ZVhiZWpOcHFld0d5MFU0RHhuVWQwRE1odHp4ZnpkK1BIelZmaU95eGpPUUZW?=
 =?utf-8?B?MnMxZCtHQkJCMFRvNkJ3Zm52dlpzVW1QNjRtWVhOSXlKdGpiTkhiMUhySVph?=
 =?utf-8?B?M3VGc3ZQb3lYQndwRnVEVjZGSWJ5NnBNNFpXdWxBQ0pUd3ByMHdRM0VIODZl?=
 =?utf-8?B?cW5hZXhvOE9IVCt3aFJrNU41RGIyV2d4RFVrelQzL0NaNFRLWXI1MGVpUytw?=
 =?utf-8?B?MnJtZS85ZFRwVjVueWFKeVRIOGtoWkhkWkdmWVFoQlJob01Lamh4NHdrOEIx?=
 =?utf-8?B?RFhlR2lJSnpQSm5UQ2J2bGFTdHdsSDFKcG8zWmFkL1BvWGNyOEpYdTVUbnRi?=
 =?utf-8?B?Z0NzSjhJTWozVE9RL0FIWkFZakU0b0pCNnJCWTZCTG1lQ2t1TmtxU0NzMThi?=
 =?utf-8?B?MEdsQys4QUVLOVhHMlNGOTVhMGRmYUNMazF5RUIremZlV0JEdlVSTkc2ZnhG?=
 =?utf-8?B?WkZoa1Z6T2pBWEpHc3BaeWoza2xUZzJPSG9QTWFQdldlalRNT1RYanR6RENp?=
 =?utf-8?B?Q3ZvTENEYXRzSVpESVAva2VsWjNVQWQ4a3VDQkYrdnJpVEt4eFc4TlZ2ZHlu?=
 =?utf-8?B?cEcrVjBPQmhsQUpQZ3JPQUh2c0lLZXMzQWpyMW4yQW40N1BFQlpQblZPUzl5?=
 =?utf-8?B?dzVpbkFST2lrZGZkN2xwUFFSOGFZTWd4dFlWdm03WlN5ei9uZzNBRHV5dDVz?=
 =?utf-8?B?UlpHNUg4cTlLRGxrOUMwOXF1aWRBcUZSaTAzQVRGTDM4Sld0bEl6Q0Y2dmdR?=
 =?utf-8?B?SExLTTRLVnJBckNqNW8rUm5wbGViVm5tWjNXQUV4RzBxS2hxczFaVUtqclZD?=
 =?utf-8?B?R0VDd1RlcnVMQTcwbXpUb05taDZEcmp5c09PUGNMQ3ltbTBVNU5HWSs1SDFJ?=
 =?utf-8?B?T0dFRkd6aWYwZTNTN2wwNDFoT0RHYWxReG9QRU1hMzBySTlrSEhkZ21CUTNF?=
 =?utf-8?B?UFZNL1duZkcvK3k2L3RVbTd1SkJueVh3TDJ1UEQ3Y3JLMU5LNTlqTWJ4UDlT?=
 =?utf-8?B?aGxUSHJ3cTFJWldrN2VhRDVsY2k4bWlXOWI4aWNER0xlR0k3NWRicDI0RHp0?=
 =?utf-8?B?R1VUME11TGJiZk1uTzZDZ041NExmVGJrNFBDbTVxQmNGaFQvZ1ZqbGlNM012?=
 =?utf-8?B?RXpZNERRd25USjFuc2JnekNTUStGWWVvRVZQMERnUEU0bXpuUldOMEFFTUpO?=
 =?utf-8?B?RFdzZjcwczljZEhGdmIvd21Td0gyQ0NrczRuMjNEeDkyTVlnRGdNNVVob1J5?=
 =?utf-8?B?K1k1a0VQVjRRM3dVNGt0NDdQWWN1RG82TGNRQkRiWFg5SFc4Mm9yc2RLcHVv?=
 =?utf-8?Q?U1dQbMilufvrCfJjbsiBHq53Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 638b3c66-c2b7-49c2-e489-08dd52488f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 07:22:54.9260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rC6FLvxB0Zz5fVDaZXeCSqGTQzfttEibZ/5hfyZFXzVo1qibZ09lVklW05wcLzhwuk6rvcjVCjidd48TOjvbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4805
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgRmVicnVhcnkgMjAsIDIwMjUgNzozOCBQTQ0KPiANCj4gT24gMjAyNS8yLzIwIDE1OjIx
LCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHU8YmFvbHUubHVAbGludXgu
aW50ZWwuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxOCwgMjAyNSAxMDoyNCBB
TQ0KPiA+Pg0KPiA+PiBDb21taXQgPGQ3NDE2OWNlYjBkMj4gKCJpb21tdS92dC1kOiBBbGxvY2F0
ZSBETUFSIGZhdWx0IGludGVycnVwdHMNCj4gPj4gbG9jYWxseSIpIG1vdmVkIHRoZSBjYWxsIHRv
IGVuYWJsZV9kcmhkX2ZhdWx0X2hhbmRsaW5nKCkgdG8gYSBjb2RlDQo+ID4+IHBhdGggdGhhdCBk
b2VzIG5vdCBob2xkIGFueSBsb2NrIHdoaWxlIHRyYXZlcnNpbmcgdGhlIGRyaGQgbGlzdC4gRml4
DQo+ID4+IGl0IGJ5IGVuc3VyaW5nIHRoZSBkbWFyX2dsb2JhbF9sb2NrIGxvY2sgaXMgaGVsZCB3
aGVuIHRyYXZlcnNpbmcgdGhlDQo+ID4+IGRyaGQgbGlzdC4NCj4gPj4NCj4gPj4gV2l0aG91dCB0
aGlzIGZpeCwgdGhlIGZvbGxvd2luZyB3YXJuaW5nIGlzIHRyaWdnZXJlZDoNCj4gPj4gICA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+PiAgIFdBUk5JTkc6IHN1c3BpY2lvdXMgUkNV
IHVzYWdlDQo+ID4+ICAgNi4xNC4wLXJjMyAjNTUgTm90IHRhaW50ZWQNCj4gPj4gICAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+PiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5j
OjIwNDYgUkNVLWxpc3QgdHJhdmVyc2VkIGluIG5vbi1yZWFkZXIgc2VjdGlvbiEhDQo+ID4+ICAg
ICAgICAgICAgICAgICBvdGhlciBpbmZvIHRoYXQgbWlnaHQgaGVscCB1cyBkZWJ1ZyB0aGlzOg0K
PiA+PiAgICAgICAgICAgICAgICAgcmN1X3NjaGVkdWxlcl9hY3RpdmUgPSAxLCBkZWJ1Z19sb2Nr
cyA9IDENCj4gPj4gICAyIGxvY2tzIGhlbGQgYnkgY3B1aHAvMS8yMzoNCj4gPj4gICAjMDogZmZm
ZmZmZmY4NGE2N2M1MCAoY3B1X2hvdHBsdWdfbG9jayl7KysrK30tezA6MH0sIGF0Og0KPiA+PiBj
cHVocF90aHJlYWRfZnVuKzB4ODcvMHgyYzANCj4gPj4gICAjMTogZmZmZmZmZmY4NGE2YTM4MCAo
Y3B1aHBfc3RhdGUtdXApeysuKy59LXswOjB9LCBhdDoNCj4gPj4gY3B1aHBfdGhyZWFkX2Z1bisw
eDg3LzB4MmMwDQo+ID4+ICAgc3RhY2sgYmFja3RyYWNlOg0KPiA+PiAgIENQVTogMSBVSUQ6IDAg
UElEOiAyMyBDb21tOiBjcHVocC8xIE5vdCB0YWludGVkIDYuMTQuMC1yYzMgIzU1DQo+ID4+ICAg
Q2FsbCBUcmFjZToNCj4gPj4gICAgPFRBU0s+DQo+ID4+ICAgIGR1bXBfc3RhY2tfbHZsKzB4Yjcv
MHhkMA0KPiA+PiAgICBsb2NrZGVwX3JjdV9zdXNwaWNpb3VzKzB4MTU5LzB4MWYwDQo+ID4+ICAg
ID8gX19wZnhfZW5hYmxlX2RyaGRfZmF1bHRfaGFuZGxpbmcrMHgxMC8weDEwDQo+ID4+ICAgIGVu
YWJsZV9kcmhkX2ZhdWx0X2hhbmRsaW5nKzB4MTUxLzB4MTgwDQo+ID4+ICAgIGNwdWhwX2ludm9r
ZV9jYWxsYmFjaysweDFkZi8weDk5MA0KPiA+PiAgICBjcHVocF90aHJlYWRfZnVuKzB4MWVhLzB4
MmMwDQo+ID4+ICAgIHNtcGJvb3RfdGhyZWFkX2ZuKzB4MWY1LzB4MmUwDQo+ID4+ICAgID8gX19w
Znhfc21wYm9vdF90aHJlYWRfZm4rMHgxMC8weDEwDQo+ID4+ICAgIGt0aHJlYWQrMHgxMmEvMHgy
ZDANCj4gPj4gICAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMA0KPiA+PiAgICByZXRfZnJvbV9m
b3JrKzB4NGEvMHg2MA0KPiA+PiAgICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQo+ID4+ICAg
IHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMA0KPiA+PiAgICA8L1RBU0s+DQo+ID4+DQo+ID4+
IFNpbXBseSBob2xkaW5nIHRoZSBsb2NrIGluIGVuYWJsZV9kcmhkX2ZhdWx0X2hhbmRsaW5nKCkg
d2lsbCB0cmlnZ2VyIGENCj4gPj4gbG9jayBvcmRlciBzcGxhdC4gQXZvaWQgaG9sZGluZyB0aGUg
ZG1hcl9nbG9iYWxfbG9jayB3aGVuIGNhbGxpbmcNCj4gPj4gaW9tbXVfZGV2aWNlX3JlZ2lzdGVy
KCksIHdoaWNoIHN0YXJ0cyB0aGUgZGV2aWNlIHByb2JlIHByb2Nlc3MuDQo+ID4gQ2FuIHlvdSBl
bGFib3JhdGUgdGhlIHNwbGF0IGlzc3VlPyBJdCdzIG5vdCBpbnR1aXRpdmUgdG8gbWUgd2l0aCBh
IHF1aWNrDQo+ID4gcmVhZCBvZiB0aGUgY29kZSBhbmQgaW9tbXVfZGV2aWNlX3JlZ2lzdGVyKCkg
aXMgbm90IG9jY3VycmVkIGluIGFib3ZlDQo+ID4gY2FsbGluZyBzdGFjay4NCj4gDQo+IFRoZSBs
b2NrZGVwIHNwbGF0IGxvb2tzIGxpa2UgYmVsb3c6DQoNClRoYW5rcyBhbmQgaXQncyBjbGVhciBu
b3cuIFByb2JhYmx5IHlvdSBjYW4gZXhwYW5kICJ0byBhdm9pZCB1bm5lY2Vzc2FyeQ0KbG9jayBv
cmRlciBzcGxhdCAiIGEgbGl0dGxlIGJpdCB0byBtYXJrIHRoZSBkZWFkIGxvY2sgYmV0d2VlbiBk
bWFyX2dsb2JhbF9sb2NrDQphbmQgY3B1X2hvdHBsdWdfbG9jayAoYWNxdWlyZWQgaW4gcGF0aCBv
ZiBpb21tdV9kZXZpY2VfcmVnaXN0ZXIoKSkuDQoNCldpdGggdGhhdDoNCg0KUmV2aWV3ZWQtYnk6
IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0KDQo+IA0KPiAgID09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiAgIFdBUk5JTkc6
IHBvc3NpYmxlIGNpcmN1bGFyIGxvY2tpbmcgZGVwZW5kZW5jeSBkZXRlY3RlZA0KPiAgIDYuMTQu
MC1yYzMtMDAwMDItZzhlNDYxN2I0NmRiMSAjNTcgTm90IHRhaW50ZWQNCj4gICAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICBzd2FwcGVy
LzAvMSBpcyB0cnlpbmcgdG8gYWNxdWlyZSBsb2NrOg0KPiAgIGZmZmZmZmZmYTJhNjdjNTAgKGNw
dV9ob3RwbHVnX2xvY2speysrKyt9LXswOjB9LCBhdDoNCj4gaW92YV9kb21haW5faW5pdF9yY2Fj
aGVzLnBhcnQuMCsweDFkMy8weDIxMA0KPiANCj4gICBidXQgdGFzayBpcyBhbHJlYWR5IGhvbGRp
bmcgbG9jazoNCj4gICBmZmZmOWY0YTg3YjE3MWM4ICgmZG9tYWluLT5pb3ZhX2Nvb2tpZS0+bXV0
ZXgpeysuKy59LXs0OjR9LCBhdDoNCj4gaW9tbXVfZG1hX2luaXRfZG9tYWluKzB4MTIyLzB4MmUw
DQo+IA0KPiAgIHdoaWNoIGxvY2sgYWxyZWFkeSBkZXBlbmRzIG9uIHRoZSBuZXcgbG9jay4NCj4g
DQo+IA0KPiAgIHRoZSBleGlzdGluZyBkZXBlbmRlbmN5IGNoYWluIChpbiByZXZlcnNlIG9yZGVy
KSBpczoNCj4gDQo+ICAgLT4gIzQgKCZkb21haW4tPmlvdmFfY29va2llLT5tdXRleCl7Ky4rLn0t
ezQ6NH06DQo+ICAgICAgICAgIF9fbG9ja19hY3F1aXJlKzB4NGEwLzB4YjUwDQo+ICAgICAgICAg
IGxvY2tfYWNxdWlyZSsweGQxLzB4MmUwDQo+ICAgICAgICAgIF9fbXV0ZXhfbG9jaysweGE1LzB4
Y2UwDQo+ICAgICAgICAgIGlvbW11X2RtYV9pbml0X2RvbWFpbisweDEyMi8weDJlMA0KPiAgICAg
ICAgICBpb21tdV9zZXR1cF9kbWFfb3BzKzB4NjUvMHhlMA0KPiAgICAgICAgICBidXNfaW9tbXVf
cHJvYmUrMHgxMDAvMHgxZDANCj4gICAgICAgICAgaW9tbXVfZGV2aWNlX3JlZ2lzdGVyKzB4ZDYv
MHgxMzANCj4gICAgICAgICAgaW50ZWxfaW9tbXVfaW5pdCsweDUyNy8weDg3MA0KPiAgICAgICAg
ICBwY2lfaW9tbXVfaW5pdCsweDE3LzB4NjANCj4gICAgICAgICAgZG9fb25lX2luaXRjYWxsKzB4
N2MvMHgzOTANCj4gICAgICAgICAgZG9faW5pdGNhbGxzKzB4ZTgvMHgxZTANCj4gICAgICAgICAg
a2VybmVsX2luaXRfZnJlZWFibGUrMHgzMTMvMHg0OTANCj4gICAgICAgICAga2VybmVsX2luaXQr
MHgyNC8weDI0MA0KPiAgICAgICAgICByZXRfZnJvbV9mb3JrKzB4NGEvMHg2MA0KPiAgICAgICAg
ICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzANCj4gDQo+ICAgLT4gIzMgKCZncm91cC0+bXV0
ZXgpeysuKy59LXs0OjR9Og0KPiAgICAgICAgICBfX2xvY2tfYWNxdWlyZSsweDRhMC8weGI1MA0K
PiAgICAgICAgICBsb2NrX2FjcXVpcmUrMHhkMS8weDJlMA0KPiAgICAgICAgICBfX211dGV4X2xv
Y2srMHhhNS8weGNlMA0KPiAgICAgICAgICBidXNfaW9tbXVfcHJvYmUrMHg5NS8weDFkMA0KPiAg
ICAgICAgICBpb21tdV9kZXZpY2VfcmVnaXN0ZXIrMHhkNi8weDEzMA0KPiAgICAgICAgICBpbnRl
bF9pb21tdV9pbml0KzB4NTI3LzB4ODcwDQo+ICAgICAgICAgIHBjaV9pb21tdV9pbml0KzB4MTcv
MHg2MA0KPiAgICAgICAgICBkb19vbmVfaW5pdGNhbGwrMHg3Yy8weDM5MA0KPiAgICAgICAgICBk
b19pbml0Y2FsbHMrMHhlOC8weDFlMA0KPiAgICAgICAgICBrZXJuZWxfaW5pdF9mcmVlYWJsZSsw
eDMxMy8weDQ5MA0KPiAgICAgICAgICBrZXJuZWxfaW5pdCsweDI0LzB4MjQwDQo+ICAgICAgICAg
IHJldF9mcm9tX2ZvcmsrMHg0YS8weDYwDQo+ICAgICAgICAgIHJldF9mcm9tX2ZvcmtfYXNtKzB4
MWEvMHgzMA0KPiANCj4gLT4gIzIgKGRtYXJfZ2xvYmFsX2xvY2speysrKyt9LXs0OjR9Og0KPiAg
ICAgICAgIF9fbG9ja19hY3F1aXJlKzB4NGEwLzB4YjUwDQo+ICAgICAgICAgbG9ja19hY3F1aXJl
KzB4ZDEvMHgyZTANCj4gICAgICAgICBkb3duX3JlYWQrMHgzMS8weDE3MA0KPiAgICAgICAgIGVu
YWJsZV9kcmhkX2ZhdWx0X2hhbmRsaW5nKzB4MjcvMHgxYTANCj4gICAgICAgICBjcHVocF9pbnZv
a2VfY2FsbGJhY2srMHgxZTIvMHg5OTANCj4gICAgICAgICBjcHVocF9pc3N1ZV9jYWxsKzB4YWMv
MHgyYzANCj4gICAgICAgICBfX2NwdWhwX3NldHVwX3N0YXRlX2NwdXNsb2NrZWQrMHgyMjkvMHg0
MzANCj4gICAgICAgICBfX2NwdWhwX3NldHVwX3N0YXRlKzB4YzMvMHgyNjANCj4gICAgICAgICBp
cnFfcmVtYXBfZW5hYmxlX2ZhdWx0X2hhbmRsaW5nKzB4NTIvMHg4MA0KPiAgICAgICAgIGFwaWNf
aW50cl9tb2RlX2luaXQrMHg1OS8weGYwDQo+ICAgICAgICAgeDg2X2xhdGVfdGltZV9pbml0KzB4
MjkvMHg1MA0KPiAgICAgICAgIHN0YXJ0X2tlcm5lbCsweDY0Mi8weDdmMA0KPiAgICAgICAgIHg4
Nl82NF9zdGFydF9yZXNlcnZhdGlvbnMrMHgxOC8weDMwDQo+ICAgICAgICAgeDg2XzY0X3N0YXJ0
X2tlcm5lbCsweDkxLzB4YTANCj4gICAgICAgICBjb21tb25fc3RhcnR1cF82NCsweDEzZS8weDE0
OA0KPiANCj4gLT4gIzEgKGNwdWhwX3N0YXRlX211dGV4KXsrLisufS17NDo0fToNCj4gICAgICAg
ICBfX2xvY2tfYWNxdWlyZSsweDRhMC8weGI1MA0KPiAgICAgICAgIGxvY2tfYWNxdWlyZSsweGQx
LzB4MmUwDQo+ICAgICAgICAgX19tdXRleF9sb2NrKzB4YTUvMHhjZTANCj4gICAgICAgICBfX2Nw
dWhwX3NldHVwX3N0YXRlX2NwdXNsb2NrZWQrMHg4MS8weDQzMA0KPiAgICAgICAgIF9fY3B1aHBf
c2V0dXBfc3RhdGUrMHhjMy8weDI2MA0KPiAgICAgICAgIHBhZ2VfYWxsb2NfaW5pdF9jcHVocCsw
eDJkLzB4NDANCj4gICAgICAgICBtbV9jb3JlX2luaXQrMHgxZS8weDNhMA0KPiAgICAgICAgIHN0
YXJ0X2tlcm5lbCsweDI3Ny8weDdmMA0KPiAgICAgICAgIHg4Nl82NF9zdGFydF9yZXNlcnZhdGlv
bnMrMHgxOC8weDMwDQo+ICAgICAgICAgeDg2XzY0X3N0YXJ0X2tlcm5lbCsweDkxLzB4YTANCj4g
ICAgICAgICBjb21tb25fc3RhcnR1cF82NCsweDEzZS8weDE0OA0KPiANCj4gLT4gIzAgKGNwdV9o
b3RwbHVnX2xvY2speysrKyt9LXswOjB9Og0KPiAgICAgICAgIGNoZWNrX3ByZXZfYWRkKzB4ZTIv
MHhjNTANCj4gICAgICAgICB2YWxpZGF0ZV9jaGFpbisweDU3Yy8weDgwMA0KPiAgICAgICAgIF9f
bG9ja19hY3F1aXJlKzB4NGEwLzB4YjUwDQo+ICAgICAgICAgbG9ja19hY3F1aXJlKzB4ZDEvMHgy
ZTANCj4gICAgICAgICBfX2NwdWhwX3N0YXRlX2FkZF9pbnN0YW5jZSsweDQwLzB4MjUwDQo+ICAg
ICAgICAgaW92YV9kb21haW5faW5pdF9yY2FjaGVzLnBhcnQuMCsweDFkMy8weDIxMA0KPiAgICAg
ICAgIGlvdmFfZG9tYWluX2luaXRfcmNhY2hlcysweDQxLzB4NjANCj4gICAgICAgICBpb21tdV9k
bWFfaW5pdF9kb21haW4rMHgxYWYvMHgyZTANCj4gICAgICAgICBpb21tdV9zZXR1cF9kbWFfb3Bz
KzB4NjUvMHhlMA0KPiAgICAgICAgIGJ1c19pb21tdV9wcm9iZSsweDEwMC8weDFkMA0KPiAgICAg
ICAgIGlvbW11X2RldmljZV9yZWdpc3RlcisweGQ2LzB4MTMwDQo+ICAgICAgICAgaW50ZWxfaW9t
bXVfaW5pdCsweDUyNy8weDg3MA0KPiAgICAgICAgIHBjaV9pb21tdV9pbml0KzB4MTcvMHg2MA0K
PiAgICAgICAgIGRvX29uZV9pbml0Y2FsbCsweDdjLzB4MzkwDQo+ICAgICAgICAgZG9faW5pdGNh
bGxzKzB4ZTgvMHgxZTANCj4gICAgICAgICBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDMxMy8weDQ5
MA0KPiAgICAgICAgIGtlcm5lbF9pbml0KzB4MjQvMHgyNDANCj4gICAgICAgICByZXRfZnJvbV9m
b3JrKzB4NGEvMHg2MA0KPiAgICAgICAgIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMA0KPiAN
Cj4gICBvdGhlciBpbmZvIHRoYXQgbWlnaHQgaGVscCB1cyBkZWJ1ZyB0aGlzOg0KPiANCj4gICBD
aGFpbiBleGlzdHMgb2Y6DQo+ICAgICBjcHVfaG90cGx1Z19sb2NrIC0tPiAmZ3JvdXAtPm11dGV4
IC0tPiAmZG9tYWluLT5pb3ZhX2Nvb2tpZS0+bXV0ZXgNCj4gDQo+ICAgIFBvc3NpYmxlIHVuc2Fm
ZSBsb2NraW5nIHNjZW5hcmlvOg0KPiANCj4gICAgICAgICAgQ1BVMCAgICAgICAgICAgICAgICAg
ICAgQ1BVMQ0KPiAgICAgICAgICAtLS0tICAgICAgICAgICAgICAgICAgICAtLS0tDQo+ICAgICBs
b2NrKCZkb21haW4tPmlvdmFfY29va2llLT5tdXRleCk7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGxvY2soJmdyb3VwLT5tdXRleCk7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGxvY2soJmRvbWFpbi0+aW92YV9jb29raWUtPm11dGV4KTsNCj4gICAgIHJs
b2NrKGNwdV9ob3RwbHVnX2xvY2spOw0KPiANCj4gICAgKioqIERFQURMT0NLICoqKg0KPiANCj4g
ICAzIGxvY2tzIGhlbGQgYnkgc3dhcHBlci8wLzE6DQo+ICAgICMwOiBmZmZmZmZmZmE2NDQyYWIw
IChkbWFyX2dsb2JhbF9sb2NrKXsrKysrfS17NDo0fSwgYXQ6DQo+IGludGVsX2lvbW11X2luaXQr
MHg0MmMvMHg4Nw0KPiAgICAjMTogZmZmZjlmNGE4N2IxMTMxMCAoJmdyb3VwLT5tdXRleCl7Ky4r
Ln0tezQ6NH0sIGF0Og0KPiBidXNfaW9tbXVfcHJvYmUrMHg5NS8weDFkMA0KPiAgICAjMjogZmZm
ZjlmNGE4N2IxNzFjOCAoJmRvbWFpbi0+aW92YV9jb29raWUtPm11dGV4KXsrLisufS17NDo0fSwg
YXQ6DQo+IGlvbW11X2RtYV9pbml0X2QNCj4gDQo+ICAgc3RhY2sgYmFja3RyYWNlOg0KPiAgIENQ
VTogMSBVSUQ6IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZA0KPiA2LjE0LjAt
cmMzLTAwMDAyLWc4ZTQ2MTdiNDZkYjEgIzU3DQo+ICAgQ2FsbCBUcmFjZToNCj4gICAgPFRBU0s+
DQo+ICAgIGR1bXBfc3RhY2tfbHZsKzB4OTMvMHhkMA0KPiAgICBwcmludF9jaXJjdWxhcl9idWcr
MHgxMzMvMHgxYzANCj4gICAgY2hlY2tfbm9uY2lyY3VsYXIrMHgxMmMvMHgxNTANCj4gICAgY2hl
Y2tfcHJldl9hZGQrMHhlMi8weGM1MA0KPiAgICA/IGFkZF9jaGFpbl9jYWNoZSsweDEwOC8weDQ2
MA0KPiAgICB2YWxpZGF0ZV9jaGFpbisweDU3Yy8weDgwMA0KPiAgICBfX2xvY2tfYWNxdWlyZSsw
eDRhMC8weGI1MA0KPiAgICBsb2NrX2FjcXVpcmUrMHhkMS8weDJlMA0KPiAgICA/IGlvdmFfZG9t
YWluX2luaXRfcmNhY2hlcy5wYXJ0LjArMHgxZDMvMHgyMTANCj4gICAgPyByY3VfaXNfd2F0Y2hp
bmcrMHgxMS8weDUwDQo+ICAgIF9fY3B1aHBfc3RhdGVfYWRkX2luc3RhbmNlKzB4NDAvMHgyNTAN
Cj4gICAgPyBpb3ZhX2RvbWFpbl9pbml0X3JjYWNoZXMucGFydC4wKzB4MWQzLzB4MjEwDQo+ICAg
IGlvdmFfZG9tYWluX2luaXRfcmNhY2hlcy5wYXJ0LjArMHgxZDMvMHgyMTANCj4gICAgaW92YV9k
b21haW5faW5pdF9yY2FjaGVzKzB4NDEvMHg2MA0KPiAgICBpb21tdV9kbWFfaW5pdF9kb21haW4r
MHgxYWYvMHgyZTANCj4gICAgaW9tbXVfc2V0dXBfZG1hX29wcysweDY1LzB4ZTANCj4gICAgYnVz
X2lvbW11X3Byb2JlKzB4MTAwLzB4MWQwDQo+ICAgIGlvbW11X2RldmljZV9yZWdpc3RlcisweGQ2
LzB4MTMwDQo+ICAgIGludGVsX2lvbW11X2luaXQrMHg1MjcvMHg4NzANCj4gICAgPyBfX3BmeF9w
Y2lfaW9tbXVfaW5pdCsweDEwLzB4MTANCj4gICAgcGNpX2lvbW11X2luaXQrMHgxNy8weDYwDQo+
ICAgIGRvX29uZV9pbml0Y2FsbCsweDdjLzB4MzkwDQo+ICAgIGRvX2luaXRjYWxscysweGU4LzB4
MWUwDQo+ICAgIGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4MzEzLzB4NDkwDQo+ICAgID8gX19wZnhf
a2VybmVsX2luaXQrMHgxMC8weDEwDQo+ICAgIGtlcm5lbF9pbml0KzB4MjQvMHgyNDANCj4gICAg
PyBfcmF3X3NwaW5fdW5sb2NrX2lycSsweDMzLzB4NTANCj4gICAgcmV0X2Zyb21fZm9yaysweDRh
LzB4NjANCj4gICAgPyBfX3BmeF9rZXJuZWxfaW5pdCsweDEwLzB4MTANCj4gICAgcmV0X2Zyb21f
Zm9ya19hc20rMHgxYS8weDMwDQo+ICAgIDwvVEFTSz4NCj4gDQo+IFRoYW5rcywNCj4gYmFvbHUN
Cg==

