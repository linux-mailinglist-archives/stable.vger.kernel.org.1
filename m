Return-Path: <stable+bounces-33053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4200D88F8B4
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 08:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21E8B22180
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 07:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8574652F62;
	Thu, 28 Mar 2024 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4BVs9SU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C437D51C55
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610997; cv=none; b=jQ1l0/Iyq6xLCrG7Idi1ObA2LgUequIukEi/E2GqnhAX1f0X4acCyjFtY3cdoKeZC2vVfPwyjyeQbFcuNi2NibBqt55+W8WMPXbXUKUY3XctiCN9NnkpLuyrmx+DmWUvA1DP18LHU3jDR2bUhBPWqiDOOHfV5IScRVsPebPZQzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610997; c=relaxed/simple;
	bh=77IiDGiqWNm2GwozOTYuAavXa//plkIspLecSN3lveg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rroEMG5IpeJQPuk40VTRlvmkvvzcqFZfyC7L1rcBV2l8/T9tgIoecORkJPOx2aQTpYt8PKOmWwBz+fPJjD2ico61YuEfAYXDbUD3SeEctJ9RM3uzAFx1q0+1AuPJ+VgibZRnLoxiSlQcyL6GF6ad2eISOvytVEorEpioDjKKlR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4BVs9SU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711610996; x=1743146996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=77IiDGiqWNm2GwozOTYuAavXa//plkIspLecSN3lveg=;
  b=G4BVs9SUssdxomMZjpqjZYYthQcQOtKNvyIAiesrFG8ayEUoGgjyCcaI
   Lu6z2aqawwxXQ0ftKlS9CLYzFroMJ/e0Fs/MPp+ED9b41ZSa3C7Ev+L5X
   l63J56e4h7cSIkCXO+ipuJkr6UtohhLEr1y5zyXldmp9aOURmrNcnCXem
   5R10zb0wChHkbRT6ram9OxGXpvanlWwVYBKhItOjNEyvlplE0BZe97pHI
   5aNRwQvdjCptgyBd7+Dw8LbETC2svKD0vLe/FKEtbK5Lrf7K47V0hU+3S
   uNd+AV2N6f6zYx0BDzrnKOG2mpMtFMpWP6Sj4ifRL9S7zOW62ZAzkw6Y/
   g==;
X-CSE-ConnectionGUID: QW6j3eJDQTO2Jqt+mTJGLw==
X-CSE-MsgGUID: /UevfQCRS8CPxcVfxLU3tw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10531614"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="10531614"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="16628525"
Received: from unknown (HELO intel.com) ([10.247.118.221])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:29:48 -0700
Date: Thu, 28 Mar 2024 08:29:42 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Matt Roper <matthew.d.roper@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	John Harrison <John.C.Harrison@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Michal Mrozek <michal.mrozek@intel.com>, stable@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v7 2/3] drm/i915/gt: Do not generate the command streamer
 for all the CCS
Message-ID: <ZgUcZpUn5S5Vmgqu@ashyti-mobl2.lan>
References: <20240327155622.538140-1-andi.shyti@linux.intel.com>
 <20240327155622.538140-3-andi.shyti@linux.intel.com>
 <20240327220858.GG718896@mdroper-desk1.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327220858.GG718896@mdroper-desk1.amr.corp.intel.com>

Hi Matt,

> > +	/*
> > +	 * Do not create the command streamer for CCS slices beyond the first.
> > +	 * All the workload submitted to the first engine will be shared among
> > +	 * all the slices.
> > +	 *
> > +	 * Once the user will be allowed to customize the CCS mode, then this
> > +	 * check needs to be removed.
> > +	 */
> > +	if (IS_DG2(gt->i915)) {
> > +		intel_engine_mask_t first_ccs = BIT((CCS0 + __ffs(CCS_MASK(gt))));
> > +		intel_engine_mask_t all_ccs = CCS_MASK(gt) << CCS0;
> > +
> > +		info->engine_mask &= ~(all_ccs &= ~first_ccs);
> 
> Shouldn't the second "&=" just be an "&" since there's no need to modify
> the all_ccs variable that never gets used again?

yes, that's a leftover from me trying different ways of removing
all the non first CCS engines.

> In fact since this is DG2-specific, it seems like it might be more
> intuitive to just write the whole thing more directly as
> 
>         if (IS_DG2(gt->i915)) {
>                 int first_ccs = __ffs(CCS_MASK(gt));
> 
>                 info->engine_mask &= ~GENMASK(CCS3, CCS0);
>                 info->engine_mask |= BIT(_CCS(first_ccs));
>         }

yes, looks a bit simpler. Will use this way.

> But up to you; if you just want to remove the unnecessary "=" that's
> fine too.  Either way,
> 
>         Reviewed-by: Matt Roper <matthew.d.roper@intel.com>

Thanks!

Andi

