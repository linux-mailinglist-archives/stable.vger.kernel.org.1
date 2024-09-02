Return-Path: <stable+bounces-72716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD12968696
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 13:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CF61C2228D
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9672B1D6C62;
	Mon,  2 Sep 2024 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9FmFyRS"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D381D6C4F
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277769; cv=none; b=PjmAqKig4Ww5VgXqHFmkGce5geGemjqzvtV1ohjUpuQhtZ5OZ3be8wySdHopEqqL8XrxtRNKrshVT06c9k/ousQe+nuLXDryezfeVFxHQCX/qN2QfJLeH9GD9ND+LpmAk3HCF1GF+SdLN5UyuWnokGUXDYcZxL772XVy4GCyyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277769; c=relaxed/simple;
	bh=TbsLhDhTwEQZqG/BspoBxQwZG8kUpSJ8LMtZATpnDRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUyQQvGRcGgq2qBg0ZWY3v5IyslT/iqSknAmPEMQRFPx4H/qiLc5v3Gnz5P40qREXLGmY8wnBtuEjPucqHNQ7hk8Wpjmu1S617pEEXw7Pv97u6S2ydKNsnOivUs2An2uRWxzGiE4vw8aGxIyy6JKc0rZLwjq/fwYqjRXWmrROio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9FmFyRS; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-498cfbc0b05so1545328137.1
        for <stable@vger.kernel.org>; Mon, 02 Sep 2024 04:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725277766; x=1725882566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTifHbeYcxDQuXfliKouQ/B6JHrDG8JJUyn5xqITlps=;
        b=C9FmFyRSL5gYFvVVFkYHnuzhpYU4W7dfEwKqbaPwmzoQvjdm98+FtQ3m9i+Ag/LENe
         +ycLDpSfalL18NoWekmZvnKSL/7TJqsLkBaBTDxeUETFfWFuYXhItWhKS1RTTj1zMxeB
         hSjG6Sv3t5qhY+335mCee/GcaUXtGMII+qbcXvo/lQ9cEYUk4mA/wC4l7YgjIL0NYnfq
         zbwohrZ6NunP7x6QpgcBDPBgWmf/kUOB8oVp2C7rmYtnSu1DO2NUl7ZRK19TP7AUYYv0
         7UR6HNLlNFwAAhqb8mUCxN8Co8NZR/5ALvHsDG3DVA1BYAM3k75dvckcN0RuEZtvw5pm
         QSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725277767; x=1725882567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTifHbeYcxDQuXfliKouQ/B6JHrDG8JJUyn5xqITlps=;
        b=vONobSczSZTpUVXNVcEHZ/1/ad7oVlatNlRdCc17OUuuGr/4ciq59u7lAsvU7c4s36
         rRFA3Ztu0ZBG8Px8MxfsEjGF8FciTkndvVrixgD688GqlT8hFHlehej4gS/D7BPpbxEY
         AXAb9qf9bVvAu0v6DgwLYec7zJggxHPoxybifCtnLz+oUOInf9Cji8SmTCb64ZHliOQ8
         LvYivRjQaPeNFn3hC9JmxdVZz5qDofRu+0Gy0wjP/JqPwBk/KswIr+sJ+QTcZfPtxsOF
         Qh08O1hCqOF9K5+xWr3lxvkGbHPhe1fMrhMrG/SSMvu6KcmfmKZgJvLKwBO0ymi1oSUC
         KfgA==
X-Gm-Message-State: AOJu0YxU2A6WqS0apDU0I4Se6wWyfa+JX3qln/cr3vmTXpKwIXwkWMqr
	VieCyppWW/V/t8sinws7Pzd4VCPRMR4T3aisNVkIZc70D4uGyp2AkeGdW0p+mzOCsWKz/jfRZd0
	cGZ+B59qsYvSiy4fVSBn2SZlNABpbQVWXqPxL/w==
X-Google-Smtp-Source: AGHT+IEqJTMFzAtvhaYcjWv0okauFOgdky9k0/FOXTxZktuO6h2MRkyM3tNfux7MBolYe2+OpW4jCLLHXdWXrfZzrWA=
X-Received: by 2002:a05:6102:3a0d:b0:493:de37:b3ef with SMTP id
 ada2fe7eead31-49a5ae733bbmr19067756137.13.1725277766603; Mon, 02 Sep 2024
 04:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901160817.461957599@linuxfoundation.org>
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 2 Sep 2024 17:19:14 +0530
Message-ID: <CA+G9fYvYmpUeain222FMmDCQ=N5qMrBoza=fO-jhNP5romhM3w@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/149] 6.10.8-rc1 review
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

On Sun, 1 Sept 2024 at 22:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.8 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.10.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.10.8-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 88062a11f41d8d4c9f723337833e4e9ea9324d5a
* git describe: v6.10.7-150-g88062a11f41d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10=
.7-150-g88062a11f41d

## Test Regressions (compared to v6.10.6-274-gaa78b3c4e7ee)

## Metric Regressions (compared to v6.10.6-274-gaa78b3c4e7ee)

## Test Fixes (compared to v6.10.6-274-gaa78b3c4e7ee)

## Metric Fixes (compared to v6.10.6-274-gaa78b3c4e7ee)

## Test result summary
total: 199765, pass: 176468, fail: 1757, skip: 21311, xfail: 229

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 127 passed, 2 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 6 passed, 1 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* kss/1_kselftest-capabilities
* kunit
* kvm-unit-tests
* libgpiod
* libhu
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

