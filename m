Return-Path: <stable+bounces-28637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E33887273
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 19:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4A91F2504D
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B5260EE8;
	Fri, 22 Mar 2024 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHe9CD2K"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7254760DF5
	for <stable@vger.kernel.org>; Fri, 22 Mar 2024 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130458; cv=fail; b=ZFqZp1eAX1bgmYbL9BcShvdyEeo0kG2St9Rj9J4Yzogk0GoNyKxDnuBp6d9JWg0Y9DPalRCL4uIvoM8W3VpFb+KhyhAbGTp5BXLpETe/XJijEsJYbKQ1GE8bpUbufd1eTZPm2fmk2cYkNymt+ZCgBLajsajqrh9lxLoDa6+GTfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130458; c=relaxed/simple;
	bh=ScvOsw/0RDXD8m+cBB5+7r/6sb1b/uvwnA5Yf+YjHDo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NNwFAlRB9ZBXrb5OXMuiyq+LoCaM8eYd3gFeiP6J899jRmWIrm1llJi8aQnpDgspSav9diBLAGjdYkq6x0Sl/7AYRLUaMSLEpIxtaOmVrPOio6tY84PvcUDb+gvO6qx1wGnVLheWzDz+1Vi301ng1sOKcxOURKSPua7l4PHmD7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YHe9CD2K; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711130457; x=1742666457;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ScvOsw/0RDXD8m+cBB5+7r/6sb1b/uvwnA5Yf+YjHDo=;
  b=YHe9CD2KwPIBQnRKZnH6uDlmxk1ZcHVu/HkUFFst7OxETMCLekmlP6W0
   GarLT8KoHP2KDOVrIHQl+viyfRrlQmofnM6cCC92hteQsdG22hqkXCJU4
   l1v7ozqgur5kEqkaSXKurRUSDM/eEQHkFXzcAoluidfJIB2UuHmlyzcHw
   AT3ZQiFWz61NJL5bK9qyaprKpDnUtdxsq5OWwhTKxKmE0LCehUs9KA4kI
   4gbdEFtohcK5+FdOQpKB6/DRizluhIUknG0kOjagUoJ7B9lr2ESS52Sma
   bz0XaRqjc/5QaVraRkPWprWdoz9sHa3EmSnpu68uqJrxAtQbmeyD1LF1z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6797877"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="6797877"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 11:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="14896199"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 11:00:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 11:00:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 11:00:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 11:00:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 11:00:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fs/oB3qzUujv6RaoiUjAznohqd/KGYB3WT2/PcYZ63IYOrd09QyD2fRVkIr3/BqHRfeJWrvJf2+nQr8DozVTzTZShTTfZIrUMQMf82H5sPJFRJIUDmmw9OYPNMCttlonKEkQSgfs9s5CB8TJX9CWIcvsiE7k7krBM+55Ysg1tpWQj3LtpqsS6tzS6zK5GmidFqMhXTypT3tFnDmWrWhczVWZmjzNW6zT/9qvPFCmHiQphDRIdhvCpiQa/CruIQ1Edxl1AbbmBu4/1XTTjpcS8AUi+YbjxY9QAK4Nd6NCupordu3LWNWYB+iZEiV98ndR3Ueivd6n3YMS7zvGulce1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgTFOlhDzuIhTv0cRBScOD+U1PwD2TfH5hRr2Wgkd2Q=;
 b=dN0Agdxjy1OXctcvFb5xuwTuPTp/Qkvtka5R4b6f6tRF6GnRbVraQjcgGB/niByq1xc7UiC6kiuRc8APz69ae8lod5UCXqdjfRjy9gXIque/X6gsgcaKiCrSP9T5QsTO4NPv7PnrLYXOo4iupEJ3ghRQXJVlLrdJO+WJOlhSbxN+4oJWwj33A1sryI3Hz/WfKOGpNtLke3xUsy9lca0xjuXeR1Crfa5yyXjaTGesTseGSJCg6LM8yewqBEZ+a05EvmgL1PREnxodxHxurCzggy4xasH1ibB/K2ofIFfKyRnhCxt0FP7cO23pzJyj/jHtRQ0pe3dDb6WKjqImuCWKbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA1PR11MB7342.namprd11.prod.outlook.com (2603:10b6:208:425::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 18:00:51 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 18:00:51 +0000
Date: Fri, 22 Mar 2024 18:00:01 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] drm/xe: Make TLB invalidation fences unordered
Message-ID: <Zf3HIacyKvC66cw6@DUT025-TGLU.fm.intel.com>
References: <20240322090213.6091-1-thomas.hellstrom@linux.intel.com>
 <20240322090213.6091-4-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322090213.6091-4-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: BYAPR01CA0020.prod.exchangelabs.com (2603:10b6:a02:80::33)
 To PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA1PR11MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b0108b-8e35-49f3-3b9f-08dc4a9a02d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0hzLbzblhAT0o/N+puxpqwKWNHrTRDBmRAdtDA8SKb4RpVoR3lUyhLlaW40CzRj/mUaE+VBUSAumYC0eAnHGVqvIQZP/fVOO3ZQKNIN/jucVvbcsjo3WpUxerVofJlj8XUjOJhVqERq9VHPXKV8vjT4YTzFddDr/6gM98cl40ZPJ9Gb6I1rRQXFUFleFl3TVjbchZpQM/oE/gC6ucXqc6IgipgkH+pUQvUaBnm3qnuywPeMi1884UJqrhOw56ksmTt/QmBavakNDNqFsRLQzoFsJJKh1jMD20o2VuJ6qra9fMGJLIecqTrnlfilrWvUwgUxnBrOge2UgjK9cKXSNO94gBMpb+8a3y3qBj0rJ+RXiNABZ5XUXC3K0xSt+WuRiuAWnm5I4mG183iM816rnTTuHJY36+O/Ado3XMh0IvMMZbFFmmFLc0DkK/khLlkAXg7QjXl+W9IiyBmkhe3dh+uNJl1q2HerTc1WVjzOLf2FZNUMVFzVTSsmw74mTMFNqXl4PuQNNy9+KG0hYuNFe9j0GuAMSg8UXahsGlwRSllaQGITX6qjs7Kj1B+nBxmYyaZi9xKYTHu5YDmigDriDBpCqZGGlq7XhROUXcsCySw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LCIOWXewtxCkiFciyF0mMO+M4Kxrzjzc/F0cIHkBhTLgiWUxm7cak2wAWx?=
 =?iso-8859-1?Q?DWB9CwsLCy7JKaJHzTk2mZOutF7VksC3HxkB0viFSD8Baz3WRL3tHnPQKl?=
 =?iso-8859-1?Q?P7qoUobZm2YYdmo1sM0YPf76ho49zOwjtWRktch6L/8B9DHJImbugvEKBt?=
 =?iso-8859-1?Q?A2Q0Dmg4q3EFnobqAnaj79tZzj625IyrhvylL4L79xIdvY+1ppEyOaDzzh?=
 =?iso-8859-1?Q?o4hJq4UuRvkann+pQV3UHG3otJUr1lei6wYhXI/nwLLpjnGsp0qS2QeRf9?=
 =?iso-8859-1?Q?bQyu7cIWp/Yc5tgmSAVaHqd5amHICwHuEL+ZKZ/0L7GiOxdN3nt8Sg6Lze?=
 =?iso-8859-1?Q?wLB9iJoKLtmxcuWQ7EXFVgFF8LZim8zj6N159I4K8ojfzUeenNzZ6qMEjm?=
 =?iso-8859-1?Q?araf3sKFDw/O/4ZNXFQYomu2s/bTgWFhe4/jfyIcbFu6oH3tiKbRTvvlnb?=
 =?iso-8859-1?Q?LsWVMt2WFoKerLBKg40jnAbxadDMFCH+iO/DuLSWA1CgI3RE82eN3JR6G5?=
 =?iso-8859-1?Q?DemA8Ns7ulft4XFfHp8ZHbs4fn1Vjrjrkchqh6X7ehS3ln72kqAU/crke1?=
 =?iso-8859-1?Q?AmPAP4qbAFFrnQxOmVDLUZsxoDPkMxojpWgPa2qwEkHCVBERmdQNgIya/U?=
 =?iso-8859-1?Q?Jp5YyYmX8fERUyaZJpmJpZ7euotvbXiQOcP1OthNWXtR+7+rpDX3m7LjIG?=
 =?iso-8859-1?Q?Xsx+0S1zjQrabZ5t3HK+7edmxnIsE76ZXohjIqmtaGBUhEhv8oiQs3+Lt4?=
 =?iso-8859-1?Q?RyspFLwAUNZ+tdQ89geZ4JT9tKYwIXZBm7dWHddiqY18F6jmavBguI+ZY5?=
 =?iso-8859-1?Q?qqtJ0R6Sn02Gu39BL1+UR0ZKyyvzsQbbQOtqdzsye3oZXN+h2Eu1rbOuin?=
 =?iso-8859-1?Q?6iSkirgMGvmI7uDYofmHjl4tJm1GMdLLhPafPqtbBIOQ9gWOeyO1P/T++2?=
 =?iso-8859-1?Q?M+Q+gweey46QB1N50nTZ6JH9KPGHJhJVvZbMBhvizhcB5TFZnRLngvnzvK?=
 =?iso-8859-1?Q?iOlkmmXIyA6HUZcyxWF+rnpZMAs2Md8EZE+5hwCaF4bpeEYqfMq82QrVyn?=
 =?iso-8859-1?Q?+ZZqFuyJyeQij9yFmHNcqenj50MagusyuHtYs80pCEsJ1hf5Qv3H5pTj7y?=
 =?iso-8859-1?Q?ohS63s/o4mPVD7ZruaL3MHUgPFSEp3G5I7zFewhAiWwcN+qLv3MvxvwdOc?=
 =?iso-8859-1?Q?4mDKmbsLk+hHeaPoIJ/C5h88bRpiobeQZGn11CRZxVotJrELajBj1wfcli?=
 =?iso-8859-1?Q?9F8UaPHb9HtLgt07sII4mSrBhlmIyIol45lirXm75Hoe3IiWt/i1Xn+WhB?=
 =?iso-8859-1?Q?/lEJHKsHQrxftdrK2OW0L+5L7MaX08NC+Jy+Ivh6U2L2kO06xVKeQ1M2m9?=
 =?iso-8859-1?Q?NyV6yolVoX31eCleNH1RDIinPA7GZK6HpTkt0qQ7RHE966zXcOlnYZdSyK?=
 =?iso-8859-1?Q?8CtOwjJmQMWPPuacPsjcYlyQPgDe2uqClpsBq2gUOtqxSSOHjM3srwgJnw?=
 =?iso-8859-1?Q?jMitEGS5TtbbkKtRl2Fu3433VNVzJpMoEe4ybKuxq/RY7YjRGg3NkAKY9m?=
 =?iso-8859-1?Q?7BI6wU6JV3jC62Cs+PSqbTnuysTsqZncqnptqsVujSZ52G+yfxOZXR6ezJ?=
 =?iso-8859-1?Q?lqy5iwbSH4n/7Mw9dism6j/JdSKZqQ/oAWXXsFjz1K+9WBovT/fFMZhw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b0108b-8e35-49f3-3b9f-08dc4a9a02d7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 18:00:51.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIcdXR6S8YRPHmQsHRDebAuQe0Pmd+5M67xnZaZhhSS2d3P1Tt9GN21XTkDrwv4AL+Qyl8RiMZU0iuQ0JmEeZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7342
