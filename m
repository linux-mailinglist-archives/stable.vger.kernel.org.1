Return-Path: <stable+bounces-59050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B4892DD21
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 01:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9869A1C22456
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 23:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF10415ADA0;
	Wed, 10 Jul 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyFYW9AN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1615A86E;
	Wed, 10 Jul 2024 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720655333; cv=fail; b=GvtLZADXpXIu0yI7NH6A0cURdMom3jIMAXpFzDLYJjAW8GtsHMgvP3nz72tq7HjL1V3lZHQKcVyuI1Yt8G+kyT0hmxwRitilNAoDfPgNL4wKxrsZm3mhd8RbFdSpLN9usI3zn0p9U7g3UfWGExRSqvJlQP4EzjgoVPGmY84LxSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720655333; c=relaxed/simple;
	bh=PQmxOIIZnBiS+KQB2KAmIxpMy04fk/rkAPhV3aQe7n8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C0zmF1weSI/KUSl/5aVk2MTYHnkqeOGuHjRcdV3M+NO1bvm5r5bY4ADK8KzpBKAUT5xzzYk/Va6t5AppUC2wQmpRlpe32DduIPZBmO/KRjTaN/PgtUKgaLH0fLwFaLzeqR/54hBEZBH43bwPl5hUF0QOOCcDKWFcds04cmyC1GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyFYW9AN; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720655332; x=1752191332;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PQmxOIIZnBiS+KQB2KAmIxpMy04fk/rkAPhV3aQe7n8=;
  b=kyFYW9ANjcOTZ+F6V7OLsdNtgjo8tZIPg+evdE9IOrBAG9GtLCNoCMlQ
   IbYln0gc9JrROpB8lvdk7hixBDJOds41t2LAQr0aoceRL8Tz0Qy+VJTPN
   vlDsGnOWAiut4WYzXSyjsUELswJWqIDujtjVED7YmsNRMhV7pLygSrFrs
   hlfaDmB2xD6gCjPgVWjacoKPl5+eqwRkLIPP8ejl6sVUJsQvMDrqq6Sav
   m3R6cWrC8N+lgJiBEVHQIU/RfGBHEgyxZarq54A2zx8tUn6rM/Bt24LX+
   cJXCPO/ZsTF3OayrlaCZwYiVITdCjMGT6wI9D0arJ9I77BBrz1nGh17Dn
   Q==;
