Return-Path: <stable+bounces-194546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5906FC500CB
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 00:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 505374E6653
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 23:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2C72F3C2C;
	Tue, 11 Nov 2025 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VGaGDyMR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC362D6407
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 23:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903655; cv=none; b=OdKx5Xe/2gtrfqbEjIUwz3A+5Es7t5pu+tEowgM92uKiHFMb7MatybHbBWGp0BrwQzjveoTJBxXV56GTKBJuzJgzIaXxO6aKB639UXeYd0FGTcixOcjI/8L/ZnK6HijaGnITVhRBSiVO4/KW75kYuOISkG+LDMLPS0aybS46QAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903655; c=relaxed/simple;
	bh=IuR5ZRXeBEMrVUdIn/c5gPLOVw4Th37CLXfP2y0VULE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c7Wst6v7CzpgoTq9MGbQCS1/55Vkl4WLbiLoXYl8m1pk7Ne3dl9HKHVMM2BTvULsXn80obzlVAxVtUWGPjFc1OtitYa3tALYsqnWIKpRv8zYgZUYrWRW/PU3C50jbbZh84+e9RqnaK/bXrYGuKOFZRw7tPbcI35Vc5WG/NHvfQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VGaGDyMR; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c6e9538945so92523a34.1
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 15:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762903652; x=1763508452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9QgRZSf+qoN7+x7rLV1kVs/iEm4M3TDqxWUlp4O9RQ=;
        b=VGaGDyMRD6aButDGxKhqrpFaNC4Tx42IH+tc6tDuO+SxssRBbvQreZVHaftHULhvyx
         iKIOsa10OWkSk1aUwZ1YpTxzlEykwbYHwF16/SqqotVpp8/VbrtKoxJQ8kK51WJckSdB
         qU7alTRCJZ467+6W6Ya7lN5Psd/oi+KzLHSpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762903652; x=1763508452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9QgRZSf+qoN7+x7rLV1kVs/iEm4M3TDqxWUlp4O9RQ=;
        b=R3t0TyEsfpruf7VCgeQ0GIEIc8NTCckiuDaDCNRsKQPiHN4DBcnAzf4Y9fDH77ToIr
         NwM5zo5EU7+3ILKEjTgFFMviV6oPLqGcdyLXxtJjeGqM+lHWKEMEsVujvJUPqxXGpaWO
         L7370aaiVIAmcmpShPfPXommBq7wu77oMsurNhMDwwLIw8HqsXErMuXTWZO7FYjcpj3e
         xACZ3jP+GHcK2fPi2HRG3cIDxvX83qJhwWi/watYOLzSSD4Xi46gB8EAVl7mRknWhqtN
         bvPxrtLUPe94F+FDCURXoSIuU5GAiMdKi8+pUO24ehu2yGTmEqPEf0QeoYdwfFRxbzjr
         7mig==
X-Forwarded-Encrypted: i=1; AJvYcCVvpG83xvsz3vrKU3+yiG1bmQAQgPuHVvVdwG9r/HEXD6Cs4ZBPi12snu6YsfnCgCoV4d2IA28=@vger.kernel.org
X-Gm-Message-State: AOJu0YypYqyRgR2Q39nDFHzfcBxdFERqvUNBGxYUWhBQhYje69a/RUQT
	e2TXWWeIeUyi9fBvfZ7h/7UWTgZv+3m9FbR4YysFb2K98WpaPL9ehMwRggGrdFzYIQQ=
X-Gm-Gg: ASbGncsaHkHpEPk9Q9pVqvkcrJji+vjpOilcI6PMG9ph0twWU8CWxCCMmQatTU0bLVU
	JYwQEmtoO83QBMLNSqMnNO+L+rN24jBkZEjzRBmWQv6xQL/RaIi0u9osXPgPtzU4Ek9g/SeOv+n
	xcV3j5W/LV0SPbORn9AAZ3SSL/N4AWNnZJKT1Jnay0elVfU2S+hxXHbqVin2h/10s8X17v44npb
	6jHwF5Wc1pBFK1Ncc6GibtRU3BkGm3khxWXnQQrbYA1pMFshEMW1lhNM/fU2FiuYIEUjX0wZEmk
	AehNAM7DJBtYo7F65f3eQhMj56FK/YpmY4orM8/rOncP3Ff7Vedjxzlj9Ebu14o/NK35tGGO4cp
	lPFIG9BPzuygq4K8ygfZWsl3z9cJUEQsMD4MQMDDu86rOS+Mj8my26eiCjtsFThAFmvw843XVdw
	dxOFnCHMCQns5M
X-Google-Smtp-Source: AGHT+IHveGWcHvUuvrntsLVRkctV87zv6f2ES3vse/t5ppbqYjXZLjyMUEBBOSX6NbMtKYeNIAOi6w==
X-Received: by 2002:a05:6830:6d25:b0:7c5:33f5:c028 with SMTP id 46e09a7af769-7c72d4d77a8mr807476a34.8.1762903651855;
        Tue, 11 Nov 2025 15:27:31 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f0f5e882sm7650941a34.8.2025.11.11.15.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 15:27:31 -0800 (PST)
Message-ID: <0c6b16e6-bee1-44c1-bd62-2c4baa22630c@linuxfoundation.org>
Date: Tue, 11 Nov 2025 16:27:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 17:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

