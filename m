Return-Path: <stable+bounces-46059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E9F8CE4EF
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 13:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C60F1F22545
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E84686250;
	Fri, 24 May 2024 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iblX/ADw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91DF86246
	for <stable@vger.kernel.org>; Fri, 24 May 2024 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716550948; cv=none; b=UREJaoBOzDp4EC6yR9wQ1Ty6syW+eaQ7mpKv2T3CEpy+Yo3O2bmcAwnLn+qqPjH+K9L3C8SuPhhjeFUgfGizwFWXTdCgsHIpqbj0pift3BIEKEhBcC0jdXPzRi+Qc7uNQDMRIPVGyb/RPNH5eje0ixTfMA6x2aHv93Tonpp3rAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716550948; c=relaxed/simple;
	bh=+mkcUxMgjHTJE7LSoGXd+4Je2IxfRW+Y9Nwx0ewwowA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAAtpcXdPBXQjgmYRkYpoCuBKyYYtfkOTOi4bRHMr8oDVRKXt794gfmn5tb47ympfpUYVzckocPkmEF0hEM2I/d2JLGNyu64aRGm0kOo3aMOh4A5xpMVMrliYuoYM+rOzuJM0XgCKLBttBUBk7+dYyp5Kc6uk418t/ln4Xp/130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iblX/ADw; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ab9d3d878bso4504276d6.2
        for <stable@vger.kernel.org>; Fri, 24 May 2024 04:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716550946; x=1717155746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUBz/X7v2h9KLktMkCURYwLf7bZdYcqIIXCNuLisKAg=;
        b=iblX/ADwDaIswB11C6CRL+bSCjJUupp9y3uGtBzcoizy0LepNI6p70jJB7fwUZlQAK
         OoHZBPYrUz4pWutt1LdQ+ZOXjFHHEjutGSkU3CU10xaXmzPds3TRXedQJGlCErb5MvC0
         JPlqXz8lmsspe+/2VEShCqT+3DEYpP7ezafiXkhhnZrOeIWZAhkMunuqDAwufBKLqFzz
         EcLvR4N1iJ51E1jRqEBLJV4yweP3YHFfXo3mwoFE3QeM5Wk5Z8YwvAeSwLVduVbU/S/H
         KFU1F6cHuuMGFr6urjt8woHgVB46lHlePNYlpixBBJ2/VnXW+qnBPA7aOk/EK4Lp+a5P
         zmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716550946; x=1717155746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUBz/X7v2h9KLktMkCURYwLf7bZdYcqIIXCNuLisKAg=;
        b=wAnTnVfUpHPq9Gqapy1yJwpGtRMYdoYP6yP80AnOLAaXg1ZQdsi6kvOU65W3tSOO5X
         Dr4KkgQp2UxFdkC2Pg9T8yTHaYiv8orhAv6Asw0F2XCsUANMS6VprUrc7VDluIC0Xp2E
         Khz+8VWmS4O60Jklzdt0MOvG2PYISTrN29P/FWEDDWjQZ0Gw8sppxxihqQXbJbx6uSWr
         AWfOQs5r4LLlmK88UJ1U1xfidROq9uoR7OLoOSp0dPmNYmw2j+e7wFpAqzz/wCIgLTMz
         Ayz2klyBJOYQvPbOyPzDoMGX6B/qLibOVHHgCmmdZWUZvVYWM+QJc2zIpUGu8Y6TNKu0
         7jpQ==
X-Gm-Message-State: AOJu0Yx1oAyetPfzltptgBdJcuoRXvtnqaWfT7kANMPifSOHqBL4M45Y
	7GN3ZSyDHGSJn6UZSepazB9QzKw++rrGSd2yey5+Q29MHSS1Qkr7xDK2msDc1VEpRr1p/9oy7hK
	oyNjJsWZN7FlQsTYEoHQc1Uzxnq3ZSwd3yHmQFg==
X-Google-Smtp-Source: AGHT+IHV7skJSpbmWm1CldNH/dEGLgQ0x0cx+ALY8NjMdQP0Uua1/gEx/s0+aDv4VPVhdjQGxLFULonAEOrcN6GN1uc=
X-Received: by 2002:a05:6214:31a1:b0:6a0:a98a:4846 with SMTP id
 6a1803df08f44-6abbbc3de5dmr17095236d6.17.1716550945617; Fri, 24 May 2024
 04:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130326.451548488@linuxfoundation.org>
In-Reply-To: <20240523130326.451548488@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 24 May 2024 13:42:14 +0200
Message-ID: <CADYN=9KS5gCW+C8V+bEtHDUUmuApv7Nq9xgHf-LTp887N-VLsg@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/15] 5.10.218-rc1 review
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

On Thu, 23 May 2024 at 15:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.218 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.218-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 104 total, 104 passed, 0 failed
* arm64: 31 total, 31 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 23 total, 23 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 9 total, 9 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
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
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mm
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

