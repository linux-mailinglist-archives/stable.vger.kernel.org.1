Return-Path: <stable+bounces-6360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4C780DB0C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 20:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D60BB21480
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF2C537E2;
	Mon, 11 Dec 2023 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzGRFcNt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D26DCF
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 11:46:10 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6d9f7b3de20so2156897a34.2
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 11:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702323969; x=1702928769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImaO0HiB00KnmVvwdifGKd5anpGyBP2weFFw/cHgfm0=;
        b=bzGRFcNtXGxXGd0elFCIYAG7sQ/GCXBilAKd7sQqWlkhsnXinGaDAehZE7dROc4O4U
         QYIq8oNqqMi82ux8L+l8o+JyROd1KBbo1XnIHz5J0pvsP/rxmj7ZfIdzRg2gdeKrIELr
         oedjTh1/di/bkyFUW3BqBXAMxdhmi09d3DQlshu0PiwSELR1//HZuhhMKxWrthcyHF4d
         Tda9q3ntU+axV+Q7IF74gHU5DPplc6gFxmXJMwUnuPgz9u4eGasvkYf9Q0bD9z81T1b/
         QRD7FGfPOL4UpLUsA//sPs6zlApFneO4VimXGQZ96urjQIQDxzEk2I540HJM77nZg3Ty
         JM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702323969; x=1702928769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImaO0HiB00KnmVvwdifGKd5anpGyBP2weFFw/cHgfm0=;
        b=J9rFuT9TD9UTTtXPjrhAWC4On3CAco0H0vtcji3epzANpgR2K1J98HtEMISx3H26cX
         Yl6vc2gs44s71OL8XkaZuAMP5Vj1sroUsjBIPvkQxF7sbnprDQq/dAbX69rD7FQPLfZC
         CfSLo9xIOa0URQUe5l6anmz3Fk8tgAv/X2b9+nIil0mZHnAu7vyNIb3j9Xy/9Uznd0kv
         QxB4HXZGxvfjSj7LGGzJIMxcc8rrs9eVT2mXym61OefGISMhtahhcuw21EoCpF9mRtdN
         QR0vllO7q4LNuCqCJMzpecEq4CnYelBIkxdN3c7DPc/8KlBnzj/qAKAuYuakwoM6D9F2
         4YUg==
X-Gm-Message-State: AOJu0Yxh8hGv0PrnlHeokOM3kuz+t9pPaeDwWDyjQKrOP011AiMDijZD
	3cEiwu4bsijeZRYArK3VRzbV3A==
X-Google-Smtp-Source: AGHT+IH7YlVHb83oEeaYR5yfIB5dT4KgPf8C+yd99M6a4B7imAXNABkjzoUjSei5n/PxEabG+OtZsA==
X-Received: by 2002:a05:6870:c07:b0:1fa:f0ed:6865 with SMTP id le7-20020a0568700c0700b001faf0ed6865mr7000027oab.5.1702323967203;
        Mon, 11 Dec 2023 11:46:07 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.113])
        by smtp.gmail.com with ESMTPSA id j1-20020a9d7d81000000b006d99cb99f25sm1835434otn.81.2023.12.11.11.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 11:46:06 -0800 (PST)
Message-ID: <f63a13c6-7e19-42a9-89fd-c37249a855eb@linaro.org>
Date: Mon, 11 Dec 2023 13:46:03 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.14 00/25] 4.14.333-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, arnd@arndb.de
References: <20231211182008.665944227@linuxfoundation.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231211182008.665944227@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 11/12/23 12:20 p. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.333 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.333-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Linux 4.14.333-rc1
> 
[...]
> 
> Arnd Bergmann <arnd@arndb.de>
>      ARM: PL011: Fix DMA support
[...]

We see a build problem with this commit (at least) on 4.14:
-----8<-----
   /builds/linux/kernel/sched/core.c: In function 'sched_init':
   /builds/linux/kernel/sched/core.c:5962:30: warning: the comparison will always evaluate as 'false' for the address of 'cpu_isolated_map' will never be NULL [-Waddress]
    5962 |         if (cpu_isolated_map == NULL)
         |                              ^~
   /builds/linux/kernel/sched/core.c:87:15: note: 'cpu_isolated_map' declared here
      87 | cpumask_var_t cpu_isolated_map;
         |               ^~~~~~~~~~~~~~~~
   /builds/linux/drivers/tty/serial/amba-pl011.c: In function 'pl011_dma_tx_refill':
   /builds/linux/drivers/tty/serial/amba-pl011.c:657:27: error: 'DMA_MAPPING_ERROR' undeclared (first use in this function)
     657 |         if (dmatx->dma == DMA_MAPPING_ERROR) {
         |                           ^~~~~~~~~~~~~~~~~
   /builds/linux/drivers/tty/serial/amba-pl011.c:657:27: note: each undeclared identifier is reported only once for each function it appears in
   make[4]: *** [/builds/linux/scripts/Makefile.build:329: drivers/tty/serial/amba-pl011.o] Error 1
   make[4]: Target '__build' not remade because of errors.
----->8-----

Reverting that patch makes the build for arm/u8500_defconfig. We'll continue looking for other things.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org