X-CSE-ConnectionGUID: tOeb9Y15ScSP28Ip3rkuRQ==
X-CSE-MsgGUID: K0ImK3OuR4i9Jh6BvRS/eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18152202"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18152202"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 16:48:51 -0700
X-CSE-ConnectionGUID: mHri73S8ReGJsu6pVcVdVQ==
X-CSE-MsgGUID: jkaAD1GdSvi8E3e/+7YQFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48345516"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 16:48:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 16:48:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 16:48:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 16:48:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 16:48:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbCMu29nlloDXUsAWLj3ogUmlaokICYBvbZ28vSbN9OUxnaOtaX31uN76Ip41Lz8d8Ak384F4rtvcYiq9iTBtuP0qumzmSABjBvEvQcTpnpLi1X0TKf9HYYPxNSg4IFnWzS2obk0PRuMUjbKClFH+adPKuCECQ3jMHP1YO5SwymOXmeW0L5aKdBN7RKFKZLrd7WbPsVL7uRAXXNbRTxMlOyT2COrV2L3PejynocIEEhaY1qvlhOJuu0iF7SJ473+LaZBJ4WdzzBmngFyK9yY81jbfRJoH5+xGZfHLC7Q5A8BCTnM0h4rjj2OymgVXnc6U50GgGZ4go7SA3bq4YYaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/HxrDkzSpUE1g0hKQk8dhPov0a+X8MG1HXLHjErqUQ=;
 b=Cxfju2Uxb7tmD3aAC+gZar0CTNOmfCxF5NdpixlvnNoVBaPvSOar83xnJQoY/uAFrxFqu7XPF0HxiK910bTMrzs1r8QIFlr/1FFwPqdrYyORx3qme29ErMX4BYvxSZBGYQC3GxjBwjTJuCh+gYvnDy32Y+rXh4zSh3nTIesAJYxpGGbhw9zxk2koBOv8aoPEqcLhlwAlmqej7YI963f9Y/8mXn6ACtHkOmyhOftoSzl1K0halFmS+Hv2qlWxso3BzKkJ14w1slHAtEd3a6rBqfEmGlRoaiCiOtBjRQYf0DdzUMikqKofzmXqDIj5grTrenGGBBV/0Wlx11LwGq0fyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5167.namprd11.prod.outlook.com (2603:10b6:a03:2d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 23:48:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 23:48:43 +0000
Message-ID: <8e4c281e-06d8-47bf-9347-d82107f00165@intel.com>
Date: Wed, 10 Jul 2024 16:48:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ks8851: Fix potential TX stall after interface
 reopen
To: Ronald Wahl <rwahl@gmx.de>
CC: Ronald Wahl <ronald.wahl@raritan.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240709195845.9089-1-rwahl@gmx.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240709195845.9089-1-rwahl@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0281.namprd04.prod.outlook.com
 (2603:10b6:303:89::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: c5bcd623-ab86-4f93-8d48-08dca13ad549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWw5WGVUY1VvTFNTNit3VDRidmtnWHNCQVpzdVVySnUvYlVFcnVsTm5JQkhq?=
 =?utf-8?B?WWJLSEhQYUhCeGUyMWFJTCt0U3lrK0lvY0J3NzJKZ3dNdmhpMXJpQnYzMHlR?=
 =?utf-8?B?dlZFNXA5UmdOanBGOHVBSS8yaUsrKzFoVm1zd2h6Qi80Ylo5TmcrdjkxVkNm?=
 =?utf-8?B?ZEtoUzlvdWN1UGNCZWoxYWpPTU9aRGltUkYrc3ZxYmF2SEk1aXBiQk5SeHlx?=
 =?utf-8?B?VG42K0lDbVFsVHJVMXgzQWNzdGVVK1huTm4yQndna0lscFBoSlVDOW9vOUlE?=
 =?utf-8?B?eUZscXc3TjAyUWJSNzIyM1cwU2NSNElDNm85WkFBczJJOXVoU0dzQTREdDd6?=
 =?utf-8?B?N05mcnlrdHhhZFpqcGVLNlFmRGpJL0szTW15YTZQWDVvbnVVUTBJUEthVGt3?=
 =?utf-8?B?UVZBTDBjTm42ZmR4QVZUTkYrL3hUU2pFbHRna1N5dWNpRUNNem15aHdwVzZZ?=
 =?utf-8?B?a3MvbDJYanpmaTJRY0NpNjhNNnhSdWhjcUlLYWlvM25XdHZiS2lyaTViWnVw?=
 =?utf-8?B?UGxaUWVGN0JQZm9tYzFoUlZ3dTk1ZHdnQWhxUjlDZzZ5V0JaNjRrSm5GVmQv?=
 =?utf-8?B?a0FscDIyWUdKZXJxUysvcE4zWTRJLzQ2Nmg1eHlMNHhocFkvRHBUbE05ZWJP?=
 =?utf-8?B?blVuaDhXcnYvN0I4aUVrbzBYclJPaURrdCtwUFJna0tHejVhWHRhNExsVk83?=
 =?utf-8?B?dFdzZlU0VFcrcm5ZNFNMWHhRa2tKVVNGQ3lNR09LMEJNTmdnNjFWS0M0NWdP?=
 =?utf-8?B?alFLZ2VvVmVicVUwVzdXM25rcFRzdFVGem5hdkpRTmgxWmg2c2g0NXRDb29T?=
 =?utf-8?B?M1hPODZXbHloeFFsbFZSR1RGS0FLNUE0TEZIelRqK1NUQStZdFMxMXhrWHhm?=
 =?utf-8?B?NFR3RE5BSGpYd3lFM1AxT3VJcGx6V25pVFk2dk9zQ1dqemNFYkFjcWNzQnEz?=
 =?utf-8?B?a041L3hQTmhxL0RXcTZLZ2xGc1VWYnY0UjZYQkxVOVhXYnhTYk5keVlSZzVw?=
 =?utf-8?B?a1lSbEMzMHl0L1A0cGlQMTNNQTluSS9icStjQkF0YUJENEZZdVdxNmRUajBu?=
 =?utf-8?B?OTczQkNzTFMrNDg3dDlRclhwMGFBNHVlYVgzOG9WQUhkNDFHSzNrRXdOMkt6?=
 =?utf-8?B?VG1IUlJyNlFyY1pGeXJmUkV6cGk0NDVIKzZiaGhRZmF0UURVSlBYT080dlE5?=
 =?utf-8?B?aFhRM1hpeFpjR0lDazg2SERtQXFiblN2QkdCZndYL2ZqMjNmbHcvbHczSXRM?=
 =?utf-8?B?ek5iMmZDTkVYakdpc3ExYm1vZFkzdEdNYXFkVDUrL3JtSmZ6YjdHZWVQS2p0?=
 =?utf-8?B?cTAyK0YrU0syZEc1Nml6ek81ZXFiRUhYZXdzWnpKbWJUL2VhZkFLcnBYYkp6?=
 =?utf-8?B?ZXRXQUtSYzlhL1lteHl1NTFRY240UkNiMnkzWVlQbC9mNnZuNzYrSDFDWmtV?=
 =?utf-8?B?ZTFEM0pYSS9LcWgyeldlOXBTQWowRldqcHdsTExabkdjRWxrSWgxd0pzSHcy?=
 =?utf-8?B?azBJTDV5TDZkeE1CN3VERm5hTDcwTVhydS9nbHFmUkc2T1VtSW5LemQ3bUgx?=
 =?utf-8?B?OFBtSU1nOTVlejZrcTZuMitWMGtabzFXUkI0SEQ5NGNVK0NrODBVaVlNSS9m?=
 =?utf-8?B?ZVROMWlmL2lBdU1pUS9aR1JSSXdQQndNWFBUOWE3cGdjYlFkK2N5YVdTMUxQ?=
 =?utf-8?B?SWpuenpaV1hBY0pwdEVtK1UxNmJaK3FWWmtzemp4S3JYOW9wT3ZGTEtFY3Ux?=
 =?utf-8?B?eUFzMGllTExLMmpMOEVlRTFhUlpETjNWUGpMSVVzUWFIVHE3VE9YTU1ETVRE?=
 =?utf-8?B?cWNiMjdKbjJkQWlJUWVwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejdtMTlIcEdMajFtai91U2JhaEttdHMzQ3J5UEVTbDc5MjlUQ3RISnhLRTVN?=
 =?utf-8?B?K2E3QVhHbmI3RTVUSTZjWklpVjlRSldnWklHS2phSmhlSVJDa2RydHNYQ2hU?=
 =?utf-8?B?Uk9rVmtJMWhFU3lqQm1KUkJ1WVBqVnplZ3Z5a2EzY3djZEpvVUhOaHJITGVB?=
 =?utf-8?B?a0RDWW0rUk9ZSDcvSkFVdWJnVU1RMC9hbWVqYVgxditsTHZoSnArK3pQdU96?=
 =?utf-8?B?RmhTZGx1c2NmVU1JallDOGRVSFZjMnJYQW9TZ3l6VmxQTTIxY1J2UERyWXJY?=
 =?utf-8?B?dWtob0NlckxiMndLa3BlWUJkWGlGeWxGK3huUXMreVBMUWZGUW9FUDlhaHJv?=
 =?utf-8?B?NGRSZjVCUzVmNnJBSXNENFRwbE54amJOc01tVVEvS1VoaTlIcndVWVJxdXVZ?=
 =?utf-8?B?eVVScUdTSzlPRG1iUXVZc3owZzV3SlNBVVY3Nnk5azBrbURlYTBNZk55dWE5?=
 =?utf-8?B?eE5xLzh3NFQrT0w4RTd5UXRtYkEyWWdkNEJYa0lGRnppTWl2RCt0NzBNMUhX?=
 =?utf-8?B?c0x4S0N2dy9iaHR2aUJDWlczYTJkb2xmdXBMd1RpcWZmN1Z3dWIvbzl5Tkt6?=
 =?utf-8?B?U0E3L2ZLZFFRamxiVVB4emUxY0FsYmIzdWtjbkZ2SFhPd3VQK1NiaUM2Uy9B?=
 =?utf-8?B?OFYyaHVJQVkzUXlKUkVuVTg5Um9ueDRoc3VaVGxWTEZHL3R1QkY1dHluM3pM?=
 =?utf-8?B?V1h4cnBsZlRJUDB4MWg3eloraHg4VmwxaCtpSDBmcXZhbFQwY3AzS2trdy9q?=
 =?utf-8?B?UzZIZXZ6QmlqbHgwUFVzcUhwbm8vbjZueGFQTDBySWZ1ak1JV3hEN1NFZVdZ?=
 =?utf-8?B?TE0weHB1MEJvTFJBUFUxY0s5Rk80dGFMYnpEc1ZXTkxic2pjZDlyN1BCQ000?=
 =?utf-8?B?WDZucUJ5T1o0YVRQd00rNDZHcTVPbVNlZFJpOXB4QmFSajBvRWlSZUwrVHlr?=
 =?utf-8?B?MmtKM0pRdjF4OUE2dmI3N1duaUFPMlhYTkpzTUxFZFlMSm9ENVZiTkZ1Ylha?=
 =?utf-8?B?ekx6WUFUUzl3T0E5QmN1enBLUHVDQXFrTVFuMTdFZExrNFpZbHJjOHArcS8w?=
 =?utf-8?B?SEE0SlhURThoejAvUGp6VVZhQ3NjRitKQWU5a0szMVNHT0ZhZnRLSlJDYjM4?=
 =?utf-8?B?SjlXRThqVWVjbUJBdTErWFhTRFpnQWhJK0o5L1Y0OStHeFZ4cWJteVBaUDl3?=
 =?utf-8?B?UnhwNU1CM2Y2NmZEUURNS2ZXN2kvUzdhcWtxdjJTOWdNNThRWDJaQjJ6SWk0?=
 =?utf-8?B?ajg4R2pQZnJKQXpxeUZLRmpUampZcFlQaWZ0OVdaUkJlemlUOUsreG5hOUxs?=
 =?utf-8?B?TkJkcUJEZ1RXUVNXR2RQNExDODR4Qml3QnZraG0zYVZOSWl3Tnh5QWZzdWJw?=
 =?utf-8?B?cWRYaUozYm84V2hOOXJlamxhck44UmZ2NmpVaitPTXFlMktFSTVTR1BkdHJW?=
 =?utf-8?B?K3NHajNyTG1BTEc3TG4xbi80blJST2l6QWU0T0tsRnl5OEpjQmtEbUlpWGVv?=
 =?utf-8?B?blVOWU1kMlovU0M0Vm5WaEJKTFV2Q2x1aVNKYXhGOVBVQ0pXRmtPZVZGemxB?=
 =?utf-8?B?bEVOUW93cWJ0UytOYXJVdlNrZnl2ZEZQN2YybnNNUFc2TDJ5ZHVDWDBsYmJn?=
 =?utf-8?B?aVptZGVuOVhJNHV3c29ESFBFM1REMFY0WWo3RG1zaUFUVHVwYTdCZlZ6QWlk?=
 =?utf-8?B?ZUNjQVpXM21HWENDSnFUMUcvUjI5NVY3c3AyVDNiTFBZOGNicEoyUy9Cbktw?=
 =?utf-8?B?cXE1Y0FyNGw0WC96L1pud2tiMWhJekpnaFNVTEh4eUc0aUJTcjN5Q0Q3ZkRo?=
 =?utf-8?B?cFd4UDI4WG1jT1BKeFhCcUxWTUFpZTR3a2MxVTZEQTJpS0hVZUNTNkpyZGl3?=
 =?utf-8?B?MEZIMGk5b2R1d2JHK0pkOHB1a2dMSURBamF0WUJMUmw5N0dBaElLRXhhMXpk?=
 =?utf-8?B?eXpYbUtsYzhyaThobVJKclFpQVcxWmg5U3p4bW9qQ2l2cFFjZGx1QlBobGRV?=
 =?utf-8?B?OWNiYWErR2tSRmxjSHUwaVA2SFRCeGhQYmwvWFRTRHk5aVMxVlJVVHFTc21x?=
 =?utf-8?B?VzJyUThHSllSNXE5VXRTVzNXRm5wS3c5ZGE4WjZhUThDUXVJY05Wbm5qenR2?=
 =?utf-8?B?NDdkaVAwb3hXcFRkVzVCR01FaEdFQjNRNVJMdVB0N1JFRlFsN05XMysxellW?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bcd623-ab86-4f93-8d48-08dca13ad549
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 23:48:43.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9watVvhrrVYdHNYNmAwjjdabbzr+mkm2AeOt2dsuLIAblNcLcUscZfo5eLZlGnj4iFpkPoxEeQbOjdXb+TzypfztX2B5TM71VWGC104W0Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5167
X-OriginatorOrg: intel.com



On 7/9/2024 12:58 PM, Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> The amount of TX space in the hardware buffer is tracked in the tx_space
> variable. The initial value is currently only set during driver probing.
> 
> After closing the interface and reopening it the tx_space variable has
> the last value it had before close. If it is smaller than the size of
> the first send packet after reopeing the interface the queue will be
> stopped. The queue is woken up after receiving a TX interrupt but this
> will never happen since we did not send anything.
> 
> This commit moves the initialization of the tx_space variable to the
> ks8851_net_open function right before starting the TX queue. Also query
> the value from the hardware instead of using a hard coded value.
> 
> Only the SPI chip variant is affected by this issue because only this
> driver variant actually depends on the tx_space variable in the xmit
> function.

I'm curious if this dependency could be removed?

Otherwise:
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> 
> Fixes: 3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX buffer overrun")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: stable@vger.kernel.org # 5.10+
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> ---
>  drivers/net/ethernet/micrel/ks8851_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
> index 6453c92f0fa7..03a554df6e7a 100644
> --- a/drivers/net/ethernet/micrel/ks8851_common.c
> +++ b/drivers/net/ethernet/micrel/ks8851_common.c
> @@ -482,6 +482,7 @@ static int ks8851_net_open(struct net_device *dev)
>  	ks8851_wrreg16(ks, KS_IER, ks->rc_ier);
> 
>  	ks->queued_len = 0;
> +	ks->tx_space = ks8851_rdreg16(ks, KS_TXMIR);
>  	netif_start_queue(ks->netdev);
> 
>  	netif_dbg(ks, ifup, ks->netdev, "network device up\n");
> @@ -1101,7 +1102,6 @@ int ks8851_probe_common(struct net_device *netdev, struct device *dev,
>  	int ret;
> 
>  	ks->netdev = netdev;
> -	ks->tx_space = 6144;
> 
>  	ks->gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>  	ret = PTR_ERR_OR_ZERO(ks->gpio);
> --
> 2.45.2
> 
> 

