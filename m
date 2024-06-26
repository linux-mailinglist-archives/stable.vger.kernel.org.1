Return-Path: <stable+bounces-55885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D53919980
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 22:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B081C21827
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 20:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B138419048C;
	Wed, 26 Jun 2024 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gx8dpGog"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A5E190698
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719435380; cv=none; b=sTIquWNd5xaFAmwcusrySoEbzXiX0K7cZ7qu9NaKXchirs1/3z2nfoGspqzDxjUw+7bTG7vsb+OWWcryIsQ+M09qRufjndXobx5bW2F6ydyJcrwPs3m17FVspX0jvtOckjryv/gps5FrflIim3iikKWbuJTp2J3Y1ICo9ROBVvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719435380; c=relaxed/simple;
	bh=LeNd1Sl00me4t5CXJexFKouTM8Rr4gR9mY11ueyyc58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohdqNfgrd3DavN+lzQa+ZVekYWrDg3QlFVW4RKFbGtzGlokmL67v7O8gXYVg26TcxDnxQUsMOpuD+nLYPLHFIYJJlPxHQtXvLQFIDOOqOA46KSc4kuFdWG6n3XoxX+0At5ZayrG/tvHZ+CliTcWz3PwzDQo96Fi9Hzs9FuFZSg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gx8dpGog; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-80f879181fcso1070581241.0
        for <stable@vger.kernel.org>; Wed, 26 Jun 2024 13:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719435378; x=1720040178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra6xNmZUFmFCQqOuBMuD5M9kR7LWp8krWQ+ZimOxr1M=;
        b=gx8dpGogl0R3SupSS4bydKYy73CeP7XvlEV+1IPk1yi0Us7lc6TuxeR5f58qdztbpC
         dxwa09JsAa5pY3VHw4u5gr0kTPqw11gbKC67uDhvxEGJBf2dAFJTyy++VUQlWv2GN6QC
         ilB2Men9jW+T467sFG+TDfW0meN+m5Esb+neuhPPcRzVhb0B/Hd8wzkwvqmiDSImz7cB
         2c1chItWqzlsjYcIEydWRUED8zddfljYrrYKYidcmWJt0tI3+SfyDfjDQynWOpq+2DEc
         /tiYq7GgD6uhAdS8/27UPGwcMhWEiSoph3YiV3k2RQC0iDUKU/jizt0Ag1wc+9kVsRYG
         gXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719435378; x=1720040178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ra6xNmZUFmFCQqOuBMuD5M9kR7LWp8krWQ+ZimOxr1M=;
        b=LOHLmXIJ9+UYl4cc30UAmWdUnwK8WJ0GKZ+gXUSHo3kQet6sbBHMReqFUUp8mNN+QT
         nvpUz1l73S0gUEJroiKchWNHszkeoxtd1jajqRXPugu7pg7XPCav63wVG6i8JdZB7aBm
         iQsI7djKCzPm/+/xsLDeZJFcHecHfA+5ugSn9Fty+aFgXudqdi7bbqQgCxNoebUP8UjV
         0iX90QTqUBi1bsz+Wqazed+zaQqyhbx4h0FFzco+wcm+wyzSVhwRz+ntYFmZagWIN03E
         d7+tQrEY0Nau0VijBjY0O+ra4ke8fmJL6NUVLTPeiUUWN7CrQ8p+lqJEoAOdPtzi4hW9
         pRaQ==
X-Gm-Message-State: AOJu0YwfWC5192iredO6Tak7wArigZpnGQxpd8k4kVGgKz2u1QWSW8eP
	9f67oYBQYKSskq7qzTia/TlQ6+j1TSLgDMagqEuCL5oH9Klgpgse+R4LVvs9AdsNX6SUGWQaLF6
	hdVFWLlxCN9LjuofZgYhxzXagwKi5IF/qD6+wUw==
X-Google-Smtp-Source: AGHT+IGd+fezczxsF8sdBmQyvjpmWSbG+CgYCWeg/ifXeMZVxI6nVEg79pqM2aK66grjjTiS0WLYLkxQuZGABcjv/vo=
X-Received: by 2002:a67:f807:0:b0:48f:46db:7a11 with SMTP id
 ada2fe7eead31-48f52947b56mr8666192137.6.1719435377713; Wed, 26 Jun 2024
 13:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625085537.150087723@linuxfoundation.org>
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 27 Jun 2024 02:26:05 +0530
Message-ID: <CA+G9fYscT-jC378sz7FVw_GSjQYq64=tKgJfvzB+3Gak=9wdvg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/192] 6.6.36-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jun 2024 at 15:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.36 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.36-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
The arm build regressions reported as described in the previous emails.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.36-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 580e509ea1348fc97897cf4052be03c248be6ab6
* git describe: v6.6.35-193-g580e509ea134
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.3=
5-193-g580e509ea134

## Test Regressions (compared to v6.6.34-268-g0db1e58b51e3)
* arm, build
  - clang-18-defconfig
  - clang-18-lkftconfig
  - gcc-13-defconfig
  - gcc-13-lkftconfig
  - gcc-8-defconfig

## Metric Regressions (compared to v6.6.34-268-g0db1e58b51e3)

## Test Fixes (compared to v6.6.34-268-g0db1e58b51e3)

## Metric Fixes (compared to v6.6.34-268-g0db1e58b51e3)

## Test result summary
total: 234233, pass: 204427, fail: 3373, skip: 26007, xfail: 426

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 109 passed, 18 failed
* arm64: 37 total, 37 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

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
* ltp-ma[
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

