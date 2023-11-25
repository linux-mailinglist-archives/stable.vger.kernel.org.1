Return-Path: <stable+bounces-2621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 274697F8D8D
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 20:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE007B20F90
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 19:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CC82E839;
	Sat, 25 Nov 2023 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvLOKyV/"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D51AF3
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 11:04:07 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1eb6c559ab4so1749725fac.0
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 11:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700939046; x=1701543846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVLgTfi8XS7NzCAGMfCjECNo5pKytb4Hcwd/ayxLWKo=;
        b=lvLOKyV/m6GEZ+LeXnxbYj6bdNkVb8+7qZM2Ys6RIuK+FO+0eE9s3XKFF40dViP8ho
         exskOXOvCHihC0jkuhSj7+ZyJmBoi/C6h3T8bRxFl0baFcYNCB0HG6HbK1b57trAV/qT
         ZD08NQPabWAEq9QR3pE1r4Xc8bxOR0a9ggmN34FhuTwl75tesmMbADRZXsGOfGAxJMSO
         QCS12CPVfhcMbJuEvvnEnL8VKizFeV98IZ5n93/rqP9k+ahTs78u8thczDa7wjszBdZA
         PFXDA9LAUETK38gEzmcrz19gakTZtziPbsH19l1lklJDtrwu0K9V27E/M3HlzVrgmmma
         b3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700939046; x=1701543846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVLgTfi8XS7NzCAGMfCjECNo5pKytb4Hcwd/ayxLWKo=;
        b=FNX5ttO0Tr91LFB6jpOhM/0h16ZR5ywtUX3nAbLp5qTRYCiuMS6K50qH4c64rwKYNp
         Us/yCmZ7dCVX2ysCYHkg6mDz72wv3W3Sz2rzFaZ8sAhM4DeDc5b5+8yzRWlcFwvOGZOe
         aN8PxObiu0Eto1T4duI1U/3SBY+TknsIaLPRmeQAb/3Kr9AJU5ArqhXezHuDSgaEjh3c
         aHgofNRU1LgDMcuYrF8YdbC0mFI+mllX+qnLIqI5+tKaFkRokODJ+lBg6cWAtob1D06o
         wrA+2qSa3w33cIZ+8khQUGNka5p71mZjvFNENsauS1Jmp4cEYl3l7oQxBwuvMsj9xDTb
         Merw==
X-Gm-Message-State: AOJu0YxnAKDJNaI132xM4uv3AwW5OMhN4c1LwAs6c8FojXXl+XqrzsKG
	aRXJt3A6hvRmWwH4Qm+KuYPfNGDTANC3CT87PLfHOTHw
X-Google-Smtp-Source: AGHT+IHgZdgP1on4N3LC80KMS2IdPjMpvNSJF4hrYp4qKVG6WSLUKFgvqub9oOpsaT5uF79VJ4IXnQ==
X-Received: by 2002:a05:6870:209:b0:1ea:e36:70d9 with SMTP id j9-20020a056870020900b001ea0e3670d9mr7900604oad.20.1700939046155;
        Sat, 25 Nov 2023 11:04:06 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.70])
        by smtp.gmail.com with ESMTPSA id le8-20020a0568700c0800b001f4b1f5ac0bsm1412893oab.31.2023.11.25.11.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 11:04:05 -0800 (PST)
Message-ID: <e819d653-8a1e-4088-a4dd-a093356da8e8@linaro.org>
Date: Sat, 25 Nov 2023 13:04:02 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/528] 6.6.3-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, hca@linux.ibm.com
References: <20231125163158.249616313@linuxfoundation.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231125163158.249616313@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 25/11/23 10:33 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 528 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.3-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We see this build regression with System/390:

-----8<-----
   /builds/linux/arch/s390/mm/page-states.c: In function 'mark_kernel_pgd':
   /builds/linux/arch/s390/mm/page-states.c:165:45: error: request for member 'val' in something not a structure or union
     165 |         max_addr = (S390_lowcore.kernel_asce.val & _ASCE_TYPE_MASK) >> 2;
         |                                             ^
   make[5]: *** [/builds/linux/scripts/Makefile.build:243: arch/s390/mm/page-states.o] Error 1
----->8-----

That's with Clang 17, Clang nightly, GCC 8 and GCC 13, with allnoconfig, defconfig, and tinyconfig.

Bisection points to:

   commit b676da1c17c9d0c5b05c7b6ecb9ecf2d8b5e00de
   Author: Heiko Carstens <hca@linux.ibm.com>
   Date:   Tue Oct 17 21:07:03 2023 +0200

       s390/cmma: fix initial kernel address space page table walk
       
       commit 16ba44826a04834d3eeeda4b731c2ea3481062b7 upstream.


Reverting makes the build pass.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org


