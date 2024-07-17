Return-Path: <stable+bounces-60464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5A0934154
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 19:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63512815B3
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 17:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF771822CA;
	Wed, 17 Jul 2024 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2CGcRQa"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA0181CE7
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236694; cv=none; b=NBEe8DslG/BXXT49357Sl7Nr8jWiPHrotD4q0jThVFPK9Kg5wa4uOAFn0TScrGXtg+G9QzfBZvMR6kec5y2MUfKD87C+cU9xbX5ceCXd6Q8TMrcZLVJ7Any5SXkGnoBho/R5b0ZOAdibq+pi4KIBFkGziACDdAyRY72ASFyUJ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236694; c=relaxed/simple;
	bh=Y3f8GyO5ZrEUXO7QQwWxtrVV1sbBgKpk5HJgaPZnWqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CogMXcIKcJ3gFtGhzV4JOgC+JrPWBKlJHdQQmruA+mNostG1ozVFerl47tjwU+ToqwKaj7uqdsWG9+SS+TaFtaBzKGlacmjC/F/7muTib5kU9DQLkZEVXaev4ygMN5SAcIuG+gUSNolfVZU8rkrJ3zYCkRx00xo+NzTKlkOmlmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z2CGcRQa; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70362cb061aso281543a34.1
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 10:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721236692; x=1721841492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQ87CQkHvz/Gw13/KX5fDYpHUXtRC2GsKKiDfez0/zY=;
        b=z2CGcRQaCkEq6k86pQWeg7Vd1nrKw9LTPyCV7Q0RaC0DOAvbnNmmGIbfuvuLidVuq4
         OBtTBxntMXJzx4GvVrKC1DMuTU/Sf2nOnKWO+1davXoh0K0obAoVszzVOath8pjzMoFx
         qazUO44fcy9aB21Esn3Om3V6uj4bqorpn6d8U4+1NOvV8kw8rMpqnfPS5p+xcRHO/JAH
         x11s68oaT7+LgmYLYi26gpOr13vJzM8isYpkeJeJmgPYp2nKzac78p+H+xh7Wx4nrTFC
         ihXUPWT9jJA4AatRu2+ytc3/5YT5ogLFr0sVzWExqPvcmb2IM0xE+Q2awW75+zpFxVM8
         lNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721236692; x=1721841492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ87CQkHvz/Gw13/KX5fDYpHUXtRC2GsKKiDfez0/zY=;
        b=RW19CkyXEvHJttK7v8GWGI3RnUNORwsJJ4PPfty0kDvFZSYoDYsWyzkpD/cnp4BdHZ
         YAG6zJPRQAVHgqCaRGMysjCbwUZOsNvPpCBP0Owf80IAE8AUCs5CwrpgW3DpNq9xEJeE
         e4jamuj9E32f87IUvUwUTGB057kWPz0Rd9XJOnm29A6wxNJ2FThD5MhtYwDAUPlZcciF
         Pd1SsRB1xHuFiP0HZarN57OnU9/jsJaT3oELOT9+wr0RHdGPSbvwCXV1OqvHFkBCNi1w
         A5/1FgQUVrx6WlDCTTaadypPyj3ttN57kwuJTLZ1Odt7sox9iUoGFc07rvZMxPLJM7RY
         WHVQ==
X-Gm-Message-State: AOJu0YwlWBEgpdyEgVZ9n3vbPimBQuddxPPk8X5f7vw9FGejyD2yLeiS
	hiNINpoDpk4J8N/N93YhwjAgZWSavSGOQ9B0XKaw8IMdRSo3YizHOmX+in10fT4461berGxD9+u
	076C56AqRf9nA0xB62GlGbBbJdzDjrV5hI1ciQg==
X-Google-Smtp-Source: AGHT+IEOmhBZS1mBeh4jBqhuXW/iRM3FLIcVFLFuvgl8Zn0VIJKwr5xaSP6aJOa7TbGKcwS+Dlb+q+5Gfv/V8GytZ64=
X-Received: by 2002:a05:6830:3493:b0:708:b41a:ff16 with SMTP id
 46e09a7af769-708e3777e19mr2860397a34.7.1721236691807; Wed, 17 Jul 2024
 10:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717063758.086668888@linuxfoundation.org>
In-Reply-To: <20240717063758.086668888@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Jul 2024 22:48:00 +0530
Message-ID: <CA+G9fYuigJ2fDRugS3xpGbATqULsKvkF89h5DkzthNERDdpFoA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/95] 6.1.100-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jul 2024 at 12:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.100 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.100-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.100-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: c434647e253a1ace7b60140761f27e922139de93
* git describe: v6.1.97-198-gc434647e253a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.9=
7-198-gc434647e253a

## Test Regressions (compared to v6.1.97-103-gb10d15fc3848)

## Metric Regressions (compared to v6.1.97-103-gb10d15fc3848)

## Test Fixes (compared to v6.1.97-103-gb10d15fc3848)

## Metric Fixes (compared to v6.1.97-103-gb10d15fc3848)

## Test result summary
total: 110994, pass: 95010, fail: 1148, skip: 14691, xfail: 145

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 34 total, 34 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

