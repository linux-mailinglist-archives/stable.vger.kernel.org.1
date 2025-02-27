Return-Path: <stable+bounces-119789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC03A47502
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 06:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9ED3ABE8C
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 05:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EF21E5216;
	Thu, 27 Feb 2025 05:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iBgJAzVa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CB31CAA79
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 05:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632685; cv=fail; b=eqvzbOa/bPev5oo7OHor6Nk8RZhGRVzWGliPLzSN0ocPUCQ/GBhEBmJjlPrBgMB9YZXiZLcGkOPYz7NeDGC7YKTMG1yXT47G4Yw+HAcNJkaonLESxI0K3+4A3P/SJpinkLr7yKZveCvgarvhHZF5N1M4UVsG8t3WzXxo/N9dbRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632685; c=relaxed/simple;
	bh=IvL7bwvDWVY3hOJ5Uw3mn1Cj426Prvu+9+rEfFKj1j0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bmPjF8dZS6TzlDWsCjLhS567fCkVubreD1slxNO+7gf8bhrxmGIOv+WMC3LpGFgMlZU48HkUnb61a1+DNsohRMGQw58EevAf98JvaxIemJahw4d1NmBgn7v4reOfNmSAqobbPKQ8i04rTknz2XvtBHcHJw1OKHIfDxend/5LTEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iBgJAzVa; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740632685; x=1772168685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IvL7bwvDWVY3hOJ5Uw3mn1Cj426Prvu+9+rEfFKj1j0=;
  b=iBgJAzVaHiGM9icmNqOZdX1kiWbEZ7KW26RRLmb7gR0M2odshAs7SiI2
   42XItJFy4bQcaZ7oksagBUEmQik4r+RpWiHofncxcctFjrdmhxxJwu8rv
   h4bKMZ0QMp1ZEf1947yskMuA6OMnrYqJbDbGDRhwdlMBuMb45vBw5K2AC
   uMbm6/+xroL/p25mYXG03PnE0jApGz5bFqW+LQEHSXeeUvhyRuC2J2JZn
   lwB6JII9Dw3npOh3YkYZ7TvrxFDEq10wkeWWNa7L9xbWbvNx9JfFUDlbw
   AI/t+VQg2THIJ/NW8nmU3vb58NoRiysJSf5dlBopQnkE5S5zYMcsikNV0
   A==;
X-CSE-ConnectionGUID: yLZ3JlkjS9eltE5MxJxeug==
X-CSE-MsgGUID: uTysJpD9S3OLjFyG0E0HmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="51716613"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="51716613"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:04:44 -0800
X-CSE-ConnectionGUID: Hp2yFqlkStGJyo9SPVtjQg==
X-CSE-MsgGUID: YcFtoGHsRCGHBdmnLosccg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117827729"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:04:43 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 21:04:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 21:04:43 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 21:04:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h087PfAwuTEiocmHyXkgFYsOGYFCPj1rZhgeWe24hS4xMvt1bututVuJqeoUozvgkA8UnLp6OiyUSfTLCEG/xGgsTc1Jbf+vvO5pQ4qrqfbbzqVF8y1Z3Jh5yYGysPoF76t+rYK2KIkuWVLR/EACUn2GlMLosyMSXpL/hkuLa1+kOiINmJlrhKNW5KWy93FqBs7vIX8p0IaJ/Gd5Migi2GviRRyVQTluGHtQsp+AoIUFd5RVGOMdESoYQFQ4Qe3kXm2+rdmrm3ftqpbOkDzreyKDe66+5+B0aSmSPt9HOyhEnPyaoDpBYCR/EcjWPEWRkW5ULXP5DpMf/ANhAqSWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvL7bwvDWVY3hOJ5Uw3mn1Cj426Prvu+9+rEfFKj1j0=;
 b=eIn7PMfArxvs20SVTDB8vDQEs5Fh8gSoQ8ptKkBC1RSFfyvz8yVAcrzbOMeLsxxUVuDxg8y9NdcRDOUwqLdYdn8a6GteaJVmP1NVVuu32RVTHl5ugD7guaBaQiRsMvFh1GUv4qihgyIQP8abH/i3bBOQHOi47uO/D2oJ2n/c6kgDsm2Irpm55Ki7H36gKyAghmBG7HObxl/CjWL6VWTO+i0Rn9MZWZr19xs5j5OjbPb/djqV6svGbuHQq4DcRgHuLXFndlVWL1Wzh7i2dM24ffhCetptq3BHxHUOFsppYVPWQHA+S6RKQeFuh0Ga58JXZ3KMosGF6GLJ3ZODvRgVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6204.namprd11.prod.outlook.com (2603:10b6:a03:459::19)
 by SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 05:04:39 +0000
