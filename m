Return-Path: <stable+bounces-117518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34A5A3B6CE
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A0E188499B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D741DEFE6;
	Wed, 19 Feb 2025 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5YGuEk8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF491DED51
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955535; cv=none; b=iRNiD1pf8ZIZb+8bVAiNjteWAx2jgC1h7xhYhQ5yWdoIVqhOGVyXl1qhxcRkS6VYlmdkR7builVV5uhCT02Dvv/Gu+riv7jTvkYzc0jj/A2ls57TD/oCkrF550el+dXoYVcOVn6CrObyBkX07sAGqauqmPrPf7CVsv1FKWa2X2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955535; c=relaxed/simple;
	bh=wO/6BSf/ZusKqipQukzO7Dtz9mSKLmO+4Ku4WrpLgw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQ19lSLAjWstyqxum40t5O+yMf9I4qoiiwpYDq665fWtNB9xcS2VDJnRlXQHoS8rXGwC1S3j4rBDNv0twpVzkAAhB4mGOUqRNIqJsUncXe8/0f5i/6EWt+ew+KPMGypJob5HPgVO7cOZTkgRgoHRyDF2UtNGomla3FxEEFd35g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5YGuEk8; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so11001088a12.2
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 00:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739955532; x=1740560332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPYgKL9mz20WeqRf2n6s6KWAKXTyT5lCL3eATb+Q0X0=;
        b=M5YGuEk8ot/5UnEe7gY1z04KA6Oh1k5x4PGyJcKyv4V2Qf4aGcr9uY3maTPovGfSQ1
         XzXfJMhJQx8ZdjRqGSsYIMCajFdYmaEt79I1iDd3yvjWavDi+SjnpBADi+RFlZca3XJS
         STrO2jSZSC9HQzqyN2nExpLwe1T0UawPzU3B17xqgPR+J3dywG33UK/S0PqFEMmUDPxA
         SyTw994e8aM4YXg6PMGZlVhRyhth4BkAHDh+d+DrknZirQPiPO1blaH3QpCN1m1cSZrQ
         uz6lFZaFhDzpmrLjSrZHz5ICnOakn9yh/gvz27nSLC07uyuekSb6FVkICXbaVzOd6fQm
         94yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739955532; x=1740560332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPYgKL9mz20WeqRf2n6s6KWAKXTyT5lCL3eATb+Q0X0=;
        b=RCuDwYm9vl2XVqGaxUh8IQhQjhe22A/dFpWcDDSwmrCw9IFnKVZPP3skDG0UFLXLHm
         MmEoD4LRbi8zMTuS8QsH5cUihV0jk0AbJBBywFJ2SE3K3jZlPx/InrUPteFoXYDEs0wR
         MdZkS4LhYL+nX/TQSwfULmmeNjMTTfBi8R0rA2heJusE0IE3mpVs8/GzhmzQLxsjq8FA
         nmQVy5Q+Uv4bpoiyJ7bvchCimhbL1DnQ4i/eN+tOovJGWd9kLE8sU0uIuB4gcZ/C+q+f
         4AR3BCSgbVqzHBqCPs1JeNi5k4PeUD6By5AOOamWKtiZcVzW5advCUimYFLk10Zp7ugn
         eRXA==
X-Forwarded-Encrypted: i=1; AJvYcCWh1DqqeRzCumjKU6n7i1o3i1MDspkW2jGeTHtFNI9+wsNWlavlwRsnq9+RPYOpiiSPsO6AbmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcmX0BMzkAuJWckWnDCu/xLsTr3Fdjr4D9XnPUMzGisYGKz3tD
	pbEkquu7DPBmisB58KzUM66Z7nF52uayHZ75AmVSMccMa5UcCbe/
X-Gm-Gg: ASbGncsqWDRmqgXgsRQcUhyMtEQwY5djeDm3QopuymmcpnA4CSQONRcpwtoSKIVwQ7a
	1ahYGttBOk11ksbuYXZKBsvOQwU2LisG0JIYmSSQT5z2leWcCOh0bgnnTts7ZkBWT7AABDEgnQb
	Rvc358IRosnuRDaXY8nIjxPuqebR8n6ekvzmXjUuB5ZI5rCr71RcNPJGIgmfyajSCwfo+8TpGLL
	eC/vOc41RXO0hsQLDQlEglE4opB1v6fsqar2hfJM98jaxKCMxSCHEAbDbsFY5pBYWBND6cDVBR3
	Ta/6iGvx9gMB1nPE5L6H8TgbI7XHjI/x99GLOms0909d9aIYzoAulxcV9A==
