Return-Path: <stable+bounces-128333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AF2A7C0B6
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 17:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD96B3BA26F
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9461B1F5854;
	Fri,  4 Apr 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itvg/SPX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23D61F5850
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781093; cv=none; b=jO95aAFkbZgXXyCntvWtN0W7QEZTkiuphvSXYVZkzc4kSlB79vuKupdYrq9V2RBGb1xFw+kEhCY9QYFZ7sQh79y60bZI6bRtCIAHSQZikgC4+87qjVHbu8Q1sGpE7PS8gjyt4TJAKutscIo31Jcx5rOs9jXG+QJIgpQ5e4TnwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781093; c=relaxed/simple;
	bh=Tb1jEOcQTNIusGfQkL6TipoSeEce8YDhpRh2S2YHyjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/5869UpnluVUbMGIs8QwmfSCb/ISqin7fJw9M71QWFbpiblOaodCWBSOxNH4Z5ej7JTdji5m8+CzNuUttYwao+kDduWnz2HJZWK93Ox18k4eXRpX53G/hHolQvV0RU0MiAScIWHT6OoLhXhsRJbnEIO+vKVlhb2IDUCbaxDoUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itvg/SPX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743781091; x=1775317091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Tb1jEOcQTNIusGfQkL6TipoSeEce8YDhpRh2S2YHyjc=;
  b=itvg/SPX22H3Ltrvr5DFR9f4F9wD0h/UCIElSdfKEkrF2srdIwI2ZFwQ
   K4EvzRdFsrEj+NMZ0eL75B51eQw9xWMam02+Dt+XjMToITFx3eGfKNgPq
   ms2Vg+HgVU/NhEqca+swwGyhCbC5GXxoFjxf2JdEyDD9uI3gEvqifuWws
   Vs6QUkaKIwgZuy6Z9NTiRXLxOnGmqDLXyv+em229o3PeQtUrhs6kbJKTO
   gtUlai3u2q4TxwZWBCf4JLTK6Cepy93XiVJHwpQp6c0NfP8G3Tetwse2p
   p01lD/0bTMVzxxJfBsW7/oHlGDUlyh8mELO6eTdN+3JtZsaAmdNfHp0tH
   Q==;
X-CSE-ConnectionGUID: WcUS/dAzREikcH6QGSmx1w==
X-CSE-MsgGUID: XNodOvbuR2+NqujjKqLzeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="55859192"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="55859192"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 08:38:11 -0700
X-CSE-ConnectionGUID: VIRe66fuSRyl6/F0yQ1NVw==
X-CSE-MsgGUID: q2bXvepnROivX4CsoL8HOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="132543218"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 04 Apr 2025 08:38:08 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 04 Apr 2025 18:38:06 +0300
Date: Fri, 4 Apr 2025 18:38:06 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
	mitulkumar.ajitkumar.golani@intel.com, arun.r.murthy@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/vrr: Add vrr.vsync_{start,end} in
 vrr_params_changed
Message-ID: <Z-_83ng-1KTFl_50@intel.com>
References: <20250404080540.2059511-1-ankit.k.nautiyal@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250404080540.2059511-1-ankit.k.nautiyal@intel.com>
X-Patchwork-Hint: comment

On Fri, Apr 04, 2025 at 01:35:40PM +0530, Ankit Nautiyal wrote:
> Add the missing vrr parameters in vrr_params_changed() helper.
> This ensures that changes in vrr.vsync_{start,end} trigger a call to
> appropriate helpers to update the VRR registers.
> 
> Fixes: e8cd188e91bb ("drm/i915/display: Compute vrr_vsync params")
> Cc: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
> Cc: Arun R Murthy <arun.r.murthy@intel.com>
> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.10+
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index c540e2cae1f0..ced8ba0f8d6d 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -969,7 +969,9 @@ static bool vrr_params_changed(const struct intel_crtc_state *old_crtc_state,
>  		old_crtc_state->vrr.vmin != new_crtc_state->vrr.vmin ||
>  		old_crtc_state->vrr.vmax != new_crtc_state->vrr.vmax ||
>  		old_crtc_state->vrr.guardband != new_crtc_state->vrr.guardband ||
> -		old_crtc_state->vrr.pipeline_full != new_crtc_state->vrr.pipeline_full;
> +		old_crtc_state->vrr.pipeline_full != new_crtc_state->vrr.pipeline_full ||
> +		old_crtc_state->vrr.vsync_start != new_crtc_state->vrr.vsync_start ||
> +		old_crtc_state->vrr.vsync_end != new_crtc_state->vrr.vsync_end;

These seem to yet another set of values that are potentially problematic
for the always_use_vrr_tg()==true case. I'm not sure how careful we
should be with this stuff...

And the whole encoder->update_pipe()/infoframe fastset stuff needs to
be rewritten to make sure the all the changes it does are either atomic
or happen on the correct side of the actual commit. Right now, for AS
SDP specifically, we enable/disable the infoframe potentially before
the actual commit, which I think is wrong at least for the disable case.

Also we still seem to be missing EMP_AS_SDP_TL completely.

Anyways, this patch isn't wrong at least so
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

>  }
>  
>  static bool cmrr_params_changed(const struct intel_crtc_state *old_crtc_state,
> -- 
> 2.45.2

-- 
Ville Syrjälä
Intel

