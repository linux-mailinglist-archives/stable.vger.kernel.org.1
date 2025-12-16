Return-Path: <stable+bounces-202739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AC1CC5415
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 22:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD7B9301275A
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EB433C189;
	Tue, 16 Dec 2025 21:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5l/k24t"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DB21CC79
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765921721; cv=none; b=nwX6AunN42dMOzDadnIR+TWF6iwOX6l/V8fh02GIPTjOLxy/Y9ApDokjuBu7YbW+e8dyrR7CyP0Gvp14g27D0x8LZWhhn6pOZcnA0mmVPtKIiZzENnt9jeNy+JUTukSXgVrBzKdDCfjBcqXH4LT3FDSnjwaMny8qM4t85svkwn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765921721; c=relaxed/simple;
	bh=I3khe0INvGbPezO8MZGli6eEOt5M5BEU8F4wdYbG+KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUk6qG0805S+P9jeI8kF2nFPCskEw0OVJSj8UgUsBu5A9tSBYUVQ79qKRL2fXZv/sQ1/kickJ2LSdXKiwtkJD4naw3sQzQgHlCPl5qk94KKq6YN+5veDRQxTGQp0z+27Kbxgjuvs0l+Ys5Ez+u5BZrwzZF9ZMyReqryjWsFEdzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5l/k24t; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c84ec3b6eso3335190a91.3
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 13:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765921711; x=1766526511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMTHmxf1vh/B5qiF+nhjuqwN+fGfM3fi/VSYaVSs8Ac=;
        b=J5l/k24tH8AR/Nj4SrlXOYNTa+VGUhvV8OYgDL520wKFqE1Pkkn7YVYcgdG/k8Oj74
         0mMEfTYs6HKZFKqjGwXFOiqWi0t276Uxv1twAa/RfvJBe6SbZ91swXI8+RSEzrX/xns1
         8EbN286DGDFSeRTM+vMx/nT2NbuOWI5q60ukMeuJkzb9/vob7r1O7BlhCOjs8z0rp3B9
         bmCul/lTIIX4M5RDXY8J38m8EahZC9kh12zYhSCwZgJMRVYSR/Nio4t8tUmL2/YbUIX9
         RJLtMlXkBvSpctq8lzMkYpy8vaNl5uttoXZ3lQPeOR2t0uL8FNCsL5Hsa7oHaAP7z2qF
         AV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765921711; x=1766526511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMTHmxf1vh/B5qiF+nhjuqwN+fGfM3fi/VSYaVSs8Ac=;
        b=utIyYnf/4YkjfXULeuvcK615tAEKS3NCymEXqBmA15xXQ0Iuqopf9PvvCbFhMlUlRP
         OIYd7hXOAfhMgroOZscmUAJ0cEmaihPfa7G7XGSMQ+e83WLWSS9Duha4cSgCBXmYlfQB
         f7HKauwQKzP9sVIKFWIq+I8HtjAge+P0OJj6/Ov6mlAyrn6zvvswWKeF0Gk8fVf9ZjbC
         1m2T/f2S1kfDIVEQ49ZDcWCn8a1aWHFqPljpn9RjjWfTtxglNcLAvPbT/Jnk5/JvT8md
         Z3V6o1zmoBGHnvs9ZnJxCZ84O3C5NAxuWquXpM1OjhUtR17MP43j9upbjzlmxwQGY6Tj
         b4OA==
X-Forwarded-Encrypted: i=1; AJvYcCUu+uMs/NRzA8vx4zuwyRx5No5wWX2hWQFYaM9zQHNaRSozUKIoD7uSbEDVicDtoOU6oJT9Scg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybGkCpV2Iw1Ewb+8TF/nlPIgcicFavq6WXDS0IzzR6kjwwXJHe
	xz26B81fryC06qh52Tf0NInHcCBdAB/9VHklb9o2YpJFrDQxixU62hNAZGuoEw==
X-Gm-Gg: AY/fxX61crSxBI1aa70FBv5uphrV7WJ+IhKgG76y5eotqBs5PcAT4hIwcazL6TPyRma
	C7WocaXw6AVey6H7GJ/nO7wegqqrmIu23/8pOt78EIiqc4zb2xk7cjHNHckDYrY60exEJywPRS3
	RYODQBTEbPQQ/cHjz3DjEVY/bA43v6ZWYxfv1+26gN26MVoiufTWRd+OBURWY6y6XYXz13RD3bD
	AH8NZqhHApZtrQo+Ons3bsipnAgEY1hXRg1qIzXg//DyoX31B2eJKp2Ez9wEw8dFkgUNu6X5pcC
	Q3YzxaoY6fGJ1HvlKWiY9FC8qHOabjcTreLT1Zk5pkcwMOdjZLgh9OaX4KcjssL4HFb5bxQj25N
	ZoGrvmiw78c+vM/i9b0a5a7aqUg/2nP9voOgsawxF499aNyN4F81y6VN/ljJNZ5Actb53IB4oSb
	6pCh/c7mLabVYHRYI8b9riGG/EiVoFfRuY8wiJKw==
X-Google-Smtp-Source: AGHT+IFOlKrP5dymtFfEhr+JD4QtZshAYy9tk2jSUN52Wv1Dnrw/OYGy8yUGpFmBSM94R3467aMp8g==
X-Received: by 2002:a05:701b:2309:b0:11b:8278:9f3a with SMTP id a92af1059eb24-11f34ac5418mr11887492c88.8.1765921710596;
        Tue, 16 Dec 2025 13:48:30 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f461a0ad4sm15625722c88.14.2025.12.16.13.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 13:48:29 -0800 (PST)
Message-ID: <011fb0d4-bdc5-4997-858b-466a381a21c4@gmail.com>
Date: Tue, 16 Dec 2025 13:48:27 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/614] 6.18.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251216111401.280873349@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/25 03:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.2 release.
> There are 614 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Dec 2025 11:12:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

