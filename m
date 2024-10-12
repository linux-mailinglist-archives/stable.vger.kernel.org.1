Return-Path: <stable+bounces-83603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BA899B77C
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 00:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFD71F21E4E
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F5B14A604;
	Sat, 12 Oct 2024 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuINCHiE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35494610D;
	Sat, 12 Oct 2024 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728771409; cv=fail; b=eaBqWFl3J2jXkEug0vSX5V3/n2TPMduG37TFirJj4X6LzYHotVdbCsmkv1UanBlqxTsskkZe8TNN4UTiy6tmyE9ryAJxJUp4AhbJwwsuFO5lTGCB8TvPfyd7ybYFNg/nnCd94DYLeL9+t33trs1xAy5J7qfkertVLow1qm5plr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728771409; c=relaxed/simple;
	bh=ftgSb5G9YklhkGgzrQhVCKaWxtYLUwtAcT03gmTPlko=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hDz3eKNMY7wsYZGLQE4C96gFOaqFh3ymXBYYAjVpJrey46Dn3iwIkBiGdhi+e//OM/V4toCZCW+cDe0gS7pnC3bMMd8jnpGiXi3FcYK7ApG36P4JNDvvzpujY5h1Ae9dcNqeC2lHmKDhrclzxVyqdrIU97M8pSuIDhycB0Yh1BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuINCHiE; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728771408; x=1760307408;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ftgSb5G9YklhkGgzrQhVCKaWxtYLUwtAcT03gmTPlko=;
  b=OuINCHiE67IVWF0K8pwoFZR2nqPME/LdGfAbUyfEH6lJu09l1VCXNIsn
   0h0QYhTVMhOJAe/YMD8+OYH4CyxEXIOOPcgBjb5VCO68aIoT7Oz5584Fj
   WRCEngnfSQygx3opjiRg2IZOjc8LFoCaKmY0oTopKjnohOpRPGk8pIKuI
   lylushvbcWRdw/xQKznDwOFplAD7PoOoAMbhCv27wOQnTU1tn01No1voJ
   ac2Xd0EiajtK7tF/2qGp8S3a0uLdZsdcSuDHcnNVQaNxwx32EQv2Zqny8
   09ESX1ldxwQYusSdPTcaw7rBxQk8WAAJFkfPg6ZHXMP9g0rxVFr1eEkhG
   A==;
X-CSE-ConnectionGUID: Qk3eOP0uQgevb18mV4tBfQ==
X-CSE-MsgGUID: zqWY72f2RpSLsgtUvVL1BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="50683566"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="50683566"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 15:16:47 -0700
X-CSE-ConnectionGUID: zRMLBaCjRN6uwPnEG3SS6A==
X-CSE-MsgGUID: Ci9OGKCCQ/ObSiNx0QR2FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82233454"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2024 15:16:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 12 Oct 2024 15:16:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 12 Oct 2024 15:16:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 12 Oct 2024 15:16:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TthiOaoZsBYpso6+pvtKQLK4WIWZS48vOsDk1nhNLRHWlVml6xZUjvqZZdfNkRgFza6MRqofNOuKOQygH5rq0cz6tPay0EkD+LLCL1bql62Gq8SBDuqLATV8+rTV2FSr8fIFOzjMT4oATQYukRo9Vf102qpNStVGbe1W1OhSAqZUhmQoNI/5ZduyOzQ5BM3jtfPfqJ9j/xwllVzaLOYZ5vrCDFJVKfXfwjQ0VHUHDuqf75kbM9IYoR50krw5M/tZhqURm8t63G+yzeS3qWTBdV6ab24TpOLSeu/+Q3XBsjK8KsN5xm5T78Jy3TWg9AVf2uISg+AVA6suZtPaTCuUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGkKrtksKCy+uRpIta9ny53HHpWhCfweA6BT2Okg27I=;
 b=V77reYcAFYb00KWezg9GYhuwWPowhbx6XcR6gAsZBbuJysSfQtmOvXJZ2lAUU1TzFOBCOLqHUaknv13OXtvbrfwbeCIspUQQbGJ0r4/WG+szyR2VzpBXsuR9tgIfkyo8ku1aOkRbqebJbxG6/3AeYn0J0M+Zd+/Udvm0Fn/N3SomOHXLJJDbaBbVFxZovPtItPjh1zkUTxHVYeAa4AXKjjewT5H/I0RaBUq2uln2GGIzt9Nd/ntvhpQjJhVsrfoxjinadFze0drFv61ITqAhBRLaHxPtZTkSuFoF4pBh3xzrNFtv/hPjHw/JagA3YqaUM5KwADcMzu9odZRz6wbotw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5087.namprd11.prod.outlook.com (2603:10b6:a03:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Sat, 12 Oct
 2024 22:16:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 22:16:43 +0000
Date: Sat, 12 Oct 2024 15:16:41 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Dan Williams <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>
CC: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/5] cxl/port: Fix use-after-free, permit out-of-order
 decoder shutdown
