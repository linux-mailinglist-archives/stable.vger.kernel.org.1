Return-Path: <stable+bounces-179264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD032B5338F
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 15:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D096A48132A
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 13:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502D2326D58;
	Thu, 11 Sep 2025 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jxKV0quu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69346324B0B
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597017; cv=none; b=BW2Fu37iIfBlDE7cKNP9swyDRKijUYYIGMV6tFD9Q8cx/SVvthMCiWnYqzb6yEeKCVxaHibKROIvRouaEBJGiwpAvr8YJz7ldwqhjxqjzr6/El/RqB7eM78ZjPUVjSvQH0VBu7PUGKQuCd+zD+p3j82su1TEGho1gF7mULgDZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597017; c=relaxed/simple;
	bh=/YhstqouVriUy4uvZSzgUIQdc4wbmJHjZqK9gJmykTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFk/L0Ulfues+jypeVjQ8/5g25juFjQH9wKD4pnuZrfXNWaR/0WIZh227pV1+eMMbotLPGLSFf3SPX301ja+lEibIMWEgj+8NOLnOf8j6RpYPtPKzaJ+zGUXEKqI1zcKIU3TXlh30LyUYkHz6cReBtpCGZvz4pzAU7T4D+Gq43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jxKV0quu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45deccb2c1eso5644155e9.1
        for <stable@vger.kernel.org>; Thu, 11 Sep 2025 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757597014; x=1758201814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5DZdOOp7kCLf5PJMbTE+QCt8MHwfrXt8sp1qPFYcuQ=;
        b=jxKV0quuGckntUYYYEW+UpPFojkZGJkkgX1FZ71A3sfYG7EjYAEvbhKzbnG/AJzNPQ
         mLZxyAy+8nLmnu/EwiUH7bAeNuPsGoBgr1vv22wBclGAbXmYqCQh5zP9wJ5xnFxDdCA5
         /BUM+uhy5wFkozK64ldxFKelFhiMHw6oewM5DclJFnJJyaoqVU5anOGt6aFH4IEXiiE7
         Z6czntYjPKOyymEZq358KS0dov6ETFDzYUh4dWZCRM/dLJdEV046qsqW4kTHfSwO7Gny
         Wl5/yAHQYKo/bybTl33yfEM72pBAyIj0s/vh2ce/sBxFU3lj9f5GSomJQ/c2gr5HiUOm
         Evcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597014; x=1758201814;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5DZdOOp7kCLf5PJMbTE+QCt8MHwfrXt8sp1qPFYcuQ=;
        b=IQGdAYWiu6MSTw5gW5BhMKg7K3JSfqUjIN4cGtYiJaJEYOuvXyhNOnPTIrlKqFjvP+
         HQmCXUSyac1mZ3msS6/eTz+hCAwTjd46zHIQvCKlH0zGoUbKl5rcv7wkUVTO1zx4cJ/0
         TYSHUpMqrRt8FfuVAmZTrwvDFJtHfElj1iFOCgS9y7tGgiDSmkDpVFOj3yu6BqgAoo3g
         tCX9GET47wgsZMs/BMzGRWSVPev3/jxoodosOax88czkzmtEY3eWF8mbpQOy8rOf/dy7
         xJvoExlvCvOYzx/WPiqkQMQrVsmUpiDhRlsHGQRFsFt8VtOdvlVsbnafAAprbWzJRfV3
         djWw==
X-Forwarded-Encrypted: i=1; AJvYcCUUDBpnK2+xKJJQa+Q2zTCboSeztzmlKS4all8Sv/LGA05j28SekZil3IyUAkH0XfvgprMlBnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlu7vl9gFIJEWrX8u5jEKIx6PWbb/T3rOr/KX8oWIJhup7K0Yy
	dnpg2qoAcQ2POXdJDx8dMBDQ+WuDdOkevfALuWaFsRog82koE2ze825lW3D+e0+rx20=
