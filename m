Return-Path: <stable+bounces-139090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C5CAA4124
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 04:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3154E5D9B
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 02:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424CF1459F6;
	Wed, 30 Apr 2025 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZmLhjPV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C316208AD
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 02:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745981216; cv=fail; b=ukbsBkXwL3ICkvHb4Und1WoPnYYjIWRcTy5+TnOnElr4s1HFBGDZ/EUUWhGNXi28T0VsDaGQAh2oGJ3sFgzlm/GcFH1wGle2D3OpOkRtYS0PjRede+woHnmxDK82mo9ooYvpWppT3udyxrXVTrndIN5KwXqVsYp/NaUTcJ7tpQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745981216; c=relaxed/simple;
	bh=AGfLs2pFBHilMrofVjkKoPWTZ9PhTts+dRUbzEyvjo4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gALdVrGN11xsZ2AwmwsvjuOAz2xgRAiaCkN22s8pHSaK3pMZF0INEfwMR2Gbf8J69Lr9VtVlnsFLzT0Cm6A2kMlGrYgMi2YcuZsNdfJEntDI2yZ84SgwX51Ff6wM63WLkf0jPwJLSo/yZ/MDtxGU90BkHXp6wrHip2/Y5TnQ1n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZmLhjPV; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745981214; x=1777517214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=AGfLs2pFBHilMrofVjkKoPWTZ9PhTts+dRUbzEyvjo4=;
  b=SZmLhjPVcnVab6U41P0NWTYqpx+eTnSuq5fL96/Zq7ewaSxFhie3xZvd
   ph1MOlrj3AbJBHLAFOGb0BIiT6yCaUiMnXyQYtpN7ociOrQXsdSbSf5EL
   8ujDDMT7zvcMfQFqVd3CKGKnRJOJG53UZmnFDMhEduYAoI8mudc7K23mo
   Grg2k68OcBNywdEYryKS5tmU5iQsGFOa+kBSu/jiy7tRB44ul+TmXh7lV
   UGFrumXUtX8yPzA8BqtIhSpnlJT8Rw9STsx7RBXAsvXhXN+VYDRFL8J31
   sLlpGiNYtX7m9lcsyzf+y9pSfwkWGFGCzNlw0UPmsMjaQ5Lg+j0djiBde
   w==;