Message-ID: <670af54931b8_964fe29427@dwillia2-xfh.jf.intel.com.notmuch>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <172862486548.2150669.3548553804904171839.stgit@dwillia2-xfh.jf.intel.com>
 <a7b8a007-907a-4fda-9a35-68faed109ed3@icloud.com>
 <6709647f66d94_964f2294ae@dwillia2-xfh.jf.intel.com.notmuch>
 <060193f9-5de1-422b-abfb-6328a1c7b806@icloud.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <060193f9-5de1-422b-abfb-6328a1c7b806@icloud.com>
X-ClientProxiedBy: MW4PR04CA0244.namprd04.prod.outlook.com
 (2603:10b6:303:88::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 58213606-8733-49c3-41c2-08dceb0b8db4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EB6u8Ul4PM9oES3PXB//B2YAhzTFjizz0s+cSjA9NPzZuqOZJwEqVk5cvWp3?=
 =?us-ascii?Q?tOkHOsgtM32oRCfj8PxWZarMssf1fPTc8Koz0mInNjvQ/78f4r00EXt29X14?=
 =?us-ascii?Q?VJekmVnPqkyusd9SFkUZAX7vsP6C+0nVyn75XCWwbW0o1DOyerW8XVZ6wLMk?=
 =?us-ascii?Q?RqabbIw8dleeqk70Oz7X8/gIz4gtY5ydc0VO3FU3ttLZ0xe/AP4WKE5zHe4a?=
 =?us-ascii?Q?Pn10QTHpZbNXiBQ4hzgOXZtWcY5jAVHbyn7z59JcW8TWdUAOupQb6fYdUKwk?=
 =?us-ascii?Q?l5Pahf4JR3aQZVq/ODcnxy+j90w5K0OecJk39fQiPgPQq6eU9aHoGG5rdd20?=
 =?us-ascii?Q?67WB84/iJ4LKvxijiH0OmFxqgOJokOMlp5qaMAzbv5CmLASCJFBSKzLBnjZZ?=
 =?us-ascii?Q?8DPovdr7PM+qQ9vob+uTNFbJXxWe+l/bwjFjXUX9UdcavkfEYirBYZr8F8Eg?=
 =?us-ascii?Q?pBRtA4cWK0zFKvHuh0LBgkYsdX0eiF+HJqXMWiIEHn4YrSfp2p0JRfaIGCiP?=
 =?us-ascii?Q?Ip9l1t0J8buClWuBtiW1RyuvR1UteYpKyfJMPKdVtyUmfUpKYR37caaemIRr?=
 =?us-ascii?Q?9LT5ili2I3DKHlo1w4nKviH5nfIDW9qRd2m1Rj79rwr8sWpvebWI2FsQUmwF?=
 =?us-ascii?Q?+sQnxv3L3L0PK0qvLHrnN5BC0hUvcf28XUBGYpJutTk4q/zD/bqNUZWGeWdg?=
 =?us-ascii?Q?kB/37qCxpzxr73kZgjl/CpZb2l1H7wckSHNolX28Rq54b7wvRqSTRxfLfrlq?=
 =?us-ascii?Q?BdjAWKAAtsVsPM0Nka/kXZD7fdFOtFovnNjFexAh1wx6W8cqlGdN0gdUNroR?=
 =?us-ascii?Q?QhruT7O5JhUM4ZxdzCKFvJHPZu1wZA+oZBUvs4Nxl2eVE5KNhuuLftmPLNzw?=
 =?us-ascii?Q?1hw7kpTMmDa3vDHeoN6mbyLjUHnkvhhsD9UdUy4MhGe3nVrW/2qqRbMb45lJ?=
 =?us-ascii?Q?Xs0tBd0XXX/8ILYLKhxjh/aXzBpg7deFeUkriHOSrzzg1RrHxrxgkdPM2QHk?=
 =?us-ascii?Q?IjnAlku6XBn8dcSaL2W+eQwsLW9Cxi89RS/rtNH8tvAnuqbrMTp/eiHanHX3?=
 =?us-ascii?Q?q2iZBwPUtIclzxQ5WJph9VFgQG7xqAT5H4K1DhBA8WbzBbvlGfn8Ed0SdaFB?=
 =?us-ascii?Q?7vFO8kAk800YMrQnkjSsr8oDvSqUgmH8XSC0fLwVz/f/DQklAeIDcIFL7IoN?=
 =?us-ascii?Q?RFsPQCERacLNkNf4df+iK/llBzP/3540Nmlbq+Y4V2W5ycW1qrDjJ8+2w1dZ?=
 =?us-ascii?Q?PGOt6d96GehdF2TDE5Amc1JsAjdoX66v94E14fbCjycL1s+6JGV9Sq+o5xJh?=
 =?us-ascii?Q?DUM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9v1HzXVPBs0zS9bMILwPndqagnzQHsWm0OhBOYvAjQglzaupxE+jhKBEOXVo?=
 =?us-ascii?Q?8FqqSHoxEQ+ptv7hK+ppqEEKKpKJS8D8s+GCFyoQhd1s8qTMSdsg8sP2Nkju?=
 =?us-ascii?Q?8ZCCOLAxwa8U5gJdIbVJBm1yW9sXkmKd7j/afnsYsNrBYVmt3Bq4ji1xmUht?=
 =?us-ascii?Q?Kg/hO1OT27/E2GlnFtr/o3ipcNq9ne0FdXT/maCiskhW+a3mhXQxJDNMG41r?=
 =?us-ascii?Q?fOSJBjH0tApeLnN6s6xMIprAJACnfsQ5AW9Yd4d0ZTS3IKn9uQrdDBBpgTbZ?=
 =?us-ascii?Q?HgE6XotWllqtUgMb6Y71hANQG/TWTIA69CQcl96lLTwPW/sCzsFm8zekmRDb?=
 =?us-ascii?Q?1hWMOoHm7BovKfuXRgYhDWV/Jeufms6uYZHLsiaOS2MvyS5cljgswghWeqDc?=
 =?us-ascii?Q?5KURlL7QNdVsVN0ldx5hAbKPXhvYNLHQgPnLg2Mn7o84CQOWkSGVnX+wSUga?=
 =?us-ascii?Q?cDu3qc1NezL3Gh8pKSb647eDMnKW5dMv69CfR4iNboTw+fThLz9F/WmGqjFp?=
 =?us-ascii?Q?FrgzOAJh8NbExWRcUTjh3tFSGV3OVNxfYByZ9Fic+o8oRjqVvyj62NcVeGXJ?=
 =?us-ascii?Q?nS1ywH7aNwzhBuecnqG3Padt5nyxyhDAOiAKGZGHn1iLar0vxMjPVl1byGQn?=
 =?us-ascii?Q?UsCp6vtFBf9Ltfep370Zzbaw1/QUtEo2/M+vFnbJdL7GcBQlwe+Q1kSERU9a?=
 =?us-ascii?Q?8OyefGnYXmkVLNzF9in4gn3kWFY887LvqPjxdagg3qfE+Igy+AaOPaT72G4k?=
 =?us-ascii?Q?Ga1QmtGz5fkx1iRKlB2MV3aRH+FmbyCutlbVhKaIKwswP78YrIGkK0DdYLQA?=
 =?us-ascii?Q?KvSZsaTZMCzyQKuQS7I81FzztaQO5CTGtcH+OoCtM/UnG78v9pSu5j1ZIm5z?=
 =?us-ascii?Q?GCjILaANFwzWcMuphCL8dRGMmwmamDU90oD+WEkmCAPOrtsVJWjEVjz7H4px?=
 =?us-ascii?Q?BnPyYxI8Cv03KcE13lJpmC5Ah2yjrQ+M7Nk0yHF0E4c6dZfC68gq6bvjYtqY?=
 =?us-ascii?Q?0sjVyUlZ0BPe7HOFpEqqsaluyzlLbfCdI+7J3vQrtSyFgObgFO3jOIpUllAL?=
 =?us-ascii?Q?QBk9uITb1P9BhwP7EfK7ztHgZ6PQ8luWZ9EXfW2/fAF2MzYQS7yvzSMd96OZ?=
 =?us-ascii?Q?PvLBmkft8sB8zUvmVDr9CStYlFSGDNPg5gLnz6Z8dXDw0+o3E9tabB6c3w5q?=
 =?us-ascii?Q?ARE5vlEfxIAgXcekwnves9LjDiEj92gq3padA1N8gZNAE4CscmO4EPys/HYu?=
 =?us-ascii?Q?bONxzSamtCov/CcTUNtjsE9dsFjlPO5x4/RY2lmamIzp9jpC/3NcZ9FklB3N?=
 =?us-ascii?Q?3bm67Oub57P8ZWphcWz3MjhB9sUqhBCgNNpQcDPpo3Myca0vlCk44xss8oR1?=
 =?us-ascii?Q?Lzd7TCyXlG5zFqZ4C3aiNt3090iM2DfrPG9vkcFXnPQGQhUkbIuGJXHst7bL?=
 =?us-ascii?Q?/MoZ09UBSECzPWLnzb1750vTwfcx2nEHeadpS9G2NOwcUmV9/c4eD8cWcPkT?=
 =?us-ascii?Q?R0SRyey5RM+wcu4Qljdqbissw8IqtKR5SXyXWiT0hmWQfOIruTkr97bb8xUT?=
 =?us-ascii?Q?awjS+qJ1iPXv43iO9ilpLeFuwpMZy+WJtAOaVVJOcp9iQo/2wc6Jmzmsr3Gv?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58213606-8733-49c3-41c2-08dceb0b8db4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 22:16:43.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpWGcngROlQIFzQP0ttc+puR/y20V1m5Vq589JCjXQNXr4sMA0rWtWI521DBaTmJOx0Qg2tRHqplFV1+xxXXr1ui492tvlMSXfN67noT03Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5087
X-OriginatorOrg: intel.com

Zijun Hu wrote:
[..]
> >> it does NOT deserve, also does NOT need to introduce a new core driver
> >> API device_for_each_child_reverse_from(). existing
> >> device_for_each_child_reverse() can do what the _from() wants to do.
> >>
> >> we can use similar approach as below link shown:
> >> https://lore.kernel.org/all/20240815-const_dfc_prepare-v2-2-8316b87b8ff9@quicinc.com/
> > 
> > No, just have a simple starting point parameter. I understand that more
> > logic can be placed around device_for_each_child_reverse() to achieve
> > the same effect, but the core helpers should be removing logic from
> > consumers, not forcing them to add more.
> > 
> > If bloat is a concern, then after your const cleanups go through
> > device_for_each_child_reverse() can be rewritten in terms of
> > device_for_each_child_reverse_from() as (untested):
> > 
> 
> bloat is one aspect, the other aspect is that there are redundant
> between both driver core APIs, namely, there are a question:
> 
> why to still need device_for_each_child_reverse() if it is same as
> _from(..., NULL, ...) ?

To allow access to the new functionality without burdening existing
callers. With device_for_each_child_reverse() re-written to internally
use device_for_each_child_reverse_from() Linux gets more functionality
with no disruption to existing users and no bloat. This is typical API
evolution.

> So i suggest use existing API now.

No, I am failing to understand your concern.

> if there are more users who have such starting point requirement, then
> add the parameter into device_for_each_child_reverse() which is
> consistent with other existing *_for_each_*() core APIs such as
> (class|driver|bus)_for_each_device() and bus_for_each_drv(), that may
> need much efforts.

There are ~370 existing device_for_each* callers. Let's not thrash them.

Introduce new superset calls with the additional parameter and then
rewrite the old routines to just have a simple wrapper that passes a
NULL @start parameter.

Now, if Greg has the appetite to go touch all ~370 existing callers, so
be it, but introducing a superset-iterator-helper and a compat-wrapper
for legacy is the path I would take.

> could you please contains your proposal "fixing this allocation
> order validation" of below link into this patch series with below
> reason? and Cc me (^^)
> 
> https://lore.kernel.org/all/670835f5a2887_964f229474@dwillia2-xfh.jf.intel.com.notmuch/
> 
> A)
>   the proposal depends on this patch series.
> B)
>   one of the issues the proposal fix is match_free_decoder()  error
> logic which is also relevant issues this patch series fix, the proposal
> also can fix the other device_find_child()'s match() issue i care about.
> 
> C)
>  Actually, it is a bit difficult for me to understand the proposal since
>  i don't have any basic knowledge about CXL. (^^)

