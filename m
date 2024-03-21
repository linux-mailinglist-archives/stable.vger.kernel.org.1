Return-Path: <stable+bounces-28573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E698860E2
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 20:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E967B214C4
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC313340B;
	Thu, 21 Mar 2024 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6j3fTBt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7D5CB5
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711048214; cv=fail; b=lDwnZHkvnJiai6IG6L8sqBeaCJUvw1TXbmuV3uZlDWajgReXdYFafxE88Ybeq1xM1UN4ZfxIsiuHM4gD58RvkgQi0bqOwrt7YKysKAH0uqlK3lVvhauJJ1TBZdLYfntSv49rkg/IqeNEj/P9kKIx06gJu27OyhG1VfRAPMobDZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711048214; c=relaxed/simple;
	bh=3kA8SYezCCeGXg6JAcVsr3F+TPmbGuu4ESgvIn6y1Ro=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=do0hMZg/QK0hfyndPdmOtuiy98qB/+UR0Rz6qhkr4hhFvRxWJYFNveNoySa3jSzfguGWa3dF2XHCexdpyF961IW+3UnKhWod0A657cCD6H46YqDgA3rpFtNvRwUMVqkhFDWdrDy+SwVECI2c7ynv/cIgwyaFKFwfYTsnY3LKjPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6j3fTBt; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711048213; x=1742584213;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3kA8SYezCCeGXg6JAcVsr3F+TPmbGuu4ESgvIn6y1Ro=;
  b=O6j3fTBtUJEm567WiblvUJXozo4eFtbHQawf0oVSEQgMGuwHwc2QQALt
   3h1vcKw5QPo2aeDRucvNaNhmfIeoriRm9XVHkaA0DBeNpW4kIVIt61vC0
   GqUoIfE323cucBEDqp4IrDqfwlw0Z2w32zPW1lvZO1h3Cm7zQadNELORK
   jYjXWpwwiEyOXU+gqFStyV6A9PXiOzDCoz4lrMSyXbHy3F7pxaqwMlVyY
   nHgM7dpwmAufTMw+tnEr6BwlXbDmGZOPMxN8uZQPgJ6Hth2BOHmiD4oK9
   IjlXfXbjURYzyTtCPk6WvEf/+gLtJgk6avn//fRfnvGGUc5j0qG51Jqnm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6276898"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="6276898"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 12:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="19271840"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2024 12:10:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 12:10:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 12:10:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 12:10:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 12:10:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzbV9a/2G+YtY10WjqkrHSEjKdQwcKtM72e6zmNDWjJFGwNw2RdvC3YXnIVIZ8befvMH7EoAu0fRt+f0h4uMgj/sb91aHKi9aS4xOAscd6GeHN20R45PPMrXxFGRUsd/QR02ypSNlh4ALrKtRsvPOOI0bkonWCKi20xNZ0LB00T6TV5WMhBK2vgMqQwNndO9+2au/1v0rss8uSzpv7v/ZhPKB57H3y6pvq5945tf2uO/agS77n4OjEBiV83Ck9PngMl50XAbfRfWsT3xneyf61Y+IY8/8woFGbRCH+Q2vR8lvLrtsGY08JP823tjXtIKjoawETXVKOTo3+VS/EJlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLtERFqgUfU3l4tvfEGWuYt7jIiou8VwFstK7Sk0HFo=;
 b=hu8U5b7do2irYK89YrvtAGuFMjXDoV/6diKCafTDGc5sjPh/4PuPscngHT3m+AWkrNMHUCJEvnOZ4NLXkVWr6ayYaObL96C9Z5DvVuTakM6ge0lmtwqPasP+68+U372RgrW/FTYK+0Y/XE9xJDRGunwsG28jAHJUEkCY//OKsTtj6H6XRlNnwv3nLAW9W0V9rRt6OSPJQuX8y+LmjMEofcuHu/pziB54yPtU3wG67Z0sEAdmE8GZnTl+pFsr/w+uKpGZeJNSonfrgGYWhBlQs9+MkrwpqO5OiIcQCAlQdZ9w30uustAkkXrqVaveikj2AUt2KVDY0wSM2GzYTmdVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH0PR11MB4791.namprd11.prod.outlook.com (2603:10b6:510:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.10; Thu, 21 Mar
 2024 19:10:08 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15%5]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 19:10:08 +0000
