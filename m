Return-Path: <stable+bounces-45681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 009BD8CD23F
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 14:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328161C211B3
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 12:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2485013C3E7;
	Thu, 23 May 2024 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHMLGmED"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5413BAE5
	for <stable@vger.kernel.org>; Thu, 23 May 2024 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467070; cv=none; b=pRDfwrmXsETrroz0vRIzAdvNRh1+ElYipr/LHXvGU+ja6WT2G8DwAPgRediRreAioDBeEE9gHIkj7Ebu4HhGeC5NyD4gB1380rGW0owf1t7utn14ckdWdOSTAvUpaxM1DH65cLizxL2BBQjrifCpv79fnJACq2yAqyHByrtmWf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467070; c=relaxed/simple;
	bh=x3/gDXCN8QwyY7LtftEfCAY5ZJlQ8iNcSJuXoLgkKpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUW9JyEVzUNSwHzPefYRn1C3JPMgF37a277soPTIo8g2tosSIg2RkUq+pQJva7i6P+ADCi71FYIFQE23D2ip3XnAh5VAiWp3bGLiIByVtnP+eOMKVRlxMZNsvxTZmz4RYr2Hmom6BebKQ19ikYi1zfDoa9xYrxpBGWEVRVUr84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHMLGmED; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716467068; x=1748003068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=x3/gDXCN8QwyY7LtftEfCAY5ZJlQ8iNcSJuXoLgkKpc=;
  b=kHMLGmEDetU4sbJMX3FLOc8LPokqJW+4nU/l4LQEF+Gj1Bn04C5+zxql
   Diz5vyyL9ARJKOaNA4Z9raCLC9ldBDgPU/MfqvKxAEF/mVA9JjQEa6oy1
   rjz8X4TFm+VLdEDpErGA8CEeoiulqP1sPi0fkc95nLqX81GrjeHNhLg5U
   mFL+ueLk0/THv+LtMZ0ByZlCW33tarSzJHgaH57Nt5xA8+GzzFgPzTsQF
   3nHjV9L89fUAgd/2eaPwI+BkBMILK60d5LIfno1MOwmhE+EQizzCCyS8e
   hwtr0ENJ/6jyWw214ZrWv7LrshJz5V/d906wQL4+XXwxG3a477fGvwcN6
   Q==;
X-CSE-ConnectionGUID: XyXxLWifS5KIkaovA+ec7w==
X-CSE-MsgGUID: Zp/zfDtUQUupPQgA4vLO6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12896209"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="12896209"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 05:24:28 -0700
X-CSE-ConnectionGUID: sT/bykXxTj6c8qchiUwrMg==
X-CSE-MsgGUID: rrME+WXwRRuhNSt37UKCEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="33635693"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 23 May 2024 05:24:25 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 23 May 2024 15:24:24 +0300
Date: Thu, 23 May 2024 15:24:24 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Vidya Srinivas <vidya.srinivas@intel.com>,
	intel-gfx@lists.freedesktop.org, shawn.c.lee@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/dpt: Make DPT object unshrinkable
Message-ID: <Zk81eDBUlz_axOn4@intel.com>
References: <20240520165634.1162470-1-vidya.srinivas@intel.com>
 <20240522152916.1702614-1-vidya.srinivas@intel.com>
 <5e5660ac-e14b-4759-a6f6-38cc55d37246@ursulin.net>
 <Zk8mM0bh5QMGcSGL@intel.com>
 <0f459a5b-4926-40ea-820e-ab0e5516a821@ursulin.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f459a5b-4926-40ea-820e-ab0e5516a821@ursulin.net>
X-Patchwork-Hint: comment

On Thu, May 23, 2024 at 01:07:24PM +0100, Tvrtko Ursulin wrote:
> 
> On 23/05/2024 12:19, Ville Syrjälä wrote:
> > On Thu, May 23, 2024 at 09:25:45AM +0100, Tvrtko Ursulin wrote:
> >>
> >> On 22/05/2024 16:29, Vidya Srinivas wrote:
> >>> In some scenarios, the DPT object gets shrunk but
> >>> the actual framebuffer did not and thus its still
> >>> there on the DPT's vm->bound_list. Then it tries to
> >>> rewrite the PTEs via a stale CPU mapping. This causes panic.
> >>>
> >>> Suggested-by: Ville Syrjala <ville.syrjala@linux.intel.com>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: 0dc987b699ce ("drm/i915/display: Add smem fallback allocation for dpt")
> >>> Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
> >>> ---
> >>>    drivers/gpu/drm/i915/gem/i915_gem_object.h | 3 ++-
> >>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> >>> index 3560a062d287..e6b485fc54d4 100644
> >>> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
> >>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> >>> @@ -284,7 +284,8 @@ bool i915_gem_object_has_iomem(const struct drm_i915_gem_object *obj);
> >>>    static inline bool
> >>>    i915_gem_object_is_shrinkable(const struct drm_i915_gem_object *obj)
> >>>    {
> >>> -	return i915_gem_object_type_has(obj, I915_GEM_OBJECT_IS_SHRINKABLE);
> >>> +	return i915_gem_object_type_has(obj, I915_GEM_OBJECT_IS_SHRINKABLE) &&
> >>> +		!obj->is_dpt;
> >>
> >> Is there a reason i915_gem_object_make_unshrinkable() cannot be used to
> >> mark the object at a suitable place?
> > 
> > Do you have a suitable place in mind?
> > i915_gem_object_make_unshrinkable() contains some magic
> > ingredients so doesn't look like it can be called willy
> > nilly.
> 
> After it is created in intel_dpt_create?
> 
> I don't see that helper couldn't be called. It is called from madvise 
> and tiling for instance without any apparent special considerations.

Did you actually read through i915_gem_object_make_unshrinkable()?

> 
> Also, there is no mention of this angle in the commit message so I 
> assumed it wasn't considered. If it was, then it should have been 
> mentioned why hacky solution was chosen instead...

I suppose.

> 
> > Anyways, looks like I forgot to reply that I already pushed this
> > with this extra comment added:
> > /* TODO: make DPT shrinkable when it has no bound vmas */
> 
> ... becuase IMO the special case is quite ugly and out of place. :(

Yeah, not the nicest. But there's already a is_dpt check in the
i915_gem_object_is_framebuffer() right next door, so it's not
*that* out of place.

Another option maybe could be to manually clear
I915_GEM_OBJECT_IS_SHRINKABLE but I don't think that is
supposed to be mutable, so might also have other issues.
So a more proper solution with that approach would perhaps
need some kind of gem_create_shmem_unshrinkable() function.

> 
> I don't remember from the top of my head how DPT magic works but if 
> shrinker protection needs to be tied with VMAs there is also 
> i915_make_make(un)shrinkable to try.

I presume you mistyped something there.

-- 
Ville Syrjälä
Intel

