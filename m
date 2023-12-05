Return-Path: <stable+bounces-4753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D9D805DF5
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 19:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0011F2119E
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 18:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1279763DDA;
	Tue,  5 Dec 2023 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixMoVRaN"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AB91A5;
	Tue,  5 Dec 2023 10:46:17 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58d956c8c38so3979941eaf.2;
        Tue, 05 Dec 2023 10:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701801977; x=1702406777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ztbwKI6Jcpyra/1f/euXfg6neSljT4kiu1G9pFbPYo=;
        b=ixMoVRaN61B1qypD1GeBsZ8NoG1ayC6z7Wl+/DSNBzmyqGcN9inalgImzSHxfvnPTf
         5nEF48DpmnBluBw8cp7rHQHV3l3TN3IRs7xAqQdq43A478zmknL4PK3m2dbqprioHNVP
         mjL4jpsDLNlCdmPxAgRdLvmjqUm6XmDcPNq3FXpm6Pgm684Jp8W++9/hf84aIbUaafsY
         W3veVtnXXpSgNgSY23YvehMYu8JRONkMCcQqzD4oBCnUS5UBe3IU7A3OcsPBcRIxCuse
         KV9vE0EEswATcR+LcOjHrti7tb/mGmX5iUiuWXSWv2+UTJPP8R8TdNc63BtI55IWaTFt
         GgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701801977; x=1702406777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ztbwKI6Jcpyra/1f/euXfg6neSljT4kiu1G9pFbPYo=;
        b=c4lmpWwll7T6diP7vWD2w9S3hDodw0+wJ1ujt40EfvbooGIuKwJnnhbBwfqUbNnrHN
         DZjMVW2FuRUO/89BTJU7RW+2IbvJGFF0257PiFHW6OzqxSjkiopRJjpGCCp1lxHooDb3
         bHAftW9k1lW0X7MXZO+DMVdgJm4XPs2FWlIf4vOsxN/SDnxkYpDk+P0M/dgyklE43gKR
         jRGn0RRDcU65LVqI0yxieTegY6mp3GzoT+rYI73HIxuoIufj3hSJXYGXzLypegf+8YPi
         c/YOHm7G/RDeJnwe57GMuvOVsOX5KcCttZ9kl6KowEUJsFMSlAQupNVEk7dl1xsLEsp2
         RNHw==
X-Gm-Message-State: AOJu0YybyaEq7K5LxR01ndQbMErWVK+lRv0/Gdb5AxRwDPlZf5wm2qb7
	zq8K6ykZgV3A4fn5LzY/RXo=
X-Google-Smtp-Source: AGHT+IHNhTyeeUJawENhom0wRXWg11kt1GxkarCQx5XbN515tXLjDYVFoZ+lqxKQAtUfU1aMbrGlig==
X-Received: by 2002:a05:6358:611e:b0:170:17ea:f4e4 with SMTP id 30-20020a056358611e00b0017017eaf4e4mr4940086rws.49.1701801976786;
        Tue, 05 Dec 2023 10:46:16 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z20-20020a637e14000000b005c68da96d7dsm2520922pgc.38.2023.12.05.10.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 10:46:16 -0800 (PST)
Message-ID: <a0218181-6234-44d4-a8b4-fa2dea073943@gmail.com>
Date: Tue, 5 Dec 2023 10:46:14 -0800
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
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20231205031535.163661217@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/23 19:14, Greg Kroah-Hartman wrote:
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

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