Date: Thu, 21 Mar 2024 19:09:34 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/7] drm/xe: Use ring ops TLB invalidation for rebinds
Message-ID: <ZfyF7kfCE+xcMFa7@DUT025-TGLU.fm.intel.com>
References: <20240321113720.120865-1-thomas.hellstrom@linux.intel.com>
 <20240321113720.120865-3-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240321113720.120865-3-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH0PR11MB4791:EE_
X-MS-Office365-Filtering-Correlation-Id: 329fbc88-a39c-498c-72e0-08dc49da8646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70WF17LckTgOHBM5cCrpxFsjwHYCT2pgGnA6mcSpTUimjFLeSxeLVnAmllko8k0+9Xj92nPPhdg1iJAiMrcHQuoMY68+TXvM3wcuEXlNIm5yLg6udmxNLb0vYrvOEjCZfr17jP4gFZiFM35vnZ9OwEjgj/tepDwOZK6IHRAVP83b5zFgDXIU6oU1atId0B9zVGhnfOkUljj2fys3df/wv2Apn0LK6jZxMb9ZWpzbiBLmE4PPOgfXe/oaM6Hh5X5kV2GbVdQtFeLPjR3PKrvoQAJFlqlFCZOGGpYERx1si6Pa4JhTuAoLphlmMuYxwBPoWY0RQYty5kftGPj6PiWU3r6ML2p4Biwsvqw+FdZt1XC6nCckscHxbBvWiymB5FSvxT1UsgG7NYpgpIH9QQp4mi3pcDlE6rx2w3UlcWw1RbCSA1fOH1rBw5nA6ON2ybsgaehC2tHmJhb4PcbvQWNhVFxx+OCmOxFLRupD8ElmtwPuutpy/6P5mzIL8MX5JMClXD4Ovzms+YrzFUisT25sNIVNTvhjE/8OV+MglgpGsJAP/ovNA+LwRImSpj4+FMDPPFQcmbgLjAsHmq2ukUudAzaGlN324/R64Exx6cALAE/cP7ea9TyuevyFFVyAMsTO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gIeIwINsq2GG0cYryws/sGzByFmK5Gfr7MakHWChHMdxmvFLgIHcPfAWLa?=
 =?iso-8859-1?Q?hCdJh14MCGj89rZvWURbbC0G09zlQ4U9oBh4pb5wRsebA526lpcTSSPr6Z?=
 =?iso-8859-1?Q?TZXsZvSaFVEQZv5F16BJ+Zv0gzuOAj1uCpe8ic3lXTdlIO75PGe1QP09Z4?=
 =?iso-8859-1?Q?FZqIuHkaVAw1+MdeEvleBYAoTWYT27Y+nF6QBvf23stiB8fQ6zHgaZ2dqY?=
 =?iso-8859-1?Q?rSm+Uphpnx73R5uqOCNLtnHryBbEgrGnkPZ1OLQw4fBbkQXuhVYKhAgP98?=
 =?iso-8859-1?Q?lmlKbPH2NaTQ4rJFD5F701ZZwLpl7G2G1+Aw+dTRBmCZVoHVNNaVquw8BW?=
 =?iso-8859-1?Q?Baj0wCIaT1zno+VfWYFO7KyR0b+EBuoZAZpdTqy2ruWtwal9sLCZXxdIHQ?=
 =?iso-8859-1?Q?njIuU674hRcT420PiTqifh0uA1U/F9wnYlRFILmNtQckZqOoZRBnIG60bJ?=
 =?iso-8859-1?Q?RhlbRCBmoPktfGA9wnmuoVmOx12mLrQY6mfexdhZ8NWMnA65FSe2Ayattt?=
 =?iso-8859-1?Q?W/CJ3NYG0PcTRrw3zKezTz7Jx/zA8OxiE//xN5NNq7U7QoBqa7Sq6vE4Px?=
 =?iso-8859-1?Q?7CGDmXhN9hlwZCtRpig217RTC873XzFEORHwFY3lOd8Ux9v08/N2rrnNhF?=
 =?iso-8859-1?Q?p2KjnETxEhdFYdCLoNYlaKkOSk/ZdXNvljHEpiE2X+n1LkIoPzs3pVYDR8?=
 =?iso-8859-1?Q?zl581ouk6FIsUduLRLF7hnQ+owSLCpzEkZfPwHx8/Jo3gfs+ns2SGT3/k/?=
 =?iso-8859-1?Q?zcXAVe8ytIIXJqjWNAwQCUDPcb0M5T6DuMaztKBH27Ih8+nMdHDZxIpMAH?=
 =?iso-8859-1?Q?CYDKanHZtaTox90ugXPFDqDchzeB0SSSNpBY1TeedmlGvTs7DQSZIXvG5E?=
 =?iso-8859-1?Q?6fnQvA9xB4qLChstiJtaOmedWCiihlMRNgybEC34QJTGmc2F4BvgU/HhCE?=
 =?iso-8859-1?Q?nDwE3Mp/+DB47NImavysjLVzpAtJqiNoYndGBQZTM4RZJDfdZQUpyCeNsH?=
 =?iso-8859-1?Q?0RzYv/JHisFcAMkX2v2leiywJ+CfCC+eE6rN0XGhGxn1LHGD1pOnhnU26T?=
 =?iso-8859-1?Q?2NyArWiXcitXwdrFL+jc58qAQ9ELx+Uvv5C+NxhIM/NfyMy03A0jNh3B00?=
 =?iso-8859-1?Q?tcrhyVCTTFlKGkEeWo6LjXHHHvGDygMNkPOquP2RU4JN+o5wLT67T2IHJm?=
 =?iso-8859-1?Q?7CUgWSuMQXzTZbAHtolYdN53RCJdXb7DdTWAObKjl34GU7cyW5clAxN4gI?=
 =?iso-8859-1?Q?8F4bCl0vuT44p3saiCcZyLr59pE00oLIyVkGoEq6QKr1nfkyab0wjzxc6S?=
 =?iso-8859-1?Q?d+TSWv37Iqoz3o0fI2PuLXuKXpNzrjlXUPPLrC35cEIaBk8nKMwcx64OcS?=
 =?iso-8859-1?Q?tImJwYaW/n4cz/yC9F39F62WuTcOiLNMy8Xp7XbdItktKvr51uS33tm2JN?=
 =?iso-8859-1?Q?pzSwlsGs9zTYn+2K8NhFjHIlUchh8xVx5jG0MQB/N2NooPCoj5yCauqGPU?=
 =?iso-8859-1?Q?lfr0JYC4+pFluVT5rnwlBgSP6fAVQDunC6fs5gYcc1i5Me5l2CFsXg/DHy?=
 =?iso-8859-1?Q?fHJcqWJ2YercFpS0esA8BMOp8c++v0CsPSMsgdlJrwMemMauC+P9KqwWaH?=
 =?iso-8859-1?Q?gEvnlL40AodVtLchwZTy1I+CdtU3eP8GVsW8GgHHo8vdRbKYLyGENjRA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 329fbc88-a39c-498c-72e0-08dc49da8646
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 19:10:08.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQGNd6LdP6V3XTmEagKHARkKT1fczXLc/JevdOXYc6okV4859VvCaHGTk0YcZvtq0XLnrqse9MaXNl8vpmdZ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4791
X-OriginatorOrg: intel.com

