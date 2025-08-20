Return-Path: <stable+bounces-171888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D708B2DA40
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 12:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1A51C46A56
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 10:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F182E2DF1;
	Wed, 20 Aug 2025 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AgK7Ci3C"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA582DEA9D
	for <stable@vger.kernel.org>; Wed, 20 Aug 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686613; cv=none; b=B/j69P8nqXj9LVl6sprvtBN9Wo7nEiC2qjp6pTPi7kOQG39lFLhDwAmwgTph94Lar2kqd30Xpu+y+o9tuN66gI6iXTxyrgH8+bGsfslCazfyc8yEQJkQa475UEvugkKNoUQ6j6K+h94zTziJluZw4JNNzJCYJ2JfP22tNYgmMNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686613; c=relaxed/simple;
	bh=uVpcSCB5mtAaK6aCWFyWWs7ICZDA2hsY1/QCUgHENGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S957K/bu8w59OLZ8N8llGk7FdEfHcDLcMzNjRrsd7pxMcDG9zDG//2r6S1g0CsL15GsIAxJehib2B17O8beXQ1qYK3rT2MjNAnO9U+BZqnW7ULu01NyZVaJRstyWEuTNbN2XLPf76YtEtLoyOuBHr0E+sL/JE4trK0gfo4tEweA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AgK7Ci3C; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-321cf75482fso823001a91.0
        for <stable@vger.kernel.org>; Wed, 20 Aug 2025 03:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755686611; x=1756291411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lk/vtWnmqYeXCudIPf+xoX46PWcEg0mYxFLpg6PHTfg=;
        b=AgK7Ci3CQTgoua2GBKkBZpTU1Gfi273HSu35o7xv92dac4JzTFHwmhn235gSzJ3xeR
         niex6/8bS3LFQqlQ+LDnHiTcTMBT3s0+Q8rlF2/9gHUUCPbwqavWZ5nLTbfxF9vQ87yI
         mtuCzkNkJq6HymYAS89nPuhYeomX6xIlDejMZ/Y4RM2IM+j6R04eKcco1Cq0BnpKVHuI
         0LUkUCK3uBKuBLjCL2/XgDMDlO2uVJU0K4+r4vdcu02zZ/LY1lZ9wf0zbf3ANH47SiEc
         0NTsoCfAvGRsKHn5wywVf5Sv2JFLDO6k8DjtrP8voAJtt/aYYCEbEDm3QrLmz+eDJzIP
         tTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755686611; x=1756291411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lk/vtWnmqYeXCudIPf+xoX46PWcEg0mYxFLpg6PHTfg=;
        b=tjmALjPhvhQJBJZfhfikJsaChfJmXg+7ofYMTwr4v+FQkXbUU//HR1EA/dHVvhkdsz
         Y65nHuNoiCXS7R7Ny8zLtXMfUMfkbslEivm9RvhvpqgCz+klr3hnWYSKkPBP7GArehNq
         unVRCw1XAIv/fBCi4N9YzS/72PcwKWxOR6F6B+4AcyIDx3FkA1hqTLwmdazRbaVajBGf
         XBTO/2U7EoetC+UitwggNb+QfQW4Qv/4jsnyY/c2Y5OhUNDO8tmWnChksngsJdD2Z39J
         XtEcI0yDZLP52mYsWE9MWV4pppT3kqBaAFWy8sS/NUbQH5/XcMBoOlfU8Uok88hV7YTC
         qgsQ==
X-Gm-Message-State: AOJu0YwB41/DgXAvAnN6HxwG38T5mh6v1mQzZXq7TTaUN3btM94ly6hU
	WE65zZkb/WNqP6w2p/6vpJKE+oVdcfZUUCZIIetdVFOTsEp35bgg60wLggLR+Ud0i4e11QXFpdv
	cORc/2dLa83Ar8bIeF1h0N7woFNCmFUX4c0hDBkuamw==
X-Gm-Gg: ASbGnctPJH+WmvM4xvftp6nGuD70lCVaroIcmZq7l3/3vgXVJqmmMIiugky5Qddml5i
	ZKlKWe/KZAg1AWnRcQlRs7SnqEqYYfhvAQROmZOAATCAXJVwBY1GOmlc6sLyu9JeolXAnLRSxzo
	l1D6MJ9z3KAZ+B/AD1sMIRlDRkG9yLA5+fIykzEUYGtocg1oCYpi1moXJic+86NWicQH5/cRvu2
	1vtTiqFH3V+ofQh5cbUFWJikLLMLDmdk0Tr6iayXZUzPbnKXSk=
X-Google-Smtp-Source: AGHT+IFwrsubzwYy6OCz71QSPoYRUwgOCZIF012RxCruCEQL3nCCwcumSkjdOdE86Hy8RNzNzoY+6hhO68xb0y33ijc=
X-Received: by 2002:a17:902:da85:b0:235:f091:11e5 with SMTP id
 d9443c01a7336-245ee010a57mr36015605ad.10.1755686611227; Wed, 20 Aug 2025
 03:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819122844.483737955@linuxfoundation.org>
In-Reply-To: <20250819122844.483737955@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Aug 2025 16:13:19 +0530
X-Gm-Features: Ac12FXyXjg44pYVkVc6KmflacKpBYZDwKjup2B-GNdc5o1-6kkVWh646JGrHJBE
Message-ID: <CA+G9fYuxaTeCD9ftGZ=MJVSoH-OY+pHx6XS8aXGhvySfT3V3TA@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/564] 6.16.2-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Aug 2025 at 18:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.2 release.
> There are 564 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 21 Aug 2025 12:27:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.2-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.16.2-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: b81166f7d5904b51887cd414c27cc416fba3f215
* git describe: v6.16-1186-gb81166f7d590
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16=
-1186-gb81166f7d590

## Test Regressions (compared to v6.16-628-gcd8771110407)

## Metric Regressions (compared to v6.16-628-gcd8771110407)

## Test Fixes (compared to v6.16-628-gcd8771110407)

## Metric Fixes (compared to v6.16-628-gcd8771110407)

## Test result summary
total: 329363, pass: 304882, fail: 6396, skip: 18085, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

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
* kselftest-rust
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
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* modules
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

