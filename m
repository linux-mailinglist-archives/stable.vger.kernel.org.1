Return-Path: <stable+bounces-91803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D5D9C0527
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 13:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EF41F22170
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DAB2076A5;
	Thu,  7 Nov 2024 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iKTCuXB+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EED1DE8A4
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981023; cv=none; b=CFVwwf4Doi7XXjaGS+Mcp5ILzhCAwSRr+Oan6kjQ15N3sJThIlN5ep+U5c1HEY2RIz4uzPI2+CaiCCZkaiGTSLy+pDDDvhBxaCvUTrcin+nvRQqBBtmPo7gtpLMkf63AJE6GQUpVZcH+Vah+Blsr4wG4FkpL2QLzbWRX7npkP0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981023; c=relaxed/simple;
	bh=IHosAZVePfA6j/L2D13dnEQ/Ic9W8mSBmvs6TFc9t0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaNbmyZgU8njKoCO3E1jan0xj5OfrHP+3oSvqZ/RjdFQeCshlvQnS5i1NPUYKNZESL6+Gc9txsZZ1R0r67MNT4TUXLDXSEqQTZxjCh25lV/ERd1l/JhDpTFe+BN1uxbulZXU5/JEcO5Dr0XInRSuzj+b586p0R94wTtsJL0+gfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iKTCuXB+; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7180e07185bso392951a34.3
        for <stable@vger.kernel.org>; Thu, 07 Nov 2024 04:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730981020; x=1731585820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+NR8Ybu826lRz0YdDfbD41eoh3Xb5mDE+JZUUs10lA=;
        b=iKTCuXB+7DWK8+YfQxs05mXWDXEZ5oRCl8HRIUPJEbP60JVDSrEoL9OSJxOvzafv7z
         B4AZTWj5Z0ZvzIOB1qWTrjiwJokyfOvcwMhuYNEh2FQ3urEbKiqFcaNUuenipEfO9HEU
         +CvMUHNPx9fKpCgzxEKmPyaGeDx+R0m/NFPHzX+K+K/eyZuwSaTkUzhdRwpnRUtpmwZp
         sDiVxybuesTeaRw7rOAdeDRXOcETNjV/cyJa5ny+DqgX+qTUtHANuM4C7sYlAAkhx7dA
         0ct6xyHvfwf8+l9FDFfRONw97lDh+Wv8CVJATHLIi9dR1zlB/dUMGG30b2yOrs1fak2z
         uQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730981020; x=1731585820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+NR8Ybu826lRz0YdDfbD41eoh3Xb5mDE+JZUUs10lA=;
        b=M7rggG+GOYLnROtUCPvRDU36bZna3SjK6e80FhTjcozODAnXnMgKmj5KWuHEAFtAUF
         9gW/ecAcuOfokhybIormEyPrDcGwcalJnCLGbwP82OLT4Ao+C5MIUVn12GEjGicxT/k2
         fru84v9VqU2b8vv076bPnthpTly3jTqsVMcl8dZ4BSEs4h6sBySQjHrEwpdXA30Kvm2p
         ldrYIodHd4cXrFRRZ4fpqdhEA/Y5HEw01LHT5Ffx7wgvW8+Ux9SMGYlOHU5lMzbiEJLn
         xbflb2lbMKZQ/vsG+0EKNUdTx4TE4hyI4Ec6GhGyEsQs3EoW2Q/3pOBwD5ZBKeUr1+AO
         Fk+Q==
X-Gm-Message-State: AOJu0Yxf6+We4Ffi3ijhyYjHG4yopI6xYvcj5bYKLEDr/VWlA40txcGF
	0nM+IWgzfvPbNsRmpmUrxJllrCYbJDVK636xAOxcaoOuAFSK5Ej4y0Bz8n2gbuQdVJu39oZtyu4
	YXDRzkCseBvt0t+OCqNNp1fsYLsI7Tu21jW5gQg==
X-Google-Smtp-Source: AGHT+IEKoyvJ/cov0WtFF6wWofUTQy58nUtFI4fWiBL3gWCsT5hXlIPqU6bdph9K0DRsV5d5pc4VjFe8An7V8XID1eI=
X-Received: by 2002:a05:6358:d59b:b0:1c6:1d18:7cd8 with SMTP id
 e5c5f4694b2df-1c61d187d50mr876504555d.1.1730981020545; Thu, 07 Nov 2024
 04:03:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106120259.955073160@linuxfoundation.org>
In-Reply-To: <20241106120259.955073160@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 7 Nov 2024 12:03:29 +0000
Message-ID: <CA+G9fYtgOA-5y73G1YEixQ+OjmG=awBQjdKjK+b0qLNYvAAVpQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/73] 5.15.171-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, 
	broonie@kernel.org, kobak@nvidia.com, Arnd Bergmann <arnd@arndb.de>, mochs@nvidia.com, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Nov 2024 at 13:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.171 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.171-rc1.gz
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

NOTE:
----
The following build warnings have been noticed on x86_64 with
various build configs.

drivers/acpi/prmt.c:144:29: warning: passing 1-byte aligned argument
to 4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an
unaligned pointer access [-Walign-mismatch]
  144 |                         (void *)efi_pa_va_lookup(&th->guid,
handler_info->handler_address);
      |                                                  ^
drivers/acpi/prmt.c:147:21: warning: passing 1-byte aligned argument
to 4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an
unaligned pointer access [-Walign-mismatch]
  147 |                         efi_pa_va_lookup(&th->guid,
handler_info->static_data_buffer_address);
      |                                          ^
drivers/acpi/prmt.c:150:21: warning: passing 1-byte aligned argument
to 4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an
unaligned pointer access [-Walign-mismatch]
  150 |                         efi_pa_va_lookup(&th->guid,
handler_info->acpi_param_buffer_address);
      |                                          ^
3 warnings generated.

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTjBf6W7vsijHrkw=
8ZdOnL9Iby/

## Build
* kernel: 5.15.171-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 7a95f8fff07f7c8bab8da252016221fad81e010c
* git describe: v5.15.168-239-g7a95f8fff07f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.168-239-g7a95f8fff07f

## Test Regressions (compared to v5.15.168-164-gcebe213d2a87)

## Metric Regressions (compared to v5.15.168-164-gcebe213d2a87)

## Test Fixes (compared to v5.15.168-164-gcebe213d2a87)

## Metric Fixes (compared to v5.15.168-164-gcebe213d2a87)

## Test result summary
total: 60712, pass: 45080, fail: 1728, skip: 13822, xfail: 82

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 29 total, 29 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 25 total, 25 passed, 0 failed

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

