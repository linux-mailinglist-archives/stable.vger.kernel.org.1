Return-Path: <stable+bounces-110321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D99D6A1A983
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 19:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB483ADCE1
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F5D148310;
	Thu, 23 Jan 2025 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4Y60jnB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D70C1BC4E
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656424; cv=fail; b=Ozoh2Tpco0Ut8mFqeVzRkCwXpeiLIqEF343AW7wdFvKJX2mlsA8/ghwm8p7wTplkcx1FvQXxNF59UX7gAzcVaXjvJCsUY8KdW2tfoIkEwLscWEwpwQjERafxdlwihkiQJP8+U9AfIW03D30B1TweNbWZc+IBPbzsGpNlUxBrmfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656424; c=relaxed/simple;
	bh=IflAPHUWhT+/qZYlK+0MfKkto6GRZOPBZ3SYsvek+sM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cNgCn4sLqP/yFbhDCMbD96sqVEkRuLtWG0HNdo+j9oq51X6Mxx9wzYkP5vF31bN5ukuhLsYlXJyaNBcUWflxTLOEbCmVboTs0VSEOeRsxz5Kd2k0Tpgl7RY2tmGaCi3yjhJdi2h0j2Prq/cQu5ogWbqBnnN2XW0pI87WamqeoEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4Y60jnB; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737656422; x=1769192422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IflAPHUWhT+/qZYlK+0MfKkto6GRZOPBZ3SYsvek+sM=;
  b=E4Y60jnBrDfKOC4zh4fM+1VO1JlPvDBGtjGMU+zNqxmG9I96HPuQaH3g
   NecsbxY9po1CGMUbcIeGZDyi872Spo5peW9pON9TJQ4BCSC8CSAx8SpCW
   s+DMwMC4ErcM8rZS2cZmYBcpxHfYYkgj5eceSr1VKFD4Lvl0NJGBHIIrE
   U9sNDD92I8eMBcnIzhMCYQA+8mrJAFSbcI5JQIYcYr6kat10svds3C+OI
   dTPV/hEsxYAf53xApz0bqrr+58skc3MMPHOKc9MAB2xmkuroQNUJYygNH
   DIUL8XVpGgckq42u/5PPcfYa1Br5Kj8a7Gjl2qUw/2OZ5u2PcFVshtPMP
   A==;
