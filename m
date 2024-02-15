Return-Path: <stable+bounces-20325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ECF857098
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 23:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996681F2735D
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 22:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484F1E894;
	Thu, 15 Feb 2024 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8FkyiVZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B255E7F
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036484; cv=none; b=eHY1+YwbyCDaJcLTRG5GFK9fCw+XXeZNY9IHxm3Afeh3e8bFXaTIdRHBUH7KOobEz1ANDErBNoIIv5lPW+4mLRrrcvNtfiS8qvmWsMkvSExWGsqIWEDMyjnlZ4ENqrZnM+/FEWnmjdseY3mNeWf+gfCEflo4iLYCqk/0VIqilXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036484; c=relaxed/simple;
	bh=ovOx7YhupNgGk3WIudcdFj2YU1jO94K1AbDhXRHjqLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFHAkirq8pitJB69hG0y1SxxUO1peD2Hm4devDhr+D8PlwCTvKxHApXGUxiaPmbl/U+CJ0XVfZ9pnzoPOfXGtQ85imjeScm3+9E9e9OT8rdWIgUi88Gs7vGA44ZuPYDNdnGEZRTzjJ+kCFC5x44hdoAa3rtnVel9UP+5W6X5a7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8FkyiVZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708036483; x=1739572483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ovOx7YhupNgGk3WIudcdFj2YU1jO94K1AbDhXRHjqLY=;
  b=N8FkyiVZ9KvHkSuVyoUfNC1m00THqgoEkuLSMMLKg6ZSwIkefEsvvQXW
   BCrmb9xeuumzSnCzpT8uk7oInp8ZhP0Y3VZE+mhQ6A8uq4JwXd+RBKaaT
   PnP4GAHWiYkwDH8wsIn/lVqlB7xkBFDVfGXVEMGLl/Pjc7NtJxZRNb3dK
   f0Qqkfj2XFbBc8xOievhPf26N74hg7lfYdyCBi/5cGlenvO4Fk77SjjYM
   wHLIYOebAJ2F4VFzeEboeoPlkuYBjN5Pd3gCfLCoNp5pECg5uW4N+JmXQ
   KrVk53HaCSrhUH9IV6AkOWulJsW8Yk+uaONPceNiqWV79LR3nqNnh0+9I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5967095"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="5967095"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 14:34:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="3752872"
Received: from gpolsine-mobl1.ger.corp.intel.com (HELO intel.com) ([10.94.248.101])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 14:34:38 -0800
Date: Thu, 15 Feb 2024 23:34:35 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: John Harrison <john.c.harrison@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>, stable@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 2/2] drm/i915/gt: Set default CCS mode '1'
Message-ID: <Zc6Re9yg-OXpvwdh@ashyti-mobl2.lan>
References: <20240215135924.51705-1-andi.shyti@linux.intel.com>
 <20240215135924.51705-3-andi.shyti@linux.intel.com>
 <be6484e3-d209-4109-97e9-efe02e4e570b@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be6484e3-d209-4109-97e9-efe02e4e570b@intel.com>

Hi John,

On Thu, Feb 15, 2024 at 01:23:24PM -0800, John Harrison wrote:
> On 2/15/2024 05:59, Andi Shyti wrote:
> > Since CCS automatic load balancing is disabled, we will impose a
> > fixed balancing policy that involves setting all the CCS engines
> > to work together on the same load.
> > 
> > Simultaneously, the user will see only 1 CCS rather than the
> > actual number. As of now, this change affects only DG2.
> These two paragraphs are mutually exclusive. You can't have four CCS engines
> 'working together' if only one engine exists. I think you are meaning that
> we only export 1 CCS engine and that single engine is configured to control
> all the EUs. As opposed to running in 4 CCS engine mode where the EUs are
> (dynamically or statically) divided amongst those four engines.

The balancing is done statically. The dynamic balancing is
disabled in patch 1.

The 2 or 4 CCS engines will share the same workload.

Because the user won't be able anymore to select the CCS engine
he wants to use, he will see only one CCS.

I think we are saying the same thing using different words :)
I can try in v2 to reword the commit better.

Thanks for looking into this.
Andi

