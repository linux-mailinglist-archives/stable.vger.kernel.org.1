Return-Path: <stable+bounces-33785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D08928C6
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 02:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A8C1F227A9
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 01:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4716315C3;
	Sat, 30 Mar 2024 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXeL8j7W"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24057E8;
	Sat, 30 Mar 2024 01:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711762739; cv=fail; b=uepUD80varlTJRXgUh+1YOsu4upTHxOY+uJQ779+NMhh2H3MeO1xAOxCKNgP7XGPkY19o6VNlom4gTqneOkLvMTwdyU519xPR/BkW+89vDzKvKwGy7YsBtPUtiI/vR1HBTH7I6y57c6gJHt9cSQnGeH067eCIaeUdWZWCtrfldM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711762739; c=relaxed/simple;
	bh=MhvGiLtElwa7iSBNAzIydd4lHaEARYjcYHo2PkpZAkI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rq2cL98dmWZKuKjRjUulFRbZjey1ZY9cpevO87ZHghnmKFPQhaOn3NvHguhWqapYJWdx7O8cbNU9gAdlUuXFojWjGaJUJX1heWfu2dPqxaTf6Ss7LFGvneEA3DMIBM10/nHm18IJAvB5RoERXQ5sy9PyPmjvPBcs6Y/VZVUFZxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXeL8j7W; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711762736; x=1743298736;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MhvGiLtElwa7iSBNAzIydd4lHaEARYjcYHo2PkpZAkI=;
  b=mXeL8j7Wt0QVJ2Ec1RxsYPqueRPfloB/6M4O95ZxQlpsrQuUyjqsaq6E
   RHRi8d2QFcPdYSaHlfxEYje1pd8TgXMN27J/yGUotePIadeZUtqspUN7y
   H3IfGzXdA01LhbnKkiTnj8kOctuQ35jV5zi3RvjUuvJtrkKjzlfILanIm
   Ws7HEUMeuaHqoPYapbXXFpuiK6czMEu39UAG36zvg3N6jHAntckWKvjed
   6BiC0xTVtzuiCCYJbbSxt6TYJ78uUTQCc40duFsscoOrlA9RKSII9BB56
   iLlldwzsF2K8okNoEOXKPIA/CrmndzHLnhM6jPiuZ603jb9csemi5h3Op
   g==;
X-CSE-ConnectionGUID: v2n6uk6QSJe7hh6ck3/6qg==
X-CSE-MsgGUID: eVdioeRyRQy8SwoYVE4xag==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="24418644"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="24418644"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 18:38:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="17191918"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Mar 2024 18:37:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 18:37:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 18:37:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 18:37:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 18:37:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6l2UaJyGYny9VSQjhdXYnqo2TF8AMk6R6YJj7/gZYx+KcFu34FPptLViSl7MJNAifeA+ti5R7bfqeCVsGLDKFtTCELf8OESaaLDkPu8SLIxKVrD63EBueIgMP9nUrS6UN3L+6E81LhPgxLYWcMdsREdDfCsEOj5cB7abquGQooN//iNjiqYIUroI7aT3m5Kp7GPeIDNcVrefYphY1/wFCQxzDZQDCuLZz7zuptZqjhajyLrbop/U+bwR3iXNjm+zesuMLNzBW8H/burT4jugN4Fjr1OJ8cnq1uDjHRi+Mto8ftGDqh2hfH6Q3CXyvVN65TZKEHCRtNt/B31bwxYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Rdupa3XdW3ys7iLaFqD4wgiOyuxSfOH1vZSJyjCOkU=;
 b=PmZqmcyvIPSgi0lwLuAH6LX43h9xo8BoHF+gfMv7kUjF14TfBZo5cwSewPNlJbsu4oX7w242acCt/jn9AQhyJYBh2Nb8h9+yZjPB0S517ZOl9H4B5URNDJNPl6pQd44uwAND8s3oN6Ci92ne+6eBAwcq13ZhoiMQaJ5920rE2Gtrj0kNaRhrseCxq4eyIf3p3ADEaF4kmtMdT5V1puMFhfLcl2H/2W65MmAz4E/aobfK9cUr5SUgghWQlybcRyWH+tYQNZLnXGyBhWLwvI4n9v/TpiFAC3oH/UADqkwX2HNKxKPT5hmLjUGSYqsDMVr2SFCKaqYnnB0h/ABnSVOKhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Sat, 30 Mar
 2024 01:37:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Sat, 30 Mar 2024
 01:37:41 +0000
