Return-Path: <stable+bounces-65964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4259F94B206
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 23:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C599A282B33
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 21:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282C71487EB;
	Wed,  7 Aug 2024 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFxu8Hb1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3907F364BC;
	Wed,  7 Aug 2024 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065719; cv=none; b=HokbIkEsjZZFRkW0IRjERTSlPdBgfGkwUnP6sVnzXetO2noScDWtvnkOG+mJc+BtjzfW6hIwvqKN/rrs8baoBs6xxPnGbfnI3GstRtBFW4O5up2C2C3sLZpAESEbbmgzUS7rBgMSQiCKixVmC2wmXmfM46n+30XYUGkL4g5M4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065719; c=relaxed/simple;
	bh=Dq1+AV92i31+4oeKeLoCAinDWxNJUx71g/nSYf1wiqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7o+bkazJXWj55YoZElSltSUvpjMIcOc1fnVdY0LBWgyQzw4L2SvJHAox5TyC/37SDZOGyqsUSBDZ9o7nsgYp3+uf6Y8u/8UK4/uyA0IkRP3voCj2gtICJCoygKIdDBydYN3SQfB1MpdK2++IxtI7tC1wXoSxaQUud9RGxsitS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFxu8Hb1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723065718; x=1754601718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dq1+AV92i31+4oeKeLoCAinDWxNJUx71g/nSYf1wiqo=;
  b=NFxu8Hb1+5p5jj3bz79LSDNIYAErrsCii5xwH2q/qpq7KoSTgutXMOiW
   fMNE+RH47lmGwaJp3waOE/Xm4OGHSdFP8sJu27koxrwpnxk3uUnG/hVPM
   ouMEtHHLzPsjidjOv2lHrwBwmzSNY+4RG2AMjBRpLrBdwLp/4fhNc85Th
   yWiau2NLe0DR5JxbOjpEs1Yawe5LIhfQL36S7NE9xPpCQWWlNurUprNDW
   Yc2yIuNfboD4g9eTU9BWMp3KJw7nfrQJkJbfMdN0j0SJU0GwdYhvS+XY4
   gW8wLQ8WKXZkV59pLCJbtbskQrZ5/eQOunt2T11LupetC48jETVpSSUwJ
   Q==;
X-CSE-ConnectionGUID: c5BoWpXmTaWdefejmtAHEg==
X-CSE-MsgGUID: 5CcD4M7QTJqIpYyeV6wWJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21285331"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="21285331"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 14:21:57 -0700
X-CSE-ConnectionGUID: 5nV0nHCrQNqcrggwMFCChg==
X-CSE-MsgGUID: SnpUb/X8QU65IyoY1zD1rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="56946448"
Received: from dneilan-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.245.42])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 14:21:52 -0700
Date: Wed, 7 Aug 2024 22:21:48 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
	airlied@gmail.com, daniel@ffwll.ch, ville.syrjala@linux.intel.com,
	stanislav.lisovskiy@intel.com, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Fix NULL ptr deref in
 intel_async_flip_check_uapi()
Message-ID: <ZrPlbBGFAGLVfGf3@ashyti-mobl2.lan>
References: <20240806092249.2407555-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806092249.2407555-1-make24@iscas.ac.cn>

Hi Ma,

> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index c2c388212e2e..9dd7b5985d57 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -6115,7 +6115,7 @@ static int intel_async_flip_check_uapi(struct intel_atomic_state *state,
>  		return -EINVAL;
>  	}
>  
> -	if (intel_crtc_needs_modeset(new_crtc_state)) {
> +	if (new_crtc_state && intel_crtc_needs_modeset(new_crtc_state)) {

new_crtc_state is used also earlier. If it was NULL you wouldn't
have reached this state.

Have you experienced a null pointer dereference or is it some
code analyzer that reported this? Can you explain how
intel_atomic_get_new_crtc_state() can return NULL?

For now this is nacked.

Thanks,
Andi

