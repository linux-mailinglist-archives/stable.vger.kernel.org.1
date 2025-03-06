Return-Path: <stable+bounces-121227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B2FA54A8D
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 13:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD85165920
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 12:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076C420B207;
	Thu,  6 Mar 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhZooeJG"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9A19C574
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263732; cv=none; b=sOmG9jKnZTS+uTb5zCIxEO4ClSQdavhfpFhQJ4HXcTioLOUTk4bEhQFlRKUmarkpbZDYnPmRBE3yz5d2BnQyfe+HcvqDZwNEjpjQS4EERG2fquGXxxlHjHH7T7fOjXn9ONpb4bcsuZsSVkFT2V/vEIopssU0Nz6RkXBNQTyVfu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263732; c=relaxed/simple;
	bh=8WpiNtP4SUsV2btOYYsU6TNjuaweKXpboF/a4bcaaGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B82AW5o8XgHMufjl17SJsXizfDIcmwDSD4lphI0HX30GSA/nflVKX0ftBKE8WdcAPFYej8NZnLXXtGEHUf/NwMZGjzF8VlIoWnl/VqEK08TUM4c6r1LeW2eh63Lkw+LCcjPdmxX8Ad5HSsqJXN9Xrr0DM09/BkYkzFM1nDwf7Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lhZooeJG; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523c67dba31so247731e0c.1
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 04:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741263729; x=1741868529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NMaFzP48YFinEhiZrVchmGEvLHB/ao+cnP7Dht42RRM=;
        b=lhZooeJGKHcWX2pgKIrhdsCMV/xzmLFp4cdRGNcr7F5lsq6bGufTMT+029mcA6zmA/
         sS0Dhw+3hXO7lJu4Nk8YOujzswLtrFVJEq8z5DzE9EpDZMSRpS21VJx/WLhrD1aHcLu6
         HUnNTBTyqhzcW0hitGyqb0BJqAEWExi8WiE1ZVKxZAbjyNlscXlv8FeQg2ABysM2wqOI
         SAMtWD+cwBzaeQuN9I9bJ84tyqOBGWRv0fyBzXJ4LOd6n9QbzYipcITRoxxrF3EdKWfx
         aNodIWdmKxEx5JMIUyQ7q5KIOo2QOK6nICF2dFcW1ECS3zjdr99C423yi8eUElK+FRfE
         vktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741263729; x=1741868529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMaFzP48YFinEhiZrVchmGEvLHB/ao+cnP7Dht42RRM=;
        b=rIDQkQcKIkcali1cerNJLMb2fNa3Kgf78gHFBAJyydtQz1gecOH8hIPBvLJRqzWuEa
         Uz8mN12W67/1I5vyOuB2KvTVIT8gvjc/Le7bbz/vlH7G8nNVAqzJO87jxrJvVCgjlio+
         +OCJHWzufoAMF7SrZPgDdwrobcU+6SgvmTBgS1CzMgRT/TbQrBJb+PlOZvGuvu7BjY6F
         KQFFjgqFsYObW7BloVW8sf+xAh3BvDvl2w7ZTqtARkQ82rs09DHPZoaj13dpqEsELdYN
         87Ll2CUFsUuxis75R6u8UdQ+EQ9gDGgNOFyllSlAulhijqeaR79vziArfwkQ3gdOS6f+
         MNDw==
X-Gm-Message-State: AOJu0YzHwBeEKX0nzP5lgzS7CUdheGDIlHykGHa/ZF+2we1YO6DsKXvC
	XwgVFuksoaawFL+ky11Dg06Cj+lXoweuxLjekiO+7jf74/0Xf+MnC945a5Jwv4Kk4PfIa+m+ld1
	h1mhyylQhenMgGkCycBWsoQQ+CTqWz/VZGmC2EA==
X-Gm-Gg: ASbGncuukUpm/GSkQLW++f8zw0mP3zSWEwgvZQLnhK4Am+THfAVgzaYNQQSVB/zeHae
	dMoEnXYypS3WoOHcQPuOutaJiQuiTvYUFGz3mmGLx71mYswiiFw7gWgrl54DtkrJfHhJSopcpj2
	yGzaC4l4UNX6gak7ZHE1QahyohdhVb+sL6HTN7RPAGa/hTB6F0TrSmkjISUw==
X-Google-Smtp-Source: AGHT+IFYww1kZHMpxt5rfe7etSrcj4Kd67QgSomHrhxf7n7GkfeEsvd0m/xOfmDxwX0pwVAOrU/zMPkV6Cfa8MEglrY=
X-Received: by 2002:a05:6122:d21:b0:520:5185:1c31 with SMTP id
 71dfb90a1353d-523c6281025mr4217547e0c.9.1741263728875; Thu, 06 Mar 2025
 04:22:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305174505.268725418@linuxfoundation.org>
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 6 Mar 2025 17:51:55 +0530
X-Gm-Features: AQ5f1JoHOMnMdoj85LLhhqMa2z8QuDprDq4v5xGuh6PRQjSvUsaQu0qsUl8-2Ow
Message-ID: <CA+G9fYv9CcsWEywck9qivOVtThrmr9UUiu-RdPnrjVs9k5JxTA@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/157] 6.13.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Ryan Roberts <ryan.roberts@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 23:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.6 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm64 the defconfig builds failed with clang-20 and gcc-13
the stable-rc d 6.13.6-rc1 and 6.12.18-rc1.

First seen on the 6.13.6-rc1
 Good: v6.13.3
 Bad: 6.13.6-rc1

* arm64, build
  - clang-20-defconfig
  - clang-nightly-defconfig
  - gcc-13-defconfig
  - gcc-8-defconfig

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

This commit is causing build regressions,
  arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes
  commit 49c87f7677746f3c5bd16c81b23700bb6b88bfd4 upstream.

Build regression: arm64 hugetlbpage.c undeclared identifier 'sz'
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
arch/arm64/mm/hugetlbpage.c:397:28: error: use of undeclared identifier 'sz'
  397 |         ncontig = num_contig_ptes(sz, &pgsize);
      |                                   ^
1 error generated.

## Source
* Kernel version: 6.13.6-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 30be4aa8b95762886fc27cf2a9931e14bce269d4
* Git describe: v6.13.3-555-g30be4aa8b957
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.3-555-g30be4aa8b957

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.3-555-g30be4aa8b957/testrun/27516541/suite/build/test/clang-20-defconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.3-555-g30be4aa8b957/testrun/27516541/suite/build/test/clang-20-defconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.3-555-g30be4aa8b957/testrun/27516541/suite/build/test/clang-20-defconfig/details/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2tuRCFN4wc8W1MqNki1qddcwCF3/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2tuRCFN4wc8W1MqNki1qddcwCF3/config

## Steps to reproduce
 - tuxmake --runtime podman --target-arch arm64 --toolchain clang-20
--kconfig defconfig LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org

