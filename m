Return-Path: <stable+bounces-40115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 204A68A8ABA
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 20:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B29E1F2521D
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 18:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DE2172BAD;
	Wed, 17 Apr 2024 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ch0LzIr5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2201171668
	for <stable@vger.kernel.org>; Wed, 17 Apr 2024 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376883; cv=fail; b=ecxifRSxlvgDwDAWRb5vbJBWRCz8ueg7giSKiI0AwWOH2iYMRQ37MBsYULIlDvnXt1SiB8nRMqtDQYNuo3JcQ/xbi2SBgg1vAZwmnwHHcoQjO9zxDiOYXFb2JZyDd3jYuptav7q2hV23YsXlg1NvY3wlK9b/WLHQTaLY4ZYh7i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376883; c=relaxed/simple;
	bh=W54qGuphmfEBMMIEzrQF5fjfEq2gCnob5LBG1yNzvAc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wyq6/u6AAnzaesK2KYwZBanDcl2FkD0cetbj/XHcpVJ7KAGtpfv3ITLfLID3S61dhtzV+x8BxTuN1EDlSzcO5rMoEOdFBKOMOPBaGyBz3bJGe/yjOxQW3Se1s9hGloajAKorZt+7PqpNNxCzkLGQS/TKJ69L5Fqsa1RaaNOBTds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ch0LzIr5; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713376881; x=1744912881;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W54qGuphmfEBMMIEzrQF5fjfEq2gCnob5LBG1yNzvAc=;
  b=Ch0LzIr5SLHLxe3OaZQqtXcct6uCG1WEkObrRQE7qJUBbQpCAn3uZ6WQ
   /+Uuvlb57WVpx7ucNM+hjk0MaimvNbUrP99UixASLjSb6Ng92nDubPurV
   ZEOBpAk2t5zFaVhTJYyApTPdpUswrTXG7mDwMz7gDKAgAwSARcSHbJDwd
   T81d0iiF+Csvc4SULGnSeD2GLR8fw6Jh8ISbrDWyMGrc2xeEgpIAOfxaP
   xeeedqJ1PCd2rSFQT+JwVJ5iYe586Zm6cqQap9CuFm4Ye+yL1364WijAp
   Gwxild5ceqP3mYQW/UkfgMpX5OIM4xdMwUM2qA/JUe1fa55C7kO48GUUV
   w==;
X-CSE-ConnectionGUID: 4FElx8PdR52586xW1MpGgg==
X-CSE-MsgGUID: ZKRuSXSjQ4SfRMOUz9RoTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="34285194"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="34285194"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 11:01:17 -0700
X-CSE-ConnectionGUID: gcyBXuHKR8ypEWx9nxX8DA==
X-CSE-MsgGUID: YWCm0yokQjqkmDOCY743eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="23194592"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 11:01:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 11:01:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 11:01:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 11:01:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 11:01:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw6MsRYxcufOg1tyUdiz3jZ/bKz9AV3ILPoAqR3syb4Ac2iP00fT1lcxIj17R5jt3alPnbbErS+MEeGEn8jMn/kESP2PPaEUNl/LGEy80yXypWRHVB+zbxonxjlItM0Ec/K1vymsVjVEMTaemZ/1PiiKJjMb/8jQDLQPZQujuGezflGy/WNkVnqnJgK8JJJBa+OCFl1pGKaGY8FzJURNVjmvnapO2iL9P6hWD18TgOz2T/8uxfe8DNFuKiVu9s4YECBJgeE+t1xLMD6uKw6pbpbzsIZxyflZEdysWif6ujNuSGdznsOdfy+CaA3qdUugJlV/wLL94mL0ilpVBZO43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJtYPY/DYnnD2Me43xm1vWcWDwNBL+MYoelc70E6mwM=;
 b=WFRd21K3J86WEdyizFnZj3IgLbg2jpMGVZxgTZHazH1DO/B/tGgxk1FVLiezZ2k5Vb9+8oMIY8oRF0rVQw10CH9S7iETQgZoUy8WcYj16+eu43AqsaWe3ANGkXmuZbeE/JYde9r9q0MoHT7HPWt8YvBxHHCH1TwGc67mcDqvxREyjAB4Ptd38NxJWebfV0kkJEPQDmMBn/qGV9IWqFLze4Gb/Zof3Kp8Wyv1aATUNmTTnTC5axRo0pcNhe4es+G62Z8jM1jMkFnyLToeeA5MTt6ecah8BiSSfg/AHEUGEyqYnRWUv0TqSF/gfM7z0s9eQ/LLMIyc7ytwiJvOvM1ALA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ2PR11MB7620.namprd11.prod.outlook.com (2603:10b6:a03:4d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Wed, 17 Apr
 2024 18:01:13 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15%5]) with mapi id 15.20.7472.027; Wed, 17 Apr 2024
 18:01:13 +0000
