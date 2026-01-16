Return-Path: <stable+bounces-210063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E93DD331D7
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 16:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A786130FFE3A
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DD633971F;
	Fri, 16 Jan 2026 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laltpRYy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E90145348
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768576026; cv=none; b=dykauHaeu7hzVyoXCkjU5sZQU2oYy4OeRa6xGiHhYPdUCQYa5CkBgYPZPybAQxoOP8P/bWqz2H6w4igDzqruDvnrGQfi0TpLrVOPku6xHe1HC+JOB6tMvWI5AH5oFjC9erqZtnn51rvxkr6QJE8LVYF9/5aE5rE4Cq5Uu++xo0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768576026; c=relaxed/simple;
	bh=Pz8ztduKDZpRKO0ccE0abw9KU6bswUfzPk/s9t7qgpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVrnPFCpm00bzc5MxHawxIKPrPIlCYApIMj7OXHNssVQ/9BlJmkrOPw+AFjwHIU3UOlDDGyeCJU6Vz+lo3QgKcPidybYWzwJ+aJib4H298e4WCAYCuhTorDb4Zoq3XBrbwr4W8ovrb3nYemV3eH5Nx51DglS7l6zOFGdjd+FWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laltpRYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFACC116C6;
	Fri, 16 Jan 2026 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768576025;
	bh=Pz8ztduKDZpRKO0ccE0abw9KU6bswUfzPk/s9t7qgpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=laltpRYy7BlQk3jGZ/iYoz22mHPNlRBw61pbZUfKjuHMB7gDB8atR52UMQ9WfWAcc
	 ntlkG9TQlUSNKAIycl6HdJYYvWHLCIdkAh03LU6Lohsii+boxjcDd33eeWsO/e4be8
	 eS+vak3OUevh+Scd2GyMA0F/GThBGL4Ydj7bh6wZO598SY+ndW0EPxQ62sxWFNIWm2
	 cxdmekKiNUGcPSzfYr59uH6ulfj565M2+0JldHzOyT+O7ivxpE/BOz3rJH2Z5x1BAi
	 Soz5PQye8sHIVri6WFWdNpNxG/xvtzsi6Vq7az1DYbIAL7nOWX3YLpJNduOPs/Rhpw
	 BW/MY89p/i0Pg==
Message-ID: <6fe1eca2-2b4c-4852-b4ee-a87abc92a6de@kernel.org>
Date: Fri, 16 Jan 2026 09:07:04 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Clear HDMI HPD pending work only if it
 is enabled
To: IVAN.LIPSKI@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20260116150411.1110886-1-IVAN.LIPSKI@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260116150411.1110886-1-IVAN.LIPSKI@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/16/2026 9:03 AM, IVAN.LIPSKI@amd.com wrote:
> From: Ivan Lipski <ivan.lipski@amd.com>
> 
> [Why&How]
> On amdgpu_dm_connector_destroy(), the driver attempts to cancel pending
> HDMI HPD work without checking if the HDMI HPD is enabled.
> 
> Added a check that it is enabled before clearing it.
> 
> Fixes: d98e9c0497ae ("drm/amd/display: Add an hdmi_hpd_debounce_delay_ms module")
> 
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 655c9fcb078a..cba7546d3f95 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7743,10 +7743,12 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
>   		drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
>   
>   	/* Cancel and flush any pending HDMI HPD debounce work */
> -	cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_work);
> -	if (aconnector->hdmi_prev_sink) {
> -		dc_sink_release(aconnector->hdmi_prev_sink);
> -		aconnector->hdmi_prev_sink = NULL;
> +	if (aconnector->hdmi_hpd_debounce_delay_ms) {
> +		cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_work);
> +		if (aconnector->hdmi_prev_sink) {
> +			dc_sink_release(aconnector->hdmi_prev_sink);
> +			aconnector->hdmi_prev_sink = NULL;
> +		}
>   	}
>   
>   	if (aconnector->bl_idx != -1) {