If I understand your question correctly you are asking how does
device_for_each_child_reverse_from() get used in
cxl_region_find_decoder() to enforce in-order allocation?

The recommendation is the following:

-- 8< --
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3478d2058303..32cde18ff31b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -778,26 +778,50 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 	return rc;
 }
 
+static int check_commit_order(struct device *dev, const void *data)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	/*
+	 * if port->commit_end is not the only free decoder, then out of
+	 * order shutdown has occurred, block further allocations until
+	 * that is resolved
+	 */
+	if (((cxld->flags & CXL_DECODER_F_ENABLE) == 0))
+		return -EBUSY;
+	return 0;
+}
+
 static int match_free_decoder(struct device *dev, void *data)
 {
+	struct cxl_port *port = to_cxl_port(dev->parent);
 	struct cxl_decoder *cxld;
-	int *id = data;
+	int rc;
 
 	if (!is_switch_decoder(dev))
 		return 0;
 
 	cxld = to_cxl_decoder(dev);
 
-	/* enforce ordered allocation */
-	if (cxld->id != *id)
+	if (cxld->id != port->commit_end + 1)
 		return 0;
 
-	if (!cxld->region)
-		return 1;
-
-	(*id)++;
+	if (cxld->region) {
+		dev_dbg(dev->parent,
+			"next decoder to commit is already reserved\n",
+			dev_name(dev));
+		return 0;
+	}
 
-	return 0;
+	rc = device_for_each_child_reverse_from(dev->parent, dev, NULL,
+						check_commit_order);
+	if (rc) {
+		dev_dbg(dev->parent,
+			"unable to allocate %s due to out of order shutdown\n",
+			dev_name(dev));
+		return 0;
+	}
+	return 1;
 }
 
 static int match_auto_decoder(struct device *dev, void *data)
@@ -824,7 +848,6 @@ cxl_region_find_decoder(struct cxl_port *port,
 			struct cxl_region *cxlr)
 {
 	struct device *dev;
-	int id = 0;
 
 	if (port == cxled_to_port(cxled))
 		return &cxled->cxld;
@@ -833,7 +856,7 @@ cxl_region_find_decoder(struct cxl_port *port,
 		dev = device_find_child(&port->dev, &cxlr->params,
 					match_auto_decoder);
 	else
-		dev = device_find_child(&port->dev, &id, match_free_decoder);
+		dev = device_find_child(&port->dev, NULL, match_free_decoder);
 	if (!dev)
 		return NULL;
 	/*

