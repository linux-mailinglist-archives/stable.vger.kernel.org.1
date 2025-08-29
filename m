Return-Path: <stable+bounces-176677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3043EB3B0BC
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 04:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B0B1C84A89
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 02:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3149211499;
	Fri, 29 Aug 2025 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFjPKsh3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C66519F48D;
	Fri, 29 Aug 2025 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756433325; cv=fail; b=Lths36iINRfUqp41unfIKZLVs0hQRrfqsAFMpQKt67om1WYJ1PSwW9jwChzCykhWQQ7KKn09QKR+Mwx8utBY7iVkogZWVL9RKRPCEfn+8HD6lCZ8fM/Iyaz6KsUn1DH+uAD0BPYtMpzjoyFKlryoHxRO/YvRPZFgbUweicaeTow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756433325; c=relaxed/simple;
	bh=y+VzVsZOvRSPHMFExDZgmvybPFlpXFhZ3pzDOPPpfmM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q2UfhZmbLHGnsIA7eIvEvJ3dmNHSTyVH4/OABlYWu+Xic4ds445jIiEGECebouMQ7gZBjepnsVsQe5/mBeAzJ62CBiMGHM699sUlvI201F0C1U99LPfmjnwWa2Fcn5rpCftKux57ViPdxt3mfWIByhY/yDcfP/HR4XkG/qEYgO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFjPKsh3; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756433323; x=1787969323;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y+VzVsZOvRSPHMFExDZgmvybPFlpXFhZ3pzDOPPpfmM=;
  b=SFjPKsh3XlnL414PDMD+o8KFJRNsSw7VHHCc39z3ZSPCVuuAIqI9GaVy
   jdTo1XDf8czNoOM1NAewhDRfHF2y+dItiG3R/OiEeFc+v8nES966CzejG
   ISoCWlzh7Z2y0CpHq3PRgeY1jPm6+m/o+LpGSYcc+73dnGer9lFwIR4OO
   LVddRtbSNVK+VXbb0leL6prj6K6QzMI12wFQ9RqoY5YZzzEvFlg+k5Zmu
   fgsVy7yNcZBX/eM6EhxIVd7D8Ir2GhtXKJEwWi+kbdD/aNg86VWP8puWb
   P7I/lbgReJmbrJn5fNICY9/mfnhmgxYZ6Lq+PfLbfDez8niLAuQW5u4tF
   w==;
X-CSE-ConnectionGUID: Tu2VyGtzSTyczeVCwpZukA==
X-CSE-MsgGUID: aIf1lWe7TxiVMcqG+icW2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69311755"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69311755"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 19:08:42 -0700
X-CSE-ConnectionGUID: hfv50E6nS9ysdSmSlGf+0w==
X-CSE-MsgGUID: vM3DQ+iOQvG+hK935+Xpxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170652098"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 19:08:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 19:08:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 19:08:41 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.68)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 19:08:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiYYk7xRYpC2dsugiJvrzuV6baBvkUGpF5TxSuw7drr7vRh0HkS4ZNu/SQfK2LYxkJtJoi8mxzsP0oksWePM3N1YCR4HlziEHTzpHs2mG0Fts8IOKDtpy04ABsGcR6lwDCiviqiFY7rljB5j6Rna4G9Mu8v5HN3/DAkPZX6OQlNE/53vLBnLkO2gaKmK4ZjG7JKttAPnMpXTCIAHZ/FuiPQPBatHgVvmtHSJbGZHqRuaMsgdF4ehzI8zi6wgsCb5rXs9BpTS99x8Z+iy0I6VCDs/O+2IOA3bmtaJrKYdWj8ntGXU5YQZU0vXsILJvo2hujUnfa+box+3vdHJDFc6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGeVJtsXXfqwC4R4ssYqVRpn98vwc5MJRAz7e8GYPfM=;
 b=j5r1LhYOy8yB0jq/YTVmFV9VsJPcK6bzQHWY1orqrcwhV4d2UcSWQZNDh7Rs+7F2zg67Lp5+xduDVqteiR9x8g/HB4ySJgls1Qc0by4yChohYUAZHH/R0PldUiyHzPz+lqxDvmiiag2fUbXbSSO8mTUsm9vk5Cp0ptUBNJKRusrP5icNyTyX7aiJE2coAcqHajg4m3YJ+4bBUP90iqtZT9ehkkCuIESILqA01mS0twYgnNHESz1U7sWUX5yxWw1d2Ia6kVYonYwwkWfW4GYRdXMJpjHTT55B6dT+opNLV+rPq7PxPECU/RayEWo5SjqpXSkcHL0ZAx5HByH3beRbEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH3PPFD80FA6330.namprd11.prod.outlook.com (2603:10b6:518:1::d52) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 02:08:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 02:08:34 +0000
