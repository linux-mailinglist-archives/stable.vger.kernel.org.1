Return-Path: <stable+bounces-41334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596B08B0393
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 09:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD6B2812DF
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 07:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAD81586CC;
	Wed, 24 Apr 2024 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkiiVk0k"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB4E158218
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945437; cv=none; b=pX5PdDxKLrcZxMKLa43EsWMETFq7O3nMhGpgiR4qgn0UtWTaTM5Xsrw6E1pcs+L3qfKFfDfvEYJqcbwHUgJczLVajbLldjqOKH7cOz4aIqBX6nl0AtooaJ28YhloIDlb2T1GDYk3sk8GRrB1pbtt+4BgUVoQAGv+3wiytbDrJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945437; c=relaxed/simple;
	bh=Or64OaneAWMEOpHLPP9hFWsP86VsJI1ybI9wBjzPf4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNwHgbiVWZK+1wfjZdDsgYZqtENi6py4zuzf8agjWkkiOMOSlb1g5G3Pz6VM0p7ZHq4KGZ0g7WWjQieARu/9j2DV3Yz/aBcqDraW026zAsrfn3tLDBTFbmh6dCPKhujnSwZHkdPozxb/6lvPzlCSJSIc6LSWi8ND5TD2vM8tDmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gkiiVk0k; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7ee1dee900fso570223241.0
        for <stable@vger.kernel.org>; Wed, 24 Apr 2024 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713945435; x=1714550235; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UA2CVXNklvbf0LWrbUSmouXmAKtxu5bf0ARspZd3rk0=;
        b=gkiiVk0kU3cUlosxTNSomjqMd128jrplNoxCvP8jShbz72PusgBj608q6ETjgQVw7L
         tn5LUPczwDJLRRHMqstLwapWJRAmRJaRd1UNx6lGxiy6WBlSP/B8t5MuYyBvkDzrxKfx
         EdFvGSfxhiQcn30QtKHX4vQ45Ap+eLXum9L1/e9Nnt4poQY2YebEZ+IcRNdwyjK8gWt1
         d71+fOg0tBxIoeTrREXkzQvix2NYWWXaVXsxPm6j1PTvGoVDqBtgMWy7tQkdOSGM6PSv
         a3wcJsHKXk9HrdWn5Y7A8l+jONJ8wvzqBxNqJqAcXkhe3CQ/Bhd/dAguCxRB75gGx1YP
         SD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713945435; x=1714550235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UA2CVXNklvbf0LWrbUSmouXmAKtxu5bf0ARspZd3rk0=;
        b=KEMjoaBV88k+rlSnFkp8e8b8YDvyvBWJIH/hFUL+3xsh9mYhNttQq8UIRpQhFRX2/y
         CGMm/wDZcSIPMRQhKoRpEXed9BE+RkfzRpucqOzKKVujKeUjyahmfBtC9oQsP5prs55x
         1/k38Tu3GD557kEgpT2qx3F6ti95W/3qmQKa+Y6a9fCYMdKgoRp61/B7KpDfJZdM0l+x
         hFe4Ju//+G5uiYMYxVV4NEUwePJrxMAauiVW/y8ofeo3YoYxfNEHaOLOpx8ClPwra8rA
         iGjuqnQkXp9e70LdSs+NDzmleAO69RkfssEDPKq4Q2BLc4zdUV2c/cBxWCWlzJ0hmjuH
         ULbQ==
X-Gm-Message-State: AOJu0Yy2VUfGJ6pYJrWMMBKlOpR9z7hy9XUaLxucafJt+oDnyxzwCYrK
	C9hbFAd8z2KfxRhzvJVf7Tct29g7fMRWs/wYOGsCOlgWT3WSjtIyyscA4haOTiFOCr8052Hua/v
	R1dabQX5U0DEWKLtzytumzdBND/2Dt8CDYuQfCw==
X-Google-Smtp-Source: AGHT+IFUwN08g7BSlDM6prRxw/urZVDh3+vum7FMACj7zISxNt8w6l0rqBWyuUBUbfTG9y+9p1LtvpT3K2vwBvNOvOI=
X-Received: by 2002:a05:6122:c89:b0:4da:9a90:a6f2 with SMTP id
 ba9-20020a0561220c8900b004da9a90a6f2mr1806626vkb.10.1713945434922; Wed, 24
 Apr 2024 00:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423213844.122920086@linuxfoundation.org>
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Apr 2024 13:27:03 +0530
Message-ID: <CA+G9fYsm9OYUh+H9X2kpJWXsPdde36=WbSWc+mU0vO0i-QaWOw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/71] 5.15.157-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, linux-s390@vger.kernel.org, oberpar@linux.ibm.com, 
	Alexandra Winter <wintera@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 03:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.157 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.157-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The s390 defconfig build failed with gcc-12 and clang-17 on the Linux
stable-rc linux.5.15.y branch.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---
drivers/s390/cio/qdio_main.c: In function 'qdio_int_handler':
drivers/s390/cio/qdio_main.c:761:52: error: incompatible type for
argument 2 of 'ccw_device_start'
  761 |                 rc = ccw_device_start(cdev, irq_ptr->ccw,
intparm, 0, 0);
      |                                             ~~~~~~~^~~~~
      |                                                    |
      |                                                    struct ccw1
In file included from arch/s390/include/asm/qdio.h:13,
                 from drivers/s390/cio/qdio_main.c:18:
arch/s390/include/asm/ccwdev.h:172:50: note: expected 'struct ccw1 *'
but argument is of type 'struct ccw1'
  172 | extern int ccw_device_start(struct ccw_device *, struct ccw1 *,
      |                                                  ^~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:289: drivers/s390/cio/qdio_main.o] Error 1


Suspected commit:
--------
s390/qdio: handle deferred cc1
  [ Upstream commit 607638faf2ff1cede37458111496e7cc6c977f6f ]

Steps to reproduce:
---
# tuxmake --runtime podman --target-arch s390 --toolchain gcc-12
--kconfig defconfig


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.156-72-g70f39a25a6b8/testrun/23638097/suite/build/test/gcc-12-defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fWFs1EvyrjLKUD3D6ODW0Agksv/

--
Linaro LKFT
https://lkft.linaro.org

