Return-Path: <stable+bounces-180421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C4EB80F14
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 18:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F133F16458B
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 16:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EAD2F9DBB;
	Wed, 17 Sep 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FPlhM44i"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E813E34BA46
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125124; cv=none; b=UOc+Fq2EwTG/onwBG/dc43SZUDuWunB+II3o6tWZoJ/eP8JLYKeZZx1lB8a/XxbziI7K91iFw0oI1ft8XBscU1WCAzIpfr2KFFE9mfl5yV68od0w9sgmrm7CN21qzSsyX5+FnHsMKINg0SYNNKFHAttDi6ZEL/SFKNd8opxjP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125124; c=relaxed/simple;
	bh=83FVdwNnxqEbYW3PgFyOSJc0vbgnfeTmYkwtMxfNscE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAgPiud5PwZk1/GXSkcXWsHJZsj7Wod5vjidmejWeAXb45WedBxzRJK9WVfGdSUgTPBGweecmhFZVrYZQEm/dVmrPUPVEUMwDM4EFJJvIj69nvYmNw+blfgORNb9daSdCxqfFycNvKbkXBma6pSnyAwKFlI6ubVjTKerVumD/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FPlhM44i; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso625260f8f.1
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758125120; x=1758729920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZfZwmKXTX8HZnh5vO2cl8cRtebuw3nAGYKhbz9bcrEc=;
        b=FPlhM44izJgKtPAMIOHzlNf/52KXm3YvTZx5MIg1RJRXuSXR55CCj3MiJsbPPkbt1H
         2Yo0CqLaa5hTo9HK6X6O2ZT6G/OkUuWpv1E9iedPO5get+LXQAdxSDEP4Rq+Rh7L8U8R
         RKI/RCnmIxxWso5Db0YwApXuRLyQGg2bPruNjE2rYJIFuSQ4q18s38+sUV4enXFoDrXS
         AUiv3t5AgPl8PnehGSfBCFrnGtMRKYkNSS5Shz7bG7VS5j9sKsLRFnSwOJuVhigQJNNY
         deqCqxq6RNgwtdNDEo04/hxij5i7u5Tk2EUptSXnTqlScDn7/op7KRKCaEuVByIz+b4a
         1niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758125120; x=1758729920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfZwmKXTX8HZnh5vO2cl8cRtebuw3nAGYKhbz9bcrEc=;
        b=ilbQ39I4/BA3RrVczh8rSYKECyOPDVg8lYKBKtiQeYivKDBH0XrI9qnxZCl33GeJqX
         8JWvRvrm0yL0MnNhsT24ozFq++gj8XQ8TjCCIA2z0GShoT1uL2DUMvDGT8UBUa3UvBd/
         d+FtyX6ocb/hF/BEeIHbE4sgYhh006NYyR1/m3Uq4WhApvIRuMWkxJNFVO7paE8y77ue
         x+D5y7UAMrophYd9egIED3uGmx6AonQJ6BSeIu8bwX5soiiN1f5AfAKPvRd19j845GHU
         qdpmerjugg1YXhVnqs3unu6zBZhawkrnmLzZc2MBKi3DbiwIDYzBfdJgiGr8kuAF7xi0
         sGRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEFff9sgu+oRclMP3VG6xoeuWvu2SSuJM1mc/XOHbF8BWujnlXRISVf2HjfxKXpiMptwxXUy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzudVU82Hm9nC01YlavQiL6C5NDdGWQY2VqF4j/ajt8+cpFHd0/
	J10SALXUKjNlj0KU+1rRFDdvlJhlQt1ESqefOqZ6kZ3PDAsHqnTbx5kOq2tU8G/HIFy1uNoT7ty
	jAwvy
