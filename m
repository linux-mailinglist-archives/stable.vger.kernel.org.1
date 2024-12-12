Return-Path: <stable+bounces-100852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E79C9EE120
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE291689AC
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C173C20C03A;
	Thu, 12 Dec 2024 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ielVCVs0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FEE20CCC1;
	Thu, 12 Dec 2024 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991561; cv=fail; b=Vvwq5E3BFyNHhScXCPY4xMpYq6Wzu14pQXAWkqNboT9hdzqCZ7cWCHyEFk7MRBsDXxKQej/XZLVxloOi5FO6mF7s6cp1ua30ZtfIblYPC1PdMq96zOJHiSEh1veZ7tqhI5aofnY38yFORxra2gsmBCjzqJ+RqLQzRxijqJcw3T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991561; c=relaxed/simple;
	bh=TEGf0Lw9Any8o3pEtdFlpB0ZVj80HG9x99wn2DewaYI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IeDxMQA9fjQzBBPffQb935SendAUMaZkcInRm4zBqGddZN5mvu/ar3UR8zuYRsDUB+a9fJzZfGa/t4jyKoAks4q/2jadm3aDN+3fYNDgp6fbET2wsEpZ5wt18Ujxm5RT4hJ+9MO5I3OvgOjNAIO9WFRIadan+pVGy0SHJaYJ1l8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ielVCVs0; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733991560; x=1765527560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TEGf0Lw9Any8o3pEtdFlpB0ZVj80HG9x99wn2DewaYI=;
  b=ielVCVs0TmrKNHCRwapgzNmBkCVbFDxOf9vWxM0XyS6Cbsm0Seofk+zk
   gJ1sTuagK6kIDA9pDKTVUxoHN47Ofzl9puDsmScXESO/0SrenFQuNffUG
   6jJ4MW837U1VjhFLmHnUYP1FPbE+KJ9iB3Xvyx9ynFwsksBtMLSw41HfN
   Yy7H8Yk18PpGwSMw0Lpil47cOC6AaYEuy2Z1IgiP5mnSPgxiSAyawge/R
   l20f3oOHtdjdddvwlnuldO6GvGXfjJavNxJhZSEz8ABcdA2ZnFy0lZcxn
   urix9UCs8E5/iUHCx1SYR2gcNwRb/92FRDZKT2CX1IezLsAFnVmiu29pM
   Q==;
X-CSE-ConnectionGUID: cBi5nr+bS5+aksx+edT7cQ==
X-CSE-MsgGUID: mwt2EDe3TY+ZewhhH7CJmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34526266"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34526266"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 00:19:18 -0800
X-CSE-ConnectionGUID: N2Le6lI/R4WypUivB2aMYA==
X-CSE-MsgGUID: zBhMw67pTDK0UHCh0zkApg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="101021292"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 00:19:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 00:19:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 00:19:16 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 00:19:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oS+E74VCxwpdpvnTKQSv5EZ5WetjWAJBWpYK95fAz8KK4YCYJ6+nskmnwJdjTTf58Air2viLaoMndTvxbs65ghZAI916qJizshhaD8pHseB4mKigRCqMZGyBPalLpdaX89fs0aXEYBjMx+sAdSV82SyI1JQsMkOs56Maxy6i/t7PI05/tzgH82iqmBN6eaNN87+O5MBl+sUrI+Hm9iswILKwHgCB5cw5yo8blSANeWpoRiQlhU8AMcmrfezJGTIVimf/uqJQneYZG94DcLcxo1fRMDRQJJE3y9fw33mh9W95wyMyiMIV0ry+htt4BeBgZnsGNujkBaxG4MenYA09gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEGf0Lw9Any8o3pEtdFlpB0ZVj80HG9x99wn2DewaYI=;
 b=YGHYmdzJrVAZX2FBiHJw4H27J0TwuxvjXC1wn8mYaEiPQZS7sZ27jx7+frYe+HXIcZxYqeAbBtHUME57gJcq/tnjWfhAg6i0KTEr1/fc7JEnxy75XGOoeuKescLIOszu8xBO5xammmZjBl6NVoRwuPGMkVA2tNjd/qeEmH7rLJl4U8VhJ9ZxWhETeKOoJuGHp3030jq9J2nWwzu3ih4cq+zBr02o8cetPLmz9Ay/HNfE5I9YnRJ6BmSdnQbJGVlAJNfWU/gOMhcsxKMS5zFchjwlx3rc9Bo2UU0owQQB1rHO8hUpi9oykPtSibOVbRoEo6MZo2Va0tivqkygo4jBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 08:19:14 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 08:19:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] iommu/vt-d: Fix kernel NULL pointer dereference in
 cache_tag_flush_range_np()
