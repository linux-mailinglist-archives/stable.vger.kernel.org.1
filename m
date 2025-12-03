Return-Path: <stable+bounces-199903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D57CA12EB
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30DDF301E228
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923AE33E35D;
	Wed,  3 Dec 2025 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5vGSmQd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC93933E355
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786600; cv=none; b=TSascRClbUWLE0ayIvcLF6DAgOIKpgXkGDffcixu+O+V0MmQ34nlwkHH3c1hs3jGMT+BwnzQgseiwBF9ud97n5FLGZpx9qTW7bwJXm3+M7rOvtJV34JRSUbEKvP+x4irbK+43fMd2KgeCsRAxQwRgMfFDwyAWnB+jLE+3gtOpuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786600; c=relaxed/simple;
	bh=PluX3wdObdNX1HiZ8k39xSSiuNhuCbc+SBesJzZBB64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSYK2Ut+U8j1WrKvJ+UF6KTuaermqm+jElTFb0BqUuZY0PLq3SOQLebhczODAfUMmJivb5p4W4dW7lzUICwy/a28tQAR/w5feGBYYgElOEo9JDBSP8m9dgUqkufqJIfjxLv2zJxmS6oq9DO72kC4jFgOupvDuh0Kb4AGQdC9O3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5vGSmQd; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b2ea2b9631so1644785a.3
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 10:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764786598; x=1765391398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VV4t1NW023cvwTw1rbmTo/1U8JjaBfCScs6Ix0NDmA8=;
        b=I5vGSmQdRpPPzSNeZpM4U1YxBy5eJTjqSXazI7Kim27M3PKeMv/rTZAp1P2GS3k3OR
         AJGwMbVS/NV3MEAVz1IRBHFvDGpMk9lAuiESCk4JaKxuCR2n4B2jMdE7YM1FBS7NBiqp
         7ggb3B8JCCxIZQVGfbf/ffAZvghYknr5eRQJ1FD1s0QmQt0qBhNwGYGasvlYRApGkSAf
         zMnxUGtc6CuWniboS0b+H7pwjXaKr6Tv06aPMBorGhqE9wMBZs7l0mnY8b4g5XsEHFCw
         +/X7NVb05eywMkXedOthhSVHmJqf11JsUjKCZADhefBkRX1J6QHulr7NPnE6mTX5HFI9
         60rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764786598; x=1765391398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VV4t1NW023cvwTw1rbmTo/1U8JjaBfCScs6Ix0NDmA8=;
        b=npy9mvTDRXC1s790A0MUZnXm0IjXdFyOKyIr5mRe3VzzZSmvT3iukrSeCT1BKxlkCg
         oi9Ga5YCXXUNRey5ReT+jjAs+zXg/tqTiNTpGmMFA2q4vdzl4Lx+h2xUqZmmLqaKSfpX
         OjsVK3TRCcdBDm+aK2xVFNQtWlngkhetXK49Mi6x0F7hXx96kcYFOEA88i2JIJefCVFe
         iiH1wIHLP5Qy4dEB9TdQlWgMiwkRl+Iuah6Uq0hYrWX9c3kyjLN4SOdzIMeiy/1FgPgD
         C2z0GAD/RxRTqClh6freL3KUE98HsUitQdExpe7Q1o3vfc+LEPfSH0Bf4GBPsPCOVt8m
         SAQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/LqwPI6r0uCW79ybHSB+UTOmIOgc777dtuM238wwJwxzUirBL74CEDvVMjxKIbOShyQ0gP14=@vger.kernel.org
X-Gm-Message-State: AOJu0YziF95n+NHV19F1piznGcVPIgh/HWTrTbZv2KmI65/BEP0iN9rU
	uHvoZLAz0a0UTnKvbI5Jm/zQFLCVz30o2gndJIW1Hr8uTliNZoM3n7UL6IK92w==
X-Gm-Gg: ASbGncuowtF23Iza0/JiAaZFACT5hWqN8DL8vRbJUcGknQBnY/E7K7/ufmvuYqQratd
	kEuv1mqHkaqxsnYyGVJLIoVl0YdeuxIUoq7odsguIefoYrQQ88IqWhazvrFxsDwKHl/yeDKiXEp
	pJgWmXnDiTuGsdwEZJ6tOPPBfy5ffJaId24nmr0mBzrFpnZbrfSQGlLtBSU3nEbbt4rTObBq+z6
	cIz1AlxlS30+F9Fuy78sfMUb/Kom3BpyzxNQJYzZv5tlSjBhglepN9JDXIh8RMRAvigG08xe8zL
	mCjjsi7LrYuZi62dvqec8wNnqcujWtu5vL5th6N+UVoN+7hqNfkUSFFvEOvZYrtTDwMrz4DzjYf
	jF7N93QWV0EzgZlflNtWmI51+qhYUId/3wMIgMNQ32PargUuZOT307PCx+bT4zsZIvtL169vLgW
	i/TyUvdX3HMXLMwdrIdKE83oIrCFNvIGHN2/JZyA==
X-Google-Smtp-Source: AGHT+IHiJ8n/50vlqbm1/NN3ThQqkkDO8VFXcQXQ9LLAOKP0PwiMkAgZqgZdrHX78YGv2Ll5CM/8mg==
X-Received: by 2002:a05:620a:190d:b0:85f:82c1:c8ed with SMTP id af79cd13be357-8b6181724d0mr10843585a.37.1764786597652;
        Wed, 03 Dec 2025 10:29:57 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b529993839sm1397870185a.8.2025.12.03.10.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 10:29:56 -0800 (PST)
Message-ID: <3591a9b9-35b8-4f5c-992b-84bc03297e41@gmail.com>
Date: Wed, 3 Dec 2025 10:29:53 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/93] 6.6.119-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251203152336.494201426@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251203152336.494201426@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 07:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.119 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.119-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

