Return-Path: <stable+bounces-132698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23F9A894B1
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 09:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDFF3AADE5
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 07:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45961F0E47;
	Tue, 15 Apr 2025 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCHtd7iK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028FA2556E
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701433; cv=none; b=RJSGM39iEx/2azXsqAN3SN6NeVO89/phec2sTLCCf95QNgTDc1kitcryUJPQFMW+HpCj0WWgHUEXDDIv3Wjtggm7qZVoHTGvrs3rrA80Vazou5ykkebmodjWDFkmsMrOArV8OgkT+MOG3xaleB4ArGt5KVt+ZT+AoZJCn6wBvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701433; c=relaxed/simple;
	bh=SfqplkzMKHmvAml6eQ8xHN2tknxcnoULWNX6BN16ZbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JxI1pd3Ac+wp9v1jMBOYoFrzzNN2BejKIirOGVoHo1pSICLYZFtcf2/Tx1XFKtjs+nBjTR1YK5wg5aY0a4XguxCDnW58OQ+3UBDh/QGfhUdpDgcvYe5LR3RIzW9JRyJfDAyseSlJZZ3XITcSqGx1YDYSMGkWiuGyqftdCt9m7mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCHtd7iK; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744701431; x=1776237431;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SfqplkzMKHmvAml6eQ8xHN2tknxcnoULWNX6BN16ZbE=;
  b=dCHtd7iK8m5+nmTy75n3WhKi5xd5nC5nqMeZ0IaqeBDGYHC40GUz3HF8
   8Lm9r96DNpItR8n6zTTej9i3M8YOh1R0JiO/Iu81y+ioJHw9XrUmlbR0P
   I9TXEiWKwzcXZfe8C5VD4vwdRfAvOzlX6/EPGS82rwzr2coblWnX28IGf
   75uc/Oy4qY6SoJxTvNdfZw/Y9usr4BtIbCJ6XR/5dTk05KSO9/9Fwk4Zc
   Yk2YLE1YCgaZzPEGUsxwXQlQmKMoiLi0rqucDBCfivnbZk0JUM2EZ0kiE
   00fBpEDZ/Nkd2ZAu17tqfajLunlXxtQoPgH/y6/I0NroUIczaj5P4ovdN
   w==;
X-CSE-ConnectionGUID: KgVtEnDhTrCARBoNa7fwQA==
X-CSE-MsgGUID: w2q9UBYlS1KOSL8z3c7Odw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="45428706"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="45428706"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 00:17:10 -0700
X-CSE-ConnectionGUID: T8Acfdg3SrOmB5Ed2zeN5w==
X-CSE-MsgGUID: RGlFWzX+T5KB9x6RrIw8rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130363869"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.249])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 00:17:07 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: suraj.kandpal@intel.com, stable@vger.kernel.org, ankit.k.nautiyal@intel.com
Subject: Re: [PATCH 1/2] drm/i915/display: Add macro for checking 3 DSC engines
In-Reply-To: <20250414085701.2802374-1-ankit.k.nautiyal@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250414024256.2782702-2-ankit.k.nautiyal@intel.com>
 <20250414085701.2802374-1-ankit.k.nautiyal@intel.com>
Date: Tue, 15 Apr 2025 10:17:04 +0300
Message-ID: <87y0w1sxlb.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 14 Apr 2025, Ankit Nautiyal <ankit.k.nautiyal@intel.com> wrote:
> 3 DSC engines per pipe is currently supported only for BMG.
> Add a macro to check whether a platform supports 3 DSC engines per pipe.

Nitpick, feels like a macro returning the number of DSC engines per pipe
would be more generic. Like, would you also add HAS_DSC_2ENGINES() and
HAS_DSC_4ENGINES() if you needed to know that? But I guess we can go
with what you have for the immediate fix.

However, adding the tiniest macro and its only user in separate patches,
for something that needs to be backported to stable, seems like erring
on the side of splitting up patches too much.

BR,
Jani.


>
> v2:Fix Typo in macro argument. (Suraj).
> Added fixes tag.
>
> Bspec: 50175
> Fixes: be7f5fcdf4a0 ("drm/i915/dp: Enable 3 DSC engines for 12 slices")
> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> Cc: <stable@vger.kernel.org> # v6.14+
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display_device.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.h b/drivers/gpu/drm/i915/display/intel_display_device.h
> index 368b0d3417c2..87c666792c0d 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.h
> @@ -163,6 +163,7 @@ struct intel_display_platforms {
>  #define HAS_DP_MST(__display)		(DISPLAY_INFO(__display)->has_dp_mst)
>  #define HAS_DSB(__display)		(DISPLAY_INFO(__display)->has_dsb)
>  #define HAS_DSC(__display)		(DISPLAY_RUNTIME_INFO(__display)->has_dsc)
> +#define HAS_DSC_3ENGINES(__display)	(DISPLAY_VERx100(__display) == 1401 && HAS_DSC(__display))
>  #define HAS_DSC_MST(__display)		(DISPLAY_VER(__display) >= 12 && HAS_DSC(__display))
>  #define HAS_FBC(__display)		(DISPLAY_RUNTIME_INFO(__display)->fbc_mask != 0)
>  #define HAS_FBC_DIRTY_RECT(__display)	(DISPLAY_VER(__display) >= 30)

-- 
Jani Nikula, Intel

