Return-Path: <stable+bounces-145842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C217ABF751
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947953B1C32
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095F219994F;
	Wed, 21 May 2025 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcWtNH4E"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DA2145A18
	for <stable@vger.kernel.org>; Wed, 21 May 2025 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836553; cv=none; b=YXkJs/6EgT7WcQCx3fbrNg0jlUiCDnY1Lhf5r2xS+OfScNqlFQKWAmTxl4yijrMUtzPfjHkLsusFNcQlJuBD4uzs4/eY0TAfEvlHYkkTTX3ZPPCzzT2q0kwXAXEwKXKylypGxKuGo7tYCq8Z7X0u0/JAvhSEZRymbw2r0phKJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836553; c=relaxed/simple;
	bh=C/JRzUChCpABy7RAEj6G9EuEVMUfJYNB+l7mWDpDK3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ec3sS2+y1zHc2ju369nxWeOqGq7l4qfcbdp0UGqFEPt0AjSsxk2+mXJcQih/CTJrVHymvTyjUNJV9aR8G3WI4SWo0+eBsJUKt1k4LKU2PiKo5fgi7bRz3qCSXiIVgmV4V8iRteYPLm14kdezPIrMApmAkjxbDoywNBZpmKkzfZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcWtNH4E; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f5373067b3so87292166d6.2
        for <stable@vger.kernel.org>; Wed, 21 May 2025 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747836551; x=1748441351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yeKllHl739tWSw+Pf9YV3vR33en6i2spzbLK/NYgJ/c=;
        b=AcWtNH4EKzb26I0lqmPx5O6nnHOcgHYvO7vjm5gKw6xSipypa7Ik9OemUkCrO0pY0h
         q3K6eV0xYAz5paC94rDBMms8jGtJL4VX85P6lBM6Vr2dOAXtEz4ABCPwHTLVwhq7SceD
         Ehmk6hZB9L1BqiMK7XoDODNkwKouj3JDXbbaabAg4oRlt4v/5baITNr7YtMEt/hTtNQE
         a0hjKsAVXN9rlHtSkEZdZhU12IFJDVEhTXLx7KHTYPSYI2rZ6e9Xrb7P9SfQlWpGXPUY
         87W9vYXpJk0SHKMuMoz4+ZEY9ldFjyyPoqU6kizOkjDDhXyRM254A0j5sWqDESOWWktv
         hEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747836551; x=1748441351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeKllHl739tWSw+Pf9YV3vR33en6i2spzbLK/NYgJ/c=;
        b=RkN1qtlPmCI6B6Itlc8OCnMLnwDOVUwm4JIhmnweIun922Q+3tKYsibF3ROsdOyX8A
         S8+Jj3jV9pBzZOPFit5hBcowxVs8j37MO3+DFKOjbiF5Qa9CGdv2H4jdSl9r+Iy5xIOG
         EzWm+YcTli0KaUI1ux/ZU+LQOaBmJWT/e3s5b/j2E5Ya2vndB7dEJS1ENe3W3WLMxRjX
         N3pRx6BtdBKnNiBG1wGJa2zt8U44FUdzxRjGxeCXEMI0nOifXuGVa5WxfCIPDqwSmC6U
         ZptPSYyPp/kXPZ5L6PgQOaF8y+LN61FkZmd1gdsTU8YCYVxHrYb7QAdcV0M2Dbap+Eoe
         4IGQ==
X-Gm-Message-State: AOJu0Yx5u8GfwpNZexWSdRCidyYY0VpyEyEXifQJrXQjf4g46YMK5H5e
	J/WpwetdC3ayZmsQIuXFD8HPm2psKsnEPZmxg5Sl9HvlJ4ehg5CqZIFh
X-Gm-Gg: ASbGncvtkJ0BcvXry3MK8ioglB1c5Mt/ArGDWJBOFdTzmjlbKKIKHBuBOfUGjzg683w
	bNw2IIqs7SJVGAkImfAHKEP0ZDtslwz3Dj0EEO0hKucxCc9eo00W6ri4lSu2lj5GLso85qee20c
	Na+Y0afDlSj/qrhdHgAQNtc4GrMY4tvyxa4fObrWSerPA9KI/6FMDvzdh5Kfjp5f2k+IxSz0kek
	T54NpCxdTjx7jqGtgQeEqW7Fkv0dbKPepqw0UVy/2QKCA1eKMgmFdvprnCuybZBx1BHI+FJ3p81
	5W8ydFFLNhushM2ZNedv11TlyTzn0jaaJ1LiA9BWQ6b5avwL2ybcLcJN5Y5+