Date: Wed, 17 Apr 2024 18:01:04 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/vm: prevent UAF in rebind_work_func()
Message-ID: <ZiAOYD0vqe64HWkk@DUT025-TGLU.fm.intel.com>
References: <20240417163107.270053-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240417163107.270053-2-matthew.auld@intel.com>
X-ClientProxiedBy: BYAPR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:40::43) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ2PR11MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b77f5b-c738-4603-8c32-08dc5f085e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+kiSHX3QRiors1vqxCTI/lp0v+GCd0it5KEvfBtKXA/5scrigH+dq7M5lK6+gR2XVo03GbvalSAtqbesbz6Mk/W9HK1QDam+aaImbH2044gR1QV0z1hvUtBuzgdErmlUs0CNJ24UVF4FWA6hTmzzQB+SU5ceAC5zvKIYx47MYEOzRbpMcYgW7Qnb5OKWfzAQSvJVW21jXdpQVSNtaxc+wkKlMF6D+X5UncF2u819+I5i3LxSXPWo2WrKTbfb2VQLrfeBBDNkusmHqfzsQBo0f/iuOgrSuIMETrQvE8SqeJRJ0R0M/xauGgRCJ7MqaJypwhV5dR86zeM0etvlYto+bGaYXuTtdit0TLoe5PbVtyzRm/gY5e4mOjrpSPSDFoNfpZ39lJRhSwQs5qtyvO7dIo9ALWvp6LgGkOsFc+Xzw3viukfu4eP/2ePrTkBd49NYphPZLLslCxLJ007vGcUcqHwjSqhG8M2rXh4g8lKC/BjlB2CFRD1eqP061URwhd/f3zl4GfX6Xh3WyHxMEA9yNo66HB4A9A2Qw8MivrUMHAEZc8nPtB6AqSjaiA58WEVZ1n7B6F54eoeIn79cCCV6jhB0PoFUDYuRZjm0UWUG0+vXuLu49lNr33AU/JD0V0s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hYJwY491zG+za3AQcp1l11JFg1atIuSJa1AKEQTwmlKxb9nu5hip5FPQgQ13?=
 =?us-ascii?Q?v6DZtBVqE05NvjB40I0xaC0VXlXi51/D33xpi9+/+NQkOwzrHA9F//evAnTS?=
 =?us-ascii?Q?er3dpbfuhWmpjf33fw6TvIsV75qWL67tbgzm2iCltNDTN26HGLPUvesJ4KwE?=
 =?us-ascii?Q?s3bANqOPRWl1DAeQw7u2HWe64nxPJeRAdCbOO6LrU3DWSlJib6juJDg6jT6r?=
 =?us-ascii?Q?arlqb41gBekylo1cjwy7RN4RyBaJWHrsLTMlxJiTpeKuGtmYL3mcs0UvA/Q6?=
 =?us-ascii?Q?pv2mGLq/ZsIe9kbi+u17fg8qnSAwWFbyzjJf3LyHnKtLj/K6wko0inDOgTv1?=
 =?us-ascii?Q?Sdb+I+f6uFIUNZsBJ1gt6A+ns9LbWKW+qPFYoWc/Xwme6t3N/oSaFaZuiaTz?=
 =?us-ascii?Q?iJhSZW7teo0evuViDFxzQO6uqEJjQ1zhZt0rzfLrJsCDkDVSueJsG0THTxa9?=
 =?us-ascii?Q?jjXn8FaMoioD8F/yIlGjP1uC9/WwEaATDWWMCTgGSqxjdabhGCtmAHBkyvEA?=
 =?us-ascii?Q?yTxvS3dhr+Gn9q4pwfcQwa6SO+oAK4kwd3OUtdvJAP9PdKqlhoO0Ac1cWk2r?=
 =?us-ascii?Q?m7gXcfyXNyxbbHPmrLPLV887NFzF8pFcXusefXLirKIh6Sw+inM9hmb5E57g?=
 =?us-ascii?Q?Fz8xCKNLuFOJj38kVZwYPJeq3+vgqW+j53aeaekZcEYr9nMGPBTuzvBZulEE?=
 =?us-ascii?Q?2siQKIC5OI/kUY7RmOpRWwsQBC15HfdBnj1l1gsgDnYcQo5J7cCbBWx5S5r6?=
 =?us-ascii?Q?TmTIWMlSTGnS8GQNok9U7gsX4t04+hM01Nxk1geHkZU27/eKWGflPpC8C/Cw?=
 =?us-ascii?Q?mp5iqRATlzh8olcnS+CAk4b9gNCy1LyK2RpMLpWHljMFvqD3S8zMImr4g5el?=
 =?us-ascii?Q?Qs/7SrrwAE1IFwH+sOnZAUdiLzuvuiWnY//nJD9wA8Bdy7JWZlrEGENE6xVi?=
 =?us-ascii?Q?6gMNqmAS4t5QC5JA0rpN8MJl30YWowLlAn+1TenMnE6Hyh1gaHP/Eq4xU4AL?=
 =?us-ascii?Q?oIXFJfkRDHFi/3YFaplqcnmkk3jApCQBxsms0tZ0g/xFT9zgD87MrSxJXevY?=
 =?us-ascii?Q?pweflvinTtKTnNg3zKO7UO4CS4oI1Eo0zRyfQJaf8pNBpU2jrlPSDqq01AYf?=
 =?us-ascii?Q?sV9yJCUycG9+3zYmggyrGiLEd7juovFl2D9AFog78TLqZfcqU9R/iZ3DFXHD?=
 =?us-ascii?Q?bw1hWHbl6m8/bIAoT/J98dlcgWCeOuwxuMsxvicVgZpOmqk01yBpB4u/k8gv?=
 =?us-ascii?Q?zNhJYuVA+8wICNerHTlWnTlSXJFvp3nkLlBngtafjxH3kFvNxI56RJF4in67?=
 =?us-ascii?Q?h7C59sLc/G7TXo9uFe5uNnPyMicX2zlN2qq1W4SLZX+5GPlZEaRki889h9c1?=
 =?us-ascii?Q?Sgn+S23bSYtwKi3dJj1mpvEe/7xiisIDwm8VtHztI6s951wd1uGBLtguXDcr?=
 =?us-ascii?Q?DnvYJAHAY+38++QFPbNZVgeBkcwujAyAFaSR3fN1zb/bCc95pomRK+J2Iflo?=
 =?us-ascii?Q?iq1twPnJQA7qfL3A2fewD+j8CFh+Ls6DKNyOUeUUsXNCyps5M48idnPpatIQ?=
 =?us-ascii?Q?jLW60JSIvoQi6F/ltXKEN7UlvurmABjVNpVoC9B0idzLXDk+dlVie0seDiih?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b77f5b-c738-4603-8c32-08dc5f085e65
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 18:01:12.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDSeWxesl4bnbnoUlAzVEiWRa6giDudyPGQDcv/o3QLK2Zld2/fIKoiAxUyQpxvsF0wz9oqL3zBjvfclkcoBIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7620
X-OriginatorOrg: intel.com

