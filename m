Return-Path: <stable+bounces-50106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC31790274A
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 18:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8BC1F223CD
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BB3150992;
	Mon, 10 Jun 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXSP8Bld"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB714F9F9
	for <stable@vger.kernel.org>; Mon, 10 Jun 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718038223; cv=none; b=gruZB7IjbJHwPqGvmxdU6z32hRFCftFWbcCikt33NGF3IUs+X1bWUAq2Jn3A0WFdJdKak6U6jGsT54TWg+fK/mrgNS2JNe0fnGynkk11VGTFhtJba9VjkDK/XeUs1MfySxuDlqX0y+VtcvYEniC6x2iS6t3RgX/rz6XI/dZCE04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718038223; c=relaxed/simple;
	bh=Op51ATWecdf7j+RQluVKtMZvRZBhJ8bqLg9hFxrGjkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmvoWQgkpR91l0BjvoaXaRmpp1HbG9E6JXTWg28b30rhvdi38FOX/iUsfxw5ZY5ptmTMbyApHdD4q7rlPwAYlGqQGR05dyxS++C5pD+9ppfDSg2tqdDliwrhS8LKVdLUGiXy8kP3ErH+5ztetxXQPeKvtXaq/toZ66MuA0fdAr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qXSP8Bld; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-804efaaae87so1457520241.0
        for <stable@vger.kernel.org>; Mon, 10 Jun 2024 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718038221; x=1718643021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEqeBUXohf2DPwU8bhw7EgaN6UenXOZrA/eDTgNv2tM=;
        b=qXSP8BldDweedzID4Ev/bNW1ElmXJc4MmQyQvXocEC6hH7eQ+IeorAZVBpBFHwru7l
         vdQslW1Mt5sh649YtqUGd8bU2brarThvDJeZZKEhtibBASN6Gub6IKIXdUPfSj8TMyOg
         Z2e2s3PI9Qd7YdgskWjgtFOR76Np1ZaoU5CVetBfdtGSz1OWOLiMm3B7n99VIN9pyjtt
         TMT+w6KE+8E5VBrAyXbbUUnM8hoiLQOCXlj0LXYVMYcRIFI9OMoDhiYtku3c2h1U+5NJ
         t9TuDYTSxXjMOupn7A+aKRwrey6i4W8DNJjw6N6Ynr8tWnQ5IwYNQNjRMNQ1OIme2O+d
         EVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718038221; x=1718643021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEqeBUXohf2DPwU8bhw7EgaN6UenXOZrA/eDTgNv2tM=;
        b=vT+jVc8RC36q9oqp7zhbpK0VaOIDUflVd6N4SfraSVtEBGMaj3wwBHBcX3zPlllkIV
         zgoF3aI1AD6DcM5EL2BRZgvoxJmIEPaxZmUfdOVhQWta1Ru0R4f3IBg1xX8MIX+xI1PX
         GK+j0I15s05iwuM1LbPPZM2JyQYTWa1Vp7wCCFnM+DZJSXxNmR8YBGRBM+AuT19tSG/+
         HsWiWZS7wDpG0oD3m1UMdJVSSpYNIheXsN8ooMZSxt6cmeIqhD6IjVpuqTnb1sMKbEm5
         9Fa+G2m2qP5tvtv6zk0jXAXP2NoDHJy1GrMRQ6yGrMg5//+6VMj/8RBe7PdLZfxPX0Wi
         dRkg==
X-Gm-Message-State: AOJu0YxRnqCVnsM4RhOXD28bKI7kkw/3KtNgC4cX4VCSLcLZ5ferG1Vg
	DrG4bQs3rHc7PWq5N2oOkU2g6ByBoyAM1qh7q/eDuh8mwucHMdxYSFzhWvUO+/lPIuCIyfdbtEb
	xWE4OUAUbPQaSbc/lsTwEyEuYbxCVdRZO0a6YZw==
X-Google-Smtp-Source: AGHT+IFfk85pMew2WCJm421xS0xi6t59jd3ETOlQHdUk4BBRqOUEN43NHnN/oZNmsZIUsWwrM6OEVQH/Jd/pbyvLLBY=
X-Received: by 2002:ac5:c0c2:0:b0:4e4:e90f:6749 with SMTP id
 71dfb90a1353d-4eb562a4b74mr8732756e0c.10.1718038219348; Mon, 10 Jun 2024
 09:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609113816.092461948@linuxfoundation.org>
In-Reply-To: <20240609113816.092461948@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 10 Jun 2024 22:20:06 +0530
Message-ID: <CA+G9fYuhTqdU51hmX=CmByqk6k4CrTE89wpe9-gxdqHFEYB5XQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/470] 6.1.93-rc2 review
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

On Sun, 9 Jun 2024 at 17:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.93 release.
> There are 470 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 11 Jun 2024 11:36:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.93-rc2.gz
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
* kernel: 6.1.93-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: bd8637d23a9e34e5be865c6bd30f591bb7200e73
* git describe: v6.1.92-471-gbd8637d23a9e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.9=
2-471-gbd8637d23a9e

## Test Regressions (compared to v6.1.92)

## Metric Regressions (compared to v6.1.92)

## Test Fixes (compared to v6.1.92)

## Metric Fixes (compared to v6.1.92)

## Test result summary
total: 216101, pass: 183048, fail: 5319, skip: 27475, xfail: 259

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 23 total, 23 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-exec
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mm
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-timesync-off
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* log-parser-boot
* log-parser-test
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
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