X-CSE-ConnectionGUID: TwaTQXzhQRaBNOMSEFc4HQ==
X-CSE-MsgGUID: rEGzeDEZR06SKcwgln9YGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47764059"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="47764059"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 19:46:48 -0700
X-CSE-ConnectionGUID: y3OxVJNzTWWMoQTqJ1GRvQ==
X-CSE-MsgGUID: aPF3GJ5eTgiE9q+1RNeyoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="133904074"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 19:46:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 19:46:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 19:46:47 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 19:46:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wt6K0nlvG/6E6ZWHk4oOpWnvrHAKsOyCmNM0h8NIHMLmNS3M8slWEmKHSWLFdvZG4TU4KDgXrVTjRQEjNDdlJOcVXufUkEJsLj0lY+uhkx44Bcqzh3FaDMb5TkqR32bhZh0cJgcj4zxBzY2eCdRRzkMQfxOA9n8KvNVsDmgzSQdRgKF21il8VRnezZoVpUqPVEVod7igHbuTJh0c+B10/a62tUQG5DhY5qY4jcrcWmPUAgFUIyq/7MzYnsPUVMuWYtEycYyAduEf33H0oBJyg2Gjus/M2vqRFuERa1rlgEtXvmQ0qQ5e+byWi6795AcqixhhHzb1etmZ3KORSWiGEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERoo9eIVFnIGogrUZxOIcoKw3Yn7S2Z2lF5qiiFGlog=;
 b=gLMeGhU0KXXPQPHCcAbrmSfSrIrwLtNxBrBNquzGK2u7Yxxf+yKymBsGC8KoPoxYS6+cmHhbFjRlLuqNv14z0egYd8AzIEUDpgDT1FtDJ3ACpn7iAytq2+lNaec5jgrpPpr/qXjDNHNLHAXffzdPnsBCtVvpmi5z+HmINOAySOweVYgGFqGu/qh01BIfmD2YrdjjdCO0fb5PYZZkNK78UoZpnEN4eK3dom5q50s5F/7raGzAtbD4Hx3RiSOrq9gSoDnSi5I17wTjYhasHsgJVLV2TPRUmIxb9gtwS0U7qkSuFxIs8Sqzu1zDfmYGYe1kfw4Bs1lX83VWgDJrdtqI9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5231.namprd11.prod.outlook.com (2603:10b6:5:38a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 02:46:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 02:46:28 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <dave.hansen@linux.intel.com>
CC: Arnd Bergmann <arnd@arndb.de>, Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar
	<mingo@kernel.org>, Kees Cook <kees@kernel.org>, Kirill Shutemov
	<kirill.shutemov@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>,
	<stable@vger.kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Vishal
 Annapurve" <vannapurve@google.com>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH v5] x86/devmem: Drop /dev/mem access for confidential guests
Date: Tue, 29 Apr 2025 19:46:22 -0700
Message-ID: <20250430024622.1134277-3-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430024622.1134277-1-dan.j.williams@intel.com>
References: <20250430024622.1134277-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: 653b3fa5-deda-45b2-9226-08dd87913519
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Da2YjTiVC/n+GdXbVDF6a5aGUptZ2M3RC7Brg4J0J6exkd+6YVy9WcaPQpz?=
 =?us-ascii?Q?tzAEHcvNQNs81nF17YbUiwDBVVAsq3VnUPQLFCdOZa/bj7pKYq2FLGfGQPR0?=
 =?us-ascii?Q?eBJp/j/29t2goXfOM9U7BkrG/9AxDkvJ2jnexoQ3IawnSFpQzqg7t7JlMNZS?=
 =?us-ascii?Q?enQ5jHlDlD/9oh74wCDawgEDQCjLPLWScrnN9PJOAwpbT5wG8mkTn3PVt0J0?=
 =?us-ascii?Q?MmGdF2cbuAGgge6CH5xCBM+EI7hHgv5DD7QQAFQALGRtzcwh90p5yPBAcJp4?=
 =?us-ascii?Q?WRrgbj/Qylthv90vr+NGB4lN61UB6JDib9nu02LeGH39lISEFbTQyt/F9AzW?=
 =?us-ascii?Q?hBpi0hgUbwSpxAm9lzLVmKhamcR/rCv5mWg9fKhSJcsvD8e4ZCGPqgMkCe4O?=
 =?us-ascii?Q?3wMVsO4xDP1JNC1SEz4JL+xVkiyDT02RwMX9fqYxYs9wm6tO3AizZ42RwYGk?=
 =?us-ascii?Q?CS8HBRrb+2x6maGKPCsw+ecfR+/wfx+cEH2EL7p09juxtZmEdTl8qAnoNcD0?=
 =?us-ascii?Q?tw4Ak/6t7V4ywN2+8K6X8uWJvHoxmmjGT+SQTSHE6u7EONorn6q686JeBDej?=
 =?us-ascii?Q?w+SEoCxEOza/k8yH0dciHn2Bsn3gcA8/xgyvYA4Li2D/0+cJR/MwV2zfVO3E?=
 =?us-ascii?Q?ueCP+r8Wuk8K14y0c9RD0xYWLM8b8ga7X5yxXoPl2bXVo29KdZTxTU1tletk?=
 =?us-ascii?Q?glF/dtu+mEJhkVYST2M4aCDLHcvdPOoPzKkgFyx4ioHqX3nDsjSxjqdxDFpt?=
 =?us-ascii?Q?K+o03ojyq1Py7wGtN3uNLA5vVryBoWUO1r+yPDhV4/lZ+m+FIQB9HosxhCKc?=
 =?us-ascii?Q?1+HETzSM9v4u2j1dAmX8TpfTyDBu6rEOpgV+hvdXIxcvi5Xh69g/lGm5bA+s?=
 =?us-ascii?Q?vfrWFdquo3AUIapa6AoExr6/u9WVzi/pAAgZDhoMBe1U0YwhE9uT0ktv4Zt4?=
 =?us-ascii?Q?vWJSxSYb/Y1y+I4EffbCbKTHknnFReVIhrmsGliE9gqcrcDoV6NSEZYMI0HX?=
 =?us-ascii?Q?5Lt1Umly4xztF87nSxB6O4qrjM/5iEpC5X79mP3EesA+TReKUf9vlsKXbEJ4?=
 =?us-ascii?Q?gpfXx0aJQOOrHc2qhvlbn9NYOGHEEjJi9awkRHJekNHT6WfvmffuuK0P54tJ?=
 =?us-ascii?Q?WkwiFqdyVnbQ7hkDUtHDR3hQop252E0jo+c1/y4j4empB4W4Pa+W0i1TP5eJ?=
 =?us-ascii?Q?nHccbJr4ll16R5TbuZ0IkWa7eiyUSUKc3UPR/UcPZjxilQvynwn45S5MR7ag?=
 =?us-ascii?Q?zjdIn72/Dl3njN8K272cnfRDL65hbkPdDNrbgOHt7Tiv1VCcQThlEwQPAt3q?=
 =?us-ascii?Q?DibD0r/4t6Gl5aC6xjqXOifOB56bDbLHYgV2VKeqlYIgboPIovzvybV5VPRf?=
 =?us-ascii?Q?ITvz11s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zmY+i18EIdocmhFHS/Uo2OHPCML4TW2IHNAID7Sf038K+kyKvKxAstGNLlO9?=
 =?us-ascii?Q?SjKmcDGv0Bju6RJYIu2MnYq1xiTq6DvJQkDo3Hzc6Myw8qlZCGkX5r3tGcd9?=
 =?us-ascii?Q?z+woVqmgqQmo5nfUBPxlpu445FOAluXMwImCmx3VWXZqvGeAoO951ZQILE2O?=
 =?us-ascii?Q?VBCXwcqNfdNA37RGS+RYAwmjO99XZTIH/TvevuTcAqU4gitn8xFfu8DvCxCo?=
 =?us-ascii?Q?MkQjNHcXop01kjwJRfhhSniG6flXLMsy9u34F0eitVb+HqI0+zgC7ggIPbyU?=
 =?us-ascii?Q?de2wlPSLAvhbTsk3RPzwqIi2lCM85UFg11wReRDtNXwiCuD+LKlEP0a/Zdko?=
 =?us-ascii?Q?zEy0gngfPesZQ86DbihIV+Il1wPHGLkDDzUGdkv0H/poAy144Za1Qt+tEnsf?=
 =?us-ascii?Q?drWdHdZt3sXQCmoZBQX/RzBwOEk1ZPzqENNqjmSX33TJUXR/sulrc1Tqokd3?=
 =?us-ascii?Q?B17TKbNLsqAFPWvAGkCxAhUYezn0iI399NjQ72qWruzbBwELSTe/nbR2l0iA?=
 =?us-ascii?Q?trhOlXzq+oiZjGwoSWxUgIOwx56jsFhTo3od3C1KmgThVZZZMXVCPf69b0x9?=
 =?us-ascii?Q?XwSYglFxAc7GcoWekCdAb9/dIdCoI5NXIDYEmlInpaot26mLBrU6v1okyIi1?=
 =?us-ascii?Q?J1C4eQIlc1nZoQf4qmHU+87OPXiGvOZuVSa2dnV2ZC8XBm45ypdh8FIAcUcd?=
 =?us-ascii?Q?nBiAnxwcDG40ftM71ZR0ycXsVZA6tcBvIA1J78OG37KQIaqi2W2dcUPqrRwF?=
 =?us-ascii?Q?0rw94SN2IzGGpBDUX6H2MaeMKPoO99BdSforyVRqY+cVwEhIa2gODvRHbWOh?=
 =?us-ascii?Q?O5hOBv128SPNriL2cmyNTE59kaEdGQZrK2qff+5ws6GSgkCr3ATkze2P4uUJ?=
 =?us-ascii?Q?Ai/QOxMuB+okMDx/n2kDLgW41Du1avMtB1HfDpxfj6jOASfJW1aWlOH8Fy7T?=
 =?us-ascii?Q?m/wV8U5hnhVRT1mX+8Bb1qaY6mVUiVk0CuHMZ3Dj/NXo79cni4SDFKpkSO0n?=
 =?us-ascii?Q?+daAzWmwj6PirhOIigMQo4CS/9U8mgcLyu7fPPguVP6meHebIZPsl24bXPso?=
 =?us-ascii?Q?corgzFbXe3VbZNciJasbw44xFLMTAT96MKpmr3FdMh+N51/EhflNpfIBUz++?=
 =?us-ascii?Q?ViEG0j5AhDQifyV+ZxhXaGd52hy+9vvdJ6Z7eJfu4yvyY0UaNddxP74qs79B?=
 =?us-ascii?Q?rWD2EOeb9SndumSZsEQjrpmTdqoCHFyt8eL6KI7m2IHNJaZs56ZiqKvF2z0r?=
 =?us-ascii?Q?AsC40O8mXnSOXo8qt0bwaPvbOWK8OMX8yRVsD8mj9MCinUgPcuIHAjxvzmCR?=
 =?us-ascii?Q?IOEnthkYYyV4iLfBAXtZ4oMkTyfZZmoBklN/yl44NTmaL1EQWSrBLE93FQ76?=
 =?us-ascii?Q?S56cxtHN0BPJhCrbJ+95FVEFuJrPzSRUMsyCPV0kywXSzJGhb/KPO2Y1w5Ap?=
 =?us-ascii?Q?xGV4V9eaAvlKryTyhuvY4Dm1A5pB2B2T0AP+PcNqrym1XhmIA86ViPrCAtvA?=
 =?us-ascii?Q?5Xq0Cxg4eM78x86GJYceASczcPWOI6AJNAVrJEPDiI2B+ti/aeL98QJ9dc4E?=
 =?us-ascii?Q?G6pkT+Zo0C4WsHk7XiHRCqREgBQl7etvZ43B8bbr05AaDodgm0uDllW4yTe2?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 653b3fa5-deda-45b2-9226-08dd87913519
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 02:46:28.8962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItLfMJ8yYaZ8Umq4U+qiYkfHi5HmGrLbawCPttvyjjL057Tbcduwsb/gMmfFKP8l2hpq3l8rpwEF5k0r/7JZNiafJzQu3qmGqpXqJwq3SJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5231
X-OriginatorOrg: intel.com

Nikolay reports that accessing BIOS data (first 1MB of the physical
address space) via /dev/mem results in a "crash" / terminated VM
(unhandled SEPT violation). See report [1] for details.

The cause is ioremap() (via xlate_dev_mem_ptr()) establishes an
unencrypted mapping where the kernel had established an encrypted
mapping previously. The CPU enforces mapping consistency with a fault
upon detecting a mismatch. A similar situation arises with devmem access
to "unaccepted" confidential memory. In summary, it is fraught to allow
uncoordinated userspace mapping of confidential memory.

While there is an existing mitigation to simulate and redirect access to
the BIOS data area with STRICT_DEVMEM=y, it is insufficient.
Specifically, STRICT_DEVMEM=y traps read(2) access to the BIOS data
area, and returns a zeroed buffer.  However, it turns out the kernel
fails to enforce the same via mmap(2), and a direct mapping is
established. This is a hole, and unfortunately userspace has learned to
exploit it [2].

This means the kernel either needs: a mechanism to ensure consistent
plus accepted "encrypted" mappings of this /dev/mem mmap() hole, close
the hole by mapping the zero page in the mmap(2) path, block only BIOS
data access and let typical STRICT_DEVMEM protect the rest, or disable
/dev/mem altogether.

The simplest option for now is arrange for /dev/mem to always behave as
if lockdown is enabled for confidential guests. Require confidential
guest userspace to jettison legacy dependencies on /dev/mem similar to
how other legacy mechanisms are jettisoned for confidential operation.
Recall that modern methods for BIOS data access are available like
/sys/firmware/dmi/tables.

Now, this begs the question what to do with PCI sysfs which allows
userspace mappings of confidential MMIO with similar mapping consistency
and acceptance expectations? Here, the existing mitigation of
IO_STRICT_DEVMEM is likely sufficient. The kernel is expected to use
request_mem_region() when toggling the state of MMIO. With
IO_STRICT_DEVMEM that enforces kernel-exclusive access until
release_mem_region(), i.e. mapping conflicts are prevented.

Cc: <x86@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://sources.debian.org/src/libdebian-installer/0.125/src/system/subarch-x86-linux.c/?hl=113#L93 [2]
Reported-by: Nikolay Borisov <nik.borisov@suse.com>
Closes: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com [1]
Fixes: 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()")
Cc: <stable@vger.kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>
Tested-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/Kconfig   |  4 ++++
 drivers/char/mem.c | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4b9f378e05f6..36f11aad1ae5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -891,6 +891,8 @@ config INTEL_TDX_GUEST
 	depends on X86_X2APIC
 	depends on EFI_STUB
 	depends on PARAVIRT
+	select STRICT_DEVMEM
+	select IO_STRICT_DEVMEM
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
@@ -1510,6 +1512,8 @@ config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
 	depends on EFI_STUB
+	select STRICT_DEVMEM
+	select IO_STRICT_DEVMEM
 	select DMA_COHERENT_POOL
 	select ARCH_USE_MEMREMAP_PROT
 	select INSTRUCTION_DECODER
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 48839958b0b1..47729606b817 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -30,6 +30,7 @@
 #include <linux/uio.h>
 #include <linux/uaccess.h>
 #include <linux/security.h>
+#include <linux/cc_platform.h>
 
 #define DEVMEM_MINOR	1
 #define DEVPORT_MINOR	4
@@ -595,6 +596,15 @@ static int open_port(struct inode *inode, struct file *filp)
 	if (rc)
 		return rc;
 
+	/*
+	 * Enforce encrypted mapping consistency and avoid unaccepted
+	 * memory conflicts, "lockdown" /dev/mem for confidential
+	 * guests.
+	 */
+	if (IS_ENABLED(CONFIG_STRICT_DEVMEM) &&
+	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return -EPERM;
+
 	if (iminor(inode) != DEVMEM_MINOR)
 		return 0;
 
-- 
2.49.0


