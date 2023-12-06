Return-Path: <stable+bounces-4786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F6D806437
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 02:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA495281F77
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 01:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A3510F3;
	Wed,  6 Dec 2023 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FX1D24ia"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAD81B2
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 17:42:07 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35d626e4f79so3936305ab.0
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 17:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701826926; x=1702431726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fl6uSMPG668/bjfJHguE8uLZnjAsB2+IPr+krcKfck=;
        b=FX1D24ia6wXJueCrn+VomkxiJ4rhPcg+v+2dHIy4awzTorcLqer5x3ZFdNKF6hq7Tv
         i7eHsE4H93rp8cMwXyZyizOf8HZI3j1sEJPMV2qugpzBPohB++m9hhEe4wlxmEZ5m/R5
         +8H1sB2TRgP/4SLUZcofZYkbC9RfOiWdcZs6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701826926; x=1702431726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fl6uSMPG668/bjfJHguE8uLZnjAsB2+IPr+krcKfck=;
        b=T7vqE4K96dbjzaX4LnsVYzHFASMl4h89aXLROc5etiN5OAK4rQ2299z5BGPHXdeHvL
         u31yfJcSDNKeVyJlAPj/G6nk04arCmdvjLtZCIcdMtSXS0OSpkYUmbhy1FQqIfImUHhP
         qCUdA1uNWmmHOerGA9BheN7mHTfJr9xi4Cl3EPPg//4ba1r+j1omRj4+3VAtB8Pqukcw
         hvu0xsGSbwbGUfyQVvdoZUKX4DI6VmEz+Dn4lr1ysAksvzpC8PmTHzDUGEq8aA9HL+n2
         ZcdTHksHEFuIImR/rwFMJhURD1B6Pyels0AMbSWa8FqpDA4OBKUc+86nMwumVuPMYFVk
         B3KA==
X-Gm-Message-State: AOJu0Yxs/nyeD7FzoEKJ/56ZuvuKqC3y4EFZV58nbJEakx/nK8s4djtL
	znPJVJl41AYJDeeBjfO/vPvhSA==
X-Google-Smtp-Source: AGHT+IF7hRY676SlJdoe9e8zBAvOI5d9KgVkzLLXriIYVg++bbCrtMIl8ujxLr4pqmY+X8IPNmWltQ==
X-Received: by 2002:a5e:c30a:0:b0:7b3:58c4:b894 with SMTP id a10-20020a5ec30a000000b007b358c4b894mr581932iok.1.1701826926536;
        Tue, 05 Dec 2023 17:42:06 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id o2-20020a02cc22000000b004665ad49d39sm3423615jap.74.2023.12.05.17.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 17:42:06 -0800 (PST)
Message-ID: <45e7a76d-6003-4840-8d0a-b20adfa42a36@linuxfoundation.org>
Date: Tue, 5 Dec 2023 18:42:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/107] 6.1.66-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231205031531.426872356@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/23 20:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc1.gz
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

