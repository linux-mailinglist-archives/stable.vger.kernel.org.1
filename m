Return-Path: <stable+bounces-60463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC83B934142
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 19:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544651F22328
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905FF1822E6;
	Wed, 17 Jul 2024 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/PW5tOg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF40F1822CA
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236501; cv=none; b=qbhoGB68FXw/GKHAru0RWfALrSjKftumHSLveZOZWQ5g2NqPfMDTvmijQu48f+118zL0p+e4VDAJnKXD1oryZWbYvartXA6Ieu/t2VJQrLJ0qhreOthN2QoyvEdRE0sGq8IuGBRA6E3+7Edx/jGiU0+/fG8LkkgL/47dFT0XEdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236501; c=relaxed/simple;
	bh=cw30YfvidqMdAX2ktCxRyPLr2LugrsLeMrCFFWIhdDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJddZEoWu+TJYMyVRZVxP4Tuc+ykbuw/J5F+acDGsJ80qZ3O6eOUaCDdszvS+77jyxrXCMNuL8icO/N5m1LTs9OR1IRN26gkn+KQ3Sv4l5g3mNk9oKneVyT0BdnZFO1HI/ty0BZ+3cyrHaVHPHaa8yUNsAtBg9ySTEiNrSREgLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/PW5tOg; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-80fbfeecca1so467259241.1
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721236498; x=1721841298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pDlFW+0uEtRWgzfnhOmL6Q4bRT/kPk7C9hXwCrZE8o=;
        b=S/PW5tOg2qhEo7cr6kbzRCot5hwqsVx81iK8co7ydff8DL5lBY99GEZJN+Mjss6v4l
         eHs9n078yi132RA+jEbK8KWlJJnI9GtGwfarVNDc9lyUPbvflKE45Anad0lG47n66zPT
         tvey3UL87U1y1UJzWaOT81isGOOMBypq4MQrySNwvsFecNrzBvJH7qF++pCqjzSJRd23
         ULrSTjk9Hl1GRr3ZrvGzIAf0hE5TMDhTbOh8Z5ulYuSw5k+sfjEtf2zk4Ka5ezd05qXv
         TmlUdCFZzvDmNx0zZWITVuQDQ5KTF2npQaN1enHEfjRs9ivG4n35oGAU7tU3oacJj8Iq
         pF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721236498; x=1721841298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pDlFW+0uEtRWgzfnhOmL6Q4bRT/kPk7C9hXwCrZE8o=;
        b=iubtIUWvKgAJfmPZb4LXKpEbGKP0uniQZbxdDz8ztgBEMNGtfoPwN9zxYMZgSqxGng
         ifurBBLnc1obHVfwgP67IquKaWeadw7UtKJCd+eIDImek7EPZhoJvw741KYfoLdqk9YJ
         zyOfHbMFUn6DlwIDQOfk5XCvo12koj2ShF1PrI/FYWqMTeG/Bxm3zLJiJkuXoV31yCQe
         k7Nxw7Ks3WZPvcrbv3wO5bMEAacNT46c7KpVkXIsYNOTTxnMszZ2hNIcBFvLKlvtr8y9
         wPJxBA2DU3n0mqrMh6EL3ea0YXE/dzE9MRvN8hf4lezUUa+rdeyJb8+NdHR56AKxMI1e
         gB2w==
X-Gm-Message-State: AOJu0YxaGQQFizHScsEBfFMx3LEjPwPGQeDQsTKtyuuwnFUJqgjrVj2U
	mXyqPmNUE1USdqmqP96KqGiwGbi1+SyKEPkSBanFziYVf8m6EQR4+VmEmwcNDJFwtMwDC5GzNVi
	PWtTO/7qKkr7J4/c+Ti15PwcCX+OYJaNzpBz8zfTj4dZbXmdQNXPXfQ==
X-Google-Smtp-Source: AGHT+IFV2Rs08vOtSHS/pIuDotDwNtFl5dP1U0UR7bwlPlrSRd9Kbn7q6Oa0g3IkIkOG730WdUMEEkNczqEwG3hcXfo=
X-Received: by 2002:a05:6122:d97:b0:4e4:ea24:4c53 with SMTP id
 71dfb90a1353d-4f4df63874amr2705262e0c.3.1721236496976; Wed, 17 Jul 2024
 10:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717063802.663310305@linuxfoundation.org>
In-Reply-To: <20240717063802.663310305@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Jul 2024 22:44:45 +0530
Message-ID: <CA+G9fYt51XWL7Od2wno47hEGTiOFYJ2JfhdyZEha7GwjN1K2FQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/122] 6.6.41-rc2 review
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

On Wed, 17 Jul 2024 at 12:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.41 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.41-rc2.gz
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
* kernel: 6.6.41-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 6b4f5445e6e6e806a7e9bfbb1e1e5cb73c0e07fc
* git describe: v6.6.38-261-g6b4f5445e6e6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.3=
8-261-g6b4f5445e6e6

## Test Regressions (compared to v6.6.38-140-g3be0ca2a17a0)

## Metric Regressions (compared to v6.6.38-140-g3be0ca2a17a0)

## Test Fixes (compared to v6.6.38-140-g3be0ca2a17a0)

## Metric Fixes (compared to v6.6.38-140-g3be0ca2a17a0)

## Test result summary
total: 140936, pass: 122778, fail: 1053, skip: 16932, xfail: 173

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 126 total, 126 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
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
* ltp-sm[
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

