Return-Path: <stable+bounces-197564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29415C9122F
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 09:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A72C634B172
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 08:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E012D3ED2;
	Fri, 28 Nov 2025 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JSL9jncP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21982248A3
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318310; cv=none; b=uOovDO1RJ3jSLiZ3hE/de452k3w4b4OmKkm+Owjim3kbMcSjHHW+YvpgBcIZC8b0ZIw/EVPteUWQUkqZJDvR60idIaLeIPXLJT3QalziBRI+edeoR3y2befi2M6ASUw62DKADCdvNeIUAuOF7iuUv6Out/S2T8FgJTK4k1hRKCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318310; c=relaxed/simple;
	bh=2LrVIlClEoUiMukkkRWfmFHxPdK2pBDVDG09zud9wgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmbZ9altaheGanpSPxfMalnLSnGsjMkyiSO3ECCcbU+Dm9v6UOy6sVsQBDQMaXEudj5aZEdl8rSIAKQvwmOC6q1s68QjQuBmpK50RrCtFKLZMscNG1xuqluoFOlVGhCbSjtmWHQRFfSBB59hpWPfc7KtzbBJf6asNbOQ3EtxdG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JSL9jncP; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1097354a12.3
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 00:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764318308; x=1764923108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uYrd53GbhqnVXd+rWaqcOqymzSCbRhWWrjjFVeFsww=;
        b=JSL9jncPFInygvlcBvNwQoM1oj7frDfMX34SQG3J3S/1aECLAKT95fE7xSrllzgYlp
         mycEbGQrBJNlp1W/+C2MUXCb3SnzlzvqfMy8LEc2VMrkhBKCH6hupLsxLIOU11cicyc3
         n7u4IlOKMSVvXAU3ZWgaHfbADHMeSgNVIGR/nykRhAmMM3tTTjwcxAbRjbmXS7WLnVh+
         cdZlUI4hjCwjjb8Nw8IzHGf+95Xn5f5jHp/8kUH5jRFEJgT8FUwoEHBmEO//uPnGoGd4
         DUkdWQo99p6kMw9jrOL2Xl0UxyqUviinVZQfdJSgY0SXtnPPsoUAoZIznXkXSo+d7LGF
         gkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318308; x=1764923108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5uYrd53GbhqnVXd+rWaqcOqymzSCbRhWWrjjFVeFsww=;
        b=O+UHV9PER2UdKPtEfVNMrzprahJF6FDz0Gidf59ij6B0qhdbGlkrdS4Q0C+W9SS7E8
         L3N4u9mtp+hZO6fP6SQPMcQ5P0poDvUUjOBenKp15VJxyYMBGu6qwQw1SQF4tpRlqVMk
         DY71zOeF8iyBjR5H4RwhaPvRPsJLDGtVBeoOFwwzyCY3qEm2O8noqkPwclPaFelJ5pSS
         oz4lTBB61csdD11+FiVl7K7TZzqWjaZlJ1r9yc1fBe21r1HjGeFxp/HTZGp+IDF8usBo
         rLoRWo9cI1viO7U9KuVtWqH67x+JrYOzNomostIhuuLNrK0Pr22GssO1KjcNnafGkPyo
         ZkvQ==
X-Gm-Message-State: AOJu0YybKtHDGvc7wIrOo3kokkNc0wYQJOHZYlpm0H362eVYJd53evWh
	wGJbC1a5ZStKHbWWDwKQ/Y8WxgCHUsfUivLqm8kk06jabak4yuON2HEE3S+znpc59WGzQemRPSB
	LWGdgvZ81knTTSpHbTxim85prBJOjtN/fQdF8Jrz0fA==
X-Gm-Gg: ASbGncvVcJtXMu0nWAY3cegXiRRgRea/7uDOG3coO/UMTLsI4DRZ7lAELFTC+lI3da5
	p29GkMrlDv1T60z65yQ13IqDrg19wF89KGzQS4ZZuA09CQKYKX9NReE8KAb6/QnOU6MkPjeiirT
	drHVIF8o3M25diDjRlJNgd7mBUM+I+vYPI7g3i+NrH7GQNDLUjjZ0j9K0FLI1TclGo2IL/JoJqb
	Vu+sg2M9AC/NxD8HBkAY4cBMhkwvZwfyfbqgLFew+PwlU5C0+RXL5hP8ES16lBkp5/HeXXWs1B8
	UgKu2EPntUDyjPeWyqsIEMN45BiFbwNy5cCZFDg=
X-Google-Smtp-Source: AGHT+IEX7w/0sdxjJ1WFSvglwlncuFs5xO10w/ShVlOuFqUOcubjwaYoOiWLKgn6Vu3slhE+eujlA+UaukdYtZ7hkx8=
X-Received: by 2002:a05:693c:60ce:b0:2a4:3593:c7d2 with SMTP id
 5a478bee46e88-2a7195c9a07mr16497327eec.18.1764318307733; Fri, 28 Nov 2025
 00:25:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127150346.125775439@linuxfoundation.org>
In-Reply-To: <20251127150346.125775439@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 28 Nov 2025 13:54:56 +0530
X-Gm-Features: AWmQ_bkjyIxjczZwplAkbFTpE8x3f1OCIMqCUZQihFzJU3KU5PqE03bUZAlNnIo
Message-ID: <CA+G9fYtkSLQXSiv3XqK=e7kEE6EzhN-i=xcTiKdB2SoH9tMh_w@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/113] 6.12.60-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com, 
	Sebastian Ene <sebastianene@google.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Nov 2025 at 20:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.60 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 29 Nov 2025 15:03:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.60-rc2.gz
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
* kernel: 6.12.60-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 375669e5645f465d87d534f0be2eef993e3c7bab
* git describe: v6.12.59-114-g375669e5645f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.59-114-g375669e5645f

## Test Regressions (compared to v6.12.56-605-ge6b517276bf6)

## Metric Regressions (compared to v6.12.56-605-ge6b517276bf6)

## Test Fixes (compared to v6.12.56-605-ge6b517276bf6)

## Metric Fixes (compared to v6.12.56-605-ge6b517276bf6)

## Test result summary
total: 121315, pass: 102842, fail: 3825, skip: 14279, xfail: 369

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 51 passed, 6 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 46 passed, 3 failed

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

