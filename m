Return-Path: <stable+bounces-45182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10428C693E
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 17:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26421C20CDC
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 15:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054B913F422;
	Wed, 15 May 2024 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eFx6/9Dy"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DB915573D
	for <stable@vger.kernel.org>; Wed, 15 May 2024 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785648; cv=none; b=UfsQdnG6aIv5o+LQafHcaLw8UmtWqXN0tSMidUdn9DWvNH/cOqIthJpoyjXKJKfw3Llj0a4eYMdVaLRvtLQOCB+YCrx9xFMYct0k/Z6hSeKzv+dajiHtWo8MPmocf6weNBX7xr6aAWTHVPBCnOhwmg5rS8+zLJqtG5TPvOAvkp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785648; c=relaxed/simple;
	bh=M/mp7kjcGr8DnRpHH/QucuSBMAtXjGtmEfL1icHFFWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EB1bejcazDS+35bRc1Jm7oNUdaPhunteVa7ZyOQVDlgx3HFkSVx8q5f/DgmRNKqorVRPkPzuE/+j2d/b6SCvkxeBUYXzeM9VrUVHCtfbU6GYBeb7x1JmD8pnoe1FFLH7Wq7S3HtHZSCYS0orN9XY6nJENnMuO5q0ISqwnJWt3d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eFx6/9Dy; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d9d591e660so23693539f.2
        for <stable@vger.kernel.org>; Wed, 15 May 2024 08:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715785646; x=1716390446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3toXt9vYdwBFDAxiXSkPst6onSnfmkqqLWL2VMwMaow=;
        b=eFx6/9Dydj5jtsRMKUvBsLGamQLYvHvn00/1aEUVP62sYr8YlheBChoOJynlWkSR07
         KNzOmlDlSBACtkVkkeeT2I8pJbt10XMtO/ekxMvPbuO76CteRrQXGMo9zQuWUZadxy/L
         Msvzfs3D19IOH00d1jW9bNWiDUbx5qYID+4Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785646; x=1716390446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3toXt9vYdwBFDAxiXSkPst6onSnfmkqqLWL2VMwMaow=;
        b=BICHHIfxT2Gp9A/fNqzO1wMCb0RO/DheptfXM3gzMnQLuT6HqdRaR4wsuhc1r6D1MP
         +xnF54H8PNyLmXYWuxgj2wsSf7rHevFwOVRh5VTs8f4dEA0uyXZ0vWeB/uDEsfAKrUlJ
         j9/urURQI04dsVZB7Opbr2gQsx1KDHyna5mqJroex6ucCYv0AnjHU4AQ9JWx+NmvO7uR
         +1OPMU8Bpz/ObL36fHkuylMF8Z5r70IeG/pK2HCBHLqAR5b92547aMVqh2OO+8UJv/TU
         lpG/ZcXr7SsPuke8ZfrQ5B28JMlLHBr5QVi5s3kNApKvdhCiyFtG9BGnY3ZAYxoUrLh7
         fKUw==
X-Forwarded-Encrypted: i=1; AJvYcCV+K+Y3GeLVoz/r86X43cEHGErXIsFODBLu5NfewMcCxsFbrIK8k0pdqmSRzbapt8NDd9zNujdxpkOUFFneB/iI9fu8DjsN
X-Gm-Message-State: AOJu0Yxnt7mDaHgUsEfaHZofStxylQcw87NMbe18iVzodEUYiL0imEuu
	m3xwKrKwdTWdeQSms5TMVt5/Gb/6UkO/Dezg9cIpoAoeMBs+b/MrdIYzI3Je1Uk=
X-Google-Smtp-Source: AGHT+IGvl3dpFu7VxMte1m9bU4eJetyIF8et1w15eYUBYC9PnEP9jff6fpeWugT2rmJoGIQyyzvoog==
X-Received: by 2002:a5e:c748:0:b0:7e1:d865:e700 with SMTP id ca18e2360f4ac-7e1d865e82emr1176690839f.2.1715785646574;
        Wed, 15 May 2024 08:07:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e1e2e03bdcsm174171039f.32.2024.05.15.08.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 08:07:24 -0700 (PDT)
Message-ID: <437d33f2-0a91-4675-9e1a-f097b174de7c@linuxfoundation.org>
Date: Wed, 15 May 2024 09:07:23 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/236] 6.1.91-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240514101020.320785513@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240514101020.320785513@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/24 04:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.91 release.
> There are 236 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.91-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

