Return-Path: <stable+bounces-62766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D3A94118E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A1C1F21BB5
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D463C19DFA5;
	Tue, 30 Jul 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/00lp7N"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A86C19AD8D;
	Tue, 30 Jul 2024 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341312; cv=none; b=lOdhkamUtwlxVspYrA70hufhESvOkztkxCJXLJzBRED3tvMMktQ80BtLfzaZGXMecFJ6cnibjoJ1DMXXVr6LhPiuCJvdXZ94bMZCQM72QRsCofwn+6BfoIGlSfzu0YHuByICrI08VoBD9LD8ZU4D6IofuDVTpwdeFUn0xjDpXzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341312; c=relaxed/simple;
	bh=/sfpWWW8V+Cpbz4W8KtLY2uaeQ4/J756IydOKw4ia+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ImmO1UdN03g0lk6BWQNgr9mCI7kDLGKxqHerDIrTxvbIxjQw9qBFupwfmjFOV/SjnzoPQTDLo3K1G9veWbFcSIHkAtzTAYZhRviLGMJjykGcdqJaxFSPZAnvAx3/JjpEQjY9P6X7ZIH+LQOyDr/7gYh4zF+VZ4lumAXlqjpsKBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/00lp7N; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722341310; x=1753877310;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/sfpWWW8V+Cpbz4W8KtLY2uaeQ4/J756IydOKw4ia+g=;
  b=J/00lp7NvZu/0uJXn+nZ8hRO2t4Xd+6V2O9kG16mUqiiL2/vGdB6ImNd
   66GSWSPi1BHAe46N4EYEgq49vBlIrHXuDyR5tTv0M0NW1hw0Ey+kL7SXg
   WMok3qaqG/25pp0jTcEuhWmyGTaINKZeN7FzPwtvA28D4QVJRNbc/OBcN
   rpEFwqHWs0XqWqzZ3VU5Ciw9+St3eO4RpaHLscmDp48ljJbF1o1LdH3xL
   ahRYW+3fn/BrDPzf/qcPcU3+em09SGUFxHVcCyQoHjpaIcSkTjXPqwdLK
   IAEW8wFv8C7WP+0wQtu0N0cOG3EFKSNJhPb37lIQhrGYQZyjKs2rYrPRj
   g==;
X-CSE-ConnectionGUID: RCaDpU81SU+FxEaFBpHYIQ==
X-CSE-MsgGUID: Lw25jFzATcysyXQFnrNI3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="30779268"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="30779268"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 05:08:29 -0700
X-CSE-ConnectionGUID: AasE62mgQD6Ed+q30Inkxw==
X-CSE-MsgGUID: p4irrj0DT/aQcMbXVuDN+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="84965012"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.34])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 05:08:25 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915: Fix possible int overflow in
 skl_ddi_calculate_wrpll()
In-Reply-To: <20240729174035.25727-1-n.zhandarovich@fintech.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240729174035.25727-1-n.zhandarovich@fintech.ru>
Date: Tue, 30 Jul 2024 15:08:21 +0300
Message-ID: <875xsnxetm.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 29 Jul 2024, Nikita Zhandarovich <n.zhandarovich@fintech.ru> wrote:
> On the off chance that clock value ends up being too high (by means
> of skl_ddi_calculate_wrpll() having benn called with big enough
> value of crtc_state->port_clock * 1000), one possible consequence
> may be that the result will not be able to fit into signed int.
>
> Fix this issue by moving conversion of clock parameter from kHz to Hz
> into the body of skl_ddi_calculate_wrpll(), as well as casting the
> same parameter to u64 type while calculating the value for AFE clock.
> This both mitigates the overflow problem and avoids possible erroneous
> integer promotion mishaps.
>
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
>
> Fixes: fe70b262e781 ("drm/i915: Move a bunch of stuff into rodata from the stack")

I don't think that's right. The code was only shuffled around at that
point. I think the bug's been there since the code was added in commit
82d354370189 ("drm/i915/skl: Implementation of SKL DPLL programming").

Fixed while applying to drm-intel-next, thanks for the patch.

BR,
Jani.



> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
> v2: instead of double casting of 'clock' with (u64)(u32), convert
> 'clock' to Hz inside skl_ddi_calculate_wrpll() and cast it only
> to u64 to mitigate the issue. Per Jani's <jani.nikula@linux.intel.com>
> helpful suggestion made here:
> https://lore.kernel.org/all/87ed7gzhin.fsf@intel.com/
> Also, change commit description accordingly.
>
> v1: https://lore.kernel.org/all/20240724184911.12250-1-n.zhandarovich@fintech.ru/
>
>  drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> index 90998b037349..292d163036b1 100644
> --- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> +++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> @@ -1658,7 +1658,7 @@ static void skl_wrpll_params_populate(struct skl_wrpll_params *params,
>  }
>  
>  static int
> -skl_ddi_calculate_wrpll(int clock /* in Hz */,
> +skl_ddi_calculate_wrpll(int clock,
>  			int ref_clock,
>  			struct skl_wrpll_params *wrpll_params)
>  {
> @@ -1683,7 +1683,7 @@ skl_ddi_calculate_wrpll(int clock /* in Hz */,
>  	};
>  	unsigned int dco, d, i;
>  	unsigned int p0, p1, p2;
> -	u64 afe_clock = clock * 5; /* AFE Clock is 5x Pixel clock */
> +	u64 afe_clock = (u64)clock * 1000 * 5; /* AFE Clock is 5x Pixel clock, in Hz */
>  
>  	for (d = 0; d < ARRAY_SIZE(dividers); d++) {
>  		for (dco = 0; dco < ARRAY_SIZE(dco_central_freq); dco++) {
> @@ -1808,7 +1808,7 @@ static int skl_ddi_hdmi_pll_dividers(struct intel_crtc_state *crtc_state)
>  	struct skl_wrpll_params wrpll_params = {};
>  	int ret;
>  
> -	ret = skl_ddi_calculate_wrpll(crtc_state->port_clock * 1000,
> +	ret = skl_ddi_calculate_wrpll(crtc_state->port_clock,
>  				      i915->display.dpll.ref_clks.nssc, &wrpll_params);
>  	if (ret)
>  		return ret;

-- 
Jani Nikula, Intel

