Return-Path: <stable+bounces-184229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620BDBD2F32
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 14:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83633189C6F0
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 12:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD4D262FCB;
	Mon, 13 Oct 2025 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="k0ul/v93"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C5825E44D
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358090; cv=none; b=GdQpPOQrj/TS2sAiOjQRKNbkPWBz8oLUUpeDXiRMo6ePn+mcl1a8Lv9Kz1+Ndh9wTajDZz0gIVMzn9hXNzbxkEw67Z1x4bzgKTCVQbPPEPWh9+oycLJ9NlR1knzgIBjvwxft/n2smnnLGPOlR7zv4OfOp04onElqo1r5XLcw2m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358090; c=relaxed/simple;
	bh=zIQotQXJ4iPtkTZRN2oDsVw+JvRj5ypvEyNyoQC1oFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvHj/SHZql67imsZoiSa1gR556lDRVYpyiHSmDknqtqcwVOrs3gvsfXfv5/XLwwkL+pyi0FHFX/AFvn9+jH8QCXveMVm4Y4IHxXLkxLdoBMLOXZMLYYlphAOcXBwOz0i1IC0T+9BDTRqEgUVIrUpsR5V8X+Nw4Znk9ZbYKh/J+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=k0ul/v93; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e6674caa5so21121885e9.0
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 05:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1760358087; x=1760962887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ABCeOI0Ueeiv4CUdV7HP2uy/+8hpV76uJWq4TqSIBQ=;
        b=k0ul/v93aLupQ37p6VybIPYjsN8rPsO5oCdoXkCTbv3h7UBtxA1TvN45Ri5WW2MHYw
         GljoXcncspa9q03lGF2YK43T2e7g4QVMPWdKbo2KyJOWHgnEDUUN3rj88JdWHtU4J2IC
         DLRh6tynAvvGZ+iQZsnG+MkyH1bCo/mt0tEQzl5404qZZYnngNDBvIs7dl3+5e16R9dc
         Gz+nUV8Vx5Gx1ow4vxQptUGcc4bn+GpUtdlDFeBUNsFxahzkkHwiZVe815wXO2Jvtan0
         BU2I5TPBZ/vjHqIVh4oTnn1tj8jALMhEQ0Dg/b/RAetsz9LAI2P3alZyXmRBurnBPzha
         gmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358087; x=1760962887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ABCeOI0Ueeiv4CUdV7HP2uy/+8hpV76uJWq4TqSIBQ=;
        b=K4SeZMOoWia9OQiehOfaV9Yaup2+NzVYNLxbQxSqiP3v6+R6W/g1PYUP1aCDgIjw5W
         9EOs633sqHVrEjUGcc6tOoYmsJl41TNkNZLLOap8gMXvfir45DuOxBYd/qDry3SPhesj
         7vI2iEmYr/4dEqkyQezFcfLKHvAaVxJ85pdzhBE65ddCFJEi3qNuNA+XPS2QkRzIGUAs
         oR9pYCpMl3YBq+7ZsonOPr1doH+KyUEJcQBTkY9+0Ol1asiXoMW5EfeZXPYuiCn1PGxa
         BZRhk+Smd2W6VJnwbvyLMx1WTtay9qMaxnId5/e0VQAExmk1Ok95s3AZTgBSnSiAxU3K
         PQAg==
X-Forwarded-Encrypted: i=1; AJvYcCWpWSUReDZ1EUc0T9vtwpCoxvOUxQp4np+Koo/gWJnuXKoAEGGl9Pfc1hxYYAPtq1ZQCCSVpKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJqPjW0m1KWWrwvXVyt0iyH8aI7ljAAp87dBC13WIQb9fimDYm
	1GWHvSBg16VbZ6p49xu5HCbOTdD49AIuftc42ty0oNTMy5R/0Rzf2tbeT5c6jryteWg=
X-Gm-Gg: ASbGncvhARsmL4jijwnzxvbc779g+dibxl0Z6UDbnCWnkSviejVzwvPA5oOkN1f3JiM
	lxdT06KHcJL712PwTDzdnM9KTiTis66mfR5yOcuA5fE7IZJ4OlGrlVkfKWPJo4m9wzFGW9sGa6W
	MEUc+qUT26E/6d151BZHD44FrnkmSvqx6W3ThZiiwHiLVF7k+tRweOQ3TcYJZfob9ncmp0AuqM0
	tfzDqoubThdp7KvurqBc4jDGjhMVuro2AkTkN+F3hevHQSZp19Kj0tVFLUEWQq8NWi6QSBcy1OZ
	6H047cFG4ASoRJIyMexOSU4aXt392q90FbM0Ou+t52lZ1XoLoTsdfuzrZV0yUJ/9ft9bG8+o2fr
	+BCEGXBUamHvPy0im/9wurGwrgjOBQ/pzbnhUWeHbZCQsp3oeUTrt1Q==
