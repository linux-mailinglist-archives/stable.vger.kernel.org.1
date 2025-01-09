Return-Path: <stable+bounces-108051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 471B4A06BD7
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 04:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1131D188863C
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 03:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7174613B7AE;
	Thu,  9 Jan 2025 03:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Pi5ggEas"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957BDDDC
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 03:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736391983; cv=none; b=UdWSasR3g8A+bt59Dtm5V3+DPx7aKj6Pvp0FPcUW/GUEPM+X8cZGBr+47v55BAOdPBQCFnRRi3NX+gge0BhmecabaukCvsqLi5j5EcVyyxtYJjJyD9JMyzJVnH5F+kge0NpysvuZmsE50gX4qO2r+BSsgXyzBei8UBrT2pNtSb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736391983; c=relaxed/simple;
	bh=6E44TC/WeLohaV/GG3/+2us5iJI0msB4IR+W0wVCTc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfsSGSY/UwOOIy9xN48bDu4bQJM+8XDJkB8dZ/Cq8xmXQ+oZbGOQ1QzUB7aJNf5KYVE6pKRpdqWbQ942H16EqoaxWX6I0xCdkdFPoe2YMVyQc/eod81rxiD4PN5ZqAHPW/bakRr1n5Tq+iCFW9sCbn+/UhIuiRJy115Oi8GXI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=Pi5ggEas; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844e9b8b0b9so32793139f.0
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 19:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1736391980; x=1736996780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTUZvAfC3HuCxdGqCAQ+0ClPvsf5FRg9P5yGUQG8KrA=;
        b=Pi5ggEasgOUK1cgUG0N42b9cHeWmrZ31hdGPO3RVjLkD+6N7hBiFghp9hyywR6oHE2
         5BgVITy4K5Hb4eXSOlnHNolTH3RRMo9Qi2gxd8EgtdBLLbZiVkTbrz55ch17GK+YOsQb
         e3LcvjylRTooNkp9zKDQgtdIKqHlaFEjEMpwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736391980; x=1736996780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTUZvAfC3HuCxdGqCAQ+0ClPvsf5FRg9P5yGUQG8KrA=;
        b=mrM3cti2Xyx1cYrdsvkeZL1KlrLKfTSB5+7f6f8SxdhmvfR/mXa3sCGO7C92REIGef
         Nh0yT+25yHhXYyYYNAIYv5xzcgQ70awVYLCwse91OTFqbv8XJX9eCkY5XAslIF6BIEhj
         a0FrOnbohlyaQO2C9KSpfx1bO6f2tfHYosLe1mzCpKSEnBfn0XluvYUutuNwQkMHh1q7
         5dzEyZCEwZvRB8JT0bGenCP3AWreFGetIqxGk3UbOY5f+TGoERKE4UhjC7gfW02u8tw9
         W+p6gfiW07jpiY7Ik+vKx8TiDzioLvVh+igH4cEHHG2gEqkD+/E6OEahbFnJ5hrVf65Y
         dRig==
X-Forwarded-Encrypted: i=1; AJvYcCVRfGCuhmn30VKKXbCZiEWv/ifAfPJBqfPfQpA1AdV6Lxo7ROzYWoJxBOrUkXjDtWUO9gYPJXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvjGIf1E5CHsji3V3Dk5bZat8E18y4OKIvVoKO3hpSxZWeC3HS
	I4MSsuuSW2JoC/dlsOMhqG8mPNQ+EM0z2ZXoFupFdAIZBanIUTbFvE429U6aOA==
X-Gm-Gg: ASbGncvfIZBYPA/hGsIW3fOuYzEqanRCaJ9mbarneBrd1T0+OXBxahwAUuHBO1UV9wR
	FKuRVYi6vBi7wsYZpA3MjTYyS2obZMybLW6I24NPosKLFfy9bAc2iXzQ5QXmDdilo3GPh9iBM70
	MyWU4R0ItmMXVmmTPwgsuNZnoIPxRtMkWGUj+KYkL4OWEENYUWwrs6hk9ETwAxvsNep4GOw3Kp5
	vemYouXZenD9XbCYBkC5Hi/HcR1fplI7mYa9b6WQDWnlEb0AfoYwQ29CKPpUlEEZRCa35PQU99D
	3/YfnS+Zqor/X7U0Vsr7isjI
X-Google-Smtp-Source: AGHT+IHDD0mFIm+x2FLllMlTBSOrRH1d0iM6GMX0L6u7f+zIeXK21APePMyl/UJrekX3J3HBVwuUUw==
X-Received: by 2002:a05:6e02:1f09:b0:3a7:e0c0:5f27 with SMTP id e9e14a558f8ab-3ce3a86a220mr41193365ab.2.1736391979775;
        Wed, 08 Jan 2025 19:06:19 -0800 (PST)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3ce4adbbdaesm1202825ab.29.2025.01.08.19.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 19:06:18 -0800 (PST)
Message-ID: <229506bf-e675-4f17-b1fa-f9f7d62fcd45@ieee.org>
Date: Wed, 8 Jan 2025 21:06:16 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] [ARM] fix reference leak in locomo_init_one_child()
To: Ma Ke <make24@iscas.ac.cn>, linux@armlinux.org.uk, sumit.garg@linaro.org,
 gregkh@linuxfoundation.org, elder@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250108033049.1206055-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250108033049.1206055-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/25 9:30 PM, Ma Ke wrote:
> Once device_register() failed, we should call put_device() to
> decrement reference count for cleanup. Or it could cause memory leak.
> 
> device_register() includes device_add(). As comment of device_add()
> says, 'if device_add() succeeds, you should call device_del() when you
> want to get rid of it. If device_add() has not succeeded, use only
> put_device() to drop the reference count'.

And above device_register() it says:

  * NOTE: _Never_ directly free @dev after calling this function, even
  * if it returned an error! Always use put_device() to give up the
  * reference initialized in this function instead.

> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Looks good to me.  Much cleaner result.

Reviewed-by: Alex Elder <elder@kernel.org>

> ---
> Changes in v4:
> - deleted the redundant initialization;
> Changes in v3:
> - modified the patch as suggestions;
> Changes in v2:
> - modified the patch as suggestions.
> ---
>   arch/arm/common/locomo.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
> index cb6ef449b987..45106066a17f 100644
> --- a/arch/arm/common/locomo.c
> +++ b/arch/arm/common/locomo.c
> @@ -223,10 +223,8 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
>   	int ret;
>   
>   	dev = kzalloc(sizeof(struct locomo_dev), GFP_KERNEL);
> -	if (!dev) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	if (!dev)
> +		return -ENOMEM;
>   
>   	/*
>   	 * If the parent device has a DMA mask associated with it,
> @@ -254,10 +252,9 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
>   			NO_IRQ : lchip->irq_base + info->irq[0];
>   
>   	ret = device_register(&dev->dev);
> -	if (ret) {
> - out:
> -		kfree(dev);
> -	}
> +	if (ret)
> +		put_device(&dev->dev);
> +
>   	return ret;
>   }
>   


