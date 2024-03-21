Return-Path: <stable+bounces-28574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DE38860E7
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 20:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D41A1C2198F
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 19:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F043133423;
	Thu, 21 Mar 2024 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKH1Kj7v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC02D13341A
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711048601; cv=fail; b=UkWMEEjV3FjD4uVz5baXtuTLXnHTXHMFznla1eZknMmNftQo1kVmdTwzHixXv2okcLKY1VzVmwJocbxggN33OPc8CURb6Ppd3UvZL1OM2YvbLwu2blSdbsZfr/kvEBt5ZbfpjiSKpEeAnFxke74SlomUH8j9y7uy9z675BLR9Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711048601; c=relaxed/simple;
	bh=s9ImtQKmV1p4fIVAeC73hEPhj5B6tZ5SPC2mLipDkGA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KIZcsqOI6oXCV1sZvqv+3lw+gtpXnsNm/60oFFKV7apeJ/7Dj3cMya4D9LtWkg/xvzwPSjKsUfOHDWCXK48aDdx6Uitm4C78iwOq5yJpUHAYazeOhFFlmJ3Ixsi+7RQwiO5QZ4m52ftIxvpFN6HHaFsKVr9Vj9uNSi7F4sxMwLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKH1Kj7v; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711048599; x=1742584599;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=s9ImtQKmV1p4fIVAeC73hEPhj5B6tZ5SPC2mLipDkGA=;
  b=JKH1Kj7v7sn0kgXnbPk6aNFF8Sjlj+BF6Ld7fCAxbu3TfhmQm1nb+YdG
   siPELVLand+9oLoKaZQH5UwHUKPdPi9J6NA6rtdl1Q/z9O8xm3msaPJ77
   b1oByZAnyoda4ECUw+aCyWHwyne9PLRGgxVmucBeSQJLv4Rei6SbYe52f
   Uqbi0ZlvevrT6zNTL/QTt599Lirz8cl2gU9iAXdW+R3SEuzZFQ4RAbaun
   3tz4Lof9K+AqgWVaOSCwSuOnVQH/6l9Gh1Dk6sNTYKxqNV5Ed8p/o2aR1
   UL+K48tjwGyu5MTr7wJiH+DjcSQFQ0tu+GNGEiE2RNeA3P6NzvhbjGfAC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="5901976"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="5901976"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 12:15:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="19077452"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2024 12:15:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 12:15:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 12:15:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 12:15:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+nkOyVUqduk4CiLm3Vyh0D9Gc25UjPfcyWPPeGvoZRixynHmiIZtTbq4xoKKCzqBIhtguuCHdUYDSlD796YwZ9U6Rx/E7XOLVxPdlT0sO7EdSkfBf0Xi4rQEiq/23R0E2CpwdS3XFLWxfwUePpjjaRh9vIzMtq/T8G+Kheuup2PeW2K1RNaE6ghlSDkIr2u036FtZauCx9PuH+Z8EzNgCksCenezAEj6+8GmFMDBWDz06pweEKIhi5dw/VEjbnkCrcP/G13pz/ENYo6xNRGY+JroJJEEaGkBvlfafh33CPl71rKK8n8ZGDYdshCpikNcE9iQjgU7CQX0S4POnj42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIBERawRaATgWtrHvlN/1Sesa0h85kMXGyJ48nA8Axs=;
 b=EpLPsMe5JhNQNyr+L4tlw9CU6c2c2IEEGJ6lwwAuN2iPxr1j/QtMfLo1G0QRLa4W7QDEEuSiH2ap7xQL/3XPB27A+XxQEqXWv03BDcQtODklKOnvN9N3ylkfZSwHds645IFbkTpChPp7W+q08e2v2ZU1D0KWExH9DPpHq/a+5DQxgvdBURwuM2P5liW+xqlDmgR23mQTnz7KWCvG+E3y0rC8CW2AKlm6oe1xF3IS6R5UvF0JNYtBmEBqwC2x6QIoB7+nSmLaw+5u4pil14vxGNkk0euZuw8jsTm+Tp+Ej5mFiXc8rKyNPoQf3v0U+Qc/hkc3pU9TnCpme9eyIi6h6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH7PR11MB6427.namprd11.prod.outlook.com (2603:10b6:510:1f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.23; Thu, 21 Mar
 2024 19:15:32 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15%5]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 19:15:31 +0000
