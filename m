Return-Path: <stable+bounces-76841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F5997D9CE
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 21:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038191C21D1D
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D2318453F;
	Fri, 20 Sep 2024 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kag+tgHx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B083291E
	for <stable@vger.kernel.org>; Fri, 20 Sep 2024 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726860556; cv=fail; b=azdJkJ+cqG4LFGHyALF6umV3oUYbRvtTpC2SIH0U9RXAeoxXO1FVS/NYCRKkz45jAoqyeqwX9lrir8bWaWjPjbDikv8MOCCkY7pySFnutsp+py7bARblSdbFwBm+4avcdZFAH3l49/Izks22zqrxf6R7T6Viw0FZX0TWnQZ8Tp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726860556; c=relaxed/simple;
	bh=x1csfcjwBr6zi07indz819TXXxxA6OLq+YILgD/XgC8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=as4QHinNmnwwG68OejUAGV8ZjAcF3RuHF231MJ4JFJ9MX71m/k4uQApchRxJU88X2pjxa2y93RenfZEJAitco2gEYvCiIFWL9KdMTD9oHHTp9nmzUNy2ZRjiViJPgxlXNTsoJLnyNlQcjXOU3LsFjLM8noGFsXS3rDPmS7iOKMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kag+tgHx; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726860555; x=1758396555;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x1csfcjwBr6zi07indz819TXXxxA6OLq+YILgD/XgC8=;
  b=kag+tgHxBTDGwBHL2BIsF6HTNdo0B1SNlpRBz0hxgR3M2IFm/s9loKla
   HJF1tEIvbgmPSDRqnM40qdXTOKH4ZLfo67SoFsPMpDGmPZ4BI3QFomb3h
   75uKraWu0GlzyRtwdNFD1KH4YqMzHatuVHgUzmsE0bZ3XvrSYrqbJq5hz
   GRisVmCyjaer3wX0ZEzPxqKvliJCmHwnTUQh0TcIpmXwmT3WovbGYWP0u
   PygnNdw2ZEiZp9/Fb8Ske/7gyrkf3piDf5C23eyNVraA78uoWp4Tqm9U7
   KUPjLiPbCeO7tyW1EJn3F3c5uCXCCLYmW+/eDj0n9/6S7OD2JTb6+tcpV
   g==;
X-CSE-ConnectionGUID: Pttz2PtJQX6dK4UkybnVkQ==
X-CSE-MsgGUID: mL8jwAU3RwSwdRDEiYVuHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="37252279"
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="37252279"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 12:29:14 -0700
X-CSE-ConnectionGUID: YJzZF2sKSouW+2Scgj8Q8A==
X-CSE-MsgGUID: 5uWwpl1tStunvaUOk2Y+Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="70680735"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2024 12:29:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 12:29:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 12:29:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 12:29:13 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 12:29:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cs7f/4POes69MBqax5aP0SHhwji7ycj5YILnO4Mcph6V/iXdw1kNjkU+3KJfnDlCTVA4EHtgwGiK7vtipqZb+mBUKLetPCwDlhoeUaeuWK6jjDbtADTmBxNhPRpXqKKiJS9hQYZ3PqL8YnDHEPqkAhmD4CnQM4iUVhnhE/DWCVjCmvIfEyOfO+TgVflaT0pipLi056FIf87BM/FgJxwhpXawcL95xLL+EI8qPZTQm3hTOxCYTt3jZcdfihc0l/dLfF9DCWFHUGG64V7VjXMfrhFSwKPVv4N3V5HDPkQdwM9c5Gu15vKRohrix8YPlWTx4W0gWM/HGC2E1a19FkRZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJrQIIdLr2LMLl2V17cp+6Ub4s2wWbqUJNrsCK/pb0M=;
 b=jXxZSWjKClBUipUT9Qkmzfm5pT0lWPPTwq6OafMnlx7jI9pWW3NaiTAx++T/lewGTcHtDZbL8eOZW49vy/51oPv3JqGRbthVKhlcAfEQuJbYElI+HQWwxT0LEG5r+YoQ+sdPiJ9Z6kwgm4n547MCvD4g1yn02pmNULgwtdFIvdBVNiaOF2ROU1dfR4QVZf06vdSN+cpIV6aNVxT9UmAGe94LiyZ/NAw8Olm4WebojXzqDJk4Zp0CbHK1FDziJhcohknDg977b3B5RVTA09AXO2AXUOjExZnW9azzKDCp1r2inhtbDbOHb7oJvMbcXU2JgiLSVYn/iweYO2o6UURfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 19:29:09 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%5]) with mapi id 15.20.7982.022; Fri, 20 Sep 2024
 19:29:09 +0000
