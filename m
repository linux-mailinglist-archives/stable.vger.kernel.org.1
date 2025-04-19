Return-Path: <stable+bounces-134719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AF3A94432
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 17:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED9A1898ACD
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0BB3595C;
	Sat, 19 Apr 2025 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IK62cRy8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488742049
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745076674; cv=fail; b=AtO+NQ9AQJVkIden7a/zEBsl7gQ2xHH6mqAmznEk4p3cmxA/GxJvg+4dpUbqcHUaVWh1U4CI8j/nPOGEmQDB+J6AJqfG7CN3uk01LlQGsB7UGH1uGXjWCYMud2H8S3nc0+d1FXicQuc/vtUJjUrU7eDGDwdV+wM5Uq8nfMevpUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745076674; c=relaxed/simple;
	bh=w34ZfOVlSNV/7UbLgNPLS3oPBDftw0FZGSUg69CI7SI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gG3O+8pHShREI4mRZW4ZCZOPI6UZwzSlO6q/0Hf6eynPj2FHu1+lCIIsPVNOa2HzMEqK4Fx9tweqnK/MzEcffDJNcA3hnO4jw551I+ttP7tmxOqs4A0m1ppW3mfiMe2ZY3EpAEZziN1UD1NldeB7womwFtpTi+4ybuedqXXUOWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IK62cRy8; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745076672; x=1776612672;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w34ZfOVlSNV/7UbLgNPLS3oPBDftw0FZGSUg69CI7SI=;
  b=IK62cRy8BjGWWUJBxW3NNVTvaHiLtq3+x8pTqPPrbuAGeCG5Y1OvSXuB
   CquBxEAY8+CCQwBVomdcMizTmsHtj5AgNPpyFiAKsU8SFFOmOy4PydsAc
   Uf3IMuuo3ERlnticAAW8xcn/+mrhc3x43D58uPrJfFJndMG+gP4tKFijA
   Ys6jFun9e84Xls3Z0PyItRZIAKYHEBW69i6kAm/cH3R95kTAeTS4n23L4
   WVrOepBWFpqHH8ipRjyxdSWE9Iv2S98dmXK4xX6nANTPWsW8QMEY6xctC
   QgwLq4qHvwtXh2aumKEBgnRX4zGyDKpbStAvxWbo72k8Z6UOFgEioekLs
   g==;
X-CSE-ConnectionGUID: as2kcdbiSeW5qfxF1ssMNg==
X-CSE-MsgGUID: Ii2ncO0iTlOrEoSuXDL6aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="69172216"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="69172216"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 08:31:12 -0700
X-CSE-ConnectionGUID: vEsMpllcQjqgfS9Fbx07BQ==
X-CSE-MsgGUID: VZJCoVnWT365TqzG+RIzxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="131320940"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 08:31:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 19 Apr 2025 08:31:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 19 Apr 2025 08:31:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 19 Apr 2025 08:31:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXsNClm7hGRrtNKLFQh422ma14AExyg3ILzH6QgrNmJk1sg4P0Jlr/YfpmBD3oU7u24xvPPHCQxD2Ba9ldcN6m7qba3P8Ei5QiJ3YivVPBrAnF/3H0vyijeoReqll8Uy1KNKrs5cTSEO29jvzxkgPZrk2f7fQqx5e387Q0wqmwrO3wiuObgMuFMI2u9Eraf71/AdUzifO0QRnS0D+bCQKOwhZ4gMAJQey6Hqjc1bvZvh0IXkFqohizGXXVKAXOk82Flv7Y64do3KZylP7EzkPK8EuoZ4jLQqZdrR15MnoC6192l7nwXSBq3i4mhULPUjq0U1Zst5ejkHT6BGpGo0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEaoIVb8hCx3DZrx2g3YezGWFBkDORniFkvQwwBUX9s=;
 b=S1gpnurcq0wSN2au2VVH8qi7Fb7TM/tmZmTSZToxy/KZZl5ikTWWhK2inSTYaPsfP/y0BvWf0WhbbAg24e+6W8GkcQH6GhGLd6qoJQ6MNedjkD2f3Z59zkVVkI4NsjQEgSP73OXNTE0pjA4+RIJOGLU3p+kCLiORmrZ6yEOPWjYzkW9pprHS3vdOPMpuj8tkDm5ldahHKt91wSKx7tPfiulSSXv56ovtorkw1jubP1DNF184+0hOF4oQInibzjZYgjcFClXP7F4iMOgzUFj8szqie5w08rC1cJ7p6qGUkY46bALuhw2xjaK3kW5ctMGMTZSl3LUKo4Av5MHtNWj7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.30; Sat, 19 Apr
 2025 15:31:08 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%7]) with mapi id 15.20.8655.025; Sat, 19 Apr 2025
 15:31:07 +0000
