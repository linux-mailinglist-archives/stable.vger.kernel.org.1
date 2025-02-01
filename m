Return-Path: <stable+bounces-111889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A560A249AF
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 16:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037C416562B
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8461F92A;
	Sat,  1 Feb 2025 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xv6HSZu/"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01901C2337
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738422910; cv=none; b=DrejfzQhH+4vfGBwExJ4TBXstidwkiIbJopaasQmlFeI2/eovgeuYV/TipucCyIJNOzxNKIaSTCugHGsYe4QVDpShPEEKCuJicsu8Mjd0wGhzel9Vqg3CGuKThJX3Glu6vOIdyEIgE4HPqKqhLFDPX7B5oP4EB6hqwwlnlv96is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738422910; c=relaxed/simple;
	bh=grZzjOTp5UoxSAJdG19Iv5CHEy0RSryjcZZhcpUC39c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nh5LOSDgJ5rsmKtibGStOXEy5vbuaJO3Aa6LEn3UMn0n5mdzRrQyQA+6g/Q8qEApnPY3IcvXlwZc2uLIlrKWoFUc1+oLHq/EXu6cQ3SRoHbcv6JaSB+uDGGKRFrmWoulXPDN2VqmmuaxykmcvzzrldhOJkxwbZq1IOsKBCkzpiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xv6HSZu/; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-51873bc7377so975329e0c.1
        for <stable@vger.kernel.org>; Sat, 01 Feb 2025 07:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738422907; x=1739027707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqUogr6li+EQcK4KgEU6JhksjMQU+YKI3tRfrBxh9Ck=;
        b=Xv6HSZu/bJQ2J773V55XHI7ei7s3MqsY1mD8IJ5LvVGjW5HZWG7EQs0uR/Z9ksNRjP
         MUopZdBrJ64ko5saQ3MtIEPXXnZlxwDGgjjaO0tjE4CLTLK7+XORf0FL/04A9Nvv4fIK
         +U9ufVpKSHqCZ9yP/byjHy2vALocYSjn8SUquu+XdtLYsJ7CMObXGDjt9oe3CEEpBv/3
         HrJKWI9kOMo/ETempNpwG2Sl7QH3ExVvG/AwCuIztLzejLb5pf6Fgh9cVHffyar/bsxd
         XGseNLbgMpSY/ynZoEM4hU9QeKhfQ4qRffoM+bSHD4uzepZYL4riOLlBhNgwdjGPcHIT
         yypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738422907; x=1739027707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqUogr6li+EQcK4KgEU6JhksjMQU+YKI3tRfrBxh9Ck=;
        b=VtPMr3lDJ/y4SkfhZxkUWAcftS0wii+5TW/F+XowZz5VznPam30FOtTxQUEzFT8kmI
         CWAi83RuIgp//LUw14c9prl0SpITWLh9XvYUDsECybaYsDzOSCgV9RVdZJWMQm0WLQrX
         D4qoEoAkfttCRQEPbTiMVbxsPo+tRZjaF+vbAjCR5C95A5Xh9djFPp5/RX4a3YtDhzSB
         f7cHb50act5eWfRLl7h+O5S7bAUZ60pGaI4iorW6o3BfDNdoIKkfWgFUwg7sjwcTfJMw
         OVWiuGLbdpv3NWlxd0+Vs0/fv5SlWJP8La/gsmeAQd/hKppCl4ThwWQwjAumX5p7L+qI
         0hpQ==
X-Gm-Message-State: AOJu0YyYQAakxcasQdZ+ti1/gKfwWL5OQY5Tox28ugeZd/a9QGdGubkg
	RqhwHzpcgOCN8BojkNNWXO6IkWLVfuie2LKgfIxNeq3SAafKjCz/b9shhkBWXjpbBhez82wvijp
	eII84EP/ppFa2j1xK0dX8aQOmRWcimp2iK+LCCg==
X-Gm-Gg: ASbGncuTK26RwZa0CLFBcTZSieSREHx5tf15gWRVDVGBxCHbVVxTb2ZaTewko6usg7+
	cNKK/ezANsC3IunX1MrCC99Ht8nTZO4fKUqnmSTysTp5DumvI2INpI9CoINQl/A44Zf0Gf8V8DH
	c=
X-Google-Smtp-Source: AGHT+IEaV7VfecG2k91AzuNc19uCZEV/4HVYuQHZQcoKg7q1LxaxbqmhJg4rOW4rp8U1tUb5bA/SK4fZn79dgHO+50s=
X-Received: by 2002:a05:6102:3e15:b0:4af:ba51:a25f with SMTP id
 ada2fe7eead31-4b9a5233a2bmr12955902137.20.1738422907554; Sat, 01 Feb 2025
 07:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131112129.273288063@linuxfoundation.org>
In-Reply-To: <20250131112129.273288063@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 1 Feb 2025 20:44:56 +0530
X-Gm-Features: AWEUYZn186bX7d-ejOshMMFJpRDXth8s7NIOuvjxj2MaiDp-6eYGDEBP2ddGFag
Message-ID: <CA+G9fYtW7_LA+ZZ4=bw0m7V-UiSyQaztCw0YY4X45Efcjq5f1g@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/136] 5.10.234-rc2 review
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

On Fri, 31 Jan 2025 at 16:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.234 release.
> There are 136 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Feb 2025 11:21:01 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.234-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.234-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 99689d3bdd980ed74fed764babc35d90522391ac
* git describe: v5.10.233-137-g99689d3bdd98
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.233-137-g99689d3bdd98

## Test Regressions (compared to v5.10.232-139-ge0db650ec963)

## Metric Regressions (compared to v5.10.232-139-ge0db650ec963)

## Test Fixes (compared to v5.10.232-139-ge0db650ec963)

## Metric Fixes (compared to v5.10.232-139-ge0db650ec963)

## Test result summary
total: 103553, pass: 67752, fail: 13776, skip: 21285, xfail: 740

## Build Summary
* arc: 12 total, 10 passed, 2 failed
* arm: 210 total, 210 passed, 0 failed
* arm64: 64 total, 64 passed, 0 failed
* i386: 50 total, 50 passed, 0 failed
* mips: 50 total, 44 passed, 6 failed
* parisc: 8 total, 0 passed, 8 failed
* powerpc: 48 total, 46 passed, 2 failed
* riscv: 24 total, 24 passed, 0 failed
* s390: 24 total, 24 passed, 0 failed
* sh: 22 total, 20 passed, 2 failed
* sparc: 16 total, 14 passed, 2 failed
* x86_64: 58 total, 58 passed, 0 failed

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
* ltp-filecaps
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

