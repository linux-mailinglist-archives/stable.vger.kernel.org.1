Return-Path: <stable+bounces-43114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DB88BD043
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 16:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6FD28CEF0
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446D581211;
	Mon,  6 May 2024 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k77lD9ES"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8CD1DA22
	for <stable@vger.kernel.org>; Mon,  6 May 2024 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005698; cv=fail; b=VdcJ9vsQVb0g2GEX6v0IMHOeNsgmFyteq12xItQaqgR3RR0V/AvlRw4EJrLzoN6P2KHWEbu88q620/7qVCcwhyyO2jyMyF/VoC06kmuBQFCfCScVAsQVv/NLgzYzntRhP8B3eVh8Zr086+4GcAXBw/IGaeTPfIGYjhBh/1w9LZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005698; c=relaxed/simple;
	bh=Qm+5EzReiqRoyOoeG28NDB8GozmflQd1+uaqYs14Rww=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CUnDbFmi99vN0zWFcTQ0Z0oIdg2j4K9R/7B7U2e3w0QAiJjoqguv3F8xQR7f3zpZg+2Q2m2Xti0uKbHlNcx6F7XvXmEgBRs0+SUeD6pXT/DhY1PDpJkZ24KAjmIGf/sPgmYP/w5xrBZ3KgMEK58eEd7Xw3w1BoN2h8TGDp8ncfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k77lD9ES; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715005696; x=1746541696;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qm+5EzReiqRoyOoeG28NDB8GozmflQd1+uaqYs14Rww=;
  b=k77lD9ESYy5ZWMXp37bUHDvi5ynISx12cwg9fj2SS9Hh+U5nzZ4BPxXr
   fZMlB9p9gXGPlJPRjcKR2gBxOb2EHBiWGUBxR+BOLUatv3FEgWXeDiYIL
   UvhXP2py7UHc51/2Fvr+J76bmMDT6QLzzy1BcA2ftWzIqpgq0vUn2ehL/
   W2zyXeStTjPLNgnduUVYAvGBjor7cHh4BZhrnU/TkGloi4x5b3Fu1ODme
   u9us9rLn4iBkOXznRtsSJLYtQ/FcaC/G4Cf1DIoh9XA3EHgMn4S3VPBGn
   FUmXTKxSddDlZIUflJoswPZWTCrqTwNLYujlqEygW3k6sOaK37+NQilBW
   g==;
