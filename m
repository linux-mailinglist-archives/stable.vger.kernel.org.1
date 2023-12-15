Return-Path: <stable+bounces-6809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111858146A3
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 12:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EE428423C
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 11:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB48200AD;
	Fri, 15 Dec 2023 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z066T/hi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AB734558
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702639075; x=1734175075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CABde8yKJe0Cl0xxR+1vVQSnkZhyPhpDfbH3OaB8c5U=;
  b=Z066T/hi0C7Y0EiS0f1/BpaW66AwNppwxBi1k5M8pywPABsAzI0EQ+Wl
   gdlvgu1HgYZtmRHHLoDjtM90jYukqcuwGReW+HtMjYTOdCmjJYSmu5FYG
   3JE00SJcDl3uuq/a/5bkWABC4T3fOZUy4tvLKHFIAVC8XRYKbdfllOHNY
   cL+r6szK0AQooiNHlSmkoc8Todq3KqFydABevLDWSsWKp/XkFHqZMwJdS
   qDtrBs9Pgfg12/eUwnFdTHhW52bz+2QfFuqzm0ht+J6dRRbOWvIAli5dJ
   G4eD8THBnhNouKgmtFmaTKP0OSHVWsNExelLiS3TFWqdcMBFSW7hdFqmh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="380258271"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="380258271"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 03:17:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="767948148"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="767948148"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 15 Dec 2023 03:17:46 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 15 Dec 2023 13:17:45 +0200
Date: Fri, 15 Dec 2023 13:17:45 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: "Lisovskiy, Stanislav" <stanislav.lisovskiy@intel.com>
Cc: intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Reject async flips with bigjoiner
Message-ID: <ZXw12T9rLTo0u2Mc@intel.com>
References: <20231211081134.2698-1-ville.syrjala@linux.intel.com>
 <ZXn5aJsa41Nv2tXA@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXn5aJsa41Nv2tXA@intel.com>
X-Patchwork-Hint: comment

On Wed, Dec 13, 2023 at 08:36:49PM +0200, Lisovskiy, Stanislav wrote:
> On Mon, Dec 11, 2023 at 10:11:34AM +0200, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > Currently async flips are busted when bigjoiner is in use.
> > As a short term fix simply reject async flips in that case.
> > 
> > Cc: stable@vger.kernel.org
> > Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9769
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_display.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> > index d955957b7d18..61053c19f4cc 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display.c
> > @@ -5926,6 +5926,17 @@ static int intel_async_flip_check_uapi(struct intel_atomic_state *state,
> >  		return -EINVAL;
> >  	}
> >  
> > +	/*
> > +	 * FIXME: Bigjoiner+async flip is busted currently.
> > +	 * Remove this check once the issues are fixed.
> > +	 */
> > +	if (new_crtc_state->bigjoiner_pipes) {
> > +		drm_dbg_kms(&i915->drm,
> > +			    "[CRTC:%d:%s] async flip disallowed with bigjoiner\n",
> > +			    crtc->base.base.id, crtc->base.name);
> > +		return -EINVAL;
> > +	}
> > +
> 
> Was recently wondering, whether should we add some kind of helper
> func for that check to look more readable, i.e instead of just
> checking if crtc_state->bigjoiner_pipes != 0, call smth like
> is_bigjoiner_used(new_crtc_state)..

I suppose we could have something like that. We do have something
along those lines for eg. port sync. The difference being that
port sync has a bit more state than a single bitmask, so it's
more useful there.

> 
> Reviewed-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
>

Thanks.

> >  	for_each_oldnew_intel_plane_in_state(state, plane, old_plane_state,
> >  					     new_plane_state, i) {
> >  		if (plane->pipe != crtc->pipe)
> > -- 
> > 2.41.0
> > 

-- 
Ville Syrjälä
Intel

