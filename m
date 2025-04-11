Return-Path: <stable+bounces-132221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EAAA85933
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 12:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35649A2FB7
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 10:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73518296141;
	Fri, 11 Apr 2025 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nR7ed3OE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF72238C0D;
	Fri, 11 Apr 2025 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365790; cv=none; b=lkZ3j3h+zNbb07H1j9hd8UGx8AgDBH7cYLP5D4L9oQMEf0ClpZrsfh+KEKXr38/L0YfmK1Kc5O62PF1nINLB9vX56R2fe4cR6aw/f04Cq0kL1c0gg+vF6ddhjSV0r63M348YxP27Kb/tBQzTsJMxqzuuhV9kpRd/R2fVz4yvJ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365790; c=relaxed/simple;
	bh=J6OeqQNRvvSrkRJ6nriZOb1mLK+7fVoElxaexjCvEC8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BxzfQ3TZkTb9ATsy/HXmF21ajp3WKSBAO+XYexoW8yhQjV8pYrFe+/EU1zR/bVARVKQFnd0Kw2lhXmPUaXDnJRITVfyaJWyE8qRCNmm+rqqXoBuk3F1TfW42LCuw7WOcXhly/AxvOVk0mbFFsnupYMf30oWptDwWpdpE6MiOy1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nR7ed3OE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744365789; x=1775901789;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=J6OeqQNRvvSrkRJ6nriZOb1mLK+7fVoElxaexjCvEC8=;
  b=nR7ed3OEDyEQmaqePVYjsh1lQHspgmmg6mvIze5XccVXvV3fKoMFeHxg
   hJSlJTADlMd5rL0bYzX1IeOXgrKkxrM9AzJQeWIqhrfpYkBfhcrDZ5t0p
   ZuFv395OrwIW20BGecxyfzn0z10kIVQFms/CWMCf1YqcQQRJBrfKYKwdJ
   QzOAt6qhk6upkwUI4KD4YAYzHHbIQqP9AEDVnM4QTBW0n3WsySlnXDFVD
   +hBHsKwmflZpMQwzU5yAxwKTyzJdh43Yvi+oEwLINW2SmC6liFtAsgNE+
   vKPcRt6bEryVK9NFJFj/JqWgByjB8kqyCbpvaIL+FBMPtsaAj/RAocjPT
   g==;
X-CSE-ConnectionGUID: RxJ6uXOGTOyHwIb93QheNA==
X-CSE-MsgGUID: 1BiuMBf1QZaGC/7I0HDDag==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="68399662"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="68399662"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 03:03:08 -0700
X-CSE-ConnectionGUID: Gho7LCKDQmeVk9R7lfB3zQ==
X-CSE-MsgGUID: Wof1yPShQgO9Ew0s0jPpUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="134136088"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 03:03:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Apr 2025 13:03:01 +0300 (EEST)
To: Mario Limonciello <superm1@kernel.org>
cc: mario.limonciello@amd.com, Shyam-sundar.S-k@amd.com, 
    Hans de Goede <hdegoede@redhat.com>, Yijun Shen <Yijun.Shen@dell.com>, 
    stable@vger.kernel.org, Yijun Shen <Yijun_Shen@Dell.com>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86: amd: pmf: Fix STT limits
In-Reply-To: <20250407181915.1482450-1-superm1@kernel.org>
Message-ID: <8bab41c3-2c66-9dd4-fe9c-af7a250928bc@linux.intel.com>
References: <20250407181915.1482450-1-superm1@kernel.org>
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
> On some platforms it has been observed that STT limits are not being
> applied properly causing poor performance as power limits are set too low.
> 
> STT limits that are sent to the platform are supposed to be in Q8.8
> format.  Convert them before sending.
> 
> Reported-by: Yijun Shen <Yijun.Shen@dell.com>
> Fixes: 7c45534afa443 ("platform/x86/amd/pmf: Add support for PMF Policy Binary")
> Cc: stable@vger.kernel.org
> Tested-by: Yijun Shen <Yijun_Shen@Dell.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3:
>  * Add a helper with a generic name (so it can be easily be moved to library
>    code in the future)

I've applied this to review-ilpo-fixes branch. In the end, I decided to 
rename from ..._from_integer() to _fromint() which matches some drm 
usage in context of fixed point integers and is shorter.

