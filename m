Return-Path: <stable+bounces-158442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFB6AE6D7C
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 19:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6FB17F097
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 17:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6962E2EE2;
	Tue, 24 Jun 2025 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSq3YY/i"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E9226CE20;
	Tue, 24 Jun 2025 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750786234; cv=none; b=jc5wgsFP/EuTsi1yafzbBkg66FPcJmPei5glWAF5W8zvGJivBjobF7Gp81g1ANJkIFfQx8zxN6cNhuh29PFsqP/ZtbIWBHogjaejAN4MPTePJqvcCO5TZUQAyFoLud/6D3S4ScTNEvyrfMhTDHI5Mbgll0QJ9bmXuN7RGuPc4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750786234; c=relaxed/simple;
	bh=QPmbsM3vCeQ/6N4tUAMhtC6ekMVzqeWDDDlsxvEEkng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nsm1obZPp78v90nN5rBSKtoLczmIO/b9BGcfi68E1FsoStYvMDP7sQWuXX2fXDJnrn6G7OQXd2S/7yy00KLxayt8bfp+WooVtCllfFUWuxNQEKpEoDVpf/jFK7k3klX3sBGmVUI+3tRveEtxJuziCN1/OQvwu85COcxLVtgOSg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSq3YY/i; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c4476d381so159536a12.0;
        Tue, 24 Jun 2025 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750786232; x=1751391032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YP+oZ52shuYxDzYWmlHOs+Uz2OoQ5Id/H5ia3aiicxI=;
        b=dSq3YY/i+kYGgOy0YgRHC4IrGFUBSOd55M9TiPYHG/M5BEEGceVdv6DdRscQ2pJ13C
         z57VW5xSQ6q44umcIRYV5Ue8aJ050gvHBY0KQDkj+qRxFiC4l7I7Y6kxBPMDjB2ryxJm
         dyEdoMXRPq27pAPEfjaylSQoMwWLV/6BMPiEVPY2J7VB6TxfBlhAR8Pr0Fs4StI19ghW
         w1jQoOwPP/EvMog64I163l7/vuVibgRPAaonIRLBhR0t6uTeM31p/gybK9QAlwvjcdpM
         DKkhRp/X6wbrhQkyd04tSNjNky9/8gaKwFHX0ifYXeSv4muua+FBQwWzPuFCC7Ym7UrA
         48oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750786232; x=1751391032;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YP+oZ52shuYxDzYWmlHOs+Uz2OoQ5Id/H5ia3aiicxI=;
        b=dIaH8cSr47s7xnVRgvqeMVaeoqX8EpFa2SDdERdVyKhxTJjRW7AlPI9cL6G6ocan0p
         2F0UL+K3MjpxJfQ9BqTuBnHDXA4RjlvmjwcfMZzir75FZfcKeFUif/d7oSZnfS7wM9rQ
         9lNZXDPr9Km3X0g0vvzA2zXvkLZYdSTOs0/VgV4vDqLCPteAQdTmQwUJfUHalNDUPEh9
         +VIG8DlrgueplEa6hGRff4R4vjT7PF2h0jMIuYh/8wxk5P5qhnBBcq+lvQsrzJ18RvWU
         La2TMgtjDXorzVRK4W9rrBplSr1s4t9fC5XEUQnNvI1QNi14aqWeU+Nz0M6hScM1FD3S
         E+tA==
X-Forwarded-Encrypted: i=1; AJvYcCVEq8c2E/zU05shWCrjsfBBtJWWNRDXmF2W8e+pDyqoXHquLOvgp95hIe2jHhRW8AxK+MQ5m8GWAoTO9bM=@vger.kernel.org, AJvYcCWNZLAS3Prvf0+n89idDxnybYnBorDMqOtcaA5fDHpmSWD1K9BM98nua53tHw3ATVT1z7SPoMzO@vger.kernel.org
X-Gm-Message-State: AOJu0YykgWEOmMRMux+mWXQ2TXTyrjouBWihIR0jGB6i+ws97oosEl5K
	VyYxonK6J4lRRSl+GsVfmCvhNP/MZowt1Hvl5ia94kN0i8ttyPeFkl3e
X-Gm-Gg: ASbGncvLM5mb5ZW7UHfU5ib6Tlh1i2F2RAVW8BccZXEWtnMp3YXAi7ISo5FspTt3JA7
	NRXyv4I/iz2TOaW1LrOo2eLzNdtOT9Q66V+cqvmsMfxmBcnWGJ0dimOVBvSNQQy5SSPwBmjzl4H
	aiA20yFF0KHI9gjRmrgvcvDX+ZOEcUk3/S10xo7L6gV6mPQBT9XVKU8C5KRPg3PL3AAo7A1Wd+B
	+S58m1t8fcpaQf9wq/TvGPKKE8ho8Ihp9+dtlt+N02wpLWHAy7qU3wy0ryx2MlvS/W77yx2DJoD
	ZpnJ64bHZr4G9OWYL3t95s5mXVoPyTHDDMLTOUJMhqUW42MEl41oZMKbsB37WLxCFtuem/5iZ5c
	OCR29Bu4ynhRJYA==
X-Google-Smtp-Source: AGHT+IGwKDEzWKv00qUJ726dLtfdN6pVZrF6NIdjVegKN6GGf+TCv3bwW6A23rylIeTfduxNFcanrg==
X-Received: by 2002:a05:6a20:a51e:b0:220:7e5f:b2fe with SMTP id adf61e73a8af0-2207e5fb348mr48668637.21.1750786232324;
        Tue, 24 Jun 2025 10:30:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f118f7d5sm9647999a12.12.2025.06.24.10.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 10:30:31 -0700 (PDT)
Message-ID: <5c96c033-7cd8-4d76-8f85-856cd62056c2@gmail.com>
Date: Tue, 24 Jun 2025 10:30:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/413] 6.12.35-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250624121426.466976226@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250624121426.466976226@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 05:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.35 release.
> There are 413 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Jun 2025 12:13:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.35-rc2.gz
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

