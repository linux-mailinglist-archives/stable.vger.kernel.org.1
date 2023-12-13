Return-Path: <stable+bounces-6632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47542811CB5
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 19:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74DF2B20D13
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 18:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD4931750;
	Wed, 13 Dec 2023 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqH6YUi6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BFCAB
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 10:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702492621; x=1734028621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GtY5NToT1aZ689lTsYVcVAP5k6TCBOw31Wh/PaQh3Ow=;
  b=lqH6YUi6Tc3HUCKLWDAZCq1yluvZhATPtudjgLjS03PDAQIQV+a0S4Bx
   wseRWacH7ahlC0wboyAQONezqSjwg8ONCLo+W2U6t0he5sIeUFTMQ+w0H
   YLXDRJmJJ85dk+LtYw2d++MHfYSN2veR0l7jOyGi7K6mDTM5eb36KMiu5
   2VumP0X45aZ9h6pEexDSAI9JmpgIIqd9wHFixRRG6qG3QYTq+CKiXNvcg
   iBIS/hYsDwyR6q84jpkH5TGuVfZiG3lxn2Zkx7Nepf/EQlmYK1cQqjtn4
   MXh9uTvssyxFsI95I0ob/cJIbQbhh30ObwSEIf4XoNc7sB8efkplZZ8uT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1845832"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="1845832"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:36:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774047192"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="774047192"
Received: from unknown (HELO intel.com) ([10.237.72.65])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:36:56 -0800
Date: Wed, 13 Dec 2023 20:36:49 +0200
From: "Lisovskiy, Stanislav" <stanislav.lisovskiy@intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Reject async flips with bigjoiner
Message-ID: <ZXn5aJsa41Nv2tXA@intel.com>
References: <20231211081134.2698-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231211081134.2698-1-ville.syrjala@linux.intel.com>

On Mon, Dec 11, 2023 at 10:11:34AM +0200, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Currently async flips are busted when bigjoiner is in use.
> As a short term fix simply reject async flips in that case.
> 
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9769
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index d955957b7d18..61053c19f4cc 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -5926,6 +5926,17 @@ static int intel_async_flip_check_uapi(struct intel_atomic_state *state,
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * FIXME: Bigjoiner+async flip is busted currently.
> +	 * Remove this check once the issues are fixed.
> +	 */
> +	if (new_crtc_state->bigjoiner_pipes) {
> +		drm_dbg_kms(&i915->drm,
> +			    "[CRTC:%d:%s] async flip disallowed with bigjoiner\n",
> +			    crtc->base.base.id, crtc->base.name);
> +		return -EINVAL;
> +	}
> +

Was recently wondering, whether should we add some kind of helper
func for that check to look more readable, i.e instead of just
checking if crtc_state->bigjoiner_pipes != 0, call smth like
is_bigjoiner_used(new_crtc_state)..

Reviewed-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>

>  	for_each_oldnew_intel_plane_in_state(state, plane, old_plane_state,
>  					     new_plane_state, i) {
>  		if (plane->pipe != crtc->pipe)
> -- 
> 2.41.0
> 

