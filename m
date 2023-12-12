Return-Path: <stable+bounces-6469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79E680F215
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC5D281B07
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 16:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C97477F03;
	Tue, 12 Dec 2023 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K1SzLdpb"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B502AEB
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:13:39 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7b7117ca63eso34972839f.1
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702397619; x=1703002419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7alySON03WYfD6qf3ZfyB9eSAEEy5WG2do07xkvBxk=;
        b=K1SzLdpb7gA9oMzk+aaiKNmDLcH3nC3En/NUOjSZZ4NFL2/ak1vY7mv+lPppZHzal8
         7tZMfcqKHipYYsTEK2ecuhOP1/ctT94SkR4yht1bRiCiiOWgPRdPuQO2grUWai3lv7B9
         JgWDZW8/LiWww+wmiVNr2tTw7qxDFpc9qa/tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397619; x=1703002419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7alySON03WYfD6qf3ZfyB9eSAEEy5WG2do07xkvBxk=;
        b=KubOpo0btiigI67NOEf7adayG0E0fuXhS7AD3X46V364QM9x25xF/gC0rwZX8dMuOG
         qiXIjsXhE4djKc51rJ5whALrdsH1etOaGTIMAr/p8AcwrK0ehP9L5XNANDGOn6p57Y6D
         beDOw1XUGM1c63i+MwPkm4OIe6q02EYZVYrt9/0zB+4EwoDwLk0TaLi6ZMQi2dg+gLv+
         nyGPuU58+QTODoS6agAQEl9CEptNDCVtCleEGw/tfOhf2pXIARdMiAy3EFvQizNJ44mk
         hO6CoJOuVZm8c/RfaxHAq4uVbsoUjgHiJd4W18AKBXLAtSsEb327o6cAP7xuVbdKcHlz
         37yg==
X-Gm-Message-State: AOJu0YzTPezX9kCueuVOWItFkwy4zUXGG0/bzqxSVX/h7rnkPfwNecQt
	Xs5AlvYSWr6JMsUQ3EiU7mf1jw==
X-Google-Smtp-Source: AGHT+IG3GZGYn4y4YYm2tHG2D87ap6X+kqIa27ZDbVHHkcGLK1mHElj7VKWjYheX7bdAtLLEJpdQnw==
X-Received: by 2002:a6b:e70c:0:b0:7b7:fe4:3dfa with SMTP id b12-20020a6be70c000000b007b70fe43dfamr10643360ioh.2.1702397618980;
        Tue, 12 Dec 2023 08:13:38 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t1-20020a6b5f01000000b007a6816de789sm3012606iob.48.2023.12.12.08.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:13:38 -0800 (PST)
Message-ID: <195fd72d-2170-4224-9e8a-3b4b27fbe3df@linuxfoundation.org>
Date: Tue, 12 Dec 2023 09:13:38 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/67] 5.4.264-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231211182015.049134368@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 11:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.264 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.264-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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


