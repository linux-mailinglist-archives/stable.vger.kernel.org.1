Return-Path: <stable+bounces-21762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D6185CC91
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 01:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F59CB224C7
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 00:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55682384;
	Wed, 21 Feb 2024 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFdjb4Ac"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B763193
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 00:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708474347; cv=none; b=ADOEeh/oQCgy+5Duul1PD/lhXSEYXV9VpbPE4vkfhpNCWmrkGygHwuvQlQTNYT6vN6wTsi7BiPdIcaFhZ46LCOAbtYBcbgkrdpdzSEtr1y70oakc4zYBwDtShgOmE7g7v1dxS22MAUrKZwS2ZcVy4keHkJiJDkb+7/fZA6EobXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708474347; c=relaxed/simple;
	bh=cfIkHNXVDAoqEYt2ILB8kEy0Bcdi8AQQ7vYgwpZ6qmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqMIWw1/F0VaccyWOy+NVBqx8viWOLaEWf/M9+xUfNH/WFaJ3exKrca4zwBcgKTFn4+E7Z9guSwiVK2nOPjPzV2pfsgChiRXldp1/FktnH9hFzWBZFQK1II/YeWir3mNLHmPrxXJo/wfdgcxtbbMAXgR7IfGfCpT15VZ917Wx5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFdjb4Ac; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708474345; x=1740010345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cfIkHNXVDAoqEYt2ILB8kEy0Bcdi8AQQ7vYgwpZ6qmY=;
  b=KFdjb4AcTb57vWxT+QZmAbwx0+D/skHocNA4sS2c8Z3DfkPtLUnNkLGZ
   RrSJk1TwPdzHQuJ+tM8iTITPNj4/wbZgqabksyL2/O6fNtdOy8N7rylq9
   duAjb0qZqF9PsPvYhAe/MSwvXjBB4IwFtsQEdUSQYveGnmIzTgOLQeQtC
   StVXIxlOKVPq88dJ4ZTP13FjyYDSV4XcNsim/g0uFId3uLDpwM/si1T7H
   x5rOWdISLEWBxxoJ6Jqh/TDZlM3Hutb2OcFYfr8XAK0DVrXXhAWO/0Hwm
   v6hGZ30oc8rBLgPIfVoU6iMb85EGu0KskWN9uUQlY/bKsOVBz0/pAoaEf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2477735"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2477735"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 16:12:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5306495"
Received: from okeles-mobl.ger.corp.intel.com (HELO intel.com) ([10.246.32.195])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 16:12:21 -0800
Date: Wed, 21 Feb 2024 01:12:18 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Matt Roper <matthew.d.roper@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	John Harrison <John.C.Harrison@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	stable@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v2 2/2] drm/i915/gt: Enable only one CCS for compute
 workload
Message-ID: <ZdU_4okr8GcSpTtm@ashyti-mobl2.lan>
References: <20240220143526.259109-1-andi.shyti@linux.intel.com>
 <20240220143526.259109-3-andi.shyti@linux.intel.com>
 <20240220233918.GG5347@mdroper-desk1.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220233918.GG5347@mdroper-desk1.amr.corp.intel.com>

Hi Matt,

thanks a lot for looking into this.

On Tue, Feb 20, 2024 at 03:39:18PM -0800, Matt Roper wrote:
> On Tue, Feb 20, 2024 at 03:35:26PM +0100, Andi Shyti wrote:

[...]

> > diff --git a/drivers/gpu/drm/i915/gt/intel_engine_user.c b/drivers/gpu/drm/i915/gt/intel_engine_user.c
> > index 833987015b8b..7041acc77810 100644
> > --- a/drivers/gpu/drm/i915/gt/intel_engine_user.c
> > +++ b/drivers/gpu/drm/i915/gt/intel_engine_user.c
> > @@ -243,6 +243,15 @@ void intel_engines_driver_register(struct drm_i915_private *i915)
> >  		if (engine->uabi_class == I915_NO_UABI_CLASS)
> >  			continue;
> >  
> > +		/*
> > +		 * Do not list and do not count CCS engines other than the first
> > +		 */
> > +		if (engine->uabi_class == I915_ENGINE_CLASS_COMPUTE &&
> > +		    engine->uabi_instance > 0) {
> > +			i915->engine_uabi_class_count[engine->uabi_class]--;
> > +			continue;
> > +		}
> 
> Wouldn't it be simpler to just add a workaround to the end of
> engine_mask_apply_compute_fuses() if we want to ensure only a single
> compute engine gets exposed?  Then both the driver internals and uapi
> will agree that's there's just one CCS (and on which one there is).
> 
> If we want to do something fancy with "hotplugging" a new engine later
> on or whatever, that can be handled in the future series (although as
> noted on the previous patch, it sounds like these changes might not
> actually be aligned with the workaround we were trying to address).

The hotplugging capability is one of the features I was looking
for, actually.

I have done some more refactoring in this piece of code in
upcoming patches.

Will check, though, if I can do something with compute_fuses(),
even though, the other cslices are not really fused off (read
below).

> > +
> >  		rb_link_node(&engine->uabi_node, prev, p);
> >  		rb_insert_color(&engine->uabi_node, &i915->uabi_engines);
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
> 
> This doesn't look right to me.  A value of 0 means every cslice gets
> associated with CCS0.

Yes, that's what I'm trying to do. The behavior I'm looking for
is this one:

	 /*
	  ...
          * With 1 engine (ccs0):
          *   slice 0, 1, 2, 3: ccs0
          *
          * With 2 engines (ccs0, ccs1):
          *   slice 0, 2: ccs0
          *   slice 1, 3: ccs1
          *
          * With 4 engines (ccs0, ccs1, ccs2, ccs3):
          *   slice 0: ccs0
          *   slice 1: ccs1
          *   slice 2: ccs2
          *   slice 3: ccs3
	  ...
	  */

where the user can configure runtime the mode, making sure that
no client is connected to i915.

But, this needs to be written 

As we are now forcing mode '1', then all cslices are connected
with ccs0.

> On a DG2-G11 platform, that will flat out break
> compute since CCS0 is never present (G11 only has a single CCS and it's
> always the hardware's CCS1).  Even on a G10 or G12 this could also break
> things depending on the fusing of your card if the hardware CCS0 happens
> to be missing.
> 
> Also, the register says that we need a field value of 0x7 for each
> cslice that's fused off.  By passing 0, we're telling the CCS engine
> that it can use cslices that may not actually exist.

does it? Or do I need to write the id (0x0-0x3) of the user
engine? That's how the mode is calculated in this algorithm.

> > +}
> > +

[...]

> > diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> > index cf709f6c05ae..c148113770ea 100644
> > --- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> > +++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> > @@ -1605,6 +1605,8 @@
> >  #define   GEN12_VOLTAGE_MASK			REG_GENMASK(10, 0)
> >  #define   GEN12_CAGF_MASK			REG_GENMASK(19, 11)
> >  
> > +#define XEHP_CCS_MODE                          _MMIO(0x14804)
> 
> Nitpick:  this doesn't seem to be in the proper place and also breaks
> the file's convention of using tabs to move over to column 48 for the
> definition value.

This was something I actually forgot to fix. Thanks!

