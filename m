Return-Path: <stable+bounces-212681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF3dMdSFemnx7AEAu9opvQ
	(envelope-from <stable+bounces-212681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 22:55:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D20A94B1
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 22:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F296301828E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 21:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE4533C19F;
	Wed, 28 Jan 2026 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZbG4Hwu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3888D281341
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769637328; cv=fail; b=jp5W0yiM78r/1oNKWqb/I/Cmzs6uzZHhShdL7lU/gU/YLz752foB7Lg1eTY8WwOTK4KMwkDBGDwD0LW+RlcsW28l0KRCOOUmjdjHu5ITW9jyrLKd0pTjQineKZgPCO17fqC0i9vWD/VJGKnjx19yMDUxF53E5j+Mzfhs/D7zl2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769637328; c=relaxed/simple;
	bh=8qAqFmhFve2BuDEz3iSMosu7IWxcZ1jJu0qEci3anBo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=huAvgSWNO4exQMM/tSB8nsjK5OZJcEnrl3OcsiEghvaw391slUs0H3VWjhXwcE58OCNBgf3a3n+fzVNAqS3btKVEKu0uA+BLA0aljZKAsrcwl94esCPD90wu8w89bjDNqoZIsagatYKJPcFfcpSd7KRHsjDQWOCN8/AB0NggUjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZbG4Hwu; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769637327; x=1801173327;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8qAqFmhFve2BuDEz3iSMosu7IWxcZ1jJu0qEci3anBo=;
  b=ZZbG4HwuJ8K+JqdUDACZTET2W+LqxniEWEmBsCgM7YeMnACJ4ZaFRFVC
   7X5uMdY2ArsTyExWW7Pxz0GU1ib2haWtMoA7ZT3JwdlQCKCLP/lk7UEml
   VOSZrt+TJTXj0MNd6FvdLd0yha/TudJjjcua8Uuu9JMOMa5hP6hjUn8gt
   xQEIdNZeWIlSn1qp099XGkTafE8JFZCJiMac0OwYdj9GilwY6FbI1iM5h
   sM/1Ql7/Xrr8LP6rx116R8KWF3NuPRXzoOACUgDEPE7AkF+dQ049rM5sy
   y5hTaxQ93GxHfcgY/9WY+UML6FyhdXDlRAy1YzyiXvxoIMlUaaK4Mcpi7
   w==;
X-CSE-ConnectionGUID: E1tqrOvmTYWpJQ1jeVuuVw==
X-CSE-MsgGUID: Yn6oY1/vR9CyVXiCEEvB+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="82289389"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="82289389"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 13:55:27 -0800
X-CSE-ConnectionGUID: ZXzEgnaaR7yO+OucmLYlUQ==
X-CSE-MsgGUID: JKoZfVKtRZ2jki8HD/npTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="239123358"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 13:55:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 13:55:26 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 13:55:26 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 13:55:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItDT3qLhvM77xbsr0QgWZFrvd/3p0ZwE0QH7VGii4OiqAiFOffCs8TVXa6bYZ3nutseU2l28tH66k9BMLQFKwprTyzzLYFWh4q2YlJniVv1GDPOSfgunfzEmXW1Bv+ux9iL0EJ3frsD540Chg2rryfCRWhAdkvuVzuWM5rcQlAaUQA0w6eu2CCXa112LruoeGp1MmwS0+W3qbiyMyuKxOHfVANqt00EeXSKvZW46rtnp0OkFeVy0IdKJOzJa07d5DJyIJA/tmCWK/1jrPeIBvnrWnfyXfxRwa8/s+B2vw8iOchY8ckPagkpeG+IZ0sWgd9Kt/RYBfO5gnRsYoZV1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hQ9Ij6Ec0x6oHA5NPNxnhKhOSIkRV8JL8/z3CE54oE=;
 b=gbl+d2SjT5q6LLCvfUdLy1WDlnrMsZRQJPirIoMWKbSkRiLTg83nAcDXRk+MCQck0JcFovk+PMbYTfHVNLqoFbI8y7YuC9Y8ZgyPU3t5ktbg+KEA+P89zVCjGX3o0OSX805y3a6ryB5/YyxNcdVT2V9PYkGJxG1SS1QJ7L9uHCvkq7N/C9cnkZgZR57WdUmMSmbBgOzIYhmXbAan5uSfzt455blu/pgFQk4TBsNRCEg9wMiiYT9xrMcufj/u2lkSc22CuJYX81HMrmDeTiu9nBI2B3ymB9cDzKStMb2KtdfGjEpgXgLP4pNG1k+ujtYWEETw/WyFUHAbavGpankutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6)
 by SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 21:55:18 +0000
