Return-Path: <stable+bounces-136589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5AAA9AF02
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 15:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498875A3291
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 13:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3E654279;
	Thu, 24 Apr 2025 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S58U8n4J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7D92701B7
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501487; cv=none; b=XYAnozdXegVE9+Li9B4sfQAkyL/nAkE6ApaZ2kEyVBAwvS3I6lYOLpOWmt4udJKTS/sHR/BWQSeBg3BEMNr4xeP4KGGbSuTAeK1642Xenu9ebuyMBDcF1ShgZMs+ZENTIC0utQWbMfod6JJ3vhDUZ79kENj61tEUm0bBUhofJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501487; c=relaxed/simple;
	bh=RZT+Bm4muaLofaD2erPNMsSdkXdWvtmeIvrNvvHsOeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzt9hfXqtKniK07bYWPhC6Y5zStZTyYLzEFlTfPJRxJ3eXxVhu78CXRclR913A0FoYVvDScR7i6ahU6HIFUnVsC2hZf60+OU1GwUOMPEoGze5cjQmr7YB7OwSFL6zRKaxQGgd0D+tAnOyyEsB9qFUw6bCxRIj5LKt7eCiG99L80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S58U8n4J; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22409077c06so15390255ad.1
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745501485; x=1746106285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DJ7+5ltYRZmmCdAqp83XBsh7nNRI3/U1EM/A5Q+9eyo=;
        b=S58U8n4JI9htz8EgfYPAgjn6FrebuM+dYwKupyWHB1zThCYegh5a15NbQoDjJRrkps
         0i8/qZHi44ktPRgyFooGtm4DUD8RLkr92X/yo9lgSCmehpYhra1vReekDC8FsOuCeRUi
         0/znn+6fPNU9ge5od7OKxxVyfMjxel9tUbrdPZf3nIrMyfs3263bLLJwTRZwK4i5LrHn
         rb4LO5CMIXiSi3CKgDxKcVGbGvdplP+qx8FVeOdWvHmZ3K938dXwfzXDjfATSV3ytM0r
         srQUlPtPlzYQfcjwmGiSX7biMxbYdsyrsMyAHj0r3U+LF7rjwxGrUvRGklu+O0PxwBg9
         sh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745501485; x=1746106285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJ7+5ltYRZmmCdAqp83XBsh7nNRI3/U1EM/A5Q+9eyo=;
        b=AIDCbu4Lyu4Whkd+KEM38mW/gGJTn3HfaoFRyCq95jmo3aGhTkEDBjE6Vc1qCJQP/p
         cfmTU3kL4AxB4NNbwnvJtbl8oKQLp7wzbcKaXQaxTgCU0ug3nAcg78/9WgTJG6ffAnX3
         Dmngkk0shIErG936u01j9JWHixcUotJ+LaPf0wtep1WW6rS3PfBR7ipin5CLysP+XgE9
         /t1OdguKtUo/VLFhs7fkCOfIrZKGfZGU6v9U35DIsqQXwF76/11WD6mqiDNnlPmdDSmT
         pbRcTyR8Av8fijWDfZ5MZb0v41DAXzDWzvm67h/jBb6MKEaHTb3w9TBXGjoiT4PTyiZ7
         RRbA==
X-Gm-Message-State: AOJu0Yyio1YXV2UlReEITDv8fwrLtjd9xjbksrCbwY5RbGireMs7wjuI
	hudrQCiZPeW3Gr5UOkCtRTzNGp6Um0op2o7kU/U/I5KdClxgnTEqqUk063ibqM/RPOLuYHv38QQ
	/CPOT+ILquWpzQ5P6EwnZbC1tvejs72ESXPLc4eTvdXTLKcew/Vc=
X-Gm-Gg: ASbGncs0UC8D14sU003SgZnWrUNF9zN7PALtYl7TCaKt6XTJUtbNiKuRfIhR/LvaUG3
	KKlzOsn9NWgEYrTbWUvVxoa2Mx1pe+niusshmIPV60thYqZKWcCVqSMvmr3H4kibo9GQZ6NF7hT
	9MiKBcaa5DFQtkcdMrH2qU9nfUtgOzms1bMkOG6Up6xLLXx3HT7nr2cPMk
X-Google-Smtp-Source: AGHT+IGPQAdvPv130CtyW74bF5GLt9h9J0gOC9yqMjfZwUkVCJiQZ5jIuqZ653x0CDkSH9qNJMbaN+6YH6fuzBDQJEI=
X-Received: by 2002:a05:6122:c92:b0:529:1a6a:cc35 with SMTP id
 71dfb90a1353d-52a78396531mr1948197e0c.6.1745501474452; Thu, 24 Apr 2025
 06:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423142624.409452181@linuxfoundation.org>
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 24 Apr 2025 19:01:02 +0530
X-Gm-Features: ATxdqUE3Swvm29VSdLjDBXXrmS_5N47lC-b7TJpDPawZ14stkRhW3kDUI9cl4yk
Message-ID: <CA+G9fYu+FEZ-3ye30Hk2sk1+LFsw7iO5AHueUa9H1Ub=JO-k2g@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/291] 6.1.135-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Netdev <netdev@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 20:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.135 release.
> There are 291 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.135-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm, riscv and x86_64 with following kernel configs with
clang-20 and clang-nightly toolchains on stable-rc 6.1.135-rc1.

Build regressions:
* arm, build
  - clang-20-allmodconfig

* i386, build
  - clang-nightly-lkftconfig-kselftest

* riscv, build
  - clang-20-allmodconfig

* x86_64, build
  - clang-20-allmodconfig
  - clang-nightly-lkftconfig-kselftest

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: arm allmodconfig variable 'is_redirect' is used
uninitialized whenever 'if' condition is true

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build error:
net/sched/act_mirred.c:265:6: error: variable 'is_redirect' is used
uninitialized whenever 'if' condition is true
[-Werror,-Wsometimes-uninitialized]
  265 |         if (unlikely(!(dev->flags & IFF_UP)) ||
!netif_carrier_ok(dev)) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Source
* Kernel version: 6.1.135-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: b8b5da130779a27bf7d189bd3b40ebf59ee0e0e9
* Git describe: v6.1.134-292-gb8b5da130779
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.134-292-gb8b5da130779
* Architectures: arm riscv x86_64
* Toolchains: clang-20, clang-nightly
* Kconfigs: allmodconfig

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.134-292-gb8b5da130779/testrun/28211709/suite/build/test/clang-20-allmodconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.134-292-gb8b5da130779/testrun/28211709/suite/build/test/clang-20-allmodconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.134-292-gb8b5da130779/testrun/28211709/suite/build/test/clang-20-allmodconfig/details/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2w8QtyR8377WMNLrbtsmGi2lkaI/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2w8QtyR8377WMNLrbtsmGi2lkaI/config

## Steps to reproduce on riscv
 - tuxmake --runtime podman --target-arch arm --toolchain clang-20
--kconfig allmodconfig LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org