Thread-Topic: [PATCH] iommu/vt-d: Fix kernel NULL pointer dereference in
 cache_tag_flush_range_np()
Thread-Index: AQHbTGdWH2+KP9v0M0K5lC4EFs8zwrLiOrCAgAAF3dA=
Date: Thu, 12 Dec 2024 08:19:13 +0000
Message-ID: <SJ0PR11MB6744E3960431FEB30C36DE7A923F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241212072419.480967-1-zhenzhong.duan@intel.com>
 <760e2a44-299a-4369-a416-ead01d109514@intel.com>
In-Reply-To: <760e2a44-299a-4369-a416-ead01d109514@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL3PR11MB6529:EE_
x-ms-office365-filtering-correlation-id: d9a5aa94-a69e-430a-aba4-08dd1a85a98c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M0lTS3dXSzN0dkNUWHBzeS95aTFmNWdtSFRkRUpyL0RVei9Zc1JuMXJBRjkw?=
 =?utf-8?B?NE1WTXFtN1R0UnRyL3dmQW0wNzhjR1V1K0U4LzVZMCtlSEczR2Z5aHN4WGsz?=
 =?utf-8?B?SElxTU1TUElyaUdETXN5b3RmSjF6ME9UV2VGRXo2YXVKdW96WXZmaW9mV0Rk?=
 =?utf-8?B?SzhGYlVITnlJLzhZdzdpc1FoVFJiVTBUMTVjRG94R3NvemRSeDg4WDlBZVZz?=
 =?utf-8?B?TUlGckxpemcrY2luVDBlZmwxN09TcGRUNVpMVUw5Zm94Y2t1RDdwdWcwUWlw?=
 =?utf-8?B?K3FlMERPRmxyVHhKRCtmRExPT2g1VEQyTzZ4RGg0cm9vVG9zZ1I2SDRaZTlI?=
 =?utf-8?B?WElOcmE0MkJweE9HdC8xemxSNE5Lb1l1c1JGcVhCMTNHTFRPZ2RNUFNubmR4?=
 =?utf-8?B?ZXBVMWt3TzNkUjJNMER3OGxFRDVTamlBV2lPRzFKcHM3OXZYTUt5YXVxaFFZ?=
 =?utf-8?B?MS9YSm05V09jQ01vUHR2akc2ckE3VGVlaTE5SUwrSzVNRXNJTG4zVUhLSmJC?=
 =?utf-8?B?K2J0U3BPbXNFNXc1TmsxWnhQR0krWWpPeTlackxvYy8yT3JVRS9MU2xNNXAw?=
 =?utf-8?B?S2YxNm83Mndpd3dqR1VMdHpjMnBJMXdsbjBnMjd6eVRSODhvUmllZjRwZHQ4?=
 =?utf-8?B?anRJOGZLL1luVnNReDVZMmc0eG5EdTc0c1EvbFE3VW5FRUxoQ2RUb0R5eGVN?=
 =?utf-8?B?Zk91YWNQcU1rZmZjdWlxaDFkQ1BtN0w3OTZqOVpxamRCQUdTYUU4bzFQaTE2?=
 =?utf-8?B?clBEOXVweEZRTnlkaFVnNmdoN2tsYzAvb2pIMy9nRUFmOEZMU1VreWpTSldF?=
 =?utf-8?B?ZWJkNU0rQjY4c3hzV2xRb0padFFTMUNKQURYeVU4bHpXM2RQSXRydXBxU2Fy?=
 =?utf-8?B?ZUJsNE9SU0JaKzRITTJoYzczT3c0T0JtenFDaiswL3lmQ096SHMrdG9zTE1q?=
 =?utf-8?B?cTNodk1JMmNUUVNHT3k3azdMMHg2RzNreU9HK0I5eEJwcGdDS0JuK2JnL3A1?=
 =?utf-8?B?RzB3Y2ZTMTljUUlyQlVzdExWbWttOGRJSHM2TE5mMFBKbnBoc2svbUYycnB0?=
 =?utf-8?B?TlJReEt1ZXMrRXZNd0pTaU8vNTlVc3U0cytvTEtmQ3ZUb0dacUpwVVkycFFU?=
 =?utf-8?B?bnowZHRmUkVReUxDSGoybWlpdnljK1ZXbDgrMk9NbCtyQlgzREZjd3R6VUdx?=
 =?utf-8?B?T0FSTCtJaHBKVnhhS01CcHFUQ2k0SEtrQlNXZ3FTbDhjOWV0TjZpOCtZNGpx?=
 =?utf-8?B?akc1dVVXaXR0Rms3ckswVm0wbmpuZys3UVhTV0phd0F0czJCWW1MM2VReFAz?=
 =?utf-8?B?TzdzaHBXNXJDejVuZHpIdnZMZ2ZPU3RYUzR4SmhKTERFRkNRcGdOTjB5UTFE?=
 =?utf-8?B?OE5EUVVpRUFyMjQ0R2lvcytIeUpkSVNkVzIwb25UVGZyOWVnLzhUWnlXaEhY?=
 =?utf-8?B?NHRKamMwOHFnVGRLSkhOUnkvKzJrVVRaemVSVjA4ZUVRL0ZETW9YNnNrRnZR?=
 =?utf-8?B?WWdqT3kxTXJCY3Z1UTMzQ3B4bHJDRXg2b1hsYmE5bDNGVU1OM09FQlk3SUJk?=
 =?utf-8?B?Q3RoSDlSemROclg0MWVFRWJzWDN4WjlZaUZjQXE4OTRUb1E2NUN0dGZJYVdw?=
 =?utf-8?B?dzhYbHNjNzMzYWVnbFRzdjRLQ3RSM3cvVjVESGltMkpaZ2MvMjhuNHdhT3NM?=
 =?utf-8?B?MkJ4cTF5NXUxN1ZwNjRBMTR5UWJyMDlsekhyS3RGRStFblBrcFpJUmVydjZy?=
 =?utf-8?B?MHVTMU0yMHkvN3NlOVg1SXVqNW9OWVNMdys4Ykl4QnF2eUFkWlE0NWJtRThz?=
 =?utf-8?B?UlJxSnZabkk0ODBQTFQwOVprQ0xuRXF6Q2xKZzRuR0VsMjg0bTlKNGloZ29K?=
 =?utf-8?B?NStrUlFrRlhPKzFTY3Q4Y3kzRlRvMklwQzZtMlVPN0piZ2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME5GcitBTHdyY0JWSHdQeXNkdlNtQ2o3eWthVTUvRUdwNjR0Q2w4UEZMYzZI?=
 =?utf-8?B?Q2tFQnM5eklVL3dTS2tjeWwzUGVlV1JGMDQxTVl1Uk5hY3dMaU0vcTNpUk43?=
 =?utf-8?B?d3d3WHAyeUtZVjN6ZmtSOEw3M2ZxbUtlaWJvRHhuc1Z1ajFDNmljWUN0aGVL?=
 =?utf-8?B?dExZVTV4cmN0ZHVpT3dtWlMvRWw2RkxxdUFIZDRZRlVZTDJOVmV5TzNCYldO?=
 =?utf-8?B?Znd4ZUt2Z08wN05pSG5sV2JXV2g0blE0K2hBL2N6ZzBqT1BlRFZlMlAxMy94?=
 =?utf-8?B?R0N1SU9WNHNEbC9uRmpxcHoyMW9xYTJPM0NZanBHU0hLbUhzLzJZMC9KbWpC?=
 =?utf-8?B?Q29WdFFTeEo1NFFnd0xBZHgvOEtGRHRVYk9JNDc2bTZncEp0TjVTVzlyMnJw?=
 =?utf-8?B?Mys5dXRpTXR5NUlSeVJIQmhGUlNqVTA5a3ptRFBJZHIxTmhtWEhLK3hBYVZq?=
 =?utf-8?B?d3BGYUtHSFVYSytPYXhFZEJ0RW9UdVQ0dHRpSXVGQlBBZ2xWdXVDZnM3cFBY?=
 =?utf-8?B?eW9NZ05VNkVPZXF1UU94RE5mNjBnZXkzU05KUmNNYUxoQU5OTldlTWhneUZB?=
 =?utf-8?B?ankzaTFHSVNnSG1HaWg1V1lGTFlCcUx3anlMeFd5b3piaUdTa3JhZkcwYjJk?=
 =?utf-8?B?S3J6WTZjUzhwYVE2bjM4MjZOemVVZTFxdmVzTVVsVDkxQzJod2ZxcVhJUm94?=
 =?utf-8?B?RlpuYzhHYnVLWlpsZVZvVHo1L1k1Q25Ldm9yY284alRvZlBPZFVWUkl0N1Qr?=
 =?utf-8?B?cTJYU1F1cUkzbHVRSzkvZy9kUWpTS045YzJPOG0wTXVRV0x5SHN0aG9Dc1BY?=
 =?utf-8?B?ZzVMdmIrejlHZEZnekRId3pXSUlTMVFJVzFIMXkvQUI0aVpMMHpYWnhvdW81?=
 =?utf-8?B?M29IM0ZiMnFVYkNlRTJOVTZIQkttNTJHRGpNYnpGaFFVZzRxYURFSWo0cE9C?=
 =?utf-8?B?eUJNZFJKOTVPTVc3ZEQrSmRBdHI1WnhJaFQ4UDFMMHZEYXhIcFlqaXpreUVY?=
 =?utf-8?B?bS9DM2RGUlZTUWl0dmFXaGYxS1Bnc3ZZa0ZhRmszbGl4NXZhZlBLUTZEblBW?=
 =?utf-8?B?VGdsUjBBRDcxQ2x6MnZJM3BwdFR4YTBuRnMyaGZSOVdENlp1dnhBWWlPYm42?=
 =?utf-8?B?OERBQXh2bHlldURvOXB1bGkza3FTRXhWaEwzUGZmMGlpYmt5d0RpVUZpejdk?=
 =?utf-8?B?akgwYzRxMEVtQWN1ZSs4ODFOdHlCZjRKbXA0QzlRQW9Va1htRUpNZkliMXRK?=
 =?utf-8?B?aVRWWXM0SEpTQWphTm5aU0h4WCt1aTF1ZDFkcXJzd1FVREVVZUZiL0FBbG95?=
 =?utf-8?B?VU9VcTR3aHNBdHVsZjU3ZGhvWXFHbkRDdkk4TVVCMCtEVVFYNzRhWHhCVUl1?=
 =?utf-8?B?bkJCd1BEUkNTakZKdktIOVpPQ2tOVjVOUWprb2hiVGRFRVdwQWZHYTZtYjFF?=
 =?utf-8?B?RTdNMzdnVjE3VXRzU3E1S29zOHAvVWowQXdiVzV4L1EwS1BqRFZBTUlOMW5l?=
 =?utf-8?B?N1VDU3FOY25sbXAxdjMzRGtnT0NOakpZcmYxZnFrTjlObGdnaW9YMEFlNFV5?=
 =?utf-8?B?SGg3WXhHc3ZueTZrZ0xYZTZ6YVRBb1ZadFMyVVlNTU9IK0xuZzVYOFZRdVNU?=
 =?utf-8?B?Z3N4YW1oWWpRT1JJRjB6VGJpb005MWlva3hpd0JzUVZpa251L2ZKNmZrcndQ?=
 =?utf-8?B?aC9rNER4cGhqb052a3RMSXUzeUFPZWsxU2FCWTZDL094VDJBLzdyRWkrWGNs?=
 =?utf-8?B?WjNQTGlOekR0cWRlbUhNdnQ4eWV5RUxlVThoNXovUjUwakZld3VXZXF5eC9v?=
 =?utf-8?B?cDFBZ1FVZWcralpzMFJ1eWZlSVVBYmFCdnFLejVLWXo0bHZvTWxKNnVYSFhl?=
 =?utf-8?B?bkJ3aUU5S053VitaZzR1WnhaZGNCV1IzN2RXL2M0VytrU0doZ1FqVGVSSFdl?=
 =?utf-8?B?ZmQ0VGFNUlRmR2VFTXVTMy9Dd2lpbkNYZWxLRnpSZ2Z6Y3JmOE01TlJqT2ZX?=
 =?utf-8?B?QjAwUVBTZEJSZ3NONHBOZ3JzZ3k0aFZBS0FBT0dLOHpwRjVFQXhvN2RleExk?=
 =?utf-8?B?dk0vczlHV3NEZzRrdWExeDdyUVhKeXFkaUVBU0JaUzZpNlBpQ0tOK1FzMWMv?=
 =?utf-8?Q?YO3MNLLhg7NEltbBHBjcUz9JB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a5aa94-a69e-430a-aba4-08dd1a85a98c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 08:19:13.3463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WMhltCbbNnqYyyu0RsX/0eZ4DNx19BMLfCwBAks2dopeAKHmJdmIok76ylHs/FMyjCBBuppDGe6ZN6OoSsnK8wB0lEtRq/wkOKJqN4x4v10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAxMiwgMjAyNCAzOjQ1IFBN
DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gaW9tbXUvdnQtZDogRml4IGtlcm5lbCBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UgaW4NCj5jYWNoZV90YWdfZmx1c2hfcmFuZ2VfbnAoKQ0KPg0KPk9uIDIw
MjQvMTIvMTIgMTU6MjQsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gV2hlbiBzZXR1cCBtYXBw
aW5nIG9uIGFuIHBhZ2luZyBkb21haW4gYmVmb3JlIHRoZSBkb21haW4gaXMgYXR0YWNoZWQgdG8N
Cj5hbnkNCj4+IGRldmljZSwgYSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgdHJpZ2dlcnMgYXMg
YmVsb3c6DQo+Pg0KPj4gICBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFk
ZHJlc3M6IDAwMDAwMDAwMDAwMDAyMDANCj4+ICAgI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNz
IGluIGtlcm5lbCBtb2RlDQo+PiAgICNQRjogZXJyb3JfY29kZSgweDAwMDApIC0gbm90LXByZXNl
bnQgcGFnZQ0KPj4gICBSSVA6IDAwMTA6Y2FjaGVfdGFnX2ZsdXNoX3JhbmdlX25wKzB4MTE0LzB4
MWYwDQo+PiAgIC4uLg0KPj4gICBDYWxsIFRyYWNlOg0KPj4gICAgPFRBU0s+DQo+PiAgICA/IF9f
ZGllKzB4MjAvMHg3MA0KPj4gICAgPyBwYWdlX2ZhdWx0X29vcHMrMHg4MC8weDE1MA0KPj4gICAg
PyBkb191c2VyX2FkZHJfZmF1bHQrMHg1Zi8weDY3MA0KPj4gICAgPyBwZm5fdG9fZG1hX3B0ZSsw
eGNhLzB4MjgwDQo+PiAgICA/IGV4Y19wYWdlX2ZhdWx0KzB4NzgvMHgxNzANCj4+ICAgID8gYXNt
X2V4Y19wYWdlX2ZhdWx0KzB4MjIvMHgzMA0KPj4gICAgPyBjYWNoZV90YWdfZmx1c2hfcmFuZ2Vf
bnArMHgxMTQvMHgxZjANCj4+ICAgIGludGVsX2lvbW11X2lvdGxiX3N5bmNfbWFwKzB4MTYvMHgy
MA0KPj4gICAgaW9tbXVfbWFwKzB4NTkvMHhkMA0KPj4gICAgYmF0Y2hfdG9fZG9tYWluKzB4MTU0
LzB4MWUwDQo+PiAgICBpb3B0X2FyZWFfZmlsbF9kb21haW5zKzB4MTA2LzB4MzAwDQo+PiAgICBp
b3B0X21hcF9wYWdlcysweDFiYy8weDI5MA0KPj4gICAgaW9wdF9tYXBfdXNlcl9wYWdlcysweGU4
LzB4MWUwDQo+PiAgICA/IHhhc19sb2FkKzB4OS8weGIwDQo+PiAgICBpb21tdWZkX2lvYXNfbWFw
KzB4YzkvMHgxYzANCj4+ICAgIGlvbW11ZmRfZm9wc19pb2N0bCsweGZmLzB4MWIwDQo+PiAgICBf
X3g2NF9zeXNfaW9jdGwrMHg4Ny8weGMwDQo+PiAgICBkb19zeXNjYWxsXzY0KzB4NTAvMHgxMTAN
Cj4+ICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc2LzB4N2UNCj4+DQo+PiBx
aV9iYXRjaCBzdHJ1Y3R1cmUgaXMgYWxsb2NhdGVkIHdoZW4gZG9tYWluIGlzIGF0dGFjaGVkIHRv
IGEgZGV2aWNlIGZvciB0aGUNCj4+IGZpcnN0IHRpbWUsIHdoZW4gYSBtYXBwaW5nIGlzIHNldHVw
IGJlZm9yZSB0aGF0LCBxaV9iYXRjaCBpcyByZWZlcmVuY2VkIHRvDQo+PiBkbyBiYXRjaGVkIGZs
dXNoIGFuZCB0cmlnZ2VyIGFib3ZlIGlzc3VlLg0KPj4NCj4+IEZpeCBpdCBieSBjaGVja2luZyBx
aV9iYXRjaCBwb2ludGVyIGFuZCBieXBhc3MgYmF0Y2hlZCBmbHVzaGluZyBpZiBubw0KPj4gZGV2
aWNlIGlzIGF0dGFjaGVkLg0KPj4NCj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+PiBG
aXhlczogNzA1YzFjZGYxZTczICgiaW9tbXUvdnQtZDogSW50cm9kdWNlIGJhdGNoZWQgY2FjaGUg
aW52YWxpZGF0aW9uIikNCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhv
bmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9pb21tdS9pbnRlbC9jYWNo
ZS5jIHwgMiArLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9jYWNoZS5jIGIv
ZHJpdmVycy9pb21tdS9pbnRlbC9jYWNoZS5jDQo+PiBpbmRleCBlNWI4OWY3MjhhZDMuLmJiOWRh
ZTlhN2ZiYSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvY2FjaGUuYw0KPj4g
KysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9jYWNoZS5jDQo+PiBAQCAtMjY0LDcgKzI2NCw3IEBA
IHN0YXRpYyB1bnNpZ25lZCBsb25nDQo+Y2FsY3VsYXRlX3BzaV9hbGlnbmVkX2FkZHJlc3ModW5z
aWduZWQgbG9uZyBzdGFydCwNCj4+DQo+PiAgIHN0YXRpYyB2b2lkIHFpX2JhdGNoX2ZsdXNoX2Rl
c2NzKHN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUsIHN0cnVjdCBxaV9iYXRjaA0KPipiYXRjaCkN
Cj4+ICAgew0KPj4gLQlpZiAoIWlvbW11IHx8ICFiYXRjaC0+aW5kZXgpDQo+PiArCWlmICghaW9t
bXUgfHwgIWJhdGNoIHx8ICFiYXRjaC0+aW5kZXgpDQo+DQo+dGhpcyBpcyB0aGUgc2FtZSBpc3N1
ZSBpbiB0aGUgYmVsb3cgbGluay4gOikgQW5kIHdlIHNob3VsZCBmaXggaXQgYnkNCj5hbGxvY2F0
aW5nIHRoZSBxaV9iYXRjaCBmb3IgcGFyZW50IGRvbWFpbnMuIFRoZSBuZXN0ZWQgcGFyZW50IGRv
bWFpbnMgaXMNCj5ub3QgZ29pbmcgdG8gYmUgYXR0YWNoZWQgdG8gZGV2aWNlIGF0IGFsbC4gSXQg
YWN0cyBtb3JlIGFzIGEgYmFja2dyb3VuZA0KPmRvbWFpbiwgc28gdGhpcyBmaXggd2lsbCBtaXNz
IHRoZSBmdXR1cmUgY2FjaGUgZmx1c2hlcy4gSXQgd291bGQgaGF2ZQ0KPmJpZ2dlciBwcm9ibGVt
cy4gOikNCj4NCj5odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS8yMDI0MTIxMDEz
MDMyMi4xNzE3NS0xLQ0KPnlpLmwubGl1QGludGVsLmNvbS8NCg0KQWgsIGp1c3Qgc2VlIHRoaXPw
n5iKDQpUaGlzIHBhdGNoIHRyaWVzIHRvIGZpeCBhbiBpc3N1ZSB0aGF0IG1hcHBpbmcgc2V0dXAg
b24gYSBwYWdpbmcgZG9tYWluIGJlZm9yZQ0KaXQncyBhdHRhY2hlZCB0byBhIGRldmljZSwgeW91
ciBwYXRjaCBmaXhlZCBhbiBpc3N1ZSB0aGF0IG5lc3RlZCBwYXJlbnQNCmRvbWFpbidzIHFpX2Jh
dGNoIGlzIG5vdCBhbGxvY2F0ZWQgZXZlbiBpZiBuZXN0ZWQgZG9tYWluIGlzIGF0dGFjaGVkIHRv
DQphIGRldmljZS4gSSB0aGluayB0aGV5IGFyZSBkaWZmZXJlbnQgaXNzdWVzPw0KDQpUaGFua3MN
ClpoZW56aG9uZw0K

