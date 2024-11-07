Return-Path: <stable+bounces-91744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F119BFC83
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 03:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66482831E6
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 02:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766FD179A3;
	Thu,  7 Nov 2024 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WoYTIBDk"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF917C60
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 02:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946407; cv=none; b=Mt5U3Xcsnwu0zC3EuYjwzFEeUS96fQibleLrp38Y5PpKV/0gJRLDR/SEncAdb7AGuilBrnAr00zMyKyOwisTDihdr9f0gF9Uw1uHg6ZDhjR5bkz4qJ4tWWZYPgJ+I7F9X3X1uNCYHEQwoe+VrDFCFWzv4oVKxVdxggTYJvkKTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946407; c=relaxed/simple;
	bh=cJpKnGUFX+C25uYwW5TZdZx0NvQknnN0YhJKq8SGgUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RH6ktDGLfc0QGdEwrURCm8FwWRVN7u4/Y0MVQW+xyUruphqW6FlRdMQhmUZfFktfmYgvu8w+AzYeOc4a6Cn4658cpqHKC+k8z+RgSwh1Vu0rhRCrj7b2hVzdaQpjeCC5ei9Zk8W12HbtyF0V3KHAiZKiN3Wb+5BuGdUJio2BVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WoYTIBDk; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83a9be2c0e6so18717539f.2
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 18:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730946404; x=1731551204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsadpb/yTYe5Ho6eI38Uu8IKjOHgtGbPDaakrnLV2qs=;
        b=WoYTIBDkBFKz/9mnyDz2CNAB8ytQUV+xfx7jDLsNAHz+NqM31qtuK+PXikkligrX51
         yxzTmiHcibh1zg0xyZtTHd1+pizGiOAIcKJRNCwvHcXB0Ow2BdFVrNHbxhPeFWeDA9cd
         J9AffcBD2AY29JuQdbz9SVY7HF+/4iZoQBT5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730946404; x=1731551204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsadpb/yTYe5Ho6eI38Uu8IKjOHgtGbPDaakrnLV2qs=;
        b=KIj4zpQxkJC1GXQT99PdMjEfKeSUgw0q6Biag6SF/lZrknQni2Qd8bqndvOpwEdFDY
         tNUHJgcG9s4BJM84xzS3A1sR6KVZNuTsNEhgqCqlWb3/A2AQhXyas23jMTerSqq44Top
         OnoJnieoSw2KpmYsLAq83pET1Af6Axhi93rAs8LYHhXtorQRPTiKWphBhwQAb0HwuPXj
         tiKbf1n8W4P4Ez+Jww7LOuPhD/48xTs911/boWWfFGLoLKqqlxaIcm3Ssx0W3Zy6tBIo
         pUG+H98H7Vbs00N5bG+ngjCF75S/XeGXUbgGMmnVeqAnjtl5vHzgSV/oDq6cbj/xYzd6
         p75A==
X-Forwarded-Encrypted: i=1; AJvYcCUZ42vvAnxomfZSbnShIMyfsTjtTeU4Or7uWRt4lkZPwtXmvVlS0eBSU/JrK17ZHJYmLo6b8zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJM4FOtwXERDZP76YjbQVqkBQEEdXeUDkATTtpgwprqBo+jFLQ
	bj8f0w9EphlWM5qIv1KAdodGnzqzZLcz33Ra56WyGuDaHaY+iCeAQHZurEdvlI/4d3CDvMzPlIP
	g
X-Google-Smtp-Source: AGHT+IHNpB4MmvcSraJtYl8rbwJori6zmReEqGUf6w1IcSKoGYmZTjaRiv9WOGWUPCv7aothCGkPhQ==
X-Received: by 2002:a05:6e02:17cb:b0:3a6:ae3d:920e with SMTP id e9e14a558f8ab-3a6b02cf8famr249558485ab.13.1730946404158;
        Wed, 06 Nov 2024 18:26:44 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6eacbed1bsm697315ab.35.2024.11.06.18.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 18:26:43 -0800 (PST)
Message-ID: <26da61ff-524e-40c7-80ef-49c6323c629b@linuxfoundation.org>
Date: Wed, 6 Nov 2024 19:26:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/245] 6.11.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241106120319.234238499@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241106120319.234238499@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 05:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.7 release.
> There are 245 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
>

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

