Return-Path: <stable+bounces-89690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 598289BB33C
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187382821BC
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEBE1C32E2;
	Mon,  4 Nov 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFNsvBHt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3A11AC458
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719231; cv=fail; b=eL0lEsNx9uZTorReWxcMo0kJX1Cp3WOYHGz452VTywXHjT9IqCBZqBPiW6ikFhMZSpJHQi1P5sR6KDNMjzUpeZsJa309levhxc8ISKmxhfzhI09LNsTUbAZPsg5x+COiF49bATKSDgXKQtLDpLiPYrwF4l/EItk6xwC77O3F3Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719231; c=relaxed/simple;
	bh=W0Vk23B7rR58fmt4FkAL6rsN1UbVg2icIkoXoHb3vwY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qni3dsaJ9APInGTOIiNh29GDOlrmD/juOyZazyOPTKE6Q83cX7a4y+h/44L+4m/xxSlrybs6SgFxV7H3nh3oI4d/DVnWWFIfFvt/PxBnjcY36f7MDfvHDoKew975wi1HLQweGNgi5CMnlgmby7BgqpBN3eY4joDfMIQNaH1JQ5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFNsvBHt; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730719229; x=1762255229;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W0Vk23B7rR58fmt4FkAL6rsN1UbVg2icIkoXoHb3vwY=;
  b=lFNsvBHtuOoIvlqFLcjWTYRfL4zfmvN9WMaf4Tzsv7YzXDiCwTuo+Yal
   VdukAAMJXBBbm697U1Vk6DKhPmt/G6iArXZ4bSfFq0r65NHb1Z+55yuMR
   HLIotSpZeCEuzy1Wb1iIIPilEZC2YOJFeil2VIVSj7J4DDbb9MHsHD8ne
   kPZK0m083CwNtLzi5U2TuHAEHhpxZIB6DGZOrxKUp5m7xl8VDdVmu9LuM
   1y75dhNjuFA8Ke/LiVkxP5h4ziqv90BQrEki0Lxtew6+Yj1QqUQ31v7YJ
   AozWPI2FANdvsrIdySnNEsr1ucOnXpTSHPCZ15T829C8alIwD/d+sW0GP
   w==;
X-CSE-ConnectionGUID: zaV6+OahROWjJTWG8mShbw==
X-CSE-MsgGUID: osuI/h3VQu21T1jKVNtbsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="41782080"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="41782080"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 03:20:29 -0800
X-CSE-ConnectionGUID: 1/yf0FOeRR6VtzrMuDy77Q==
X-CSE-MsgGUID: 88hvamzkTeOFk6mTCjRChQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="106967609"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 03:20:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 03:20:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 03:20:28 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 03:20:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLLgV30ZwsXu2+lozrUuYIhfi9Gi4j9jGEV8ZtzvGPbQoilRZMXhp8gaiemv/h7RWFJ3UnELvoxmkF/ErawOJXK8EyHwvoYYa9oR8Punmjn7zgI69fsXsdZssrtv8RRH7hEjWP1G8hHdkeGJC1fg5/NnFs2pOSEVj27wLnPyN288ZgAOniPSiB7F9b3yfzFh3tNo/UBrwsK9FLAWHchKGzn7h1jRIi5iPvo1w52vueXWDV6oZSaRU/vhv0Wvm7b9lzk7tOqsqe7yE0T2HJz+p63WOnKiz91/oNxPP5MGk5zV6x2VpyW/ew7dcXl667h4zW5FT9NJa1Nry5KLafQCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0Vk23B7rR58fmt4FkAL6rsN1UbVg2icIkoXoHb3vwY=;
 b=ldZpRroT+l6IYDc5Jj1Q8LZfmfJ4aT1kTOpJNzUhcGqtDRpno5mHyqLZqE+M8D3xP9g/NEDBHUv8ch0U93ZiO5KGJS7b8y7O54qu4kbj5m0AjT7pRXJ4t9LR3hEqPa4AORgSF/eaxnCt7AhHy6fTQeO/aHaqFI6EpGUE5ldsBkBJYpraPJjgtoISq6DbHkTsC0R0ItEh2vdsSPFWAFwshPuaNA4e6vB0VcxH/NDUbr6QKvIEgFyRNSvefs/bhzc9mob8KafR1VlJ1zh0DeaaeNnFNnqDAR3N1ldpc9DWr69l8XLeg7zaLXqPinw3n/WqgcRnSLiPtp1UxvB1VWagPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) by
 SJ0PR11MB5023.namprd11.prod.outlook.com (2603:10b6:a03:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 11:20:25 +0000
Received: from DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347]) by DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 11:20:25 +0000
Message-ID: <7f0dcef8-09c8-4ae7-8593-eb2afd9465b5@intel.com>
Date: Mon, 4 Nov 2024 12:20:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/xe/guc/tlb: Flush g2h worker in case of tlb
 timeout