Date: Fri, 20 Sep 2024 19:27:24 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: fix UAF around queue destruction
Message-ID: <Zu3MnI2HRDwAAVWS@DUT025-TGLU.fm.intel.com>
References: <20240920172559.208358-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240920172559.208358-2-matthew.auld@intel.com>
X-ClientProxiedBy: BY5PR17CA0023.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::36) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH7PR11MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5fc382-5612-4603-eed3-08dcd9aa7fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?egcjDX4EFmbR6vd5eLjPJeUWBM3T4IW7+I0/ZiBftsaG5hbCQEtdP1sahX9D?=
 =?us-ascii?Q?/5bkngfjHaDCwiiXfNqgJOIA6ECU7j5k+xDulrJXKYKu36DFG+ScaEalwp9c?=
 =?us-ascii?Q?L0bNcLcLDCAB24K1D2dcfkmm1A/htKCMsCUqTkbkE5uc9iX5RjdUtgZsL488?=
 =?us-ascii?Q?M23LFjQW0bGE8I6zpbSlXVC182yEVwilAeW6kXr5K0xg8yfecbs/lbZZ0hms?=
 =?us-ascii?Q?V/6xvWYnIck3uqW/oYvXBJiDzZ1pTXV7IkLLEV0ppjKO4uQEbqihrgfPGCds?=
 =?us-ascii?Q?ip6UdxNphM4luIqpDreN3chfExSjgDKG0o69nUHikzDLGPrDFTTCtUrhGXJR?=
 =?us-ascii?Q?V7uoJY9KCnuh8XJl8JEXkkiISBLB3hXLTToaUSnnQuWbW88KW1CDJuzOh+DM?=
 =?us-ascii?Q?V5ZUOeu0VpSAg1SFdhYdCwnPQNehF1WfPEECiIxKXBUmrulBKV67xYex4E+P?=
 =?us-ascii?Q?auuEaqvXJvy5DbPeTejiou2hcoyWQnFBBqTvhzK+vt+cNHPFkiULslSZyq70?=
 =?us-ascii?Q?1VOSlNV51qJfLjjbcUKlxdYwZ3xjIPmymhFB/5gBsL9h0XiJ3jZ0DqpHLXLV?=
 =?us-ascii?Q?juVt0u30uG5eeWnD0xUgraErlw7ZjRLYk91soLqC1CySeu7yMqMruVGGtNka?=
 =?us-ascii?Q?Panti4ExFibC/DFYXIrCi1v2LlxZO33wpRXBqVvikFk6kbvfF8WvoqtEnbcq?=
 =?us-ascii?Q?jE+M6ZNft7nsxhNZE+YCTd23f9+hbVcLr2YPyytfTMa6X3RDbmaFEPEEbTCN?=
 =?us-ascii?Q?SO/FxsVEtcB5XVO//Guzb0tjreEbZUg/GzbHAS+TC0lblwM8/6zpZgpnbt0d?=
 =?us-ascii?Q?Gc9ZKxslOgsEy5/bHBzdltZkuKYV3tTyN4YM7MUYn6/kAhvZLWJXPNY0TAzt?=
 =?us-ascii?Q?+VBBKw3CY28gQIAtV8U2bzm4EthwPDZnaQDdpPuPJ6/mMQ+JjeKtjfnDIxW0?=
 =?us-ascii?Q?lh5EDoFkZw2uiUGSn+2dcDj+GAeg8sMLRys+nnh/9J4lQZ1A9fvrVtKBtZQF?=
 =?us-ascii?Q?GG1x7bxFDfJhp5x5eaD8hrPAq+H0FbGxIOMYQcEfOVr/spdYUxigX9PZgMNw?=
 =?us-ascii?Q?NZagKYVwjRI7CfWZ0eCsgaPgxLji/8Hew7D6NzUhTxDjPJI8BV1YJ87XiO1Y?=
 =?us-ascii?Q?2mkg8Avqnlxvc774/b/Sib/LLutMxcekzjLj5E6ZWsVpTHEDH2qAjWlNwW4O?=
 =?us-ascii?Q?zpAlR2K8Hh+YShWp6pulywvj0ZuRfm/bLjFEWhJ4rUclmgEV4XSPJBEVdYVS?=
 =?us-ascii?Q?oOsHZcVXa2F1rt0WuEBePmA8J2ZTs7DSDtsnP5ZOnjqfatRJ9D1J6HN5ayb5?=
 =?us-ascii?Q?KaI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZltIKYu70vRe44pRfohTgca7c+r9K5Dg+rHyKP1XXw3Mgu4vKmONqA179HSk?=
 =?us-ascii?Q?6YmgfzsjsV+CdrQnN43FtjKljPWgJUMT1dubS1ktTRIjO3okRUEKGIT8y7IT?=
 =?us-ascii?Q?ggE9oNTCuEw5fePh92jUstJ2+h1qdFJ/8ENeenuKlT26vMPhRSOLilrIY9hy?=
 =?us-ascii?Q?ZNe0nmju6Swn6TywRSy8aS/yjgT/z/1DecL9HkfJackQOYbnnqBMYMhvRrgJ?=
 =?us-ascii?Q?9YJ0e2TluuONkeSQ3kbVwtNSIoPsq/EODMRbYKhgtIsi766SCdHf/pKTOrZf?=
 =?us-ascii?Q?9qwo635mn0t2XAtYUFmxa8ExBtLaobJVRD+cZ1G7qjpdZgcN0aHtNr/d1k7K?=
 =?us-ascii?Q?+ty+4rAvd7SOAvsGjgzqiBPdVruTptN+5rpVN1mygYDMVj8g+en7nV9ZVdh0?=
 =?us-ascii?Q?cc+AQa2moAhVjHEd5WurW8NlGg83BIb12XflGOsQR+zxCGJgOZq3b2tAQnv1?=
 =?us-ascii?Q?hyHdbyO14RaTtsJ6ucAuFwarQhrp3FIqkS6Palmgelzj2I6aoKzRtSEt+3gq?=
 =?us-ascii?Q?aU0yG4Mtgl7tMb0wmBo1XfO38adpslngydMnGaKOZ3WlNlPqDx3rTV7cMMCq?=
 =?us-ascii?Q?4PKmY4YsaA95/5TDuWSg/3haW4N6wt5UkVYodWxTBi3cbaSuChZWiVpIajjr?=
 =?us-ascii?Q?6GWndzLnuXKN9LsAdsOdLFhi6KdFzhjOy6dhipnXAdIqSkT1PJoWTDxK8C1R?=
 =?us-ascii?Q?tXzKVcgnvkqv9vfRbdTKSfPyQJahsWZcp7wB1Lndc42Y6Ex0PG2QnK2tNFH4?=
 =?us-ascii?Q?GHf+Z+wAV2PuIvk165Hca0lekbIrai9OvwYbP/5BCIwj3qd/YnPtUlNPRou0?=
 =?us-ascii?Q?wBIc/e9lJawYjJwCS1+Z4U9Mw1q4eRtqAhecNpmBUZJ57z6yKvwVjQgN9G/C?=
 =?us-ascii?Q?VGHXe/b6SY+DJfu0LCLDWb6gteiRgb1/1bjqAC9J5QkD0tphJHJVqz0n6QsF?=
 =?us-ascii?Q?EQfpxOtluWephdrc5kStJu4CwEFi73I6lDQRlMv65UZLDT/fjWI9xtb2FF65?=
 =?us-ascii?Q?9f940ZfRauObrSTChxl+6JDabbLPQgoatDoMf13hJdayPdAqxWwgbyhcYkEt?=
 =?us-ascii?Q?7nM/U3nQJUcjke3HkoI49RWId7IYAJgf3VqHEmgGGb3CXi8tBOq8IKlF4Tb3?=
 =?us-ascii?Q?88eS1+u4QKciaApKX9+EiQ+ht9Y+Sz5kGzVwK7BwLb5l2+gWv4iBEkaFQjlR?=
 =?us-ascii?Q?//TuyhmeGJQTtHaxA9TNpBEdgJBU8EDdCr7HA3qUYRowBff9uSetLoKAscqq?=
 =?us-ascii?Q?ZlEfyVNLQEBtOkIBc8PoFW62+U3hG0+kFV8Z81Ubs4X3eobx/Tx7xhJOLGNP?=
 =?us-ascii?Q?oMSYzHlbq6WCP6tY/yTCn9OkHt5WR41CZ9gmmnsmxsM+1Jvf6yDMjzpm35ZH?=
 =?us-ascii?Q?huAQCvvfadAoO5vv6/7pDGgZ4M4VuuzIj7lXD9KvoMDpJnbPl4v31QRZbbjt?=
 =?us-ascii?Q?rC6KbU1Ci2yMhb5IFWD66DDM7Er+6x6NOlMy/7T6LmtCr07EZNLSmwTq5ohy?=
 =?us-ascii?Q?KlYeCWYC5ubVFtFoQqOWF+uSXqY0ZVj08TaunaMN8WGkH5P7T0sfB0htG3jm?=
 =?us-ascii?Q?92fwl6ewN2uUhyaavk+LxQ28mhWdU/NagJBEMmMQYXCQsE6KJlgfGx6On/yn?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5fc382-5612-4603-eed3-08dcd9aa7fd9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 19:29:09.4303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUedhctJGTDMqo86DsrCDU5xAN/S1XwDkxoprLdjYPvWbAQ81rdqar5Z2v/RD1WJ9V52X3Cfb2AMx0VC5Ljp3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6005
