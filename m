Return-Path: <stable+bounces-61310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F59193B594
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 19:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76E8281198
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BE315EFBF;
	Wed, 24 Jul 2024 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rG8w+07a"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6061C693
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840895; cv=none; b=Le4BuMLupWGA8dlKq2Hrx6OCyetJtGqxyPLARHx4frzIs6AsAHexsi7EcErmWzykCl7Z/wnKkfDamowWbXOASNzYRVcRFpWgboppmOd4Hlf58TUwczqIQiCWn2jeKmzr5Q/qIkuXyIHZuHOWI648lYjW0pD0Y8pcbODmIu6n+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840895; c=relaxed/simple;
	bh=6OXkMxIEm2fLUnUXSlhOBoRPgnTXPTENE4Ni0gXYjo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E20LzK2V967K2MGVCDBjBkjDeThagFQoKUBYB6pA0le7q7GYhP9K5fc/MK9Zm1qbjT7Jt2UODZyBzUSyEZJiUCYawjPfbSBNX9MT6iRWLQeMcGh0+/8wjIPDisgiAUpr9C++470wxmu3OTStdqnM55RbC+hsTK9Y0ZNVyB1nYqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rG8w+07a; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7036e383089so3423284a34.2
        for <stable@vger.kernel.org>; Wed, 24 Jul 2024 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721840892; x=1722445692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAeC3wapegNfnIubwZRA6G+kpfogXPVXYiQWD+CBY5Y=;
        b=rG8w+07aRyrx3Qi7smzPEhUlLYQJ3vFcACRvkPJqPpGPREDQPjArIpNUgz7CfBtzWG
         G1c4gqBSUTTylEzWSBLxLaExGV2AJ0+dj9nr/Ek0cw4gdt1/W9kPwyLl8N/Rzo2sg2bd
         Ezol2ivQNcZj9trlv3QKsqKVRRHWUu07ZH20MX3rzPQ/v+KwsYCfXcUED37+rzLmEUOx
         mk4UjnmuOPWHWU4M3VF2+YlDoXqlwcAHvjVN67/5ndwLEZm2nSJBTTiuZCgLlYxj4f94
         WrL7M0RYBSzDltkEVgJNeCG5ThNbDE+oQ4E3x+vwUZf/9vHBP0FIo/Z/NgJZdoV4T1jk
         3sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721840892; x=1722445692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAeC3wapegNfnIubwZRA6G+kpfogXPVXYiQWD+CBY5Y=;
        b=ahmmlqxijPdeHF4NN3z4MlISFbz93Megu2YiHFHafSoUq63vrhLUZUv6QODyDy1c5E
         M/tAMEIk3rX2PIP8CzXuQWlRE6GaEsyp/UAxfIkKMXj8BFV3/xW5LfB42jIr5MOZstS1
         wnUrOSHyFfqXFjUd+PBzg6RnoGwtlWQhV+QcahO6VraCFY6cd53aLduvmZVqMpFFzdKX
         YapV8rMO4n6Qv7WOCXYY3WYAzIc8+gYyGrXvjB8Xi4QcNVRgUSbOVnBTVe6hVm+AAKDN
         TMY4dUUOj1cRndxoRmCCDeRmVgVsKQ7qzkkS32YuedRb5wEqTnMAZCEAf6/wrkYQbMgx
         XPWA==
X-Gm-Message-State: AOJu0YzBS0mgrAZX1yuwRv2G1idWzDgw+5b0SeX+FZ0ZwJtYO2bNop0n
	CrSSKWQ7GzaE4dJ7SDB9xromvezc5hmq2AxfG0lO6/5GhPcGWz/tiRM0a9l9YQaLt60y8Wr5sEG
	D2FmsEG90TREWyqAFoAqHvGQRmSADnW28pUwMlQ==
X-Google-Smtp-Source: AGHT+IFjXVMJi8GOpKtVfaEYslxea1ursmT4lQUWSzvqfWXuAR71kzhnpZtlb2EUm0ApMvmE7jWKrCSoDqtwJLl1Mm4=
X-Received: by 2002:a05:6830:6d17:b0:704:494e:fa1f with SMTP id
 46e09a7af769-7092e76e4cemr457972a34.29.1721840892453; Wed, 24 Jul 2024
 10:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723180143.461739294@linuxfoundation.org>
In-Reply-To: <20240723180143.461739294@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Jul 2024 22:38:00 +0530
Message-ID: <CA+G9fYv+=8YWS=Mqoawbrw1yCDgZ36wO_NMbg81HdVNykGOu3Q@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/163] 6.9.11-rc1 review
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

On Wed, 24 Jul 2024 at 00:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.11 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jul 2024 18:01:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.9.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.9.11-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ebb35f61e5d39f0baaca27b0bf8aa63f2c135ba5
* git describe: v6.9.10-164-gebb35f61e5d3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.1=
0-164-gebb35f61e5d3

## Test Regressions (compared to v6.9.8-338-g61dff5687633)

## Metric Regressions (compared to v6.9.8-338-g61dff5687633)

## Test Fixes (compared to v6.9.8-338-g61dff5687633)

## Metric Fixes (compared to v6.9.8-338-g61dff5687633)

## Test result summary
total: 258631, pass: 223032, fail: 4979, skip: 30112, xfail: 508

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

## Test suites summary
* boot
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
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
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
* kselftest-watchdog
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

