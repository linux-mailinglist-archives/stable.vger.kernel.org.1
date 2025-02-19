Return-Path: <stable+bounces-117524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF78A3B715
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4273B9C8F
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EC41DF743;
	Wed, 19 Feb 2025 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnVDx1gN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBFF1DF737
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955553; cv=none; b=Jhk28blmzYaEJXQe9qA7RXkqFKoKehJW+JJph1YqHqa9/M5X9yX/4QEP0D2mCN9Vzy6OFReNxWcNN6SCC8gQ0Te3jKdfCF9nafwCwVYEp36ETH74mOrlF2tKZYL8a3azqcGEPZvpNdJ7YL5WvTCxIQbdSzy2RFurHHT0rglruiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955553; c=relaxed/simple;
	bh=IrzFKL+oIfGWI2q1BLYSb0MXOUzPdMMijI+zZGL3rEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/vOfFwc0f4pa5NnLQmN6ZYSFqmUpH1lk7P+/6axN8CJ61Nd/uN0s5LSm7K8pZOF3Gn5aor3uKt/TJ7xrxsdIKIjkOenWCmRGcuDjl/wPStNXFvsJLGPqdwum5Kpe+iX3rXfOoqiXVjimxQFOdc76dnTCbnhzsFm+axtFVsZHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnVDx1gN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso978916566b.1
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 00:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739955547; x=1740560347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdLd4d/2KvKjfUhQztRQPCox3np4HSwf6kDWlFesZVw=;
        b=SnVDx1gNMLgrF90+B/gMeqc5gnARJYLrpqEEPgtkqL0p6JHzMxHxo/BkN+8zczz6wA
         ylzSj9aZ3+7iZdRaeV5xwRgrXT9ZXtkDhY9SGBmJuKxlcb8epPit3udzvuKjgV8XDL0+
         rzO9wh6OVeEoEgA++B6nrO/H62CZ/hvc25Gg3UV/Oud4M9MrKXgP/6MITxaBgx9Q3pwc
         sQbED82IuxH81+23knzKKTKLEdH4TzeMtDEW6JAkkvIY8reQj4OG0mpS7TWFPyYwEnru
         Veyejqeh3DEI8tm2kCO8BUmQ4xfLQvlA50uLjK/yNeVE5q5+VAZA9r5AfUu0YJAvvTpy
         m1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739955547; x=1740560347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdLd4d/2KvKjfUhQztRQPCox3np4HSwf6kDWlFesZVw=;
        b=pIjVvs9uSQ+6Wsv+7Rl2hIgaJnS3wRPEhW6RPKzZ1bKSmM8FoDcu/Edj4yqtKhm/4Q
         KW9JdMjsiwo21oXR+LAeHftBo+HV2oY+Q7nlL3ICt/BcWJ13aOngiSrqBlpc5iGQHTWA
         YjasJQTWPZ1kG+L6q8J8TFZCHjVENQ17UQBMqQ4H04psi8fj3B/fpwtoBk7pOgPMTEaN
         EBlQpAQx+0GjQHz7o1JF22OwJ3D6rU3hCJUTcXqDQoKapngug8bdhNqES+/wdvrpuNHM
         wXg3Y7CweMK/1aZFK38mwb4Jnlh8lUhbfSuwUKZZ4/WW52d3DcMMR5oEQsN37ZfmUep/
         2mjw==
X-Forwarded-Encrypted: i=1; AJvYcCWmmPzMslXkaEkyWCRD2/jKaTJBHl9uF2JeL5/tHn7EMKRU8gBJELZplC0wjjO3OryI1QK+APQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsAMRRdWdtzueNMrjIEyJDEE4Vbs7zahTIobZ3j6lM8nkNWhMv
	GCBZroz3dKfxIuvsW2aCLt58mIUg98SzO38bK7w24P24h6B7ETxt
X-Gm-Gg: ASbGncvdpsMHBCG4bFjR5JqIlBs4osKHZVZ8waZjC6l8P4zQNLMGqwNFLbYI1qXnz+S
	4JYVD2Gxc9ybmamJyPgqVmycwz5SccZp5FQZwo6zzVvrLw8Jebs/Jm7SiSmCwKrICsHSEu7J2J6
	6FxSKHwIqgzxmb/la2GMmAEytzgYl2dqUr4WLLtztsXl4fFG7iT1XuVp8kZqQ9cM9xes9nsYA23
	VypWd/PLGm+Fknt6j4NI5ozyptVmmvhIaLSSakSbNzTNvGkoJQVL7jCGv1kSJTVfNv0ixspa3Hj
	LkiMGd4wQJk2afuRyAnOdqQs9s4cYmYgy93im+PhrdBNVFUGQbvoJgeeMw==
X-Google-Smtp-Source: AGHT+IFwjUlxoWQ4SJRaGj/REGKr2twn6c6LaS+NPPraquSZEVgdYZMC5ImE+AiM5Q6Av78vsPAdqA==
X-Received: by 2002:a17:907:7dac:b0:abb:b12b:e104 with SMTP id a640c23a62f3a-abbcce4cba5mr256021366b.31.1739955547086;
        Wed, 19 Feb 2025 00:59:07 -0800 (PST)
Received: from [192.168.0.9] (pc-201-96-67-156-static.strong-pc.com. [156.67.96.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb98ed07afsm568376866b.102.2025.02.19.00.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 00:59:06 -0800 (PST)
Message-ID: <96738386-9155-4eea-b91d-8590ef3b4562@gmail.com>
Date: Wed, 19 Feb 2025 09:59:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 116/274] drm/amdgpu/gfx9: manually control gfxoff for
 CS on RV
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Lijo Lazar <lijo.lazar@amd.com>,
 Sergey Kovalenko <seryoga.engineering@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20250219082609.533585153@linuxfoundation.org>
 <20250219082614.161530240@linuxfoundation.org>
Content-Language: en-US, pl-PL
From: =?UTF-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <mumei6102@gmail.com>
In-Reply-To: <20250219082614.161530240@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This patch has to be changed for 6.13 - "gfx_v9_0_set_powergating_state" 
has 'amdgpu_device' argument instead of 'amdgpu_ip_block' argument there.

On 2/19/25 09:26, Greg Kroah-Hartman wrote:
> 6.13-stable review patch.  If anyone has any objections, please let me know.
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
> @@ -7439,6 +7439,38 @@ static void gfx_v9_0_ring_emit_cleaner_s
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
> @@ -7615,8 +7647,8 @@ static const struct amdgpu_ring_funcs gf
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


