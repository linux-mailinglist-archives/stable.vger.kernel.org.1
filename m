Return-Path: <stable+bounces-98798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF999E55AE
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 13:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D135285068
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 12:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83A7218AA9;
	Thu,  5 Dec 2024 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eer1g3a/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FE81D9A7E
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402447; cv=none; b=G3vKGewGEM0CfVX1wiMd7/cwq2b4Wg2X5LKxpQeSP00GUqidpryScVdgFmlolS89t1KNMPgW+0fcwoFl+OCSW5Qhv6PVYBBR0YeIuLKZ4LG0O8AJRxU6Uw4mvgR0Po23XZAYy0bVxuPgWQ2AiqeSR3BuzpFNJpIoT3nZktnWlB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402447; c=relaxed/simple;
	bh=zF/bf753W7ggWjhtIhc8H8UpIw347cBvo2vbbUyw7SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1L5PTt2XQlnXvtK7rDjr7rYChNzjrgV8L6e8E850CKjlOPneuSpAc7lyMLbHKxnUIhwt6kz0PvgQ3auQfGZV3ejRB+iUuPYzj6lJPE1vWRWhTTut3Gf6vqEwit8GLCCCixrjZ47yC+qZnCy8Nj35TGZR91Btp/g0LwHEXXuvDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eer1g3a/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733402446; x=1764938446;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zF/bf753W7ggWjhtIhc8H8UpIw347cBvo2vbbUyw7SY=;
  b=Eer1g3a/D0KEcKevC3IWZrvP5YbtTgyj/ur3815D5q08vcbw6OQQRgyK
   HkAmMFHmB259j+jIaS1xJkk//ij8//sUYugs5HDU08aFmhBOgQcHs0jxF
   zNxZ3tQ3XgMbjef+VifxQVxAjIksJwjw83LaAM9waZ1pIfXiCt3dus4Oy
   awnwYFjNx5SEDFUOlC4ynVpgHlPS7SLTvfUUUsYus7o85fmjlQMcLHgYQ
   5nXgwja+cFWPEnUhGm+tWVubR5tFvCvysmngriRLbm1ZsxERbPDuVD++b
   FR/2LS4SpRiiYX/sGYRGwW2wi8kzpIaewRzrg+bX1wCgUjTMzfVMVJt0v
   g==;
X-CSE-ConnectionGUID: 4Z8U3I1wRC2urOGS0vOovA==
X-CSE-MsgGUID: xW29LRDaRLSRAvCz2vqZqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="51127259"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="51127259"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 04:40:45 -0800
X-CSE-ConnectionGUID: mtm+bbumSIy3Jhtk6o26Xw==
X-CSE-MsgGUID: j/GyQrDNQ3mISVXKlKmB+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="98892845"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO [10.245.244.50]) ([10.245.244.50])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 04:40:45 -0800
Message-ID: <5eb91aa3-6d84-47a9-9f07-1742fe723c41@intel.com>
Date: Thu, 5 Dec 2024 12:40:41 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/xe: Wait for migration job before unmapping
 pages
To: Nirmoy Das <nirmoy.das@intel.com>, intel-xe@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, stable@vger.kernel.org
References: <20241205120253.2015537-1-nirmoy.das@intel.com>
 <20241205120253.2015537-2-nirmoy.das@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20241205120253.2015537-2-nirmoy.das@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/12/2024 12:02, Nirmoy Das wrote:
> There could be still migration job going on while doing
> xe_tt_unmap_sg() which could trigger GPU page faults. Fix this by
> waiting for the migration job to finish.
> 
> v2: Use intr=false(Matt A)
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3466
> Fixes: 75521e8b56e8 ("drm/xe: Perform dma_map when moving system buffer objects to TT")
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.11+
> Cc: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>

Ok, so this is something like ttm_bo_move_to_ghost() doing a pipeline 
move for tt -> system, but we then do xe_tt_unmap_sg() too early which 
tears down the IOMMU (if enabled) mappings whilst the job is in progress?

Maybe add some more info to the commit message? I think this for sure 
fixes it. Just wondering if it's somehow possible to keep the mapping 
until the job is done, since all tt -> sys moves are now synced here?

Unless Thomas has a better idea here,
Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/xe/xe_bo.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index b2aa368a23f8..c906a5529db0 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -857,8 +857,16 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
>   
>   out:
>   	if ((!ttm_bo->resource || ttm_bo->resource->mem_type == XE_PL_SYSTEM) &&
> -	    ttm_bo->ttm)
> +	    ttm_bo->ttm) {
> +		long timeout = dma_resv_wait_timeout(ttm_bo->base.resv,
> +						     DMA_RESV_USAGE_BOOKKEEP,
> +						     false,
> +						     MAX_SCHEDULE_TIMEOUT);
> +		if (timeout < 0)
> +			ret = timeout;
> +
>   		xe_tt_unmap_sg(ttm_bo->ttm);
> +	}
>   
>   	return ret;
>   }


