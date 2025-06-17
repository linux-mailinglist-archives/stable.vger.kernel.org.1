Return-Path: <stable+bounces-154119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE502ADD8BD
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0172C7D9D
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F15E2EA166;
	Tue, 17 Jun 2025 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3kessdQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BABA2E8E10
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178164; cv=none; b=dE5aNkV8WOgiOogBfZtaIUzsRG+3/rHmz12NbMqYxluS/D0+YZbWzvyAIgcMhVnOn535oKtCXcL80erWcUxHHoZhLmZmSmigK3IPo0SY1Fst8d81X62r8IDf+Rkcx3Aj2on5TPkSDbWwZJ9WNLn1f/NlfQCILW5k32kQmxRKZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178164; c=relaxed/simple;
	bh=FBAKlOOFPmiolYsah1Z4Ano13mnn3095yiYZR8JofY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRhn7tYtTZ47egHiGdFt4eO5jX9NndzgsecOs4jIIPUMhRqJAL9ErBMUM+S3FlcHcKF4EnBSNHdHnD4iKP8XvCG+Lrx+1kICj9Frof/7vLZRZWZJwZyCTNZleuYvqK3wG2l1QYvVtKgf9rSToBCkjUyzgzjdhUfYFP8lCjBnWag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3kessdQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750178162; x=1781714162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FBAKlOOFPmiolYsah1Z4Ano13mnn3095yiYZR8JofY8=;
  b=T3kessdQiEC7yw8KBjjHocrOWD1ZB065Od0iQccehI3DQ4JvoLk8FJGK
   XKrOCq2Fk3xyrnJhcVqgxUsRM3a8med+r/irj6d59zjZK6FFXar1scFai
   rW92Y+fw42QxD34P7Vxz0HVZCfOmjtCCBNTT/hEHzymO73s1ask2Ez0Iy
   V8kZooU0SWeqCGTFMPwFxnHO2m3PQacuHmF+1yhKnz/0ckwaVuOUGMVaC
   4gQZ9Dcmf3EtUTSvsLT8nxThxlGeaEu1X3UdhnmOHIiA+6owMGZfFfhce
   SLH6eLAYRJt6NgUCCfDAqNsRExMbjMGxxy6CT6HAo18SSx9t1P8KHIC9t
   Q==;
X-CSE-ConnectionGUID: Zc30sxMnTx2syz6JI8M2EA==
X-CSE-MsgGUID: CcYqk3FpREWFBs4Ml+wn8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52459748"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="52459748"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 09:36:01 -0700
X-CSE-ConnectionGUID: T34IydxeSHOmOFcldUg8AQ==
X-CSE-MsgGUID: 2E3G0PuDTNmH0IQIpYm4Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="154127432"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO stinkbox) ([10.245.245.184])
  by orviesa005.jf.intel.com with SMTP; 17 Jun 2025 09:35:58 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 17 Jun 2025 19:35:57 +0300
Date: Tue, 17 Jun 2025 19:35:57 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>
Cc: intel-xe@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/xe: move DPT l2 flush to a more sensible place
Message-ID: <aFGZbTtnwatIdUSR@intel.com>
References: <20250606104546.1996818-3-matthew.auld@intel.com>
 <20250606104546.1996818-4-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250606104546.1996818-4-matthew.auld@intel.com>
X-Patchwork-Hint: comment

On Fri, Jun 06, 2025 at 11:45:48AM +0100, Matthew Auld wrote:
> Only need the flush for DPT host updates here. Normal GGTT updates don't
> need special flush.
> 
> Fixes: 01570b446939 ("drm/xe/bmg: implement Wa_16023588340")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
>  drivers/gpu/drm/xe/display/xe_fb_pin.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
> index 461ecdfdb742..b16a6e3ff4b4 100644
> --- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
> +++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
> @@ -165,6 +165,9 @@ static int __xe_pin_fb_vma_dpt(const struct intel_framebuffer *fb,
>  
>  	vma->dpt = dpt;
>  	vma->node = dpt->ggtt_node[tile0->id];
> +
> +	/* Ensure DPT writes are flushed */
> +	xe_device_l2_flush(xe);
>  	return 0;
>  }
>  
> @@ -334,8 +337,6 @@ static struct i915_vma *__xe_pin_fb_vma(const struct intel_framebuffer *fb,
>  	if (ret)
>  		goto err_unpin;
>  
> -	/* Ensure DPT writes are flushed */
> -	xe_device_l2_flush(xe);
>  	return vma;
>  
>  err_unpin:
> -- 
> 2.49.0

-- 
Ville Syrjälä
Intel

