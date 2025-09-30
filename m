Return-Path: <stable+bounces-182023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95436BAB807
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 07:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1BE1C48F7
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 05:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C4C2765C3;
	Tue, 30 Sep 2025 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TI4uSpQw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E635276050
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 05:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759210403; cv=none; b=U3khWtVFnLOhxJRUaIPvhrZficERS2ooqF4fSXG7WlUWMpnXsu3G5WZzyOGf2RMN3OVwVAc9/N2RXah8VpyEhpuTv8s3v4O9P1Dqxlkdih9SPBCoFX1jOsL9S9bPIpPPytr7LOLrnMAsnkGHKVikh/NHSo7bLI9B03tqzc6f5IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759210403; c=relaxed/simple;
	bh=+zYHcq1PnJGmU//SbV0gpmoJSYNqd+MwGlmrpbux8Rk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ukiCq3T3mJhrCE4LNS+ww/Mw2lErTvwsl0YnKx0BV0qWPtNNAPwhi82ZZ3+5wfZRPgxyJ1Je9OUySK84TTxuexJoDZ2w49WREyddO4JR1UnBVo0O8asqGiKHWdbia2c7Vh9OKt0GbED6D62ydwY3mv0v8NyIkWy2R+T27nCgm4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TI4uSpQw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so3211198f8f.3
        for <stable@vger.kernel.org>; Mon, 29 Sep 2025 22:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759210399; x=1759815199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RcKZSqsNCClUnXNLZ+VWODkqJQUd67st9xIuGAhStQk=;
        b=TI4uSpQwWfQKYiW1tI6/8kA5Z+W7OMOqi0a4zllk1q8j+84RD0TwN0Du9UKkguXWhO
         W76z5mPf5mURJ4ve7m6CFUL+1+UsRX1pLFNYCGCwo3SFu01z3wnAa7RMnSU9BICyKlwO
         ld4kwDoZEKgwKlSsnd9aGwUYu82qT3Iho1o+MtzCQMBzgVs1uqg5u3ukbs5ZPNPGNodb
         543neIkoKYOqLzvovMx5dWX6W7EHk5etHpXdVKHjH0jlEYrqJXmnvgrsndCmaHc0Xjbr
         jf9IHBQDX6BUC8KxoEkh0w/TJX3JwqnHOIlLZNgtum8ys1Mb2uOlKF8vBz4ICzOSZsa5
         OtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759210399; x=1759815199;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RcKZSqsNCClUnXNLZ+VWODkqJQUd67st9xIuGAhStQk=;
        b=V2BLfK32eQiXkP2xytybPpzZMeMJATWVpC+NOPMF/RW9RfJ9TMM6sgJQEXmsPHZvX5
         TGLABO0sZ9mqm4/hgNecA/3yMjnh8kG0KsjNtyrEda00UkDoV+zleJZvu37S2lUFg5Bc
         wEzAY0es1ljGTC+5eN2EEQMMm8f2jVcYbjnU/VZ+bHXtvJoXJsg8TYje1Z4+th/Wamo6
         o3ftSZvmAt8mD7B4iCSDXrDBJI+Q/7gk7rt8dg/khG346GT7mNqWMsHNT7CRSfc30lq/
         X3BH+XqXG2j+yQ0hK/rZBpHb1uPGlfqF2aS4VLgqot2PrxTWHvphnwEgI9DwvSa6EAF5
         4mow==
X-Forwarded-Encrypted: i=1; AJvYcCUf3+jAYnjwtKQIiNt1DXJQsMxgmiYUdE0QGYMLpREcvdoZflRdWSDYwhS3AlexiF0CoEbz/T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTh0wmdJsf1/Q5sWJIAnVE9/410cB2WgGHotpvgVcX8OBi2Dcf
	odSnc757+0mFN/sSzzUQsRPEpL+fzzDQLoPpf/pvGLRcyjBjCWpqS7w4P8GaQQmGjWA=
X-Gm-Gg: ASbGncsuEioJEPtd46iG8NVBZxuXMyRkHGemGjq0lJ3v/Fl9od7X7jktIsWfq21hgsK
	g+AxJQ8R6xxoN8TUKjimK8McfwOcliLVmvdi4MuxV4FLmC+AX8xmvifwInZQI9MbIzd/TWWXrMM
	2PNashsB4SvhOsnmhHyocFzSvS9xprYlTGj2Vta+YKFTciB8SLCMB9+f7y154j/A9tB2oBMbibw
	1Ff7whUf6Imb/yPThLSo5KRYA5gmF/mej1p1RDOrUIZ9ZRzGCjRIVcwlGij9b0KgJ4/pLETmMk3
	/F0vAiHnSiHOUv2pbu1sMj8NT7gpYehTHT9Ou+RVgF7F1pZO/HHeeoxkrC3OaDa7LBnfkhUBTp1
	HiRQvTbUx2Cfb5RfOOu1ZMBBxrI3Lt/r8rN35/fKG9szLZz06h+X34Yo=
X-Google-Smtp-Source: AGHT+IEkueAS01kFVAoXd3MEH9FbKcaIHwo56QQ73i1m/EjHyO0vo1fWE9up8eTSOW6ZhEmF700+iQ==
X-Received: by 2002:a05:6000:400a:b0:3e4:957d:d00 with SMTP id ffacd0b85a97d-40e4c2d2576mr17438762f8f.58.1759210399124;
        Mon, 29 Sep 2025 22:33:19 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc88b0779sm20750915f8f.58.2025.09.29.22.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 22:33:18 -0700 (PDT)
Message-ID: <2bd09757-cd66-4a2a-8801-0f62dc99b9c8@tuxon.dev>
Date: Tue, 30 Sep 2025 08:33:15 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: renesas: rzg2l: Fix ISEL restore on resume
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20250912095308.3603704-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXv1-w0SE7FZy5k3jg2FO-a-RB2w1WB=VM_UFEA9zjWDw@mail.gmail.com>
 <ef82c610-0571-4665-a5d1-07a9ed9fb8d3@tuxon.dev>
Content-Language: en-US
In-Reply-To: <ef82c610-0571-4665-a5d1-07a9ed9fb8d3@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 9/29/25 15:10, Claudiu Beznea wrote:
>> This conflicts with commit d57183d06851bae4 ("pinctrl: renesas: rzg2l:
>> Drop unnecessary pin configurations"), which I have already queued
>> in renesas-drivers/renesas-pinctrl-for-v6.19.  Hence I am replacing
>> the above hunk by:
>>
>>             /* Switching to GPIO is not required if reset value is
>> same as func */
>>             reg = readb(pctrl->base + PMC(off));
>>     -       spin_lock_irqsave(&pctrl->lock, flags);
>>     +       raw_spin_lock_irqsave(&pctrl->lock, flags);
>>             pfc = readl(pctrl->base + PFC(off));
>>             if ((reg & BIT(pin)) && (((pfc >> (pin * 4)) & PFC_MASK) == func)) {
>>     -               spin_unlock_irqrestore(&pctrl->lock, flags);
>>     +               raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>>                     return;
>>             }
>>
>> while applying.
> This is right. Thank you! I'm going to give it also a try (on actual HW) a
> bit later. I'll let you know.

Sorry for the delay, all looks good to me (checked on RZ/G3S).

Thank you,
Claudiu

> 
> Thank you,
> Claudiu