Date: Fri, 29 Mar 2024 18:37:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <ira.weiny@intel.com>, <stable@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/6] cxl/core: correct length of DPA field masks
Message-ID: <66076ce2ddec7_19e02946d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <20240329063614.362763-2-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240329063614.362763-2-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0276.namprd04.prod.outlook.com
 (2603:10b6:303:89::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4745:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRBnqLr9aJSTBdOEEdowFkuA4nbKL8Gm2r2NLbMx7wfFcIMnTz+fV8RJuziA1RmpnR8JJVEIK+Q4D42ixR6Un3G5sMtKhjfSMEz2RsdFbMqC7XmrdEANhyFLCIP65PQSQqxo9jdU2h204SoeA1e3Ay3PbWqf0bFFjU5xiPWY9M0p9pmKQm9PUfAQfPfot52LtklusLirm4iaqIjXgeOzwkO2QQOaZxsjUec6cbhkEOpvpV4IKaK4/8DNiUs2zjLyZrmZFkXW+aaYf9zAu1Gtjlj8hMqE/M2LxAUcpBLf3tBWw17jn/E+rs2djkZDM22tQOS/Cxb4hl6yzptDn8XqEYfxSxjgdP4dnODKwrls4938Xfx38JfjYzrrFUHi/WcVZ+1AsO38kfUYHCg05dNN5ncX0LxXIod/lgdBZWLKR/NyTH+qRtKjymYJ34ubUJ5puGOsvKEyUKuJ+i8c8iTnA0NRAokZfJ9zWJFDNU0ebdWFDoxz0ke0FXTAkqQzM7Vwtz3ysnw9506YEw71dJB5c6l01OiCedTvLUvKtASV8X4VkPIlJXX3xGJF90tyX/b9H1eYXHAz9fPsTyIYBVbJMhxY8ImMx0LNN1iK5a7aINn5yLU007MiDXJSsJljPCL0iBtFIgXSH9UxUDRBNqUea/AWpFA6xmA+cdiHIjeHlIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TQnlW7MlLmh1GVEpjCwzqX2x59KhxKKxUxNXYPEK+kttCo63mDhooNqFF/AL?=
 =?us-ascii?Q?04QEZwx2Ba2dQfdkl+p52nFen537V2JC2bKzgqEnxS/NoneguiC3Q9lZKbjn?=
 =?us-ascii?Q?NNkEyOWNA5YX1XhN53RGU9OEl8p4DFE4zqr9eGnUt17jtps6Gf5iR87uaadR?=
 =?us-ascii?Q?5O+dHtQc0cZjVUDC9HeKaoL3ZSVmanaeCT+QcEzj+hFoIvwj1aohOnc5jOBX?=
 =?us-ascii?Q?lSxSqGA0cfpeUiZV/CxZxSX1pdtX2xQCSqNfXuKpOae6JT9eOSkEz6THoHCK?=
 =?us-ascii?Q?q/Xp5p71KtI2mgN+bvxd824Aq0whsWVGcwTQQIgzTHWtlmGSYLC187wQxkoZ?=
 =?us-ascii?Q?D3OfkQkdpsnICb7yk8SBzJQmSxoxrlmFNigwU5o9eo4Px/Vehr82NGCEPx1X?=
 =?us-ascii?Q?PbWPPg7gJHya4vphVdO8qjKnDNlZeLqDKqzhH7/hhItS9TZdRIBlkftrTBNb?=
 =?us-ascii?Q?XOCFtEXV6uf2Ww3tN0VAPDCQ2gXbMgVeWyvfjbqpjNsSvEeXJ77fwijlh7/R?=
 =?us-ascii?Q?aLWM2fGD7ibgFaYohsZO7lPlLGRPe3UCvI1DC12bJKAZHTzbfOh9tZCz4uaO?=
 =?us-ascii?Q?rG9WREddDsWVOILjmGhjsV+hf0FfJvTRhqvJtM4BdUFtp1twi0wVGuFQyVkM?=
 =?us-ascii?Q?gCgf7SQyiQadpWXsBnL8wvLn/hXZ/IYc3klUGKWpy7PJvY/LVLrTk5xFuDc4?=
 =?us-ascii?Q?ewnFnL6VhO76yPggr++szQcFTCn8Xm/ewxDO7kAGfP4te5CSgVBdd2ju7BjV?=
 =?us-ascii?Q?LYmdxQrbtsvuEIEgeXsd+viAe9lplRentpHAXf6tqATXXAGiRwLUwktZqd+o?=
 =?us-ascii?Q?Ub0qJciHKUp3onH2xNXQbxt4KlV3jA23FOY5Rpzxr+bw34+WXTddyuUKDs/p?=
 =?us-ascii?Q?eRSDFSF1g62mxZFtIkVz7xxgz+XFfMzZUEYxICbhD2c27S7aqkwi73o8bHPP?=
 =?us-ascii?Q?m3UvuS0eH5+mBUJd8lctHyoyyHty7IES6PUQnU8/Zfve6XT10MvLUmKYEmJj?=
 =?us-ascii?Q?eXIlTsVrfPhsva5NZuQRVS/VqpZshiB7PP0aqHPkxymR3AbCVe12YxY8aR4g?=
 =?us-ascii?Q?/BPCCXQAge0HuoQm8Oxslh3MMtaPkASUo75yImDxuqEFdn3M3hLRAoVZ5WlQ?=
 =?us-ascii?Q?NhBasju7oTsJcT8GbgvxWIYH29WU8C+uHjjluHusbes6bQWyGaQohaDASpuz?=
 =?us-ascii?Q?Bcccfe9ZKpdCW78eAgCt5/+W0eaSRMlHH/r5RI8Yl4AStDoaz/ORiddEoFuN?=
 =?us-ascii?Q?w8ChcubJEk91kgKMtz6nBNj5qA+js86k8gXWBefjQEE83OEhlj9HqdCea7mo?=
 =?us-ascii?Q?q3PE1mee/mvO1rTgTJXvOqNhHhdE2iqS6O0MjNXDc/RMTAY5MJdoqnWYhFqM?=
 =?us-ascii?Q?2gUbP5slv0bIa6py7WJVKCpt2lESkrQnBogikcXSAsswF18Cg0BtmOCqtxmo?=
 =?us-ascii?Q?dXedfEqgIFLpQC00j9XgmDjL3RuT1KpT3urYsNu34DRZxC5fYlX5tCoKwwcV?=
 =?us-ascii?Q?nIEzTRBZYgQrTCjeDZhNl9c7gEZHdCdtVeAaiXfzuIwVka0vUgV8RQx/lew5?=
 =?us-ascii?Q?ZnDKmhGW9q2O6epDVJWPncpFJXLADVOdNhkwoZ2p9V475bnV1R1z9ENiI+TJ?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb65b7a-19da-4096-c9a0-08dc5059fd5e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 01:37:41.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTNRxFN1dEHLxH2uQdtRRneNJIf4osoAXi2KOo4U847fWqgPgkBHDqfjN+pxcXsEeA6VapboH+sQXKreI5ywoogTBmQH7vq4jRNwuQcIyi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com

Shiyang Ruan wrote:
> The length of Physical Address in General Media Event Record/DRAM Event
> Record is 64-bit, so the field mask should be defined as such length.
> Otherwise, this causes cxl_general_media and cxl_dram tracepoints to
> mask off the upper-32-bits of DPA addresses. The cxl_poison event is
> unaffected.
> 
> If userspace was doing its own DPA-to-HPA translation this could lead to
> incorrect page retirement decisions, but there is no known consumer
> (like rasdaemon) of this event today.
> 
> Fixes: d54a531a430b ("cxl/mem: Trace General Media Event Record")
> Cc: <stable@vger.kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/trace.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index e5f13260fc52..e2d1f296df97 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -253,11 +253,11 @@ TRACE_EVENT(cxl_generic_event,
>   * DRAM Event Record
>   * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>   */
> -#define CXL_DPA_FLAGS_MASK			0x3F
> +#define CXL_DPA_FLAGS_MASK			0x3FULL

This change makes sense...

>  #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
>  
> -#define CXL_DPA_VOLATILE			BIT(0)
> -#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
> +#define CXL_DPA_VOLATILE			BIT_ULL(0)
> +#define CXL_DPA_NOT_REPAIRABLE			BIT_ULL(1)

...these do not. The argument to __print_flags() is an unsigned long, so
they will be cast down to (unsigned long), and they are never used as a
mask so the generated code should not change.

