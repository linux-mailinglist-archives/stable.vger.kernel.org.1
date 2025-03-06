Return-Path: <stable+bounces-121225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47466A54A6C
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 13:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BB316E1DA
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 12:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C836D20E026;
	Thu,  6 Mar 2025 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aC4M/zXn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6EF20DD6D
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263106; cv=none; b=Th1qbHJC8912cQNrn/NiFvm4nj0jl7j+3ZLcDp3wM8VZZlX/dsVOMxcTk8f2YSL27TA4XPFdJ6zg4FP4kbClITpNRDHTFxLzu7ExVlQwBx+wc3X55UbeEBrNtoaB75iIhh+W8AVEpKmfSaOKxkDemBPNkisXUH00JNAP5LiYuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263106; c=relaxed/simple;
	bh=yGHR6q86C/FTZvePUkQVx5rTTpa8kIUo5G1WKw4/rvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3yrTMR/iuLDSBtJM2RAzZkmV67HUmIPtVQFp71RxC8xZmoz78S1JqsxI2oehiOPcpyPfZj6uUHLWta8fbjtkibPKhfhm8LWsWT2z2fv41XQR4JbnxGoTgiPyXqbciUr0GwJFqZP+gy5aNrsnYGBsjQoA7mOVWD0v3AErbrWONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aC4M/zXn; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86d3907524cso93941241.0
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 04:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741263103; x=1741867903; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lvsMJEXeDFDyZSd5Qb4nvCqLm7iXrW5gMYpeBFg/FxU=;
        b=aC4M/zXnHynJwgPS/HHX656iXhAn7bMZY9RSuke8qaki0IReHrwPULSBkGCEoTPmw/
         YhZ9ixiQO8IgcPf90c5CJSDpsiv9QpCNypTL+CVDsiFkijKH8oYFtz9CcTcumU7izSlO
         p2ZAaU6rbdJiJN214ts518aiL+chxtowh99oSCUaUgusemRoFpgnutwSx1URHsi5iWFG
         f2iEFdlsm+xe0ohM3PrDXsQTJVP6MCdGmqXPRlTfO3oBslw4Zdt209wACWgloZdZI1Er
         edfhOlMf+x7lU+nre9DjW4eDVPqGjZAiql1mVldeOSND064E5Mq/tN3GDhs/uA5Z+9jp
         njjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741263103; x=1741867903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lvsMJEXeDFDyZSd5Qb4nvCqLm7iXrW5gMYpeBFg/FxU=;
        b=rPQ9jHomxF0Dt0DRYHnJe8Ne/5LT2iC7gvCg8596dgj8UXnITN0Mk0s4Rq/GizRvwT
         8uZ48eqLPjIl4flYx2fRg0L+Hd7wm0xADCO1CZrA22gldLuRCVxoRk2tOx5eUt9S9P0S
         ArCm9S6ixcythFeD67BWgm58gXCuLSx14tENkub2KiOuQbNe2Eo9G9HIYQ0W+YkaSTQq
         5iTYqHczfmYQw/ubdY9SjvQ9wOhFcUp2r5x/wmYTF/lATNMt6JBBL967QL9HejRxW/HZ
         WenyhgPoFoXdheT74AnUSAj2DN2TaZlNlVD8Hu+FECorJRuY5sJOM6MM7xfTMJzoiBP/
         bDdg==
X-Gm-Message-State: AOJu0YxEdjahRcAlI5EZD1NV1lHNUBx/OWM4DZdx0E68MOTEwyTL/uhm
	0UjiS5sOurASJcV/EmtW2fl+NnhipjF+m+V7GVsh2PeWlt1sXIkKoD/A8UmyuM2Ynimrw0hjkJ9
	qgEnxN5/A6+YeslzUJxpj96MnH9P/cLeg0wANuA==
X-Gm-Gg: ASbGncuKFhwwZIkM17qQP4Cjs/aX/rVLqtyLrxuKOuHhdPldkRKcJIEPVKzI/RXx3dO
	NDYMq3E1N6lx/eal1QlNTFppmlvb/YSWoTd4FEeFzBIEa74VKQa3MV6yVJpYId1hAeIyv6x89H8
	Ru2iOtkoLGRyZfk8uAe6CqN5LG2muNidfo/4bFeWYVsP4hHEbTYB57WSfNmw==
X-Google-Smtp-Source: AGHT+IGBc5KcGLbAWgtcUp7ExaRSwgWeSAT7DBmv4XyzERcU07mDm5sOalOSAmOHcBLsW0Cxvf4/7QkDfLGyAYfM534=
X-Received: by 2002:a05:6102:5492:b0:4c1:8c9e:6507 with SMTP id
 ada2fe7eead31-4c2e281555amr3843283137.15.1741263103221; Thu, 06 Mar 2025
 04:11:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305174503.801402104@linuxfoundation.org>
In-Reply-To: <20250305174503.801402104@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 6 Mar 2025 17:41:30 +0530
X-Gm-Features: AQ5f1JrDVgX0s3QgjNqc3pa_CeDdlSmtN5DgURin6xAPja7sGpmtxqmNb8IrzTw
Message-ID: <CA+G9fYvwoYVG8wgz6Lu68EO1z3m4mbBWroGEXL2w5D7P_4SG-g@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/150] 6.12.18-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Ryan Roberts <ryan.roberts@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 23:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.18 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.18-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm64 the defconfig builds failed with clang-20 and gcc-13
the stable-rc 6.12.18-rc1 and 6.13.6-rc1.

First seen on the 6.12.18-rc1
 Good: v6.12.14
 Bad: 6.12.18-rc1

* arm64, build
  - clang-20-defconfig
  - clang-nightly-defconfig
  - gcc-13-defconfig
  - gcc-8-defconfig

Regression Analysis:
 - New regression? yes
 - Reproducibility? Yes

This commmit is causing build regressions,
  arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes
  commit 49c87f7677746f3c5bd16c81b23700bb6b88bfd4 upstream.

Build regression: arm64 hugetlbpage.c undeclared identifier 'sz'
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
arch/arm64/mm/hugetlbpage.c:386:28: error: use of undeclared identifier 'sz'
  386 |         ncontig = num_contig_ptes(sz, &pgsize);
      |                                   ^
1 error generated.


## Source
* Kernel version: 6.12.18-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 43639cc57b2273fce42874dd7f6e0b872f4984c5
* Git describe: v6.12.15-531-g43639cc57b22
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.15-531-g43639cc57b22

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.15-531-g43639cc57b22/testrun/27516239/suite/build/test/clang-20-defconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.15-531-g43639cc57b22/testrun/27514393/suite/build/test/clang-20-defconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.15-531-g43639cc57b22/testrun/27516239/suite/build/test/clang-20-defconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2tuR9WQOit4WjRC1XVxLJKTcQia/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2tuR9WQOit4WjRC1XVxLJKTcQia/config

## Steps to reproduce
 - tuxmake --runtime podman --target-arch arm64 --toolchain clang-20
--kconfig defconfig LLVM=1 LLVM_IAS=1


--
Linaro LKFT
https://lkft.linaro.org

