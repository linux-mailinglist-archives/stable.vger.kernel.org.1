Return-Path: <stable+bounces-4785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D360806433
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 02:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8AF0B211ED
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 01:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B8110E1;
	Wed,  6 Dec 2023 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CBLXLQ60"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB821B5
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 17:39:17 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35d7e22ccfeso2365105ab.0
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 17:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701826756; x=1702431556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnDyv8mpa3XCy2SgMLwpGLCMFpHcfg7BstAYVZ2g+vk=;
        b=CBLXLQ60e3NGgK/kA9ff+RiSlSw10EqwJcj4lkuUDElcgVS+TCg5X1jAcYk3PJz8v1
         TyNaWSSRrePlx/EX0WQxJ088pETeV7g0rEnf/exPPHFML3MVPZAEEbrZgEsIpw3DPqV8
         XF2iuQ/mLulreYTKEBxxxfS1jDGvFQySGtzEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701826756; x=1702431556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnDyv8mpa3XCy2SgMLwpGLCMFpHcfg7BstAYVZ2g+vk=;
        b=V7r0zTOhe9vaqTpCB0wG6d6myZFRdBXvITv+m3o7zQr2rgGOthDZMuol9I12GhDBpI
         0bcuXqM215M+XcLz7nH4Jr7qUkXSvuiWVJiKo/mOCUJRsKHQOI+ogVtOWB06qFCkGn9V
         5DG0WNJHz+GzZkF0fSFDacnczVrXHo6EvyE61WnGzhWVNKGxjn39LteFM36WVqq24Er2
         eVa0EkTsA6FO8UK87J1rRjlkfnqVqEwf/81M2Yxi2T5Q1N5mBQq8yLvrVSL0u6J57cdl
         EYHBzkiTWNdLuFP+Zo5YZf5L3O6AxSBaWApXz5/0ROc5XlaRGWRsXG6g5KHeBg5+8Wq5
         AeBQ==
X-Gm-Message-State: AOJu0YwsHD4PoxMC2AlCCRICwbrtnX33lzEB1NGQYQk+3WDw150HnwhA
	70LVBm3csSec5fC4S70Yc/p7Mw==
X-Google-Smtp-Source: AGHT+IGzIESU7A3Ck3UjU6zQbOlLRTIOa75cH8+024JUo3E3grE2pQ2di68BCQa7ACjTU6J0dCrp5A==
X-Received: by 2002:a6b:5004:0:b0:7b3:5be5:fa55 with SMTP id e4-20020a6b5004000000b007b35be5fa55mr505681iob.2.1701826756393;
        Tue, 05 Dec 2023 17:39:16 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d25-20020a056602329900b007b457549001sm931003ioz.36.2023.12.05.17.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 17:39:15 -0800 (PST)
Message-ID: <55bf7a58-3b9f-4c95-841d-d483c3b0bb12@linuxfoundation.org>
Date: Tue, 5 Dec 2023 18:39:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/71] 4.19.301-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231205031517.859409664@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231205031517.859409664@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/23 20:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.301 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.301-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

