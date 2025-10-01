Return-Path: <stable+bounces-182924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774D1BAFFE0
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 12:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA1C3BBAA5
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 10:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945A829B79B;
	Wed,  1 Oct 2025 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xKmb4fO6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB4C299A81
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314136; cv=none; b=l9M90OMoAN8Pda7CkNtRrPoc7fVFefCICxrGZQnKSgtZN8B891Gd74EzUTmHr2An53c7xP37q4eTo3N4cukpcpN3B50na2jBjkykH7U+7Z3Hufq3PoE1osa69fBzdOg8HfqourqKbZZUfw5pNqX4l7xvWFDohczoU1XU089pWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314136; c=relaxed/simple;
	bh=OTliHX4DjBx+mupF/CV++tI7w3tjBGKObI0txuXqMIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgHtuVOKWRV6cfUoeYbpUB5k+t2XVZFRnoZCjF4E7hi2otBbLXYJPS7Qvbws6ZVI0yBoXgmobPAqciIdu1Klh2JMF2KZHZfWjsz9reV/U5zdnu9z51SFmpfqeIEKnzyAQy+M+iQ3zH1cllM/+BJWX0WPDJ4kABddQVrs5uo8Kyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xKmb4fO6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b57d93ae3b0so3643613a12.1
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 03:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759314132; x=1759918932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyEVhMKoRQmspXzhQGLidUHqVI4iIdBM6eUSr/v/1i0=;
        b=xKmb4fO6uA5a+JbzC/SNSRHJsjeBalhSdt92neeRgtaC5UJgH+cijxVfoUOnSjCXkD
         kA1GDWzPUJhKKWaHoelhEIPy0cClhhT0ePYVztdD41n06qVs1FDZa1tLZRxEVYa3BzAc
         73viuqiwtoExMpxwjLoTjyazLtuhwI6BNRwO47aDpGbvddFh5VfLvgKCYbUf83Qz9bvZ
         fRJCtFYEedLhitVC4xB11qBsv9qh/nFMtjaHu3Fk+pQSEpgC5C+nUzv1VuPUnJZ962eK
         PyWylwzVHf3ObR2VD7O/GEYWSn9K0hx+l64PKpWnDaeyhiZ7Jr+t87Qksl/7yoZzVA3x
         RyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759314132; x=1759918932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyEVhMKoRQmspXzhQGLidUHqVI4iIdBM6eUSr/v/1i0=;
        b=u1WhDWmI8BVCOJc7IBYfYhyovRm9cKsIsyNWmT0xUHczpV3dAMtkXdHlmrt8eXCaxX
         coF3tNoS/ha7B0nLlDBSt/kYPWNpiAs3XqQ0r1O7PaMw5JX9PBwj8rp5DpjqvrsDskz2
         cfGZhpZhKPpwhR5vmjzLoevLc4Cia9mj0QL3qfNYG6KncxJdHjuraS+4gtKn5/azz9B3
         rId55tbzSO4wRURkJwC4BOlJXBrMspl358Pwij3aTZCXJ19ChwKm3t70PmsDVH+RtLbp
         IffOECtdrZmcgxE8uVZSxp7JmSHE9tQ1bAV0DDIhdx4OhPaweAFvAxf8esYfncUMvjtf
         Qwbg==
X-Gm-Message-State: AOJu0YzfRvzCTosyyaexVG1SbHP3NsZSoI0YToCBfneRQtKTifRLb876
	h4MkzAoiIXHrS7pa1urCR5umN5kjFSN5f0fAtqOF1nbzrV9d+sc0kGfvym5Lt9AQyhElWBf3hlh
	nw3JNHQj5PlTGgoerMG2mLe4GDmur1JgEdpI9mN5h9A==
X-Gm-Gg: ASbGncvhCAWlRqgqZjGB70EgV78mabBXZLj3OcafNHpddjP9WE4ki0fDFYnL1pqYoz2
	ZN9y0h8zQIVR/Iwg9HE/kaAZHCn/qP/nJxXQCTZ0H6MmhuZ696HLuD0qJYAYjQsTYkm8Nf+uB6a
	f3O5C9nFXNidsurM8RQrANng+c89mhIZE2HvbtJUhxcEndK6gaLilKGIe61DIZqMlscsXd86OWJ
	Q5JrXeRRqsnpoQQQVMKuEKyu0vDLxLhdPurVP7/fZoojpd1G8J7h97kOXCCrbRdqatmwbWbKlja
	8oCCjpSbz2GW6WFROJoX
X-Google-Smtp-Source: AGHT+IGo9YrBv9rBn/WWKf2pOXy6IvJ0AZVZCB3CCSonzjEZG/QZC9w1FlI364hn+cBu+gdtSNuOo4dxGMfNqACEMPw=
X-Received: by 2002:a17:903:2f08:b0:288:5d07:8a8f with SMTP id
 d9443c01a7336-28e7f2a3ba2mr34511945ad.24.1759314131937; Wed, 01 Oct 2025
 03:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143821.118938523@linuxfoundation.org>
In-Reply-To: <20250930143821.118938523@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Oct 2025 15:52:00 +0530
X-Gm-Features: AS18NWDFm3YBIpvyX9ximxJERerne8N0kR9urFmXd3w78LNh6kYHsL6Fv75FDXU
Message-ID: <CA+G9fYvsvta0E7hQ84mY9=1aY0z3kypxd2CR-RAtqtkwM9fZwQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/91] 6.6.109-rc1 review
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

On Tue, 30 Sept 2025 at 20:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.109 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.109-rc1.gz
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
* kernel: 6.6.109-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 583cf4b0ea80d8f32feb8655c39067ba1da1ffd7
* git describe: v6.6.108-92-g583cf4b0ea80
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
08-92-g583cf4b0ea80

## Test Regressions (compared to v6.6.107-71-g6bd7f2a12b28)

## Metric Regressions (compared to v6.6.107-71-g6bd7f2a12b28)

## Test Fixes (compared to v6.6.107-71-g6bd7f2a12b28)

## Metric Fixes (compared to v6.6.107-71-g6bd7f2a12b28)

## Test result summary
total: 291438, pass: 270254, fail: 6807, skip: 13926, xfail: 451

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 132 total, 132 passed, 0 failed
* arm64: 48 total, 48 passed, 0 failed
* i386: 26 total, 26 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 40 total, 39 passed, 1 failed

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

--
Linaro LKFT
https://lkft.linaro.org

