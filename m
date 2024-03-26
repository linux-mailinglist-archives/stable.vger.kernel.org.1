Return-Path: <stable+bounces-32373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB72B88CC2A
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 19:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67422C8207
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 18:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2C213C9AF;
	Tue, 26 Mar 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M33zc06L"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D3713C813
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478569; cv=none; b=CztQrmpEoSrJOjtBXPMpZ+8wmWLhLT5CLhdrpSMwA+h7pqNFOrWDEI2umY2A4iidimuwNWprXa34PLbQVG9FBl9POIX/Ut8GbA1CE6JmcEchM3rwgIYrVy85m2FqdYUL/7J+0g+ZtHBAb855q6IMZYhTnRlbha0Gzjq/FT4S8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478569; c=relaxed/simple;
	bh=8UClEmQS7ztOTKNag8nuBcrd41vmVhHLEKAGZGLJX3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxrLckz0sGZ679O5G0loBHTSwHWrKUic2242juqudrO+mzzt8vO21257k4khljgdl7Amj9EOwW+kLicvsx/NTE5+U2Z56UWoA4wzoJ2DeJr/IWegbR7QsndnW9CkWAvyWohWcLzt5JIdluS0xatTjL+QUayUelGK7An5NChCWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M33zc06L; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711478568; x=1743014568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8UClEmQS7ztOTKNag8nuBcrd41vmVhHLEKAGZGLJX3E=;
  b=M33zc06L6DKETvJBgrs7RtLdc7bKDxYRtEY6zrxhUigPpXQOPIwwTVIb
   /BoxINpn0q4+EfYsXHTjW692YcTbQwaEQW3rMPSN3pgT0lOCsU/4aj2bd
   mJexkDXIs9cTBPrvfzlaGkG44P65r1TmF740SmSKsW2Uo92SdwUpkTTpb
   uTRewk7Ht2y+pw5nw27lHaem+jxyQH0DJsG1HYYkZ664UgmCD/ckUXs2a
   zFyMXTurXtCwXpHcGmO/PqUpBnTS1VKezEQNmWPamvOce6l9y0mz80T85
   86H7U7wcYHBBNwTyiIGfARa8rb5VdvBd8Ij9fDWVrwFzIXrMe0AGNxpS0
   A==;
X-CSE-ConnectionGUID: 8IRPbLEtRsGlbNUI2CbS3w==
X-CSE-MsgGUID: SHRI8IqKQTaOtv9E/bl8Xw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17278360"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17278360"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20532894"
Received: from unknown (HELO intel.com) ([10.247.118.210])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:42:41 -0700
Date: Tue, 26 Mar 2024 19:42:34 +0100
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
Subject: Re: [PATCH v6 2/3] drm/i915/gt: Do not generate the command streamer
 for all the CCS
Message-ID: <ZgMXGlfsGSOhbC0b@ashyti-mobl2.lan>
References: <20240313201955.95716-1-andi.shyti@linux.intel.com>
 <20240313201955.95716-3-andi.shyti@linux.intel.com>
 <20240326160310.GC718896@mdroper-desk1.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326160310.GC718896@mdroper-desk1.amr.corp.intel.com>

Hi Matt,

On Tue, Mar 26, 2024 at 09:03:10AM -0700, Matt Roper wrote:
> On Wed, Mar 13, 2024 at 09:19:50PM +0100, Andi Shyti wrote:
> > +			/*
> > +			 * Do not create the command streamer for CCS slices
> > +			 * beyond the first. All the workload submitted to the
> > +			 * first engine will be shared among all the slices.
> > +			 *
> > +			 * Once the user will be allowed to customize the CCS
> > +			 * mode, then this check needs to be removed.
> > +			 */
> > +			if (IS_DG2(i915) &&
> > +			    class == COMPUTE_CLASS &&
> > +			    ccs_instance++)
> > +				continue;
> 
> Wouldn't it be more intuitive to drop the non-lowest CCS engines in
> init_engine_mask() since that's the function that's dedicated to
> building the list of engines we'll use?  Then we don't need to kill the
> assertion farther down either.

Because we don't check the result of init_engine_mask() while
creating the engine's structure. We check it only after and
indeed I removed the drm_WARN_ON() check.

I think the whole process of creating the engine's structure in
the intel_engines_init_mmio() can be simplified, but this goes
beyong the scope of the series.

Or am I missing something?

Thanks,
Andi

