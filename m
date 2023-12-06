Return-Path: <stable+bounces-4784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4CA806431
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 02:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D29281DFF
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 01:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116AE10FC;
	Wed,  6 Dec 2023 01:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IA9/SqMe"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100C6120
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 17:37:41 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7b38ff8a517so27121439f.1
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 17:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701826660; x=1702431460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsMy7T3EG2zYRwsChqog9nsZDeN6t1YOUu6K4nSNjSI=;
        b=IA9/SqMeym09rw7D1p1X6Mv++GL2nwJ9jeLPnCZOq/91ai7vfqV+V3u9I4EXOgGkQ2
         UU7ZCmaUczhCg9ITw0gnXpkBatSFK6W/1gM0ZM8g391ag9AYquJhzkOj8q2VIvRyuiQk
         0Vm1uIXrUvHH/DvYtC2pNd7CuCG8g4BHOO7es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701826660; x=1702431460;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsMy7T3EG2zYRwsChqog9nsZDeN6t1YOUu6K4nSNjSI=;
        b=Q9cM8C4xuQdgSC995BXJP1jUTSe3XpfFOCLmnkXHCrlEL83ymj7BKeD8BjYUdK3yPC
         j/BAuU4/WddMsp/7fAAacJNpLwZPHltUvkSpuoX8GEQOlnu82Q5L+ZVxUGY3P8xGQmGo
         aozxKSgLAs3LXWZLzIBswKq0z+aLhNIiIFJfGZzZIO7Y0pKuvg2Ba215LX1fu8E/GULy
         qL6YOH8HqY14pf9R16JaNx0mteozMm0D7BQuYVXo0gvbuJSSuHUdy/coaCrT8HqhtORi
         yrzIZSaM6dZUtOpO9gtbgoMtC8TLRRoluCWbd3wdzYiE+9gCm10NEIDmYnSJ3WScd1HD
         /pOA==
X-Gm-Message-State: AOJu0YzHudtaoMyID8DvBe259afaEY7KmXl12EThOATroSNvFOyEqsUc
	cxwNt9dNTZ2XMou70JzJAaTiSuHK8jTow8+JwH8=
X-Google-Smtp-Source: AGHT+IHdO250DHcjWcfyqUmHLuU/KhgKLl62WKWorND1qPqtBYPDYhk8HQGQyYJRy4S6yz6f+OeeSA==
X-Received: by 2002:a5d:8715:0:b0:7b4:520c:de0b with SMTP id u21-20020a5d8715000000b007b4520cde0bmr494655iom.1.1701826660337;
        Tue, 05 Dec 2023 17:37:40 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d25-20020a056602329900b007b457549001sm931003ioz.36.2023.12.05.17.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 17:37:39 -0800 (PST)
Message-ID: <4d7e7b23-7fa7-44d1-ac5d-ea955b2aee75@linuxfoundation.org>
Date: Tue, 5 Dec 2023 18:37:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/23 20:14, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.5-rc1.gz
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

