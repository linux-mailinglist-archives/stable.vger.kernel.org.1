Return-Path: <stable+bounces-25285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3925869FAF
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 19:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC021F2DFB2
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 18:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B125148FF0;
	Tue, 27 Feb 2024 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mbissrDL"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA64D107
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060197; cv=none; b=BkGkF6PDkgndhJCY0HoK7jxqy5zMG4uGQARcrmXhlalzQS5eyfXwepz+Gx9wItzszrUMpjrvT24YD/XLYnNrM4cRZvTjNMI9Ve8ZW1KzN4aru/XyevGqycqGLTgoZQjL+HYIW6iXTMaElbDAsvyU4RsMS2u3bHtXmeyH89vuulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060197; c=relaxed/simple;
	bh=joxNp0GzaDrB+Tqo0IVLqZ8aPuRQJFLXfeoomOYwaIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fn1/LfLcsBjou6+p+ZzWNh0LxBIFd7/DfeZiUet7c9/FqheatvLQMPZ1e3O56CzEn+L8n2clKj6m6p/eYKMqFzrgtMDy1CyYfrl3ZhJfxnefeQ2LAYON+B/ZoPFoJqUAx3z/il4XSjq4iUCYVVTmF7dj2W6nrRnHOHahMIoZ6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mbissrDL; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a089f333bdso1340086eaf.3
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 10:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709060194; x=1709664994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZ/MgDmSYcNeqlWlA/LkDt8FR4v24Xer+dQHBBLw5yg=;
        b=mbissrDLcEw08HfA5gwT1CiKZFs8FN6XKAzkfjVq0nyCfPGalOSnvf+XOkYdvF0j7Z
         d4l75x+kIbc6x4lISmB1IxZ5yWL8wZnZu0D2AlGwxf1B627PdDFBllVJu7zQxmRyBszH
         KbvoYrkt68allZjtrO8jGMhaWd26mwNLFrZQ4MnRSBXOVEIXMaz9+Na1SfjxsuYsSiMX
         zEfuNuj7NhQs3ek42C4ijmAWcpKvMACwv6yscRfUxVbw4j8PbuTm/ka4WVFdUvOgpb4b
         iMFGAoxnFxcIK5P1u2siGyvg0AbQO0xXVh0A1rBdVbC7WvuUp+s7nkb6ACpBUVkqQrt5
         W1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060194; x=1709664994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ/MgDmSYcNeqlWlA/LkDt8FR4v24Xer+dQHBBLw5yg=;
        b=lqajYmkW+DMyTojN9b6gHVQ6v4T8Nis5cg+7poQ/2AFte/4DZiKRBxKuR08gkq11h5
         CVfd0EtrvVWagZcWgMbP87co3NPrKYgZJw36gwxjAflYLxm0e2IzNfvKM+RADIAEK9K2
         F6zUKbJmG2+mOWpuJRJ83t8M6dZndmhpOmZMaPhK2sjboGlvBhrhTyVJpdWzlCYV1QAS
         gU6Wj8NziINOQVd46CsQLzgoqyy7ldPSuAdx0yKCvco6lYxLKoio+yIbW+i445pVZUl/
         jaVK5lZAeuFHmQK6VnnxREL7xxFGw9riZHhhnQYDIKhsRrPEweVnV0/I569CQE6OEuNA
         ogug==
X-Forwarded-Encrypted: i=1; AJvYcCUWqXHVUeegMjY1pRoMqFjUID4NzUQUeI+PkXZ8Xb0btTcyGl2niJRn92r04qn/St5GH6VMrNeBwDyZfSv6VcXfVZQV2njP
X-Gm-Message-State: AOJu0YygwRBmDQzQ9VRPZUDQe4t+vJfs3RxpSRC6vxvGXuBingzcZZV2
	hu+9gOHQLpiUIGalGw6Aev5V+NLzPvW4en3y2Xb/yB4h5ivlzPkvwNggyXTr1D8=
X-Google-Smtp-Source: AGHT+IFBcdrQIWIklX/t7KgJfjyLYOQtoqH4hV/tzjIuc27CYI3IKgucuOxGE8u1vPiECk5Z2JE+SQ==
X-Received: by 2002:a4a:3053:0:b0:5a0:ac20:155a with SMTP id z19-20020a4a3053000000b005a0ac20155amr3057942ooz.9.1709060194427;
        Tue, 27 Feb 2024 10:56:34 -0800 (PST)
Received: from [192.168.17.16] ([149.19.169.47])
        by smtp.gmail.com with ESMTPSA id o12-20020a4a384c000000b005a0af4efa0dsm377271oof.21.2024.02.27.10.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 10:56:33 -0800 (PST)
Message-ID: <ac2c579e-4ff0-42e2-ab70-efb8ded2d257@linaro.org>
Date: Tue, 27 Feb 2024 12:56:32 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/245] 5.15.150-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, paul@crapouillou.net
References: <20240227131615.098467438@linuxfoundation.org>
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 27/02/24 7:23 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.150 release.
> There are 245 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.150-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We're seeing build regressions here with RISC-V, with GCC 8, GCC 12, and Clang 17:

-----8<-----
   In file included from /builds/linux/include/linux/list.h:9,
                    from /builds/linux/include/linux/module.h:12,
                    from /builds/linux/drivers/net/ethernet/realtek/r8169_main.c:12:
   /builds/linux/drivers/net/ethernet/realtek/r8169_main.c:5512:35: error: 'rtl8169_pm_ops' undeclared here (not in a function); did you mean 'rtl8169_poll'?
    5512 |         .driver.pm      = pm_ptr(&rtl8169_pm_ops),
         |                                   ^~~~~~~~~~~~~~
   /builds/linux/include/linux/kernel.h:46:44: note: in definition of macro 'PTR_IF'
      46 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   /builds/linux/drivers/net/ethernet/realtek/r8169_main.c:5512:27: note: in expansion of macro 'pm_ptr'
    5512 |         .driver.pm      = pm_ptr(&rtl8169_pm_ops),
         |                           ^~~~~~
   make[5]: *** [/builds/linux/scripts/Makefile.build:289: drivers/net/ethernet/realtek/r8169_main.o] Error 1
----->8-----

Bisection points to:

   commit ac2871f646a8f556203f5b6be875ce406d855ddb
   Author: Paul Cercueil <paul@crapouillou.net>
   Date:   Tue Dec 7 00:20:59 2021 +0000
       PM: core: Redefine pm_ptr() macro
       
       [ Upstream commit c06ef740d401d0f4ab188882bf6f8d9cf0f75eaf ]

A revert could not be done cleanly.

Tuxmake reproducer:

   tuxmake --runtime podman --target-arch riscv --toolchain gcc-12 --kconfig defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel Díaz
daniel.diaz@linaro.org