X-CSE-ConnectionGUID: XIJqWae5Qh2TaKHiSncYPg==
X-CSE-MsgGUID: WgMuoLfKS9eBo49qIPM1aA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10913138"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="10913138"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:28:10 -0700
X-CSE-ConnectionGUID: CEXgRLxwR2qVeBsRHFgkBw==
X-CSE-MsgGUID: JONBZJpWTn2EEnQ/Ca0uqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="51370616"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 07:28:10 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 07:28:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 07:28:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 07:28:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zpwz/Z52ulsmQqvj/Tem82D6nEafqbwI5KlOtqZLkPpogx/lHPmKpKEsPF1ZxLF5RI9uF3dkQVANwLKr3SGXmR8ZEN/yylIy4ZzauPs+aBCf51hVo+JWnT8pzRgRw98h97V9gfymhDjMkznSg1oewKYQqRed+RXFoIOSaUwdkeqKTiD0iVwzFC1PwmANKk1c/oO+TMRdA46yYuPp9LAmATd4ehS5mYYx/5VoJa5hsopsPEJupfYmeoll+dsJ5xv4qtNT78Aodv/3Al8TDHYE2MaNNMpvy+E+QI7iSrxMYdyQOxlV80R7JUyL8cKMPwkY4SxBzIJ5j3ALJgC1A2Ew2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPU/Vss3ALLcz6jGlzPH2hcay5b0JzlLQP8sSYK+UhQ=;
 b=SHWPplBFMOt17cF8zQq9ng8BGj/NV9V4qWsZWDPQCB/SN9LIixyJE+fPuYhz05n7gs1lJ89/RSQylJzKr5jnwbv+abXo4bMRky0URDDfZnDYXu6Jur5nuL/WayWJT0PuCkGJ7vkzq2AaJ0uWIBUzkJtui80FCz7df9wTR1AVe6ah2odjZu8fr8HslkHtmyc3sqqZmr62wMSpgwCEhbbQ91HcHC0B4r3n8JcCSVHjnimwGfKQCu/B0j0qosTJvLtGS60qubnIfvRIUJZG5ztVXtQ4sKqVbdmYeFaNk+LqUexMjXSsp2x2hFsS4Yo4bm7rHHZwv6XuenEe8aarvPrNmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7838.namprd11.prod.outlook.com (2603:10b6:208:402::12)
 by BL3PR11MB6316.namprd11.prod.outlook.com (2603:10b6:208:3b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 14:28:07 +0000
Received: from IA0PR11MB7838.namprd11.prod.outlook.com
 ([fe80::5fad:8088:ff14:93eb]) by IA0PR11MB7838.namprd11.prod.outlook.com
 ([fe80::5fad:8088:ff14:93eb%7]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 14:28:07 +0000
Date: Mon, 6 May 2024 16:28:01 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Use ordered WQ for G2H handler
Message-ID: <Zjjo8ToY-YGrsld_@fdugast-desk>
References: <20240506034758.3697397-1-matthew.brost@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240506034758.3697397-1-matthew.brost@intel.com>
Organization: Intel Corporation
X-ClientProxiedBy: MI1P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::16) To IA0PR11MB7838.namprd11.prod.outlook.com
 (2603:10b6:208:402::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7838:EE_|BL3PR11MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b29cae-a9de-41e0-caed-08dc6dd8bf2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lPqw0gW7noWaEqK12CcZg5M5zmWmCOi4AQm+4P8mxex2npoKAVlBBkLhC3We?=
 =?us-ascii?Q?CAVXyObYatzU+cM6G/h4W9fJmKHLg6uM3AjGJCZcOhh17hFdZLP93nP6Wzsz?=
 =?us-ascii?Q?syqhSeWQb33bTkM73Wha+DoiLpjxJon4QHrOmRY2lRLeHbwkYWbkpHQ/ur9a?=
 =?us-ascii?Q?oyDcZpFqhKi7nSHXJSsPZ2fu8ZFRDWPg+HRm/vyO/AuYFDDQnGuEKYQ790dC?=
 =?us-ascii?Q?MohJqRZzV0zKTkgE+ED3tF/A4JN0u617S/ai59Z/8hovggMex1vRthxYuEOH?=
 =?us-ascii?Q?vhYbOkPMnktTgxX8xxckJs0+rstBQKVXpwsxe+KkbAHpbifN1fde2WGSkquc?=
 =?us-ascii?Q?VgslnFI5dJVaoIeaks4Yvfv5n2vEbz4sLyoikvsISByQFwKwc9ask+cBVvX2?=
 =?us-ascii?Q?eJ7X5ZYuaMKJnV62jbPEE77Bdy2qm4pqCeWreKo6sFKirb+PnjtiIrojG7aD?=
 =?us-ascii?Q?vmkmq8j3ijPoizbQrIzp28joDjYDyxhlqDjZOB4DcqLvwGQUpt4oY3jvZj8h?=
 =?us-ascii?Q?focXZhkBcqsnnnWpjCekp1F1HIGIrhc47Xv/E2BKiHXWsV8tDffonbAKZ0ne?=
 =?us-ascii?Q?YBR4EKCM77lnUpSkXNwz6dEo365dVeBtslhc8ftuZWPcnH66fqeSc6bdW7SE?=
 =?us-ascii?Q?93KiQDlMxIOMHeG+VORs5+hub3g46+teD8tx/R3Ni4KN1iEqkE6uOvmrgcUw?=
 =?us-ascii?Q?rsNQyyqxx4FohRiWT7otViFbocKphgcjzUps6VoJtXtdv5S8PJ/f9h6nDa87?=
 =?us-ascii?Q?ELL0nLoSOlJ5BzOa696peUkExxN1dMWuiw/YIE/qrENY/GC8dDGQ5f3KyKbE?=
 =?us-ascii?Q?p4uy1F6QSudTHehbL3qa8uzYGJ6MzzGld/Ol94bYNzzJEo0JZCRGhYPuKnvR?=
 =?us-ascii?Q?qJBb3tsNh475xlclHOtSVdovzgM7HyboBRMuIfG7N7kg7lqt89ah6M9b3/Fw?=
 =?us-ascii?Q?2YLYpuxgpCq+RxhsJXXCdvG3BFMOKSMIK5aVdRLAu/UMziAC02L9ZUXEM/9l?=
 =?us-ascii?Q?V1AyLCNmfCZ3jcUSHnWf2vlDb81Vn5jh6svYdJ93G6BSxhYMALsdZ3FJfdO5?=
 =?us-ascii?Q?+N9RIBe5zEjJTdzWzfy7j3M8IBUbaW6ZFLh6KUL6s1QcbBx+uxSTUM+gSLfw?=
 =?us-ascii?Q?cNu+jIxThQT5rdAzZ07PZBPBiCef/dwlTPDbCNW+vMpICnmp0gQ5Iquu+2YK?=
 =?us-ascii?Q?6SjkEzsxYkWhx/Wr7KDIILWwWRLg3jxwZj2q6RMDjCNA1dv+0eq6OEVFKl9c?=
 =?us-ascii?Q?ufPVpgdh+EtII5ZRApqXhlJX5npiP+lFD0TANGDlqQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7838.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hrJRp/6anWcaZMKzpsQ9r75t1bwRt2iBb6h9UxjB+44Nf7I8qq/KJf5ogKHc?=
 =?us-ascii?Q?48UUMS4sFm4JDNPkmBEkNd7SJlDXb8YOcstyfZY4ZFZDWHKN7wWsADXzN1oi?=
 =?us-ascii?Q?6IjRmUsfpxJubS2oH2SFmBuhXVqnJoapevFruhuKiDpML3qfTMOPRHZCTi1v?=
 =?us-ascii?Q?dVPXmbWEWa5czGwoYr+iYZ0Eui4C0PSou4Qz05y8uf2h93CCG0gdKSVtCGtn?=
 =?us-ascii?Q?GjaL9qI7nwPc0kmiBCHjcqHstXYB8axNdBXskIQc64/d1/5zmll2EvhLOAPI?=
 =?us-ascii?Q?djwRZWUqPOISaMC7Juf8MHtVRosQmxqyDFpk1xsVEwVnhoUhozaXvEdcUNq9?=
 =?us-ascii?Q?Q98ddzCg+KtxCgzyxf+D31TYypPi0hh2t2gzauQEMcF1OfaJn7jZjn/v/lzD?=
 =?us-ascii?Q?/x4G04AsW6zQKLtzcOIdaK+/qoG1cvMnapxXAiMASoAomTmZx3SnPeWjjlyb?=
 =?us-ascii?Q?F3fSbog3wWMgYJHQ8GtKPMZuxQaU6uTZXSrtu+AZ3UYpsXgsh32LGwvcA+ug?=
 =?us-ascii?Q?aza7+ksmz9iSIG0F0GDC2K6yPu1KQa+jAQR5jVgTmP/3uREYe42lhgWXvoDs?=
 =?us-ascii?Q?IWOg12EHFvzywL4VZacYr4JjshXx4q74iOt4rp/L6EnrHwe3fPHWsR8dBjCJ?=
 =?us-ascii?Q?12txaS4N7/dTKC9a0yP1z36nmV8Jlj7FrPMNzgpcDjBYmOs5L4jZXBP2aIGF?=
 =?us-ascii?Q?At3zomn2VQZQemknZT/WivdIYhyDtKIQmJAVS8nfpzwK75U7pB22lMvUmq62?=
 =?us-ascii?Q?oIL0w7hHa2jNE+mrMA+UmhM9YE4yR9czJX5wXvXfi42bIcbUZejciMHYcH87?=
 =?us-ascii?Q?Y48RZDiCSO8uemYFfjeSkMbq6f+AruCWqtPZnUm9MIR97MY9q5H2N4qLizRp?=
 =?us-ascii?Q?Z8KUP8t859xUaVaJoOS4PZ0NruwkmnOZ6pA2jLVWJlVCzCcV+TY6U9p15/hp?=
 =?us-ascii?Q?0/Z43LIVT4fm0B6/UZXf5tYr9NFVrgxw7K9j0mTSg4cHHsutbI2zU6OGfJTU?=
 =?us-ascii?Q?mrm8gjdNJrmo4XKWi7JJDBTnXejHQIWU8LZk7TilVSp+gCUnq29BAbZv9s7/?=
 =?us-ascii?Q?E6Qo2fTJFGtwPPr2XUCNqPsXuoXKbbNs9EFHPh46IRFKFFNzul+13UcFtHiW?=
 =?us-ascii?Q?T8eoQULbhqUkHJZNOSbyZjO23bCiBakqyBgOS259JWvrgTIhgcAtFaXdzKaN?=
 =?us-ascii?Q?HT/qsX3Y4KmX4vY3X4rH+v8SosPasHrFVDAZFTDMyEuH9UFKuiXmXBgBWafz?=
 =?us-ascii?Q?P4qOt/d7RFYUhhCOto9AyZ9k1bb4qvt6++FI6xxBr03rSJ/5md9m55YrvhBH?=
 =?us-ascii?Q?YhHgG1tCKLQeSiZ9LFl59pmwtpm3mkashnXVczLMMnbLGtYOsWAKybk6pkca?=
 =?us-ascii?Q?4pyp5IGoRXUUK1/3hpJ2GWwRuVuNQ8+b2mOSGMiXaUhvaUa1OY7L8vMYEngx?=
 =?us-ascii?Q?pvlJgivbRem4OoXJUDAuTSZW19ryb22R0vfEL9LPFOLBJCRO8DW/VySRa7v5?=
 =?us-ascii?Q?koHK7Kb05Ih+V/3DxaUeFGCLhW/70vzgk8wYRTwEW+rQk6Bg4/9z2U2KAPah?=
 =?us-ascii?Q?imGyqyS1vsYZ1bUq07u+9ZwG0be6t/8lOms2pXaC087O0fEoYl1OFtU3SzNE?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b29cae-a9de-41e0-caed-08dc6dd8bf2f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7838.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 14:28:06.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ducQ4gO3XKDBjAh9D2bNWTC0N+Hf2o81a88KUS67AaWshqsVz/PpdW4w8rTb2Id2Dwh6f6W7uhMfE/KtFTXsl1ZBFKDoV+YiV5Ju2euz98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6316
X-OriginatorOrg: intel.com

On Sun, May 05, 2024 at 08:47:58PM -0700, Matthew Brost wrote:
> System work queues are shared, use a dedicated work queue for G2H
> processing to avoid G2H processing getting block behind system tasks.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Francois Dugast <francois.dugast@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_guc_ct.c       | 5 +++++
>  drivers/gpu/drm/xe/xe_guc_ct.h       | 2 +-
>  drivers/gpu/drm/xe/xe_guc_ct_types.h | 2 ++
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> index 8ac819a7061e..cc60c3333ce3 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -121,6 +121,7 @@ static void guc_ct_fini(struct drm_device *drm, void *arg)
>  {
>  	struct xe_guc_ct *ct = arg;
>  
> +	destroy_workqueue(ct->g2h_wq);
>  	xa_destroy(&ct->fence_lookup);
>  }
>  
> @@ -146,6 +147,10 @@ int xe_guc_ct_init(struct xe_guc_ct *ct)
>  
>  	xe_gt_assert(gt, !(guc_ct_size() % PAGE_SIZE));
>  
> +	ct->g2h_wq = alloc_ordered_workqueue("xe-g2h-wq", 0);
> +	if(!ct->g2h_wq)
> +		return -ENOMEM;
> +
>  	spin_lock_init(&ct->fast_lock);
>  	xa_init(&ct->fence_lookup);
>  	INIT_WORK(&ct->g2h_worker, g2h_worker_func);
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.h b/drivers/gpu/drm/xe/xe_guc_ct.h
> index 5083e099064f..105bb8e99a8d 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.h
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.h
> @@ -34,7 +34,7 @@ static inline void xe_guc_ct_irq_handler(struct xe_guc_ct *ct)
>  		return;
>  
>  	wake_up_all(&ct->wq);
> -	queue_work(system_unbound_wq, &ct->g2h_worker);
> +	queue_work(ct->g2h_wq, &ct->g2h_worker);
>  	xe_guc_ct_fast_path(ct);
>  }
>  
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct_types.h b/drivers/gpu/drm/xe/xe_guc_ct_types.h
> index d29144c9f20b..fede4c6e93cb 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct_types.h
> +++ b/drivers/gpu/drm/xe/xe_guc_ct_types.h
> @@ -120,6 +120,8 @@ struct xe_guc_ct {
>  	wait_queue_head_t wq;
>  	/** @g2h_fence_wq: wait queue used for G2H fencing */
>  	wait_queue_head_t g2h_fence_wq;
> +	/** @g2h_wq: used to process G2H */
> +	struct workqueue_struct *g2h_wq;
>  	/** @msg: Message buffer */
>  	u32 msg[GUC_CTB_MSG_MAX_LEN];
>  	/** @fast_msg: Message buffer */
> -- 
> 2.34.1
> 