On Thu, Mar 21, 2024 at 12:37:11PM +0100, Thomas Hellström wrote:
> For each rebind we insert a GuC TLB invalidation and add a
> corresponding unordered TLB invalidation fence. This might
> add a huge number of TLB invalidation fences to wait for so
> rather than doing that, defer the TLB invalidation to the
> next ring ops for each affected exec queue. Since the TLB
> is invalidated on exec_queue switch, we need to invalidate
> once for each affected exec_queue.
> 
> Fixes: 5387e865d90e ("drm/xe: Add TLB invalidation fence after rebinds issued from execs")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_exec_queue_types.h |  2 ++
>  drivers/gpu/drm/xe/xe_pt.c               |  5 +++--
>  drivers/gpu/drm/xe/xe_ring_ops.c         | 11 ++++-------
>  drivers/gpu/drm/xe/xe_sched_job.c        | 11 +++++++++++
>  drivers/gpu/drm/xe/xe_sched_job_types.h  |  2 ++
>  drivers/gpu/drm/xe/xe_vm_types.h         |  5 +++++
>  6 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> index 62b3d9d1d7cd..891ad30e906f 100644
> --- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
> +++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> @@ -148,6 +148,8 @@ struct xe_exec_queue {
>  	const struct xe_ring_ops *ring_ops;
>  	/** @entity: DRM sched entity for this exec queue (1 to 1 relationship) */
>  	struct drm_sched_entity *entity;
> +	/** @tlb_flush_seqno: The seqno of the last rebind tlb flush performed */
> +	u64 tlb_flush_seqno;
>  	/** @lrc: logical ring context for this exec queue */
>  	struct xe_lrc lrc[];
>  };
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 8d3922d2206e..21bc0d13fccf 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -1254,11 +1254,12 @@ __xe_pt_bind_vma(struct xe_tile *tile, struct xe_vma *vma, struct xe_exec_queue
>  	 * non-faulting LR, in particular on user-space batch buffer chaining,
>  	 * it needs to be done here.
>  	 */
> -	if ((rebind && !xe_vm_in_lr_mode(vm) && !vm->batch_invalidate_tlb) ||
> -	    (!rebind && xe_vm_has_scratch(vm) && xe_vm_in_preempt_fence_mode(vm))) {
> +	if ((!rebind && xe_vm_has_scratch(vm) && xe_vm_in_preempt_fence_mode(vm))) {

Looked why this works in fault mode, we disallow scratch page in fault
mode. I thought at one point we had implementation for that [1] but it
looks like it never got merged. Some to keep an eye on.

[1] https://patchwork.freedesktop.org/series/120480/

>  		ifence = kzalloc(sizeof(*ifence), GFP_KERNEL);
>  		if (!ifence)
>  			return ERR_PTR(-ENOMEM);
> +	} else if (rebind && !xe_vm_in_lr_mode(vm) && !vm->batch_invalidate_tlb) {
> +		vm->tlb_flush_seqno++;

Can we unwind this if / else clause a bit?

I think batch_invalidate_tlb can only be true if !xe_vm_in_lr_mode(vm).

So else if 'rebind && !xe_vm_in_lr_mode(vm)' should work. Also if
batch_invalidate_tlb is we true we always issue TLB invalidate anyways
and incrementing the seqno is harmles too.

Side note, I'd be remiss if I didn't mention that I really do not like
updating these functions (__xe_pt_bind_vma / __xe_pt_unbind_vma) as they
are going away / being reworked here [2] in order to implement 1 job per
IOCTL / proper error handling.

[2] https://patchwork.freedesktop.org/series/125608/

>  	}
>  
>  	rfence = kzalloc(sizeof(*rfence), GFP_KERNEL);
> diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c b/drivers/gpu/drm/xe/xe_ring_ops.c
> index c4edffcd4a32..5b2b37b59813 100644
> --- a/drivers/gpu/drm/xe/xe_ring_ops.c
> +++ b/drivers/gpu/drm/xe/xe_ring_ops.c
> @@ -219,10 +219,9 @@ static void __emit_job_gen12_simple(struct xe_sched_job *job, struct xe_lrc *lrc
>  {
>  	u32 dw[MAX_JOB_SIZE_DW], i = 0;
>  	u32 ppgtt_flag = get_ppgtt_flag(job);
> -	struct xe_vm *vm = job->q->vm;
>  	struct xe_gt *gt = job->q->gt;
>  
> -	if (vm && vm->batch_invalidate_tlb) {
> +	if (job->ring_ops_flush_tlb) {
>  		dw[i++] = preparser_disable(true);
>  		i = emit_flush_imm_ggtt(xe_lrc_start_seqno_ggtt_addr(lrc),
>  					seqno, true, dw, i);
> @@ -270,7 +269,6 @@ static void __emit_job_gen12_video(struct xe_sched_job *job, struct xe_lrc *lrc,
>  	struct xe_gt *gt = job->q->gt;
>  	struct xe_device *xe = gt_to_xe(gt);
>  	bool decode = job->q->class == XE_ENGINE_CLASS_VIDEO_DECODE;
> -	struct xe_vm *vm = job->q->vm;
>  
>  	dw[i++] = preparser_disable(true);
>  
> @@ -282,13 +280,13 @@ static void __emit_job_gen12_video(struct xe_sched_job *job, struct xe_lrc *lrc,
>  			i = emit_aux_table_inv(gt, VE0_AUX_INV, dw, i);
>  	}
>  
> -	if (vm && vm->batch_invalidate_tlb)
> +	if (job->ring_ops_flush_tlb)
>  		i = emit_flush_imm_ggtt(xe_lrc_start_seqno_ggtt_addr(lrc),
>  					seqno, true, dw, i);
>  
>  	dw[i++] = preparser_disable(false);
>  
> -	if (!vm || !vm->batch_invalidate_tlb)
> +	if (!job->ring_ops_flush_tlb)
>  		i = emit_store_imm_ggtt(xe_lrc_start_seqno_ggtt_addr(lrc),
>  					seqno, dw, i);
>  
> @@ -317,7 +315,6 @@ static void __emit_job_gen12_render_compute(struct xe_sched_job *job,
>  	struct xe_gt *gt = job->q->gt;
>  	struct xe_device *xe = gt_to_xe(gt);
>  	bool lacks_render = !(gt->info.engine_mask & XE_HW_ENGINE_RCS_MASK);
> -	struct xe_vm *vm = job->q->vm;
>  	u32 mask_flags = 0;
>  
>  	dw[i++] = preparser_disable(true);
> @@ -327,7 +324,7 @@ static void __emit_job_gen12_render_compute(struct xe_sched_job *job,
>  		mask_flags = PIPE_CONTROL_3D_ENGINE_FLAGS;
>  
>  	/* See __xe_pt_bind_vma() for a discussion on TLB invalidations. */
> -	i = emit_pipe_invalidate(mask_flags, vm && vm->batch_invalidate_tlb, dw, i);
> +	i = emit_pipe_invalidate(mask_flags, job->ring_ops_flush_tlb, dw, i);
>  
>  	/* hsdes: 1809175790 */
>  	if (has_aux_ccs(xe))
> diff --git a/drivers/gpu/drm/xe/xe_sched_job.c b/drivers/gpu/drm/xe/xe_sched_job.c
> index 8151ddafb940..d55458d915a9 100644
> --- a/drivers/gpu/drm/xe/xe_sched_job.c
> +++ b/drivers/gpu/drm/xe/xe_sched_job.c
> @@ -250,6 +250,17 @@ bool xe_sched_job_completed(struct xe_sched_job *job)
>  
>  void xe_sched_job_arm(struct xe_sched_job *job)
>  {
> +	struct xe_exec_queue *q = job->q;
> +	struct xe_vm *vm = q->vm;
> +
> +	if (vm && !xe_sched_job_is_migration(q) && !xe_vm_in_lr_mode(vm) &&
> +	    vm->tlb_flush_seqno != q->tlb_flush_seqno) {
> +		q->tlb_flush_seqno = vm->tlb_flush_seqno;
> +		job->ring_ops_flush_tlb = true;
> +	} else if (vm && vm->batch_invalidate_tlb) {
> +		job->ring_ops_flush_tlb = true;
> +	}
> +

Can we simplify this too?

	if (vm && (vm->batch_invalidate_tlb || (vm->tlb_flush_seqno != q->tlb_flush_seqno))) {
		q->tlb_flush_seqno = vm->tlb_flush_seqno;
		job->ring_ops_flush_tlb = true;
	}

I think this works as xe_sched_job_is_migration has
emit_migration_job_gen12 which doesn't look at job->ring_ops_flush_tlb,
so no need to xe_sched_job_is_migration.

Also no need to check xe_vm_in_lr_mode as we wouldn'y increment the
seqno above if that true.

Lastly, harmless to increment q->tlb_flush_seqno in the case of
batch_invalidate_tlb being true.

>  	drm_sched_job_arm(&job->drm);
>  }
>  
> diff --git a/drivers/gpu/drm/xe/xe_sched_job_types.h b/drivers/gpu/drm/xe/xe_sched_job_types.h
> index b1d83da50a53..5e12724219fd 100644
> --- a/drivers/gpu/drm/xe/xe_sched_job_types.h
> +++ b/drivers/gpu/drm/xe/xe_sched_job_types.h
> @@ -39,6 +39,8 @@ struct xe_sched_job {
>  	} user_fence;
>  	/** @migrate_flush_flags: Additional flush flags for migration jobs */
>  	u32 migrate_flush_flags;
> +	/** @ring_ops_flush_tlb: The ring ops need to flush TLB before payload. */
> +	bool ring_ops_flush_tlb;

How about JOB_FLAG_FLUSH_TLB rather than a new field? See
JOB_FLAG_SUBMIT flag usage.

Matt

>  	/** @batch_addr: batch buffer address of job */
>  	u64 batch_addr[];
>  };
> diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
> index ae5fb565f6bf..5747f136d24d 100644
> --- a/drivers/gpu/drm/xe/xe_vm_types.h
> +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> @@ -264,6 +264,11 @@ struct xe_vm {
>  		bool capture_once;
>  	} error_capture;
>  
> +	/**
> +	 * @tlb_flush_seqno: Required TLB flush seqno for the next exec.
> +	 * protected by the vm resv.
> +	 */
> +	u64 tlb_flush_seqno;
>  	/** @batch_invalidate_tlb: Always invalidate TLB before batch start */
>  	bool batch_invalidate_tlb;
>  	/** @xef: XE file handle for tracking this VM's drm client */
> -- 
> 2.44.0
> 