> John.
> 
> > 
> > Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
> > Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> > Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Matt Roper <matthew.d.roper@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.2+
> > ---
> >   drivers/gpu/drm/i915/gt/intel_gt.c      | 11 +++++++++++
> >   drivers/gpu/drm/i915/gt/intel_gt_regs.h |  2 ++
> >   drivers/gpu/drm/i915/i915_drv.h         | 17 +++++++++++++++++
> >   drivers/gpu/drm/i915/i915_query.c       |  5 +++--
> >   4 files changed, 33 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/intel_gt.c
> > index a425db5ed3a2..e19df4ef47f6 100644
> > --- a/drivers/gpu/drm/i915/gt/intel_gt.c
> > +++ b/drivers/gpu/drm/i915/gt/intel_gt.c
> > @@ -168,6 +168,14 @@ static void init_unused_rings(struct intel_gt *gt)
> >   	}
> >   }
> > +static void intel_gt_apply_ccs_mode(struct intel_gt *gt)
> > +{
> > +	if (!IS_DG2(gt->i915))
> > +		return;
> > +
> > +	intel_uncore_write(gt->uncore, XEHP_CCS_MODE, 0);
> > +}
> > +
> >   int intel_gt_init_hw(struct intel_gt *gt)
> >   {
> >   	struct drm_i915_private *i915 = gt->i915;
> > @@ -195,6 +203,9 @@ int intel_gt_init_hw(struct intel_gt *gt)
> >   	intel_gt_init_swizzling(gt);
> > +	/* Configure CCS mode */
> > +	intel_gt_apply_ccs_mode(gt);
> > +
> >   	/*
> >   	 * At least 830 can leave some of the unused rings
> >   	 * "active" (ie. head != tail) after resume which
> > diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> > index cf709f6c05ae..c148113770ea 100644
> > --- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> > +++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> > @@ -1605,6 +1605,8 @@
> >   #define   GEN12_VOLTAGE_MASK			REG_GENMASK(10, 0)
> >   #define   GEN12_CAGF_MASK			REG_GENMASK(19, 11)
> > +#define XEHP_CCS_MODE                          _MMIO(0x14804)
> > +
> >   #define GEN11_GT_INTR_DW(x)			_MMIO(0x190018 + ((x) * 4))
> >   #define   GEN11_CSME				(31)
> >   #define   GEN12_HECI_2				(30)
> > diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> > index e81b3b2858ac..0853ffd3cb8d 100644
> > --- a/drivers/gpu/drm/i915/i915_drv.h
> > +++ b/drivers/gpu/drm/i915/i915_drv.h
> > @@ -396,6 +396,23 @@ static inline struct intel_gt *to_gt(const struct drm_i915_private *i915)
> >   	     (engine__); \
> >   	     (engine__) = rb_to_uabi_engine(rb_next(&(engine__)->uabi_node)))
> > +/*
> > + * Exclude unavailable engines.
> > + *
> > + * Only the first CCS engine is utilized due to the disabling of CCS auto load
> > + * balancing. As a result, all CCS engines operate collectively, functioning
> > + * essentially as a single CCS engine, hence the count of active CCS engines is
> > + * considered '1'.
> > + * Currently, this applies to platforms with more than one CCS engine,
> > + * specifically DG2.
> > + */
> > +#define for_each_available_uabi_engine(engine__, i915__) \
> > +	for_each_uabi_engine(engine__, i915__) \
> > +		if ((IS_DG2(i915__)) && \
> > +		    ((engine__)->uabi_class == I915_ENGINE_CLASS_COMPUTE) && \
> > +		    ((engine__)->uabi_instance)) { } \
> > +		else
> > +
> >   #define INTEL_INFO(i915)	((i915)->__info)
> >   #define RUNTIME_INFO(i915)	(&(i915)->__runtime)
> >   #define DRIVER_CAPS(i915)	(&(i915)->caps)
> > diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i915_query.c
> > index fa3e937ed3f5..2d41bda626a6 100644
> > --- a/drivers/gpu/drm/i915/i915_query.c
> > +++ b/drivers/gpu/drm/i915/i915_query.c
> > @@ -124,6 +124,7 @@ static int query_geometry_subslices(struct drm_i915_private *i915,
> >   	return fill_topology_info(sseu, query_item, sseu->geometry_subslice_mask);
> >   }
> > +
> >   static int
> >   query_engine_info(struct drm_i915_private *i915,
> >   		  struct drm_i915_query_item *query_item)
> > @@ -140,7 +141,7 @@ query_engine_info(struct drm_i915_private *i915,
> >   	if (query_item->flags)
> >   		return -EINVAL;
> > -	for_each_uabi_engine(engine, i915)
> > +	for_each_available_uabi_engine(engine, i915)
> >   		num_uabi_engines++;
> >   	len = struct_size(query_ptr, engines, num_uabi_engines);
> > @@ -155,7 +156,7 @@ query_engine_info(struct drm_i915_private *i915,
> >   	info_ptr = &query_ptr->engines[0];
> > -	for_each_uabi_engine(engine, i915) {
> > +	for_each_available_uabi_engine(engine, i915) {
> >   		info.engine.engine_class = engine->uabi_class;
> >   		info.engine.engine_instance = engine->uabi_instance;
> >   		info.flags = I915_ENGINE_INFO_HAS_LOGICAL_INSTANCE;

