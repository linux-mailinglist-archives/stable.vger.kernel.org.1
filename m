Return-Path: <stable+bounces-192507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6825C35DAE
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 14:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539B63A6908
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 13:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8D532143A;
	Wed,  5 Nov 2025 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luapqlGx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DAC320393
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349544; cv=none; b=L8G8oD8ugh5zstIxF7vegFEfomQYqnnkuJxvCpEZuT71VJIMjcUdECTWvUXqdBTod6nUveaCNn14VjZ8e32JU7deSKquINp53JTCgSdCAi4FQf4szJo39KiC5+WYdLtusHcqkFeA5rsyPp+kr85Kf9AmykB7BWwniTR7ZuvU5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349544; c=relaxed/simple;
	bh=WZqTjb689EoWjujrHonKsIfRrwGoZauuvVV3zjdR5KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAeVVeyGht8NO4nXK6kajyy/5y895eP00ZtDtvUPpN8wCFAFu+w7v+sicowWOjqQwF+9+YEx0o6ezLD6orzVN3KEl0X3O0gZOWPDXKuEWWXw2AQwWKzax7y8cDSRwskABTnzValF94kgINXNmjazum7o8gQS0wPJnQRoJVq8xys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=luapqlGx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47758595eecso9563005e9.0
        for <stable@vger.kernel.org>; Wed, 05 Nov 2025 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762349541; x=1762954341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfYKsCgYtXAFMzfAlzEUUGBJt44vMEyp53EFHMiQJao=;
        b=luapqlGxuGVnE7WvwlaxwNS5LZoFyPxjx66LWE1SKMr8TipUOr4oKRXEEDdJ8pVyUm
         XJNo9luTEnnT9nrUnFzV1nYhFBQsfd8ruQeN3NjlbvZ1ns3DOl0AfbtElGnrYVQchfhV
         UD7gtadXVinzGp7NivmcgEnnAYeCGjyCUr1xWyeMp2pDrzmQUOuxbQ+T7ZtYrcPE20mk
         8IJ48/2U1Fm2IkYt+LKOs5qrNJX1xC10nyHv1sgSvtRLSUcDXqblV/7B7gFlT9rIR4Cw
         CTPWJXALPBU6AV67A36yjNq9ZrFr3ASzxhrTJhQ51y9QHfSKffybsOhjU54tQw25bjk2
         SzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762349541; x=1762954341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfYKsCgYtXAFMzfAlzEUUGBJt44vMEyp53EFHMiQJao=;
        b=bTAezB68fiu7F4/4CXzHKoYV7TrvoqhRfjKfDxJboGgYDYtIkwWF+r6boaj1Kw4Ma4
         H8JZOe1xtuDzW93R7xTwOWjKs2oRV5DXN+AlnkRx7lNRy3N9JsytdFwdbJzVSCwNQ3ss
         aZcyxDDVuaTYjQBOQdI7ksXv+ztcqS6b0GfePDtOX2uU8Qxspykw6K6RxquEDR5xeYVV
         Lk7Ijo5E1dZfj5D4PRCeD6NrTYBtkMB0TlsJ3NSDbMN63AgywyNTUAKz+77EDARGbgsv
         2+xVPC2d4dOM1UmJ/vxC7N1/JYN51mxDvgtfxGl1GEMBFewCMFbGZOO0biPF5s3G4V7c
         gUuA==
X-Forwarded-Encrypted: i=1; AJvYcCVlylX2SYp+H9EGu6RgVQrcLQ/RvkHOguzaDvwLKhF+zN0s4VTHk9VTfUw/qTvkOSOiKLzKGWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxha7jtGzFBSS4MDbnFEzOxrmDZvqglT3TNkvQ1i0HjmkthdeAL
	XfF0ptLPJocNsNXlDvSHFYU5PZKhNSp+MGopOjPrXX+KAXn6cuh86KMUF0ZcSkkI6qo=
X-Gm-Gg: ASbGncvlFr7WRfnpKBY/S03G/SMswFL04Ats5ovIYyjLe+ecpZzD73JR96hoP6a62LH
	lrPVQeB49ol+ZdS2pOT/fFJk23XhNbqjLHOhdyxJjs/3C/v3gGgswyQV4Zss+qBTlylTxBmK9TD
	NlzDTPc6t2SZx7dBjUcsvZ/SIh5nB0puplqKPkOxK2ZC7ppedev+yENTsWVL3ZaRhVV5Tr5XWjI
	EscUfFEdpnShjHRyYoh81WEY6Tk9qRdeFtJUAbmhfuFSJh8ryv+hjiGm6rMy7A9ewvAFKuCvZAW
	r77qRdVV3cX9yqcJfljO0CGII+ZMENpJGvSS4GZfoZIZ7Rmhwa5xpb1rJmLnEs4iU7mDzCha25y
	Pd0UBgN32d+H5+V5TcD2A2RKuLtjdudr92ZlgM5Dd3LV2q7qUYG2eDDqIvTNBcig2tvmT/fNBMP
	TSa2gfLWEo+NhAnE8tqTZZJ8xFF9eOOEtoceVQ
