Return-Path: <stable+bounces-180466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BE9B826FC
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 02:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC107202C4
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 00:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B802D023;
	Thu, 18 Sep 2025 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Xvlx1QYh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D542612B73
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 00:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156459; cv=none; b=ZUDbHDH3aSewwO9u7iftiDqLHIt114Baox6c6KVBZ5PRzf/4PoNHk7ydeWSeq/JBv1x0xy3xGrQqcUHZkEukhnK+KIzA4Z79gkWwlzQeB90mHfswWHZoGT+taxJoMonHdQ6XQwSKcPWPSzD3lH4vklVTLvxNYIts+4GcnbRGLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156459; c=relaxed/simple;
	bh=IrbF+vK94gpu/ozn7Qtd6NvlKSesxn8hE2qZizKldxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NROX7uc9vRx33psmw79DtuUHIuCjs69VjCbTsilgW34oqdvAGK9wQTLLdULyYgCuzL2lTpbkoVx+AUTASOjg8bNsOqGE7TqcEkaE7mwNtMdkvzLNys9nsaoNifjim20x+abTgC8UeAvPJmA/NYPCzewrCSNLcVyy94eeGDvjK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Xvlx1QYh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so2161255e9.1
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 17:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758156456; x=1758761256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dy3po34F373z2LL6aW/ho/h2XKggLTL7CNUt6WWnkWM=;
        b=Xvlx1QYhwouY7GrnLC4ddxEpoYmHruCJM6XA47zzQZIpxhkM8o5W+MY1AHubPtTZ68
         Jn+LlqYphah1YKP6on77LaWwWMKLBGm79qFyPx982SbqySesvPLNG4R5+Puvs2DiRhHs
         AW8I+GjlyEL61y4oacfQdwOeVJFcmnEPWNiNLldLMesEgeCrsBskrRFHYfmZ37AA2MiM
         0TIjhItsjV4XUORSKslLNr5ai/lppRsd2Wr9bg8XLK6268rFwDS/N7tJ2BOSmm3lsS1v
         nO+sOJ5z4m+fYhNB/X4ItJvPzBQYIxn8tazRbBhf96gnjDT5ox7dE0FBGRzyXw8f4imc
         pA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758156456; x=1758761256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dy3po34F373z2LL6aW/ho/h2XKggLTL7CNUt6WWnkWM=;
        b=XD9nv9igxf/ypx37HfoyQJibV+oshQIFX7wyKvi+rBTyIr1pasLmrMeReiQ0O9AWh0
         1BCNo5CZSNz5fHY3vINVWu6TE9lS+l/exC9TGyA7qFZQApcNPW9/1El3M1Oz5c8sPxUh
         3GA0guymWJ/oVTJDJpetCgGIm0/RarcOqNKDLmcr0udW5TbdZ3tyYSQnqMIbQhhDVRzS
         E0wn9vAzqr4xqUPvCIKN/KNcl/eGdI0xRes69fgkPPEYU21Wb2D1QbZHPD5U7pMS6A1C
         BI90hlTckEnbWsOd2rsRok98YD5tCBL/duK5AUB6OzHSuIHe4sIAF4X+5+AohuKGG6wZ
         Ikog==
X-Forwarded-Encrypted: i=1; AJvYcCUZJT821YkTfUo1lPCBL+LFcO7TdiyQ9UjSY5dYpAAB81m3V72MUK8XwqNeqk8iRVdvuw6Vf2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqDs1ZK0H8mDOZQpoqh152G4uf0RrWFwxLwH3ecgy6erETlMt
	muRTLKdLHbR4PRYS5fBC4ulWlIBPUMJfV9fYynlM0N1vyW8oRYehF74=
X-Gm-Gg: ASbGncu2EA7pfnoY54IDzOuNZQZaC/B6z0F+85lCacFWGiLdEsFgjtaJNW9OJo9upAk
	ms9konS6370yOHAzyuKlesSfcUvURM4wKexKo8RJDrtzSk/6cBM6sJVznkY8pjAgI90g49nm2QI
	sp1ATMiQ/4wqmIwGqySi0+Au1cVYQjujgs19+2sfsHJL2DWg7LX+XdgHUWk4Evy0kA4uIk1SWdF
	XeOaNrejBBtZORH++XT7IUDHG0VUNxeFD29W3BsaX2vNODdpcxO1jJY11Kqv9WKURrcY2T3fTn0
	275V9SxD54A3V47WrHqxweyTMM8oevvC7qfC0xO2mt2R6Uy1jgEKeCRosXVguavupMeEGF3PuU6
	NivbTdxgr3iL7cYae+xhR418zOTOQiCu/R/C+6hP8oBrcOMzTWiMlJveVBYD5//6jE6FI3F8c6f
	tzgLQp0cfJPf3ZsXYoVA==
X-Google-Smtp-Source: AGHT+IF2GdKlp1Cj55CMvxh773K38LbN60g3EFJ2JiKm4A5B9QL/on7+DP5zXojEycCtnsrb/d1cTg==
X-Received: by 2002:a05:600c:1993:b0:45f:2cd5:5086 with SMTP id 5b1f17b1804b1-46201f8b30bmr40989045e9.3.1758156455984;
        Wed, 17 Sep 2025 17:47:35 -0700 (PDT)
Received: from [192.168.1.3] (p5b2aca14.dip0.t-ipconnect.de. [91.42.202.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f320ff272sm48908065e9.1.2025.09.17.17.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 17:47:35 -0700 (PDT)
Message-ID: <b7a5110c-42b0-48f3-9a68-7681ad588142@googlemail.com>
Date: Thu, 18 Sep 2025 02:47:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/101] 6.6.107-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250917123336.863698492@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250917123336.863698492@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.09.2025 um 14:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.107 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