X-Google-Smtp-Source: AGHT+IGZu4vLoKcsEs0prOUdg2NRu/m5YMAG/vLWkjgsWlICHV6YrbIFcE3Ys3pz0mcx8tQ8BIpSgw==
X-Received: by 2002:a05:600c:609b:b0:45d:dbf0:4831 with SMTP id 5b1f17b1804b1-46fa9e39456mr143776135e9.0.1760358086690;
        Mon, 13 Oct 2025 05:21:26 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb483bcf9sm188213965e9.6.2025.10.13.05.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 05:21:26 -0700 (PDT)
Message-ID: <24affb5a-af97-4d1e-abdf-aaa061bdce4b@ursulin.net>
Date: Mon, 13 Oct 2025 13:21:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Fix potential double free in
 drm_sched_job_add_resv_dependencies
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 stable@vger.kernel.org
References: <20251003092642.37065-1-tvrtko.ursulin@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251003092642.37065-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


A gentle ping - any takers to double check my analysis and review the below?

Regards,

Tvrtko

On 03/10/2025 10:26, Tvrtko Ursulin wrote:
> Drm_sched_job_add_dependency() consumes the fence reference both on
> success and failure, so in the latter case the dma_fence_put() on the
> error path (xarray failed to expand) is a double free.
> 
> Interestingly this bug appears to have been present ever since
> ebd5f74255b9 ("drm/sched: Add dependency tracking"), since the code back
> then looked like this:
> 
> drm_sched_job_add_implicit_dependencies():
> ...
>         for (i = 0; i < fence_count; i++) {
>                 ret = drm_sched_job_add_dependency(job, fences[i]);
>                 if (ret)
>                         break;
>         }
> 
>         for (; i < fence_count; i++)
>                 dma_fence_put(fences[i]);
> 
> Which means for the failing 'i' the dma_fence_put was already a double
> free. Possibly there were no users at that time, or the test cases were
> insufficient to hit it.
> 
> The bug was then only noticed and fixed after
> 9c2ba265352a ("drm/scheduler: use new iterator in drm_sched_job_add_implicit_dependencies v2")
> landed, with its fixup of
> 4eaf02d6076c ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies").
> 
> At that point it was a slightly different flavour of a double free, which
> 963d0b356935 ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies harder")
> noticed and attempted to fix.
> 
> But it only moved the double free from happening inside the
> drm_sched_job_add_dependency(), when releasing the reference not yet
> obtained, to the caller, when releasing the reference already released by
> the former in the failure case.
> 
> As such it is not easy to identify the right target for the fixes tag so
> lets keep it simple and just continue the chain.
> 
> We also drop the misleading comment about additional reference, since it
> is not additional but the only one from the point of view of dependency
> tracking.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 963d0b356935 ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies harder")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Rob Clark <robdclark@chromium.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: "Christian König" <ckoenig.leichtzumerken@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.16+
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 46119aacb809..aff34240f230 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -960,20 +960,16 @@ int drm_sched_job_add_resv_dependencies(struct drm_sched_job *job,
>   {
>   	struct dma_resv_iter cursor;
>   	struct dma_fence *fence;
> -	int ret;
> +	int ret = 0;
>   
>   	dma_resv_assert_held(resv);
>   
>   	dma_resv_for_each_fence(&cursor, resv, usage, fence) {
> -		/* Make sure to grab an additional ref on the added fence */
> -		dma_fence_get(fence);
> -		ret = drm_sched_job_add_dependency(job, fence);
> -		if (ret) {
> -			dma_fence_put(fence);
> -			return ret;
> -		}
> +		ret = drm_sched_job_add_dependency(job, dma_fence_get(fence));
> +		if (ret)
> +			break;
>   	}
> -	return 0;
> +	return ret;
>   }
>   EXPORT_SYMBOL(drm_sched_job_add_resv_dependencies);
>   