X-OriginatorOrg: intel.com

On Fri, Sep 20, 2024 at 06:26:00PM +0100, Matthew Auld wrote:
> We currently do stuff like queuing the final destruction step on a
> random system wq, which will outlive the driver instance. With bad

I understand that job destruction is async but I thought our ref
counting made this safe. I suppose we don't ref count the device which
is likely a problem.

> timing we can teardown the driver with one or more work workqueue still
> being alive leading to various UAF splats. Add a fini step to ensure
> user queues are properly torn down. At this point GuC should already be
> nuked so queue itself should no longer be referenced from hw pov.
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2317
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_device.c       |  6 +++++-
>  drivers/gpu/drm/xe/xe_device_types.h |  3 +++
>  drivers/gpu/drm/xe/xe_guc_submit.c   | 32 +++++++++++++++++++++++++++-
>  3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index cb5a9fd820cf..90b3478ed7cd 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -297,6 +297,9 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
>  	if (xe->unordered_wq)
>  		destroy_workqueue(xe->unordered_wq);
>  
> +	if (xe->destroy_wq)
> +		destroy_workqueue(xe->destroy_wq);
> +
>  	ttm_device_fini(&xe->ttm);
>  }
>  
> @@ -360,8 +363,9 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
>  	xe->preempt_fence_wq = alloc_ordered_workqueue("xe-preempt-fence-wq", 0);
>  	xe->ordered_wq = alloc_ordered_workqueue("xe-ordered-wq", 0);
>  	xe->unordered_wq = alloc_workqueue("xe-unordered-wq", 0, 0);
> +	xe->destroy_wq = alloc_workqueue("xe-destroy-wq", 0, 0);
>  	if (!xe->ordered_wq || !xe->unordered_wq ||
> -	    !xe->preempt_fence_wq) {
> +	    !xe->preempt_fence_wq || !xe->destroy_wq) {
>  		/*
>  		 * Cleanup done in xe_device_destroy via
>  		 * drmm_add_action_or_reset register above
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index 5ad96d283a71..515385b916cc 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -422,6 +422,9 @@ struct xe_device {
>  	/** @unordered_wq: used to serialize unordered work, mostly display */
>  	struct workqueue_struct *unordered_wq;
>  
> +	/** @destroy_wq: used to serialize user destroy work, like queue */
> +	struct workqueue_struct *destroy_wq;
> +
>  	/** @tiles: device tiles */
>  	struct xe_tile tiles[XE_MAX_TILES_PER_DEVICE];
>  
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index fbbe6a487bbb..66441efa0bcd 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -276,10 +276,37 @@ static struct workqueue_struct *get_submit_wq(struct xe_guc *guc)
>  }
>  #endif
>  
> +static void guc_exec_queue_fini_async(struct xe_exec_queue *q);
> +
> +static void xe_guc_submit_fini(struct xe_guc *guc)
> +{
> +	struct xe_device *xe = guc_to_xe(guc);
> +	struct xe_exec_queue *q;
> +	unsigned long index;
> +
> +	mutex_lock(&guc->submission_state.lock);
> +	xa_for_each(&guc->submission_state.exec_queue_lookup, index, q) {
> +		struct xe_gpu_scheduler *sched = &q->guc->sched;
> +
> +		xe_assert(xe, !kref_read(&q->refcount));
> +
> +		xe_sched_submission_stop(sched);
> +
> +		if (exec_queue_registered(q) && !exec_queue_wedged(q))
> +			guc_exec_queue_fini_async(q);

I don't think this is safe. Jobs ref count the 'q' and if those are
flushing out in the scheduler that seems like it could be problem is the
free of queue happens while jobs are still around. At this point all
queues should have 'kill' called on them and are naturally cleaning
themselves up.

Can we just wait for 'xa_empty(&guc->submission_state.exec_queue_lookup)'
and then call 'drain_workqueue(xe->destroy_wq)'? The wait could be
implemented via a simple wait queue. Would that work? Seems safer.

Matt

> +	}
> +	mutex_unlock(&guc->submission_state.lock);
> +
> +	drain_workqueue(xe->destroy_wq);
> +
> +	xe_assert(xe, xa_empty(&guc->submission_state.exec_queue_lookup));
> +}
> +
>  static void guc_submit_fini(struct drm_device *drm, void *arg)
>  {
>  	struct xe_guc *guc = arg;
>  
> +	xe_guc_submit_fini(guc);
>  	xa_destroy(&guc->submission_state.exec_queue_lookup);
>  	free_submit_wq(guc);
>  }
> @@ -1268,13 +1295,16 @@ static void __guc_exec_queue_fini_async(struct work_struct *w)
>  
>  static void guc_exec_queue_fini_async(struct xe_exec_queue *q)
>  {
> +	struct xe_guc *guc = exec_queue_to_guc(q);
> +	struct xe_device *xe = guc_to_xe(guc);
> +
>  	INIT_WORK(&q->guc->fini_async, __guc_exec_queue_fini_async);
>  
>  	/* We must block on kernel engines so slabs are empty on driver unload */
>  	if (q->flags & EXEC_QUEUE_FLAG_PERMANENT || exec_queue_wedged(q))
>  		__guc_exec_queue_fini_async(&q->guc->fini_async);
>  	else
> -		queue_work(system_wq, &q->guc->fini_async);
> +		queue_work(xe->destroy_wq, &q->guc->fini_async);
>  }
>  
>  static void __guc_exec_queue_fini(struct xe_guc *guc, struct xe_exec_queue *q)
> -- 
> 2.46.0
> 

