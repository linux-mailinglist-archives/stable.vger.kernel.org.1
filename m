Return-Path: <stable+bounces-188405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A80BBF81AB
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8E83BFCCC
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C791A2392;
	Tue, 21 Oct 2025 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="qZrqNO/I"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE7834D92E
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071810; cv=none; b=sGaZQ/2VDxpSVCP6P46mwLpxrErvgpFnGWPPYs9/ZdSlPGOIO0oFg/9OwuVHqzqi4DasBHBYSwVyFzN+J2BhWd4qn7XVPruuzn2hFft5QHHNRL2hpLhC6lreFtxMbfgwUKLlPY60Fx/abLy+ijx6/WfcZsN/YpnJsPOIlGz/Hcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071810; c=relaxed/simple;
	bh=+P4ANvuSavfcnKH62tr+Cug3Rf+Z+UGRmWABjDVFotA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoZf+/7X6QLyavUWwC0hJyXMPUWNiNw0w/sIBdvuALW58sq5+IArgsjb5j3HmJD3IBzHx4lbYFXWqUMrH6KIcROtFBnoiPyn8mA5mLDH+S57ZozepVdYadzct0GL+E18+bX3K2/KInOehn1XnZN5EvnK284se/WFHH1Op3FE+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=qZrqNO/I; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46b303f755aso63677465e9.1
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1761071806; x=1761676606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/31NMDpjYxX79hD0m9CWPcEz0sXm9H/7kszN6l94dI=;
        b=qZrqNO/Id9RifjTaQmi64699CqsnWL5aNkrIB2GhnYzKq/eYuNLbuap6xnkWnCafVs
         oDWZVpmg+7QLw7q8v1Hd+250HDb0LcxLtGuhi7UqzRJHRRzMbmaT+MnOB9kzsxHu5gcp
         Crgs9iBXLr6Io/kZE7LY8sOVkiK3ed7+z0dM24GA8X14Ny1x2JZfZtJNAE5IjfjglrFk
         /0BdXgNFapMM2Ve2ze9fzPr5acDC63z8a/NT93HLxXGTHUnx5OUpFIAWKDwjMLE7B7UG
         XyX+MC7BCq91v6+NwweVXLNioQII1KpwKaQin5Er3r5wz1G1yGs2C2neT9BOt1HevCIV
         9ywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071806; x=1761676606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/31NMDpjYxX79hD0m9CWPcEz0sXm9H/7kszN6l94dI=;
        b=DUyqBZAGk9+w00bzhlrqKQCmjAMe378OjcJWHZ3p37NmDX3STo0wfBvbg7mRVU1GuP
         gQcSH83zj4SbKIyzM9YqOXrYw70PPYO5RRLmy3GY88jrVnqDVc3jz66MiO76sc9x9vw7
         4ERfLO0JV7teZUMyZZZSdnuGnLAvHWL8NMfavCvxYIUGSOuV7Qr6/FnGO7wtCO++B8RX
         8mGTQsEdsARnG1bMr6QYFDem5RxT83H5W7SPVR8zr5WjjS4YyIMOTuycwA7Vfdxi9s+i
         xHZB6zPuBmok/EwH7jwdz45yJua2+a7xbkLzwdwkv1xNZ18/UA+mX3PGi0XkbYZpRBii
         rb0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRqV5EspO7I5Tpvt3dxC+BhPtp5UlziKHcFPpaiC9eyow4h/2IlUltOk2nSZUq3lP3h6U9xrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNGYWhT0m5K3dvyqj6mPDVT5LNM6XnXy6dbm9hITJcsiAXBSiE
	q7I+gXoRKFujkVl0us/rK6t+edEJEqZFRBYFZ6nJCtwDWCMTpaZfKMKJ8E0JGdmNOJg=
X-Gm-Gg: ASbGncspdHlsxusvH0BwipsSr6vTql0dMMHuHb9whh8RV/2nnrF90N2Y41iODVZF4X3
	PlNLrgA8t5RNbdQUT6X8QZbLtyAiEFkzZ8QZxomWXjWb9vYzyV4HRIrz4X4HyatbhxZT/ZP3S/q
	PzFA6TbE2uWSMilq0CjCsoM1A54AET+5eu6uCe/mCtbupKV8/Z3r/P6QLXTQ/Xy/gkuUCCaw0/P
	GUpRE01597XMAavy+xFLTVe/S588aXYD7L/K6afM2VjFWGnD/YCGWDs6HWzCJaMyrD3nqfIQCpO
	tpWF6/MrLZvt294bEwtngqjWo2qCSC3zF5LZ7H+jPVow9+4vMTL23V2tWrGAfiRIdeY+0E1udCr
	jqBTfXgdU7ayYhiD2MxKY6EXNO5TpVn3T1XEGjyBpb4HfKdeXG/BwGSmARNM1bI1Pv4DNW96lpb
	otGbo4MmaLWEP3xJc=
X-Google-Smtp-Source: AGHT+IHuD5mgeD886pEcOy41CAh/C4EmnxTay38r/3oLMR6ZOooN7HM0ZxHB9uqLJmXa6KYTzdPWRw==
X-Received: by 2002:a05:600c:811b:b0:471:13fa:1b84 with SMTP id 5b1f17b1804b1-4711787c803mr131576495e9.12.1761071805713;
        Tue, 21 Oct 2025 11:36:45 -0700 (PDT)
Received: from [192.168.0.101] ([90.242.12.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427ed3fsm6714205e9.1.2025.10.21.11.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 11:36:45 -0700 (PDT)
Message-ID: <d9c16e9e-8321-41fe-9112-e754445d8bb0@ursulin.net>
Date: Tue, 21 Oct 2025 19:36:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-fence: Fix safe access wrapper to call timeline name
 method
To: Akash Goel <akash.goel@arm.com>, sumit.semwal@linaro.org,
 gustavo@padovan.org, christian.koenig@amd.com
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, nd@arm.com,
 stable@vger.kernel.org
References: <20251021160951.1415603-1-akash.goel@arm.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251021160951.1415603-1-akash.goel@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 21/10/2025 17:09, Akash Goel wrote:
> This commit fixes the wrapper function dma_fence_timeline_name(), that
> was added for safe access, to actually call the timeline name method of
> dma_fence_ops.
> 
> Cc: <stable@vger.kernel.org> # v6.17+
> Signed-off-by: Akash Goel <akash.goel@arm.com>

Fixes: 506aa8b02a8d ("dma-fence: Add safe access helpers and document 
the rules")

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Apologies for the copy and paste snafu.

Regards,

Tvrtko

> ---
>   drivers/dma-buf/dma-fence.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 3f78c56b58dc..39e6f93dc310 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1141,7 +1141,7 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
>   			 "RCU protection is required for safe access to returned string");
>   
>   	if (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags))
> -		return fence->ops->get_driver_name(fence);
> +		return fence->ops->get_timeline_name(fence);
>   	else
>   		return "signaled-timeline";
>   }


