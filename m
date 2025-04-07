Return-Path: <stable+bounces-128576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E602CA7E4A2
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 17:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876D53AA002
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D551FA267;
	Mon,  7 Apr 2025 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJAsLIQI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D71F76D3;
	Mon,  7 Apr 2025 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039194; cv=none; b=qRG+qM4ppp08/iTV4n7xAYu/yUIJi6wNVVs/WV2ShQLiWqc8KWiLwzaECBbVzApj4O9FK5Le9cc+M36173IHqFRdBJuuX74jUHdR25cemyGxhZC/6/nHPODmtUVsWddNGK/Lv60JmBeNV+3E6bwLgZf3M48Gyan4pYTXtdz/p8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039194; c=relaxed/simple;
	bh=Uv8tsfdGNY/eBUeej0wD8UqHXmEaL3zCsQGg2SVHWOE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MyR2xsMUeOxrvvOFNh3F8hAiW8Ai+0d7kxORAaI4T+uXqiQrNVN6A9S1ta1DJV2er8LPkJYR4d2u0UKF+qxqXIggjYzqvCm9RgU21mAAl1XGUM7iDwd041SiEAgzJr5QIPNQBl2aTVw6iSCIk0/sutHVv2Y1XBJyYT0XZO8wEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJAsLIQI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744039192; x=1775575192;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Uv8tsfdGNY/eBUeej0wD8UqHXmEaL3zCsQGg2SVHWOE=;
  b=KJAsLIQIedyRSFWJgOEzFFZTvIpXfJ6+7jXDtopGvTO95yfA5uTJla+y
   Q3nFnPbWhhZHTplV4Flx4hUkBXBK8yKVrhEp7P7PEje7pXjhS5saOqITP
   wXgYPHyi4efKrpkIdZZFwuUYAwp17zftTP20tZkHumQ2ewJsXO3wg0KyU
   PW03vBeJSVsaDdE+j5WkCmV3D+3CqSkjGRW/YxN6OYE/Uz8zwZJiQiQKI
   Hp0GlETXex3Q7qzwW1di+h9lstSbqxSGCOjmustnEiFm3vQHWWE654p2d
   +IgqgKXm5LrjnXqUcY6t12tC1RHEPpnrQTVJAyH7qvjPDlpIB5zoNv+sW
   w==;
X-CSE-ConnectionGUID: plyvz2FpSqqKvWhC/7HgFA==
X-CSE-MsgGUID: RRXk32zOTtuC60zYkpLCBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49283581"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="49283581"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 08:19:51 -0700
X-CSE-ConnectionGUID: f0+4JNQCQrGunD0Q19cLUw==
X-CSE-MsgGUID: Hkl9TmMHRUGBXL5vAfxwiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="151179868"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 08:19:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 7 Apr 2025 18:19:46 +0300 (EEST)
To: Mario Limonciello <superm1@kernel.org>
cc: mario.limonciello@amd.com, Shyam-sundar.S-k@amd.com, 
    Hans de Goede <hdegoede@redhat.com>, Yijun Shen <Yijun.Shen@dell.com>, 
    stable@vger.kernel.org, Yijun Shen <Yijun_Shen@Dell.com>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: amd: pmf: Fix STT limits
In-Reply-To: <20250407133645.783434-1-superm1@kernel.org>
Message-ID: <60e43790-bbeb-29b3-dcf1-7311439e15cc@linux.intel.com>
References: <20250407133645.783434-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 7 Apr 2025, Mario Limonciello wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> On some platforms it has been observed that STT limits are not being applied
> properly causing poor performance as power limits are set too low.
> 
> STT limits that are sent to the platform are supposed to be in Q8.8
> format.  Convert them before sending.
> 
> Reported-by: Yijun Shen <Yijun.Shen@dell.com>
> Fixes: 7c45534afa443 ("platform/x86/amd/pmf: Add support for PMF Policy Binary")
> Cc: stable@vger.kernel.org
> Tested-By: Yijun Shen <Yijun_Shen@Dell.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Handle cases for auto-mode, cnqf, and sps as well
> ---
>  drivers/platform/x86/amd/pmf/auto-mode.c | 4 ++--
>  drivers/platform/x86/amd/pmf/cnqf.c      | 4 ++--
>  drivers/platform/x86/amd/pmf/sps.c       | 8 ++++----
>  drivers/platform/x86/amd/pmf/tee-if.c    | 4 ++--
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/auto-mode.c b/drivers/platform/x86/amd/pmf/auto-mode.c
> index 02ff68be10d01..df37f8a84a007 100644
> --- a/drivers/platform/x86/amd/pmf/auto-mode.c
> +++ b/drivers/platform/x86/amd/pmf/auto-mode.c
> @@ -120,9 +120,9 @@ static void amd_pmf_set_automode(struct amd_pmf_dev *dev, int idx,
>  	amd_pmf_send_cmd(dev, SET_SPPT_APU_ONLY, false, pwr_ctrl->sppt_apu_only, NULL);
>  	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false, pwr_ctrl->stt_min, NULL);
>  	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
> -			 pwr_ctrl->stt_skin_temp[STT_TEMP_APU], NULL);
> +			 pwr_ctrl->stt_skin_temp[STT_TEMP_APU] << 8, NULL);

Hi Mario,