Date: Thu, 21 Mar 2024 19:14:58 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 2/7] drm/xe: Rework rebinding
Message-ID: <ZfyHMmxStlECaGs3@DUT025-TGLU.fm.intel.com>
References: <20240321113720.120865-1-thomas.hellstrom@linux.intel.com>
 <20240321113720.120865-4-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240321113720.120865-4-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH7PR11MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: dae8f80c-caf7-4789-f1fc-08dc49db46ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 84L7p7o99auatxAl/Cg7oTwCLISW5RBJRNnAhBAfFOXjmGkitcPfGSwY3GxpwHeiMkQ77fZaH9tuBttlO0foctgMPb5d4rQQV7K+FnqZ5/RlbUuFQF+cPYIssN9ZOfY8jqHIKcNsXk7e4/9Bfn4mtEYvJ/quqDyjhWOK+gAaMbFrX4aRKz+torV0mThXEm5i8miFXWooii3zEqn3Oz+5ss1qarGu7+akjk/jawKVPs/pQZ5Aqy7nS1wl30cVc3X3YFNr5zwORT4z8C1Ar9W4/dRcdBGxl1TbjIR77BenbYSYTpHSJJFC0erMbIygMCvX1tjYrNRQBGTdQOqgXPkaPzfD2sKI/uWSvSSTCSdcl56B6UeyHqS+DE3UQUjIj+MBqRwnpdfxSIVtvrGMen0PU42teeJ7DjFpoEMoJOWI/lgpWKdc10Xq0PtmCptHkhu+0zzCXZ8SBtv+tWhVG0iPtSlg5JZOqAYzIciGRwm5bYDt0W6bLAWH0wbiVNQVzcEkCUSlmzR4dcQTSlm3jT3qK8sRIoAQwFqrtC3z/dw6ZJtMTGJvupHdZz4LmVilLjPCgPwK1RlbV31jXM0dxrD8BdoRZ2GVL60EHmBR7QBApit6l+D475DwJ5zWn6OCj3L9GEpILv02o8TNcSk6C+xWWmgy41PdsVy0ohbbFG29EVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?527uOL3od7vtRwfC1TahNW5T7cgvH+QScEk7lqEmTsACqmWdfN/Oj5hDD0?=
 =?iso-8859-1?Q?mXUtP+G0LbFklL/aeys7zwHyFmlQxkVn7JQviEJhpKGqf6cziZutlX9MLK?=
 =?iso-8859-1?Q?LAuA91OY2Ai9NLBEvJW4us9dUt2lb4YkWEdFglUwuRlG3oskSO9wbfURuI?=
 =?iso-8859-1?Q?HTHhxtG5kVXGdjMsuIQicLEMw2JvUJwwoE2/tbSrx2IGSxJ4BygrYQqP7I?=
 =?iso-8859-1?Q?+e27HNJ3dlzAjgFXS8kbEFcaBmhG9uCNHKM5OEYfx+pLNFSsTaBSbaCs3j?=
 =?iso-8859-1?Q?nfdHs85m3mWIx1WjfVrv0joQ2cLGs6zdayXxSA3gUltQ2/qbZ5N7MKNqhi?=
 =?iso-8859-1?Q?aX/ZDWBkIIlb33zmOuUrLHJfvhFdRK8TZKQDHrtJo4KYiYNA8oJWZ+O7FW?=
 =?iso-8859-1?Q?3ajgkqAiIhIp0ilbzm+HtIcUKSo0HqgHuWVVV9sxlS5exvtMSlo1QdBUbw?=
 =?iso-8859-1?Q?vjkYagEVwEq5DekGYmZTucBqyje/TR1K8TpTt0Qn+vDNOy6oRLxQPq1sIA?=
 =?iso-8859-1?Q?d4KBIla7R6Jo+GXTY+AoAKnCpqDmBM69/usM7SKAStQZAyWj9y0PnB5RuG?=
 =?iso-8859-1?Q?vBP/bLflzdI3F+3+FROG1O40yKdfvzl2Pg/l2NQOVLLyplQcr4bsmLdQfZ?=
 =?iso-8859-1?Q?RF58lLCzdnfHVW0BYjUQVsEbE4fsQjX3F4r3PsiV0XNeVmWyb8Cu2LiopA?=
 =?iso-8859-1?Q?tL4+6EZMq+/idZrD/N61nKpyVNAHADtpSzKQFOMtShA5RCSHm6RYe/0dqj?=
 =?iso-8859-1?Q?tLe9fc28pSlpsTaX6G8/fDBwf9MNBnGBEK1kHDeKd3LDgJdK6quDtkAIko?=
 =?iso-8859-1?Q?qP8NPEJgFqjg+J0zch4GfIRcHUkhbK1APUkhBLgCtPJQq67puNFgRmcpBx?=
 =?iso-8859-1?Q?vgDl6rmxmSucwgBFTJsjy37ptTarcvqPzWfoeA+EHtYyezhxfjV2vp4yfb?=
 =?iso-8859-1?Q?32kTJrWDCVVcht/XbRA5Rg6jiQoONlL1HxAR0eNKGxyJ+g4wl3f/Cn86cB?=
 =?iso-8859-1?Q?bEfJI8AlexeRXupKN4sspcUMRygHKoWkFrwwRRSM1DA1iLV2BkqGOs9fXP?=
 =?iso-8859-1?Q?iHvmGRJxciw9iWyRpvGF54IwVWEgoHsmbcPkTGmu45suaHgiPFe9IXd/hH?=
 =?iso-8859-1?Q?4TP0umkBY21QGwjhriWGT5AsYWY6UnTmCmOuUWofMlzE7xxcG1PRmhYpGs?=
 =?iso-8859-1?Q?+yJp9/s1Llk7EERmfX2eCXTtWxUQrCu4uh/L0KsuO09MMdXU769J9ZeNqO?=
 =?iso-8859-1?Q?3pS93LavYb+FDOuHL+Fzu4fOmcW7MUPHrhdK4m8ck9vdBYEnIDx7DEcrnm?=
 =?iso-8859-1?Q?9Mdx7gd5mkFL91AV4ixNfHPnnNJG6j/UVKEJiOozxi1JJ1JrwgQiG1YTV2?=
 =?iso-8859-1?Q?DgLk9xgWFQcn53JP8OkyuJ2zhr4wmbCDqunU3FXWesVEIl/Zdh6bJK3q3Q?=
 =?iso-8859-1?Q?yj49dtZw326RBkgjYjxFas2s0dH1dZtiPBbmyv0V0OGVfczyxjBC6qjecx?=
 =?iso-8859-1?Q?IZyFGkIOyHn0PZVp1zhDghqLYmowofiYv74t0wthTG1YVl0gZJ68dbk5cF?=
 =?iso-8859-1?Q?dO1x9uuiZ0drXxfHox5noZfL+0kTS5ktZuEwZx5jhPVfo3neo2mH3eDHTk?=
 =?iso-8859-1?Q?3LxV2zxwKq4SrELRjl7dAWLi5vfN0XeSEIfqkBvGx2Z8Rsun2bioreKQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dae8f80c-caf7-4789-f1fc-08dc49db46ea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 19:15:31.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myfGjgp49p+jYmRC6nNTdy7zHaF4JpdMiEcJh71WYrgP9mVpoDLZg7Rf8XGcIdV213Jbuf15OawSrRt+RSWbPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6427
