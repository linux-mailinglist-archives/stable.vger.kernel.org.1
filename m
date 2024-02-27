Return-Path: <stable+bounces-23901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B2A869130
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FC528E83B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA02413AA2C;
	Tue, 27 Feb 2024 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXNDX47z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1042F2D
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038916; cv=none; b=c9tlzHBq06PKiGmtbGrc2SKpbRdV4IYz4tfznrJWYZ2C8JiiupCn1dpleNXDZ9ooOIri0qXkfaiDUoR73utG11IUR6/NN8qCJ7x4u7srP9vC2WzeWK6xPzCa12BpyeAIB6yyUvJ9Y37NSvDcMrpHlTrsXimvO8MKCyPrQlLwAmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038916; c=relaxed/simple;
	bh=hVNMnSvbLYCbx95XY3vaP/ldl/K5ZThG0IBfwTtrGOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrAD5gwHotCtF8lFdSZqimPa4St/nka85Zt29ofQZA8ZjDwEDVe8oQOyz90IeKX8S1lwqn3kYQBy+TMEWp0WFjJV8UDyNCoBKphjuIkqP6IrdFtcJ5VfkIXu8WQYE3op+9DVd9/ZPnn162vrkEGZ+y6ViVxhtBl13baB2ZkcGfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXNDX47z; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709038915; x=1740574915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hVNMnSvbLYCbx95XY3vaP/ldl/K5ZThG0IBfwTtrGOM=;
  b=JXNDX47zOfujr7GRLa+pX9vKIxFLz06wqc9TmLFkID/5jJ6PyYhbpQrs
   0A6JEmrAMwjsZAZbK9m9ufy2NnmA+PvQspLX0XFfiCZwrso9uqZutLOBs
   IllDU69YjUPBnSTZ7/vceQwSID4Dijl38z4NyWVthrkvguGBqgxeQiKzh
   Tp7AaSa2I9eVU3Wx5aHQq2MV0kFX4ZtAOZas2/IbwBrbBGKTlvB2byfSM
   P1+HLA1xq70dtfH25OPN4kurtNLygoSaHZ0iWBPSKG8dW3OSmTTOI86U2
   RTskUzz+Zu4d7sMGwqt3h1FcuUxL0T4nooE1CbIQam5Aqk87H6BK16cwa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6324536"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6324536"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 05:01:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11802124"
Received: from ahirstiu-mobl1.ger.corp.intel.com (HELO intel.com) ([10.246.34.11])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 05:01:51 -0800
Date: Tue, 27 Feb 2024 14:01:48 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	stable@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 2/2] drm/i915/gt: Set default CCS mode '1'
Message-ID: <Zd3dPFEFWJsD_JlC@ashyti-mobl2.lan>
References: <20240220142034.257370-1-andi.shyti@linux.intel.com>
 <20240220142034.257370-3-andi.shyti@linux.intel.com>
 <87bk82je2u.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk82je2u.fsf@intel.com>

Hi Jani,

thanks, there has been a v2 after this and your comments have
been addressed somehow.

There will be a v3, as well.

Thanks,
Andi

