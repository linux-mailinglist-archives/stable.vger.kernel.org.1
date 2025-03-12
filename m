Return-Path: <stable+bounces-124141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA5EA5DAE3
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 11:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CA71895C5E
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC1E23C8D1;
	Wed, 12 Mar 2025 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQkImav9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D750233D85
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776710; cv=none; b=Kylto0O4bnjSUYHjCnXQtyAJq9H9xl2HuogWx9bquWOZSAnUCOm+a7+Z1h0zsNjyOptgOjA+e6fM2hdiMZ2oGHTDubst3B282aycNBxzXgdfcF9A5PrzGNlnfDOnkZPPrY7vStCp5NEhQx2BIPDbxzyMXz8BWjEq6ZMudQLI9cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776710; c=relaxed/simple;
	bh=hXSiJkKHJBCdJvH+R4+/RqJzaWY/eGeelD7MrTlv2js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxvpQpPli9qKVonNTg1ZcE9RUlNPGU9EgCnJkQSkLmQFMZtBCvB9utruGXsCKlDIECpWwQKeDdCktgp5bm2yF+PQhqLrtx4+ojFWWnAeIPY/CM2XuujVQryrtsE0ZJ2+lrBuQWKSclqq/CUvJv9x88Ohy8IWHXfIEXLyheAonY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XQkImav9; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-868da0af0fcso2798795241.2
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 03:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741776708; x=1742381508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofIXHd0nXdS+xLnWIW+XGUrMohg/3SYDu/r8Q0SMWRM=;
        b=XQkImav9+qKA3r+WbThTaGTmC1tmV/Sie/WVuadNrxxU5AjI7xvOBvyP+KO+I9iOGJ
         JAD8cu5iYEt+MKyBc/i4fL9VRT0L0aqb+4HOcRectocqEPIVDteCMonZN2ZM59I3a5bP
         hArmT45qsA176aqkDUOi+bbduaJzfKlcVUqQF0dc6mawhS4qk9vGbG/B2ZOsipFBs1Md
         nV7HpPRaZ0dKOkZs4q7BpeAUG3p9NFHGoRQm8p7Pl20Lci7epoQErEpdmvphMR+x8Wc1
         UDT3N8IgtU+2tAgDMtqfoihnudbeJz2NeIIGhN4andpwVrZnr13mvCPVhQkzYtUOAal1
         Mdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741776708; x=1742381508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofIXHd0nXdS+xLnWIW+XGUrMohg/3SYDu/r8Q0SMWRM=;
        b=MS5d/mkcq7O3cWR9is+HJeFOVMTHqF5lnrgXBVfoWznCRGZ8zL8dCfk8qrPdfKfMEl
         5ZLsW7zc11czQPg9hB+5JyWZup3L3rkMSGEHREqUAIpBqrdefgSqNIUyzPi17lTZ3O5u
         lyGJnAOCOkHBpx6oqVBjZ9p+BgNxm/sBiX/BQmEReyEVXf1xQfPAGyFMu7tWJFhw3qbS
         JzwC/2RJ87BeQCFK6qdh9pk5xULqXf3oGpOdnyOCAtcSiJ7ym8AURN92N84RWEzQoW6D
         /nJ1RXAaB4F4PcTgfBFmpDNS+ywfVgMwmU/y231sYqM4VUV2P731FszEFuP1DNIU9ZR0
         fAlQ==
X-Gm-Message-State: AOJu0Yz9JqTSA2UnGcdDyVPstNIhW8zfNtr7V6oq2lgCqftDK3fdzxi+
	XEbvkiSf0ASNpX9TALhckOGXVa9D90h+hK2dS2U+/C7Qg9+tsO8OmHSm31SnDkRyK3BZNWb0uiV
	ajRXSwHoGojXADrPcOF6ilU+4WdyDLIvvOCdmHQ==
X-Gm-Gg: ASbGnctGz0qnzajUsOfhqnQF2Qo22XJRT+IbU5MHm5B7LlcaCjoCCTvirI5s4p2NvoC
	peaFPGq6BfgoY8zhUPD81FXi6j2Zl6PjYFuVeGECT/7G0VwulZYHpvj7O93dxzzuYfk9batrsyv
	Mu9EOgZe7qpu6uOwnD/xduJuV6kUwpcVnpkCEKEDPfLdcbkil8aJnNBu+AY3c=
X-Google-Smtp-Source: AGHT+IExqjwNlPJDVbhRq1gUihp2DfP+lo58w+qtI1pZKKxOFe/VwKkG7rpQaIQKS+9RqW7lVdJCkF4xzButJtwk2EQ=
X-Received: by 2002:a05:6102:808f:b0:4c1:935a:2446 with SMTP id
 ada2fe7eead31-4c30a6aeeb4mr14044886137.19.1741776707905; Wed, 12 Mar 2025
 03:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311135758.248271750@linuxfoundation.org>
In-Reply-To: <20250311135758.248271750@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 12 Mar 2025 16:21:36 +0530
X-Gm-Features: AQ5f1JoF3cL86ld_u7OGbca9lABCc58A27MGCDo0Tu9RpKsaKCWwzWHaW4rmjTU
Message-ID: <CA+G9fYvZ024_ujvUe=0YJ6xDD-sNHAgjMzX0EJpOGd98RtP-ZA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/616] 5.15.179-rc2 review
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

On Tue, 11 Mar 2025 at 19:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.179 release.
> There are 616 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Mar 2025 13:56:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.179-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.179-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 4372970bf8669b796c66bde58c72b591b8934373
* git describe: v5.15.178-617-g4372970bf866
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.178-617-g4372970bf866

## Test Regressions (compared to v5.15.177-25-gcd260dae49a3)

## Metric Regressions (compared to v5.15.177-25-gcd260dae49a3)

## Test Fixes (compared to v5.15.177-25-gcd260dae49a3)

## Metric Fixes (compared to v5.15.177-25-gcd260dae49a3)


## Test result summary
total: 70512, pass: 51509, fail: 3484, skip: 14908, xfail: 611

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 105 total, 105 passed, 0 failed
* arm64: 32 total, 32 passed, 0 failed
* i386: 25 total, 22 passed, 3 failed
* mips: 25 total, 22 passed, 3 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 25 total, 24 passed, 1 failed
* riscv: 10 total, 10 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 8 total, 7 passed, 1 failed
* x86_64: 28 total, 28 passed, 0 failed

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