X-CSE-ConnectionGUID: q5EEldq8Que106h1Lkt1wg==
X-CSE-MsgGUID: kuVF+PVESnmBtk9Mo4zWcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="37871780"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="37871780"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:20:21 -0800
X-CSE-ConnectionGUID: cJhLUknPS2m13TswXyuFww==
X-CSE-MsgGUID: gYdlqJzrRKGgWos/4WZ9MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="108084421"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 10:20:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 10:20:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 10:20:20 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 10:20:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqe5mlFPpTvZfrGsTyV+MOhSO3F3xnVR/ZaLg+/fG+IgpyQJWtQDRU70KqYFi5TjobmR/EXFLfkG1uFR9ufT0fpyEupTqkdSNaQplvIsq3hjTKTU6sppCzXVroLU8k92ZYGrTz9VJl+eG+y11gmxV9fA6mgAl1iEYXK9cTTJo1Y9Zytv+F4GbNdB0KOBmWMbagNmptXKpjE/OdDJAt4up2RGFQFkBLOdPnu65Svkk3+zp4WmTa9cz7bjx4jYedJTHrwnP7j4eL2pyUykP4RaLqZ5nkPX99aT1fGX3bLmCT6OKeDQ4nisfLqz/qvYJGwo5LBC2SXbheQBaLJtkzO03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OrVbIww0S3FwQx69PoMfaMTdP/e5XQKkiXcSBdQrD4=;
 b=OfrF7LI+drKcLPQJF4Ck/4V+85TXshmvuZcBs1nLot0nhmBHzFp0uyNmWRPL28VOEGuvoaiUw8z1J08kD4mergsz1hQi6Ko7Sz4dvPNq4KMWCjksfCQsWzMNqm7Fe11LNOkmU5FmV6ZALQlyQU5WzaoLMY31lyQ3BMTTwyKdpf2BaGHWsbKBQqRfoCYa9zTNJCNGkQAZJBMktcducFCY9I5/+X4P3F5ZprXOZGssYPdj77fLQyJQIe3cSxlBKDKNQprvtlVstiiy1EVtJeT0E71x0YgBFi3WxYAvuJ72twCdB98eNAbCfn71t4YvI7bWGEPfFgXOhiqQrp4/+6RwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8450.namprd11.prod.outlook.com (2603:10b6:a03:578::13)
 by DS7PR11MB6295.namprd11.prod.outlook.com (2603:10b6:8:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 18:20:16 +0000
Received: from SJ2PR11MB8450.namprd11.prod.outlook.com
 ([fe80::5c1b:f14a:ef14:121e]) by SJ2PR11MB8450.namprd11.prod.outlook.com
 ([fe80::5c1b:f14a:ef14:121e%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 18:20:15 +0000
Message-ID: <270f7646-da91-475e-a0ee-acffc6a1bfc1@intel.com>
Date: Thu, 23 Jan 2025 10:20:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/xe: Fix and re-enable xe_print_blob_ascii85()
To: =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Julia Filipchuk <julia.filipchuk@intel.com>, <stable@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
References: <20250123180320.66198-1-jose.souza@intel.com>
 <20250123180320.66198-2-jose.souza@intel.com>
Content-Language: en-GB
From: John Harrison <john.c.harrison@intel.com>
In-Reply-To: <20250123180320.66198-2-jose.souza@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:303:16d::32) To SJ2PR11MB8450.namprd11.prod.outlook.com
 (2603:10b6:a03:578::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8450:EE_|DS7PR11MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: eca2f943-3827-4e63-b14a-08dd3bda95ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmdEdGxabVZrUnNxVnp6V0NnbHE4ZG9uN1pFZGsxcFBucUo2Z3A2UHhDKzJB?=
 =?utf-8?B?a1M5WXBwU1lzUE80bXRDbzVnbGNtcCtSZjRLeE52eXdNdU9YMHB2Q25GNk9S?=
 =?utf-8?B?U2lMa0lPRkhpTDdyRlVTK3VqUk93d1NYSDBKcktGQXJ3dStSVGtHSEh5K0tr?=
 =?utf-8?B?WklkUjM4TFNXTlUrNU1OaU8zR21ja051ZVJkZGJRT24yR0EwMmpuUlc2WkN3?=
 =?utf-8?B?cmk4Y1g1UmtQc3pOZ0xwWGFCUzVTa3ZuL1ZCKy9laVUwNlZmMTcvdGFYTzlh?=
 =?utf-8?B?d05jbU5ubko3YjUyNkFxQVhvNi9mZXp0dnBjQk5SeDlFZFg0NkR2QysvSTRU?=
 =?utf-8?B?VVd3RFhYbXc1eWV3RUdpdyt3c0V5c1pDVHc1RXV3RW5HQUZtUm45RElrbEVk?=
 =?utf-8?B?YVJ4aitQcm1nYkwzSzZ3dmJHUS9tdyt5MnVlbktCa2ROSC9wSlQxWHlpRUFV?=
 =?utf-8?B?ZVh4SUZUeFZvdmxCWTBzU2x3U2ZnSHRtMVN2TTBGSUVobE9kKzBVemtqblpV?=
 =?utf-8?B?MlhZUHZtYlljWjdVN2lSOUNtUDZ5Um9IQ1ZRci8rUjZscGV2a0F0cGJNUTBH?=
 =?utf-8?B?ekQ1SVJwYnNwVms4VElOcm9MamlCbGVtM1pZbjJISTdINE1hVE0xMFdXV2xB?=
 =?utf-8?B?MU5ZenNUS2tYZVZHak5zSGx4NjMwaVE5cVBNQnpRUVVudERLZHNFbXp3ZlVR?=
 =?utf-8?B?MVZxR0p2Ym9UMmhBTlUxeUt6cmtPdm9UbDFLckFCNGhGNUtMSjdzRXE0U2tp?=
 =?utf-8?B?WXJkUEV4SUtXNEw4QkJWNnBsbjdnQStlS0E4NTRkYnBQVnpzSXBWZ1ZoNjda?=
 =?utf-8?B?d0xNZ09BTHNzUVBHTnRnUXlRa2lESnRjcFdxWE9tcXVjWGM3U055NjlNaFFI?=
 =?utf-8?B?UG56WW4xVWFBOXl4TVA0QUtPbW5pQ2hvbXFZY3JFNlcrR3NENkZtRHd1ZGM3?=
 =?utf-8?B?clRvOEhZNi9vWUthQ0toLzdwWG1RbTU1aU9lT2ZPNFBmVklPWjBXaEQ1eFpx?=
 =?utf-8?B?NVVORnVtRURydWRkZ3UrMVdlL3VvOVZROU5QTktXaDZBOU5IQ3FGMXNrR3I1?=
 =?utf-8?B?bzY0U3c2ZjRqbkZVQThQU05rV0dXdllKWThUUnArYXB6anRqWmYvOGsrVGh2?=
 =?utf-8?B?V283QWhsZkU3VjhUenl1SVZGRWtkWVBhZ3N0eEtEb3BGSzFlWVRzWGVKa1RF?=
 =?utf-8?B?Tm04SlN5KzVnOVdLT2xQbmlERnkwallCVE4xN1djRFY0T280ZEw0QlNFS1c0?=
 =?utf-8?B?UU1oWDd2Y2MxaGVOenNMQ1ZZWC9DaS9na2lVZXdBSTNHM0pZUG84T3pHRDFr?=
 =?utf-8?B?L3FlMmNUdDlDbUZGSnlwSURERmFBaDR1SFErdkpEdWlleGFZeWVUMkJPMXVn?=
 =?utf-8?B?SzUrSWVhT2gxbDhoRnk2K0NKNENEcVB6azZadzBrOTIyRHlSWjRubFJWUllu?=
 =?utf-8?B?a21ER1E4MUljdUtVNXdEUXFjb2xnK1duc1VsYnMzM0gwdHJsdHhETFZvb3Bl?=
 =?utf-8?B?VGZJRCtlMTltZVRQanhjK0hTOEZoT3ArVEVJdHlIV0JXNEJ6VGlyYkpNRmFy?=
 =?utf-8?B?YkZ0VElrekxyY213Q1VBTlVlRno3OHFscTQralNxcWJYOUEzZkpGdWllVmlJ?=
 =?utf-8?B?VDhiWHErMW1HS0FXQytDbDkxZHBGUTdaSG4wUEw3dXFMdDZwcVFMRXBYak5L?=
 =?utf-8?B?TTVFdGJ2VEp5TS9zNjNwYXRDb3htRitTM0hBNXJvanc0TnA2THpQMFVYcVVx?=
 =?utf-8?B?RWJNT1kyOWx2Q1JYRU0wMlhZMm1WU24zbGFXVGVrWDhkK1JmRDJVQTV3WE5k?=
 =?utf-8?B?TXA3WFJJQTVLVlIzZldhb3B3bUlrY0Z0R0RweVoxYTErYWFUTi94TDVVM0o0?=
 =?utf-8?Q?pYRNV2bT4LztK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVlsWTQva2hsZnp4WEU3MzNaTklOczdLZmh4WU8wVjFVYVhvTng3L0dIUXA5?=
 =?utf-8?B?VVFlMnh4SzZ1MERkamNEQzR2T2s4MTZpOUh6aGVrVjAwNjRPRXgxbVpsNEhQ?=
 =?utf-8?B?YVAyNGtDazJMaFI3RE1oWjBTTG1VWG5iRlRKWHY3OEx3UlQ3dWpxK3RNTVV1?=
 =?utf-8?B?bko4aWJsOG9zMHA2eDB5bC9IWHFzLzNILzNVMEs2L0pZK09MNlU4ZmIxaHZh?=
 =?utf-8?B?ekpZWis2cXJNOFkvd1RVcHpGR0RnOTV1VTJLc2FkT3hSelZ5bHdOOHJtWmtQ?=
 =?utf-8?B?ZktucURSN0hsY0VmUUk4a1BDOVJmMUhIdWpHVDJMdVFJcm9GSW1ibGxoU3lL?=
 =?utf-8?B?SmZpSWRuK250S1JTdFRuVW5aQzlXK1diVDZpdDRKbHl6VnhON0c1SzJxRWpq?=
 =?utf-8?B?U2MwWkhzRTJPVG5ZVzlYb2ZCU21mMEVnRmxORDQzK1V6cEovSStQTkxoNDlx?=
 =?utf-8?B?TWU5K2xycUJwS21LK2hCNUhiRmxJK1owSkU4VHAyekdZdEN4Rkg3Qm1sZGJm?=
 =?utf-8?B?aUVWMUNYVTdxQ2w5L3ZFWGRhUVVJdUdXS3dIL3VkMzk5K2xaYzN4QThrWXB3?=
 =?utf-8?B?V3lIZFQ2SG1QbVNTKy9sS25aWHNVUGgwTDhUbjlkMGlGSjVWL2cxSldpU3JL?=
 =?utf-8?B?eWJkcDJCc3IxSEhSc2c3UHpDNnNJYWVZcFNVRElQNzlzLzNpaGJRaGl0V1R6?=
 =?utf-8?B?WTlYa0M5ejdhaGxyQ2JvZVVzcG1BU0xFYnU2NDEwUjU5VWFqWkQ5RVlCUDlE?=
 =?utf-8?B?K2dvY2szR1JVUnR2WSt4c2t2WlpxeWEwVTdtY2ZMOTFIWDRueGRRRElMWkpV?=
 =?utf-8?B?OXNTQTJUUTEzTTd1K0ZSbUVmQW5qNERjQzBHODA2K3Q0MmZ3S3MyYXQwa2sx?=
 =?utf-8?B?TTEvT2U5WitEWEpnaU9QTGsxcXJybE43T0JqVmFwcmk5WVN1dC9oR1picW5H?=
 =?utf-8?B?RVRwWStzdHlaWGVEUnUwRGtvTzlkUG1GV2QvTnVsVjMxV1N0amd5M0dIblY0?=
 =?utf-8?B?empMZ2t3TUhwNjk3T25TbG4ycWdiNXEya0pwSVFVRXFyMHVJSW4yTGJYdWZk?=
 =?utf-8?B?aE5hSnZlZVdMbzh3cmprVFhaTVJMd3BqR1FMRC9JWlZnOUVkM2pObWxBSno4?=
 =?utf-8?B?cGR1OW11blBGNnFWMHFKM2puNklUSkJ3SThIR0dhcC8vcHZHOU5pVWZiVTJO?=
 =?utf-8?B?bG1obmxJVnRieXM4Z0p3eEc5d2dwdmpVbnhFVFhrYUhxQjV2dHJnaVg3aGVs?=
 =?utf-8?B?MWdxSnNDYXdYYVJEdHZvZUtTL0hSS3RvRGJsYmpUZ2VEOTZzVHVSakpWMVlZ?=
 =?utf-8?B?bTk0OGFUNS9zR01aT2VGc1BhUGR3em53SUdRSVRsRktYZHd6dXdZK3hVdDFy?=
 =?utf-8?B?cjIzdWR2T0wwOENSY2VDQWxtNnRtNGdTNlVpcG55OENJU0lsMWJnMDJYeGl2?=
 =?utf-8?B?dlJxQWwvOHFSQmd3Q09XbDd5dEVIQUJLTndxMHFqdkZxKzdkcWZxbmxzZXVv?=
 =?utf-8?B?OFlUek9wd0ZKbEpLNTJaODF3N29lTlBsenk3aUs0ck9mTTlVZDBzUytRbnJV?=
 =?utf-8?B?OC90c0ovbjI2M1E5WEwzS1VLRXhDeHlHOWlBcjJTeDQrdWNUV3lzMFRGWkhB?=
 =?utf-8?B?bnlDYldZUVoyNHVOS3ZpZXIzaWR3d0IrajJrNUdRUS9wK1UvZTVZTUhGUko3?=
 =?utf-8?B?NnV1N0QvNHdTSldLL0hJN3BKWnh6Qi9OMjlmUVo0dVMwTEpVcEgvQ2FtNFBL?=
 =?utf-8?B?eGl2dnUwS04yUlEvZ3VYMGZFcGdqNFFFaDAxeVk0WXFCbEIxZGpCZE5wOFVK?=
 =?utf-8?B?a1VLcWpoNGZreGhpS09GWTB2MGI3Z1Y4M2RCS0Y0TUUybk0weG96djA4VjJz?=
 =?utf-8?B?V2MxbXlFMCtmd0RaK1VGdTNPWkpKMTRQQXd1TXc0TTA5Um1yajl3ZlBxdmhE?=
 =?utf-8?B?aFNYNTR1RThyekZ6NVEySDdoZzhrbGVaZ1VocS9Pdm5KZHFkUFlEUDJpaDFw?=
 =?utf-8?B?alI1L0dOc1ZpS3RFNDBKTXYvdVJKVVZ0K0h6aE1FYnVWNnFqaGVEdGRJTGdT?=
 =?utf-8?B?QkFULy9JTlB1UWdwVDB0MGUxTDlPV3BlMGt4bUc4cVN1YmZEUlhDazFCM3hq?=
 =?utf-8?B?bWg3SjZmdDd6VTNFRVpvNXJvYXVXVnBVVTJjZllyMGtSc1kxR0F4eUxjeXZk?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eca2f943-3827-4e63-b14a-08dd3bda95ba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 18:20:15.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDz0y26QuZ0uMLWmGMX8iOFpZ4tLCoP4wL7W2eoG2NqQGr1MEDiIzn2zUy4EJ5J74k4w2c4i1nrbqJDpDKWtwpgwz52BdUCJZhXIXdZMgj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6295
X-OriginatorOrg: intel.com

On 1/23/2025 09:59, José Roberto de Souza wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
>
> Commit 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa
> debug tool") partially reverted some changes to workaround breakage
> caused to mesa tools. However, in doing so it also broke fetching the
> GuC log via debugfs since xe_print_blob_ascii85() simply bails out.
>
> The fix is to avoid the extra newlines: the devcoredump interface is
> line-oriented and adding random newlines in the middle breaks it. If a
> tool is able to parse it by looking at the data and checking for chars
> that are out of the ascii85 space, it can still do so. A format change
> that breaks the line-oriented output on devcoredump however needs better
> coordination with existing tools.
>
> Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
> Cc: John Harrison <John.C.Harrison@Intel.com>
> Cc: Julia Filipchuk <julia.filipchuk@intel.com>
> Cc: José Roberto de Souza <jose.souza@intel.com>
> Cc: stable@vger.kernel.org
> Fixes: 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa debug tool")
> Fixes: ec1455ce7e35 ("drm/xe/devcoredump: Add ASCII85 dump helper function")
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_devcoredump.c | 30 +++++++++--------------------
>   drivers/gpu/drm/xe/xe_devcoredump.h |  2 +-
>   drivers/gpu/drm/xe/xe_guc_ct.c      |  3 ++-
>   drivers/gpu/drm/xe/xe_guc_log.c     |  4 +++-
>   4 files changed, 15 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
> index 81dc7795c0651..1c86e6456d60f 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> @@ -395,42 +395,30 @@ int xe_devcoredump_init(struct xe_device *xe)
>   /**
>    * xe_print_blob_ascii85 - print a BLOB to some useful location in ASCII85
>    *
> - * The output is split to multiple lines because some print targets, e.g. dmesg
> - * cannot handle arbitrarily long lines. Note also that printing to dmesg in
> - * piece-meal fashion is not possible, each separate call to drm_puts() has a
> - * line-feed automatically added! Therefore, the entire output line must be
> - * constructed in a local buffer first, then printed in one atomic output call.
> + * The output is split to multiple print calls because some print targets, e.g.
> + * dmesg cannot handle arbitrarily long lines. These targets may add newline
> + * between calls.
Newlines between calls does not help.

>    *
>    * There is also a scheduler yield call to prevent the 'task has been stuck for
>    * 120s' kernel hang check feature from firing when printing to a slow target
>    * such as dmesg over a serial port.
>    *
> - * TODO: Add compression prior to the ASCII85 encoding to shrink huge buffers down.
> - *
>    * @p: the printer object to output to
>    * @prefix: optional prefix to add to output string
>    * @blob: the Binary Large OBject to dump out
>    * @offset: offset in bytes to skip from the front of the BLOB, must be a multiple of sizeof(u32)
>    * @size: the size in bytes of the BLOB, must be a multiple of sizeof(u32)
>    */
> -void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
> +void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix, char suffix,
>   			   const void *blob, size_t offset, size_t size)
>   {
>   	const u32 *blob32 = (const u32 *)blob;
>   	char buff[ASCII85_BUFSZ], *line_buff;
>   	size_t line_pos = 0;
>   
> -	/*
> -	 * Splitting blobs across multiple lines is not compatible with the mesa
> -	 * debug decoder tool. Note that even dropping the explicit '\n' below
> -	 * doesn't help because the GuC log is so big some underlying implementation
> -	 * still splits the lines at 512K characters. So just bail completely for
> -	 * the moment.
> -	 */
> -	return;
> -
>   #define DMESG_MAX_LINE_LEN	800
> -#define MIN_SPACE		(ASCII85_BUFSZ + 2)		/* 85 + "\n\0" */
> +	/* Always leave space for the suffix char and the \0 */
> +#define MIN_SPACE		(ASCII85_BUFSZ + 2)	/* 85 + "<suffix>\0" */
>   
>   	if (size & 3)
>   		drm_printf(p, "Size not word aligned: %zu", size);
> @@ -462,7 +450,6 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>   		line_pos += strlen(line_buff + line_pos);
>   
>   		if ((line_pos + MIN_SPACE) >= DMESG_MAX_LINE_LEN) {
> -			line_buff[line_pos++] = '\n';
If you remove this then dmesg output is broken. You can make it optional 
in some way so it only happens for dmesg output, but removing it 
completely does not work.

John.

>   			line_buff[line_pos++] = 0;
>   
>   			drm_puts(p, line_buff);
> @@ -474,10 +461,11 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>   		}
>   	}
>   
> +	if (suffix)
> +		line_buff[line_pos++] = suffix;
> +
>   	if (line_pos) {
> -		line_buff[line_pos++] = '\n';
>   		line_buff[line_pos++] = 0;
> -
>   		drm_puts(p, line_buff);
>   	}
>   
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.h b/drivers/gpu/drm/xe/xe_devcoredump.h
> index 6a17e6d601022..5391a80a4d1ba 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.h
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.h
> @@ -29,7 +29,7 @@ static inline int xe_devcoredump_init(struct xe_device *xe)
>   }
>   #endif
>   
> -void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
> +void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix, char suffix,
>   			   const void *blob, size_t offset, size_t size);
>   
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> index 8b65c5e959cc2..50c8076b51585 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -1724,7 +1724,8 @@ void xe_guc_ct_snapshot_print(struct xe_guc_ct_snapshot *snapshot,
>   			   snapshot->g2h_outstanding);
>   
>   		if (snapshot->ctb)
> -			xe_print_blob_ascii85(p, "CTB data", snapshot->ctb, 0, snapshot->ctb_size);
> +			xe_print_blob_ascii85(p, "CTB data", '\n',
> +					      snapshot->ctb, 0, snapshot->ctb_size);
>   	} else {
>   		drm_puts(p, "CT disabled\n");
>   	}
> diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
> index 80151ff6a71f8..44482ea919924 100644
> --- a/drivers/gpu/drm/xe/xe_guc_log.c
> +++ b/drivers/gpu/drm/xe/xe_guc_log.c
> @@ -207,8 +207,10 @@ void xe_guc_log_snapshot_print(struct xe_guc_log_snapshot *snapshot, struct drm_
>   	remain = snapshot->size;
>   	for (i = 0; i < snapshot->num_chunks; i++) {
>   		size_t size = min(GUC_LOG_CHUNK_SIZE, remain);
> +		const char *prefix = i ? NULL : "Log data";
> +		char suffix = i == snapshot->num_chunks - 1 ? '\n' : 0;
>   
> -		xe_print_blob_ascii85(p, i ? NULL : "Log data", snapshot->copy[i], 0, size);
> +		xe_print_blob_ascii85(p, prefix, suffix, snapshot->copy[i], 0, size);
>   		remain -= size;
>   	}
>   }