Could we add some helper on constructing the fixed-point number from the 
integer part as this magic shifting makes the intent somewhat harder to 
follow just by reading the code itself?

I hoped that include/linux/ would have had something for this but it seems 
generic fixed-point helpers are almost non-existing except for very 
specific use cases such as averages so maybe add a helper only for this 
driver for now as this will be routed through fixes branch so doing random 
things i include/linux/ might not be preferrable and would require larger 
review audience.

What I mean for general helpers is that it would be nice to have something 
like DECLARE_FIXEDPOINT() similar to DECLARE_EWMA() macro (and maybe a 
signed variant too) which creates a few helper functions for the given 
name prefix. It seems there's plenty of code which would benefit from such 
helpers and would avoid the need to comment the fixed-point operations 
(not to speak of how many of such ops likely lack the comment). So at 
least keep that in mind for naming the helpers so the conversion to
a generic helper could be done smoothly.

-- 
 i.

>  	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
> -			 pwr_ctrl->stt_skin_temp[STT_TEMP_HS2], NULL);
> +			 pwr_ctrl->stt_skin_temp[STT_TEMP_HS2] << 8, NULL);
>  
>  	if (is_apmf_func_supported(dev, APMF_FUNC_SET_FAN_IDX))
>  		apmf_update_fan_idx(dev, config_store.mode_set[idx].fan_control.manual,
> diff --git a/drivers/platform/x86/amd/pmf/cnqf.c b/drivers/platform/x86/amd/pmf/cnqf.c
> index bc8899e15c914..6a5ecc05961d9 100644
> --- a/drivers/platform/x86/amd/pmf/cnqf.c
> +++ b/drivers/platform/x86/amd/pmf/cnqf.c
> @@ -81,9 +81,9 @@ static int amd_pmf_set_cnqf(struct amd_pmf_dev *dev, int src, int idx,
>  	amd_pmf_send_cmd(dev, SET_SPPT, false, pc->sppt, NULL);
>  	amd_pmf_send_cmd(dev, SET_SPPT_APU_ONLY, false, pc->sppt_apu_only, NULL);
>  	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false, pc->stt_min, NULL);
> -	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, pc->stt_skin_temp[STT_TEMP_APU],
> +	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, pc->stt_skin_temp[STT_TEMP_APU] << 8,
>  			 NULL);
> -	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, pc->stt_skin_temp[STT_TEMP_HS2],
> +	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, pc->stt_skin_temp[STT_TEMP_HS2] << 8,
>  			 NULL);
>  
>  	if (is_apmf_func_supported(dev, APMF_FUNC_SET_FAN_IDX))
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index d3083383f11fb..ec10db1bfa5ec 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -198,9 +198,9 @@ static void amd_pmf_update_slider_v2(struct amd_pmf_dev *dev, int idx)
>  	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false,
>  			 apts_config_store.val[idx].stt_min_limit, NULL);
>  	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
> -			 apts_config_store.val[idx].stt_skin_temp_limit_apu, NULL);
> +			 apts_config_store.val[idx].stt_skin_temp_limit_apu << 8, NULL);
>  	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
> -			 apts_config_store.val[idx].stt_skin_temp_limit_hs2, NULL);
> +			 apts_config_store.val[idx].stt_skin_temp_limit_hs2 << 8, NULL);
>  }
>  
>  void amd_pmf_update_slider(struct amd_pmf_dev *dev, bool op, int idx,
> @@ -217,9 +217,9 @@ void amd_pmf_update_slider(struct amd_pmf_dev *dev, bool op, int idx,
>  		amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false,
>  				 config_store.prop[src][idx].stt_min, NULL);
>  		amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
> -				 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_APU], NULL);
> +				 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_APU] << 8, NULL);
>  		amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
> -				 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_HS2], NULL);
> +				 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_HS2] << 8, NULL);
>  	} else if (op == SLIDER_OP_GET) {
>  		amd_pmf_send_cmd(dev, GET_SPL, true, ARG_NONE, &table->prop[src][idx].spl);
>  		amd_pmf_send_cmd(dev, GET_FPPT, true, ARG_NONE, &table->prop[src][idx].fppt);
> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
> index d6a871f0d8ff2..7096923107929 100644
> --- a/drivers/platform/x86/amd/pmf/tee-if.c
> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
> @@ -142,7 +142,7 @@ static void amd_pmf_apply_policies(struct amd_pmf_dev *dev, struct ta_pmf_enact_
>  
>  		case PMF_POLICY_STT_SKINTEMP_APU:
>  			if (dev->prev_data->stt_skintemp_apu != val) {
> -				amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, val, NULL);
> +				amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, val << 8, NULL);
>  				dev_dbg(dev->dev, "update STT_SKINTEMP_APU: %u\n", val);
>  				dev->prev_data->stt_skintemp_apu = val;
>  			}
> @@ -150,7 +150,7 @@ static void amd_pmf_apply_policies(struct amd_pmf_dev *dev, struct ta_pmf_enact_
>  
>  		case PMF_POLICY_STT_SKINTEMP_HS2:
>  			if (dev->prev_data->stt_skintemp_hs2 != val) {
> -				amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, val, NULL);
> +				amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, val << 8, NULL);
>  				dev_dbg(dev->dev, "update STT_SKINTEMP_HS2: %u\n", val);
>  				dev->prev_data->stt_skintemp_hs2 = val;
>  			}
> 