Date: Fri, 29 Aug 2025 10:08:23 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Brett A C Sheffield <bacs@librecast.net>
CC: Paolo Abeni <pabeni@redhat.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <netdev@vger.kernel.org>, <regressions@lists.linux.dev>,
	<stable@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<oscmaes92@gmail.com>, <kuba@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in
 broadcast routes
Message-ID: <aLELl3NLlZmgeAki@xsang-OptiPlex-9020>
References: <202508281637.f1c00f73-lkp@intel.com>
 <7090d5ae-c598-4db5-a051-b31720a27746@redhat.com>
 <aLAzki2ObTlTfSZd@auntie>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aLAzki2ObTlTfSZd@auntie>
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH3PPFD80FA6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3a73ad-c2ac-4aef-e8ad-08dde6a0f520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ScHyf4uNtCWqkWioQyyZneeKkVAU+9WosjN6VWwEXxDVJVcV9eb+AQiG8mo/?=
 =?us-ascii?Q?bYjvDjVOo1Dl64oz0hFozBshtpLzcdesLtXQBAzvy4RVAuXiMWkQuf+6Kucm?=
 =?us-ascii?Q?ogKdXex4vbOnTvK9SqAEknXFgqxDhwozwB61EWMU8Pnelpz6uC49v+16rjYd?=
 =?us-ascii?Q?ePwldQSRw+YvoGby4Ug1+28iwNO/gvhv9ppBW3+inrqbQBIQwsU6PKqmKH+2?=
 =?us-ascii?Q?ptUWg2AmmUy32Hm7Ym62pz6cFd2P6bRdMnF0FLs0s+3ChANskuccYZDLNtOQ?=
 =?us-ascii?Q?ZGU0F8f/jKVliUW7RUmIiYYvSNwlUiR7Ods9FAOX5qy+5OOKVFrgHhpUAM3X?=
 =?us-ascii?Q?d4xljIe7RU09ToHuDlLJ5AY71pvTNfZqC2jdq9gUT5pkRYGzfPIpGvjUsF6s?=
 =?us-ascii?Q?yhRArUS7gcfh7UusuJMAL5gre1wes5iKTGEgBkHu7w1uNNP72HLeIrPLizAj?=
 =?us-ascii?Q?gdKnVly56wHhuoqndqisqBUpLGFGG7XeRVFRrDPXTBFroddam3YXQx7wuKie?=
 =?us-ascii?Q?+tn8TmVXhEw0HVqMN+Kb4hRI/usJyaaOuw7kFDaquhAMDXD+apbj0Wkd9jmT?=
 =?us-ascii?Q?IgYcpkZ+iQYN8e5jXxLPQJ82pCneBx/KRHIpe7poiBhfTBGn/4/TYeESMC0w?=
 =?us-ascii?Q?A7ScC0LqGS+N3zFVLs9u9GU2JQ452R1JJ8iPJSYaJNF2CVr8TUBdfobMlBf5?=
 =?us-ascii?Q?3/nsY5Msywt4llpbBQwX/7IwNmZ2sue46ww5P7QLZdgzGFMWbdvjh6Nq1iAw?=
 =?us-ascii?Q?pbt925c3h8+eGZwYSH5QFO6DNIICkDuM572xwFQIyK7qxzpiPI6CtDSvPGb5?=
 =?us-ascii?Q?/EAmLnw0anZX+PVszP6qzo8BgaAZgh3g4Y5wfE3k59W8GvhKRJsaA4+4MFN2?=
 =?us-ascii?Q?swqdYbvS8zaCY8bEnb+B2cbQX1m0y1vyu2QUTwrnd3ZhnhN9E2BnyJR/Sz9b?=
 =?us-ascii?Q?OgNWGgjsaB+hFJ0/VPiFHNeejMyeBN/ckH8R0Q+rCHeOzsglRCs50qF5O+gO?=
 =?us-ascii?Q?ljNmNMr+tYowkbojhA6a9uRG4JoWT+2qwVDeTH4udpA9WWnYmxJuQ66Dg3Bq?=
 =?us-ascii?Q?Pc+JTf5Xcp+VbMnqgUN1PVYbNTY1hToewJB3MJCtClr2hV0rrUOcvy6FgIm6?=
 =?us-ascii?Q?KG9rD24AWXuae+urfQeUrC0SzpNp8gTO2qH+ReK1MVTN0MvK1p1z5goebkn0?=
 =?us-ascii?Q?Hng2zu8mZp8unDHsU5YMPg5xagjdLj7Cieq6xZQgXzInACScw4m/CGa97dqS?=
 =?us-ascii?Q?9+bHwv+0jdTNv6AF9/hMS50yTwC5qd1H0x3ysElZZW4ym5ZT7OlV0OahNmXW?=
 =?us-ascii?Q?Abqmmz6UGLOcU8IxiQkwCVDU5o06hbEAWaugASSFc730xCN3QNKxM0E6i9+E?=
 =?us-ascii?Q?Iti+H8b59QqzzgH6IJuRgj5i4PXM08t2Bcout587o+crzCPHIRTxjQaVRwS/?=
 =?us-ascii?Q?KsgcSk0LOMY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQFhPLelYTPafta9NcxRG4ayZZVae8hFFPcyepckUsfT/3QL2MlayDsLSsl+?=
 =?us-ascii?Q?1ByS8fYT5kUz5dqZVs3QqrH8KipQ7E8mkAFfwRwz8sJDe1J7XztIwcuHK/T0?=
 =?us-ascii?Q?8ntnwPHMKndjsodPS9YZL7NAv9896OMwVs14ao6qC0jF8Al9MKgSIbGAHT5/?=
 =?us-ascii?Q?zdIBGnKQ0dmlpl+JKNjvtgGhkyn5qDAhQttA4wpOQbKYPcED1OTnxdfQ0s7V?=
 =?us-ascii?Q?SzljynA4/E+yd/8pzBcLXuBtAj1o+NlAjYxQpmekrQaWtKyyabNtU6ZdqOyQ?=
 =?us-ascii?Q?gLUA1JOxxLhvteWikHF/SWqeLkVym0ccAyg66TlBM+no7iACXvbUn9Z/4EmY?=
 =?us-ascii?Q?JuEoGXILYOeE+xrOMg3r5rw8FFC3ZkHmCZyuz8UB/AD1+xvbrD/NtfeMZJMN?=
 =?us-ascii?Q?D2yJISChyKUq3IrS1QDdMVSFXg1NRMD1OmaET7S8tvoIiyCYedqTsOiCsDsm?=
 =?us-ascii?Q?Oyb8egxqvR47Y2Vsvp2nlPxf4+qY2smuPamqTnqCGsWHUuGdiuicRZddoh4v?=
 =?us-ascii?Q?EHhfo9G2ts0IL3Xj2jojritJ7b3xZJ/VGlCEd55rr2cyUvPXIw4KEhr3+1us?=
 =?us-ascii?Q?2fbD4dWPm6iHY82wmbQaVGHlYV812DliXJxaouPFCYSbojdkVn0kpImWxakB?=
 =?us-ascii?Q?P9ZIOVda9XzDhbqWIN7Yt0d+F/HDGPFfcRCMGTHiBTjpwAJhl4k+6uSvxytL?=
 =?us-ascii?Q?f0Z7kac9lFuYy7nLYoYARKWeN+T+3CIL+ads3r4LH7aPHavA7UbG3dwk2Wpq?=
 =?us-ascii?Q?Px3tLXJSrv+PbnIMe9lLguFCRZ1u+jE1zYc82Dj5kvhZ+o+cQJTn2Bj/WGUf?=
 =?us-ascii?Q?pYIDjT9sr14khZnh9j/+9JdBO9BUtJiN8u1Utr6OwrCfbUQwj4U/h8nv/ohi?=
 =?us-ascii?Q?y+ZXyudXaftpp+uEz/mdw2lb9W0lg2YrrM33tK/V68FrF9AVLirCb25eXEsr?=
 =?us-ascii?Q?BACzUz6x7b6zPwKXjWAdaGL8f3bISKstiKti/girhriVf5n6D59rhIt1sKer?=
 =?us-ascii?Q?wPXgWqH7Z8LwsWhDd2Vfzxbt4YfrM9/NdyXR2lDzOnb/OycGBeVYpgLztB6m?=
 =?us-ascii?Q?CTqSngmpJdwNfLb7huYJVSpej8ipDNw3zk32tOeHrtGbWFuyobQffCPphYmN?=
 =?us-ascii?Q?RvZgBhqvdAmBzo2L+auPjyuDB4Lpzt6VHfLz26lD2lK+9mcXNm+d0cOdzwnM?=
 =?us-ascii?Q?miiETWELF6cMg3H5cDpjpm7ab5NHHZ/+8DL07YYKvirQtLNNWQLlCpF3z5Ew?=
 =?us-ascii?Q?ekjHQBRR/EzvVAGgxt0XJJIj2C263I/ypHAwQNB7HTWUa1apgbp7JBukQqRZ?=
 =?us-ascii?Q?tSSpOmwKInc3/cDG/4SA8B8OSpIc8S8Pmi57qBJyE8dtZ1L2rt/huQ+axMgQ?=
 =?us-ascii?Q?35wVqq88LIt0kNesP/v//fdc7SaJJnwshGD7trbWfE0YuVYQnWgQV8NewI9Q?=
 =?us-ascii?Q?l+hVIYO13YLLbyOAXieqH/7TVgmk3GK0fZ1tC+2P9qT0EiQC86wtZE+or6Zl?=
 =?us-ascii?Q?H6QrlCitnjl7ebr/m7lTgza5tzM2QCgJoB+3HayYlmTfcMFGvhiYOklNtA+i?=
 =?us-ascii?Q?0PtPNWsIvqsTUJckvLh6rYI2/PA+AgKGrcYQTSoU83KJV10iZ5YERd+4nl+0?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3a73ad-c2ac-4aef-e8ad-08dde6a0f520
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 02:08:33.9315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtostEE1RwAE3ZSiMQRjung9Ed/USQWb4WJyO/gKH8t4T4UHdU354uK/S1m5zJQ4Ol8bbR9jzkbt7vQImWaO4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD80FA6330
X-OriginatorOrg: intel.com

