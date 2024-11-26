Return-Path: <stable+bounces-95574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7ED9D9FCE
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 00:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20832836E3
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 23:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD48189B94;
	Tue, 26 Nov 2024 23:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYpiGgY2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFB51DFE11
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 23:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664697; cv=fail; b=f4X/1+yR4h3Q9ARcI+5Twz9mpq1y5eMgXMnD1I5GfTJKs3kMkoKGY32pAoYE0lvZ8w2DVbAIImUL9lD/Jom50FKjiFLNcEdIAz/ultgE7ubCA+Ee40CutnP9qFCs9phbJoUGVgVV6P/+40axX04dlDfriWL8EekvK5irAkPfj3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664697; c=relaxed/simple;
	bh=6rrTdHaNolgRl5jjrMGm5/HZbdF3MV97FPPl5s9f/jY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R/oF1tK9n3dnzlCKbj56XPsrUJPldlawx4AKbyNLuxz6CHXBJ7U912cke0PkHmuWHmMDLl/RMa/QA3fELXESUSCn6R5kWBrQu6QoSI9kzMWgUedHXMJpfTJD2QejVxduRTlSplZ5sY+tnr2t5KFwW6N5dumIfIWZyYbfsEBCDZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYpiGgY2; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732664696; x=1764200696;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6rrTdHaNolgRl5jjrMGm5/HZbdF3MV97FPPl5s9f/jY=;
  b=FYpiGgY2nEu8PSY2sDftl7HNaqxtBK5Z1QqTQzproVqvOuWfnAXVVTC3
   V82tHX7B/D38WiTLTd0PbiNImrBkQwzhRmF4tGqyi19afseSrTALFB05F
   vR+SifWBHR+r8WHdzVCzVPoeqOWylVsMziMN87ZhfLiD1wqROZgRD7/Cl
   VZk29baf87BC7jsLR518Xv1t9Ot3knUwJLNq2EUMRdkFup8p+J8re1aTx
   wFbKsdcZal4kk73bFJ8pyjEmliYMpIji8ph2pUQPi+Fr6xOxQTZntObYy
   DXKAtvuLt4gNIC08M3v8enWiBx9x0t70RuSrLHtg1eOtcRVruZt4USFpP
   Q==;