Received: from SJ1PR11MB6204.namprd11.prod.outlook.com
 ([fe80::fd8d:bca9:3486:7762]) by SJ1PR11MB6204.namprd11.prod.outlook.com
 ([fe80::fd8d:bca9:3486:7762%4]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 05:04:39 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, "Souza, Jose"
	<jose.souza@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/4] drm/xe/vm: Fix a misplaced #endif
Thread-Topic: [PATCH 2/4] drm/xe/vm: Fix a misplaced #endif
Thread-Index: AQHbiGQAwAkUVfHZIEmShEFsO34gYrNamT4Q
Date: Thu, 27 Feb 2025 05:04:39 +0000
Message-ID: <SJ1PR11MB6204A0EDC7A96BE7EAF8F4FC81CD2@SJ1PR11MB6204.namprd11.prod.outlook.com>
References: <20250226153344.58175-1-thomas.hellstrom@linux.intel.com>
 <20250226153344.58175-3-thomas.hellstrom@linux.intel.com>
In-Reply-To: <20250226153344.58175-3-thomas.hellstrom@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6204:EE_|SN7PR11MB6604:EE_
x-ms-office365-filtering-correlation-id: 42c948d7-4512-47c4-a0bc-08dd56ec3cea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MEQ3WlBmazNjL0JrKzgzNUxRaVdsVE16blRsZXRPbWkzMC9BbmV4T0JBelhv?=
 =?utf-8?B?RFIwREdCZWl3Uks1b1dRWnBtR081QVEvWHZiSXp5ZE1MeUJsVnRJNFliQVkr?=
 =?utf-8?B?TldVS1Q1YVRBcEZzVEJtSG9MSVJoLzlBa0ozQ1IxTlZ4cEZVUHFBTXNMbmJ2?=
 =?utf-8?B?eTdGaGt2aHRJQ2hXeko4VEJKd2JVREZHRmpwTDJHbTh6TjhOeEtlYXRhTWw1?=
 =?utf-8?B?MzN5SmpSTFI0M0Z0dHo2ZS9PZm9wdTNKWElqK3NOanFUVUVLR1FTbDgwTnhQ?=
 =?utf-8?B?dS9pT0hCcHExOG9QclpPNmg5d2VUZ0dqVkVhdVVHRlRFUjI3K0RxbU1ITVZS?=
 =?utf-8?B?bHMvN095dVh6R2Z5NzNNV1hLajYxNS82L2dPdHJBMmgxa05MSjRjSDZGZWda?=
 =?utf-8?B?d2FQMHE4RkN1VHlhWFpGQVVSeU5IUmdCZ05nVzAvcFg2RFExQUxwRloyZEZE?=
 =?utf-8?B?dmg3L2hSeTFqUzE4emlZT2NRYU1nTzN5T0lUcDlPbUVQdFNQdUhtcHcxajZG?=
 =?utf-8?B?Ukx4Rmk4dEM2ZEwzYjNwUFAzWDNYTzVjY1Z5TnhBNXFjRFdDRXJlNUxBY0di?=
 =?utf-8?B?T011S3VoSEYzQVJIRklSS29uc1pwcDdvWmRwMHEvVGJXUVZFVnN1a2czMmkx?=
 =?utf-8?B?MEdPdGVjeHUvVVFsZzZhSUk0L3Yyd1gwK0djbFI0UTlRV0RiS0R1K0FJcGdB?=
 =?utf-8?B?K3A0MWVWRUhKL0ZKQTQ0MWMvS2tWZjVwd2NqZEYyV1lNYXAwNkZjT1FzYTRE?=
 =?utf-8?B?WDBTMWRyQzhmYXFpRU1TWDFad3VnZE11WTAwMVhZMlJtZXdzS21VTWQzNkFw?=
 =?utf-8?B?ZDUxVzJnMTdNMjVyQ0N0RFp1Tzh1bzUvZ3A5TlAxbjNJOVltVk9uNEsxNlRi?=
 =?utf-8?B?QTNONDA0VEkyWGFiU1YvdDkwK3RjT3NGZ2ZOSmRXc2I1S3RGbzAwUzhreGt0?=
 =?utf-8?B?MStrZktTOGM4bktpeFZPenJVWlUweEtuSFFZODJieDRWQ3NaVEdUNEFiTC93?=
 =?utf-8?B?RlMraHhSTzhLR2ZrOHNwQUJBVStDVXRablFzc20rTVBZdXEvYWlQSWd5R3Zy?=
 =?utf-8?B?R3RpVUxGNzgxQXE4aW9wYllJZnNaL0wwU1NkUWd3VU1LTU1IUjVRWDBqQ1Jh?=
 =?utf-8?B?RHNPTVRHUjN2SHlKK1BFRVphNkhTUHZpV3lnVU9yTisrUCsyc2NHVXB3OWU0?=
 =?utf-8?B?RGtZRWJWV0xLRUxXK0tEQXdGcXdXRkVUNGNTbHlpY21tVW5rWStOSW1kR0dU?=
 =?utf-8?B?bHExVG5FTUlFTDh1M0RMQXhmNlRRVkJpVjRKa25ic0dJN3RVNkI3em43Snp0?=
 =?utf-8?B?cENudzFaY2pyeFFDNnRES0pGeHhYREtIeXhkR29CZUpHUVJrRFk4YWZSSTJP?=
 =?utf-8?B?ZEJHSGdVSDlIdFgvYVR4M0VWbjBSSFFzWmJJL2JDMHBrK3o2Y1o5aFBBNHFv?=
 =?utf-8?B?S1BzUDVQZnAxS0ppSFI4VFNiQnpDKy8wSWo4eURXR3Babkdqd0hrbVE4L29C?=
 =?utf-8?B?ZURmcTVXRDRQRmJ6WFM3THRGb1NtcVppY1NjOEl6RGM5UGFUd0NJOEJYOVAw?=
 =?utf-8?B?WkhiSWFyZEZ6MTM5YUZiZm5NODliUFVJelJMWm04aStpZTlIdGxQa3YvbFU1?=
 =?utf-8?B?L0V4N3hpUnpxaWJwMDNpd1YyZDJJODNmL0E3STQ1TU1tczY3eW56c3hBckRL?=
 =?utf-8?B?RzNVZzJCNE4rZjlHc1J3YkFVaGYxL0lma2dIcy9pYUtXQ25JZmNkMzczeU54?=
 =?utf-8?B?NGUvNWt2NDNKdkx2cFRvcVVZUUdqbXFsOGlKaUhQUGJhWjU2a3o4WkF6WHRV?=
 =?utf-8?B?d0tuYWFSa09iZ0JMd3RRcm14bEhxSWFHM3cwQ3VsWVFqd1NRMEhmdGw4UG5C?=
 =?utf-8?B?QmUwYVQ4dVdQZjk3WUJ3V0lLTHV1TFVnUzBSQURjOC9QVXBGUjR4UkhUaXZp?=
 =?utf-8?Q?6P9JlBlqR8A8FxqjyaG6fav07Z8Klvpu?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6204.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUVVV05TUkRqcVdWdG5GdHR2cnNERkp1NEU1b21ycGNxeDdueVBVcDFScHI2?=
 =?utf-8?B?RE9lOUswTzJ0ZWlYUE01V1o1K1IxYnluWWVSKzJ4dGNSMWhYSlpZMVJMZlps?=
 =?utf-8?B?dkNsOVhSczI1UW1tSFZlZm0rbS9LLzJYZlAvSzZJU0xhYk1UTkNJbzZtVXZl?=
 =?utf-8?B?NEo2NjNtOVBEWW1hTkMrMllNV2ltZTNXbEV1d3NpNGlpZHM1ZjdUL0JWeVlk?=
 =?utf-8?B?MEVYZ2xMSE5SZXV5VWg3cURVR3pNK3AxWC9TeFh4OXZuMzhvTVY4ZmZ5SnpK?=
 =?utf-8?B?Q20xcnYvdzZxWnR5UlNOdmhkWlY3Vld3Z0VUVjZpZzkzeEdwOEZidWpRenFo?=
 =?utf-8?B?dVl5cXBYdXFhbFRGbTFERk5lbXViazk4TDV5bU5xTlJLN1FqbmVTMTFwMEpt?=
 =?utf-8?B?RlZYVFQ0M2tGODNRZ2h1V0hLR1dmVkZ6NnZEV0VCc1dTTXhkaVMvMnRGVFBu?=
 =?utf-8?B?RTR1cXgvRGFiZlcwcEthVCs0YmJTYURNN3hrWGZSSWRPTjNBZUxRb2l4aUlQ?=
 =?utf-8?B?bmFGS2FXTEpoYmZqRVFMcytCQlhQWVJsWGxyRm1rY3JhTHV4OXdMZXJ5UFNq?=
 =?utf-8?B?bXcvb3hLc29iV3FmVEEzOHVTWGYrdzBjbnpMNVVtc25pUGZUOG1FZFZhNGU4?=
 =?utf-8?B?VnN0SkxscGJUZERBT2pyRVN0THVYc2Z6Y3Y2Z3FhRFFTYUxZQm4xNkdRRGU5?=
 =?utf-8?B?Qk9id1UrYW9TNEpmcVNLVUNneWNCSGtVQkljc1B4RkpNeTlZQXNlZGZsb090?=
 =?utf-8?B?UjJUdkorVXNEWDZhZzcvN2tJTm9kajJxV29FaEwycFZJK3F1UW5USzI4U1c5?=
 =?utf-8?B?TlJLckJDOFk4NmtPZkNoVi9OK0RNVnhjTkQ2YTJoZEQ1a1JhTjhVaDhCR2pa?=
 =?utf-8?B?S0c5NU1pZldQL2RqZHNibFBGNm9DL3pSTWNhMFQrdmpFYTgvMzZmK1RLQm5O?=
 =?utf-8?B?a0xWa3paUlFzMjJIUDJoeXZ1TVIvOEhZT2ZvdTRhYnRCSmord0hHKzNLcDBE?=
 =?utf-8?B?N2wrYkxLKyt2cldhQk82ZWl6eEFvUmk4V0tiYk9xUjN0ZFhlV21wK28yOG5B?=
 =?utf-8?B?NmhhcmtvWllrRWo4YktzalV1STd0a3BFSTh0amVCSWxKRGZEbnFmNm0zdlBJ?=
 =?utf-8?B?WVg2cndZczNiM2RaSEpQVWhEaU5ORTgrNVVsTXhBRWRwbG5wTWU0alJNQUMw?=
 =?utf-8?B?RmN6dHhLdStyM2ZaaE5sUklNZmJtUUk3T2tWc2wyQ2U3czVtMm54bTU1dXoz?=
 =?utf-8?B?dVNNS1JUeXZvbklXdys0MlNVMkw2V1V6K3QwdFcxZDVCTndadVlhU0tYdUc3?=
 =?utf-8?B?UlozcU1WZGdSYTYwK2lSS3A3MWZWcjFxYzNvS2x3aG1hSTB1Y001T3pvVUZH?=
 =?utf-8?B?RW85WnR4WFMvMWxJOXZ3VTdEM2FCbGZrR1pPTWwwNnp5eGJ0dkxUZExoVUJO?=
 =?utf-8?B?dG92QjhjRXU3c2k4YjZMUDUrNXF3eGNXUkpVSFR1a08yZC9BNkd6Zm9lLzZy?=
 =?utf-8?B?UDY2elBkN25UYklQMWpMei9mOUFTeVB6cFcrY2wrZVBYU3hTaVhYWlJkeHBJ?=
 =?utf-8?B?NXI5K3FaMkNxRWI1REp0b3oxSzViQXFjUFpNWHBNUGNvSkVzVzNBZ3RhM2hM?=
 =?utf-8?B?aVNVaW55WW9GSS9haVlUTTQrKzZRTVROZ3RsUnFWM2ZBVEZoNDIrTHNNckRG?=
 =?utf-8?B?Z0VKa2llSGwzSjQybC92NXlRTU9YV25uUGhuRi9HM3IyNnRQUW4wS1B5K2Nz?=
 =?utf-8?B?WjBIcFVpUEhwMUcrUjc4cGFlcllQQnh4L0lOU3BUOXdCSVNaU1FCK0JMUE10?=
 =?utf-8?B?QUZLOTV5WGhDdWROQTZWUEZZUU12emk2Nm54a3p3T2xlSW5kSldTM0VBYUN6?=
 =?utf-8?B?ZTYrRERRd24vSjduL28rcGNoaDlCSTI3YVRmSzN0ajkrUHJHUW5UcEFpRnVy?=
 =?utf-8?B?S2JzbTNxS01DL1lRVHNhVWdoRlhMT1JXUXkva2xzM2E4RXJWZ2hMZnE4a2Fj?=
 =?utf-8?B?QVV5YjIrSjV2Z2R5RHp0MkZ6eWc5NFhWaHVNUWx4QzFsTURkcHlFYWdlbnl5?=
 =?utf-8?B?bTlvMklmWVhUcGd1Y3VSMVM5U0VIZlpPRnZNL1VNSTBqcWxCaDIwSk51c2ZV?=
 =?utf-8?Q?QLKsVTfxanbqA/GgzPTw6F0LG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c948d7-4512-47c4-a0bc-08dd56ec3cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 05:04:39.0731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P0zuEoSeQU/pFNCwdlA3dNSuI9n4OzMhlYSEPwb1E4yl0+d8iaWmmPjkx7q5dZiQs+GykjikwaJcV/tpi54Ss8inLrMl/FoijQEKyZ5AJUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6604
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwteGUgPGludGVs
LXhlLWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgVGhvbWFzDQo+
IEhlbGxzdHLDtm0NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyNiwgMjAyNSA5OjA0IFBN
DQo+IFRvOiBpbnRlbC14ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IFRob21hcyBIZWxs
c3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVsLmNvbT47IE1hYXJ0ZW4NCj4gTGFu
a2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+OyBTb3V6YSwgSm9zZQ0K
PiA8am9zZS5zb3V6YUBpbnRlbC5jb20+OyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFtQQVRDSCAyLzRdIGRybS94ZS92bTogRml4IGEgbWlzcGxhY2VkICNlbmRpZg0KPiANCj4g
Rml4IGEgKGhhcm1sZXNzKSBtaXNwbGFjZWQgI2VuZGlmIGxlYWRpbmcgdG8gZGVjbGFyYXRpb25z
IGFwcGVhcmluZyBtdWx0aXBsZQ0KPiB0aW1lcy4NCj4gDQo+IEZpeGVzOiAwZWIyYTE4YThmYWQg
KCJkcm0veGU6IEltcGxlbWVudCBWTSBzbmFwc2hvdCBzdXBwb3J0IGZvciBCTydzIGFuZA0KPiB1
c2VycHRyIikNCj4gQ2M6IE1hYXJ0ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51
eC5pbnRlbC5jb20+DQo+IENjOiBKb3PDqSBSb2JlcnRvIGRlIFNvdXphIDxqb3NlLnNvdXphQGlu
dGVsLmNvbT4NCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY2LjkrDQo+IFNpZ25l
ZC1vZmYtYnk6IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVs
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0veGUveGVfdm0uaCB8IDIgKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV92bS5oIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hl
X3ZtLmggaW5kZXgNCj4gZjY2MDc1ZjhhNmZlLi43YzhlMzkwNDkyMjMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS94ZS94ZV92bS5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94
ZV92bS5oDQo+IEBAIC0yODIsOSArMjgyLDkgQEAgc3RhdGljIGlubGluZSB2b2lkIHZtX2RiZyhj
b25zdCBzdHJ1Y3QgZHJtX2RldmljZQ0KPiAqZGV2LA0KPiAgCQkJICBjb25zdCBjaGFyICpmb3Jt
YXQsIC4uLikNCj4gIHsgLyogbm9vcCAqLyB9DQo+ICAjZW5kaWYNCj4gLSNlbmRpZg0KPiANCj4g
IHN0cnVjdCB4ZV92bV9zbmFwc2hvdCAqeGVfdm1fc25hcHNob3RfY2FwdHVyZShzdHJ1Y3QgeGVf
dm0gKnZtKTsgIHZvaWQNCj4geGVfdm1fc25hcHNob3RfY2FwdHVyZV9kZWxheWVkKHN0cnVjdCB4
ZV92bV9zbmFwc2hvdCAqc25hcCk7ICB2b2lkDQo+IHhlX3ZtX3NuYXBzaG90X3ByaW50KHN0cnVj
dCB4ZV92bV9zbmFwc2hvdCAqc25hcCwgc3RydWN0IGRybV9wcmludGVyICpwKTsNCj4gdm9pZCB4
ZV92bV9zbmFwc2hvdF9mcmVlKHN0cnVjdCB4ZV92bV9zbmFwc2hvdCAqc25hcCk7DQo+ICsjZW5k
aWYNCg0KTEdUTSwNClJldmlld2VkLWJ5OiBUZWphcyBVcGFkaHlheSA8dGVqYXMudXBhZGh5YXlA
aW50ZWwuY29tPg0KDQpUZWphcw0KPiAtLQ0KPiAyLjQ4LjENCg0K