-- 
 i.

> ---
>  drivers/platform/x86/amd/pmf/auto-mode.c |  4 ++--
>  drivers/platform/x86/amd/pmf/cnqf.c      |  8 ++++----
>  drivers/platform/x86/amd/pmf/core.c      | 14 ++++++++++++++
>  drivers/platform/x86/amd/pmf/pmf.h       |  1 +
>  drivers/platform/x86/amd/pmf/sps.c       | 12 ++++++++----
>  drivers/platform/x86/amd/pmf/tee-if.c    |  6 ++++--
>  6 files changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/auto-mode.c b/drivers/platform/x86/amd/pmf/auto-mode.c
> index 02ff68be10d01..1400ac70c52d1 100644
> --- a/drivers/platform/x86/amd/pmf/auto-mode.c
> +++ b/drivers/platform/x86/amd/pmf/auto-mode.c
> @@ -120,9 +120,9 @@ static void amd_pmf_set_automode(struct amd_pmf_dev *dev, int idx,
>  	amd_pmf_send_cmd(dev, SET_SPPT_APU_ONLY, false, pwr_ctrl->sppt_apu_only, NULL);
>  	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false, pwr_ctrl->stt_min, NULL);
>  	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
> -			 pwr_ctrl->stt_skin_temp[STT_TEMP_APU], NULL);
> +			 fixp_q88_from_integer(pwr_ctrl->stt_skin_temp[STT_TEMP_APU]), NULL);
>  	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
> -			 pwr_ctrl->stt_skin_temp[STT_TEMP_HS2], NULL);
> +			 fixp_q88_from_integer(pwr_ctrl->stt_skin_temp[STT_TEMP_HS2]), NULL);
>  
>  	if (is_apmf_func_supported(dev, APMF_FUNC_SET_FAN_IDX))
>  		apmf_update_fan_idx(dev, config_store.mode_set[idx].fan_control.manual,
> diff --git a/drivers/platform/x86/amd/pmf/cnqf.c b/drivers/platform/x86/amd/pmf/cnqf.c
> index bc8899e15c914..3cde8a5de64a9 100644
> --- a/drivers/platform/x86/amd/pmf/cnqf.c
> +++ b/drivers/platform/x86/amd/pmf/cnqf.c
> @@ -81,10 +81,10 @@ static int amd_pmf_set_cnqf(struct amd_pmf_dev *dev, int src, int idx,
>  	amd_pmf_send_cmd(dev, SET_SPPT, false, pc->sppt, NULL);
>  	amd_pmf_send_cmd(dev, SET_SPPT_APU_ONLY, false, pc->sppt_apu_only, NULL);
>  	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false, pc->stt_min, NULL);
> -	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, pc->stt_skin_temp[STT_TEMP_APU],
> -			 NULL);
> -	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, pc->stt_skin_temp[STT_TEMP_HS2],
> -			 NULL);
> +	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
> +			 fixp_q88_from_integer(pc->stt_skin_temp[STT_TEMP_APU]), NULL);
> +	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
> +			 fixp_q88_from_integer(pc->stt_skin_temp[STT_TEMP_HS2]), NULL);
>  
>  	if (is_apmf_func_supported(dev, APMF_FUNC_SET_FAN_IDX))
>  		apmf_update_fan_idx(dev,
> diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
> index a2cb2d5544f5b..5209996eba674 100644
> --- a/drivers/platform/x86/amd/pmf/core.c
> +++ b/drivers/platform/x86/amd/pmf/core.c
> @@ -176,6 +176,20 @@ static void __maybe_unused amd_pmf_dump_registers(struct amd_pmf_dev *dev)
>  	dev_dbg(dev->dev, "AMD_PMF_REGISTER_MESSAGE:%x\n", value);
>  }
>  
> +/**
> + * fixp_q88_from_integer: Convert integer to Q8.8
> + * @val: input value
> + *
> + * Converts an integer into binary fixed point format where 8 bits
> + * are used for integer and 8 bits are used for the decimal.
> + *
> + * Return: unsigned integer converted to Q8.8 format
> + */
> +u32 fixp_q88_from_integer(u32 val)
> +{
> +	return val << 8;
> +}
> +
>  int amd_pmf_send_cmd(struct amd_pmf_dev *dev, u8 message, bool get, u32 arg, u32 *data)
>  {
>  	int rc;
> diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
> index e6bdee68ccf34..2865e0a70b43d 100644
> --- a/drivers/platform/x86/amd/pmf/pmf.h
> +++ b/drivers/platform/x86/amd/pmf/pmf.h
> @@ -777,6 +777,7 @@ int apmf_install_handler(struct amd_pmf_dev *pmf_dev);
>  int apmf_os_power_slider_update(struct amd_pmf_dev *dev, u8 flag);
>  int amd_pmf_set_dram_addr(struct amd_pmf_dev *dev, bool alloc_buffer);
>  int amd_pmf_notify_sbios_heartbeat_event_v2(struct amd_pmf_dev *dev, u8 flag);
> +u32 fixp_q88_from_integer(u32 val);
>  
>  /* SPS Layer */
>  int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf);
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index d3083383f11fb..dfc5285b681f7 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -198,9 +198,11 @@ static void amd_pmf_update_slider_v2(struct amd_pmf_dev *dev, int idx)
>  	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false,
>  			 apts_config_store.val[idx].stt_min_limit, NULL);
>  	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
> -			 apts_config_store.val[idx].stt_skin_temp_limit_apu, NULL);
> +			 fixp_q88_from_integer(apts_config_store.val[idx].stt_skin_temp_limit_apu),
> +			 NULL);
>  	amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
> -			 apts_config_store.val[idx].stt_skin_temp_limit_hs2, NULL);
> +			 fixp_q88_from_integer(apts_config_store.val[idx].stt_skin_temp_limit_hs2),
> +			 NULL);
>  }
>  
>  void amd_pmf_update_slider(struct amd_pmf_dev *dev, bool op, int idx,
> @@ -217,9 +219,11 @@ void amd_pmf_update_slider(struct amd_pmf_dev *dev, bool op, int idx,
>  		amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false,
>  				 config_store.prop[src][idx].stt_min, NULL);
>  		amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
> -				 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_APU], NULL);
> +				 fixp_q88_from_integer(config_store.prop[src][idx].stt_skin_temp[STT_TEMP_APU]),
> +				 NULL);
>  		amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
> -				 config_store.prop[src][idx].stt_skin_temp[STT_TEMP_HS2], NULL);
> +				 fixp_q88_from_integer(config_store.prop[src][idx].stt_skin_temp[STT_TEMP_HS2]),
> +				 NULL);
>  	} else if (op == SLIDER_OP_GET) {
>  		amd_pmf_send_cmd(dev, GET_SPL, true, ARG_NONE, &table->prop[src][idx].spl);
>  		amd_pmf_send_cmd(dev, GET_FPPT, true, ARG_NONE, &table->prop[src][idx].fppt);
> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
> index a1e43873a07b0..22d48048f9d01 100644
> --- a/drivers/platform/x86/amd/pmf/tee-if.c
> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
> @@ -123,7 +123,8 @@ static void amd_pmf_apply_policies(struct amd_pmf_dev *dev, struct ta_pmf_enact_
>  
>  		case PMF_POLICY_STT_SKINTEMP_APU:
>  			if (dev->prev_data->stt_skintemp_apu != val) {
> -				amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, val, NULL);
> +				amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
> +						 fixp_q88_from_integer(val), NULL);
>  				dev_dbg(dev->dev, "update STT_SKINTEMP_APU: %u\n", val);
>  				dev->prev_data->stt_skintemp_apu = val;
>  			}
> @@ -131,7 +132,8 @@ static void amd_pmf_apply_policies(struct amd_pmf_dev *dev, struct ta_pmf_enact_
>  
>  		case PMF_POLICY_STT_SKINTEMP_HS2:
>  			if (dev->prev_data->stt_skintemp_hs2 != val) {
> -				amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, val, NULL);
> +				amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false,
> +						 fixp_q88_from_integer(val), NULL);
>  				dev_dbg(dev->dev, "update STT_SKINTEMP_HS2: %u\n", val);
>  				dev->prev_data->stt_skintemp_hs2 = val;
>  			}
> 