Message-ID: <eb74abac-074e-498b-a00e-0eb878b74251@intel.com>
Date: Sat, 19 Apr 2025 17:31:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14.y and others] cpufreq: Reference count policy in
 cpufreq_update_limits()
To: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
	<marmarek@invisiblethingslab.com>, <stable@vger.kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>
References: <2025041714-stoke-unripe-5956@gregkh>
 <20250418021517.1960418-1-marmarek@invisiblethingslab.com>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20250418021517.1960418-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::15) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|BN9PR11MB5276:EE_
X-MS-Office365-Filtering-Correlation-Id: db0da0f2-211b-408b-1963-08dd7f57347c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGJRM1RKNjdyK3EzUGtCMzRnNytSOWJnZkJmNDFIWFEwNDhOOXNSc25JbTRM?=
 =?utf-8?B?MzdkTTRRQm4vRWdDVGo5ZStMU25WMGxSK3Z1cTNWdDNhZFR5MlFxTGs1YjhZ?=
 =?utf-8?B?T2M5S2pmNUZTcmZ4Q1krc0NPSWdwSFlKTVpabThCSzZRT3p1Rm9UMXdPZnN4?=
 =?utf-8?B?YXQzNGl1cXE0c2N0NlZUS21WMFBDaUl1eTZIR0ppd09VcVpPUXYrZVMyVnhy?=
 =?utf-8?B?Z3J5b1pRbit2cXd6aEtXbHFVa1MzZ2hTWk1GdVdSQ3BHUU0yS2hjQmRIVHll?=
 =?utf-8?B?a1NqVGcrWnFmYWNNdHBDWFYybkJRanJmdzU5SHB4aVB5RHNWZDc1SmpubE5h?=
 =?utf-8?B?WEwrNzAvdFFGYnNGR21DNzAxcGx1REg0d0s4WmI0ejcwLzlQN0ZqRytnNUJz?=
 =?utf-8?B?cktGRTdpZzExZmdTUzNzcGNjQW9xME1rRWpxb255c09wOEtlbXQyeXhRN3Fq?=
 =?utf-8?B?a2UwWlRnVDdsRjlKOTBJN3FKSFF1ZW5HQ0NOYVhKVStFMlowMkUrNGJyMllB?=
 =?utf-8?B?ejFjWlVwR05selBLM0lic2I1OFBkZUh6OUd4YTJGeVFaUngzMWtRaGVHVExW?=
 =?utf-8?B?VU9oTmNSMXNzK2prOGZlWHpvaEJCWHpTM08ra3QySHVNajd3RVZTSXJzOGRE?=
 =?utf-8?B?b21kQ2dnVmJXYmYzaCtVeW1QU0ZQTXdzc2ZuRzkyVkJjalJBWTFUaDJ2clNN?=
 =?utf-8?B?UzBpYlU1UkM3SUhId1I1djZVUE9CTkFqRy8wRnFYcEFYUUpQOEZNZjRvdFN3?=
 =?utf-8?B?eU9iUC9vd1hiUkZQQ1BoY3JidGwvaXFlN0xoV0xmQVY2bEVCNWJDaEhienIz?=
 =?utf-8?B?Nk02WUQwQno2Z2pLQ2wrcHhodjJ2QWJtZTlDaXhYc1FVTVdORzJMMjFsS0Nh?=
 =?utf-8?B?WkV2cjBoaGtwdlg4cEovM0U0ZXg4MzA0UjJxTHg1bnBoc1BDUUZVWHAyL1hW?=
 =?utf-8?B?YkdYWVZOTFQzSnA3SzhPUjVLOWI0UEpFcERzblkwT2tLc09KcE9FSkJxTlRx?=
 =?utf-8?B?S0ZIdWZ6UHU5WnhweHV2b0dIR25nYUF3SzY2OUtseWJ0QTR6blFqdTE1YkM4?=
 =?utf-8?B?YnV6aFBHTDNDdmxUWFZweXN3eTh1SGJ6ZW54cXVORitJam9RS25wTE1Wc2x5?=
 =?utf-8?B?eW1ialBBbFJzazNWWkdUTmR4ZURTV0FRZEk0cS9tUmw4NTRBSm5hSFFqWVRt?=
 =?utf-8?B?blZPd0d3MWZnSy9iZElwdGF5TXVxK05NVGgyTUpYb3E2dURQdnYxUXM5K1ZN?=
 =?utf-8?B?N1lwdG1kWkF6NnJOeWpZYXJKV1R5SHZZSk5pUVd1Ym9qVXJabGtQMkYzbmw4?=
 =?utf-8?B?ZFE0M2lLR240Y3RqZ1pmdFBPeGZnRitZRFN4QUhOUlk5S1F4TkdGUkZEdlA2?=
 =?utf-8?B?ekdQOE1DOG9FSDNDb3VGWlZIMVB4WkF5SE96WDVsVlNCUExzT0xxKzV3cmEr?=
 =?utf-8?B?aXpwOGdsK1pkRVBDaW5tS0pVcGU3Z2pmdnN2dUF0WTh1ZjUxbFlsTStlNGcx?=
 =?utf-8?B?c0dzMWJ5WVhUYnlVeUR2ek1lSUxsdzRKWUtLbzFiUDFNUGdheVRFUEwzZVVC?=
 =?utf-8?B?eTNkL3dpZVY4aE9mYkFnaDRXVTJ5eEdVYkdId2pybFl2amoyeXdlNGtpb2dI?=
 =?utf-8?B?OUNIT0RLSC9NNFVOcGx5WG0xWUdBdEcweEVNMW43Q1hZMGJSREEweUU2NGRC?=
 =?utf-8?B?aGlXOFVZWkpZdzNlSlRIaVJaR3lIRmdsT3Y5QStIMzJFc1M5RGlWZmRBMmxw?=
 =?utf-8?B?YnZDS2xFMUQ1OEx1U1Z5OVd5UjdMSHJFM01MQUNXWVlXaGxwOUF4Zm5aVjdG?=
 =?utf-8?B?T3k4SmhjdWZSVGd3TXBkZTBXS25aNG90VkVmQWFwUmpXdXJXek13SlJIOWI1?=
 =?utf-8?Q?zpx4W9hPJC0r0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0hndjk1eU5hWGxaV2FGM3hoZFYwMkViVi83ejh4S3FjK3pDYUttSGlpVWNo?=
 =?utf-8?B?UGx3M0UvRnIrQ0lkU3l4SzJhb21SRzJZc1k0M2hqS1V1Q1NRUVU5cWU3WkVV?=
 =?utf-8?B?VS9CNjlLYUJNUjR0V0s3elE3WFVXaUdrQVpzUXhxVVJ5TmgxaGd4RjB6MFlm?=
 =?utf-8?B?NGFIV3lYK2ZUdGJpSURBRm1SUU1TQWo4dWhYQXZoT3htaGxjMGpnd0NybXA4?=
 =?utf-8?B?NVI2VFNnRnR6VTlQYVBTYlVqV2NtS2JRL3hZRU5mOXYrdnV0WUVBeDVrOGNP?=
 =?utf-8?B?bVducVE1UkJibGJnaE9TbERCWVRrQkV3anJqV2R2MkxYSkJIRnJyQlRWYytM?=
 =?utf-8?B?L29jSVA2VnluQk13TWpzYVE3SmkzeGJwUXppZlRMUWxoYlZIbFk3NzBZVEta?=
 =?utf-8?B?a01hZjhnS1FKNTF5NUgrM1ZtMitqNkFidVZDT0trOEV6MWRmcGp4NFpEN21X?=
 =?utf-8?B?Tm9zeXErOGV2NmFIeERhUjRvL3NUb1hPbGNCcUE4elJTdGhZVkVpSUhrQmpu?=
 =?utf-8?B?Y1lGRTlMRWV2QjArOEk4WFpTbTA2VVdnRFYwWDRBQTVobXlpT3hoNFpqTTU4?=
 =?utf-8?B?d0xDbWtLL1B3dHNtN0NjRnQ1NUluOXNIRXR5Wk10TUZJQUVWOWwzUlVLTXly?=
 =?utf-8?B?K1RFL3Vnei9sN0pyaHdXWU9Na1AzcDRYdDBTQk44amFwMkVUVStkam8wVEo5?=
 =?utf-8?B?S3cxbGlYQUhZclhFSE9tc1N5bUpoVmtNd0NlbFBBd3pkUTN1TGpLeERkSVh2?=
 =?utf-8?B?cjZDOGZVL1ZmU2sxYkxKNlFjMXNrWGx2KzNsZExhMVZ4VVJpQzg1aWNyb2lR?=
 =?utf-8?B?cnlxMU1GVE9lOTNxaE41RTg2QUpwVUpHblZQVFU3aWliaCs3MTBJOVQvWmI1?=
 =?utf-8?B?WkdoUnFra1c2TUdWUy9GV1lCL3l1RUFqbk5qVlE1VUVodFp5WURqdG1waDZ3?=
 =?utf-8?B?UEdQODlyRlRZSDdQTFBkckk3SFA0eWI3SkdmYUlBUEY3UEM3bW03V2N0V1Js?=
 =?utf-8?B?c3pxR3ZnSDh4R1lQa3U4aDBvaDROYmJJNWgrSHU1ZU52ZzM5YklPZUdXRDE4?=
 =?utf-8?B?bXR5dnk2dlNDa3VZUVFiZit6cFh6MDhqRGx5NVVzZmtWbng3Z09jTFF0bjZV?=
 =?utf-8?B?ZURlNFBKbWFwMDVPNFNWL0RndEtCejBjL3hWSDRLcXJzb2NPa1MwYmNaMnFn?=
 =?utf-8?B?VjdnVWtzQjBPOTFlaENZWkhyN1lONEZhamNuOWhpNFV1c2hPTzcxeFQ0WnEw?=
 =?utf-8?B?eFc2b2RlekdqZGxoSm15Q2VZMnpTRDNkNHpQOGlxZjNaaXNqaEUwNnlKZENo?=
 =?utf-8?B?aWlSUGhwTEhhRVVuaHUyOXNYcHY1MEk5YUFFM3V0NitNSVpnaHJBMDFYOFZD?=
 =?utf-8?B?RXk3eXUwMDMwL2dxMFNFbTQrYVpXU0c1VmpEbWNQclhSck1QNkFTSXhQelZq?=
 =?utf-8?B?MFZWdFlNbW1ZdmJJT0EwZTBWcXBaYmNndmkvTHY2SWlxVUo2VU82NHY1d3kz?=
 =?utf-8?B?UnNqeDU1bFcvMXc1cVpsSWNjVk5nYjZ6NHpMczhOakY5UVpNS2xYRXNleG5E?=
 =?utf-8?B?VWkwbEYxVk9xTEdkaGQ2bkpwM0d6QU5oSko0Mmt2ZG9EQjk2OU5qcU1qRXp5?=
 =?utf-8?B?WVFvWGYxVXFQazg1ZzhSR09penk1N2dhYXBzb2IrSDhUOEwyRHRKdHVUR3Ex?=
 =?utf-8?B?ZDF4MlpMbDFDYjdRZ0FWdllSZStxMWM4WG5WSTZzb1hUbzRMazVOZ2tqUk1I?=
 =?utf-8?B?VVJKd0pyV0lQcXFOUXgvbTUvTS80dFlkNHJab2l4Q0hZYkswQ1hSUmRiV2hj?=
 =?utf-8?B?c3BXT3hCM0dOZ0xKL251MlRPRk1xTGJRM1RyTjA3S2ZMcmR1djVpbHQ5MW5T?=
 =?utf-8?B?QUlScVEyRk1ZODdrdTN2V2k4R1ZuejlxSzZCNUNZZlhacjNTOUF4cXdXQmNU?=
 =?utf-8?B?eUYwRVNoWkJmYTRjVTh1MUlacHJLRWd0bWxkN1dRNjgzbEpBZ21jZmRkQmJS?=
 =?utf-8?B?WVMxL3ZlRG1aa0VVZVZ2YkJYRWRiSW00YUt3YVE0NkQwa05mL2o2OWFSWTZ4?=
 =?utf-8?B?Tk9SS0tFeFVZVFNjVGtVcTJpd3Byc2ZmOTEvTkpJdmpPMFBhVEt5UzNTMng1?=
 =?utf-8?B?OU01OHZjR0FBK3orZjNrWjFzTkNHbjVsd2RDR0VxeE10NW9yZDVxSzFGdHNK?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db0da0f2-211b-408b-1963-08dd7f57347c
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2025 15:31:07.8743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXQz8FksStpGdqjg2LyC0kZM0P/V52CiQPJs8tr/MUpcBqt+0DqmBQeKMrbRQf+Ax2eBlPE1/HAEvru/9faFTaDIsOXtH5ZFwqnejpNC9JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5276
X-OriginatorOrg: intel.com

