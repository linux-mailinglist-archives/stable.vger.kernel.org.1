Return-Path: <stable+bounces-160182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB165AF91CC
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 13:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49426543F6F
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78C62C3265;
	Fri,  4 Jul 2025 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlG1Vrf9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358BA29D19
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751629695; cv=none; b=XywEaFJGMiLc42IPa4uR7YDDoK29Ds6ga0vHVdqXLV/iBlIk3hr7HKTf6YTOvtATNvtcYzN1tzg57FRBio+veMcknuOTWLtZ31fAzQz/Wr3qN68KqllgXr1dtQIv7VShHCqEUsVxvHEyM+u/w2zx76jeMIL6fNv5E5Yg4VlxVic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751629695; c=relaxed/simple;
	bh=BLt2e4gYJDfFUIoqp0C1xUglnvplbIMHK+j3HeEZ7T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoDDG/WTldcAPSzoO3pUph9cM/JOOkfuSeOhPXonCTsBifuMoUQMHKin3mstAsAOT3zbwBlrKxJuCA258+k3Fv7AWIJV4AKLWGkd7muLq/73A67XrFzb6FddmyHJp+NrbrULamvMCQmQ8my6wWS/ZrZ06v84eyAZxEV2/65HpDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BlG1Vrf9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234b9dfb842so8514755ad.1
        for <stable@vger.kernel.org>; Fri, 04 Jul 2025 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751629692; x=1752234492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUjN4QXidtuC9MgKWPzYZIK3wmGJF/NB5v4vy9SsyI4=;
        b=BlG1Vrf9tGgk1tePNmN9bb4jCzj6fFSEmKSMelUb5FA1tQjuoNLaT5IDg0Hv1C5Fp8
         sHUTZM80WWHFJIitWvMgC1Qc8fB0gH7PzQNDlmPykoq5Bx4y/aFdMtQZAES5zxuLhklY
         /MFwu7Zh+WJVgtvHxXVzKiuqVNMSXzNmkz+OmUEacM6jMjLfZF5T7cq8AEvuSKz9Wjbs
         vAdQUNVB5RpuaNWPCQDeSlhHj6c1dZoFhBr4XhxhMVkOg0Og9mHetwfzHBzwvzGCu6Lk
         13NAZq5g+6HxPC2gLzW5Efm2h3KqlnjkK/NIRtgKKE4o17vGkgSJ8l6XEeCfk+PwNWFB
         hd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751629692; x=1752234492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUjN4QXidtuC9MgKWPzYZIK3wmGJF/NB5v4vy9SsyI4=;
        b=HOMSA9G+FhtYPKhY0hWyLE/fajJJyFHV1lKDVB4aCGP5Nrt0ie5hOscWAhqKlKuvbP
         LlSX279GerVcsmMFHYts/w1gP7oWRFPB4k9UG4ZZhzVLyQsGvMe9CLjAbqFnW7bNXtOT
         q0z5+6kWjPgBAAG82o8NdnBYjjcEpTciSGhd2/N/kCoKN3hlBhNDD1v/olEwTvj2xpm1
         aCVijF3p4L8F0DpyeRYy+moxcTYNPZBRIO93oF0fjItv39N1aXXyaEfwHyk4aB50HTR9
         oMd5GLWfL08HBnsQvMVXNV+iS/UIcQkBO5a2TC+AIQOwoKHzrKqyjiYQ+XFztnkV/fNq
         KO4w==
X-Gm-Message-State: AOJu0YxVGzd7SFM8B8Xj9Y21xGvrJXjpwhtDhCAQHMg1M6WTZhBdtcAK
	lOR0gBVDjBaFSBeYlnOXDvNgIqvaunuuM1tNBUyA/BJt4DhSiQOev3x7qxlZDhZ12pp7R8sckwa
	DvhhlCK0WadZ26UPDpZfDwBlj62UQhnsQt0yOjZfh3w==
X-Gm-Gg: ASbGncuZxFitYkpxbWPa4W57V9l3d+YBuGWvCgtl12St8jZbffVeD0ySI78RkRpZEe5
	zGIthgFXYlSm/F34btjDe9JgKw0SLZ6ZoUeGfoccB8tN5ir5MgmEurepOVmeCuO99oJbTaY18TL
	acdNBNKLmTJo3FQ2ljatEun7jbG3k3FNW4ASIY/JhLCYmgNe9fkyb7Gzy70pAN2vM1Rube0daL4
	8Lg
X-Google-Smtp-Source: AGHT+IEZP3iwLGUJFpqwoWWIOW6UVQ23gWdyxZYmObiHJnJt2wQd7+1nwt5UYR1/ti449dFIgpH/kWfqiz/Bd7UHlwQ=
X-Received: by 2002:a17:903:3d0d:b0:234:dd3f:80fd with SMTP id
 d9443c01a7336-23c87465293mr33713885ad.2.1751629692416; Fri, 04 Jul 2025
 04:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703144004.276210867@linuxfoundation.org>
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 4 Jul 2025 17:18:00 +0530
X-Gm-Features: Ac12FXybOZIGHC5PyPBUj4nRBTvqSKaPmqw6NTEjvBZOrsk-eVQnQskIsVP5bTI
Message-ID: <CA+G9fYuk8=yLbdUv7ngQ0b5_p2-w21D6JdOYDcsdx7XUK-aQ=A@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc1 review
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

On Thu, 3 Jul 2025 at 20:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.15.5-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: d5e6f0c9ca48c1efb86783db4a2b4e457118c27b
* git describe: v6.15.4-264-gd5e6f0c9ca48
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15=
.4-264-gd5e6f0c9ca48

## Test Regressions (compared to v6.15.3-590-gd93bc5feded1)

## Metric Regressions (compared to v6.15.3-590-gd93bc5feded1)

## Test Fixes (compared to v6.15.3-590-gd93bc5feded1)

## Metric Fixes (compared to v6.15.3-590-gd93bc5feded1)

## Test result summary
total: 261397, pass: 239055, fail: 6046, skip: 16296, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 136 passed, 1 failed, 2 skipped
* arm64: 57 total, 49 passed, 0 failed, 8 skipped
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 0 failed, 1 skipped

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

