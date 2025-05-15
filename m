Return-Path: <stable+bounces-144515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B472AB850F
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 13:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3293A4749
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 11:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC01297B83;
	Thu, 15 May 2025 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRGGWx4p"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10944293B6B
	for <stable@vger.kernel.org>; Thu, 15 May 2025 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308913; cv=none; b=a7czg51aQ/cDLxlCS59rsxH//UGgaBsamFJ1CA3ZYXX7gjEuF4rPeB6gm5CaU7kw6T9zCe9LbL3gDd/awe4IDckcWSPptUbcWhN5ssj3aryoqVtKuHmItw2bonb8jMjRPrRdB9XDQOEEqg+MjEKJubTJoKugbPjG3CjlEr6FF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308913; c=relaxed/simple;
	bh=e0ABl9xopNqukayXAeP+VcBd3ZZCVfEEKInScyY3tig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gG4y8t5TMeAN6UoAT7ayqtGxrzb8GFDvN9eLJkJQeLhWTyoWehGPM6B31LbrgFVlTJr5w1iEE1LLjlilk5oX2rN1AV9q6SklP3bZxITNlauQC8mf+sL2pN8jnCzBUznrVQ2Wv65j012s6GZgEiOIlNgGwOHVRLdFUSwCQaCGNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BRGGWx4p; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-52c4e568d07so251760e0c.0
        for <stable@vger.kernel.org>; Thu, 15 May 2025 04:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747308911; x=1747913711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bwmcjjtRVIYu/F7DCKBAun5RhjURvCxMohVScmjWck=;
        b=BRGGWx4pmsudfvpvHps+Qw6YCCH/6RJKEXbgSKbToMCtPdUH6SvzVYYpw5JNAa2pEo
         VsWJLMEiV+NFbOiRKNjgBCBECNU4jD327645YSS/kFW2l0Rf2gedyWbYsd68UWVDx8fc
         Q7AxYqILD5sie6qYhturDGQBXOqUlWxd4zOi+Ze61QbdrtoFNwD++LTcF5bSJbdoE6iu
         037+xvZQbwC1ODqYBFUuDcNi68j8XtGWwifcBIwfEl6m//jbFWdZIvYYGPeMWZiLlH/v
         3TUBvGefVx42mp0vxSfgyuJMvJ4+YcQ39Alyrmlst/pm7eZZ2TRTPNWXdIId1TIX/9UX
         cO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747308911; x=1747913711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bwmcjjtRVIYu/F7DCKBAun5RhjURvCxMohVScmjWck=;
        b=EJTYDkN8gWUlrs+qFJb1sjoxekIT726esJJyFDLgkAHiqZQnVHblbceG16D6SVZQMw
         tIoP056ixmX8P4QVfReZmbtYt9RGv0hpZwF4iEFZtkgyORXD/dfiTyzazspGoBvdb/xs
         Jsuhx4vQh4WYP/u858QKexdKrVyy6+PH7hVranWgIGStkMFRlzoQn5W6NcoMR4rSx/Co
         FTzAMiniOABL2mFyM5fzqumIT9WCUpyV60iHcdllVgQQ2AXg1i2e3lgoSjHwIfbUcWKl
         jL9UJsvo7swru5D5Uw5CUZ0QNYt5ap44TYQIEOWS/ERNIxg9y57wET3CsOu3Hrl1VJhT
         ANug==
X-Gm-Message-State: AOJu0YwpLj9U0qXeB7fJeIR6uDBty242qvwEXlog0Sm7sekoOEtHV9Tc
	lPq+aMC+w0D4Msf34OdQqz+1GqjMp9pIpcW5svouJTFolBxcwF2dtihhiswf7/lZc4NBHRT8Lw+
	h6gq02OH1K60Z3hvFhvWCdS2UKKIAjxl6vsPMQw==
X-Gm-Gg: ASbGnctZOSElIqj/YHZHJ41Gwga6rlx9mnfNbki5zNlqMnU4QMKKIFmT1ff2to0JZIL
	6AxKXjAtt/mXathdySgPJrfKIwBbKd3joy4/6WHfBxF8T9dYjKBX8OXsHAY0xWZeFAag0xcqTqY
	CB/24+eLvYpczycATLArtSYcpNDoTvm8Q=
X-Google-Smtp-Source: AGHT+IEXBt+YS20PugXWgGdvZXWg4QYar57KBuwOezG55POCXBUJeFjT4clhig6AxSBLzZnRD/QYLMg49rFl9RV0knE=
X-Received: by 2002:a05:6122:3104:b0:52a:cdda:f2a5 with SMTP id
 71dfb90a1353d-52d9c39dbd3mr5696291e0c.0.1747308910688; Thu, 15 May 2025
 04:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514125624.330060065@linuxfoundation.org>
In-Reply-To: <20250514125624.330060065@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 15 May 2025 12:34:59 +0100
X-Gm-Features: AX0GCFv6UCZUdoZu1FXJUxjnlmxfS4W6iylVBxg-VffWfmUm0ltSi_upUSdvM3Y
Message-ID: <CA+G9fYupqyDyHBg5x9k4YGwrwvBhTmVGBSXHWHHTByo_tCTj8w@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/184] 6.12.29-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 May 2025 at 14:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.29 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 May 2025 12:55:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.29-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.29-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: f7cb35cbafc541b97fad214f4254342dbf64a27f
* git describe: v6.12.28-185-gf7cb35cbafc5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.28-185-gf7cb35cbafc5

## Test Regressions (compared to v6.12.26-167-g483b39c5e6de)

## Metric Regressions (compared to v6.12.26-167-g483b39c5e6de)

## Test Fixes (compared to v6.12.26-167-g483b39c5e6de)

## Metric Fixes (compared to v6.12.26-167-g483b39c5e6de)

## Test result summary
total: 154373, pass: 127484, fail: 7099, skip: 19159, xfail: 631

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 16 passed, 2 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 23 passed, 2 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 42 passed, 7 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mm
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
* lava
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