To: John Harrison <john.c.harrison@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Badal Nilawar <badal.nilawar@intel.com>, Matthew Brost
	<matthew.brost@intel.com>, Matthew Auld <matthew.auld@intel.com>, "Himal
 Prasad Ghimiray" <himal.prasad.ghimiray@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, <stable@vger.kernel.org>
References: <20241029120117.449694-1-nirmoy.das@intel.com>
 <20241029120117.449694-3-nirmoy.das@intel.com>
 <32481d09-617b-4396-9577-010ddb657654@intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@intel.com>
In-Reply-To: <32481d09-617b-4396-9577-010ddb657654@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6541:EE_|SJ0PR11MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c555d22-5da0-4e3d-e686-08dcfcc2addb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWk5Y0hsdnMzdnVSaDlXOFVXUzR6Sy9MMXM2b2RRejQzMFd3Q3R1WCtVUmp0?=
 =?utf-8?B?alk2NE1GOHdDZkxZSUpib1U4ZmVSRGFkOWtiZ2ZCbXFyaFpiQW1Oekg0UGI1?=
 =?utf-8?B?a3dHWmgxOVlzSnQ1Wm1FeDdFOUJ3ckNqMUtqckpLTFgrQmc2VmppQVozazBD?=
 =?utf-8?B?Wk5BYWxua254Ny81N1FIZWNNU1lleGdnTUcxMVJyZUozckJ6b3haQlc2YkVz?=
 =?utf-8?B?blVybExRb1lHNnVKdkFvVnlDMm8xSjZoYTgwSmRzMWVlcjBwWldVSzZOcXIz?=
 =?utf-8?B?dklhT051dVBDK25CZFdKcWdCdzY5TDZmSExpSFhnVitYb3BCWjdhbDVDbVd1?=
 =?utf-8?B?WTUycFJHWUVFUVd3WWFSSjdLUCsxT3lrMVJtNG9xcjdxdjd1YzRvaTNRZkQ0?=
 =?utf-8?B?VUZBaFZkV081S3Y1OWlYcXVxYzRlREdDc2ZnL0FLaFFUQTA5YVd4RkVEc1Zw?=
 =?utf-8?B?dXBHKzBSa1BJczNvelhETzlmM2lLOXJDemkyWTc0N1BVUDB3ZysxN2hxTnow?=
 =?utf-8?B?WWhpcDFPeDhwSWthWU83TXpuOFBJb1Q1U25lNThZWkxDTkpFc1Q3L1BxbktJ?=
 =?utf-8?B?R2g2bmM3TnpiM0VGbmlFS3VWaW5ESGNVcGNiejNCNnYvRWFuUEx5bnlGRkpV?=
 =?utf-8?B?NUJaK2FwWUoyUzZ3T0FKb3QyUnZUNEIybDlKR1pnbFd1MkdRVEcrZ2l0KzVj?=
 =?utf-8?B?VEVvS3dPWm1HK0Q4TEhqdytTbllXRy9pUUh2NXVYbHgvV0pYdXJwaDhRcEtx?=
 =?utf-8?B?ZW9oZ2R5ZlJFRTBrWVhkbVBpSml5YWx3MjQvczVybzhUV21XRUFRQVV0Nkhl?=
 =?utf-8?B?ZnUyZlJwQzBSSHp5d2hjQUExTThXQVZveHFDcGtsQ3FoeW1xY2JYWVV1a3lY?=
 =?utf-8?B?L05QV1AwRUhZaUVFRFJRU1lNajhZY0JXd1ZIakdXOFR5Y3dhb0wzc3JPUHB6?=
 =?utf-8?B?S1pQWmxLdXZMUHJGV1hiakNVc0ZIYng2eE1ucnc3cjFBUzEzOTJaR29rZUdl?=
 =?utf-8?B?QUtFYW1FQmtqSHowa29KRHYvUEpMaGYxZXYveklUTG1oaC92RHRlOGw0ckZj?=
 =?utf-8?B?TVl1cTdueGxnMjV6ZDlRMks2U0dJK3g4cE5td0h0UGVKT0grK0ppOU5jSWo5?=
 =?utf-8?B?SFRmZzFpaCtsYmd0YllJRXl1OVJ1WklzbTcyUkc3QlNQQXhLYUtIMlJIY05m?=
 =?utf-8?B?UkdCVlJGT0hqQ3FtRjRTN2xWcWZmc20weEcyRWhpSXkzZGJ4MThQV0dEbTEx?=
 =?utf-8?B?dmtTVS9oazdYV1NncDJZSlVBRXgyM2FYZW1FdlczaGpVQ2VQYU9ER0EzdFpi?=
 =?utf-8?B?enVybXBBbWhZaTVPaDFtQ0FkMm9mV1g2SDNRTkhwTE1GUUhrOVlqN3UxVVZr?=
 =?utf-8?B?NnhxZUZVY3FSb1lIbktJajZUT0tkUG1sa01hS2lZb29IeGtCMjdUa29HVGph?=
 =?utf-8?B?bC9JaE9qRGFyT0lCWnNoRmdLQVlrcmN5Sk5ZYXJkRis5RXcxZCtjVmhsYXlr?=
 =?utf-8?B?c2phT01wazMyZGlaYVEyNXFUWTdUUlRubldPRHNOb3AzcWpNbGlsWXAvVUR1?=
 =?utf-8?B?UDhXeWhaN0dMeEY4WjFpTXh5cDJPRXlGdlRFV1V6VDJFVklrQUtZMnN3NU8z?=
 =?utf-8?B?ZUNHc2NLaE5XM2Zkb3pWUStobEtMcG9VVFp2MWlSTkw3cGoxTksvZEJZT2Zj?=
 =?utf-8?Q?qcAGnosjZxTHQJiXkIyB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6541.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3FTbUoyMXc3SEdoYm1ZSDRmbU9pd2IvTzZpK3R4UjJvbTd6K05IRkwwa0ZN?=
 =?utf-8?B?RW1pM1dFQkJlMTc0NXhKU2NTSTkwaTJheUZTOCtaa3g2YWRuZ0tqRGtjY2VD?=
 =?utf-8?B?M3o4MlpjRUdaMmYyZTdTMEo4aUhIL0d1UVVLR0REbDByM1lsNGd4SkpuZnRu?=
 =?utf-8?B?NXdLYXBaTEVCOUlKVDJtK2dNWHVHUzY2V2hVQjc0dnpXSkc3YkYyVVJzSTYr?=
 =?utf-8?B?OWdnZEJkUERYc1FRSFRQRTZOL01jbmJRQ2g1d1d2QTgxUnBOOU1lTzVIM0p3?=
 =?utf-8?B?R0x1bVNVNDRSQVkwMTVtRzQ1TmdMakxNTkczZVU0bFcwZGhMelFaK1YvUDFS?=
 =?utf-8?B?dGJoNGZPenJQS2lkS3g4bENNZjFiay9Gb1YvTlg1OFZScGk0NHRNS0pua1cx?=
 =?utf-8?B?NHE2VFQ1cTFhbXhWa2oyOFQ0M3h1bHVvYlc2WDVVRmJ5cVREQ2RaTHMxN2N2?=
 =?utf-8?B?K1RFK29JQ3pESnRuaFM3d1c0YW9iODh3ODRYMGFkUnpaK1lsWjVYYnQyV1Ja?=
 =?utf-8?B?KzVOMHppOVNTRjY1Q0xsa2Y3MXQ2UUIyUmRPeFh4NnV4d3V1SmM4R2tlTlRH?=
 =?utf-8?B?SDNtb3JtS21mSy9Zd0d1YjdxMjhvUUpoeWZRd0JHNmNUTTZmUUl3eFBkU29F?=
 =?utf-8?B?Y2NQd1o3TmxrTzFvOG4xNGZTWGVXbW5TbVV3dDU4d2toZlV4TDhRbkZiSzhs?=
 =?utf-8?B?aGRDald4cDVKM1dUVk5raW5PYUVOZVJDMU54clV5WEV3dmpuRG40ZElCalhl?=
 =?utf-8?B?YmhrZWJxMHZNaitOc3BkQjVrVmtjbUl2N01tYkR6SjJ0RDJNQWdNTE9vbThj?=
 =?utf-8?B?aElvZGk3NkhjSzFLMDdSQnJhclBwMVJYZ0xtaFI0Q0FaZnlwVGtRajV6WlF4?=
 =?utf-8?B?bTVUc2dLZ0NibENFY05tK2VGRjVmTFVvdDNIWWovNkQ5cmphVXFCSjI5azFv?=
 =?utf-8?B?cmhxVi9tMHNqZGN2cmdYQ3RUeFUyY3pwVHJhNFhQK01BdWpiOHBPQVBtUUlK?=
 =?utf-8?B?RVFaWmxsWmMvaDI1RXlPeUxBQWNRZnFob2p0U3ZFV0tRdnNCTEo0c3ZWdXl0?=
 =?utf-8?B?UUNsS09ZRjdvNEI5RDhyYVdZaDE5SmJDYTd5WDVrZXdGcWhDbDhhQkQzR0hC?=
 =?utf-8?B?ekhkTER4SnEvS0hpQ2NzTXRIblhvR2gybDhQbVVacE5QcVpNL2xDZjBMYWVj?=
 =?utf-8?B?SUF0Y2JVOEJxYVlIOE9RUnVlS1hXQ1p0b25mQS9pQnN5VmdyMmltMDkwUy9R?=
 =?utf-8?B?a2k1aXlMaC85OFpIeU5lOG4renFobFVIbXZnaVJaK1FLMURmNmFwL0JPb2xB?=
 =?utf-8?B?UWdQNDBCTWVlU0JIWEZxdUdvOVB1K3pxcHlwT1l4blkxY0NpcmRpOVAyYjNX?=
 =?utf-8?B?UU10TVFxNXoraWwzalJwbG9XbE5XZXNvWFVBT2JtVEdVd2t6bGtyWU1uWDgx?=
 =?utf-8?B?b0JnQVpDODluK0tVR1dNcjVNdkZRRENtYnhKS0FNL2R3Z0FmeGpSRGRUd0Vh?=
 =?utf-8?B?T2t3Y0gwNEZWNE01YW9PYnVFczRGcXduVW5qTWdXd2FxM1NRalNSUWNVL0dQ?=
 =?utf-8?B?cVg3dW5lM2V0bVNWaEc2QlptTlEvOGJhaURkUXh6Rkh0ajBjem9mWlNkRDZS?=
 =?utf-8?B?aVlYelFxREFYdXplMlhUMlpFQm9lNDlYYjdYRHh3OEVWek5JWEZlZU44b2ND?=
 =?utf-8?B?WU9vK0IvWVRrZVdpZlpXcmFDeW9PZDVuOVlnRkwrTDgyL1Jhb0hNZmx5R2tP?=
 =?utf-8?B?Uk9leWo5Z0lMTm1oNzdHYzhUU1JSb21oUnJQdnF3VW1xVm1iU0w1MFE3ZmRj?=
 =?utf-8?B?K3haQkp6NnU3VzhxRmgwb283OFVDN1hGeGJTMVUxeWVIWTFlSE9MK3ZGcThH?=
 =?utf-8?B?ZkJTYldtRjEzbVdhV1FhZnB5cjhKWFFVV1dZYWczOTIrbFM0eEE1Yjc5Qmdy?=
 =?utf-8?B?N0tJQVYrS3lDRjVjNmJwaFluZ05NZ2crSWNtT2YxWHJ5aGFSU2doTEp5cDV1?=
 =?utf-8?B?a3dBaUR0NFRtanAxNFh2MDhYOFpQV2ZDY0h4YmxLOWdEZlhSMy80bkNGd0JY?=
 =?utf-8?B?cGdQRE9hd1hPUzRqbS8xK2ZYaTdHQnd4c3NiZ2w2WjNhQXV2VjNqam9JUXRw?=
 =?utf-8?Q?aWzwv9QnTGt1R2DB0TdvCNuZ/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c555d22-5da0-4e3d-e686-08dcfcc2addb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6541.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 11:20:25.1961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+NvFPFbHrANxFLoNTYASzwBbIdEUpMy8J3oZCSV0EUQWsiC18NFQGZNL8AurJfLNoqmAWhtxLC7mMk5WRK5Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5023