X-OriginatorOrg: intel.com

On Thu, Mar 21, 2024 at 12:37:12PM +0100, Thomas Hellström wrote:
> Instead of handling the vm's rebind fence separately,
> which is error prone if they are not strictly ordered,
> attach rebind fences as kernel fences to the vm's resv.
> 

See comment from previous, do not like updates to __xe_pt_bind_vma but I
guess I can live with it. Otherwise LGTM.

With that:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_exec.c     | 31 +++----------------------------
>  drivers/gpu/drm/xe/xe_pt.c       |  2 +-
>  drivers/gpu/drm/xe/xe_vm.c       | 27 +++++++++------------------
>  drivers/gpu/drm/xe/xe_vm.h       |  2 +-
>  drivers/gpu/drm/xe/xe_vm_types.h |  3 ---
>  5 files changed, 14 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
> index 7692ebfe7d47..759497d4a102 100644
> --- a/drivers/gpu/drm/xe/xe_exec.c
> +++ b/drivers/gpu/drm/xe/xe_exec.c
> @@ -152,7 +152,6 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
>  	struct drm_exec *exec = &vm_exec.exec;
>  	u32 i, num_syncs = 0, num_ufence = 0;
>  	struct xe_sched_job *job;
> -	struct dma_fence *rebind_fence;
>  	struct xe_vm *vm;
>  	bool write_locked, skip_retry = false;
>  	ktime_t end = 0;
> @@ -294,35 +293,11 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
>  	 * Rebind any invalidated userptr or evicted BOs in the VM, non-compute
>  	 * VM mode only.
>  	 */
> -	rebind_fence = xe_vm_rebind(vm, false);
> -	if (IS_ERR(rebind_fence)) {
> -		err = PTR_ERR(rebind_fence);
> +	err = xe_vm_rebind(vm, false);
> +	if (err)
>  		goto err_put_job;
> -	}
> -
> -	/*
> -	 * We store the rebind_fence in the VM so subsequent execs don't get
> -	 * scheduled before the rebinds of userptrs / evicted BOs is complete.
> -	 */
> -	if (rebind_fence) {
> -		dma_fence_put(vm->rebind_fence);
> -		vm->rebind_fence = rebind_fence;
> -	}
> -	if (vm->rebind_fence) {
> -		if (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
> -			     &vm->rebind_fence->flags)) {
> -			dma_fence_put(vm->rebind_fence);
> -			vm->rebind_fence = NULL;
> -		} else {
> -			dma_fence_get(vm->rebind_fence);
> -			err = drm_sched_job_add_dependency(&job->drm,
> -							   vm->rebind_fence);
> -			if (err)
> -				goto err_put_job;
> -		}
> -	}
>  
> -	/* Wait behind munmap style rebinds */
> +	/* Wait behind rebinds */
>  	if (!xe_vm_in_lr_mode(vm)) {
>  		err = drm_sched_job_add_resv_dependencies(&job->drm,
>  							  xe_vm_resv(vm),
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 21bc0d13fccf..0484ed5b495f 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -1298,7 +1298,7 @@ __xe_pt_bind_vma(struct xe_tile *tile, struct xe_vma *vma, struct xe_exec_queue
>  		}
>  
>  		/* add shared fence now for pagetable delayed destroy */
> -		dma_resv_add_fence(xe_vm_resv(vm), fence, !rebind &&
> +		dma_resv_add_fence(xe_vm_resv(vm), fence, rebind ||
>  				   last_munmap_rebind ?
>  				   DMA_RESV_USAGE_KERNEL :
>  				   DMA_RESV_USAGE_BOOKKEEP);
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 80d43d75b1da..35fba6e3f889 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -522,7 +522,6 @@ static void preempt_rebind_work_func(struct work_struct *w)
>  {
>  	struct xe_vm *vm = container_of(w, struct xe_vm, preempt.rebind_work);
>  	struct drm_exec exec;
> -	struct dma_fence *rebind_fence;
>  	unsigned int fence_count = 0;
>  	LIST_HEAD(preempt_fences);
>  	ktime_t end = 0;
> @@ -568,18 +567,11 @@ static void preempt_rebind_work_func(struct work_struct *w)
>  	if (err)
>  		goto out_unlock;
>  
> -	rebind_fence = xe_vm_rebind(vm, true);
> -	if (IS_ERR(rebind_fence)) {
> -		err = PTR_ERR(rebind_fence);
> +	err = xe_vm_rebind(vm, true);
> +	if (err)
>  		goto out_unlock;
> -	}
> -
> -	if (rebind_fence) {
> -		dma_fence_wait(rebind_fence, false);
> -		dma_fence_put(rebind_fence);
> -	}
>  
> -	/* Wait on munmap style VM unbinds */
> +	/* Wait on rebinds and munmap style VM unbinds */
>  	wait = dma_resv_wait_timeout(xe_vm_resv(vm),
>  				     DMA_RESV_USAGE_KERNEL,
>  				     false, MAX_SCHEDULE_TIMEOUT);
> @@ -773,14 +765,14 @@ xe_vm_bind_vma(struct xe_vma *vma, struct xe_exec_queue *q,
>  	       struct xe_sync_entry *syncs, u32 num_syncs,
>  	       bool first_op, bool last_op);
>  
> -struct dma_fence *xe_vm_rebind(struct xe_vm *vm, bool rebind_worker)
> +int xe_vm_rebind(struct xe_vm *vm, bool rebind_worker)
>  {
> -	struct dma_fence *fence = NULL;
> +	struct dma_fence *fence;
>  	struct xe_vma *vma, *next;
>  
>  	lockdep_assert_held(&vm->lock);
>  	if (xe_vm_in_lr_mode(vm) && !rebind_worker)
> -		return NULL;
> +		return 0;
>  
>  	xe_vm_assert_held(vm);
>  	list_for_each_entry_safe(vma, next, &vm->rebind_list,
> @@ -788,17 +780,17 @@ struct dma_fence *xe_vm_rebind(struct xe_vm *vm, bool rebind_worker)
>  		xe_assert(vm->xe, vma->tile_present);
>  
>  		list_del_init(&vma->combined_links.rebind);
> -		dma_fence_put(fence);
>  		if (rebind_worker)
>  			trace_xe_vma_rebind_worker(vma);
>  		else
>  			trace_xe_vma_rebind_exec(vma);
>  		fence = xe_vm_bind_vma(vma, NULL, NULL, 0, false, false);
>  		if (IS_ERR(fence))
> -			return fence;
> +			return PTR_ERR(fence);
> +		dma_fence_put(fence);
>  	}
>  
> -	return fence;
> +	return 0;
>  }
>  
>  static void xe_vma_free(struct xe_vma *vma)
> @@ -1588,7 +1580,6 @@ static void vm_destroy_work_func(struct work_struct *w)
>  		XE_WARN_ON(vm->pt_root[id]);
>  
>  	trace_xe_vm_free(vm);
> -	dma_fence_put(vm->rebind_fence);
>  	kfree(vm);
>  }
>  
> diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
> index 6df1f1c7f85d..4853354336f2 100644
> --- a/drivers/gpu/drm/xe/xe_vm.h
> +++ b/drivers/gpu/drm/xe/xe_vm.h
> @@ -207,7 +207,7 @@ int __xe_vm_userptr_needs_repin(struct xe_vm *vm);
>  
>  int xe_vm_userptr_check_repin(struct xe_vm *vm);
>  
> -struct dma_fence *xe_vm_rebind(struct xe_vm *vm, bool rebind_worker);
> +int xe_vm_rebind(struct xe_vm *vm, bool rebind_worker);
>  
>  int xe_vm_invalidate_vma(struct xe_vma *vma);
>  
> diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
> index 5747f136d24d..badf3945083d 100644
> --- a/drivers/gpu/drm/xe/xe_vm_types.h
> +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> @@ -177,9 +177,6 @@ struct xe_vm {
>  	 */
>  	struct list_head rebind_list;
>  
> -	/** @rebind_fence: rebind fence from execbuf */
> -	struct dma_fence *rebind_fence;
> -
>  	/**
>  	 * @destroy_work: worker to destroy VM, needed as a dma_fence signaling
>  	 * from an irq context can be last put and the destroy needs to be able
> -- 
> 2.44.0
> 