X-Google-Smtp-Source: AGHT+IF+lRwCFoZ/rYv2lYXMEsn99+2d5jWGkVFmY3F0KjL0NpDI7z/zZK2DhXNxEYNjhrHWOodACA==
X-Received: by 2002:a17:907:a088:b0:abb:b1ce:b4ed with SMTP id a640c23a62f3a-abbccc4df42mr258290166b.8.1739955531800;
        Wed, 19 Feb 2025 00:58:51 -0800 (PST)
Received: from [192.168.0.9] (pc-201-96-67-156-static.strong-pc.com. [156.67.96.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbb186c5d5sm352597966b.51.2025.02.19.00.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 00:58:51 -0800 (PST)
Message-ID: <bee822ff-b6eb-47ab-8d6d-af11e89ef5b2@gmail.com>
Date: Wed, 19 Feb 2025 09:58:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 097/230] drm/amdgpu/gfx9: manually control gfxoff for
 CS on RV
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Lijo Lazar <lijo.lazar@amd.com>,
 Sergey Kovalenko <seryoga.engineering@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20250219082601.683263930@linuxfoundation.org>
 <20250219082605.490351110@linuxfoundation.org>
Content-Language: en-US, pl-PL
From: =?UTF-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <mumei6102@gmail.com>
In-Reply-To: <20250219082605.490351110@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This patch has to be changed for 6.12 - "gfx_v9_0_set_powergating_state" 
has 'amdgpu_device' argument instead of 'amdgpu_ip_block' argument there.

On 2/19/25 09:26, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Alex Deucher <alexander.deucher@amd.com>
> 
> commit b35eb9128ebeec534eed1cefd6b9b1b7282cf5ba upstream.
> 
> When mesa started using compute queues more often
> we started seeing additional hangs with compute queues.
> Disabling gfxoff seems to mitigate that.  Manually
> control gfxoff and gfx pg with command submissions to avoid
> any issues related to gfxoff.  KFD already does the same
> thing for these chips.
> 
> v2: limit to compute
> v3: limit to APUs
> v4: limit to Raven/PCO
> v5: only update the compute ring_funcs
> v6: Disable GFX PG
> v7: adjust order
> 
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> Suggested-by: Błażej Szczygieł <mumei6102@gmail.com>
> Suggested-by: Sergey Kovalenko <seryoga.engineering@gmail.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3861
> Link: https://lists.freedesktop.org/archives/amd-gfx/2025-January/119116.html
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org # 6.12.x
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c |   36 ++++++++++++++++++++++++++++++++--
>   1 file changed, 34 insertions(+), 2 deletions(-)
> 
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7415,6 +7415,38 @@ static void gfx_v9_0_ring_emit_cleaner_s
>   	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
>   }
>   
> +static void gfx_v9_0_ring_begin_use_compute(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ip_block *gfx_block =
> +		amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
> +
> +	amdgpu_gfx_enforce_isolation_ring_begin_use(ring);
> +
> +	/* Raven and PCO APUs seem to have stability issues
> +	 * with compute and gfxoff and gfx pg.  Disable gfx pg during
> +	 * submission and allow again afterwards.
> +	 */
> +	if (gfx_block && amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 1, 0))
> +		gfx_v9_0_set_powergating_state(gfx_block, AMD_PG_STATE_UNGATE);
> +}
> +
> +static void gfx_v9_0_ring_end_use_compute(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ip_block *gfx_block =
> +		amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
> +
> +	/* Raven and PCO APUs seem to have stability issues
> +	 * with compute and gfxoff and gfx pg.  Disable gfx pg during
> +	 * submission and allow again afterwards.
> +	 */
> +	if (gfx_block && amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 1, 0))
> +		gfx_v9_0_set_powergating_state(gfx_block, AMD_PG_STATE_GATE);
> +
> +	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
> +}
> +
>   static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
>   	.name = "gfx_v9_0",
>   	.early_init = gfx_v9_0_early_init,
> @@ -7591,8 +7623,8 @@ static const struct amdgpu_ring_funcs gf
>   	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
>   	.reset = gfx_v9_0_reset_kcq,
>   	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
> -	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
> -	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
> +	.begin_use = gfx_v9_0_ring_begin_use_compute,
> +	.end_use = gfx_v9_0_ring_end_use_compute,
>   };
>   
>   static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
> 
> 


