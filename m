Return-Path: <stable+bounces-6727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F331812CE3
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 11:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE3B28180E
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 10:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB123BB2C;
	Thu, 14 Dec 2023 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWNw4OgX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0231CAF
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 02:28:49 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-333536432e0so7184191f8f.3
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 02:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702549727; x=1703154527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WS74u1YdM90ymuqPvvVgOyS833lPLTSZYme54xVkA7U=;
        b=CWNw4OgXTT0AleoWfAEIcW2NZq2S0fX6OnLa6qdQBXA5PcdjlQ/aH7YMjEg53PnNug
         TnBIOoyS89Ve6TMIygaUzzzCgget25JRKtFH7AzPKdrj+1YNoX6V2CvQeqU+Rbql+M0W
         Ckh/pspEaZBCYu1lwEEwweL7f8CEMbIjexkYd7ZPSP2CEcOs5G953WBUmNql/EVOvp/B
         augTK/NlMIfbfkjTT8W91BklOOMsAd9EbkI5CN1+DeDnV2m6YeLBa5Y7t+4Wp00TiqM1
         AIfnBu/kB20qmO40gytRnh4Ohq8QRj6cZvfptYCb+PW8OvQSinconUoJQjyMFFeExbxI
         3Fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702549727; x=1703154527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WS74u1YdM90ymuqPvvVgOyS833lPLTSZYme54xVkA7U=;
        b=auYPJ87uS8L8AGtEHzglJJ6VB2DepjDRBJBdwO8wbYBq+FRMR11FlEhwdoTUYt70R1
         SV2aF6wvMEaikI7g/Q+EqSiTv3/aQa1KS1jRzrrwI70/GMtO+iRn3ECfkXvjYs6oNjBH
         LzGa7eCo3G9MwgVBjFX4dj2esvWZUf3MysRZY7rp2tyJrZBhbFOtc7nTg868r+3xpJ4B
         worbhGWkPF6zdKiF+VuH0afz+1MKy6VNq+1rHTaptawpKsYDQOGLTEKW/ZwZUeBvfhNl
         9Ou8BBvvBcVvad9zifvD83I+CLXRuO6wsjDhyQcCEcOTNVCct/KELOO1wqe6FSEGS1oX
         fS/w==
X-Gm-Message-State: AOJu0YxmPuLJr7kiN8Y70FehsT92th3iuMYex79kJEDnaRPR2xvC3U/H
	gh5WhGtLlyUZPz/ET04Rq0M=
X-Google-Smtp-Source: AGHT+IGpjNTqP78grQMH2esWNz5HtAtJeBqniKJY+bGKLx7I0iIiSGuMdU2ShuAoEsYjnTCqL8wZBw==
X-Received: by 2002:a05:600c:ac7:b0:40b:5e21:ec1e with SMTP id c7-20020a05600c0ac700b0040b5e21ec1emr4890414wmr.80.1702549727257;
        Thu, 14 Dec 2023 02:28:47 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id he15-20020a05600c540f00b0040b5517ae31sm26287917wmb.6.2023.12.14.02.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 02:28:46 -0800 (PST)
Message-ID: <184fa52b-2546-4ab3-b11d-3b58e5562b32@gmail.com>
Date: Thu, 14 Dec 2023 11:28:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd: Add a workaround for GFX11 systems that fail
 to flush TLB
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Tim Huang <Tim.Huang@amd.com>, stable@vger.kernel.org
References: <20231213203118.6428-1-mario.limonciello@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231213203118.6428-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 13.12.23 um 21:31 schrieb Mario Limonciello:
> Some systems with MP1 13.0.4 or 13.0.11 have a firmware bug that
> causes the first MES packet after resume to fail. Typically this
> packet is used to flush the TLB when GART is enabled.
>
> This issue is fixed in newer firmware, but as OEMs may not roll this
> out to the field, introduce a workaround that will add an extra dummy
> read on resume that the result is discarded.
>
> Cc: stable@vger.kernel.org # 6.1+
> Cc: Tim Huang <Tim.Huang@amd.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3045
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * Add a dummy read callback instead and use that.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 19 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +++
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 11 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  8 ++++++--
>   4 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 9ddbf1494326..cd5e1a027bdf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -868,6 +868,25 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
>   	return r;
>   }
>   
> +void amdgpu_mes_reg_dummy_read(struct amdgpu_device *adev)
> +{
> +	struct mes_misc_op_input op_input = {
> +		.op = MES_MISC_OP_READ_REG,
> +		.read_reg.reg_offset = 0,
> +		.read_reg.buffer_addr = adev->mes.read_val_gpu_addr,
> +	};
> +
> +	if (!adev->mes.funcs->misc_op) {
> +		DRM_ERROR("mes misc op is not supported!\n");
> +		return;
> +	}
> +
> +	adev->mes.silent_errors = true;

I really think we should not have hacks like that.

Let's rather adjust the error message to note that updating the firmware 
might help.

Regards,
Christian.

> +	if (adev->mes.funcs->misc_op(&adev->mes, &op_input))
> +		DRM_DEBUG("failed to amdgpu_mes_reg_dummy_read\n");
> +	adev->mes.silent_errors = false;
> +}
> +
>   int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>   				uint64_t process_context_addr,
>   				uint32_t spi_gdbg_per_vmid_cntl,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index a27b424ffe00..d208e60c1d99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -135,6 +135,8 @@ struct amdgpu_mes {
>   
>   	/* ip specific functions */
>   	const struct amdgpu_mes_funcs   *funcs;
> +
> +	bool				silent_errors;
>   };
>   
>   struct amdgpu_mes_process {
> @@ -356,6 +358,7 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
>   				  u64 gpu_addr, u64 seq);
>   
>   uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg);
> +void amdgpu_mes_reg_dummy_read(struct amdgpu_device *adev);
>   int amdgpu_mes_wreg(struct amdgpu_device *adev,
>   		    uint32_t reg, uint32_t val);
>   int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 23d7b548d13f..a2ba45f859ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -960,6 +960,17 @@ static int gmc_v11_0_resume(void *handle)
>   	int r;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> +	case IP_VERSION(13, 0, 4):
> +	case IP_VERSION(13, 0, 11):
> +		/* avoid a lost packet @ first GFXOFF exit after resume */
> +		if ((adev->pm.fw_version & 0x00FFFFFF) < 0x004c4900 && adev->in_s0ix)
> +			amdgpu_mes_reg_dummy_read(adev);
> +		break;
> +	default:
> +		break;
> +	}
> +
>   	r = gmc_v11_0_hw_init(adev);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 4dfec56e1b7f..71df5cb65485 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -137,8 +137,12 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
>   		      timeout);
>   	if (r < 1) {
> -		DRM_ERROR("MES failed to response msg=%d\n",
> -			  x_pkt->header.opcode);
> +		if (mes->silent_errors)
> +			DRM_DEBUG("MES failed to response msg=%d\n",
> +				  x_pkt->header.opcode);
> +		else
> +			DRM_ERROR("MES failed to response msg=%d\n",
> +				  x_pkt->header.opcode);
>   
>   		while (halt_if_hws_hang)
>   			schedule();