On Tue, Feb 27, 2024 at 02:18:01PM +0200, Jani Nikula wrote:
> On Tue, 20 Feb 2024, Andi Shyti <andi.shyti@linux.intel.com> wrote:
> > Since CCS automatic load balancing is disabled, we will impose a
> > fixed balancing policy that involves setting all the CCS engines
> > to work together on the same load.
> >
> > Simultaneously, the user will see only 1 CCS rather than the
> > actual number. As of now, this change affects only DG2.
> >
> > Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
> > Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> > Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Matt Roper <matthew.d.roper@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.2+
> > ---
> >  drivers/gpu/drm/i915/gt/intel_gt.c      | 11 +++++++++++
> >  drivers/gpu/drm/i915/gt/intel_gt_regs.h |  2 ++
> >  drivers/gpu/drm/i915/i915_drv.h         | 17 +++++++++++++++++
> >  drivers/gpu/drm/i915/i915_query.c       |  5 +++--
> >  4 files changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/intel_gt.c
> > index a425db5ed3a2..e19df4ef47f6 100644
> > --- a/drivers/gpu/drm/i915/gt/intel_gt.c
> > +++ b/drivers/gpu/drm/i915/gt/intel_gt.c
> > @@ -168,6 +168,14 @@ static void init_unused_rings(struct intel_gt *gt)
> >  	}
> >  }
> >  
> > +static void intel_gt_apply_ccs_mode(struct intel_gt *gt)
> > +{
> > +	if (!IS_DG2(gt->i915))
> > +		return;
> > +
> > +	intel_uncore_write(gt->uncore, XEHP_CCS_MODE, 0);
> > +}
> > +
> >  int intel_gt_init_hw(struct intel_gt *gt)
> >  {
> >  	struct drm_i915_private *i915 = gt->i915;
> > @@ -195,6 +203,9 @@ int intel_gt_init_hw(struct intel_gt *gt)
> >  
> >  	intel_gt_init_swizzling(gt);
> >  
> > +	/* Configure CCS mode */
> > +	intel_gt_apply_ccs_mode(gt);
> > +
> >  	/*
> >  	 * At least 830 can leave some of the unused rings
> >  	 * "active" (ie. head != tail) after resume which
> > diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> > index cf709f6c05ae..c148113770ea 100644
> > --- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> > +++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> > @@ -1605,6 +1605,8 @@
> >  #define   GEN12_VOLTAGE_MASK			REG_GENMASK(10, 0)
> >  #define   GEN12_CAGF_MASK			REG_GENMASK(19, 11)
> >  
> > +#define XEHP_CCS_MODE                          _MMIO(0x14804)
> > +
> >  #define GEN11_GT_INTR_DW(x)			_MMIO(0x190018 + ((x) * 4))
> >  #define   GEN11_CSME				(31)
> >  #define   GEN12_HECI_2				(30)
> > diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> > index e81b3b2858ac..0853ffd3cb8d 100644
> > --- a/drivers/gpu/drm/i915/i915_drv.h
> > +++ b/drivers/gpu/drm/i915/i915_drv.h
> > @@ -396,6 +396,23 @@ static inline struct intel_gt *to_gt(const struct drm_i915_private *i915)
> >  	     (engine__); \
> >  	     (engine__) = rb_to_uabi_engine(rb_next(&(engine__)->uabi_node)))
> >  
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
> 
> Hrmh, I've been trying to pester folks to move the existing engine
> iterator macros away from i915_drv.h, so not happy to see more.
> 
> But since this is Cc: stable, better do that in a follow-up. Please?
> 
> > +	for_each_uabi_engine(engine__, i915__) \
> > +		if ((IS_DG2(i915__)) && \
> > +		    ((engine__)->uabi_class == I915_ENGINE_CLASS_COMPUTE) && \
> > +		    ((engine__)->uabi_instance)) { } \
> > +		else
> 
> We have for_each_if for this.
> 
> > +
> >  #define INTEL_INFO(i915)	((i915)->__info)
> >  #define RUNTIME_INFO(i915)	(&(i915)->__runtime)
> >  #define DRIVER_CAPS(i915)	(&(i915)->caps)
> > diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i915_query.c
> > index fa3e937ed3f5..2d41bda626a6 100644
> > --- a/drivers/gpu/drm/i915/i915_query.c
> > +++ b/drivers/gpu/drm/i915/i915_query.c
> > @@ -124,6 +124,7 @@ static int query_geometry_subslices(struct drm_i915_private *i915,
> >  	return fill_topology_info(sseu, query_item, sseu->geometry_subslice_mask);
> >  }
> >  
> > +
> 
> Superfluous newline change.
> 
> >  static int
> >  query_engine_info(struct drm_i915_private *i915,
> >  		  struct drm_i915_query_item *query_item)
> > @@ -140,7 +141,7 @@ query_engine_info(struct drm_i915_private *i915,
> >  	if (query_item->flags)
> >  		return -EINVAL;
> >  
> > -	for_each_uabi_engine(engine, i915)
> > +	for_each_available_uabi_engine(engine, i915)
> >  		num_uabi_engines++;
> >  
> >  	len = struct_size(query_ptr, engines, num_uabi_engines);
> > @@ -155,7 +156,7 @@ query_engine_info(struct drm_i915_private *i915,
> >  
> >  	info_ptr = &query_ptr->engines[0];
> >  
> > -	for_each_uabi_engine(engine, i915) {
> > +	for_each_available_uabi_engine(engine, i915) {
> >  		info.engine.engine_class = engine->uabi_class;
> >  		info.engine.engine_instance = engine->uabi_instance;
> >  		info.flags = I915_ENGINE_INFO_HAS_LOGICAL_INSTANCE;
> 
> -- 
> Jani Nikula, Intel