X-Google-Smtp-Source: AGHT+IGUJmKANcomr75orAMXeYRbud74YUe7qJPOSGIgZHx04hku/bR1ApJYg5S+2Sci/qIhMfF5Eg==
X-Received: by 2002:a05:6214:da5:b0:6f8:ae32:39ad with SMTP id 6a1803df08f44-6f8b2c5b0f9mr330315626d6.15.1747836550641;
        Wed, 21 May 2025 07:09:10 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.111.111])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6f8b0883f20sm86476656d6.22.2025.05.21.07.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 07:09:10 -0700 (PDT)
Message-ID: <4e859672-91f5-4ce2-8c68-e47b51b893d7@gmail.com>
Date: Wed, 21 May 2025 10:09:09 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] drm/amd/display: Defer
 BW-optimization-blocked DRR" failed to apply to 6.1-stable tree
To: alexander.deucher@amd.com
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org,
 aurabindo.pillai@amd.com, daniel.wheeler@amd.com, ray.wu@amd.com,
 sunpeng.li@amd.com, danny.wang@amd.com, Zhongwei.Zhang@amd.com,
 chiahsuan.chung@amd.com, anthony.koo@amd.com, robin.chen@amd.com,
 charlene.liu@amd.com
References: <2025051956-disdain-foyer-a53c@gregkh>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <2025051956-disdain-foyer-a53c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/25 8:02 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 874697e127931bf50a37ce9d96ee80f3a08a0c38
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051956-disdain-foyer-a53c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h

Alex,

This patch depends on the following commits:

1. bd00b29b5f23 drm/amd/display: Do not enable replay when vtotal update is pending.
2. 34935701b7ed drm/amd/display: Correct timing_adjust_pending flag setting.

These look to be a fix for the panel replay feature.  They can be
cherry-picked cleanly for 6.14.y, but conflicts need to be fixed for the
earlier kernels.

6.1.y doesn't appear to support panel replay though.  I don't know if
the resulting commits should be squashed or just reworded.

Anyway, please let me know if you need anything from me on this.

Thanks,
John

> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 874697e127931bf50a37ce9d96ee80f3a08a0c38 Mon Sep 17 00:00:00 2001
> From: John Olender <john.olender@gmail.com>
> Date: Wed, 16 Apr 2025 02:54:26 -0400
> Subject: [PATCH] drm/amd/display: Defer BW-optimization-blocked DRR
>  adjustments
> 
> [Why & How]
> Instead of dropping DRR updates, defer them. This fixes issues where
> monitor continues to see incorrect refresh rate after VRR was turned off
> by userspace.
> 
> Fixes: 32953485c558 ("drm/amd/display: Do not update DRR while BW optimizations pending")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3546
> Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
> Signed-off-by: John Olender <john.olender@gmail.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Ray Wu <ray.wu@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 53761b7ecd83e6fbb9f2206f8c980a6aa308c844)
> Cc: stable@vger.kernel.org
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1525c408d452..cc01b9c68b47 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -372,6 +372,8 @@ get_crtc_by_otg_inst(struct amdgpu_device *adev,
>  static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
>  					      struct dm_crtc_state *new_state)
>  {
> +	if (new_state->stream->adjust.timing_adjust_pending)
> +		return true;
>  	if (new_state->freesync_config.state ==  VRR_STATE_ACTIVE_FIXED)
>  		return true;
>  	else if (amdgpu_dm_crtc_vrr_active(old_state) != amdgpu_dm_crtc_vrr_active(new_state))
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 28d1353f403d..ba4ce8a63158 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -439,9 +439,12 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
>  	 * Don't adjust DRR while there's bandwidth optimizations pending to
>  	 * avoid conflicting with firmware updates.
>  	 */
> -	if (dc->ctx->dce_version > DCE_VERSION_MAX)
> -		if (dc->optimized_required || dc->wm_optimized_required)
> +	if (dc->ctx->dce_version > DCE_VERSION_MAX) {
> +		if (dc->optimized_required || dc->wm_optimized_required) {
> +			stream->adjust.timing_adjust_pending = true;
>  			return false;
> +		}
> +	}
>  
>  	dc_exit_ips_for_hw_access(dc);
>  
> @@ -3168,7 +3171,8 @@ static void copy_stream_update_to_stream(struct dc *dc,
>  
>  	if (update->crtc_timing_adjust) {
>  		if (stream->adjust.v_total_min != update->crtc_timing_adjust->v_total_min ||
> -			stream->adjust.v_total_max != update->crtc_timing_adjust->v_total_max)
> +			stream->adjust.v_total_max != update->crtc_timing_adjust->v_total_max ||
> +			stream->adjust.timing_adjust_pending)
>  			update->crtc_timing_adjust->timing_adjust_pending = true;
>  		stream->adjust = *update->crtc_timing_adjust;
>  		update->crtc_timing_adjust->timing_adjust_pending = false;
> 


