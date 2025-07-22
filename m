Return-Path: <stable+bounces-164282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 908A0B0E32D
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 20:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF081C81890
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 18:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D3728000A;
	Tue, 22 Jul 2025 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zSTmL38H"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608227A917
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207246; cv=none; b=sNTr8EIqoGGaF1n37Zc1JxRvlYUGfHQv/d6ktrTs79j9EQ+XIza/PH51tm80JpOA4QCGzENukZJZd95r1ffWhrXwcKvsQSrCt2tjCMbWc9AJZlplqDOettT70YZmWQJTmznDQfZb32cwyIy+oT4Y3v3h57X2yMFjiyXMf8UzW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207246; c=relaxed/simple;
	bh=YVtu41alI3J1y0N+ZggPSzt7lkdH9t/iPzc26jPFrYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdaV4dkZkCA2VJysLY5bh0XZFADDPLCspnjfrWNDpixPuLxuCX+rmJp867Z1tVa2i6W3DVZuz+sJMOMKIxFZuOeuFjFk8B85022qmL3tEC9Egk1HMbr6OHSFfeWznzNH4PKyR6rUtB6S1vofp3h2W9PIL+E+9+ID5SS8q6T/7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zSTmL38H; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-313f68bc519so3678096a91.0
        for <stable@vger.kernel.org>; Tue, 22 Jul 2025 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753207244; x=1753812044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Px2ISLgVozuB6r8zgwA8tkISmDkVGlK4ZTL8goB7E8M=;
        b=zSTmL38H3byXvemZ0Nd611RvCtnf+mO2jKbqoAaS88EofYkoOXdZhPq2QgHcPSpyZD
         ssJ07u+aA9EqUnpxis8t1LkB5LqCbtry6NEu5L9TsCpijO9haJncsFRFPCghJdeCANIA
         BbI73Ii1qEMhvz4XR1+ZWK6KFH6QX0Wj28CVkSHskNA9RP5L6g+hwd68ElyUqfc0y710
         cNMB/FEzUzFUsLtX/uJ9Hgnpr5kJUAuSKF/FxudRVyLnMVIOG6aLLOpCuWaj2n4zgrBW
         knHiVgZ3LzZuThJ1EXoDkq0LRpSQwixZkRK6BpF3oSkuHcuF/05Cv5zauDD31+UzdOWn
         ZQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753207244; x=1753812044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Px2ISLgVozuB6r8zgwA8tkISmDkVGlK4ZTL8goB7E8M=;
        b=L2JLNcDONvrUOtzEGQRG0JmPn8VevQ8E/rJlOD1IvKWlHVcnBPymRptp2ejlIcN/SK
         foqlTCZnmzvEpBIKgnnpsD1r1wrsnaiax80sR8+mknooX1Y/pA1AA/irOmkptPu6n/Z5
         kqoDVomi4mnDpXAUe15YYzSStgQ01O7jm3GwxhyYnoaiWDgrcY1FjMcJWHv7NL+YYr0D
         COUy6Hu2FiE/msUwW1debecB7wg6KtlLF7dnb1vysZf45VKYgg1vCLVVZVM+Hy/eH8LO
         GVHASdxUog921F5aq979s53YbmnZB5IlvH6J/OBxfAJDD7yHNJd2pU01C+tix1w+NNmx
         Bdwg==
X-Gm-Message-State: AOJu0Yw8itn5a3Fk1L8wXlfmFhhyMhxMGuyEyEMbBqeqzUWC9SdL0t+C
	hiE05zk8R4z2eVLj+dwlUMDf6b/6YmYNbCrwBsKpAORC8AnZdb9CDYc32iopNmzUFoOT8Qmpatx
	9Smy9ChgvTP1rn8oILffwMYxlJm/Bk/iXhTSGd4z8oQ==
X-Gm-Gg: ASbGncs4EbgDRtPcMOI22D7Rp0mjNvyDJNph0jkp4akiEkvYErTirrAvuvFZnWgNwxS
	bNQJJIQm43sbrPldv6Lv40+ukUiPxUYcs9bfpDmph7ujnLfVfzoqJWHXVTwV27w8KjfVqIcC6al
	6GLhJ3sHsJs4kh8OqjeC2WvP4mTEwDZrhmtYgMWCguc4JgZPeu4QJhuoaYomR4xXwK50nuakHGN
	XDXuS9+EXLjLS/an8YfapvLsIKqJ64D4nH9Ng==
X-Google-Smtp-Source: AGHT+IF1c0ECz1dHQBMozDVaGJegjDQ+xVWv6X/ujXbFpey4CFIuQxZFRfSj60viTUAnlrJuZLxqs44XGNMAeZvlUx8=
X-Received: by 2002:a17:90a:d60b:b0:311:f30b:c21 with SMTP id
 98e67ed59e1d1-31e5082cc31mr280553a91.26.1753207244493; Tue, 22 Jul 2025
 11:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722134340.596340262@linuxfoundation.org>
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 22 Jul 2025 23:30:32 +0530
X-Gm-Features: Ac12FXzKOsmLQ8yujNcTxBZG6536oHN-0krbleAUzT7bCEwfhEyQGS7hbv_zCoY
Message-ID: <CA+G9fYu8JY=k-r0hnBRSkQQrFJ1Bz+ShdXNwC1TNeMt0eXaxeA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/158] 6.12.40-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, clang-built-linux <llvm@lists.linux.dev>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Jul 2025 at 19:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.40 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.40-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

With addition to the previous report on the stable-rc 6.15.8-rc1 review
While building allyesconfig build for arm64 and x86 with the toolchain
clang-nightly version 22.0.0 the following build warnings / errors
noticed on the stable-rc 6.12.40-rc1 review.

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Build regression: arm64 x86 kcsan_test.c error variable 'dummy' is
uninitialized when passed as a const pointer argument here

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log

kernel/kcsan/kcsan_test.c:591:41: error: variable 'dummy' is
uninitialized when passed as a const pointer argument here
[-Werror,-Wuninitialized-const-pointer]
  591 |         KCSAN_EXPECT_READ_BARRIER(atomic_read(&dummy), false);
      |                                                ^~~~~
1 error generated.


## Source
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 596aae841edf981aab1df1845e6df012bed94594
* Git describe: v6.12.39-159-g596aae841edf
* Architectures: arm64 x86
* Toolchains: Debian clang version 22.0.0
(++20250721112855+43a829a7e894-1~exp1~20250721112913.1588)
* Kconfigs: allyesconfig

## Build
* Build log: https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.12.y/v6.12.39-159-g596aae841edf/build/clang-nightly-allyesconfig/
* Build run: https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.12.y/v6.12.39-159-g596aae841edf/testruns/1703644/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/30EXE6Cnct6e7DCgsWWrXlMdO0z/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/30EXE6Cnct6e7DCgsWWrXlMdO0z/config

## Steps to reproduce
* tuxmake --runtime podman --target-arch arm64 --toolchain
clang-nightly --kconfig allyesconfig LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org

