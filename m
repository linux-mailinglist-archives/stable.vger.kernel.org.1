Return-Path: <stable+bounces-15653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF9283AADC
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 14:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1625F28D38D
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8321177F0E;
	Wed, 24 Jan 2024 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKI2mq6y"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1540F182DB
	for <stable@vger.kernel.org>; Wed, 24 Jan 2024 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102641; cv=none; b=uWq6LhUOPZ9Df1eoeLtTWRzyxmgHXQ/Hg8f1KccfPONJ5nIWi/8H8ThD8c9p6qS1o6WZhDhB8/aku2pt7aMRh5wyiK80RcHHXyeYztLnErCHecgjSlGuFx6aGYdrakX18/2laWpRxXzAFLrAMRD0egyN1jobkZax2F+KFFePzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102641; c=relaxed/simple;
	bh=iWZac+ZaEacF+KvqnPyM6HfqTzttijNbXBaymdeQFPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nat2peEiYN+TLT0s9s+FV7U9OZyjG70P9XHJFZNPnkfmeWArGm0DgM+yjwT8RcRJvgFqWJz2XbtqmDz3vGYqCfcQ7GXe3faKBYW5pT85Z+knZSdCkr8ga3ZV6u4S2aBmr/KM0CcWqEMDN/rL05l2j5Kim2hJ7vs1/x4O8x1Pu4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mKI2mq6y; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4bd302ce55eso268488e0c.2
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 05:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706102638; x=1706707438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02kXXgSqM3f0wcrI/acHfP6E2HHPpWGNtsvRtk7S0yo=;
        b=mKI2mq6ykMRuz96Tq9ilzvXDBu34Ea7YG8doPKu5+U2eiVA2CD6XhBdFtHolVXBg4y
         wg4ZoUWg0pHFMpaq9rLHlphEiIGc4HGbq1CShHc4Tu+UTEX/DdRFt4GT4B1JUEJKIyIC
         XdVkjHLrZgArUzuyZymv10/yj9Q8RM4N3SCWJ09H7/6iQkm5nRHB8un/j6azeB2cd/FC
         JYq+jvTRgo5WTrqbxjsq8yJ7bUrrs5D4gUxstmknKkb6YRLzy7wqStVdM9n159Xm+Ees
         ZkSRi7u9bXwG2Rx7zb79ewK/DbK03QP4n3OubrgXVWWcXr6jKsuuJ24o735Dq7FrAMn3
         7rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706102638; x=1706707438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02kXXgSqM3f0wcrI/acHfP6E2HHPpWGNtsvRtk7S0yo=;
        b=aRqlIs8XyuUnLFd2VV1MQwtFR/4/iDMV1uNfWZqxFs9WMRujplwcrc2h3LTssXho1o
         ETcczbjFyr2w1YWKTxX+hXnOi8Hou1Q9Ldb6AkzNeP4iHwCCd2Gk1OFh42Z9RJQDExwS
         tXdk18NcJNezxDEaDiWm4lQHnc6R/9RI0K8O9QR0wy/f4L0uNg/hyhxVd1WDa+l30NkG
         Ps7VXmMiSpQJCX3o2bXPNo9DfLRsHPYhkol043HhMngKGyEoNMYgFemwoZs8unHaTYJp
         h7YJhanoDjO8s63/nzMccDLiYancRb+9CxjVvSpN3Kvd4shia+pz7S3oWf1pUnOHsZjU
         GC9Q==
X-Gm-Message-State: AOJu0YzOEvp2V7hRbrZyhpTUEKXR/mh2TdlainVL6qQRqk/8nQwK7yw7
	zuEO/UGbBGKRSkG/OBP0T09aJr59MS/nlxxvCytA8YgYzi1hYzTLeI4M5HQuWjD3FvTYKlcqppT
	dJdvw6dQ17qHcXmlUQyn/B2DTyfM3AE6GdEUnAg==
X-Google-Smtp-Source: AGHT+IFH+XBA9wdCSOw1u5qUmb6O+RjCCUttprLGBuYUvW/Qx2Oj2rYBLNR6xNbkGma97W1xgWndI38Q6iyL8lz/wh0=
X-Received: by 2002:a05:6122:a0f:b0:4b7:8e5a:ed86 with SMTP id
 15-20020a0561220a0f00b004b78e5aed86mr2395856vkn.29.1706102637932; Wed, 24 Jan
 2024 05:23:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123174533.427864181@linuxfoundation.org>
In-Reply-To: <20240123174533.427864181@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Jan 2024 18:53:46 +0530
Message-ID: <CA+G9fYsg4b+QF_X-GaJt1wENoEMxokx4RFoOGbjJ3-PHE6c_cQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/580] 6.6.14-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 at 23:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.14 release.
> There are 580 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.14-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.14-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 86b2b02ae53b684a71d629c5ae2511c2e0d0f675
* git describe: v6.6.13-581-g86b2b02ae53b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
3-581-g86b2b02ae53b

## Test Regressions (compared to v6.6.13)

## Metric Regressions (compared to v6.6.13)

## Test Fixes (compared to v6.6.13)

## Metric Fixes (compared to v6.6.13)

## Test result summary
total: 153830, pass: 132159, fail: 2244, skip: 19241, xfail: 186

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 144 passed, 1 failed
* arm64: 52 total, 49 passed, 3 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 44 passed, 2 failed

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
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org