X-Google-Smtp-Source: AGHT+IHrQ5Ca/eXvqCH81m3o/jUTceHdPdQQWNSE7M8rzMniM4TuBgB5grmgh+HwfHdWHibHeGh8dg==
X-Received: by 2002:a05:600c:5252:b0:475:dd9d:297b with SMTP id 5b1f17b1804b1-4775cdf46f0mr23240645e9.33.1762349540607;
        Wed, 05 Nov 2025 05:32:20 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4775cdc2d14sm49078345e9.1.2025.11.05.05.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 05:32:20 -0800 (PST)
Message-ID: <7ad2b976-3b0d-4823-a145-ceedf071450d@linaro.org>
Date: Wed, 5 Nov 2025 14:32:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/stm: Fix section mismatches
To: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251017054943.7195-1-johan@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251017054943.7195-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Johan,

thanks for your fix.

You should replace __init by __init_or_module


On 10/17/25 07:49, Johan Hovold wrote:
> Platform drivers can be probed after their init sections have been
> discarded (e.g. on probe deferral or manual rebind through sysfs) so the
> probe function must not live in init. Device managed resource actions
> similarly cannot be discarded.
> 
> The "_probe" suffix of the driver structure name prevents modpost from
> warning about this so replace it to catch any similar future issues.
> 
> Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
> Cc: stable@vger.kernel.org	# 6.16
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/clocksource/timer-nxp-stm.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
> index bbc40623728f..ce10bdcfc76b 100644
> --- a/drivers/clocksource/timer-nxp-stm.c
> +++ b/drivers/clocksource/timer-nxp-stm.c
> @@ -177,15 +177,15 @@ static void nxp_stm_clocksource_resume(struct clocksource *cs)
>   	nxp_stm_clocksource_enable(cs);
>   }
>   
> -static void __init devm_clocksource_unregister(void *data)
> +static void devm_clocksource_unregister(void *data)
>   {
>   	struct stm_timer *stm_timer = data;
>   
>   	clocksource_unregister(&stm_timer->cs);
>   }
>   
> -static int __init nxp_stm_clocksource_init(struct device *dev, struct stm_timer *stm_timer,
> -					   const char *name, void __iomem *base, struct clk *clk)
> +static int nxp_stm_clocksource_init(struct device *dev, struct stm_timer *stm_timer,
> +				    const char *name, void __iomem *base, struct clk *clk)
>   {
>   	int ret;
>   
> @@ -298,9 +298,9 @@ static void nxp_stm_clockevent_resume(struct clock_event_device *ced)
>   	nxp_stm_module_get(stm_timer);
>   }
>   
> -static int __init nxp_stm_clockevent_per_cpu_init(struct device *dev, struct stm_timer *stm_timer,
> -						  const char *name, void __iomem *base, int irq,
> -						  struct clk *clk, int cpu)
> +static int nxp_stm_clockevent_per_cpu_init(struct device *dev, struct stm_timer *stm_timer,
> +					   const char *name, void __iomem *base, int irq,
> +					   struct clk *clk, int cpu)
>   {
>   	stm_timer->base = base;
>   	stm_timer->rate = clk_get_rate(clk);
> @@ -388,7 +388,7 @@ static irqreturn_t nxp_stm_module_interrupt(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>   
> -static int __init nxp_stm_timer_probe(struct platform_device *pdev)
> +static int nxp_stm_timer_probe(struct platform_device *pdev)
>   {
>   	struct stm_timer *stm_timer;
>   	struct device *dev = &pdev->dev;
> @@ -484,14 +484,14 @@ static const struct of_device_id nxp_stm_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, nxp_stm_of_match);
>   
> -static struct platform_driver nxp_stm_probe = {
> +static struct platform_driver nxp_stm_driver = {
>   	.probe	= nxp_stm_timer_probe,
>   	.driver	= {
>   		.name		= "nxp-stm",
>   		.of_match_table	= nxp_stm_of_match,
>   	},
>   };
> -module_platform_driver(nxp_stm_probe);
> +module_platform_driver(nxp_stm_driver);
>   
>   MODULE_DESCRIPTION("NXP System Timer Module driver");
>   MODULE_LICENSE("GPL");


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

