Return-Path: <stable+bounces-20131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6418540BE
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 01:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478941F2A277
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 00:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1302D197;
	Wed, 14 Feb 2024 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gy3Q614O"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B75800
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869736; cv=none; b=B/t3bIFZBTAzxolcqVFVxLkJpNXhDwbwloqDaYj0bMjvH0x+MgxUXOCzkswWFP49wJ+lQGgdJOP0e+oHYhIqzZEe6olaXTbJzK3VnHTYyTRl7+sAHUFwSXjv6qd4zRFLydPB9p1FcYofHMSbnBviGhKyHfOhmydISlfh71uZ0Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869736; c=relaxed/simple;
	bh=e/JPk36YcaAkB2eASchwf/O4/pt4gfV1CfqC3KKqLck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sD7V7DoKw6Qw07l03+XN+2+9QP8XKtGA7rWMHO1+aE3iSzo+ZEjRKSPVNSoQuESxtnVGTOhfubYhyvwP7G+SKCKUcdSHhoWZkMFlv1FjKleFPXcCHq3KOkGDwM2voHDakJjDN8PbLs5045AjZiHpLE+YKPFWAh7Xm8Rj/yVGJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gy3Q614O; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so50916839f.0
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 16:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707869734; x=1708474534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2dMR0dbccb+q6sxSnuzRauid6CUXOmO7gipmGVqwVI=;
        b=gy3Q614OHRtayXXVNca16ZROgGbouqHww8L0MKv9bTnU7BcQEMldT/+XaBNAR338WX
         fMtwFPD//SEc1WScRDRRwYXKwHU+onUgzDC25ixWK5eR3MGSbUAFvWObQDpLCh8Y/CRd
         t0/B41LuJYwHY0Jb+TGVN/9SUDiUMDIplHz1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869734; x=1708474534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2dMR0dbccb+q6sxSnuzRauid6CUXOmO7gipmGVqwVI=;
        b=mfN6kUmYWkumqodNzF5vKeNe/GPc5S44wA28tMxI5Fx5b1BMdowVWrFeMVMuIz1uP+
         wZg6/HrjnboNF1kGCuZQluvQuyxJc+EYotY0uOtxxP0AeC/LgaStvIZXqQM+Xiwslj/6
         IHftjYwiPijzwR6w8HOPQ4jHhvPTbrcUZ4WaqaFU8pu2LXj+xuNh86/Ac0xioZ782Fm4
         4H2GWgP9PrQiOzecrcRAigp9ODNPFLRhiaR5UJ6i0u3Xy+6ul+MJUITZDgPDHf6HQCK5
         qQa9sqGJP4l2YcZTTBVA0NS/q5ajnXLKF8e81aiSxnBZnr6TJw8SYNsY+2Oz71F3H+oo
         wwBg==
X-Forwarded-Encrypted: i=1; AJvYcCXcK9Q4wm/cHKH8YQZIlMjnkbCGBQJOq3hh3pi1Z8YEayrkFNSotDAT+w/SdJwIx4SupUYJb58kgcAp38k3JgxRF2P7c+OL
X-Gm-Message-State: AOJu0YwrjV3PvMO31ED9p6s+vme6R0fMD2O+lUohU/KOHTYAbbP0+yo5
	hhsolviLCLb1qI0+v5wtAMF3o9LT8UMvKl66155reXFhYT4m7X/Rgy5F6SJucKQ=
X-Google-Smtp-Source: AGHT+IGZPxBDGfs1GmmWPdgYBbbuzmh0oqNysYe208XUtrQBS8ruPHHgQ0FygG9avlS6AY88n1HIyQ==
X-Received: by 2002:a6b:ec1a:0:b0:7c4:8398:ac64 with SMTP id c26-20020a6bec1a000000b007c48398ac64mr413794ioh.1.1707869734360;
        Tue, 13 Feb 2024 16:15:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoTjLI+7jQTSlcz2sbv7KXq9AUXRKEHCUIBP16b9E4j7pskLlJlDZ9IEdtWsLsmQVZWrww6JzE1txJTPJVH3MJTVv5ydQcdsJGIpbKgjBaZJcA8FEl3v7O7fhDZ0NSJsZh8hrRcL1GD/+MvtwFSYdplaRbm2u3zc2RhGJHuHH0EZIvjxCbQvIt3HzXhyz3rIDvetV7UwsskUB13liQdl+iGJerRZYxqtcylOFcL2bTww4+EESP5/USLOPr+6eZ1YhYBdH+7BbpgAn3EcitWCpQZn3GUbzyhHiIaSe4tKOsfyJrzN3Gr59gVejYLM/a4EjL3UcdK83FTk96hEJbk1FDXiwhU1k5wdLDyqctQUX7Hw903pbgV7+tsIgTlGBPY4JEX295XkHm0L8r4wezPiYeM03SQ25GIwUiegekayXJIkpiDlZTjULPZOuckAGwy286xe+2G4WaWD3ihzXA0nrxyVgxXlFGMY2NVp7SEKDcsQQkL6gx469uc40SrFpikyITMtb8CwlYM8n7ydK5dHzKtJIWzD3REkdUQwm3wA0ALLku9Iaxc1wWPuRYViDBV1+iW+bBNNBSxQ==
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b1-20020a056638150100b00473a063fe07sm2003035jat.118.2024.02.13.16.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 16:15:34 -0800 (PST)
Message-ID: <d66a3b58-2cad-466b-8f6a-cd6a10013b65@linuxfoundation.org>
Date: Tue, 13 Feb 2024 17:15:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/121] 6.6.17-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240213171852.948844634@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240213171852.948844634@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 10:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.17 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.17-rc1.gz
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

