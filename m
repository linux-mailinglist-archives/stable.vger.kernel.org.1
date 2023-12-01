Return-Path: <stable+bounces-3655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD55B800D35
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 15:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B679C1C20D69
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0A02575F;
	Fri,  1 Dec 2023 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WP/3yrzw"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8979F3
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 06:34:31 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b565e35fedso329571b6e.2
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 06:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701441271; x=1702046071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fln7JZ3gmS5L0otpWNEVUCaXcYxV9vulN7piRIGYzVQ=;
        b=WP/3yrzwIRguyqCqLf5jCa9eFR2me4nTFrvT2SHfOjNyX3yXgnM7eGjmqCQT+Z8nDH
         EX0Vf268SQPPDdXXFY1T8/9Ac6hoJ7S/47i6VRsOIWomlOur5wq2Hu3Syk4aoWwFZOZR
         hDU0mx771UDd0e/5n2GdVfQuibdK7zx2ZvuG17R/WdRgZc6hcjj1Mq+ZBWz1RdhUgXBy
         40va/WsFokJ0/nartux6RNVNeQHankTIAEiQMA6xhbnqeuIiV8Nh9KNgJ885AHX/2WpM
         NolPGTa5jtNEOI6YABpzplx+nipAWLS9m4E5NF8W0OItNskLBcIsIKRvt2P70qgofc8J
         9TUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441271; x=1702046071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fln7JZ3gmS5L0otpWNEVUCaXcYxV9vulN7piRIGYzVQ=;
        b=gtBmideei4QpH68RDpR3E2Ked+Jgri0iZPNHv/FQRUzwdfR6zPiiLiJge/lY9+yZOg
         Nm0WjHl4e2SePKDanew1CLThicRaKOcGMb3y1jEn3gUljdmtXJlpyD3NRTCj4ye8B9WP
         X1E9kM9O4dWhyXp1agUeXWGFSk8wfebikdZjdfht20r8dkMp3i/shszqzGAaIBd490ec
         edvSbTSPGiZBabUaR//0pvh7tujbZbVmAFuAHJY7QMJUC8eneYkkFe4mQdZI1/N7rQnc
         nEdRSjjfb47wz/vPwuQ06ri8n8L3F+K2GYwL+CR0nug2kgB4psJ+d6i+ruR8M/+fxAS4
         6A6w==
X-Gm-Message-State: AOJu0YxToA9w5zTRHgy/cPLxj/SjvLQbRCUSJ/o5EbrqJ/srQsu0rlvp
	dKzzOuFGPyN4cqX3HxuXJmW5RA==
X-Google-Smtp-Source: AGHT+IGlS0ZJiPjHS08tYhuYYizp/NnBi/oTgvFplF5P7lsUqNoJ5XZsvgT8CEP84o377lqBaJlDIw==
X-Received: by 2002:a05:6808:ec6:b0:3b7:73c:ce5f with SMTP id q6-20020a0568080ec600b003b7073cce5fmr3469254oiv.41.1701441271073;
        Fri, 01 Dec 2023 06:34:31 -0800 (PST)
Received: from [192.168.17.16] ([138.84.45.78])
        by smtp.gmail.com with ESMTPSA id k15-20020a54468f000000b003a3860b375esm555786oic.34.2023.12.01.06.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 06:34:30 -0800 (PST)
Message-ID: <4cf40ef6-058f-4472-88c9-3dc735175c85@linaro.org>
Date: Fri, 1 Dec 2023 08:34:26 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/69] 5.15.141-rc1 review
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, Guenter Roeck <linux@roeck-us.net>
References: <20231130162133.035359406@linuxfoundation.org>
 <CAEUSe78tYPTFuauB7cxZzvAeMhzB_25Q8DqLUfF7Nro9WsUhNw@mail.gmail.com>
 <2023120134-sabotage-handset-0b0d@gregkh> <4879383.31r3eYUQgx@pwmachine>
 <2023120155-mascot-scope-7bc6@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <2023120155-mascot-scope-7bc6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 01/12/23 3:44 a. m., Greg Kroah-Hartman wrote:
> Please take some time with a cross-compiler on the above listed
> architectures and configurations to verify your changes do not break
> anything again.

It failed in more architectures than we initially reported. FWIW, this error can be easily reproduced this way:

   tuxmake --runtime podman --target-arch arm     --toolchain gcc-8  --kconfig imx_v4_v5_defconfig
   tuxmake --runtime podman --target-arch arm64   --toolchain gcc-12 --kconfig allmodconfig
   tuxmake --runtime podman --target-arch i386    --toolchain gcc-12 --kconfig defconfig
   tuxmake --runtime podman --target-arch x86_64  --toolchain gcc-12 --kconfig defconfig
   tuxmake --runtime podman --target-arch mips    --toolchain gcc-12 --kconfig allmodconfig
   tuxmake --runtime podman --target-arch parisc  --toolchain gcc-11 --kconfig allmodconfig
   tuxmake --runtime podman --target-arch powerpc --toolchain gcc-12 --kconfig defconfig
   tuxmake --runtime podman --target-arch riscv   --toolchain gcc-12 --kconfig allmodconfig
   tuxmake --runtime podman --target-arch sh      --toolchain gcc-11 --kconfig defconfig
   tuxmake --runtime podman --target-arch sparc   --toolchain gcc-11 --kconfig sparc64_defconfig


Greetings!

Daniel Díaz
daniel.diaz@linaro.org


