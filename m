Return-Path: <stable+bounces-60361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2E89332DD
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 22:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5721C230F9
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88FD1A08BB;
	Tue, 16 Jul 2024 20:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZFNR85pJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2DB1A01DB
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721161168; cv=none; b=SaO3HWSGnbM8oZfAlFYa7IUvkOTaLIYdTiXzTGph2Ux75ETARSfzq367V74WLMdSlUmJ1HZnH+1fX3UzQokpfBQKS4NpVz97boeZVNE7oqmuOLgUYwilHdYZnQcPqplCl1gydohFeMKlphBxjjX6D5iBEYZFFRBBn5XKa6hDIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721161168; c=relaxed/simple;
	bh=xRs9X/zIuhjyr4G+PAXlBtEleLmm/4QgK/3XoMAkxuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WErJba8zN3rftFBX865UrGmDHyyTh6zrUHk7bXOE3iWDsIxhKpneu89hYtLjiZtSIXh6XYyBa1OxluoxyyGukGkn7AATbmFHuhNjzoct39dB+cOIefk022Opj1M8KbGeo63MYl2sRw/0dwkN0kM6PvoCOUkmNz90UdG9gGMHm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZFNR85pJ; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4f2ec49e067so224359e0c.1
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 13:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721161165; x=1721765965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ShLOYvKi8vsHBAFo9bp96se4Div2YHM9RNeuoNs/3KI=;
        b=ZFNR85pJC4G+LGos0GznF7kc8hrmZEb0eCrZo+HwT0ywDq3+vBpzFOLMRsUAWT+TJ3
         bDNZaifSkUID1zqkFvT0P8CrNBA8Czq7wEt2vH3Lf49xtBH6t3QG5TbwcvkDqybpsTQ4
         zxCYQ0HQaui5mObSwT6doKyaMaNBLkC8XhEFg2zOILjccsn/qyrwrxv4zkWdTKkSEoq5
         FuuYCILBk/swho7DjeIdNg06lpDruLNHknEcT77gIVaXc+z5zZQhz6bExM/VZThAUnGT
         cTMoX4O6YHtoxQedJK4LNobkOUEP9Rj3bPVQPBUKldXcZ+P6Xdd6nOJFHOg/iiN+Bfu2
         Q/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721161165; x=1721765965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShLOYvKi8vsHBAFo9bp96se4Div2YHM9RNeuoNs/3KI=;
        b=Gm+Ak9B8NZbEvNW5BMwvlzP6q8HB4VfIgCYFcNj4gP97r4VbBq0Y+2sW2mYTTQa2yj
         jasWhsviOdkhsQdRB+QOKATuEgDRhBqex5tEkp+Oy4G6sHmYB1s3dJ8wEF71rfeVU7Pl
         sSouxp0qlxuLeIJfIp4ilw5ralYDNo9R3AqaATLQxKVI0yrY6KMVHVdlbe6IIs56KYne
         fnx/U2B5nCJTa6BjTvIbAFz01xVsfGCT14qJqg0rg2twR5Ly/E9Pn71xEIdTd2kXMGi7
         gVzHh+RWUfbfRxSnx6iOua9gVkCPOtC6e1qvb3S0gaNCOgRwlQE73EUPleQtVGKb9n5y
         ZG2A==
X-Gm-Message-State: AOJu0YzdXfCg/yPtut9KpDfMRHHApm/EMpyq6Y/AuHMGqkQ0LednWkqJ
	lZhNBcUwkRJd+3bC5aQozKYJOL0kNqhJ/gtEAwekNGBLFXWB9HBGkSSu+/1VjjAA5zRoYTRU5os
	WpFfqHMFw8r1tRMAdj2n3FdzrBtHiqTSYmcyw6JQsyEA2WfmA+XS91A==
X-Google-Smtp-Source: AGHT+IEhFbbeQTqWecix0OTUYlT5I7+az0amKdkeLMhx7c+cOrhFs6TyPr8ulUAYZZmQ7DVatjck7YtX+wTCXehOqto=
X-Received: by 2002:a05:6122:1686:b0:4f2:f2e1:5f04 with SMTP id
 71dfb90a1353d-4f4d714aef4mr2572075e0c.8.1721161164744; Tue, 16 Jul 2024
 13:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152752.524497140@linuxfoundation.org>
In-Reply-To: <20240716152752.524497140@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Jul 2024 01:49:12 +0530
Message-ID: <CA+G9fYvVaSX9Ot2vekBOkLjUqCx=SbQqW4vWhypCnGwwBmX4xg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/144] 5.15.163-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.163 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.163-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The s390 builds failed on stable-rc 5.15.163-rc1 review due to following build
warnings / errors.

First time seen on stable-rc 5.15 branch.

  GOOD: ba1631e1a5cc ("Linux 5.15.162-rc1")
  BAD:  b9a293390e62 ("Linux 5.15.163-rc1")

* s390, build
  - clang-18-allnoconfig
  - clang-18-defconfig
  - clang-18-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-tinyconfig
  - gcc-12-allnoconfig
  - gcc-12-defconfig
  - gcc-12-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build regressions:
--------
arch/s390/include/asm/processor.h:253:11: error: expected ';' at end
of declaration
  253 |         psw_t psw __uninitialized;
      |                  ^
      |                  ;
1 error generated.

metadata:
----
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2jKu9JqgTsYkPJ9AeEnsDPajz9p/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2jKu9JqgTsYkPJ9AeEnsDPajz9p/
  git_describe: v5.15.162-145-gb9a293390e62
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: b9a293390e62ec049b3795fd1538a2d2654dfd0e
  git_short_log: b9a293390e62 ("Linux 5.15.163-rc1")
  toolchain: clang-18 and gcc-12
  arch: s390

Steps to reproduce:
---
# tuxmake --runtime podman --target-arch s390 --toolchain clang-18
--kconfig defconfig LLVM_IAS=0



--
Linaro LKFT
https://lkft.linaro.org

