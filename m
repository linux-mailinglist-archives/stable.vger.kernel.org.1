Return-Path: <stable+bounces-21829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D21685D6AC
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 12:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22601F227B9
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 11:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7CB3FE25;
	Wed, 21 Feb 2024 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDc1/12l"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032B3EA94
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514381; cv=none; b=SsGE7c/w0Gv2wdRSxBKG5vy80zoDTRVBXldcdRN7MwJGkOfdzr60esMDWtwXh1HR/SiS1JRWx9MCJyC3+viVf2cH1IKFTPwWDxD8FbAp4xi+2A8FKLps9H28oxP0643sdiakHMJUCmzkvURkB75Fobr/51zCScH5MbSk/VuuLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514381; c=relaxed/simple;
	bh=1MPSwiBgeJuseJVQcUWyd0NCoEJbjVJDNEBxFzzf9c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwjRdCy1imurfDXC/Zex5UrcSAeC8HgeNWSoQzQ2ITZpsFmxkzI0+o7aXmPRRCd5uMtVOAZza/K06g0Bbt81RSCemynUFMk8HqXwW4cKzP7+kMapEOlZgyK4wDTbjrPCqRvHmjiCmfDtbaKUw2zsk4ROdyXRDXhS3EUZlDn+S8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDc1/12l; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708514379; x=1740050379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1MPSwiBgeJuseJVQcUWyd0NCoEJbjVJDNEBxFzzf9c4=;
  b=fDc1/12lUw/PzipDK6rlRDQJ052NE7kvxlmOGh6pnvWQfYMF4qKUyb7C
   /NPIOQLZS3GrkyvqPYPc3PDvrPy2ql31TvNC7sHOTshXus8HR4wqIMy+t
   mETZnDw4n+w2S/uscmoZhokk9NzdCoLqCbKcenV5HoU0sPagpqjDjXsGy
   qSOcADvb2HS2vQFhXnqfSzCz3KKHUp4mDyPYvmjR1O887xy0Cc9pqpw14
   1QlKuzNFCfp9R/no87KQdwyXMfzhz4lELg0wciPcqP0PfFjs2t6u9/drX
   gWzYC+6bYwHbIH3FCi/H3CVHxrtesnHFA3v5zcUGc6Beu+hot21z3WRm2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6482718"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="6482718"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 03:19:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5119015"
Received: from okeles-mobl.ger.corp.intel.com (HELO intel.com) ([10.246.32.195])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 03:19:36 -0800
Date: Wed, 21 Feb 2024 12:19:33 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@intel.com>, stable@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v2 2/2] drm/i915/gt: Enable only one CCS for compute
 workload
Message-ID: <ZdXcRat8OcTeVozx@ashyti-mobl2.lan>
References: <20240220143526.259109-1-andi.shyti@linux.intel.com>
 <20240220143526.259109-3-andi.shyti@linux.intel.com>
 <af007641-9705-4259-b29c-3cb78f67fc64@linux.intel.com>
 <ZdVAd3NxUNBZofts@ashyti-mobl2.lan>
 <a0f66a4d-12f9-4852-a1bb-a6d27538b436@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f66a4d-12f9-4852-a1bb-a6d27538b436@linux.intel.com>

Hi Tvrtko,

On Wed, Feb 21, 2024 at 08:19:34AM +0000, Tvrtko Ursulin wrote:
> On 21/02/2024 00:14, Andi Shyti wrote:
> > On Tue, Feb 20, 2024 at 02:48:31PM +0000, Tvrtko Ursulin wrote:
> > > On 20/02/2024 14:35, Andi Shyti wrote:
> > > > Enable only one CCS engine by default with all the compute sices
> > > 
> > > slices
> > 
> > Thanks!
> > 
> > > > diff --git a/drivers/gpu/drm/i915/gt/intel_engine_user.c b/drivers/gpu/drm/i915/gt/intel_engine_user.c
> > > > index 833987015b8b..7041acc77810 100644
> > > > --- a/drivers/gpu/drm/i915/gt/intel_engine_user.c
> > > > +++ b/drivers/gpu/drm/i915/gt/intel_engine_user.c
> > > > @@ -243,6 +243,15 @@ void intel_engines_driver_register(struct drm_i915_private *i915)
> > > >    		if (engine->uabi_class == I915_NO_UABI_CLASS)
> > > >    			continue;
> > > > +		/*
> > > > +		 * Do not list and do not count CCS engines other than the first
> > > > +		 */
> > > > +		if (engine->uabi_class == I915_ENGINE_CLASS_COMPUTE &&
> > > > +		    engine->uabi_instance > 0) {
> > > > +			i915->engine_uabi_class_count[engine->uabi_class]--;
> > > > +			continue;
> > > > +		}
> > > 
> > > It's a bit ugly to decrement after increment, instead of somehow
> > > restructuring the loop to satisfy both cases more elegantly.
> > 
> > yes, agree, indeed I had a hard time here to accept this change
> > myself.
> > 
> > But moving the check above where the counter was incremented it
> > would have been much uglier.
> > 
> > This check looks ugly everywhere you place it :-)
> 
> One idea would be to introduce a separate local counter array for
> name_instance, so not use i915->engine_uabi_class_count[]. First one
> increments for every engine, second only for the exposed ones. That way
> feels wouldn't be too ugly.

Ah... you mean that whenever we change the CCS mode, we update
the indexes of the exposed engines from list of the real engines.
Will try.

My approach was to regenerate the list everytime the CCS mode was
changed, but your suggestion looks a bit simplier.

> > In any case, I'm working on a patch that is splitting this
> > function in two parts and there is some refactoring happening
> > here (for the first initialization and the dynamic update).
> > 
> > Please let me know if it's OK with you or you want me to fix it
> > in this run.
> > 
> > > And I wonder if
> > > internally (in dmesg when engine name is logged) we don't end up with ccs0
> > > ccs0 ccs0 ccs0.. for all instances.
> > 
> > I don't see this. Even in sysfs we see only one ccs. Where is it?
> 
> When you run this patch on something with two or more ccs-es, the "renamed
> ccs... to ccs.." debug logs do not all log the new name as ccs0?

it shouldn't, because the name_instance is anyway incremented
normally... anyway, I will test it.

Thanks a lot!
Andi