Received: from IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::b6d:5228:91bf:469e]) by IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::b6d:5228:91bf:469e%4]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 21:55:18 +0000
Message-ID: <55663496-af72-4a9f-8d4e-75ff88016f9e@intel.com>
Date: Wed, 28 Jan 2026 16:55:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] drm/xe: Trigger queue cleanup if not in wedged
 mode 2
To: Matthew Brost <matthew.brost@intel.com>, Michal Wajdeczko
	<michal.wajdeczko@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
References: <20260127170455.618616-1-zhanjun.dong@intel.com>
 <20260127170455.618616-4-zhanjun.dong@intel.com>
 <0d5a5fc7-10e6-44c4-810e-071c10c45cd0@intel.com>
 <aXmE19aGZIjWjDaF@lstrano-desk.jf.intel.com>
Content-Language: en-US
From: "Dong, Zhanjun" <zhanjun.dong@intel.com>
In-Reply-To: <aXmE19aGZIjWjDaF@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To IA1PR11MB8200.namprd11.prod.outlook.com
 (2603:10b6:208:454::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB8200:EE_|SA3PR11MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7853f3-7def-40b7-36d1-08de5eb7ec4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHdOMWtpTUNOdmRwS3dwcksxaVVGNXF1ZmozQWZnbFJkLzZkZGlDaDJyT2lv?=
 =?utf-8?B?S0g1aHFYc2RpSUs1RVhETVg2NFZkL2gyY2cxb3U5TVE2USt2b1crODhCYnJ6?=
 =?utf-8?B?TVJLQUFDN2paN0gvSjNsK2tXOGdseTNjK2d3Unk0QVhXSmx1c3l2RGlmdGM1?=
 =?utf-8?B?VVA1bWh3Qm0wdndEVTBWbnFvMURMNVAzT2FPOStGRmhNOUpHdkdLK3AxZGUx?=
 =?utf-8?B?QTA2NHFuZHRXYm14TzB5VitFR0llV0g1ZlRKRm5kcTM2SGZHVXQ0OUdCNS8y?=
 =?utf-8?B?UmlwcVExYU13OW55eUU4eHAwR0VvRFB1UFV2ckNRTkZJUE8veVJ5aEdhWGk3?=
 =?utf-8?B?aEdtelJMSmUzRVJZdWp1VGM5TElhUDZ4WS9uNHJ1UHBld0tRSEFzTnpWTFJo?=
 =?utf-8?B?ZjVOT3Q3M2lIb3pDVzNyV2pGSHJEMWh4R2VzdUNSajlOTXdTcTFMcWUwb0pp?=
 =?utf-8?B?cmg4UldqTUZGZnVsTXd5UlFBTHkxVC9GTGZCY21pUUVTM2wyREYwZ0lCUFVv?=
 =?utf-8?B?aFhRWmwvbGNzNjFrVnJKRWZxTjNKQkJHRmg5bzNLSGhOcWZYNmZZQjZuL3Fo?=
 =?utf-8?B?dEViU2dsZHdseGJ2VXM4TEdoVUQvbEVtMHF2SjN1dVN6bSs4RW16NmNqcE80?=
 =?utf-8?B?STdHRXdKS0pVeDBoRDBxQ0RDLzliYWw4OFMrMGdhOW9mcnh2M1RsTTEyVi9m?=
 =?utf-8?B?WXEvbXZQNU9XNWFKTEljVEpNdVp5dUs3S2VYNHZUam5LMEk0VjNTTmJDWllI?=
 =?utf-8?B?YXpnTk1DWDlPMjFhOThLNTNUbldPQnBYc0JuMHN4Ylkvd2gzbWlDOXdGMU91?=
 =?utf-8?B?S09XN29icnVpK2xBYlVWQy9mcVAzQ3RmNlpsRHpRT2htNDVwQnpodnNoQ3Z3?=
 =?utf-8?B?YlM5NXAvM1lmMWN3U0NkanFNUVBMTklVdWptSU1xTzRGbVFRZWJ0N2NBZ3k4?=
 =?utf-8?B?QVM3blcrK0tJY0lKSFVNZWpaNXNpOWQ3MG4vczRIaFRNblRWdmJOdUI4ak1R?=
 =?utf-8?B?ZU1xSG11N0lYSEJlWjFvUUdBZ2lFVkVCQ1FWRVN5WFowMmNJNHQyZjRBejI0?=
 =?utf-8?B?NlpRbklSSkRwTW1kVVR6cUdzQ05kQVphSTYrQkJmMlpaaTI3WHZzRmVHemJz?=
 =?utf-8?B?dE9ZVjcrOFRGb3UrR1UvdURmR0o4cWhaZHc3NERJNm9VazZXSTg2QjJhQlFS?=
 =?utf-8?B?eVhqckVId0NhWEZmZEM2TVBSSmU0M1VnOEI2cWRteW4rS2lwOXlNWTFHdkJF?=
 =?utf-8?B?a1RUKzBhTmJIc3hyOGpidDA4eWRQdG8yZW5jQlltUW5Cek5kcXZLbzRzOXo2?=
 =?utf-8?B?cThka3hoNHIzRi9GbEFXUFlWT0RmVkNRZEFvdG5mRjRIUkQyb0dJV0xTaDFz?=
 =?utf-8?B?YXp6MWRRRllJWmVlRTRxSW5qbUM2ekQwTlVkdjNMVHBMcHVvMmlWRXNTR3VK?=
 =?utf-8?B?ZnVaQ3hTK0dWMnNFeE1UN1kwQWI1Nit0QWFiaXlSZk1WMUpJQWk4OUNFMW85?=
 =?utf-8?B?TDM0c3Q1Qlc1WFQ3b3NCWDgxdXRGRXlaNmp1UWVCamtXS1ErU2FvL3pPTmdC?=
 =?utf-8?B?TzNaRmdmaWVhV2l3ZVNvOTFkQ0xZd2NYazJzNFFNRGs0eU56cW1iT1F0ait2?=
 =?utf-8?B?dDlrWHlpaGQ1SzBjSGIyWVlEUC9ZTHlQZC9rM2VpaDlnNjBaY1NiSE56M1FQ?=
 =?utf-8?B?bW5TbU5mSFQ1QVQ2MVQrbWFzbmdLY01xRVJGRHRoN0JQQ0VMTVdQK0h0R25h?=
 =?utf-8?B?TXIrYmhtVGt4WXpFWmtYVVJoSUhLTFl3MUhOakN6ZUthTjU2MWoxdXRFYlJJ?=
 =?utf-8?B?eUErR2l4VlI2ektsbmp3d3BvV3F3MFNrMEsrQ092RERtL0hubkJrYWRieDdW?=
 =?utf-8?B?Zm5mOXlUL1o0dGE3Qk9yNHJhM2NWTVpSS0xqbDJHU2xFb1hEZzNCbGtHYURh?=
 =?utf-8?B?UzVoL2NJdExZV1ZCb1ZoZlpvL1pBeHNJSjE0ZFVraURpdmdPV3BNaW1nZnB2?=
 =?utf-8?B?WGEyOEcva1F2MzRxVGtWUytoTHMvNDBzbDlNNGxCS3kwR0FaKzZpVklMRkdT?=
 =?utf-8?B?aS8rZlZSc0ZlRTdDUGkrZzB1ZitkZzNvRWlsRkNmZUFrYUVVY0M1U2o5czM1?=
 =?utf-8?Q?cI5w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzBKYUtLYzVXck5hd2x2NldJL21nNHhYc2Y2U2o1WU1nUTkzV1BIYUxjc2lI?=
 =?utf-8?B?OGJRSlhLYUIwQmx5T2pHZFc3ZmhneWt6UGdPMHBGZFcxMCtqNDRSTXBteW1Y?=
 =?utf-8?B?dUxUbzlvTlVkTVozbkJ5MzZDemExS1g2WVRzZkNzMDBSbmRBbzZjSEh0SjhG?=
 =?utf-8?B?OWtURjVENmFpS1JQQVBjc1NJdGt5bEluOHZ6czM2SENIcG5PREp6dDU5THk5?=
 =?utf-8?B?N202Uit3bnMvOXkvN01TV0dBamdvbzVKU2pLdkE0dkZOWldsdlNpV05Ea0pS?=
 =?utf-8?B?eXlzRDhSYzJhQW5VU2p3KzJ2NDdWdC80dTI1cmplTXRkYnhTbnVQMXhZd0R5?=
 =?utf-8?B?VVlkd01UL2FSQ1lpRUtmUGMvVWtweG5GTjJNMHQ4NElBZ2U2RVhOZ3Fpdmdv?=
 =?utf-8?B?M2R4WHJpd2NGUXdXMFZCeU4xWFh2SGpyZ0xCcjdjQkRXYVhmOHZHbmpDQ0ZD?=
 =?utf-8?B?Qm9YT2FWelhsWGVMY2t6bGZqVUUxSkEzWHNlM2IzOWVYN0lqQXNRNFVqOHVu?=
 =?utf-8?B?SXBYSVZvblNodjNMR2pNT0VOTDVZT1JTdkQza2YxVjFxNWV6aksvU2Q4WHRh?=
 =?utf-8?B?cDJyQWRscURzTGsvZGtlSU96TXFEMkFaZzRERUJLV3ZvWHBhTzNXNmdTdVBB?=
 =?utf-8?B?UUZkQzF6YWJGRm42bkE2ZW5BbTZFTVNmaEJNZis2QTVlZ05STU5icm8rYmow?=
 =?utf-8?B?RnAzejZOQ0Vxa2dYWlBhSWU2Y09hTmZQV2VkUzdPUExaWlVmdFh1N0FJTWI2?=
 =?utf-8?B?M0RzbmQvcWlhRENTaUVmaU1SWUhWL2UvcWZNUU94aFR6ckNKN3FWRFYzL1FL?=
 =?utf-8?B?aEtIUkJPa0JsbUxSb3hiRXNxOHpxNUZSWHpWVkQ4N0orSlV6U0pKVUUzQ2Yr?=
 =?utf-8?B?SGZxVmJJU3hvUUdBVG9vV2hrd1VDYlM4TFFOdTV2cS9XaG9EZ293Y0JHRWlr?=
 =?utf-8?B?TVdtRG9Zdmp6U2tyS3BrYkRqcVJDRVk4Q1pSZWkxV1p2NGJweHNiOCtCNm4w?=
 =?utf-8?B?UTE5MG1tcVRHcXAreDFoajUzZGJaTVAvQ1ppOElxalJLMzIra1VPc25PK25x?=
 =?utf-8?B?UVQ4cjBCZ3FTNTRlZWdHc1pHanhoMjNYWDFudHd4eEtQVVM4NDlNYWpQZHF0?=
 =?utf-8?B?bDQwdmRDeFF6cHNPL0VGdklNOVNIWTd0VEV1V1RlVWlibjhiYU5DSURWMHpP?=
 =?utf-8?B?cVB3NnNoTktybWY1T0tqUlROV3NwSDgxQ2tQbGxsd1RaTHR3b1QzenJYNlgr?=
 =?utf-8?B?TnZGaWZQeHpaNlV1c1c5akNpYTJlRnBKZ0paRWlzOGx0N3YwZENoSE12MENl?=
 =?utf-8?B?NUNwV3BZVS9wcEtDRUdQR3pQcTl0UFpPM2M2RG9IWXZrNEtDZk5pT3UycnV6?=
 =?utf-8?B?VU4rNjY4SFc1YUR5SlFCb1ZsUjJUTE9kR08wcGlTNmtwYisxblZGeGVxQ1dQ?=
 =?utf-8?B?Tk1wYzRpeW9uTWwwbXo4UXU3YnRUbFZybCtDbHR3WkljVHhZMVR1TjJDL20v?=
 =?utf-8?B?MlZWNXpOU28wTEg0MCt4dlI3c1dJZ0F5Nm9WdjRLSU8vQ0wzSkF6a1RhV2hv?=
 =?utf-8?B?RVNjanVOVEFSQUpZVEFIbnJpTkNpSUEvSExjT3ByVXhoMHdwaVdlc2VpSUQ5?=
 =?utf-8?B?My9hT0NsWER5NWtnYzJwdmlQTitSMEJSeUNXU1NZT1dZaDNSZ1Q3by90VEZp?=
 =?utf-8?B?M093R3hiMGc4bCswajRvZ0JCYW5TbmNLRDBuaUNQZFc2bWdCSlMvd0JTZ2ZY?=
 =?utf-8?B?b1NDWUNjN0czemMyZTNlYnh2aWlMQ0NEQWhuUEs0ZHEvQW16S2NUblh6ZkQ2?=
 =?utf-8?B?SDA3MlRpK0ZpWEVZM044SlorRlhlMTlVNWFZZTZWdXl0TXlOeWNMN080N1hq?=
 =?utf-8?B?dVNmVW11RTNMZHBSSTN2Tk1ZSGN5clZEYzcwdHR3K2RLakFwNDlLZzZkenBw?=
 =?utf-8?B?MW5WUXNZMU1JcGtEcHpIU0kxWndpM09CcFBKWXp2bm1SakUxSnZYNzNGQjMv?=
 =?utf-8?B?MGQvdGJ6YWZmZnkySXhpNUZGS0FjQlpkSS9mcm5qYWRaQ3JldndKZ0VTZk9s?=
 =?utf-8?B?aFNEN2RQWmZta2Q5eXk1ckVnUExjVlJvalpwVXhxUmxkQm92K3dqNkQvUjF3?=
 =?utf-8?B?M2lPRVlZSFh1OFI4aG9uMVFWeUJYd3lKZzlGVFU2Yjk2RE9KWER0NGFESW5j?=
 =?utf-8?B?aW02QVdSWkkzenRXWnV1dEczTmFoVmJ2VTVMSkRYNnM2dHBKbEJXZGNVNHh1?=
 =?utf-8?B?WGJEMWJLRmR5b3ovbWhQOVZyZVhzL0orMkFDY0NWSjZNODhZZ2oxdWJ5MVZL?=
 =?utf-8?B?c1Vsd2NJd2JqbUh3QzR6QnU4UFVhOExlVk9UMVpuT09ESUFQNVBRSFZ6WnhD?=
 =?utf-8?Q?2ikAygJFLpda1rEw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7853f3-7def-40b7-36d1-08de5eb7ec4f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 21:55:17.1948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN87lwBHdcmjG1RzepJc8t3hnWjr1uAJq5yNVSss/pa6iFN/vwjA9wGXTi1dnOyVav9LPmSmF/ennVwzyaL+Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8118
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_SEVEN(0.00)[10];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-212681-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 43D20A94B1
X-Rspamd-Action: no action



On 2026-01-27 10:39 p.m., Matthew Brost wrote:
> On Tue, Jan 27, 2026 at 11:02:42PM +0100, Michal Wajdeczko wrote:
>>
>>
>> On 1/27/2026 6:04 PM, Zhanjun Dong wrote:
>>> From: Matthew Brost <matthew.brost@intel.com>
>>>
>>> The intent of wedging a device is to allow queues to continue running
>>> only in wedged mode 2. In other modes, queues should initiate cleanup
>>> and signal all remaining fences. Fix xe_guc_submit_wedge to correctly
>>> clean up queues when wedge mode != 2.
>>>
>>> Fixes: 7dbe8af13c18 ("drm/xe: Wedge the entire device")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>> Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
>>> ---
>>>   drivers/gpu/drm/xe/xe_guc_submit.c | 34 ++++++++++++++++++------------
>>>   1 file changed, 21 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
>>> index 92ea32423838..f29ed62d2b12 100644
>>> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
>>> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
>>> @@ -1326,6 +1326,7 @@ static void disable_scheduling_deregister(struct xe_guc *guc,
>>>    */
>>>   void xe_guc_submit_wedge(struct xe_guc *guc)
>>>   {
>>> +	struct xe_device *xe = guc_to_xe(guc);
>>>   	struct xe_gt *gt = guc_to_gt(guc);
>>>   	struct xe_exec_queue *q;
>>>   	unsigned long index;
>>> @@ -1340,20 +1341,27 @@ void xe_guc_submit_wedge(struct xe_guc *guc)
>>>   	if (!guc->submission_state.initialized)
>>>   		return;
>>>   
>>> -	err = devm_add_action_or_reset(guc_to_xe(guc)->drm.dev,
>>> -				       guc_submit_wedged_fini, guc);
>>> -	if (err) {
>>> -		xe_gt_err(gt, "Failed to register clean-up in wedged.mode=%s; "
>>> -			  "Although device is wedged.\n",
>>> -			  xe_wedged_mode_to_string(XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET));
>>> -		return;
>>> -	}
>>> +	if (xe->wedged.mode == 2) {
>>
>> wedged.mode is now an enum
>> you should use XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET instead of plain 2
>>
> 
> Yes it should be. This is a fixes patch though and with
> XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET, this patch will not cleanly apply
> to stable kernels. A later patch in the series could add in the enum I
> guess but maybe not an issue as xe_guc_submit_pause_abort isn't present
> in a lot kernels either.
> 
>>> +		err = devm_add_action_or_reset(guc_to_xe(guc)->drm.dev,
>>> +					       guc_submit_wedged_fini, guc);
>>> +		if (err) {
>>> +			xe_gt_err(gt, "Failed to register clean-up on wedged.mode=2; "
>>> +				  "Although device is wedged.\n");
>>> +			return;
>>
>> if we want to continue, shouldn't we call just devm_add_action() here?
>> some default cleanup will be done later anyway, no?
>>
> 
> Ah, no. If guc_submit_wedged_fini doesn't run at the end the driver will
> not unload cleanly. This could be refactored but it is correct as is.
> 
>>> +		}
>>>   
>>> -	mutex_lock(&guc->submission_state.lock);
>>> -	xa_for_each(&guc->submission_state.exec_queue_lookup, index, q)
>>> -		if (xe_exec_queue_get_unless_zero(q))
>>> -			set_exec_queue_wedged(q);
>>> -	mutex_unlock(&guc->submission_state.lock);
>>> +		mutex_lock(&guc->submission_state.lock);
>>> +		xa_for_each(&guc->submission_state.exec_queue_lookup, index, q)
>>> +			if (xe_exec_queue_get_unless_zero(q))
>>> +				set_exec_queue_wedged(q);
>>> +		mutex_unlock(&guc->submission_state.lock);
>>> +	} else {
>>> +		/* Forcefully kill any remaining exec queues, signal fences */
>>> +		xe_guc_ct_stop(&guc->ct);
>>
>> this was already called by xe_guc_declare_wedged() before calling us here
>>
>>> +		__xe_guc_submit_reset_prepare(guc);
> 
> We actually can skip __xe_guc_submit_reset_prepare too I believe as that
> is also called by an upper layer.
Will remove above 2 calls in next rev.

Regards,
Zhanjun Dong
> 
> Matt
> 
>>> +		xe_guc_submit_stop(guc);
>>> +		xe_guc_submit_pause_abort(guc);
>>> +	}
>>>   }
>>>   
>>>   static bool guc_submit_hint_wedged(struct xe_guc *guc)
>>


