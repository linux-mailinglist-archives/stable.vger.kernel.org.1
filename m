Return-Path: <stable+bounces-103940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD819EFDBE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 22:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9279288CAE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 21:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904C21B85CB;
	Thu, 12 Dec 2024 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7iN6vLm"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47941B0F14
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037211; cv=none; b=LWp7obRQuy2EFvzNKsAnZLRJplmGehjiY7PxJpuFeffCX0jn/x8xeYsNlM8piEn1dY1uafcF8KrYTdmNPC6rpTutjhqik/CYnYr5+pvZG7aWXbOkf1PsnkUcRj/exSg8yVIoiw5VRup9v4wRusPanjExk+rk0kEc1LOr0t/bxas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037211; c=relaxed/simple;
	bh=nC4EmuVP4ntlQc9bu8GJVOZYdMhzB21vlErGfWW8W3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9CO3lURbbbfjOCgZ96748fp4bKezjuTtiEFrdgnMjSOqs/uBzBjkeovEVpiCFm6sMqe2iVBTyYAWTEr79j3YsFzvpKanktsCof6POXZMCzSOPhAtq84Lh2FNUHiB4XqYKrzbl2eZ4SNvhMQgo6HzPIJEegS3oHnY27qIuY24oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g7iN6vLm; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4afe70b41a8so259522137.3
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 13:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734037208; x=1734642008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k6Y1+WixMes/8w7Qpnpmgj9E+CHS4GlCyK+GluDTf58=;
        b=g7iN6vLmX7iT1kCs7eRq3iwoeS56Hcw0FocaPkVbBvMFVFv/rQUCLeLCXLtieSm85U
         s/eXEzG+Jz+CJ1m9f6ab8UAZfDlKmLEd8T0Mx2gF0ZdCfCKXcDAeHgC6eswjmM70V7vs
         f9s5X7nGxOszfy/VgTVc4W5BHVkscaQgekIZiUeqmfnURB3TFUZwY2xUlATGWg8lodTI
         p4RsBzo0Y9BFE64v+LAN9VCpo63UZ5Rd68D6oD48V3K1nvQEEiQdJS+LP7kTKvQEurJr
         1UzW3Ah5In5lRPQvKmiNhEEo+qtdSW6Mc+7zKTXj1KcY8nKzdAyq4bxC1bQNeRV+jMkz
         DscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734037208; x=1734642008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6Y1+WixMes/8w7Qpnpmgj9E+CHS4GlCyK+GluDTf58=;
        b=LDgFQ+muGtz0HE6IoINs9w1A/gahP4UzvlC0Wf4u+oiLYXp13eyXVIScnubNvGl7rF
         kvKjNZV9zmFvj1km6war098q8cXtucLJZ8ddG3geCsHCY2YtKoZUxtdjmnXhW6xhbHgR
         YTLt4V+eLRWh9YvOT91vqEt6IwRACSgGsAd5lvjy7+b5zB38u4tB/ZkDgGy1dta2M/cV
         PXdboOjh0jqoid9+kak4N3XeacORalIs6F9t3agXv63ajHtzrKRxJy6glELSHycsam6y
         2db7boIpcIoTHt85kWv+DKCln61m26ZMPSsVtjE8L6R26ySOM6jZNbrQidbL49WeKq1X
         HKrw==
X-Gm-Message-State: AOJu0YwVGcpBbfKCdpA6X2Gu14cBmS6RmMDng/918OtSz9Ttzxz0n/F9
	3TkxlAZl58cqbDHT74YdFlMnObdu1lX+YgQNSW/qmN6rnO0cdYaNwNCuhxekr5rjCSBA4lvFaJR
	WZmVYn44QNWqhfpuBv2qnABV2posvjuw0q72pWw==
X-Gm-Gg: ASbGnctQkMTmRZYCXjwWP2fGROCVphL718Ta2AfHznbJJyncKrYEjjTwZ28Kyu4q16D
	SYFPultOXuOBvsEpZV0pg2F9SR7JYzQnuT8Hn
X-Google-Smtp-Source: AGHT+IGdvT/mhowuOXBJ2aXodZzIiREIHRQvRQBno0frewBNX+LzZcApS40ykgaLhTzbQyOr7inpeeuIlg31e3nkwkQ=
X-Received: by 2002:a05:6102:1591:b0:4b2:5c2a:cc9d with SMTP id
 ada2fe7eead31-4b25d9dff21mr592214137.16.1734037208538; Thu, 12 Dec 2024
 13:00:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212144349.797589255@linuxfoundation.org>
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 13 Dec 2024 02:29:56 +0530
Message-ID: <CA+G9fYu+u4a+63vCCeLo1LdWhvK75B9j-znx7kp2ZVtzK_H4AQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/772] 6.1.120-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 21:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.120 release.
> There are 772 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.120-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The powerpc builds failed on Linux stable-rc linux-6.1.y due to following build
warnings / errors.

powerpc:
  * build/gcc-13-tqm8xx_defconfig

First seen on Linux stable-rc v6.1.119-773-g9f320894b9c2.
  Good: v6.1.119
  Bad: v6.1.119-773-g9f320894b9c2

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-----
/builds/linux/arch/powerpc/include/asm/page_32.h:16: error:
"ARCH_DMA_MINALIGN" redefined [-Werror]
   16 | #define ARCH_DMA_MINALIGN       L1_CACHE_BYTES
      |
In file included from /builds/linux/include/linux/slab.h:15:
/builds/linux/include/linux/cache.h:104: note: this is the location of
the previous definition
  104 | #define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
      |
cc1: all warnings being treated as errors

The bisection pointed to,
   mm/slab: decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
   commit 4ab5f8ec7d71aea5fe13a48248242130f84ac6bb upstream.

Links:
-------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.119-773-g9f320894b9c2/testrun/26283233/suite/build/test/gcc-13-tqm8xx_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.119-773-g9f320894b9c2/testrun/26283233/suite/build/test/gcc-13-tqm8xx_defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.119-773-g9f320894b9c2/testrun/26283233/suite/build/test/gcc-13-tqm8xx_defconfig/history/

Steps to reproduce:
------------
 # tuxmake --runtime podman --target-arch powerpc --toolchain gcc-13
--kconfig tqm8xx_defconfig


metadata:
----
  git describe: v6.1.119-773-g9f320894b9c2
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 9f320894b9c2f9e21bda8aac6c57a2e6395f8eba
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2q7iTg4R40CXEIVAGM9hWTEqyjR/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2q7iTg4R40CXEIVAGM9hWTEqyjR/
  toolchain: gcc-13
  config: gcc-13-tqm8xx_defconfig
  arch: powerpc


 --
Linaro LKFT
https://lkft.linaro.org