X-Gm-Gg: ASbGncuCPN0PeqAw+7MG+ie38jSlClmhm4tc3EGIB+qq8uvmMUQkKsK2H5cNY1CuTwE
	lWXI+9WPL86XZEfuFREMTy3boVOhuDKL2REMl0OWxUACu3TvxyXHMf8ITAnfjpbzVhjS0lidHon
	jVIKoYKckxrKHZ1sYtB8+875/+R/MZSOR5KGIWJKTEtv//1qcjgdmRYJ+q04jpLCeIBtxHkgKAU
	puyhaCw4BeEjq9Ye9JdKdbtkVdH6Nt1JdvQEF4tAYSbI5MYke3IicAwCim1sxIaEktEiNkfG24n
	zCgJ6hyxPR4U7ZzCifyZqLaENmaXwTQOoE9KUV0ALJWMM8v9T35DLRvY1Yzy+vDjJVMkPWgNg54
	qwZeDu6tNDJx2mp1eThg5jMTVFf617nc=
X-Google-Smtp-Source: AGHT+IFjnfzF7F/GlJxwpHM8SNF/LM5GQGWaMSdVtiWgkVzuGZF4P9oVll9idmR9VsX8OIWFod6saA==
X-Received: by 2002:a05:600c:1f13:b0:45b:97e0:22ad with SMTP id 5b1f17b1804b1-45dddee9082mr196072155e9.24.1757597013684;
        Thu, 11 Sep 2025 06:23:33 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c3ee8sm24444215e9.18.2025.09.11.06.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 06:23:33 -0700 (PDT)
Message-ID: <54d7c3b2-762f-4f61-af21-02247a471251@tuxon.dev>
Date: Thu, 11 Sep 2025 16:23:32 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Fix ISEL restore on resume
To: Biju Das <biju.das.jz@bp.renesas.com>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250908144250.1269294-1-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113460BE4B4D20305021D85328609A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <TY3PR01MB113460BE4B4D20305021D85328609A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 9/11/25 13:43, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: 08 September 2025 15:43
>> Subject: [PATCH] pinctrl: renesas: rzg2l: Fix ISEL restore on resume
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Commit 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL in
>> gpio_irq_{en,dis}able*()") dropped the configuration of ISEL from
>> rzg2l_gpio_irq_enable()/rzg2l_gpio_irq_disable() and moved it to
>> rzg2l_gpio_child_to_parent_hwirq()/rzg2l_gpio_irq_domain_free() to fix spurious IRQs.
>>
>> The resume code used rzg2l_gpio_irq_enable() (called from
>> rzg2l_gpio_irq_restore()) to reconfigure the wakeup interrupts. Some drivers (e.g. Ethernet) may also
>> reconfigure interrupts in their own code, eventually calling rzg2l_gpio_irq_enable(), when these are
>> not wakeup interrupts.
>>
>> After commit 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL in
>> gpio_irq_{en,dis}able*()"), ISEL was no longer configured properly after resume.
>>
>> Fix this by adding rzg2l_gpio_irq_endisable() back into rzg2l_gpio_irq_enable(), and by using its
>> unlocked variant in rzg2l_gpio_irq_restore(). Having IRQs enable in rzg2l_gpio_irq_enable() should be
>> safe with respect to spurious IRQs, as in the probe case IRQs are enabled anyway in
>> rzg2l_gpio_child_to_parent_hwirq(). No spurious IRQs were detected on suspend/resume tests (executed on
>> RZ/G3S).
> 
> IIRC, I believe the issue is ISEL is not restored during resume.

Yes

> Can we restore this register just like
> Schmitt register suspend/restore[1]

The IA55 would have to be configured for interrupts as well. Doing it in
other order will lead to spurious interrupts while resuming. The commit
254203f9a94c ("pinctrl: renesas: rzg2l: Add suspend/resume support") that
introduced this approach, mentions the following:

    Because interrupt signals are routed to IA55 interrupt controller and
    IA55 interrupt controller resumes before pin controller, patch restores
    also the configured interrupts just after pin settings are restored to
    avoid invalid interrupts while resuming.

Thank you,
Claudiu

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250911&id=837afa592c6234be82acb5d23e0a39e9befdaa85
> 
> Cheers,
> Biju
> 

