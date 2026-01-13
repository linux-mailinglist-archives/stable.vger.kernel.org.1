Return-Path: <stable+bounces-208302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BD0D1B9CA
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 23:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13C4130124C6
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 22:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C1E35CB87;
	Tue, 13 Jan 2026 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLckx10g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B2D2E266C
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768343924; cv=none; b=hnW8GkmiZVmDOWQjUklbSflBRUtEz+JLlK4YOuOZAmFL2laAIPw2qEhgj8a3CfGYhW6CDZ8pd/DIHd83H06Lws9FJZdujaPSY0yCO0s0yaUPfEVVL/KVyYM0+5asKGSE7WkspPh+9QdZeFGrdn9VNPugIZYNCw11gh4b2AE9214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768343924; c=relaxed/simple;
	bh=4cgnKUefhRKwFLUbnV8rNzACEXUctKDlbClwQFLMNRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOkSJFKtOQbSBcCcwjtZ365drlKzMJ5+VT4fsLQ0z0JK0eaVQKogJo/iyqOJXPOiQDmGxZcIeVnf9XHN8xTmGmGQveInJ2S1VXO7lPGVANeocwDghtmmntuM3GjHZehPw/WslIu5Nb8dqDNnDcJLjVf+sGllwSRUh34tfTgji8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLckx10g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA28BC19423;
	Tue, 13 Jan 2026 22:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768343924;
	bh=4cgnKUefhRKwFLUbnV8rNzACEXUctKDlbClwQFLMNRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vLckx10gDHTCse67SFqunTLsqRh9OfleOGudyQBor/aqHLCZXmHR3yjlkZvOtso83
	 6yOmB7wjW0ifWFhduf7UKV7E/WxpDzhGI6a3z5rh9GVbcXGNQEj0UtxAWTb5Czacjp
	 nP4FqMgFsMs2TXcRhEsdGcXHCBtHARmG0QP1oho95DGEuu6jQEwFn4pRJmbiwwgGPk
	 tvJvv8CVh19G7QYtlRDAXBxWyjHx93oWneDfirAEbA8ivHnS+1j0JoucVZQRdAvoDs
	 jJlfZS+p7k1OVBgf9W3UtgxB3HUEU0hBrdAA7bhv0cNP2FyjJXR+vjb+KD24IdngID
	 48kmJ2SLh06Kg==
Message-ID: <f2849dc4-ae29-463e-9f67-667e9174c5b5@kernel.org>
Date: Tue, 13 Jan 2026 16:38:42 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add an hdmi_hpd_debounce_delay_ms module
To: IVAN.LIPSKI@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20260113223012.494982-1-IVAN.LIPSKI@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260113223012.494982-1-IVAN.LIPSKI@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/13/2026 4:29 PM, IVAN.LIPSKI@amd.com wrote:
> From: Ivan Lipski <ivan.lipski@amd.com>
> 
> [Why&How]
> Right now, the HDMI HPD filter is enabled by default at 1500ms.
> 
> We want to disable it by default, as most modern displays with HDMI do
> not require it for DPMS mode.
> 
> The HPD can instead be enabled as a driver parameter with a custom delay
> value in ms (up to 5000ms).
> 
> Fixes: c97da4785b3b ("drm/amd/display: Add an HPD filter for HDMI")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4859
> 
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> ---

Makes sense to me.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

>   drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 11 +++++++++++
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++++++---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  5 ++++-
>   4 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 11a36c132905..9903da2d28b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -269,6 +269,8 @@ extern int amdgpu_rebar;
>   extern int amdgpu_wbrf;
>   extern int amdgpu_user_queue;
>   
> +extern int amdgpu_hdmi_hpd_debounce_delay_ms;
> +
>   #define AMDGPU_VM_MAX_NUM_CTX			4096
>   #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
>   #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d67bbaa8ce02..771c89c84608 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -247,6 +247,7 @@ int amdgpu_damage_clips = -1; /* auto */
>   int amdgpu_umsch_mm_fwlog;
>   int amdgpu_rebar = -1; /* auto */
>   int amdgpu_user_queue = -1;
> +uint amdgpu_hdmi_hpd_debounce_delay_ms;
>   
>   DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
>   			"DRM_UT_CORE",
> @@ -1123,6 +1124,16 @@ module_param_named(rebar, amdgpu_rebar, int, 0444);
>   MODULE_PARM_DESC(user_queue, "Enable user queues (-1 = auto (default), 0 = disable, 1 = enable, 2 = enable UQs and disable KQs)");
>   module_param_named(user_queue, amdgpu_user_queue, int, 0444);
>   
> +/*
> + * DOC: hdmi_hpd_debounce_delay_ms (uint)
> + * HDMI HPD disconnect debounce delay in milliseconds.
> + *
> + * Used to filter short disconnect->reconnect HPD toggles some HDMI sinks
> + * generate while entering/leaving power save. Set to 0 to disable by default.
> + */
> +MODULE_PARM_DESC(hdmi_hpd_debounce_delay_ms, "HDMI HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
> +module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms, uint, 0644);
> +
>   /* These devices are not supported by amdgpu.
>    * They are supported by the mach64, r128, radeon drivers
>    */
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 354e359c4507..ba7e1f72fde1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8918,9 +8918,18 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>   	mutex_init(&aconnector->hpd_lock);
>   	mutex_init(&aconnector->handle_mst_msg_ready);
>   
> -	aconnector->hdmi_hpd_debounce_delay_ms = AMDGPU_DM_HDMI_HPD_DEBOUNCE_MS;
> -	INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, hdmi_hpd_debounce_work);
> -	aconnector->hdmi_prev_sink = NULL;
> +	/*
> +	 * If HDMI HPD debounce delay is set, use the minimum between selected
> +	 * value and AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS
> +	 */
> +	if (amdgpu_hdmi_hpd_debounce_delay_ms) {
> +		aconnector->hdmi_hpd_debounce_delay_ms = min(amdgpu_hdmi_hpd_debounce_delay_ms,
> +							     AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS);
> +		INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, hdmi_hpd_debounce_work);
> +		aconnector->hdmi_prev_sink = NULL;
> +	} else {
> +		aconnector->hdmi_hpd_debounce_delay_ms = 0;
> +	}
>   
>   	/*
>   	 * configure support HPD hot plug connector_>polled default value is 0
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 7065b20aa2e6..6fe7f78b66c5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -59,7 +59,10 @@
>   
>   #define AMDGPU_HDR_MULT_DEFAULT (0x100000000LL)
>   
> -#define AMDGPU_DM_HDMI_HPD_DEBOUNCE_MS 1500
> +/*
> + * Maximum HDMI HPD debounce delay in milliseconds
> + */
> +#define AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS 5000
>   /*
>   #include "include/amdgpu_dal_power_if.h"
>   #include "amdgpu_dm_irq.h"


