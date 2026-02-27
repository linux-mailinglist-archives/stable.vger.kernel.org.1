Return-Path: <stable+bounces-219938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODjpLTFioWnIsQQAu9opvQ
	(envelope-from <stable+bounces-219938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 10:21:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 129A11B5371
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 10:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82325301E3EC
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 09:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D55C3563E5;
	Fri, 27 Feb 2026 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cd5eNvP2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC4231618B;
	Fri, 27 Feb 2026 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183794; cv=fail; b=V/2aX3Qs76UAn0rmIiLukLBcuBFovJ44yRZdgDS49gQFAD3ffKScA6MWMPCBJ+tiURdh3C1rwjiXzdgHOLLRUHj9E9GUZ6/KrNjB72zEKxbuF1+GrJyIeDX36zzyPjVQ9ovTLJKtXwigmx4k1MgfoyvCe0hlNE1paDUYGgEmDHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183794; c=relaxed/simple;
	bh=JxP3R9JAyDqc+Tp0PbNAnGIxQ/x3lsnnkBFbH3B3PKU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uIg6Cq9nXNzXYuipFNidxA9bc5XASNlFu517SyaIsGzG5+AuhbwKdfRaynStoML092lKx6Zexf3zKllPWprXGUN+ctR5EWO2WT7x7l6zdUjm44WphH6PAP3U8q9SwKfl6jelC9z+oGmDztpteqAwteuTGpKsTs6ygu1h6GqBu1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cd5eNvP2; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772183791; x=1803719791;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JxP3R9JAyDqc+Tp0PbNAnGIxQ/x3lsnnkBFbH3B3PKU=;
  b=Cd5eNvP2dezphdvTvLjJIITbdT5ZGbbkCgCVrSBTj4s3tM1r5Q9do9Zj
   c5IIZBazvPQkqJzpYg1jsDTvoxK/0vwiA2Hid5Brd3IiPQcla6KjxqjYH
   bauOXRoIi+XtHJ8Iev2h7XC76Ikes4xDDThOImzxBUEFm0zHG8QSUpU2C
   BtccOy/LZcLMBNbRzgzMAffAGJhg90vcieT+b4YR1QWuNMWQ+c1jqa4pg
   RHHcFECQdZpfoQK83l/nzUlXResaAsswJKsXzqTPnDO328ZjF71REqzA0
   ldTPGBM0WE2nlQzsExxBvDP6RW8KK+esXZoWeFApo56tjNDHxaE5diqQB
   g==;
X-CSE-ConnectionGUID: ZPR34+wVQHSQr9Qsnx+qTg==
X-CSE-MsgGUID: ql/w8xq2S/+8nS+ufBe2cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73231621"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="73231621"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 01:16:31 -0800
X-CSE-ConnectionGUID: Pg19nqMlRfeThL/LZ3IlKQ==
X-CSE-MsgGUID: B97QlnUVTxiQmLOJmdawFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="244257690"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 01:16:31 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 01:16:30 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 01:16:30 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 01:16:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3QXmD9GICp8ZVaWhtxJznoCDl/1PJ+RUVnGnyDQ3AVq2RzuTLH5l6d+Jk2P2ESwusX9U1p9KeL8UNTMGX6u/pe7PLLNICJrRb+gK3FpSP2JLgiRvQXBdlS5kDD+RQG4eMauBEvnZmFOiifXj2m4q/1gWsbk368hZkgIzz1MSmlhke++ogvNwLWfJXdyaeMf3mMb9Ds5OiF+oxm23vOeeJlgj7DxzCzNQEPxZSfYbooaxLSl0kfsguGC4hQYX3nzBUQlj4faoDo4XBG+ceAItDLnkpbKjgzfZ9vrTbSPAGY+T5fOzwjwb1Z2z9cHh4OB6mZNztqTFBkioRR5/jHZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU1chBaqvi2aj9n8tWoOUqRVvs9x/ffUMULCUlJ0MxM=;
 b=gZPsoSdrYyMXeJb2q/STD+CD9NeHL5UpX3hBTjOJ+m8g5WiJqxSuIQdKmmOQ4nQWlyLAhHYEy4cngL+85eY4SXl0zqmfG3VnC4/ICqvLRsi9gWjI2cg/Ck2T5/tAWZcZH7Rcx2wi9kda601dpgmIf2eFuMQN8qpBKUlpC8ZxUuQmFI5dA1OGhfxIidl5zceTiRCTQ5Tv3px1uTKHRCP9xe7XtALmTCy0cR8SeqkwtS8NysvuCl9yvxxqOq7cDZUD9AJ1/MNT3uBUUN3GOgS64o0vUFjqWSpAEiEToJFV8ZP/0ODS22NIqn0ghslHEO/5XtEdPUrHhtVB1IFNz6nnXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CO1PR11MB5137.namprd11.prod.outlook.com (2603:10b6:303:92::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 09:16:27 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 09:16:27 +0000
Message-ID: <1e71a22b-48d5-4a5f-87d5-860a6cb9a04d@intel.com>
Date: Fri, 27 Feb 2026 11:16:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
To: Matthew Schwartz <matthew.schwartz@linux.dev>, Ulf Hansson
	<ulf.hansson@linaro.org>, Ben Chuang <ben.chuang@genesyslogic.com.tw>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260227075909.3860183-1-matthew.schwartz@linux.dev>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260227075909.3860183-1-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0282.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::17) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CO1PR11MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce561ed-ef54-48d1-c402-08de75e0e2fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: ZncpymVSCWE8OF78u2skpmCYYsLhb92EkPVY9s4MpUBsoy8aic73L/QiMNW8F/We+Rtnm8XwKoAG7EdTqDV/4BnHbEJkJYT3wTd32DwiuOPzD4gopkQFq9C6yZkvwAxw3L57Du/8g4GyCGssafTbs9sBw0KI5cQxZZuwvBm99k1DFKjKUmtZdAHDk5vf5go0CEonIh9bAHx5O0C72P/3CPudOCbjo/MJDIGsCU/uOcGiZ452gQJNLB1HskZX36fd3giu+yrI2VqCbswZUzX8+FCAoxdpHjFGLk+4pLRH/60JGI0NwUVbJl+J4zvgZqsys3Bj8l2tmR/iXbTiO+fCLXMsIt9+L85kqNivQ3Y57DDzKDnzapEAOWTKKGQ1gAu1gkHqDwfUoUnlc4hHmk4WnDzBYfq0Q6gpFxmI0i/oY32FWDwfna9SHjD2DOtvHsbkxKyQ9FfKZcPmzy4T9Mpe7I6Oz/pEI1K2K7X1N/Fwss677qccQuqINRimdd27kmR3x4DMMYqp++71C54H2iJStDAPypgC5/itlSvG+f2CKjRpsa+Q+gLs/cqYeIbJyNf/BvDny58G0QcludaWIMzJUGZZAQuuj1yz/fTHOdokgW9XhuMnOZ8ZdvC+Rs2jsfOBBHbFwJG2oBbKjR5iIx8fLVvH7tuXKRkebXki3FWfTBQJDCIZeJKaR0CLQliHcRx5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2dZU2NhclVTYzRjVlhtNjBhMTNBWnZyei9XWDlLYURiQllqL3Q1QW9lL2VS?=
 =?utf-8?B?SDV5QUpNN2xTc2xtYnNRTU0vMFBWeW0wTUZQekNhckVheXRpdkJPWE82Q3hF?=
 =?utf-8?B?MlNJR29Sa1FRNmlKMXhtUkk3aG16WVo2dlV5TllXbEc4N2xKTCtjMmR4bElo?=
 =?utf-8?B?OFZqVEd6ZWtab0hkaEx1SVJDZW11d0s3aERXdlRrSFIzTFkvVXhoWTNPNUM1?=
 =?utf-8?B?Z290QzJoblc1b2hYOEtadFRIMjNaSnhTTFVBTUhxTTdBQlREZXlRR01DNHNP?=
 =?utf-8?B?N3NXRGRoUmhlSHo4bjBjSmZNOUlmbTMwM0JOL3cvNjhNTlF4eGFCNXBYdnl6?=
 =?utf-8?B?QU9USlpPK3ZzOGthT1pCNDNoVHpid1RGeDVBb2pMMmo3ZThiSG9QdENUbWp5?=
 =?utf-8?B?aWcxNkRXVkh4djhJNUpzZjgrUjlCL0hoSllGTlp6bERVRlZaWnlEYmRsSlYy?=
 =?utf-8?B?bWhLT2lMTmlseWlmUFFyRXBpaDQ1UzRNMjlvMU1CbGR4TjhiU3U0MzZSVEMr?=
 =?utf-8?B?TEh2TzZNcVJxRTdNMXdlUTJSZDZqY0lIK2VwVWU4Y2hXOEpNSDJST1hOMkow?=
 =?utf-8?B?N09HSHRLallobHdCR3JLRXphVUdWdTNQNlY2UEJ6SlNKZk9xenJZYllPYzZC?=
 =?utf-8?B?MmwxY3RDaHl0K3djNkZpK0xNNlZTQXRqdWtNdFE1cXJiSjJTcjlhYWdQUUhp?=
 =?utf-8?B?Njk4QmdhTVUxOEd1cFJVMXZKUmp2ZCtna01seXdGb1ZqN0MzdEJwNWI4NFUw?=
 =?utf-8?B?QlFqUGFicVVnSXFwa0R6akQvcTJkVW9UTFZ0N09rL25hWGJSUzY5ZGhkaTBa?=
 =?utf-8?B?UzQyUldkWHRWWkRIdTFLVmhhR3pucFBMbXYwNUpnRzlQU29qY0J2bm0xUkJE?=
 =?utf-8?B?dXNiNFIxL1RtRUgyRmdLcG16UzJMVzZyY0JJbFh0eWZjcmtKc2h0dnhMbitJ?=
 =?utf-8?B?K3RGRzBHZjBaK2t5OW4waWFZK25ndGVBVHJaOTdlTWtyU0JrODAxcGRSMjRO?=
 =?utf-8?B?alUwR3pTUEMvWmZicHd3ZmZkY2RobVNNYTBhL1pubUsvYW1jOGNuVFhRc2NP?=
 =?utf-8?B?enYzcndvSmVpTTZPQkpTVzV2Y1R6N0JKK2wzWVhTdWJMUzJteDF5YUpyUG8w?=
 =?utf-8?B?UEcyRkN6QXFZSzhKOVlYY3daeDJiK3ZiRjFVNDkxNmJlWkFZczNCaVdNemZW?=
 =?utf-8?B?MkNiUzhjSkZtRkJLakJEQ2Q1UmlacUNFb3F6Vjlkb3hUVGtrMkRlMmNXVExq?=
 =?utf-8?B?OU1lVEMyUE4wVDRwb25QUHlIOGFMbmFYYmZFbm5iV0hYODQ5MmlGU2R0T1FO?=
 =?utf-8?B?dDhxTERXN0h4ZWx6WjhJc3p4dTNndWtzMzAxZEZwVDIvaWhYVzl5M3J3cndz?=
 =?utf-8?B?NXJRSFpiWVhlWVk0ekwwMjJCNnFqODJlNWhqTlZNc1BsdHUwdDRISzF6N2or?=
 =?utf-8?B?aHhEQWVMNE50YU5xWThhVnZONFI1Uk5nODhmYlFIZU9NOXhLUTRwWDUvem55?=
 =?utf-8?B?TlNvYVF3OGFBcEtGdUc2QzZ5UkNIeDRUYTNmcVNFZUZRZGVsMEE5VWtldkFH?=
 =?utf-8?B?TS94NGFvbGxzblE2MFRaRDhnT04xeEJDb0NxYWJET1MwVVh2M0FoL21yR2ZO?=
 =?utf-8?B?NU1zaklFUTZocmRuQU1lTmhDQjFUckJLT0JkSkhaWHBKLzNRK0RhQ3RIakty?=
 =?utf-8?B?L0pJQ1VPQzd1MkppRjJKZmhMOUdwb3YyckJGLzZzYWFnSkV1WXE4c25QcWVL?=
 =?utf-8?B?OWJ2NXh1ZTNmWkxNVTgzOVNGOWNpTlRTOHFQbmNCVG9yNkxLa0JGQWw4OU9o?=
 =?utf-8?B?bkxFZDJVNzZiQWhSanBGaWpsRng1T1dkZzVwNjduNW5Zbm4wZlNCckI4YnFY?=
 =?utf-8?B?M0JHckIwRE8wL2JSV3JDWE9mLzZRajhVN1FDZ091R0c1WXJ4NXNhTlZtQWda?=
 =?utf-8?B?MlU5OEt3N1FXeDBad20vMW1FMytCNStzdFpEdFQ3WFNPejA5dE1NYTlERjBN?=
 =?utf-8?B?VDJqbitoYlZPSlVjalIwSkNuU0krazNJL0FtY1JTS05PTkFoZ2diOW1KMWFO?=
 =?utf-8?B?NWIzTXRIRWZML1M4aXN5c056OUpPaFJ5UTJWZHVpcDRGVUxzWlhjVkQyVmJh?=
 =?utf-8?B?MVFMcnJXMEF4amh4bms4bm83bk4xZS9WYzh6VlBmMFJWS0VySUtGOWUzd0Rt?=
 =?utf-8?B?d243b0krVFRsNzg4Z3ZSTTVPSnhFUXhjQWlveEZOclllQUhKbWc3VUpieUZT?=
 =?utf-8?B?OWNUcU1UOERCU1hzQitlQzNKcmVqQnRQYlh1V2pmaXc1eGZPQkYwYkQvcXEz?=
 =?utf-8?B?STVKdGkyVWRxQTVFYnJhMFBMWk5GTEwwMkZRYkkrMitNTy9GRysvNllYWmVw?=
 =?utf-8?Q?SAx+T0cl81TsfnO0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce561ed-ef54-48d1-c402-08de75e0e2fc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 09:16:27.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9w+AgZ3DSlytDZPviaeVEDPnqQOeNGGUc2tW6hFekR2ZJi3nFMuelrvgYJ7EohF4dRZIb73McsePkvjs3on9Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5137
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219938-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,linux.dev:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 129A11B5371
X-Rspamd-Action: no action

On 27/02/2026 09:59, Matthew Schwartz wrote:
> The GL9750 SD host controller has intermittent data corruption during
> DMA write operations. The GM_BURST register's R_OSRC_Lmt field
> (bits 17:16), which limits outstanding DMA read requests from system
> memory, is not being cleared during initialization. The Windows driver
> sets R_OSRC_Lmt to zero, limiting requests to the smallest unit.
> 
> Clear R_OSRC_Lmt to match the Windows driver behavior. This eliminates
> write corruption verified with f3write/f3read tests while maintaining
> DMA performance.
> 
> Cc: stable@vger.kernel.org
> Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x support")
> Closes: https://lore.kernel.org/linux-mmc/33d12807-5c72-41ce-8679-57aa11831fad@linux.dev/
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>

Ben wrote "So I think your patch setting R_OSRC_Lmt to zero is reasonable."
Can be have a Reviewed-by tag also?

Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Link to RFC: https://lore.kernel.org/all/20260117234800.931664-1-matthew.schwartz@linux.dev/
> Changes from RFC -> v1: use the proper name for the register field 
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index b0f91cc9e40e4..7a7be3f7bee6b 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -26,6 +26,9 @@
>  #define   GLI_9750_WT_EN_ON	    0x1
>  #define   GLI_9750_WT_EN_OFF	    0x0
>  
> +#define SDHCI_GLI_9750_GM_BURST_SIZE		  0x510
> +#define   SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT	    GENMASK(17, 16)
> +
>  #define SDHCI_GLI_9750_CFG2          0x848
>  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
>  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> @@ -629,6 +632,11 @@ static void gl9750_hw_setting(struct sdhci_host *host)
>  
>  	gl9750_wt_on(host);
>  
> +	/* clear R_OSRC_Lmt to avoid DMA write corruption */
> +	value = sdhci_readl(host, SDHCI_GLI_9750_GM_BURST_SIZE);
> +	value &= ~SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT;
> +	sdhci_writel(host, value, SDHCI_GLI_9750_GM_BURST_SIZE);
> +
>  	value = sdhci_readl(host, SDHCI_GLI_9750_CFG2);
>  	value &= ~SDHCI_GLI_9750_CFG2_L1DLY;
>  	/* set ASPM L1 entry delay to 7.9us */