On 4/18/2025 4:15 AM, Marek Marczykowski-Górecki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Since acpi_processor_notify() can be called before registering a cpufreq
> driver or even in cases when a cpufreq driver is not registered at all,
> cpufreq_update_limits() needs to check if a cpufreq driver is present
> and prevent it from being unregistered.
>
> For this purpose, make it call cpufreq_cpu_get() to obtain a cpufreq
> policy pointer for the given CPU and reference count the corresponding
> policy object, if present.
>
> Fixes: 5a25e3f7cc53 ("cpufreq: intel_pstate: Driver-specific handling of _PPC updates")
> Closes: https://lore.kernel.org/linux-acpi/Z-ShAR59cTow0KcR@mail-itl
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Link: https://patch.msgid.link/1928789.tdWV9SEqCh@rjwysocki.net
> (cherry picked from commit 9e4e249018d208678888bdf22f6b652728106528)
> [do not use __free(cpufreq_cpu_put) in a backport]
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> ---
> This patch is applicable to other stable branches too.

Thanks a lot for taking care of backporting it!


> ---
>   drivers/cpufreq/cpufreq.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 30ffbddc7ece..934e0e19824c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2762,10 +2762,18 @@ EXPORT_SYMBOL(cpufreq_update_policy);
>    */
>   void cpufreq_update_limits(unsigned int cpu)
>   {
> +	struct cpufreq_policy *policy;
> +
> +	policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return;
> +
>   	if (cpufreq_driver->update_limits)
>   		cpufreq_driver->update_limits(cpu);
>   	else
>   		cpufreq_update_policy(cpu);
> +
> +	cpufreq_cpu_put(policy);
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_update_limits);
>   

