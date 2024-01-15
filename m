Return-Path: <stable+bounces-10876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B8282D74A
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 11:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FC82821AA
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C58E101C6;
	Mon, 15 Jan 2024 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgnpGIya"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A646F6105
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so98894245e9.0
        for <stable@vger.kernel.org>; Mon, 15 Jan 2024 02:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705314367; x=1705919167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0ERJGdJKXuy2bRlb0EBBzuDaoF6eK/whbAY3GtjCXY=;
        b=cgnpGIyaqPDAX3L2ytjerEabLrmtmGhG6c2xrRgfaV824D/FYfdN6XuQVKHbWtRwWL
         xAztRirIcuSYOS58blO85fSrexWLU0Hi8IUEYCMSuDwpAIaOs8JGjObmvba5JsWmQboc
         dJYkTK5f/QsWMEZzTJApiRNBkshy0Ox1J/F+knlCnFXNuksvnmW6m8AnZirAtp6krpLD
         gBvF0BhPOK63JXxJe+UzMeWQ/U8BzyvuZSFBj6pCgDev4qzhcJiptbr0Ua2mTxopaVFA
         QkoKYwsxBtfWkHhwURIDSVgNEFySJxoHMlsI50v+sM/59g8tZXKPMs8dXgQ/blz9mRWj
         imxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705314367; x=1705919167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0ERJGdJKXuy2bRlb0EBBzuDaoF6eK/whbAY3GtjCXY=;
        b=CHJ2WsTK3sY85pR8Fn/v3auc0iiB9Gg7t8ZWL5CYEpNF8Blxn0PwvFyqLOtSKBypPf
         HPQunciAojhHNBjI5tUrhVn+cg8MktdmdipCC8pDNshGDefrMm3JTN3JAE+H6jPhlE5h
         OGhkC5DmGQNlPoxP6NelGlUueV234VVuynNZc0kyKbrmguuUcthGLhrHHX4fmNQ1Um0Z
         ux4wSzNKyzbjKX0EVquOI+nMdyfI5+ksIDLqyieTMj0T4iE5SrQvkk1rX/MFgLYTDR9U
         rXoyxU3sTfgfGrRgZHOtEwgEbeZsseYVkw2P8XHLZFqRVr1FFRU0nvGvpnwX46tuzbFb
         XnmQ==
X-Gm-Message-State: AOJu0Yw3724Fz1k8wyNDf6rZ191ILaq6C6EXxQ8M2Bh8CbvB93B4k04l
	FvZehDC5sjCeNg9DWi30PCc=
X-Google-Smtp-Source: AGHT+IGbc78kZgLpSNjQ1fWujBr7AiDioLbcsHrpuzSaiNIV1HYVMCiGG0f97yKDV0Swi7FmLmM9vQ==
X-Received: by 2002:a05:600c:4452:b0:40e:5bd0:d969 with SMTP id v18-20020a05600c445200b0040e5bd0d969mr1916363wmn.271.1705314366518;
        Mon, 15 Jan 2024 02:26:06 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id i5-20020adfb645000000b003368c8d120fsm11510679wre.7.2024.01.15.02.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 02:26:06 -0800 (PST)
Message-ID: <ef01b29e-8529-43d2-befc-a3e3d8eaccf9@gmail.com>
Date: Mon, 15 Jan 2024 11:26:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Process fences on IH overflow
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
 Joshua Ashton <joshua@froggi.es>
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <20240114130008.868941-2-friedrich.vock@gmx.de>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240114130008.868941-2-friedrich.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 14.01.24 um 14:00 schrieb Friedrich Vock:
> If the IH ring buffer overflows, it's possible that fence signal events
> were lost. Check each ring for progress to prevent job timeouts/GPU
> hangs due to the fences staying unsignaled despite the work being done.

That's completely unnecessary and in some cases even harmful.

We already have a timeout handler for that and overflows point to severe 
system problem so they should never occur in a production system.

Regards,
Christian.

>
> Cc: Joshua Ashton <joshua@froggi.es>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index f3b0aaf3ebc6..2a246db1d3a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -209,6 +209,7 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   {
>   	unsigned int count;
>   	u32 wptr;
> +	int i;
>
>   	if (!ih->enabled || adev->shutdown)
>   		return IRQ_NONE;
> @@ -227,6 +228,20 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   		ih->rptr &= ih->ptr_mask;
>   	}
>
> +	/* If the ring buffer overflowed, we might have lost some fence
> +	 * signal interrupts. Check if there was any activity so the signal
> +	 * doesn't get lost.
> +	 */
> +	if (ih->overflow) {
> +		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +			struct amdgpu_ring *ring = adev->rings[i];
> +
> +			if (!ring || !ring->fence_drv.initialized)
> +				continue;
> +			amdgpu_fence_process(ring);
> +		}
> +	}
> +
>   	amdgpu_ih_set_rptr(adev, ih);
>   	wake_up_all(&ih->wait_process);
>
> --
> 2.43.0
>


