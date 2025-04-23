Return-Path: <stable+bounces-136483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBF0A99A88
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 23:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0AA37A3D2E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 21:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0F6293B7F;
	Wed, 23 Apr 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZybXzxhK"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB15028A1F9
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745442789; cv=none; b=jUPUVXfmWv+dU2oR4vcNLOVTMeKE7Nvr6YeRnIij5UiRdWS0xGWInOpia9+YO3NU6S8idcI674NO8qWaVM0T2UzqIKxviTUYhN2Stu9RL3YA+IU12rg5hpJeB4u5NeRd839rqeTUH23YdATLhgZvSAqskBFp5NPNqVTNcwfo3Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745442789; c=relaxed/simple;
	bh=E//82LOYPiTmGcYh2jIvd7jDfS8n/1+ryqbT7Uroeh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnkgszII1Ehyh/qT1zNuJLDkz9vEELW+WOyDwQgMhs7vbK2SocA7TFjf8ernUjDbH+BENZ4QIGQ0ojHT0Jj4ShUHmuFs6EUG+EqzjsEQsUXqUdExMHrr93AiHrynpCAFjiX/APifmawptKDJs2nmKdC93r/IIsz0Q6FB5oT1i/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZybXzxhK; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d81cba18e1so2489505ab.3
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 14:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745442786; x=1746047586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJl4xnZJ7CK5VljYcazrir4C/qZU01ruca5B4HK79Vk=;
        b=ZybXzxhKJf4v6sYq6+lA/s3fZIYwqEBqdI0FZIEanOBm32HKNBbyt8MI3yEsYJyN3w
         jOU7UyEgraL/vBNDNoMARWIRKZiskN0akybUWhxTMb1A1WYEsOexJJBRLweAC9bqIJ/t
         TwPRIJGTh8e/e5vraa4Fba2z6poa1qWdliC0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745442786; x=1746047586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJl4xnZJ7CK5VljYcazrir4C/qZU01ruca5B4HK79Vk=;
        b=piEbAixZjAmBaB2EwFibcXP/tZSvkA1UvQftVlrTCpb/ljfIaojHY0OITY7JVxvsEV
         LPR7eke56ZpnCLDKShC6ptj/Pi87rhwxSKtay/8dMzEgi1wET1DMeaWCpNYW8cFnF/Yh
         L/JkZ+lQPhunlFOb44Rsz1fNZ+PcifrFoFYRI4ep5e3hENhXRJHrcaUcMCTvHJ7gffq9
         dWMhpcGuIkPG5gxXmQyn1wt4JGzkF6xZm2UmA7jzfZdKAWU7NgWKcBHW3E7nlhWXcC/5
         OC+xA4yqdfRrg+N2YXALneGVcVfu4TCvIum15RbXHMCDu6PdTnVMpENjhCo4LjFFGX6z
         WkTA==
X-Forwarded-Encrypted: i=1; AJvYcCX/hqlB+ItrQuipFCibQJI0hl9hmIrDM0uISLxXUR3ULuSLZ29NXxOJd5m+AY+eBaygSsG5oW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSivdID74wwrjdG4XO6rJ0rpJCF7FCQtT8E1Ab/Gp0u8SKt78
	YDPezl2StcHTXtgJ47EfAXm99iEYR21LfA7iYpKdvsXAfpYhh1DE5QRqXm83JWg=
X-Gm-Gg: ASbGncvQ5QMuH+XMO5wSlok+SeRPMSl+qObUcOrnWZFu9QJfTpFlQMaSo9ij1ajbCXe
	JA1iLo/xs7+pfJKuN/LpSbi9cSkD1heptLSXNEkMak37MR0si6rnhcKMpvuJghMnZLlxbPUFf4s
	3xA5ffF+QAfqvRGfSC0YHVLTxgQIgGpD0h1AKXtkVWHXT3EHEVWkU8+KZc51BjLZGhTPm8b2XnM
	DgxaObxSX1qlMLfcDwJJ1gT2i4QXM67cDhIpg4NUGKdwasAyAVOL2J8acY1BnXOA5Us/2kMuXP1
	pmtxeTJGpIdnQ16/QmsIpDcjaxI4/ipEmMZ1ofpOOeTcCiUSwlM=
X-Google-Smtp-Source: AGHT+IEyZDCabZuyz0Qo8Ncebji6UII8VsX1nanFNy6fPYhte3F9BgT0IArHsl2sKVHW0CRT8FjE0g==
X-Received: by 2002:a05:6e02:1d9d:b0:3d8:1b25:cc2 with SMTP id e9e14a558f8ab-3d9303a0901mr2127865ab.8.1745442785773;
        Wed, 23 Apr 2025 14:13:05 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a37f9c7bsm2977167173.37.2025.04.23.14.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 14:13:05 -0700 (PDT)
Message-ID: <23e1eb72-c445-4aec-9077-cbca66525f48@linuxfoundation.org>
Date: Wed, 23 Apr 2025 15:13:04 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/241] 6.14.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/25 08:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.4 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
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

