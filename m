Return-Path: <stable+bounces-91921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D299E9C1C6C
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 12:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023341C22F41
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 11:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BD31E47CC;
	Fri,  8 Nov 2024 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMUtDzlh"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2011E9090
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066282; cv=none; b=QtGhov/7dH4d8xPEwqQA0D8eJiHl1iQgghNo8S4T14OSPaKVKhepD6vdzUcuGqq3Ix/azaJKiAbRxiTI9u/EULbciItsmgzGRHl62kKsEfQ1psG1AEnFgg1Qqe1cAhOIEGb6KeLG4D3JELzPqEFIlc0ZqK+1i6ZQ740ryjm6bYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066282; c=relaxed/simple;
	bh=+OKAoz88ppfKCnr6rPAI6mS9UizP4kyupQi780jyc5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P59SN6l/WDpY4GXsE/XNJC6YO0Y/cGhHNrHhplNNFZ9hYkjPbKKCSdt8OGbMfkPC/IyQu6cbDoGlyvoUMnRY8AL+AHCZsJiHPQdvvOyVrRTXXd4No0WMfh9QaAeGayLsqeJsm9u7b/0x6DguPwu2gQmC/4Kw+g+Wtyp/q/69oOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QMUtDzlh; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-50c9f4efd09so809081e0c.2
        for <stable@vger.kernel.org>; Fri, 08 Nov 2024 03:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731066279; x=1731671079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MkHXmgDAc7wSG/2nmCt5dHpGxnoKoPhVGd8Ic3kCUA=;
        b=QMUtDzlhE45tqJHkajZ14vzU8yTmQV2ti9R+DTF/Q+t5qn7+uC4l6VouVfDfd+kEeU
         HFo/ToGwMAPqFyZYwHYwy8QDyIL2m8LBVGuRhA7qFn3epxi6RD2Sn1WcgQRHmmLMsdMB
         h5O+7gZuYz/Cj2ma3lqQdZb9a0ado5tjnxi7IsyE3YBXsrNeofNeai+IdmJLaTN+Lgez
         XvPdITjrePJHSZFmwjFpA5Sc2JD6b3+iAO6puNRh3yCpjxyU//Fh1gT8yQeDDvrgQaWI
         cw27Zea2JMMPPML66ctFp0Zn44FlN6sEmio8ryIIJfJeox6Yl0jdwXXA4O/7sRoccQ/n
         5XuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731066279; x=1731671079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MkHXmgDAc7wSG/2nmCt5dHpGxnoKoPhVGd8Ic3kCUA=;
        b=UHfbGMt6AroHnv2lmtdhJ2tJrt3Vb6rNCL+Mv1X6piN+WKEDRzVEToPSFT/+8zoB9V
         GaRCvqY2ArUhA9pgxC9bADPsxRMy/XohwbkU2MiORxI4v4qr7IRBH00N/7DYZmDisg87
         Nx0iW6/SDnVi5eBNgmbfUUB9RlRzbOMRkEvY/AVaLCScwZGcYldCqezRUtiYBpC7G93u
         WwQf66Sb+AqrQsNkGaLNYwTWXXB8jhSGtc5Zf2E9YlKf5jWshWXfByrEwzifOdzU44XY
         YxCYAEvWxTWqcFrkVgpyXfZSAFIFoMT+eKZuoBMe/OPGPZ/5raCUrZTISnWHViOe8OMs
         ADKA==
X-Gm-Message-State: AOJu0Yy9ZzuadB8EiDwL9eLHXqGrC7qGwXjK3GzxVGJKH8YJlSKMV/WT
	Nd1d4WoGzRZzGIqFQDTkGxt1PVaQ3gu2nOik6IzQRJIuaC3HmAeDioy2hUO/58sa0WC20GJOXSj
	we0BMlYoVCgQh5d4on9Tyv+wCKLL/DpwemXXcEg==
X-Google-Smtp-Source: AGHT+IFAZTqKzcVIqRu2qUNfmV1XxJQHNHEolKZ0j+1gbYX4fXqaE1L7s9c3g5QIBoKkgQslJmlu4ncQztgHZ+I8dIc=
X-Received: by 2002:a05:6122:3c56:b0:510:185:5d89 with SMTP id
 71dfb90a1353d-51401ecb673mr2320465e0c.12.1731066278880; Fri, 08 Nov 2024
 03:44:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107064547.006019150@linuxfoundation.org>
In-Reply-To: <20241107064547.006019150@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 8 Nov 2024 11:44:27 +0000
Message-ID: <CA+G9fYtr2V+noAMBzyCafOMOeZf33bo6DKMcGOqsH0-C+0xPEw@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/249] 6.11.7-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Nov 2024 at 06:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.11.7 release.
> There are 249 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 09 Nov 2024 06:45:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.11.7-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.11.7-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 504b1103618a4532bbbf6558d80cdf3545a2c591
* git describe: v6.11.4-646-g504b1103618a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11=
.4-646-g504b1103618a

## Test Regressions (compared to v6.11.4-397-g4ccf0b49d5b6)

## Metric Regressions (compared to v6.11.4-397-g4ccf0b49d5b6)

## Test Fixes (compared to v6.11.4-397-g4ccf0b49d5b6)

## Metric Fixes (compared to v6.11.4-397-g4ccf0b49d5b6)

## Test result summary
total: 610158, pass: 505466, fail: 6987, skip: 97705, xfail: 0

## Build Summary
* arc: 20 total, 20 passed, 0 failed
* arm: 524 total, 516 passed, 8 failed
* arm64: 172 total, 172 passed, 0 failed
* i386: 72 total, 64 passed, 8 failed
* mips: 104 total, 100 passed, 4 failed
* parisc: 16 total, 16 passed, 0 failed
* powerpc: 144 total, 140 passed, 4 failed
* riscv: 64 total, 60 passed, 4 failed
* s390: 56 total, 52 passed, 4 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 16 total, 12 passed, 4 failed
* x86_64: 140 total, 140 passed, 0 failed

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
* kselftest-watchdog
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cv[
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

