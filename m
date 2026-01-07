Return-Path: <stable+bounces-206068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E46CFB7CA
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 01:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F2930274E2
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 00:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038F61E9B1A;
	Wed,  7 Jan 2026 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWDVB25U"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DCD1DE8B5
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767746125; cv=none; b=ULTSmo1oG23VFvllwnXsXn0o1BKQdDOX/qePu6bE00tzESv/LHhc/9KT6/iT/HYKHXyelf5end1KeT29h8kNVTrks1pCUoaAfuhkkSHAGI3m7W/vu0PUPEgCQUrHczozg1IzQD4MNleOtjw+mRqQsVh3CH4zyh3TW9YUD36O7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767746125; c=relaxed/simple;
	bh=SQHTamUMARk/4HeKk6tbOiLGG2s0CIDs2tsevS20n2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVCozrWC6zrByt21w0o6v4Giy+t4uaELbP9QJ3QJFGbpLMpDjanApVaeEEg+ggqHdTeukqIwo3T+FJsFIrkJUHmYkaf3ziWB1Y1xgWUFDk/3GdanuXZTtJXr5fWuXCiyWYQpqzJ/cTF4d2cxCaqPrZ2HtpDF6aDyU6j9PiQdAsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWDVB25U; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ad70765db9so1207778eec.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 16:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767746123; x=1768350923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fVvSiMXrQw7tIv49SNAYxvhVw8Ed8hsijayWkxWyGBY=;
        b=SWDVB25UEaAGBbaLoT1Km4djzPBueAAtnlxLuLiuGKDVR3MFnWiUHzSKuoYwI9gsUj
         L6nUn8iu5KIUESM3a3G2szWV1ElIZRSro7U9Oxf1uSw5jmKzgoFc4HrchMPZVX1wxqK4
         znwmrhvb6WcOAoijbwX5TmaDxnhUPKzHuug+82xgyHfHyWn9x/dAEaxPwoUCpRfLKHO0
         P0dW2/aYDkqjAv9cvLKcDzRn4CzijzPu/d1ggNaYVKl3D4FNU3FlE2EqDIAPcCzA+Blo
         X/5/wqI1AHJp4W/udi6q81vncEqYNkyBVIdAtkkGIbIXxi3S8qbouSTbfGo9tonZO+7e
         jYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767746123; x=1768350923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVvSiMXrQw7tIv49SNAYxvhVw8Ed8hsijayWkxWyGBY=;
        b=enSRfJCLo8kgrowQKsZKk4VFHgfV598HNjM+e6yQ4QSJpnSU1sLDtoZhcV/QdU4FJf
         gk7yqdKt+tSaCqDFjjLKybqk2xhoJArY0LWHc6IllEhXdMa/h06bCZ8/GpS5p9j+Cffo
         QFuVQ4KQd+6Z6vuub2vgAJWydd+2IXkeFX86BDA54f70gpeZi2KLKlwe3yRpoxydUglj
         /vrz5g1PcO+O5yfcTu9y089wGaW/K9TtkbiTvHYFz1tKtzsDuABCr2dlWDy5jS31XxEZ
         /pPb63qDa7GMTuCKwFi3MyZ1Jx9L34rEXok6IbqAU4FnzjSEoTgKK7Os3RboJtywUTm9
         cn3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEAyVPKA7YDyPx/wVQD+LjGgSvinXQiXK7AslADoB8lF0M6X8rWX3St4AroW+AZGpaK0qxTUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwoju6n0O8bVeHS75kQfjKHjFZbUoRKQy28c1DUTtzX2iFkNLm
	2XJ4r5X2ggW3uuVc085RtMdhXvr7m3xn4SpRwKzh6gCzjFJf/XBKjIYT
X-Gm-Gg: AY/fxX6G6dVpwJPCizZN7xE0b8u8CdqQN/Kd7JFjuLpt4vEqsPM1gCbHZbYkl6Qs6bJ
	SVf1jt6Wb3AIhvdgSWrInRNlT3WDY5+FvZiPbbKzC8mZzlzAf3skclrplVJdCbgkjAJ/cUxWW3L
	zG0G1C+1nHBX6iI/NjAVQlOrRFdgL7bJFTQXyp5Dq9A3jFPtMVIaSgwKv2TLFrLvx/ruFh3S6/R
	nNhEz3yW++nEfV01lhpOWy+1TDdZr+qSYU/YF900qffe1FiW6SdhfVwnReXDWW1G2CfAmYyjNs9
	YaiOJM1NMsHTD8bdWWvsWymsG8XxSUc3JSMh7KQ/V9ZWI80i0qU93SDoGzL3TYfcfbaA9B9hGOb
	vli1Gfm5mTPyVzi9GxdeQqv64iDQjsCNoBf9aeaHLUuo9lJAVO2BUx42AEwOPvTFX8sXIvpeG17
	7ew+5x4rizdk4ZT5WzWITGOQn1flQsG/Z07RyURA==
X-Google-Smtp-Source: AGHT+IGd79dWHwptBHXu+7I49Qt9sJ+A1Cod780f/7MZ6LCroa5lJhgJ6S4GXKD+cVkBXrNiBlbG/w==
X-Received: by 2002:a05:7300:bb07:b0:2a4:61a1:c0d5 with SMTP id 5a478bee46e88-2b17d31c9bbmr834642eec.36.1767746122486;
        Tue, 06 Jan 2026 16:35:22 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243421esm8099217c88.2.2026.01.06.16.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 16:35:21 -0800 (PST)
Message-ID: <62b3574f-a45d-4c1a-9707-53e391b5f5f7@gmail.com>
Date: Tue, 6 Jan 2026 16:35:19 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/567] 6.12.64-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260106170451.332875001@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/26 08:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.64 release.
> There are 567 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Jan 2026 17:03:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.64-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

