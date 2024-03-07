Return-Path: <stable+bounces-27122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 816BB875B39
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 00:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34101C20E51
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 23:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16EB3FB2F;
	Thu,  7 Mar 2024 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kd1ZB/h5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC2541A88
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709855534; cv=none; b=sqE2xOFpaRt8NJT/6TZ3jYH+T534iEXcT8Rqhf35KSewGXQD/RmLff+teaupelx+Z9Uwb6pF0FytIcuYfXtSDUB3qKC00CoYYP8CXrhcF2alV49Sn4IFl9lYvP3r+u6kM9LVprNQ91l6+oeDdohNw4wl11a+1tdLsBN1yX5M14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709855534; c=relaxed/simple;
	bh=g6KNEv97sL21XlZbjXrN4u3C1nl8XOMMFLdNGYOeSWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TU7yvzpraXAOurUn5rbZZ3RUegB2WHA6Y1tWECRv3gMLB6qUv39lHqQHHsH/l7rSrMqsNJmPSx9sZyW2qGetnvcrZiZi0j6IKre1vL7KZ6R1GklUKziNM6PC7kwAkbsS/4OSz+JjZqUIte5Ou87cmH+cR5rGHlXwt1Ezs5aCZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kd1ZB/h5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709855533; x=1741391533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g6KNEv97sL21XlZbjXrN4u3C1nl8XOMMFLdNGYOeSWc=;
  b=Kd1ZB/h5SrWLECs5xWp8P8xHCS7TYiSfYLxQ0ZY1wo4uOlP1UZ27S1MN
   lINwZlKnOaOMKgx9yVMl5Wz/jhvPBHBV3SafZlCJhwScC3zmAslmY9pxl
   a8EzrE9r7hZhTbY3Vv50Qpm3uLh+hJoyCwYIRz8uv23rJjuRPMdwTBy0I
   c/WFbP0AkJvk4jiE8MaxA7PTn1H9uGGyseb8vkF8fTFtgSS3YrIPaf2wk
   o1vQke5GY1Av6Ol3N+E5+GTdSwFFX5wwkp6pWDVee0z9WiZbyqbL3S/17
   scsSPWFveV3RPx/Eh8hhvPr474obzFCiNxqoN5L8rjcro95YSSlhB9Di7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15988874"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="15988874"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 15:52:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="10165628"
Received: from unknown (HELO intel.com) ([10.247.118.98])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 15:52:07 -0800
Date: Fri, 8 Mar 2024 00:52:01 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Matt Roper <matthew.d.roper@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	John Harrison <John.C.Harrison@intel.com>, stable@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH v4 3/3] drm/i915/gt: Enable only one CCS for compute
 workload
Message-ID: <ZepTIWnGe73Qv1_p@ashyti-mobl2.lan>
References: <20240306012247.246003-1-andi.shyti@linux.intel.com>
 <20240306012247.246003-4-andi.shyti@linux.intel.com>
 <20240307001454.GG718896@mdroper-desk1.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307001454.GG718896@mdroper-desk1.amr.corp.intel.com>

Hi Matt,

> > +static void intel_gt_apply_ccs_mode(struct intel_gt *gt)
> > +{
> > +	u32 mode;
> > +	int cslice;
> > +
> > +	if (!IS_DG2(gt->i915))
> > +		return;
> > +
> > +	/* Set '0' as a default CCS id to all the cslices */
> > +	mode = 0;
> > +
> > +	for (cslice = 0; cslice < hweight32(CCS_MASK(gt)); cslice++)
> > +		/* Write 0x7 if no CCS context dispatches to this cslice */
> > +		if (!(CCS_MASK(gt) & BIT(cslice)))
> > +			mode |= XEHP_CCS_MODE_CSLICE(cslice,
> > +						     XEHP_CCS_MODE_CSLICE_MASK);
> > +
> > +	intel_uncore_write(gt->uncore, XEHP_CCS_MODE, mode);
> 
> This is still going to hook all available cslices up to hardware engine
> ccs0.  But what you actually want is to hook them all up to what
> userspace sees as CCS0 (i.e., the first CCS engine that wasn't fused
> off).  Hardware's engine numbering and userspace's numbering aren't the
> same.

Yes, correct... we had so many discussions and I forgot about it :-)

> Also, if you have a part that only has hardware ccs1/cslice1 for
> example, you're not going to set cslices 2 & 3 to 0x7 properly.

Good point also here, the XEHP_CCS_MODE register is indeed
generic to all platforms.

> So probably what you want is something like this (untested):
> 
> static void intel_gt_apply_ccs_mode(struct intel_gt *gt)
> {
>         u32 mode = 0;
>         int first_ccs = __ffs(CCS_MASK(gt));
> 
>         /*
>          * Re-assign every present cslice to the first available CCS
>          * engine; mark unavailable cslices as unused.
>          */
>         for (int cslice = 0; cslice < 4; cslice++) {
>                 if (CCS_MASK(gt) & BIT(cslice))
>                         mode |= XEHP_CCS_MODE_CSLICE(cslice, first_ccs);
>                 else
>                         mode |= XEHP_CCS_MODE_CSLICE(cslice,
>                                                      XEHP_CCS_MODE_CSLICE_MASK);
>         }
> 
>         intel_uncore_write(gt->uncore, XEHP_CCS_MODE, mode);
> }
> 
> > +}
> > +
> >  int intel_gt_init_hw(struct intel_gt *gt)
> >  {
> >  	struct drm_i915_private *i915 = gt->i915;
> > @@ -195,6 +215,9 @@ int intel_gt_init_hw(struct intel_gt *gt)
> >  
> >  	intel_gt_init_swizzling(gt);
> >  
> > +	/* Configure CCS mode */
> > +	intel_gt_apply_ccs_mode(gt);
> 
> This is only setting this once during init.  The value gets lost on
> every RCS/CCS reset, so we need to make sure it gets reapplied when
> necessary.  That means you either need to add this to the GuC regset, or
> you need to implement the programming as a "fake workaround" so that the
> workaround framework will take care of the re-application for you.

OK, I'll hook everything up in the ccs_engine_wa_init().

Thanks,
Andi

