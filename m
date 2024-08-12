Return-Path: <stable+bounces-67384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5A394F828
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 22:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1361C21CD8
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 20:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D103219307D;
	Mon, 12 Aug 2024 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ijn7kJsT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CE2186E30
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723494196; cv=none; b=osZQB8RvRR9dUZrS44aq6XOqNcl65nBJzE+sbnbCK448PQ01tjrjXaYEFR89M217YsWSXij+mfnN+Q0NPPhDjbYz64MlyL7BER4kDywNRJPQsilB9WAA/LwdkWca4Qyt5S6rgU4d6YMfgvkDOt1S/Os8e7FyCROGq0YOcF1y/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723494196; c=relaxed/simple;
	bh=qVjbaSYLTSyg4Jp/11rgxoe4NG7CUf6xcrGt4UPk5U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiN3YCjqHLrc6mmH+V196XLiq7OtA6ZTUURlxSbr/xq0OQo0pBIAYD4Ud8Y/Pp2SNPWIU53n995PoT9ZTwaI1dphprb2A0VKn2W+XLwHaI2X7mFyfMv2daeTJlTcyAa90N+u1HmLvJZqfkWtqlrcArambe67GEdxq7XJfQdfcRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ijn7kJsT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723494194; x=1755030194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qVjbaSYLTSyg4Jp/11rgxoe4NG7CUf6xcrGt4UPk5U8=;
  b=Ijn7kJsTtvep30PG/5/Svf5kOIm2GWniW777cEUypT+xYOM1p/w8pc9f
   bFBUEPxVWmEOsaMfHcQWLgUrBK5TXtDLi/TJPHZZEtbx5sTxjx2/oFi0+
   qmW7sWlkByNtuhxd5hbikE0T+YQav++Ykonu3vSkyZGRs6f8NKF+Eq07L
   SdK1EfkaXJzthdcUCG0EHWxnIibf591va0TrXHclOpOUFEDLF8eQEOiGi
   mKPkKwgUuUu1Z8+GHQ6xW5uJ0YJjrecC7MGb+lCzwlP16h3+YszwkFHzE
   KlLv0AnENeHO0MxAQ8owul8FXuK3QzZkosi8mODEBHgrZF00FmVzW9tY+
   Q==;
X-CSE-ConnectionGUID: AKRKu8cWRde4MOxfgdhXWw==
X-CSE-MsgGUID: zVy25flyT4q0y0XqYgK3Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21759993"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="21759993"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 13:23:13 -0700
X-CSE-ConnectionGUID: bOgw3otYSaeUXHP4icABxA==
X-CSE-MsgGUID: hQNiLavLQRCAbXAnX6lUZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="58048658"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO intel.com) ([10.245.246.188])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 13:23:12 -0700
Date: Mon, 12 Aug 2024 22:23:07 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: andi.shyti@linux.intel.com, chris.p.wilson@linux.intel.com,
	jonathan.cavitt@intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] drm/i915/gem: Adjust vma offset for
 framebuffer mmap offset" failed to apply to 6.1-stable tree
Message-ID: <ZrpvK43GfF0yOgGQ@ashyti-mobl2.lan>
References: <2024081209-faculty-overplant-91c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024081209-faculty-overplant-91c9@gregkh>

Hi Greg,

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> index a2195e28b625..ce10dd259812 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> @@ -1084,6 +1084,8 @@ int i915_gem_fb_mmap(struct drm_i915_gem_object *obj, struct vm_area_struct *vma
>  		mmo = mmap_offset_attach(obj, mmap_type, NULL);
>  		if (IS_ERR(mmo))
>  			return PTR_ERR(mmo);
> +
> +		vma->vm_pgoff += drm_vma_node_start(&mmo->vma_node);

This patch can't apply in stables 4.19 to 6.1 as there was no fb
mapping in that kernel range.

Sorry, I should have specified it in the commit log.

(while the other patch of the series should be applied from 4.19,
I'm just just testing it)

Thanks,
Andi

