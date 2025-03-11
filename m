Return-Path: <stable+bounces-123202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1277A5C0B9
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 13:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C193A9CED
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 12:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA2D25A2A1;
	Tue, 11 Mar 2025 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EsZKCOQe"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25399259C89
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695551; cv=none; b=hIkiIZ+Z31vD98lJVRq9oT0iTAkOxRqIxSRfJ4C1vaA2CyILO8eUE7FImSHK1434tua6w0cVlpoD/QfaLs+F3dNFan2H4Ywv9aMoDvcyd6OsSvNUZN/4N0PinLI8cmqN3DC9i2czKFiQu5QTMRBYMvGJ9ma0klWh2RWlTQcl9Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695551; c=relaxed/simple;
	bh=1OR2ddn1OIKSZBuhlTLk9r24MJQoupMsoAjoOy/4a4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbNlJztjIDcGeMzhFM9KnYnaigV6xI3hjz8vAJSgrGOMaHRHAfnugz/ltFXKR6nYJkQBOsKqgnwQwpnyScIWfeF9d07viPSOc+HmFh9acsbfvaU+DlapE0esdxYhP5fnD/DIlGDGC+x3MjUmCoOosiVCxQHGN8lP58iX/uVKvEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EsZKCOQe; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-523ffbe0dbcso2580217e0c.0
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741695549; x=1742300349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+pu4SKQgTYhhnwI1KV/Zn+Ls8AA/0w/uChTjZPaWZ4=;
        b=EsZKCOQeFnxoVrA4NzV9M+THiWshBKqzgV+8acKQyI7VWKoL9M3MaogZHlGrl1p4Cc
         om0A7yA7RVxubkexYk0JsZz0SwByxqeRcQshXrq+hxMcVuarT+7hodqDqfS4JU5BMNt3
         0hkAI9eBdan4YVLfGnn4Cr335tWian2Hq4jPx8W19c/lqEAkTCtnhIEUHtv/SRjwIHj/
         lgSbo/Rp/t1R0SEAEzZUxURPR0/f6EOpkKvaOTJLZon1RTcLrI0savIfdSE64v4OpHPu
         iqcoYFfFOp732Z0uIotVQOCWccPXF1ZkUNMJOuVXCnMIx2CpkVMRvbrnp1j9Zt5nK2Eb
         2vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741695549; x=1742300349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+pu4SKQgTYhhnwI1KV/Zn+Ls8AA/0w/uChTjZPaWZ4=;
        b=cBKnCmz2Tcvzy880tjjWuEchOsY9FBNP5gFz7dPWWTS4Ay7UN5xAgjfNHG64cNiAyQ
         B8IYOOkz1xbdgV2NsmKPVDVoTnz/gTLqNDuaaw9rId/DXxm64ac0AhDVZaS4grHYyD/G
         oy3W2gmphbLlZLe5Lo+sNM21kMZxG0Jhsn0D+w4vt2gft1+5X+MJv6AQsuDCfwHTOkWa
         wKpMgSCZV78ogCjRT7ofYGldBz3yiQa1rsuJUfUG1IMVWxStFsaouz0rChGr5B3uJbXb
         PVVTExX02xUFytBxhfuwbnzycopZeocMPzRkD2f/On5k7ycywDK7NuOODPjHAM5frUnb
         idog==
X-Gm-Message-State: AOJu0Yy3HJ31tjdDd5+Lg80LjV8z4Fm/3d9itG7TsCiqQp3ujMg1ObW/
	dJGYxTkhsVwKh7Gr5ZEbToEZaTj/upghOIRW1ctBtcYxhY6NCnsy26xcr7LCxVTp+GJDJrvYlja
	KQ7lNDdAjNYLxIA7dxe/qfc225zjbDvAOEQBAFA==
X-Gm-Gg: ASbGncs0EIok8hyzKTopGhOdC9Gdy8+voSks2BSpJxGBtSNB6IBEiQ6ElMFozlir6gW
	J9xFgRlX7zqYsGccV4ljBX0uWvRbAZnjECtSLMTpQGw8fwrj7LVDjH0JXdV21pmbgY79jL1ChWC
	jWc9QyyHvLvZ+7SzfsEMyHaykvwQt80bPGIgWADRUIx/56pvDkoP77OWpgzRw=
X-Google-Smtp-Source: AGHT+IH45qk9E8UldXiFsm8nAVB3hcZwGPmx3+QCspv+0WyVSGg/7iMHvqU5qLYxficHb8Ss/KzF6a/WHqkSJz6+F8o=
X-Received: by 2002:a05:6122:468e:b0:520:5a87:66ff with SMTP id
 71dfb90a1353d-524195bb061mr1862180e0c.0.1741695548982; Tue, 11 Mar 2025
 05:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310170457.700086763@linuxfoundation.org>
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 11 Mar 2025 17:48:57 +0530
X-Gm-Features: AQ5f1JqTHciVwmwj3kmllmiGi1ojMeOEj69Bqu4RztEVFb6rtzOUgOeaY70MDqg
Message-ID: <CA+G9fYsKDYoKUWp2BPOLmRL-cpcao=y-vJSU479E+cn_vFAK2Q@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/269] 6.12.19-rc1 review
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

On Mon, 10 Mar 2025 at 22:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.19 release.
> There are 269 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.19-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.19-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 53db7cb59db64055714b1a7fd1cadd8d5ef6e2be
* git describe: v6.12.18-270-g53db7cb59db6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.18-270-g53db7cb59db6

## Test Regressions (compared to v6.12.15-529-g7d0ba26d4036)

## Metric Regressions (compared to v6.12.15-529-g7d0ba26d4036)

## Test Fixes (compared to v6.12.15-529-g7d0ba26d4036)

## Metric Fixes (compared to v6.12.15-529-g7d0ba26d4036)

## Test result summary
total: 77388, pass: 61961, fail: 2961, skip: 12426, xfail: 40

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 54 passed, 4 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 43 passed, 1 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 22 passed, 4 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 49 passed, 1 failed

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
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
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
* ltp-crypto
* ltp-cve
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

