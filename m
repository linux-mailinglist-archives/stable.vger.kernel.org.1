Return-Path: <stable+bounces-118298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1DFA3C3A8
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 16:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B753A949C
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786CD1F4617;
	Wed, 19 Feb 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXq4j3T9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE0E1F460A;
	Wed, 19 Feb 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978804; cv=none; b=BwBdXXlOU2cZO6jftyl2lUBpJ4rmZ45F/aFKxxWvnDQiCCIv3UfIH4ErCy9nR3qR4ZIT6NE6onmyNUZW50dxPrEfBngxnL6BMTu9/n8HelSLUtWgBQC/KNZDWWaOqgnZOPDdpSIgLANub2aiHZ8w9maiPkn8lu4Xhkm+kjSIVC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978804; c=relaxed/simple;
	bh=CK0AZ7Lpkp/QfXcb02pW83lUn9FRAJI72YGbMp2sIIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t0P5IPHSVjRFUiSx9wQrGCozX+lB41KRIQvmahLNqBOf7W5/3Ar884phQhAEftHy1vk+mSU9YGo3D1tlPcVJ9SkhbjE9HeDEZ5A1Y2ORI6d8tIHvmqD88hyhOnYboHs/xIWmT1Bk56t/tEaoqTsvBhHMlXF1uzM934TlVuhSuJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXq4j3T9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739978802; x=1771514802;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=CK0AZ7Lpkp/QfXcb02pW83lUn9FRAJI72YGbMp2sIIQ=;
  b=AXq4j3T94k7pJ6pSkhc2RfwAq5ddOCYvXk2Jiqf0mNMQbWzHoBlNL40f
   8GxbBie1+uNDGHPl7WirikjA+XhiaXHHCh9NMGQ00WXiq44C9vb/w3qvR
   ZrftBVmNCj5SZSw0WTpbRmif0XlPrmiYFD0pN8ydzi4GhUKx0i4YsWum9
   4vQBtlHGBp0Rg4cEj4Bf3U8q7VCthvTN+aywMalbrIeh3bsdH2ihIOg/9
   NPnhTe32Aw4zskT1rNYurEi+xgxNIqBmGSI0H+W09hVN2jjLK0+p8de4C
   Q8Pjd0UrYDvdo/JJlusfF12ksZkaMqql7H8R2xFM9/HHAXVgEQ+W8h27C
   Q==;
X-CSE-ConnectionGUID: no/oUX6cR0aAX3uj5ofL2w==
X-CSE-MsgGUID: xiunvIH1Q4uAI9JVbj/Etg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44490311"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="44490311"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 07:26:42 -0800
X-CSE-ConnectionGUID: hc0YFeZyTfenPRKrf4pPAg==
X-CSE-MsgGUID: yV91Q3S3TiOssDXVkhcBOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114941437"
Received: from dprybysh-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.160])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 07:26:35 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Haoxiang Li <haoxiang_li2024@163.com>, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, gustavo.sousa@intel.com
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Haoxiang Li
 <haoxiang_li2024@163.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/display: Add check for
 alloc_ordered_workqueue() and alloc_workqueue()
In-Reply-To: <20250219130800.2638016-1-haoxiang_li2024@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250219130800.2638016-1-haoxiang_li2024@163.com>
Date: Wed, 19 Feb 2025 17:26:28 +0200
Message-ID: <87wmdmlzvf.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 19 Feb 2025, Haoxiang Li <haoxiang_li2024@163.com> wrote:
> Add check for the return value of alloc_ordered_workqueue()
> and alloc_workqueue() to catch potential exception.
>
> Fixes: 40053823baad ("drm/i915/display: move modeset probe/remove functions to intel_display_driver.c")

Not really. That's just code movement.

> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display_driver.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
> index 50ec0c3c7588..dfe5b779aefd 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_driver.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
> @@ -245,6 +245,11 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
>  						WQ_UNBOUND, WQ_UNBOUND_MAX_ACTIVE);
>  	display->wq.cleanup = alloc_workqueue("i915_cleanup", WQ_HIGHPRI, 0);
>  
> +	if (!display->wq.modeset || !display->wq.flip || !display->wq.cleanup) {
> +		ret = -ENOMEM;
> +		goto cleanup_vga_client_pw_domain_dmc;
> +	}
> +

Yes, we should check these, but if some of them succeed and some fail,
we'll never destroy the workqueues whose allocation succeeded.

BR,
Jani.


>  	intel_mode_config_init(display);
>  
>  	ret = intel_cdclk_init(display);

-- 
Jani Nikula, Intel

