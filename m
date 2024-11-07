Return-Path: <stable+bounces-91746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3A09BFC9E
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 03:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B911C21C6B
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 02:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D2A4EB51;
	Thu,  7 Nov 2024 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hDFvCfwJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F4A335B5
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730947242; cv=none; b=s0ntaj15xno9djXXQc7nWcL+F8LbkPFBoXGBbk72aEiv6M6+Ux5ODgcPGktKmAv3gav/oO1CcV2BVAq1RsnGZQFWSFgP1uOX0VESxieWC21iFEpkrBiwRPmbzuqWY9aHTNue2Ic5+ffNwQi23b0nDWKJQEYitBR7lVE71f42IoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730947242; c=relaxed/simple;
	bh=kcK7aHsP78LdSs6pNTwsnISUp0fBE7OUksiNXAiKvy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kopCUbiaOziKd3WW7G3A1nE69RP/pOzs0Dbyu66KUIL5VQ2SRoYUqa7tg8XnBD5dtfmRvYqqlT3IwoTqmxJCVgZ74yF2JqFzoyAiid+T8VEnj4VSsPdDKUL/MW9ivS0ziLVrsu7QBQK6GoOMFvOj05t/Oga/sIcN7O6+mxKuCZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hDFvCfwJ; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83ab94452a7so19947739f.3
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 18:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730947238; x=1731552038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVII3fPsxOIMCI+j60vE9UfnhsNmai0dOhdTYQx2JDM=;
        b=hDFvCfwJRX3OuoZP6/lzo8XiVsMuQ7Q4WM1NQ/r2GgKN7L/SIPlpJY1ecTClYhQxom
         V/7w4xPdjMfzYG/BXnyD4vAuJG5OTPgO5dOOkAp3zwAfAPSgDpYvbUbjnBkCpluAqQ+0
         L2pdwgTvayubuRxTuq7GWYiFxbV/B3g4mWt6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730947238; x=1731552038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVII3fPsxOIMCI+j60vE9UfnhsNmai0dOhdTYQx2JDM=;
        b=jdT021PvEPTCPU95zOwNmE4MFqaRbsn+iu6HauXOC3F7RWGV9ho2+oZzNLzSLZABrg
         L8yrdATqA6khRMINTnBpdLgvNjWaSqh2n2kY226VqHIQLT2qqyEVbwitNaNnlTXr7AD2
         53FbTEWy2qrAUavliLEcoBOR3DURK35GB4fHGWCVD+gLiuhaOIsC7d1qFgVa9Ht6UYvN
         gjlNFlqvL1nE+uHNeAMi14rfMMjYjs5XHoTdNzxgpIqfbSycvlw/MBLDvX5KEHxZyqUo
         JnGp96M9jw0rvsDOvMega/DTvVfV7XkaYEvMWHHXkz35sZKWt5IZ6blRqvSHES6cw9y6
         pYKg==
X-Forwarded-Encrypted: i=1; AJvYcCVMGmG6jeajDQVr4w16zMAiwvr9nQ+Q3/VdT5wbvabLac9g5ivA+X30f+387LEzVFhec6SeEOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/7LOslSlOjx94Tr/JTab8ldq2r3zMeDvqtulL6Bes2tSsghbi
	h6uFU+ojFeYxUvRHoQXYu/R4ruodEVgntvFr2tZkuY8rAgpRuZAcllkK5SuOh2E=
X-Google-Smtp-Source: AGHT+IHGZ27/oZkKkcigXB4g1bcfKe8ACte6HVgTPQgFpjO28C3gZ2EVTg6rGHjcnOSRHLoyT/kmyQ==
X-Received: by 2002:a05:6e02:1546:b0:3a6:b3bd:e92d with SMTP id e9e14a558f8ab-3a6eb1287fbmr3501735ab.12.1730947238633;
        Wed, 06 Nov 2024 18:40:38 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6eaca8c29sm776035ab.18.2024.11.06.18.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 18:40:38 -0800 (PST)
Message-ID: <390c9e9a-0f07-4153-bd35-9155a74b7d8c@linuxfoundation.org>
Date: Wed, 6 Nov 2024 19:40:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/126] 6.1.116-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241106120306.038154857@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241106120306.038154857@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 05:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.116 release.
> There are 126 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.116-rc1.gz
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

