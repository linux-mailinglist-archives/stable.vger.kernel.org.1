Return-Path: <stable+bounces-169297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D2DB23B14
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 23:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15584582725
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341E52E0901;
	Tue, 12 Aug 2025 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMJjWDZS"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9872E2675;
	Tue, 12 Aug 2025 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035247; cv=none; b=rHxfxRRBGpuTLJM76O+yuAF+JMG/Ly+An16o+RypI35XdE/KEu3Z2emfsfHyAIxgJsW14GpD9zUu/uzCvC08b8pDhW6BZ73FY/N1re6PBV4rKjwmUwf/OLuIMm52hDjHd7l3uWR2RY2K7k6ikWFoMNPh6Nwx1SA6JdHx2H/mXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035247; c=relaxed/simple;
	bh=hsaqDC8OPPR0PygLlB4gX/F0Mb9ek+K2IeeHeAGzOek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jw+MeT1UzHGkQatwi13IX8ULI8qUhdm+hM03ytdwQEyJbaMpr/lRmnmCry+Lkyrb2hW+Xrcecha2jK1LAXtrZpZcboLFMRZH4m0Q5Wy1DVLHRmbPpguDEfXTnjfLe0bNNpNp6obiXKiY5tNK3mVKbWqAuPXYHPj0JPaDRkU5AwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMJjWDZS; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-433f787057eso2980721b6e.2;
        Tue, 12 Aug 2025 14:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755035243; x=1755640043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DqsZo/0V3DrbiFJ1KYNqTCoRcndCD+0Zay74Kd6rwzw=;
        b=OMJjWDZSbJO2S5Gz7/d1ryO3+TVWDs/kMrfMIWw2U+g6emdbWaRVrNTXYe+1/awdkf
         uKE0aXzYgXH3GKLBMgcfieDq/O4OfUAmnr1kt1gSVBuX+Fn8BnCbbY0GhURPepzMFe6M
         G4W1sQfi6Z9VqtVrcUAW9hjSSNL6LaPQAjGhpYZd1lV78VRAaNKhJO0rjflksU7ANSk2
         8XrT8CF5ltKNWtgvGdaw+janPgMEYelaVj9O0bKegdGwFP0wjLLGYk7tfEecFcdxUmWu
         P4uennEOtY+UEU2cljz0BABPRokb7BFP3T6Uykc2XQl0o8bjoojuos5dE15m8LBp12dD
         wfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755035243; x=1755640043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqsZo/0V3DrbiFJ1KYNqTCoRcndCD+0Zay74Kd6rwzw=;
        b=rdAzUzUMEuzYjgK5IttoZpDyuFsCbsVwSyVnnfinTMt8mARzoU8UGGTqFGVbCBE1sc
         Doz9KrJLclsdVOuNzh/76NcsKnpykMpVouUJqLka5CM+dlqPzgDjhDKP2CMqmIE6l0+r
         YyYLGn+3ix38BSqvHesbFvAwJeKkvySOee39MHbNvLTWmDFM3Zw1aapoXVA6XF7L4Qkb
         D8+puXB+oKdORasEHvAuPFQK+FLvx9ZeTj7Ob5vGOp7LOY9YHH43tf4qje43I66W232P
         Gjvs0zP08NmkV/5uAOnLOItxcbODoWdCuDLl4/a/qpFC0IAIrqtKLpAL/kMWzixSch7i
         HmWw==
X-Forwarded-Encrypted: i=1; AJvYcCXKgJrdf2mC42luoNP8j0wPddcMDzbm+uxeUrZi7mgJaSMaGXGf+Q3Xf6lv/tN+dxkQDmt5XbBb@vger.kernel.org, AJvYcCXRB40iH2q4/1q2c3udbm7sqFNqmYF4V6AkVG/J1WSvsbF8C4AQS4Nuc25HJlhKVPDaGdkXJoEpFScCGIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCr01ivQEpUS1ChHI9UaB5mLSVIcehwqc04PaSBXuTV1ONwLQW
	IPVm5kDlQXdVf8y8veF4Rf4rUFoCzF8xuvP+tTS414gF0zGuWaQOC8tK
X-Gm-Gg: ASbGncuyffumbmj5vmLkKo+yPhjXZao+N42ROuSXsnpscI8Cb0FKUQuaRrPYeFgmYZX
	lvi3pmI1OE6q8LOG7KQt14NX7T5BzehnSBFnx0PG2Ryfil+2uospxIO9F3etSsdYJOiFvHXQ7b2
	7J5is4p5WV5uAp+UcqsUFcOj0JGEjoHgLiYhcHjdyfFCUhYj3jpeyFLcK83N4xVH93s9MAJXtFF
	D1mkOPQZspKJfakUuNjZZxJbpejbmDAZrhQbb471YpsFgbyiMckTyi1OxR3EFt4UqTnxmikZ+CU
	bcQ6nZ2HMMS3PwmnhczdXptJh8SLQQ/eGuAKewuGQII9ZGbdiGFnGXUS+1JhCmxuEt82tt5Nkt0
	JL7TdMUVH0I5TYfsc1fap4qvQitpAZQ6W0+z4CCfPXkql
X-Google-Smtp-Source: AGHT+IF9cUjsSFJiU6UBtafgV6gmnJFu9CkOBo9dXkRHbMOqAhT6sVwBWadWx/52BAuh/XOo7q6kng==
X-Received: by 2002:a05:6808:1821:b0:435:72ab:27f2 with SMTP id 5614622812f47-435d414d2f6mr638942b6e.13.1755035243255;
        Tue, 12 Aug 2025 14:47:23 -0700 (PDT)
Received: from [10.236.102.133] ([108.147.189.97])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce8efb8bsm372942b6e.36.2025.08.12.14.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 14:47:22 -0700 (PDT)
Message-ID: <d114cdf6-1aaa-4489-a75f-c519146dd371@gmail.com>
Date: Tue, 12 Aug 2025 14:47:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/480] 6.15.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250812174357.281828096@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/2025 10:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.10 release.
> There are 480 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