X-CSE-ConnectionGUID: 3U/u49GjTYiUs8HMPTExgA==
X-CSE-MsgGUID: xj52lHaSQae8kDtoh55udg==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="36640462"
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="36640462"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 15:44:55 -0800
X-CSE-ConnectionGUID: oEjV9fVzR7mhnUTq2/JnFg==
X-CSE-MsgGUID: d0elM0VGReGsIXxa7AfEjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="92087969"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2024 15:44:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 15:44:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 26 Nov 2024 15:44:54 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 15:44:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXLU9GD+ER4iDbUpvQiZGnD1Be4KctlrKiDC1HWGQhFhJkbE5zsa2QYUMiwtyE0RvjS7ozuHrzcO6lENbGAkyPZmbXLIFRo49CRU0eGE2J0pqZohmDap81a8xl6ULTZUKiPDQgX5V0j0L0cPoTSFsmuFBQz2KKFb1ijeoRmYotrWmE8jP2tkNXxhBN0JSQtZvj3CAaHloyqLr7sFttibPOgTooFV1rJb333k5MIBYrNgcVntfWoFDPfFt6Aoi+aacUvbFI2uKRftKHswH6UPMziXt2f57lxhn4XIhEBYTNe7wE3rfnEPJuk+aVNLgpOl21346Nc5B6FfdrVgDZggJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnUwrTAUT4PIzGnT5C6N0l0eUeuBPPRLDnIlVxfe/k4=;
 b=h1sulihxBGGaGR5Q6TvYpRx6t4QNWLNDFcjMgSmhorVP5W3SGKwiF2RCXaS2O0yP4IJb1nBL+YCXNCUNP4wwyBDP0k1FTW2GWhyS1jEuAgRvMCTm6AVHBAAgj4+WW2TmgWNMk+Kk7JDLSBoGrVIyqlw2iPCrCIEQfJu0caCqAV2mNNj9/32sxZkF1h59L/jpBg2iZypiqhZBb44FfcJFrUuAfaSTogzWlHEft48FhHlIcHV00Bapw1mZYYAHNgmnyQ12rzxEbwMD7tiMWwRU7Y5KKftTyZXF/57gdl83hYb7QeI2vYZX0YFyOwiLvP3EF9p7mPCA1bZymSqtptWqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by BY1PR11MB8031.namprd11.prod.outlook.com (2603:10b6:a03:529::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 26 Nov
 2024 23:44:51 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 23:44:51 +0000
Date: Tue, 26 Nov 2024 15:45:29 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Nirmoy Das <nirmoy.das@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/xe/migrate: fix pat index usage
Message-ID: <Z0ZdmbT6DCKTG0Dk@lstrano-desk.jf.intel.com>
References: <20241126181259.159713-3-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241126181259.159713-3-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::24) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|BY1PR11MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9c7565-1704-437a-64dc-08dd0e745226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dUw1FswDmZGHU5HwpNaNfqqZ/UQpXA2xkt5KE1pn7ElKjfBwxA3TNfmjmS/C?=
 =?us-ascii?Q?/tHQops1QbwNO5DG/yrX6RxzrywhR1qOr47WUGtWVA/488YFPjfwnKcsNOEs?=
 =?us-ascii?Q?EhVHnAQTA5WZB0D1jW6ZdTcJg7IVPLzi81650QRY6eLPYluNFVCLr4GLRJ14?=
 =?us-ascii?Q?HG9LR/Oyf4dVakLgdylSyQyCc4dwFK9lVWT5Nb8J3fPlF4Y/P2wsWTL92kYJ?=
 =?us-ascii?Q?XcZKttNsbiJKoE+7X9QwaAvuQwPdfF6jEAMAEsqP07ERSnJqGDT5ez5KS4wv?=
 =?us-ascii?Q?yaNsI3a2io9EYOadt10OgNThqIiNLPsRdYT+jks0GUb+pkd8eHvqRHX34LvM?=
 =?us-ascii?Q?9NsaqkNCKeaQ7eBExZ20YuD+hp0W2ohNGUs8GVANJLLlfIbazdgzvFpSXk5g?=
 =?us-ascii?Q?6xm3W8m4vT0Cqu0tqR/9RBcYlnhaGkGC5LAzGG4+827DkXUuJYVcl7H/HB7r?=
 =?us-ascii?Q?qlEqUqghPOmPdA7vHVTljrRmEzbU4x8ysVh5g3Xdhyt/kWsCwV5qGJ8CZ7FF?=
 =?us-ascii?Q?TZ2AvQDaOCpUMaaFkC1Ur655QzS1zKEAqJrVReswIjvJmep9uJxxmkRqbFqR?=
 =?us-ascii?Q?9OuQsVwP9ZsHCbosCGVg1LKaGVHFcG4TvgDYZZaqnGmFozsNz14Lex5HhJWW?=
 =?us-ascii?Q?KRXKqoaeZ2pBNM64+dyj40fCDaSzQzQWccOlYgt1SRXQXVmREWz3cdDXj1Gr?=
 =?us-ascii?Q?Lwaj6WgvZOSgWpVOWA4bDKaJfa7O73yBvV8FZOb9W5iWa+MDNnaO6tkSG5Sy?=
 =?us-ascii?Q?T4ewL8UX+kP6/O63LQJAMkMYVoq1xEO8ws+8ztHSuHDazCtJqhnSMpRi6mbY?=
 =?us-ascii?Q?2kPHiEnjcy8LQ2n5zzfu4RJlNoVwERqo5oS99uGG97UvNGqDs8S1G+Ln5q8P?=
 =?us-ascii?Q?7VEIpUGTjqW6JqoMCWloyoo83GPBWVLtdFIHs6OTXnCS3NUOlymowHkkeHgP?=
 =?us-ascii?Q?CDu4GWoGc3gtGeStzibPWHaX9QMoCwpexJiofztJ9rCUQVCsa6iSLeJkKTJ5?=
 =?us-ascii?Q?S4GomWpx18wZVIjSMpeqP+8RTSsiDq1OaGust8MJCL7Yjj0EUS4kbU3v2jnd?=
 =?us-ascii?Q?8vLRufFXgoAJGxlhuA/g+LJrk5r5IQaK9xWhI0TJ6B5zzgtUXWZu/2fnFEj7?=
 =?us-ascii?Q?CNQhFV1qDrgeu+kSXjAbLPFjft93fm4PMYEL+aOucga6gxOUTN7cWDa2xR6n?=
 =?us-ascii?Q?Jzq+az5rPxVWJ8MNPEyNDy/nB5B9/YlyinTFPnh+YqtAxv3f9TQWE25jF1Pf?=
 =?us-ascii?Q?CqHhUodEtQYFab5SxkQnkFCMkzfgw2lU9pAEFHNwd1XYXsIAM3pQ7At9jgUt?=
 =?us-ascii?Q?xIEy3ofTArla0HtBZPsToFs+KJYrlUFn8BGTWBHYVW/3eA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hJYnVAQjAKRrQoIptnJ+iZdbGeHxwwFYDMmDiRYNEwRiByrDOvG+FNg9XoRx?=
 =?us-ascii?Q?DCbvkegOxJSyBkZt8HoPVi06jCF9SCRxaF/AMTSTJyh6HrLMmbihz7//H4TI?=
 =?us-ascii?Q?ntFD90MFOSRIoLOv+fjT5se/CQGxzumW79U14NnaKD3DSuZ4Azj5/vAqcS3s?=
 =?us-ascii?Q?b56AlEdphzVp3BSKBZdz9CSRm+MF16Ix3YItXOGntGNZevy6iC4DD7NlLbtR?=
 =?us-ascii?Q?vAavnZVd7QwVzlI6lisngs8j6gNi7EDM+bDnwnFZEIVdMNhRhBvEVN0ROwc5?=
 =?us-ascii?Q?KcTE+wL585GQH10xSgJLnNDhLT43LkCXw1c055s0i6yZdREFCzil0ZmlYPBE?=
 =?us-ascii?Q?xl7C3EW7AR3nwaaJOY+93c+P8UOK3bvK/6o2cXrpeK7kYw1527+GDnvnqHI+?=
 =?us-ascii?Q?VBkWUcPdamigBysFyTFg9bceI68Ev7ZzPFF2weSdhKEq+vJuvNlyzkydh1SH?=
 =?us-ascii?Q?1zBh/J8kFdZGFi1wyL0VUNqsTSjJK832Ely5G3hTv//4VE16oteB4syU1d85?=
 =?us-ascii?Q?LthpdeLSzLA7vp2FDhF0TS3Q301cF/Tgk2o+PjzLkze5c/ziXN3KjGUF0YhJ?=
 =?us-ascii?Q?B+IZR0t1rsvUnD00U5ZxhysqtPQS27LlnqzvxJz+a4Fp+8l8gRpCnOpJgKpe?=
 =?us-ascii?Q?GiE3cgS4Rez6LJkNiITnEofbkrg+QK/awoviQb0/8YbShaXOVfgCk+r2rLWV?=
 =?us-ascii?Q?bOcZFlKk1bVTSWQoZ/pBhIdUX7NY89VTqP3Y16ICV9J+Hb+V2PtHqD9nx0qV?=
 =?us-ascii?Q?eyDl17QfpL+bVaXpXZ5l1M/d2eaTGseNUjAwDDShOAdZck3c7WwIwB7a9fna?=
 =?us-ascii?Q?hkL2qnlA4NPCrnzBbOUHVJEDy4MRV/jX70xj4GJXGBle4JOe7DtUsSe7Uzxe?=
 =?us-ascii?Q?EeDUhGRV8C1tANh3Eq4uSvpCCGkagQ637ysfHdOnKVpGJUcbcppUP/F3vlQy?=
 =?us-ascii?Q?+wnEnX8ZDbblzSDl8d+zTuvl/SvP5GGdICllIJdqf+kwWq5mMyEJgiSfcGtv?=
 =?us-ascii?Q?itfsoMRlLTxu6dERUiSG+F1Rum7rLiNefyoAkHteQGj3iKkFldqT87ZTK0e/?=
 =?us-ascii?Q?nZ1YhriFq10tVwtn5rRw85FNkkKraCVPNtpt2yqHGNDCSBDyJs6MdKwGPMI2?=
 =?us-ascii?Q?MADcpQYL4XM5tJo0buwInky1fnqjTCN9vEeWyrxsKYja6r4tw+e3xJWKK8EE?=
 =?us-ascii?Q?UWlOsk5IsITEyI1qLf5hLQCw/x0vd95ZpsQUMw2Ve36OCJdSiuNKDZKwikbe?=
 =?us-ascii?Q?7pWJPp6atiiGizbzNTwHP0FUJkvyziLBU6V27eRXwv2l1Qxu7xW8xXXwXl2X?=
 =?us-ascii?Q?8D6yymZL756E9ZF61U6gq1tgYyJ86Hq9droy4kBGNtoUbE8pg8Ki85q0xdRX?=
 =?us-ascii?Q?fL3kcFei7eAtJu+vuAw8d7y+gVNL9PVi5oXUV/EMlIYPR6R4td6OEMdfZHFN?=
 =?us-ascii?Q?cbfnj3jAuc9jty4yvcr8lQMlNVCGK+7Z12FeYB2VmwNGGMNaC/L50daWNNW1?=
 =?us-ascii?Q?/7OWy901cU8Mi+mFkf/t2VGbIHpB7QzCaC/oeAa2yWL4wa4tdnPgbgjb57M4?=
 =?us-ascii?Q?pScFlqJXH77gDIkRqbjKf5IBrdZeBjGY4pnQQFcCQJ+Z2k9j3x8tiaQ8exL0?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9c7565-1704-437a-64dc-08dd0e745226
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 23:44:51.5084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3aFeUqHoSmNzsdpbd+mL5E32nmvXwsmdxS/FPRwPKHyuSqQenBFl848qdFF5qUtb0Qsolza6heKMtNYF1qzbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8031
X-OriginatorOrg: intel.com

