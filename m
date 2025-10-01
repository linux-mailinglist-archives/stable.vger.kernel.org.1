Return-Path: <stable+bounces-182920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB27BAFF7E
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 12:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616573A9059
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 10:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09074299A9E;
	Wed,  1 Oct 2025 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x68n37zk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BB8296BBF
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759313721; cv=none; b=nk8jXJIy/ISsq8+3JOmlESHbvM5KVu5YG4GMBMZBKOXmL+LLIrhXZn4dap/ylp4jnd12vvWuS5zWDUBrKPW5jhuTbUcVNlV+mpewLOLoZmiCTcTv4jS9+AmZuRWwF/Ha50SaMc5IbwVPCMT2daq8H9FFNxEJhq7lpUI7yZer0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759313721; c=relaxed/simple;
	bh=sgsnwpn+D8fIoDMYNzRMuhajAlNSiIkq1gS543cZsOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhFSqtBs9295N2GXtjs5HIBFocz9O6IpgOPDQ5GGZBETITMC9eWo+sMttUKFfzVEgJbktkUGg/tqYRxDxhxW62yxcxMmJI8Y+TBz6JujihsmPDbebF0nZ41GxytW36u5KS/P7/s2C+lCpycIcRpOP860oBISKQ3XylICxcmmQXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x68n37zk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so105316845ad.2
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 03:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759313719; x=1759918519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVlD7cbNAbeKP408bV/3WzoZZwwNa15/KSPYB9rp1ZQ=;
        b=x68n37zkjJn4Vku1j3EHGpZ8yHNrw7hFkt2JnQHbihYPcfU/t6NEQEltsS28sJ8I/1
         y51PCNfAfq3MYWhX3ehE1F/0bgRk67FfdIlfeugX0nUPmwS8DGkjpyoNcXNpUvmL4yGW
         vCp0BabeJal3tsNfkbnaw4SJDPo8ZPRBP8IpzEa9dnwZKxacOhAL5eBzKQIVDWkHhg99
         Wo4fNesKVfhRNld1El3mr9DRIXvsnjQxbtjI7rR0oGOEfY0UPNDvdVWm8+Gt6SjbucPi
         IR3z14usmBN+Ranc/vdgUXhXaXsPBqWv9KhBQdxBPEHb17tYi9yNzum+Fg0Qe3J7Sr2U
         Unwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759313719; x=1759918519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVlD7cbNAbeKP408bV/3WzoZZwwNa15/KSPYB9rp1ZQ=;
        b=pEE/GsBwxhKB3dPDo17boLXstINxqP8OsHbXmAOwyp94WvMaDQnhNpimjLTeo0Q6d8
         q/ADlKJ1wu4Cgxh/OddLcXtkQt7Ck7onWpNcKeR9ogKfGOanucVXNHwag7M+4wplKFKO
         xar+5VJQ9wtYQAV0yRBdzv5b0TrQh7dbtmuQomA0oOE8weUasKLZwHyaKRYXJxbe1Dr+
         /aOJl/nyUz9Bo2hHealVXv1VcRNaK/2usKqeBOPgWihunp3E41Hva7u8nW6LILtmOY73
         Yf30NHJy4z3zVPwN0zGN9c+G3cN7ODWYHIO4aHd57VlB10bgqJKLRUkAFWNDPOnhEmwj
         XCLw==
X-Gm-Message-State: AOJu0YylfARP45oSadrD1WFhFWCf/cWMttLNFP5dB6/KJqvLlrmKvxmV
	PXgDfkYHk27xzq2Gw3CXa1NfWKpzXuCXtajNJ9ITvfKTUVdDiHHo6LdwcmJWN1vDHT8NoeOhWp4
	f0jfBPyFXTSV7Bg/Wr1uPNN2R3v5pYMQEgzcXJgrnvaP9myUIQ2tO7DvAtg==
X-Gm-Gg: ASbGnctXGJpwkJRY+bMGLh9DmUDa8BSCxvuHPWBm1gsA/AV+l/MplgCQKrxPqCNkmfV
	rQjSf2pFa1mDuKpmQoOFWGyjIUBMEnwijcdX0FVS+Sv5OBUWdERIRXHLFfosZarROnQw8EoDEaI
	3tKLuUMuBY6qIw1FwMFG4m2b6fL9FGxSHfpM5goHIKJTQHp9Xytu2QUeJWAIZUR+lQQnrDPdQ9U
	s3+HJUUQdCYSsyBp6S9WrCX82Uoj9hurGIGFZ8ySe8/sojyO8cQbF4VGq/5xASur28GgADsxZO/
	IMfCzsT2NdfB8YSgLpsG
X-Google-Smtp-Source: AGHT+IHaka1yetBuMgYwu5Pa2p5NOCL2qvRKz87P7uR2CFad84AS5RAu/HfztqmZ4Cvd3NgFL2DNLwmbV8O/6aP2JRA=
X-Received: by 2002:a17:902:e74c:b0:269:b6c8:4a4b with SMTP id
 d9443c01a7336-28e7f2a11f7mr39919595ad.6.1759313719090; Wed, 01 Oct 2025
 03:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143821.852512002@linuxfoundation.org>
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Oct 2025 15:45:07 +0530
X-Gm-Features: AS18NWB3zSzph--UG6gBX3s5sPRY069g9F1bXa9Mqzp5Bw4AgJ2DL3Pxh7JT56w
Message-ID: <CA+G9fYv1jfBiG-bqDsbbAWY8gUhoajhw_LpWu1hJfHDSiCbYZQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/89] 6.12.50-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Sept 2025 at 20:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.50 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.50-rc1.gz
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
* kernel: 6.12.50-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 8e6ad214c7b34b9022784193fdc71e1561cdf11b
* git describe: v6.12.49-90-g8e6ad214c7b3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.49-90-g8e6ad214c7b3

## Test Regressions (compared to v6.12.48-106-g1fcc11b6cbfd)

## Metric Regressions (compared to v6.12.48-106-g1fcc11b6cbfd)

## Test Fixes (compared to v6.12.48-106-g1fcc11b6cbfd)

## Metric Fixes (compared to v6.12.48-106-g1fcc11b6cbfd)

## Test result summary
total: 325661, pass: 300251, fail: 7071, skip: 17840, xfail: 499

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 144 total, 142 passed, 2 failed
* arm64: 63 total, 62 passed, 1 failed
* i386: 21 total, 21 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 27 total, 27 passed, 0 failed
* s390: 22 total, 20 passed, 2 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 54 total, 51 passed, 3 failed

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
* modules
* rcutorture
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

