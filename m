Return-Path: <stable+bounces-196579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B232C7C6E0
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 05:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09F63A75FC
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 04:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D18E285CB3;
	Sat, 22 Nov 2025 04:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIhTr9Zi"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94328489B
	for <stable@vger.kernel.org>; Sat, 22 Nov 2025 04:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763787084; cv=none; b=Zv8wzY0dCgTO8l3yli7asOTh3jWtNHB+vLcDcXxhxNRm/BaOWGYnqeMBP6H4B8duN6kLyrC3LT6Gb4AVYM3OE/mQoizvfBeo54VDGe0rHzzCtEWbL8jVu8GvD4DMikPwVkjHY0kfcApLtXbVeELzwED4OAwj5EHbNuB4dsTfHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763787084; c=relaxed/simple;
	bh=TUEua0/wAoOAjKQrGKFZvy18WHinTe1oqQGXmuicXKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ow0OXVXEBEMgsYRcx3NTO4DCuS4DJeUgvFHbIL3hitjebLk8CWtgtGaSPFbn72lMSvq6kzAH/f+p+pTFb6RU5epjN8qmWhtzgIp5f5plldI1p3j8JXEMs9p8jYtvf5CvqKq6zAVCxd7DPP/oPWCCVIGgGozjryeDQopqWgRnH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WIhTr9Zi; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2a45877bd5eso3839547eec.0
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 20:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763787082; x=1764391882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asI63flty4mvoIqkQyV2Ch4O/PBYBX7tCTS9ueMUh2E=;
        b=WIhTr9ZijnZ+cQMZEe+H8AyfCBI5xWh8H9d55LfJrboEk+nZ1Mf63VJ3JSa0iBwxdA
         RIE+03rfnSR9lYylzoN6ogov4cemYkw3lmENFRH92sK2klzqg6hfe6MUXcKMxi4JK9kN
         izh7PHahsluiObOqlxGVQtyEb3Ig1NCAkLigRYiI4jJVnqkcOM+XJmxcedbj+3M8Wovp
         ht1JgFrAljapIAk4W3tv9ENpxmcQHF2wdegP7+QubHH3D6WRt3UTo7MCNoZMiEH8M+zD
         qL9r1GqzOrxuETPqa2OSfUt7n56RVRPlXRzFa6V7IdHX+PhkCz7H+54iEbPYAguJjjI5
         yKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763787082; x=1764391882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=asI63flty4mvoIqkQyV2Ch4O/PBYBX7tCTS9ueMUh2E=;
        b=vfCRttihc03sFwKUUxwzm4y+Q6QLh3Fnj0wxU+glMpITK3Nb4M/y1AYEfsQ0Jjb94w
         uXkFLr3/XiqS7kJAzhfCWIIKyUPWhBgKPharP0p1VTLsk9X7XVUQD0AhMBlPgju2lxiN
         GMzLXK8TZQSaX+7lMLTq+GAOYHGzknHcy2a9uJTwfvVnG8pLU8lHuJx0oaYHCEikzajS
         L+Vur2xxnv+2Ilyq2MXLWT1FDf0YSTimm9fgJGVCi257Yk6KVny5PqT0A5eVqlPGZTTG
         crTQkVAqnk61X+VEtVy233vsDmNpDCdXFWNA5EOeJALsOfhyJeg6CHzQfbXXLC/b3Fau
         wYyA==
X-Gm-Message-State: AOJu0YzBdwWeg2xhE7tTV0/poZU6lwkJWWl07UOEqpq6RSVjn7Jip/2Y
	MTxHY62dUjgFGbTg7XQh4POvmKJri6rsZlmlkbR7wyuLugf75Hr2YZHu+Sl6CYXI1nAonemnHXR
	rsvvfegt0NddSbtPMddCXyjw9gX9P+1VX6YUuyNAQvg==
X-Gm-Gg: ASbGnctkXiYSELjVWWc9h/o4SrX0FlTsPQRGlgTGoJIt12vpmDqPLeDtzKJwMHGfFRD
	XQq6VrD1O0OOm6OOpIyflHn/twWKuc0Iin+HJCXIDwNnN1FaDquT7aAzlO/we/FnNo6uggBYJpB
	yG0dqSEXoUqtNNSLjqFvfi6Pdo8klKgBocMr1S+2Wn/cKxVrd/ZOtqci0/KdS8CqhSa6uPgK85s
	5UsxYMSrFkFqsxcNWDEuQc1l/g++mELFgK5lImmub3CUd4DeXEqj2eL/T1nMkMu5a69Yy4i0bCx
	ShX9T9sa5Ch0Ij560aS9DQcCJme8
X-Google-Smtp-Source: AGHT+IHwmVvlAyIIo+U94q9DXDgPlcT96xbKFJ78wizY3cIfoXa0JvtGu4A1hwwjgcpTk3Cfc1Utcro6JanCnEenBbU=
X-Received: by 2002:a05:7300:a2ca:b0:2a6:a306:efdb with SMTP id
 5a478bee46e88-2a718576e14mr2236705eec.3.1763787082112; Fri, 21 Nov 2025
 20:51:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121130230.985163914@linuxfoundation.org>
In-Reply-To: <20251121130230.985163914@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 22 Nov 2025 10:21:10 +0530
X-Gm-Features: AWmQ_bl9aP_dXviGSF9smM5QiMhfrYH0QvLhLHd01n5dELXq-9_2NCdrAo_s_JM
Message-ID: <CA+G9fYt1RAW++XEOaFMSd-ieMJR2Ltj-6MgeRGV05SmTYBmavg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/529] 6.6.117-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Nov 2025 at 19:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.117 release.
> There are 529 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 23 Nov 2025 13:01:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.117-rc1.gz
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
* kernel: 6.6.117-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 69eeb522a1e229275a2a2a4ac61032a65b6785c7
* git describe: v6.6.115-563-g69eeb522a1e2
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
15-563-g69eeb522a1e2

## Test Regressions (compared to v6.6.115-33-g2c2875b5e101)

## Metric Regressions (compared to v6.6.115-33-g2c2875b5e101)

## Test Fixes (compared to v6.6.115-33-g2c2875b5e101)

## Metric Fixes (compared to v6.6.115-33-g2c2875b5e101)

## Test result summary
total: 101411, pass: 85745, fail: 2822, skip: 12615, xfail: 229

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 128 passed, 1 failed
* arm64: 44 total, 40 passed, 4 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 14 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 34 passed, 3 failed

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

--
Linaro LKFT
https://lkft.linaro.org

