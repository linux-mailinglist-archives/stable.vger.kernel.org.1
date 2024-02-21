Return-Path: <stable+bounces-21764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D76285CC9C
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 01:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC701C21861
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 00:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE5A382;
	Wed, 21 Feb 2024 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWRVh+o3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A06323A6
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708474494; cv=none; b=SQ4U0xS31oUweXgN5zmCDBcZleBM7LaZqFQWmQTr4GJDhWfmMbTFY14MdjtSxiEMvidG+T/PXyzRHj20sx5r+14Y4feic2HcuQLsfcmwZRxsoRvwREXRu+Ok0DODyBbS2u9X9eBiGRye+jjvsYQApdQYML1FFWjy+Sv2dgbTwU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708474494; c=relaxed/simple;
	bh=p2+aMGpVWQdd72/xp9GUR35skeNEMEQfwDisn1NrPsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayuo7/lz7K6OXlZnLZ6dZ4aq9Rjh0ilx9SxJ5J4pUjcQ0uqq9kh5qHCgTL/HkRE3+aC/9BvOoRtKEi5qriV31IrgHtYNcuo7aYXvspry/+XZukO0G0xj7AxVWyHDiRRr7NBA0eLwGUA/Z/wf9dmId+2zyC9ENeMtEGUdp8l56Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWRVh+o3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708474493; x=1740010493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p2+aMGpVWQdd72/xp9GUR35skeNEMEQfwDisn1NrPsU=;
  b=QWRVh+o3kty7zbSkh7SWwijg5dSDJCieQ9PZBSuysmS8TfPHuAIYFbP3
   zmZcWZNgP4ioFbYlgmHAx04+cNTMDz2/kPW1IcqkJba4Qk8v/4L+v/6ST
   YC2E9AVdE3HOGLKlHMe9jDLQuVxbhmqeuZtiUKpa7QNtbgid1Kgf5QROl
   o9OxvsQUYJBXDW2LoCnRV8wi4Uts20CQFzNVKvs3miJ5qVGWIT12f8MV5
   cSYCnFtU7S/M7T4hCl2CJi1UMbU0/KRS84VyxC1sjVxBnDQo4YtGONKQz
   vHgu+3PdxMq5ZdqVtU4cLO0X1gn0IMF6WJKRfSUwgRPKdtyb6VEbmVJyP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6386893"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="6386893"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 16:14:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4927738"
Received: from okeles-mobl.ger.corp.intel.com (HELO intel.com) ([10.246.32.195])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 16:14:49 -0800
Date: Wed, 21 Feb 2024 01:14:47 +0100
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
Message-ID: <ZdVAd3NxUNBZofts@ashyti-mobl2.lan>
References: <20240220143526.259109-1-andi.shyti@linux.intel.com>
 <20240220143526.259109-3-andi.shyti@linux.intel.com>
 <af007641-9705-4259-b29c-3cb78f67fc64@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af007641-9705-4259-b29c-3cb78f67fc64@linux.intel.com>

Hi Tvrtko,

On Tue, Feb 20, 2024 at 02:48:31PM +0000, Tvrtko Ursulin wrote:
> On 20/02/2024 14:35, Andi Shyti wrote:
> > Enable only one CCS engine by default with all the compute sices
> 
> slices

Thanks!

> > diff --git a/drivers/gpu/drm/i915/gt/intel_engine_user.c b/drivers/gpu/drm/i915/gt/intel_engine_user.c
> > index 833987015b8b..7041acc77810 100644
> > --- a/drivers/gpu/drm/i915/gt/intel_engine_user.c
> > +++ b/drivers/gpu/drm/i915/gt/intel_engine_user.c
> > @@ -243,6 +243,15 @@ void intel_engines_driver_register(struct drm_i915_private *i915)
> >   		if (engine->uabi_class == I915_NO_UABI_CLASS)
> >   			continue;
> > +		/*
> > +		 * Do not list and do not count CCS engines other than the first
> > +		 */
> > +		if (engine->uabi_class == I915_ENGINE_CLASS_COMPUTE &&
> > +		    engine->uabi_instance > 0) {
> > +			i915->engine_uabi_class_count[engine->uabi_class]--;
> > +			continue;
> > +		}
> 
> It's a bit ugly to decrement after increment, instead of somehow
> restructuring the loop to satisfy both cases more elegantly.

yes, agree, indeed I had a hard time here to accept this change
myself.

But moving the check above where the counter was incremented it
would have been much uglier.

This check looks ugly everywhere you place it :-)

In any case, I'm working on a patch that is splitting this
function in two parts and there is some refactoring happening
here (for the first initialization and the dynamic update).

Please let me know if it's OK with you or you want me to fix it
in this run.

> And I wonder if
> internally (in dmesg when engine name is logged) we don't end up with ccs0
> ccs0 ccs0 ccs0.. for all instances.

I don't see this. Even in sysfs we see only one ccs. Where is it?

> > +
> >   		rb_link_node(&engine->uabi_node, prev, p);
> >   		rb_insert_color(&engine->uabi_node, &i915->uabi_engines);

[...]

> > diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i915_query.c
> > index 3baa2f54a86e..d5a5143971f5 100644
> > --- a/drivers/gpu/drm/i915/i915_query.c
> > +++ b/drivers/gpu/drm/i915/i915_query.c
> > @@ -124,6 +124,7 @@ static int query_geometry_subslices(struct drm_i915_private *i915,
> >   	return fill_topology_info(sseu, query_item, sseu->geometry_subslice_mask);
> >   }
> > +
> 
> Zap please.

yes... yes... I noticed it after sending the patch :-)

Thanks,
Andi