X-Gm-Gg: ASbGncsThUdeBSqgT0bz8eEdh2bsLnPpEiVHi57g0FczMQCYuD3mgvrQRjKOhifUi5Y
	7ABJUAplGhcLjybOX5/v5+u1ESrvohMU29nJ3JueyTGK+SXx1UEEh16r1IS+sdohOfdu2gVksOZ
	W9QgigNr5d3JBoLX9JjUCYQbw2HJ1RR7HSOBgxmk7GF7R5HLCiXTv0j2CW7U1c0HSAvFQSIueoQ
	mARfGVFxXmkyEk1BQ5uNQmnaE/ZOcYLdNW6A8X65gP7kSZcCnK5JNHHbd+O7ZYRMbQklkGxdQTE
	5tExoXdPrpsSCP2V/wOFvOdfZ38maCxNbLf/idM0hE9WqwlQmqnL5rSPNmN0HErvryfySP9xUiH
	yQKOm1yrq+Hcpal+nL0ojVdklgWBncwsv4KiUJyaEOuURk6DsYvPOs0MpSW+Y6h6O3Ky01qPZ7V
	X4hA==
X-Google-Smtp-Source: AGHT+IG6PSOFrqglzlkWA1zO7CzKciVLMfMhjWHI8hR2vQYQuR0qyFq5Nrbski70IDPQSjM3RHc8/w==
X-Received: by 2002:a05:6000:220e:b0:3ec:98fb:d75e with SMTP id ffacd0b85a97d-3ede1b73345mr111009f8f.16.1758125120170;
        Wed, 17 Sep 2025 09:05:20 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:37e6:ed62:3c8b:2621? ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4613186e5c7sm48392715e9.0.2025.09.17.09.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 09:05:19 -0700 (PDT)
Message-ID: <80564613-d935-4ad0-ba00-4ed23a0f9cef@linaro.org>
Date: Wed, 17 Sep 2025 18:05:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clocksource: clps711x: Fix resource leaks in error
 paths
To: Zhen Ni <zhen.ni@easystack.cn>, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250804123619.78282-1-zhen.ni@easystack.cn>
 <20250814123324.1516495-1-zhen.ni@easystack.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250814123324.1516495-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/08/2025 14:33, Zhen Ni wrote:
> The current implementation of clps711x_timer_init() has multiple error
> paths that directly return without releasing the base I/O memory mapped
> via of_iomap(). Fix of_iomap leaks in error paths.
> 
> Fixes: 04410efbb6bc ("clocksource/drivers/clps711x: Convert init function to return error")
> Fixes: 2a6a8e2d9004 ("clocksource/drivers/clps711x: Remove board support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
> changes in v3:
> - Change "err" to "error" in the commit message.
> changes in v2:
> - Add tags of 'Fixes' and 'Cc'
> - Reduce detailed enumeration of err paths
> - Omit a pointer check before iounmap()
> - Change goto target from out to unmap_io
> ---
>   drivers/clocksource/clps711x-timer.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
> index e95fdc49c226..bbceb0289d45 100644
> --- a/drivers/clocksource/clps711x-timer.c
> +++ b/drivers/clocksource/clps711x-timer.c
> @@ -78,24 +78,33 @@ static int __init clps711x_timer_init(struct device_node *np)
>   	unsigned int irq = irq_of_parse_and_map(np, 0);
>   	struct clk *clock = of_clk_get(np, 0);
>   	void __iomem *base = of_iomap(np, 0);
> +	int ret = 0;

	int ret = -EINVAL;

>   	if (!base)
>   		return -ENOMEM;
> -	if (!irq)
> -		return -EINVAL;
> -	if (IS_ERR(clock))
> -		return PTR_ERR(clock);
> +	if (!irq) {
> +		ret = -EINVAL;

Remove the above

> +		goto unmap_io;
> +	}
> +	if (IS_ERR(clock)) {
> +		ret = PTR_ERR(clock);
> +		goto unmap_io;
> +	}
>   
>   	switch (of_alias_get_id(np, "timer")) {
>   	case CLPS711X_CLKSRC_CLOCKSOURCE:
>   		clps711x_clksrc_init(clock, base);
>   		break;
>   	case CLPS711X_CLKSRC_CLOCKEVENT:
> -		return _clps711x_clkevt_init(clock, base, irq);
> +		ret =  _clps711x_clkevt_init(clock, base, irq);
> +		break;
>   	default:
> -		return -EINVAL;
> +		ret = -EINVAL;

Remove the above

> +		break;
>   	}
>   
> -	return 0;
> +unmap_io:
> +	iounmap(base);
> +	return ret;
>   }
>   TIMER_OF_DECLARE(clps711x, "cirrus,ep7209-timer", clps711x_timer_init);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