hi, Brett, hi, Paolo Abeni,

On Thu, Aug 28, 2025 at 10:46:42AM +0000, Brett A C Sheffield wrote:
> On 2025-08-28 12:35, Paolo Abeni wrote:
> > On 8/28/25 10:17 AM, kernel test robot wrote:
> > > commit: a1b445e1dcd6ee9682d77347faf3545b53354d71 ("[REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in broadcast routes")
> > > url: https://github.com/intel-lab-lkp/linux/commits/Brett-A-C-Sheffield/net-ipv4-fix-regression-in-broadcast-routes/20250825-181407
> > > patch link: https://lore.kernel.org/all/20250822165231.4353-4-bacs@librecast.net/
> > > patch subject: [REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in broadcast routes
> > > 
> > > in testcase: trinity
> > > version: trinity-x86_64-ba2360ed-1_20241228
> > > with following parameters:
> > > 
> > > 	runtime: 300s
> > > 	group: group-04
> > > 	nr_groups: 5
> > > 
> > > 
> > > 
> > > config: x86_64-randconfig-104-20250826
> > > compiler: clang-20
> > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > 
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > Since I just merged v3 of the mentioned patch and I'm wrapping the PR
> > for Linus, the above scared me more than a bit.
> > 
> > AFAICS the issue reported here is the  unconditional 'fi' dereference
> > spotted and fixed during code review, so no real problem after all.
> 
> Correct. Jakub spotted the error, it was fixed in a v2 5 days ago, and has since
> been superceded by Oscar's patch, so nothing to worry about.
> 
> Is there a way to indicate to bots not to check superceded patches. In this case
> I'd have though my v2 would have been a signal? Is there something else I should
> have done?

sorry for this. our bot failed to recognize the mail structure to spot out the
v2 patch.

we'll consider how to improve it or be more careful while manual check. sorry
for inconvience caused.

> 
> Brett
> -- 
> 

