Return-Path: <stable+bounces-163126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE16B074EF
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 13:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A6C580BB4
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 11:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DD12F4304;
	Wed, 16 Jul 2025 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lh6khaKa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA62F3C20
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666280; cv=none; b=fK8be0ecRfPY2j4dDJ3XYiQH6qwbFMScDlbx3ARJotlvSQaRyqHZF4j18e3amWGycw3KhPjiFET+nnoDsX+wtdQ7CDRBmjl6rtvtEk9wfaty5D9DRJzjiJ/uHxC0TdssNEu6zgSCT8bCCVwaM2jNZZm/R75s2J7FVKJqoz2duvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666280; c=relaxed/simple;
	bh=JnOG6ooJhnbu69xt4DZN9M0n0dNgDQGpilBl/b+s1kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1UuG2CBqxFXqpVRE/f8tLuW/PpD9NqQmiNRj8NjA4JJhRW2lrsL+gQVnsUYxM+S+hoerDIeaRp7fSwae8IDdlcifZ/n9VfB3MT4iuSxHL4MrbCASC03gRbx96O+wUmO0hzWp+Bf4HuFVPBKEjkJyBjeYMvPrOxBVIVdDzQSezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lh6khaKa; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31c4a546cc2so4932864a91.2
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 04:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752666277; x=1753271077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9Vrzj9Fu7WIJeE2OnRZTO2T6pseUqFryRb+fWlv6fw=;
        b=lh6khaKalRJ/EVFZ0QHczCMcp3Gqdc1l5FNgL00erZp5dGvBDUptv8UZPKuXelfM/K
         nevLPk+knU8ADoyO5HBOkLB2tJwh5wC3BvRzoembzQjJIMw+ZsusfHSxGzyL+9A166U2
         wAYaN/C3WNtOMzMKK1xGqme2Ct9AB/cU8Bv/WQTYABVfoGVXhOjC/O/3+5aHJ0uPoC/4
         eQX0sCLL21QeTfM0Nook1oIxyki/bUVCgt6oYelTdAdG1pxcihvmt7kLW9w3H4SBxwk3
         OV6Vj0wLcjeErp41lkwhBrf6bswEqHT4P4A42xfbl16ae0ImporPK6T4RDSNZG1pU7Rz
         RM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752666277; x=1753271077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9Vrzj9Fu7WIJeE2OnRZTO2T6pseUqFryRb+fWlv6fw=;
        b=HQxRvR+4t1gGWteu3OJk0bKzGJDiWFeaPNI6f3OtxTwkMoItY9cVcAv+NvIdST54VH
         pbIBsfAkWwyXuS4k3DP5vRZNHYebQx4+LI8Pr8Hr+LGEhurSv4HV8FTCNy3CtkfU2Gn/
         La8bLDcaq5uIc8W5Fe+FC3g0ecPUDork3vGSqzVdaMX1zF6TNvD4Z4qEu6g9g7xWwW4t
         V/yKxtQJa/c0vshku5rrQQSQn16VXp509F8tgfAoPgTjJRny9od1a5BIusbgjNIvmLJb
         d0POGIKv6oRonThghbVUCDbZQlk9t30udhF8TGHLLDl44d8gF6WO4W4KkzMguWUJa1VH
         E2cQ==
X-Gm-Message-State: AOJu0YzDH4w7oVhFSAOhXai6iawaS80JD/Wb4nJLMUc4ibMzTvGsBdF3
	30OO2N1oMviurhn6eUzvNjVIQHX7qNlNBP6JjQ2IpncjWyRgrDnChKyEJOsSoC8JWZ/4rLY8yK9
	3Dz11TpsIkHvJOfC8neU3V595vaIxoCVmx1tMuvfO8g==
X-Gm-Gg: ASbGncuuu2PXMPSHUtTO9kYG5OGCCrO4S4sGic3yiG0dJc1RSedsxUcZ40GlgfNDSV8
	+lyf1KsdjS+dEOx8pjMH04b+4MPMY2qvUgTIwIl17xTqilpZvAvH7TvFWQwahW1wSBxt07W54jz
	6RD2AojmHiwZ8qVwaazyckT1Vsile+6cRu6rg6RCt4/Bz04vKW4dg0YvXuNXOdioDSZNQzgqwPW
	1Sh538iNnhhbLm7a9gNtOl5vFCBY3PF6l7P7YBU
X-Google-Smtp-Source: AGHT+IFNEGCm4dlaIj+7IRWJC0AscMoG/Wnk3C9p4eF8l9ElmPT2xzCbzseXHqg93ffcOeAzDsnVK1buOBoIc1vLXC4=
X-Received: by 2002:a17:90b:48c8:b0:313:1a8c:c2d3 with SMTP id
 98e67ed59e1d1-31c9f4a8027mr2910872a91.22.1752666276531; Wed, 16 Jul 2025
 04:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715163542.059429276@linuxfoundation.org>
In-Reply-To: <20250715163542.059429276@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 16 Jul 2025 17:14:23 +0530
X-Gm-Features: Ac12FXwh_cyJTG8bELy58HCa7WlN5iVTMr6vUGIj2yM5KVONAlV5bNbRfch_oSU
Message-ID: <CA+G9fYsQdL2XhjF_cHSni+ABMHoe0aDiwV_zyT=Y+-k8ovr20A@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/111] 6.6.99-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Jann Horn <jannh@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Jul 2025 at 22:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.99 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 16:35:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.99-rc2.gz
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
* kernel: 6.6.99-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 9e2d450b5706b55c38eae29739b1b81ddd7e3b9e
* git describe: v6.6.97-114-g9e2d450b5706
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.9=
7-114-g9e2d450b5706

## Test Regressions (compared to v6.6.96-131-g7b8f53dba183)

## Metric Regressions (compared to v6.6.96-131-g7b8f53dba183)

## Test Fixes (compared to v6.6.96-131-g7b8f53dba183)

## Metric Fixes (compared to v6.6.96-131-g7b8f53dba183)

## Test result summary
total: 288485, pass: 264299, fail: 6263, skip: 17525, xfail: 398

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 128 passed, 0 failed, 1 skipped
* arm64: 44 total, 44 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 37 passed, 0 failed

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
* modules
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