On Tue, Nov 26, 2024 at 06:13:00PM +0000, Matthew Auld wrote:
> XE_CACHE_WB must be converted into the per-platform pat index for that
> particular caching mode, otherwise we are just encoding whatever happens
> to be the value of that enum.
> 
> Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into single job")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: Nirmoy Das <nirmoy.das@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> ---
>  drivers/gpu/drm/xe/xe_migrate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
> index cfd31ae49cc1..48e205a40fd2 100644
> --- a/drivers/gpu/drm/xe/xe_migrate.c
> +++ b/drivers/gpu/drm/xe/xe_migrate.c
> @@ -1350,6 +1350,7 @@ __xe_migrate_update_pgtables(struct xe_migrate *m,
>  
>  	/* For sysmem PTE's, need to map them in our hole.. */
>  	if (!IS_DGFX(xe)) {
> +		u16 pat_index = xe->pat.idx[XE_CACHE_WB];
>  		u32 ptes, ofs;
>  
>  		ppgtt_ofs = NUM_KERNEL_PDE - 1;
> @@ -1409,7 +1410,7 @@ __xe_migrate_update_pgtables(struct xe_migrate *m,
>  						pt_bo->update_index = current_update;
>  
>  					addr = vm->pt_ops->pte_encode_bo(pt_bo, 0,
> -									 XE_CACHE_WB, 0);
> +									 pat_index, 0);
>  					bb->cs[bb->len++] = lower_32_bits(addr);
>  					bb->cs[bb->len++] = upper_32_bits(addr);
>  				}
> -- 
> 2.47.0
> 

