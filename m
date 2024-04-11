Return-Path: <stable+bounces-39237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353268A2288
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 01:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4301F23261
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 23:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DFA4CB35;
	Thu, 11 Apr 2024 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dsq9GiUk"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869175029A
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879001; cv=none; b=DugkeMF+IkVbfm5+41CVPNKI68+MaD6krX5+opm4tGZEokKksj42bQt0F3/Cr9kARjS/OeYWZp55SczQ1neDY2DeBblrz7KPS0eS6lygVJaTCCw+ecYDspu/Iy9wywPi4wDTVAFusRLj3t22n2jp2E6hnAIFz+I4EhpRnwQy4pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879001; c=relaxed/simple;
	bh=euNP9GFzTMlL7dk7n0mj6KeWCa/Ukh/qAxFXqL0UvYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+/D637v+hGk4XYLD75gr0UGP4Oa8RhjNLWsMXQSS6kRdB6Nkv19qOcyojQEEme/x/fjypFI1PjBHuy+oRnVCp7H7Q+pin4ichnrmc1L2gMyxK7Z1Kpik5Ai4HZeBjMinXPnJyLWQuV+3DxLRyG/5tA6JobOGdgjvMEb/61f7Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dsq9GiUk; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d67d1073easo7101939f.0
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 16:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712879000; x=1713483800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ftwuYrVcc3eraO9zw33nB+CAyySYVAqnz6ETdM0/8LE=;
        b=dsq9GiUkMUjAE/9hHurfS0U+yLdoKGbL1mNiGUK+oCLvjIvC5Dc91EOH5rETKKnRoj
         qAtW5O251Ua/bAMX011pUQdFtsphGS6ax5j/bxgm3IrH8Ho9tD8lQ+HC5M4ce4NzbsGA
         XcmNpmB9jZw5F22KMKeBW3ftjQJfyiBTEQhvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712879000; x=1713483800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftwuYrVcc3eraO9zw33nB+CAyySYVAqnz6ETdM0/8LE=;
        b=P4xQ//l4NcoVtRAcazWNKPXHqhXBdcjriIIC8iRcytByYW5gXn9qsOZ72iihYeC2H9
         gJf7T5ziTmcqK9D5KOhlKYUp+X5X8xohoGzPc7G8czaqi7o33mFlQQ1aV6HB8jgoFH16
         7hk+pvMuxBUQYuGYtN5VJwrWdmZ3e7YTKJ3jVt08YUKgFDJWFYESg4YO5BuhNcsUhCyr
         g1mYQJUO4+m5CrqbSWu9jXcEFiIVsDyzT3q0pnzLE+4zeMqcnvyy1gb2edYpChjflmmk
         ItTPx2syx2LXpIlcGa2q8KGoNFcJsNGp05Yf8BANck6S8En1hXcWy6Z1oEypzbF90BSu
         KlxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrFRjjA9zovKDGBszMU2U/4JQBQu4/QCBUbRAPhTIANKiIF53NFiiBp+cWfPE6FzqHj/44beUJCN07HWThb6aiYeES+OXI
X-Gm-Message-State: AOJu0YwsCwUBr3IkfYvP5F2LPwy9pGJEECUq2PHUyeHHicys9UeYm3h0
	By/9EV7Nz2M1u+ZannDL9ImepQddD6QCgwJrHWx9tVmhXA10sPtWz1vcyKaH2rk=
X-Google-Smtp-Source: AGHT+IFi/4KYRs4PuSpmw/VIWvfaUej67bS0cewEgnxZV2DTetbKiVyr7CY3wapXFEqbezkxkPfauA==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr1532834iop.1.1712878998599;
        Thu, 11 Apr 2024 16:43:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m40-20020a05663840a800b00482b8b12872sm667259jam.174.2024.04.11.16.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 16:43:18 -0700 (PDT)
Message-ID: <cc48bddb-93c7-4a75-9d78-e88a9c6fcc1e@linuxfoundation.org>
Date: Thu, 11 Apr 2024 17:43:17 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/83] 6.1.86-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240411095412.671665933@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240411095412.671665933@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 03:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.86 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.86-rc1.gz
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