On Wed, Apr 17, 2024 at 05:31:08PM +0100, Matthew Auld wrote:
> We flush the rebind worker during the vm close phase, however in places
> like preempt_fence_work_func() we seem to queue the rebind worker
> without first checking if the vm has already been closed.  The concern
> here is the vm being closed with the worker flushed, but then being
> rearmed later, which looks like potential uaf, since there is no actual
> refcounting to track the queued worker. To ensure this can't happen
> prevent queueing the rebind worker once the vm has been closed.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1591
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1304
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1249
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_pt.c |  2 +-
>  drivers/gpu/drm/xe/xe_vm.h | 17 ++++++++++++++---
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 5b7930f46cf3..e21461be904f 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -1327,7 +1327,7 @@ __xe_pt_bind_vma(struct xe_tile *tile, struct xe_vma *vma, struct xe_exec_queue
>  		}
>  		if (!rebind && last_munmap_rebind &&
>  		    xe_vm_in_preempt_fence_mode(vm))
> -			xe_vm_queue_rebind_worker(vm);
> +			xe_vm_queue_rebind_worker_locked(vm);
>  	} else {
>  		kfree(rfence);
>  		kfree(ifence);
> diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
> index 306cd0934a19..8420fbf19f6d 100644
> --- a/drivers/gpu/drm/xe/xe_vm.h
> +++ b/drivers/gpu/drm/xe/xe_vm.h
> @@ -211,10 +211,20 @@ int xe_vm_rebind(struct xe_vm *vm, bool rebind_worker);
>  
>  int xe_vm_invalidate_vma(struct xe_vma *vma);
>  
> -static inline void xe_vm_queue_rebind_worker(struct xe_vm *vm)
> +static inline void xe_vm_queue_rebind_worker_locked(struct xe_vm *vm)
>  {
>  	xe_assert(vm->xe, xe_vm_in_preempt_fence_mode(vm));
> -	queue_work(vm->xe->ordered_wq, &vm->preempt.rebind_work);
> +	lockdep_assert_held(&vm->lock);
> +
> +	if (!xe_vm_is_closed(vm))

xe_vm_is_closed_or_banned

Otherwise LGTM. With the above changed:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> +		queue_work(vm->xe->ordered_wq, &vm->preempt.rebind_work);
> +}
> +
> +static inline void xe_vm_queue_rebind_worker(struct xe_vm *vm)
> +{
> +	down_read(&vm->lock);
> +	xe_vm_queue_rebind_worker_locked(vm);
> +	up_read(&vm->lock);
>  }
>  
>  /**
> @@ -225,12 +235,13 @@ static inline void xe_vm_queue_rebind_worker(struct xe_vm *vm)
>   * If the rebind functionality on a compute vm was disabled due
>   * to nothing to execute. Reactivate it and run the rebind worker.
>   * This function should be called after submitting a batch to a compute vm.
> + *
>   */
>  static inline void xe_vm_reactivate_rebind(struct xe_vm *vm)
>  {
>  	if (xe_vm_in_preempt_fence_mode(vm) && vm->preempt.rebind_deactivated) {
>  		vm->preempt.rebind_deactivated = false;
> -		xe_vm_queue_rebind_worker(vm);
> +		xe_vm_queue_rebind_worker_locked(vm);
>  	}
>  }
>  
> -- 
> 2.44.0
> 

