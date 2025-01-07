Return-Path: <stable+bounces-107915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8288A04D45
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 00:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7703A1A8F
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 23:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01DA1E5711;
	Tue,  7 Jan 2025 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Aq3YE9pJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829741E0DE6
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 23:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291700; cv=none; b=sL9dqlWuCza3kWBBlmq+klY8/d+AfCYmqDUiZl2gXh7MELRBUhnDBIRMb/wB7Zto9n88gvCf4aDjZljtOrt5vuVh804oEz6r7Od4ew8crM6mJqs478I5pVc/gCn0qhkRcB+zB7KCNHTV15rGECDcyRqrEUQjubZiWI+10kpqfbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291700; c=relaxed/simple;
	bh=BjKKH0vGpUbV7AWq3U1V5wNomw+T3c1zTcany7gp9zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUrez3FwIryJOAD6NHgYY2b9pQA8ggEJQQqz/p7VekKjABzrXIFHHy5UFTGX/R2QRDk75aYYpJKos+xjbCf58LEQ8toP9VQaUwKPUWHMOhgLnSnpkhfUeR9op6hjkYMOXu13juy19DYTF39JxyTZEtiCAWSGjTxxQh/kCJfVQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Aq3YE9pJ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-844e1020253so626231039f.3
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 15:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736291696; x=1736896496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OMG2k29doqK4b4RNK2OGfEYP4wm7KC5LacWfwMa88uE=;
        b=Aq3YE9pJ3Csamf8uxurYWRJceJFdByLZ50NAX+ItRvtY3G1OdkoA0P7lfLsGPWYCF4
         ljLuuI70/fTZDwcTbI0WdUeAIfepp5h0EbEmNRmP658b1a4+F40DaalViVYapZPX/Ecn
         xY0IYDmw/qsGE1R5EtJ6rp52nLSS8hbOxusl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736291696; x=1736896496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMG2k29doqK4b4RNK2OGfEYP4wm7KC5LacWfwMa88uE=;
        b=IOC+uIJG2kYl1G4CbzikxL0rw8olZ0m2r8HEiHut8We01YfWGDzREvd13MU4rpQkzt
         LNcohWS5HplNZHFIR4G96apWJ5BdTnDAP7LqEgFsERM15EQ/zty7ggLSoFKWlcaQd79q
         7uD0dWSLTO0o2B0pYs1Em8E/gK0Un2wF+6OKLVgu6QhDooxYF41T8qo3O0Fy2H3Lxw49
         GZP7i9FQAK4sQyJm7iq+DeOhzJRgCLmkE7tCxJwUGKf49pKvq6sFAF5D0SpVDdZPVtjz
         CkVed8k/nBHj0oj1eT5XySnOyNdq6ApN3sZkWu1fNyZTCOO3NknMOCurixxGsGZFCwJ4
         fWgw==
X-Forwarded-Encrypted: i=1; AJvYcCU/ZY+eObZODP4p5S5RWoG6uY4r+ledxM7rilxcP2nt9btBGZznMcqBh11u4bcH2O63pzHKIAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFnXUgxJ6+hxEua2mLHDe8qGQlsFsAhs0yqnV/VyMUcTZeyImA
	vQnRlPRS9Sz4gmsl3yKPcbvyw/E4rGnLzdTWMw4XbMqILsS8O3yuWH/JlUl4OhM=
X-Gm-Gg: ASbGncujyWHWLCpWdgslnNozkbabgREkCLqIpKunsviXJY8ukQgQoXy5tKsW8FSY5qX
	ZJFqffnQfEYFa+Oy3pW/oN7w0eVbYqijzu3C5IvxxS4hifbaErUXU/cAGhQR8iP7wsACl8HWP5K
	R/cbHe+AupFN8fSLuEGsgyiXVWZNK9du/fT8VWd8jzqBta1TAOhU3BKeTcMX/k64rpc04ZXdMbR
	iRWhrX2OEuYxa1lHk3b/bNe6bgNG0FCfz4PCx72nCamKG4MjbA8xO7M96qUEvxEJHw2
X-Google-Smtp-Source: AGHT+IEhdYFsphyMJwmUVBiBfw2T+7bke7tQB4guyZXOZBr/m0Kf//ky5qWxoeZ80D1Scq5qTY9MWw==
X-Received: by 2002:a05:6602:4c08:b0:835:4931:b110 with SMTP id ca18e2360f4ac-84ce0081db3mr91795839f.5.1736291696579;
        Tue, 07 Jan 2025 15:14:56 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c19990fsm10229964173.80.2025.01.07.15.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:14:56 -0800 (PST)
Message-ID: <c59a9bf2-efe5-473f-a8c1-c93276df7fc8@linuxfoundation.org>
Date: Tue, 7 Jan 2025 16:14:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/156] 6.12.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250106151141.738050441@linuxfoundation.org>
 <5c3ac106-f18e-4237-83ff-52398839f635@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5c3ac106-f18e-4237-83ff-52398839f635@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/6/25 16:18, Shuah Khan wrote:
> On 1/6/25 08:14, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.12.9 release.
>> There are 156 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.9-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
> 
> Compile failed during modpost stage:
> 
>    MODPOST Module.symvers
> ERROR: modpost: "i915_gem_object_set_to_cpu_domain" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
> ERROR: modpost: "intel_ring_begin" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
> ERROR: modpost: "shmem_unpin_map" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
> ERROR: modpost: "intel_gvt_set_ops" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
> ERROR: modpost: "intel_gvt_clear_ops" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
> ERROR: modpost: "i915_gem_object_alloc" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
> ERROR: modpost: "intel_runtime_pm_get" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
> ERROR: modpost: "i915_gem_object_create_shmem" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
> ERROR: modpost: "i915_gem_object_pin_map" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
> ERROR: modpost: "__px_dma" [drivers/gpu/drm/i915/kvmgt.ko] undefined!
> 

You can ignore this.
Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