X-OriginatorOrg: intel.com


On 11/1/2024 7:51 PM, John Harrison wrote:
> On 10/29/2024 05:01, Nirmoy Das wrote:
>> Flush the g2h worker explicitly if TLB timeout happens which is
>> observed on LNL and that points to the recent scheduling issue with
>> E-cores on LNL.
>>
>> This is similar to the recent fix:
>> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
>> response timeout") and should be removed once there is E core
>> scheduling fix.
>>
>> v2: Add platform check(Himal)
>> v3: Remove gfx platform check as the issue related to cpu
>>      platform(John)
>>      Use the common WA macro(John) and print when the flush
>>      resolves timeout(Matt B)
>> v4: Remove the resolves log and do the flush before taking
>>      pending_lock(Matt A)
>>
>> Cc: Badal Nilawar <badal.nilawar@intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: John Harrison <John.C.Harrison@Intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.11+
>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2687
>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
>> index 773de1f08db9..3cb228c773cd 100644
>> --- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
>> +++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
>> @@ -72,6 +72,8 @@ static void xe_gt_tlb_fence_timeout(struct work_struct *work)
>>       struct xe_device *xe = gt_to_xe(gt);
>>       struct xe_gt_tlb_invalidation_fence *fence, *next;
>>   +    LNL_FLUSH_WORK(&gt->uc.guc.ct.g2h_worker);
>> +
> Do we not want some kind of 'success required flush' message here as per the other instances?


This flush resolves TLB timeout but in this function, I can't think of a simple way to detect that and log a message.


Regards,

Nirmoy

> John.
>
>>       spin_lock_irq(&gt->tlb_invalidation.pending_lock);
>>       list_for_each_entry_safe(fence, next,
>>                    &gt->tlb_invalidation.pending_fences, link) {
>

