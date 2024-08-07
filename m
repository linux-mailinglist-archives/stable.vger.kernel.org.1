Return-Path: <stable+bounces-65967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC36294B240
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 23:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845541F2240C
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 21:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970FF15099D;
	Wed,  7 Aug 2024 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gFZ2/WDM"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFADF1487C5
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066678; cv=none; b=QGfx4OKaLghXoeousTmDc2q+t2GiVnzeBLy63+lpMZ1ZVaIAQKrn7ARngSKzQ8iPqSo8vUotqjRzY8zhv5IoantZ9M80x4Fu0KpBFTwWcE02FfpVsYKhjFnEHKfKHvkFcocUzv0NKGqXU2vPktqn8hv+i0NqeL215RVqnrV+HF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066678; c=relaxed/simple;
	bh=bPAE0jN6OxJyf1bhY509issRR1SkVegadOe7o/gDdwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2wFFVdeQH2Lx2WTroj3hECTCIyzLq07jNvyryiSED2veZpgytzR4E4BhkAM9hcKcfxpGkwHuu/tufQpwpTKM3XZED4bYWEnyiY0WnRMwYelW9SIXf4TyGlmePIMVOoPwxUKSaVUD64SwLkFgh1vPBW9ahaNO4EXv2jKLMy0EkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gFZ2/WDM; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-81fdf584985so1348939f.1
        for <stable@vger.kernel.org>; Wed, 07 Aug 2024 14:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723066675; x=1723671475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aL0UiaVBU0BhpVk7/KjwpvAladn9QhUC4pdvjmsQDOM=;
        b=gFZ2/WDMb5BHsT7KH2D2XOgMeUSebIf/B9RR7fSf4UnCpu9I/mDTP1pmzmVTDm0kEO
         ErDiwLcACRxk4be756Ubyf5BLuHkDTJ4PHuxlgPtqmb5TxAGyqWs1fwZYC7fCHS2zGR3
         1EzYBAvFJFZ8ecPJ21qguF1VWMDsEsOkyqOS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723066675; x=1723671475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aL0UiaVBU0BhpVk7/KjwpvAladn9QhUC4pdvjmsQDOM=;
        b=vleMkgvyMJEfefrbMiL6RryMRKHUj2vE09EHqCttPf92+tauPimghFJR7q3zssbwAG
         C9wSOS2sjx44hzzyDZ6UYAT+twWtIAIDWclIjsQ1S2wJbno++WBa2lnPOmK0SscELtWo
         o5HuNwJf6OvnB5HD3sgUCA71JVcZ0y8EdYW0eOw04R9kbx+y2kUFAh6MsbaM+Tu2l08S
         nsf5fVZSkbBEZHwBj4HH+Wav8De81asvCHV8oE23ErCmb2ypuamyo9wHx4xdHJQuvzPG
         +Q1KAd/jhk+/tN373jPQMqYhMt5yG8pvpsfA0g1bQAsv8r672SMxrpyFoM5sGmX8qMfw
         m70w==
X-Forwarded-Encrypted: i=1; AJvYcCUB58OvnvSgxlI5k8LrNMXpHAqzOqi4g9/NXTVbDobfGR4tmLFIGzWtRvCpW0/hn1LwPHe97ADo+oIVqTP5zFpiA47c180p
X-Gm-Message-State: AOJu0YyJ0leHej28euGOlFt9LrrYjWb4L1DQDL/IPj7N4CDvjaLhww3j
	sed9l3hKD/mlfwitpLFGBtTA9TGL+ZazhTPc8Ir3DWg66qTBOFhDn0kN+m2aNl8=
X-Google-Smtp-Source: AGHT+IGVMtn7MiaIscoViwTPglpD4M3uStUn2uXYBT1vHi6PGkJW0BGpfdtdKAqOky58jq7XY8dxxw==
X-Received: by 2002:a05:6602:2158:b0:81f:a783:e595 with SMTP id ca18e2360f4ac-822537e8030mr5124339f.1.1723066674772;
        Wed, 07 Aug 2024 14:37:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a34c01sm2989918173.119.2024.08.07.14.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 14:37:54 -0700 (PDT)
Message-ID: <045f8971-09a7-4b9c-b753-d991acb6739e@linuxfoundation.org>
Date: Wed, 7 Aug 2024 15:37:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/121] 6.6.45-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240807150019.412911622@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240807150019.412911622@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 08:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.45 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Aug 2024 14:59:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.45-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


