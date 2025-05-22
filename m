Return-Path: <stable+bounces-146033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E31AC04A6
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 08:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB904A6E3D
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 06:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE11221728;
	Thu, 22 May 2025 06:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9IMWJwY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862541A5BA8
	for <stable@vger.kernel.org>; Thu, 22 May 2025 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895707; cv=none; b=jgKHcNAMtD45uXWDnrEfYwS+wy3o1LrLP1pMdXvm9jsDCGaZ0w/RL/I3ouoggKtWkdSHmqBoVJFA/NwN3V/qjPr1FBIk/Rm2ghFmX4MMCoO1uRCgmOIzpqOFJpif5E1n4rhD+0wAEj9B9GaN8+BrORzn99YR4SpwhODYn+MqoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895707; c=relaxed/simple;
	bh=m4A3YbTzI4E54+bg9JPYO1LNUV5FBZ7b2BLMvLTu2GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pesYsGzDvECcX0ACL6O5CNgGf5bS7sLJpcZlKJWx1t8bolVHYzJ52ddC/9MhUQs4b8LqOB5iV4kBH1lMmVa8c0igjogtFfFAeDhz7pA1sEfdBRxPvmyc12pIFspDvp9/k9GmFYAzYhaaGYhrSPbdq5Y0FcWFlCfIYCf65gCaJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9IMWJwY; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747895706; x=1779431706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m4A3YbTzI4E54+bg9JPYO1LNUV5FBZ7b2BLMvLTu2GA=;
  b=l9IMWJwYsAdgCf/4hEZzxwIobIeursiFvd6dFKDkqad0KJnkxZkGzYmg
   mRNw1xwxmdSkB9rsROAIFl6jj+dNObPq3yr8SclGVEypmLzxSMqmyc00y
   VpES54Wr0KsR6CnhJTm82UKKZE2q1S28SRnyFOb0H8MPW9Gvp4DuT1q7Y
   6ceIwUpGF/XZW9HDKiiZeBx1LFD84NXVI2Pr5G5wsy8pP3NMYQu1F2/t+
   QrfWtWKzYz182M5PGGWVZ1HuudqZEOmAe4MZOcoFXQaS74TIShM4oqJ6Y
   zQ4VbU6vnjAhdZvdreyTCmrq9Ct82uYwq2kQZKIAnMAq51syLzKCU7Tx4
   Q==;
X-CSE-ConnectionGUID: vcqXWiWFTm+KJ9O6QhIryw==
X-CSE-MsgGUID: mK+HCbyoTL+IBtB59kb+ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49890702"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="49890702"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 23:35:05 -0700
X-CSE-ConnectionGUID: 71PcmtqlRkiV13QNC9RAXg==
X-CSE-MsgGUID: DPSoW1c4T6Oi3GvKxbw6NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="140328697"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.85])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 23:35:02 -0700
Date: Thu, 22 May 2025 08:35:00 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Tvrtko Ursulin <tursulin@ursulin.net>, stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>,
	Thomas =?iso-8859-15?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v2 1/2] drm/i915/gem: Allow EXEC_CAPTURE on recoverable
 contexts on DG1
Message-ID: <aC7FlELcVQsHuRL_@ashyti-mobl2.lan>
References: <20250411144313.11660-1-ville.syrjala@linux.intel.com>
 <20250411144313.11660-2-ville.syrjala@linux.intel.com>
 <174789510455.12498.1410930072009074388@jlahtine-mobl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174789510455.12498.1410930072009074388@jlahtine-mobl>

Hi Joonas,

On Thu, May 22, 2025 at 09:25:04AM +0300, Joonas Lahtinen wrote:
> (+ Tvrkto)
> 
> Quoting Ville Syrjala (2025-04-11 17:43:12)
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > The intel-media-driver is currently broken on DG1 because
> > it uses EXEC_CAPTURE with recovarable contexts. Relax the
> > check to allow that.
> > 
> > I've also submitted a fix for the intel-media-driver:
> > https://github.com/intel/media-driver/pull/1920
> > 
> > Cc: stable@vger.kernel.org
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Testcase: igt/gem_exec_capture/capture-invisible
> > Fixes: 71b1669ea9bd ("drm/i915/uapi: tweak error capture on recoverable contexts")
> > Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> > index ca7e9216934a..ea9d5063ce78 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> > @@ -2013,7 +2013,7 @@ static int eb_capture_stage(struct i915_execbuffer *eb)
> >                         continue;
> >  
> >                 if (i915_gem_context_is_recoverable(eb->gem_context) &&
> > -                   (IS_DGFX(eb->i915) || GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 0)))
> > +                   GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 10))
> 
> The IS_DGFX check was there because the error capture is expected to be
> broken on anything with VRAM.
> 
> If we have already submitted an userspace fix to remove that flag, that
> would be the right way to go.

Oh! We need to add a comment there, though, because in the
future I expect someone else might decide to send the same patch.

Andi

