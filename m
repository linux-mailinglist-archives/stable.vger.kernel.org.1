Return-Path: <stable+bounces-23261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85A285ED4E
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 00:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F171C21B23
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 23:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8B612AAE0;
	Wed, 21 Feb 2024 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MRmnhHTv"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FB212B15A
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559036; cv=none; b=JiVryeMh//UWgihwb5feotPmwvs5vtaU/cuW9bDeU1nbp/Dyl80HZnegfqaIWLBhyTWllhdVbXu8PDGoybkFCCuLrtsDgkkl9CsxQtDAwinzhUctVL/KcOs6FTQrg5n3+Lzpxs3VT1FxGqxBhxyLwYb9bJ2LXVj3xL79G2YKV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559036; c=relaxed/simple;
	bh=izhq5kbtt0E2GDvdNjtl4p/OrqRO7ylffD7YEBfaC94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHCJ0Qv3GU0hjeO7wu/XGOK+A+dIOSA85IpfyQlhyB+EYyjP34tDak/uz2H/kKldB0QUCYMOE50Yx9GbtQRUBYsUpk5XNJfMX5lCd8vhMUro4yALLeJ7NCn+vgb5BjgB7RlJNVCLzsF/YHbqUmkf3MeMkcFrSjKgF+Vy05UddeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MRmnhHTv; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso120538839f.1
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 15:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708559034; x=1709163834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UUJnSIPTMCvPPD3P+M+IMvy1Y/adsahfRadjAt5ZUzQ=;
        b=MRmnhHTvZXoyDMbwyLjqEMHp1ogN7wyoSsAFyUqTjQ8gxfvfD6EXecV7RqHouQ98j1
         +3o0oXYJ4V9R+mWlfi9C3m7kFGWBRdBGwrz0WqSaTiY0O8umSQHTBTVsaNmtWjxWzY60
         qqZ44tMs9biEilrZqUuLh4tXXjPJzv5ceB3xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559034; x=1709163834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUJnSIPTMCvPPD3P+M+IMvy1Y/adsahfRadjAt5ZUzQ=;
        b=CFQu7wswYZ4dLbrsTAVXbWvVzJpIgdEaoLmQo04AY2hSbxp/0+pzH2Fd/GCGnqUZJy
         IA7Y4ODZCpQieNeMr2MQxOTqWllqdYsOWETUD4QolKsbfgZLmoQ0xZP9oHvnWOzO95JG
         TPSsT2ZB29YsFBoQXCEd/5Syt5tthOcMHpyUUGsi7uUvTY0nXgyvyRXpe7RYqsSteF4B
         TMzgdzXTEK/zQhIz+98xP9VoOL2PdS3zSLLjY6wEdxR6i/nhQBWUCL/4erB1VRU9jZER
         bYslVzcGx0i8VzWj6rwM3hAECMToY31gR+tZND9jLZSPdg9Q2TYUPHqJNzS4vPugL2CV
         07yA==
X-Forwarded-Encrypted: i=1; AJvYcCU9gTVRGpE0zRjBh8vMR1rdBAVXH7gM0op7dHIOl8gZBxPWyE0jZHk+i156KEEHRWykmNSCBLVYtgp2x4t6qOFZpwgr/qr9
X-Gm-Message-State: AOJu0YxD+5KJc36ruFLgg3pMMpSeHKI2pMOH0jDYoyTc1zaD6uRWl2Co
	wvqn27LWRuGNsKvuZPgRURJdoFxiHs4Ygg0ZggUji6Ee209C/n4e9U9U9Cd+TIg=
X-Google-Smtp-Source: AGHT+IEtUrvA3B1IBymiy547pK5kT58ah7a9oEbpT3JrqGJ0gP1CK6rxJMySRIt2X1VUIz9rI7Pq1A==
X-Received: by 2002:a05:6e02:20e1:b0:365:1967:e665 with SMTP id q1-20020a056e0220e100b003651967e665mr12362408ilv.2.1708559034103;
        Wed, 21 Feb 2024 15:43:54 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id y11-20020a02904b000000b00473cdc58012sm2932344jaf.134.2024.02.21.15.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 15:43:53 -0800 (PST)
Message-ID: <928af94d-20dd-4c44-b73d-e48833413056@linuxfoundation.org>
Date: Wed, 21 Feb 2024 16:43:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/476] 5.15.149-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 06:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.149 release.
> There are 476 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.149-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

