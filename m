Return-Path: <stable+bounces-93636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7189CFECC
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 13:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76840B21898
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 12:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83B0192B94;
	Sat, 16 Nov 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3+Q3DHA"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FC618C332
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731759859; cv=none; b=dS9VqbTNxOFLAMYecLasMC5MS7oDX5F0vcxmB9uLjBzlwbNGZo/1iIe/Ocd3v/GNILLNN4qx6/kCSQQJMZrGPpZ9CcFIVwL9yqAa4fRxrFea7ClInYBR5cIGVI0Tlfexv9HJbxHAkZiPT9oWnGVfkdxFZrfchCa3m7rJjJqdnIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731759859; c=relaxed/simple;
	bh=bYULgciyCSLuULT5+I/Ayl0l74K+ik5BB6SCvfsZi9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtN9TIwU8LWKcC3WDTO0c+omB7ejLoQx9OlShKvXomVXVZ0CBYxB0O2P7taYs0GHkHrnuyxfNZeqB8hvLv3xO8YDAKP0VeZ6nYAgZqFsFAYuK+C4otudZafTVUGSSLdSausHmrvUvWPr5en9WiFbp+OI0TqtmWDCi9FI8fnEXlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z3+Q3DHA; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-50d34db4edeso1929560e0c.0
        for <stable@vger.kernel.org>; Sat, 16 Nov 2024 04:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731759856; x=1732364656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nkGHtUc3FIG3ky9xeRxe+zYPSC9XJK88GiAX9MyBb8=;
        b=Z3+Q3DHATjdOXtX4hyCwjsS05xrYnTAscLErHvYEqjyDeqeMwupI4pQ7EMp31UjGMB
         M2a13RMuxO0b233fiulo6dX+cqpbzXOD9NnIajEzERmE+Jfch/By/q5BPTBA6PnTJbrh
         vaGKeP1vLTYJIUad3TqSzXUeylxg0G88sdNYP6bbNNqenLd25q9xst+vrHUuh2RH9X7O
         1ZK2lECXUVMBBHoSE4MhiZljVyorPcBX68DyAHRxlmI2RDsiKUuUCUNkKho4ahANos+C
         dhGkAyeNmKjzylxCBsqtNO4ElXJRt6JwTZCr1LFKtme11+L46EpfZvd5rrRBZMUkRWZn
         QOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731759856; x=1732364656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nkGHtUc3FIG3ky9xeRxe+zYPSC9XJK88GiAX9MyBb8=;
        b=YjUq3cUfWX2S1RMkVYZ7TcagUS9NUXo8UV+wlC2SgNuRzQXgXOk4j56/NWgg38Zc/j
         HoDd0fMOr4XMBmEweziQlWyMOieJBaXKZZ7A58fTuAcS9zT9OkQe+bhMgkgjUGjB9eI1
         ByVDGMvjogK2pWIfXVUhfIr97GIAJlieG/5VKA6yw/l3/JjFIpUl3355R1WG554/QQVH
         8R/IX6fb+vDkHFxAgB6jZ4xSmh/q0BsHjmM9HG+Ea1YO+9kdHseMCe06Yi60mi1H4deZ
         ZU/v5lBJjvhsf0vIogOWLAU3eLWZoYNeuLaKcZEsSkzSNli/AGRMopM5TQKrWH0pC5zg
         fXOQ==
X-Gm-Message-State: AOJu0YzBaBpXn/98exmhfBYIhF1/1u2Xpgv1m/ps7i7DE/r78C4INIVr
	4JYPh0hfSLvK9lTd94g/ExyeYY6FRjHXvHmuYcU0jDctf3nc1oGJ7oUStGZvvIVp14cqzKbqP6N
	eCFhjXBA4lKmTFQppoSyLl16cerPeVHr+KpycAA==
X-Google-Smtp-Source: AGHT+IF+QEjMi9DU+ScDdeDqS7AuB6ZeLuFW2i+9eWgNGHuQFxoMRcnobhp2pxADVNb3i+KK8LIvVS5C+8O6XhOWiBE=
X-Received: by 2002:a05:6122:1d52:b0:50d:4bd2:bc9b with SMTP id
 71dfb90a1353d-51464ec51f7mr13430686e0c.0.1731759855932; Sat, 16 Nov 2024
 04:24:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115063722.599985562@linuxfoundation.org>
In-Reply-To: <20241115063722.599985562@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 16 Nov 2024 17:54:04 +0530
Message-ID: <CA+G9fYtKyZtmgoxM+wNws=9WZFc1eMJuM0H0RQoAm+BgKfkSNQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/39] 6.1.118-rc1 review
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

On Fri, 15 Nov 2024 at 12:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.118 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.118-rc1.gz
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
* kernel: 6.1.118-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: b9e54d0ed258a28241a31fd3e9830c7ec6dc7124
* git describe: v6.1.116-139-gb9e54d0ed258
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
16-139-gb9e54d0ed258

## Test Regressions (compared to v6.1.116-99-g41a729e6f9a9)

## Metric Regressions (compared to v6.1.116-99-g41a729e6f9a9)

## Test Fixes (compared to v6.1.116-99-g41a729e6f9a9)

## Metric Fixes (compared to v6.1.116-99-g41a729e6f9a9)


## Test result summary
total: 113780, pass: 91019, fail: 1946, skip: 20718, xfail: 97

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 134 total, 134 passed, 0 failed
* arm64: 40 total, 40 passed, 0 failed
* i386: 27 total, 25 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

