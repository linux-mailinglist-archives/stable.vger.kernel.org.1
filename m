Return-Path: <stable+bounces-92142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7677A9C4128
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 15:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C751C218F7
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 14:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D929D19F10A;
	Mon, 11 Nov 2024 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OW+KAPjd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492714EC55
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336073; cv=none; b=A8d840n6x5OU1wWfy1eZS72b2ctgFXqyVZWcu+AW333K1q4dwdl7awMvMe/o36eU13SSa1WMF8qrzPC5oDluXbbFKTYGP5Zil0XWabPAtaX/eYfLJ3Y6R6yTMGMzxIra+pjK9FQIUxuc/pGqwApc57psWIf8avecuZu5+qELFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336073; c=relaxed/simple;
	bh=QC6ViF4IkpA7VCOBhetwyFyQO8qDfwObi+1D1VM2vtw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qEnU78aU/pK/vBcKj++vCrKCoh/0Is/v2lm4iU0fgpGyAGiAceuLeFAG0fvpbsi8dRReDVHDc+4C/WAucsKBNoSMgf4U6xaKYKMH55MbddGeQnlLAk/FrQs+UpvvFBnnFoHy9mXbiBZpKvEZstXUCzGluZ1AxiOGC1VZW28IJr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OW+KAPjd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731336071; x=1762872071;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=QC6ViF4IkpA7VCOBhetwyFyQO8qDfwObi+1D1VM2vtw=;
  b=OW+KAPjdc0wbEvPy2OVsvya7QQCoE+Fx3cH0StTfv50ZoQtHH6mzOcr7
   WOTwHCth3txaY0ZVOtXkrDIKizEuR54Ac/vBi0YL0CMO3d0RYSZEz+z8c
   aGFbvkTIyjvQjwdKGwfP4sXSIVb3SmtGAf2Izg+K4qjFepi5aqePFpGwg
   O/+z152T1xD65VVXhFoo7mvq4Pv8YffPfI+2xfQLr8P92OGaRsBTvMz0/
   onA2QiT2CrE9+SuJIw0TyWuC10pAJ+TbefPOCGmD0y2vFlXNAFeqzbSwO
   DWoCzMiDx45CruAC1k/cRK1g78MWExJALFiAjBDdQ2lofVr2icINeFUr/
   w==;
X-CSE-ConnectionGUID: ZR4VBar9RxWXIBH7MK7HMg==
X-CSE-MsgGUID: UTHwnGKUSAurKs1ccMf7wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="41772020"
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="41772020"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 06:41:10 -0800
X-CSE-ConnectionGUID: qzaX9EvWQue5xFFr0a2tfw==
X-CSE-MsgGUID: +0jsyEwVRhq2JDaq6Z2XUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="91725322"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.75])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 06:41:07 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Huacai Chen <chenhuacai@loongson.cn>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Huacai Chen <chenhuacai@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Huacai Chen <chenhuacai@loongson.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm: Remove redundant statement in
 drm_crtc_helper_set_mode()
In-Reply-To: <20241111132149.1113736-1-chenhuacai@loongson.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241111132149.1113736-1-chenhuacai@loongson.cn>
Date: Mon, 11 Nov 2024 16:41:04 +0200
Message-ID: <87o72lde9r.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 11 Nov 2024, Huacai Chen <chenhuacai@loongson.cn> wrote:
> Commit dbbfaf5f2641a ("drm: Remove bridge support from legacy helpers")
> removes the drm_bridge_mode_fixup() call in drm_crtc_helper_set_mode(),
> which makes the subsequent "encoder_funcs = encoder->helper_private" be
> redundant, so remove it.
>
> Cc: stable@vger.kernel.org
> Fixes: dbbfaf5f2641a ("drm: Remove bridge support from legacy helpers")

IMO not necessary because nothing's broken, it's just redundant.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/gpu/drm/drm_crtc_helper.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
> index 0955f1c385dd..39497493f74c 100644
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c
> @@ -334,7 +334,6 @@ bool drm_crtc_helper_set_mode(struct drm_crtc *crtc,
>  		if (!encoder_funcs)
>  			continue;
>  
> -		encoder_funcs = encoder->helper_private;
>  		if (encoder_funcs->mode_fixup) {
>  			if (!(ret = encoder_funcs->mode_fixup(encoder, mode,
>  							      adjusted_mode))) {

-- 
Jani Nikula, Intel

