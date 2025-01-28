Return-Path: <stable+bounces-110989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48214A20E60
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8612D3A3FB5
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 16:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540CD1D515B;
	Tue, 28 Jan 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMP28rof"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1261A9B29;
	Tue, 28 Jan 2025 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081179; cv=none; b=cvChSsUBPHnK98rqLvr3qcbWfXdQpzad9RG041OzGRwzakZIKfkM1SKpGmiLj/NcyBqzcg6zZv6SQI1WxxE3QlJvnZBw9BO3w28tK1sMxcVgzLkuKn7kNU6ApTwfVXdOuseQkYc7TxqgEGsHMDHaubSu9qmMUkmBW++UpJmALdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081179; c=relaxed/simple;
	bh=RrZYsnhVtZvJnqaZ+K9b85vjJ864CR/u6n1y6fJs/UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLqchm3+TiFl/vpx1OPF2d2b0HH1Wp2DTzZOF8Napn2owvC7m0bGSw0dsVtGxZ1kVHXXJQhSTTmGqD2lh5y7l5ZOSwMmQf1l2UF+LXwnmxalqZ0ZFt1f/mW6W7aAUvYDdtmO8Dr4+MhrNMz2Y/zP1mQG/h08Jud3g0XGvgSnfpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMP28rof; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738081178; x=1769617178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RrZYsnhVtZvJnqaZ+K9b85vjJ864CR/u6n1y6fJs/UM=;
  b=kMP28rof+5co0mg4+HfuOPQRNKXKngStFsZOQmnTKF0AUVWTzpbOKAyb
   3NSNUKPisBwfJnY+9soQ9OgmZOMwXscnvLpWf1NRRHH65DO2iKeQ9MFuY
   SEIxuuK3WpravaoYTuETa0Rs2ALr0RB/3n89A5ABSA1oOcU5ZS+xtFbiH
   QhjpeSiZVUFSfaB65Vi4wVMhhuKuRrtMvaRToWNBnfL6+kjPbmHlHZ26j
   zxfRREuy8VC1/RLSq1un8HURYRmwtylIUK3u/b+tFjh826h5IkbkPhSxH
   47nwxwPpUfWaxmOQWovV8AQLhJnFs2fBHbqQacWTeIOEzemaNLOpim+Vg
   A==;
X-CSE-ConnectionGUID: LqQyy0DOSRuM75WZAc3mtA==
X-CSE-MsgGUID: QA+a+/ncR2+reoYxlpKrDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="38456447"
X-IronPort-AV: E=Sophos;i="6.13,241,1732608000"; 
   d="scan'208";a="38456447"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 08:19:37 -0800
X-CSE-ConnectionGUID: KWgGovjsQfiLTnLRIYkZ5w==
X-CSE-MsgGUID: 7ZyubuLpQXuJRP4oZ97/pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,241,1732608000"; 
   d="scan'208";a="108880158"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 28 Jan 2025 08:19:32 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 28 Jan 2025 18:19:31 +0200
Date: Tue, 28 Jan 2025 18:19:31 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Brian Geffon <bgeffon@google.com>
Cc: intel-gfx@lists.freedesktop.org, chris.p.wilson@intel.com,
	jani.saarinen@intel.com, tomasz.mistat@intel.com,
	vidya.srinivas@intel.com, jani.nikula@linux.intel.com,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	stable@vger.kernel.org, Tomasz Figa <tfiga@google.com>
Subject: Re: [PATCH v3] drm/i915: Fix page cleanup on DMA remap failure
Message-ID: <Z5kDk69SkeHgwnj2@intel.com>
References: <20250127204332.336665-1-bgeffon@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250127204332.336665-1-bgeffon@google.com>
X-Patchwork-Hint: comment

On Mon, Jan 27, 2025 at 03:43:32PM -0500, Brian Geffon wrote:
> When converting to folios the cleanup path of shmem_get_pages() was
> missed. When a DMA remap fails and the max segment size is greater than
> PAGE_SIZE it will attempt to retry the remap with a PAGE_SIZEd segment
> size. The cleanup code isn't properly using the folio apis and as a
> result isn't handling compound pages correctly.
> 
> v2 -> v3:
> (Ville) Just use shmem_sg_free_table() as-is in the failure path of
> shmem_get_pages(). shmem_sg_free_table() will clear mapping unevictable
> but it will be reset when it retries in shmem_sg_alloc_table().
> 
> v1 -> v2:
> (Ville) Fixed locations where we were not clearing mapping unevictable.
> 
> Cc: stable@vger.kernel.org
> Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
> Cc: Vidya Srinivas <vidya.srinivas@intel.com>
> Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13487
> Link: https://lore.kernel.org/lkml/20250116135636.410164-1-bgeffon@google.com/
> Fixes: 0b62af28f249 ("i915: convert shmem_sg_free_table() to use a folio_batch")
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> Suggested-by: Tomasz Figa <tfiga@google.com>

Thanks. Pushed to drm-intel-gt-next.

> ---
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index fe69f2c8527d..ae3343c81a64 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -209,8 +209,6 @@ static int shmem_get_pages(struct drm_i915_gem_object *obj)
>  	struct address_space *mapping = obj->base.filp->f_mapping;
>  	unsigned int max_segment = i915_sg_segment_size(i915->drm.dev);
>  	struct sg_table *st;
> -	struct sgt_iter sgt_iter;
> -	struct page *page;
>  	int ret;
>  
>  	/*
> @@ -239,9 +237,7 @@ static int shmem_get_pages(struct drm_i915_gem_object *obj)
>  		 * for PAGE_SIZE chunks instead may be helpful.
>  		 */
>  		if (max_segment > PAGE_SIZE) {
> -			for_each_sgt_page(page, sgt_iter, st)
> -				put_page(page);
> -			sg_free_table(st);
> +			shmem_sg_free_table(st, mapping, false, false);
>  			kfree(st);
>  
>  			max_segment = PAGE_SIZE;
> -- 
> 2.48.1.262.g85cc9f2d1e-goog

-- 
Ville Syrjälä
Intel

