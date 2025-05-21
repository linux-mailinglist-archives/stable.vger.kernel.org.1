Return-Path: <stable+bounces-145807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E5ABF247
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 13:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B5D4E599E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A7446B5;
	Wed, 21 May 2025 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1uZo++7"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C63D21D585
	for <stable@vger.kernel.org>; Wed, 21 May 2025 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825312; cv=none; b=kmsHvcp6QMHLrkDJNyKB7fKxi2VsfWQ7JQ6fx7l5BIbhf6hwwPsg5CBvhz3RPaZb33HMltu+XovBntfd0xd5eKIaDbAQyI2ZWHcXJq94zbE8AlW4Dl+SW5S1BsQr0cNyss8c2R6bgG0McPkT1Ewu+mwtfidm1lryA2ek4edBs4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825312; c=relaxed/simple;
	bh=hrPT87P41+vrV3EBb2pUefmNFAnv+YMPlt7UIo0NouY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=toenEHD8p3Sz9BXmj2ROTMhM8fJMCSD7vy1obaamWVaLgNt7fRbtWUIwHJHeC5FGeDUPE7eSzntJ5FxeX620rCuWNUsFvHA3YUik98cMEGnRga/TYLJ1LMADVie/T2LH6jTkMsJof9dFR1gn9AE+FuHhx6adxmrLNJxemjSXcj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j1uZo++7; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-527a2b89a11so2183468e0c.2
        for <stable@vger.kernel.org>; Wed, 21 May 2025 04:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747825309; x=1748430109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l6K3jbuz4XRmGqwQxxGityewoLKvt8MNkQScorN3NQ=;
        b=j1uZo++7XuZB/HzrqrU7mYsI0W8Pt5OoxS0rZ6lNm38o50yAGTqtZcCfSA47wDoxsn
         bTQeE+leA80+PWncU9ht8kJgEg8iMs+2ddfIjdhnQJ7IFFVAii01BhQeKiyOpedem7Vs
         10hV3nP9qj/qTCCLSSYM2FeCXeVcfUMWAKy+4meo33ZRxKSlQ+vl0MSuuDfUv+yxrCum
         3BuGXmpEGvTLMiTqZNkz+uR8WFidSIojeb3wlwKJ970DtJujVFV0qN83sfRnw3NOxPl+
         UpVMIT0STTq8VBERBYCscadeb/A7BRzyiF4qeZvQ6LtkVcbfIMTkeNgmTtOOzx69SG0s
         Cnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747825309; x=1748430109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/l6K3jbuz4XRmGqwQxxGityewoLKvt8MNkQScorN3NQ=;
        b=qJS1cd79HZ7rcGYfYEjtFDw6Ha64OqupvEIxhEsQc0gVU8IDnecpdazqJLtQ5P/iTh
         FmGx3Sr8kmQq1umQ1h2XNWZ7w2n2KwBQItiUt4ZrHwRvQ/sJ85MHtztz4d2l71MScQOy
         8KJv1KCdFgXGzbEWNrLhE8RTJjGXuZRfI3Wc/DPv/DkffDsDR5pM1xNc+4Ke9fVL8r5K
         SgqqOLICdofRwA3yQjOxgKAr+1cfVWJxiLbXQyg7bXVvhxoFd5jg5jP3wDYCMZ5fG/5i
         GRbbDoivFrfxLRPndhP3givVK525/gBsdPORpN4T564kkD3JSpob+DJjeZXaeQi4oDUQ
         +W2A==
X-Gm-Message-State: AOJu0Yw9KXsAoqLqZ/C9WBet4gKe4anAeRuxAZMNOAq0bqcbDLAKLPW5
	zvXDp7/2VtW/fEc7GkbfFGj0AedqX61HkrKX3l4pQMSSIhZDOxEfzx2g8JtkjgevKj8Vyt5WnO8
	qd2YKfDs06mXs4mD1A6Qo7lpOn0QKJxyM19ED82PXLw==
X-Gm-Gg: ASbGnct6I/JGAWSo3KVwh+I2dcN0BDP4W8tdf/btNbkldWknVdY71q269oVubTEI0dA
	vay5EgwcMy4GbdP5jjQR426Z1pqZ/FOUMy+boriHexR43xBfPxE9AKGWuxvT7DVYz6gCBzObtIN
	Jfryd2z3Rldq3+JYJ+AMMYEZIBpnruvHeenGbZ64OmNKyBGyZuf0V6DPo/05NytbVJJgxjBlnE0
	TZX
X-Google-Smtp-Source: AGHT+IFtPnW8AoQGtwyutR1H47pYRQ/umAxXPwEtqvL0Csvl2g3kWlnp4aaxIBqaK5FczC06PPS+55VKgNqfiL+W/1E=
X-Received: by 2002:a05:6122:1ac1:b0:52a:c143:4faf with SMTP id
 71dfb90a1353d-52dba845512mr18483479e0c.5.1747825302812; Wed, 21 May 2025
 04:01:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520125800.653047540@linuxfoundation.org>
In-Reply-To: <20250520125800.653047540@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 21 May 2025 16:31:31 +0530
X-Gm-Features: AX0GCFtamnilUZjJWuCos6TbCcPgap8DnQbDAmOeiCR-1gj2mb5T7pmYkLby90Q
Message-ID: <CA+G9fYu8+PxraN6QUkQuFVHyTkfeJC_B_WZxybNP2dcaaUyRMg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/97] 6.1.140-rc1 review
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

On Tue, 20 May 2025 at 19:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.140 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.140-rc1.gz
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
* kernel: 6.1.140-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 1fb2f21fca7786e898e99a8b92606fa61519c261
* git describe: v6.1.139-98-g1fb2f21fca77
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
39-98-g1fb2f21fca77

## Test Regressions (compared to v6.1.138-97-g03bf4e168bff)

## Metric Regressions (compared to v6.1.138-97-g03bf4e168bff)

## Test Fixes (compared to v6.1.138-97-g03bf4e168bff)

## Metric Fixes (compared to v6.1.138-97-g03bf4e168bff)

## Test result summary
total: 159745, pass: 140741, fail: 4152, skip: 14627, xfail: 225

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 21 total, 19 passed, 2 failed
* mips: 26 total, 22 passed, 4 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 31 passed, 2 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
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
* modules
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