X-OriginatorOrg: intel.com

On Fri, Mar 22, 2024 at 10:02:09AM +0100, Thomas Hellström wrote:
> They can actually complete out-of-order, so allocate a unique
> fence context for each fence.
> 

Sending to correct rev...

Yes indeed these can complete out ordered on different xe_exec_queue but should be ordered within an xe_exec_queue.

In addition to this patch I think we will need [1] too.

This patch does LGTM though, with that:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

[1] https://patchwork.freedesktop.org/patch/582006/?series=125608&rev=5

> Fixes: 5387e865d90e ("drm/xe: Add TLB invalidation fence after rebinds issued from execs")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 1 -
>  drivers/gpu/drm/xe/xe_gt_types.h            | 7 -------
>  drivers/gpu/drm/xe/xe_pt.c                  | 3 +--
>  3 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> index 25b4111097bc..93df2d7969b3 100644
> --- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> +++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> @@ -63,7 +63,6 @@ int xe_gt_tlb_invalidation_init(struct xe_gt *gt)
>  	INIT_LIST_HEAD(&gt->tlb_invalidation.pending_fences);
>  	spin_lock_init(&gt->tlb_invalidation.pending_lock);
>  	spin_lock_init(&gt->tlb_invalidation.lock);
> -	gt->tlb_invalidation.fence_context = dma_fence_context_alloc(1);
>  	INIT_DELAYED_WORK(&gt->tlb_invalidation.fence_tdr,
>  			  xe_gt_tlb_fence_timeout);
>  
> diff --git a/drivers/gpu/drm/xe/xe_gt_types.h b/drivers/gpu/drm/xe/xe_gt_types.h
> index f6da2ad9719f..2143dffcaf11 100644
> --- a/drivers/gpu/drm/xe/xe_gt_types.h
> +++ b/drivers/gpu/drm/xe/xe_gt_types.h
> @@ -179,13 +179,6 @@ struct xe_gt {
>  		 * xe_gt_tlb_fence_timeout after the timeut interval is over.
>  		 */
>  		struct delayed_work fence_tdr;
> -		/** @tlb_invalidation.fence_context: context for TLB invalidation fences */
> -		u64 fence_context;
> -		/**
> -		 * @tlb_invalidation.fence_seqno: seqno to TLB invalidation fences, protected by
> -		 * tlb_invalidation.lock
> -		 */
> -		u32 fence_seqno;
>  		/** @tlb_invalidation.lock: protects TLB invalidation fences */
>  		spinlock_t lock;
>  	} tlb_invalidation;
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 632c1919471d..d1b999dbc906 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -1135,8 +1135,7 @@ static int invalidation_fence_init(struct xe_gt *gt,
>  	spin_lock_irq(&gt->tlb_invalidation.lock);
>  	dma_fence_init(&ifence->base.base, &invalidation_fence_ops,
>  		       &gt->tlb_invalidation.lock,
> -		       gt->tlb_invalidation.fence_context,
> -		       ++gt->tlb_invalidation.fence_seqno);
> +		       dma_fence_context_alloc(1), 1);
>  	spin_unlock_irq(&gt->tlb_invalidation.lock);
>  
>  	INIT_LIST_HEAD(&ifence->base.link);
> -- 
> 2.44.0
> 

