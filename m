Return-Path: <stable+bounces-119626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41F4A4574C
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 08:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C829F3ABEAF
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 07:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88549271289;
	Wed, 26 Feb 2025 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4RCE+eG"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9908D270EDC
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556288; cv=none; b=APW/w98NElFtNgtuwq9/i/wYDfvX45c1NZmS0MNnoZyY9OYaykyIsnatnYW7R+imZ6hdbF5IXiyj4bnCet13MZHGGWsCsaKEZntI9zGHluOWK0dHpMVzQLjz17zWNme096C66fCRSAgevwkYsPZp+c+Du3H75bJ8sNltyPnySv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556288; c=relaxed/simple;
	bh=cTvB2TQyMmoo7IX4X/o4AVO8Uwnf9L51w9URhRJnWf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCHlAlYj8Cwj7w/mkEHj/Y/ioFjQKMMfvIINboIvw5zQCxjHsI9DonXc66sljYjOV66Hg4uc1jz1cVl3u0pH+rCB6r/hq6IcE1yr/rGW6Sj53oNQ5UgBDBYPYJlMUSYrfz8PAiYN0d67vc36LR+vPWRKVt8hcRljcwC2f3Z9TNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G4RCE+eG; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4be6599024cso4230619137.3
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 23:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740556285; x=1741161085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLNwWOg4S2F2XLqkfuFJOf77RDzn7cf3N5W3Gy5iD6A=;
        b=G4RCE+eGkXVMixjgpoUZcGzUikvtZFomnC6plsJ1tLmR2dAlCsmh2ysJOJkoEOokKN
         i2bC1bjoB9taNZV7tzVm/GtIJC78VJculj3DhVwpWLns27y5BgBdD4EdfWgBWS/wvkUO
         qFrCVpK3ZmiFGnP5ri5F20uYEWft3PPHpDtCh6fAFdsV7hqrW+rcun5B/AqE8UZW4Or+
         bC5YJaaOBCz+Q10en7hjQ/R6AXxwHk30nzQK6ybjwPcqcNdGltGd02xB/ljJeY61hDjn
         4JGor3hp0WIVZg7SjlqiY6+y4QEK1NqPvVe9qpft68YXQaohwV67ElVjFOIIvl3b+nSV
         GVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740556285; x=1741161085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLNwWOg4S2F2XLqkfuFJOf77RDzn7cf3N5W3Gy5iD6A=;
        b=OgHVm0qmH65DkO3td9jkc+rrGUrAAoMkM6DOPe5YG/o0Su58EDp/4C7YXvwgSuaolZ
         B+ewlsVx2Wd465wGk2zQBuxhagZjcO7MBh8HzJ1SefKMvTWqgtO7l1C6amglUdDx3wIa
         S+Z9HlWYl7Fpst5kkPL4MVezkKvvz5arfoVx0iRn1Q93xi892nDkq3E2mQQV86wtKktK
         SQZaQsvgeTAuei5MEVch0bvjlh3BV5xtxQAaJgLcmarj68Ig7k0q8JSR6HVS+KXvcD3b
         dB71BGO5711gQyjNpXhVlfQmDdvcPpMtw/DvYPL7LDAxyGmeSPLB+g4BwtJxgLF6oeSH
         7Xfg==
X-Gm-Message-State: AOJu0Yw+4qOiK7fC9ZtSm8wjwnEucgpi52UhPfWOZdajO4Y6gV+qaxQK
	yYTk+EATVgnmYs+UP+sHAgelXCsy9o4Zir60ACgZB4TB8CCLmw2h8JG0rTEKbOPv0IUGxs6bWa2
	wX9+rTj2IbUq77E6HLl0Dz3i9QT91aRxhOXX4KA==
X-Gm-Gg: ASbGnct/D/PywId2inNZ2rz+tWgb/o3xXejgt4h+6a9OxQFGXKixuzkysIvxV2rGHWb
	8ACJUS9n0bJvK6XmgECVPfwW4+gjcnOMoVDWiRd0zc2/YaFa9sxcfCPI1NY9XusgIOZc7Y5LbGt
	dD9uHd4qcl8ZMQOXwOBjn/Ty8zrhegfE2W5RTF2A+l
X-Google-Smtp-Source: AGHT+IEUPEXM1aFeKdWgzqQkyRkjimPDoS+HtxKMtCZLUDKFm9cz4hTaQl8z5TOgKK+1ZhX21aRlRC/OXSiAglQ1/Mo=
X-Received: by 2002:a05:6102:a51:b0:4b2:5ca3:f82a with SMTP id
 ada2fe7eead31-4c01e1adb9fmr1362265137.7.1740556285291; Tue, 25 Feb 2025
 23:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224142602.998423469@linuxfoundation.org>
In-Reply-To: <20250224142602.998423469@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 26 Feb 2025 13:21:14 +0530
X-Gm-Features: AQ5f1Jpl_a9-toTC9pWH12H5cMWMUd9tdGXenz-9TdtTJyLMJ9NvQJ3aPee2ZQM
Message-ID: <CA+G9fYuwFrrUUggcKPjuTWwON=-JSv8itmsngSdHZARgoCYfyA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/140] 6.6.80-rc1 review
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

On Mon, 24 Feb 2025 at 20:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.80 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 26 Feb 2025 14:25:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.80-rc1.gz
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
* kernel: 6.6.80-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 6bde7e001d6392e3eb4bac681e702af17984e6bd
* git describe: v6.6.78-294-g6bde7e001d63
* test details:
https://staging.qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/buil=
d/v6.6.78-294-g6bde7e001d63/

## Test Regressions (compared to 6.6.78-rc1)

## Metric Regressions (compared to 6.6.78-rc1)

## Test Fixes (compared to 6.6.78-rc1)

## Metric Fixes (compared to 6.6.78-rc1)

## Test result summary
total: 123184, pass: 100614, fail: 3747, skip: 18823, xfail: 259

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 39 total, 39 passed, 0 failed
* i386: 26 total, 22 passed, 4 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 12 passed, 1 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

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

