Return-Path: <stable+bounces-107815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0D4A03AD7
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 10:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B8D3A27B0
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 09:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C97B1E0B75;
	Tue,  7 Jan 2025 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9b0pNXP"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD9619ABCE
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736241156; cv=none; b=BIGgNnX6C2kiGQRTQW+bSYz+zVblwntGUixAjHVh1L5B0KvNDj7w0NAZYob9CrcHsJH4tdTAXTUfnTva9MtnAnkn5hQ+Dm0d/mjDIyr85QeMGo1Qgw6erT/l+hdkwxnZpz/otYwMZXeX52Kn5o5wvrtAuUxZUjphy4d6LCcWSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736241156; c=relaxed/simple;
	bh=vwQHPAVlH6Xu6LDj6vxTZlZLu/ue9jZ/NDNsMErjYGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sypDPh52FN7KuTMZ8b8ykDyI3wZHSDxEMuE9SJ7XbphsUAG+/F6txi2AUMuZM11Un+YdT5goSLoEHuLiabQ5T600gvBpjAJPRNhIHk5VtCXIc+OYkpM24ufG0QgsivpH44aMa5KlT5RDvCpssYQm4UgCFuLBmPoznWB2cl1lbqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z9b0pNXP; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4b10dd44c8bso4290094137.3
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 01:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736241151; x=1736845951; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3f+8PMqm/72Skv3PIVV9dMBmUXrF4Uosjp+ptj5ZKv4=;
        b=Z9b0pNXPFutd8woy+g3/+qBHZcCUotmmRkez7ovRCVIqxfyNq5OvxXEezOGqGGUaWz
         xELQi9jZT9jLwCC72wGEtYyb/LDFM3bd8AX/PGhDpt7GrxmILN8tpv9bCbplYNvS7QGz
         +gteJR2Ip7d7yxJonhUqseG+Hn4hYJsOzaktwFTKX9AHqHLfsdj3sxdF5tGyRk0fClub
         XXFmIJMuQxwmHz7F1NmAFmYEDvtl6OYgZ91Q+6lMnx1FF1mN5kSdZDGjgzrWEs8guvY/
         1Hrj7qtWtDf5SKWUeFfRgQdIc8Rz46r0rk8oxpbzkhX+/ZtTjIwdiNB/uc4f8Iw/Xlt1
         6YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736241151; x=1736845951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3f+8PMqm/72Skv3PIVV9dMBmUXrF4Uosjp+ptj5ZKv4=;
        b=ZZMK3xUcXn5XOhLtxj54zV+Ev5ne28Hf75CLSdBHIm0CEMZCUz33ZYt5k2f8DbyB3N
         MQdII91bn8hpVAnv3MPI8fH7mlGabNUFx5RzlOmgTRlcYzKatMWHDAQkLXkgsNp64rXM
         cUDcIBItS05O9zVQ1knPoh2uCOsUo8jH86PLtJa72hU2ccfvTbmDyg9IXVFcbV4GxvMf
         OZECPLYQoZWJND47sBi/TXfpOYyYEWb7lelIxIPocLQP9KftdmpxsUJd424KwZHsnjlS
         1x9mzVSVq7ZKhNQv2XCIkPs8GdmJclixbcxLd/EgGMhjp1kkX4el08cL1SkLirEPoIXH
         53LA==
X-Gm-Message-State: AOJu0Yzks3FAD5OGvNlwQL9yGgSvBUtaNPWXNKSQ2uDq+FD6jPNRjvmY
	irK3aeqrh85cFc86elUr9vMacoxVHjdU96m9RcbwEg+do81VML+psJiIH5ug07S2S/3ai2OQ5YJ
	zToeWj6fwJ7EQSvhg/lIuYeeszI9jxrJpSckz/Q==
X-Gm-Gg: ASbGncv5Uw/DTnf/CG01sBaqp+AjW5O2sCMC2Ci69wLjNuKnTEt0zMDY8/DgbkeELlo
	9GPxa00IPzOAjf4Yc3dZjzYvWCb4S6VJ24ea3vbE=
X-Google-Smtp-Source: AGHT+IG8Wpe+tisCowZGZ9+zs1OBt+0BCWDNLnE9ZufiIjtj0ni7ANsziVCCe/cOHOkIXKi0UnTDLhOUSt8JX61oC18=
X-Received: by 2002:a05:6102:548f:b0:4af:f740:c1b4 with SMTP id
 ada2fe7eead31-4b2cc319f2fmr45981439137.5.1736241151496; Tue, 07 Jan 2025
 01:12:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106151133.209718681@linuxfoundation.org>
In-Reply-To: <20250106151133.209718681@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 7 Jan 2025 14:42:20 +0530
X-Gm-Features: AbW1kvYhV5tIM55ZWEG-0B-pDUWOJ_TMc4UkSUHFDq_r4c5Gv7TWZ5IMJcCykAY
Message-ID: <CA+G9fYss0LJRq6rzg0g_oG2+c_TZ=i3uNnq7DuWWfm4c5YkOpQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/138] 5.10.233-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jan 2025 at 21:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.233 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.233-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following build warnings are noticed on arm64 and arm
while building with defconfig using gcc-12 and clang-19.

Build log:
==========
drivers/gpu/drm/drm_modes.c:772:6: warning: comparison of distinct
pointer types ('typeof (mode->clock) *' (aka 'const int *') and
'typeof (num) *' (aka 'unsigned int *'))
[-Wcompare-distinct-pointer-types]
  772 |         if (check_mul_overflow(mode->clock, num, &num))
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/overflow.h:88:15: note: expanded from macro 'check_mul_overflow'
   88 |         (void) (&__a == &__b);                  \
      |                 ~~~~ ^  ~~~~
drivers/gpu/drm/drm_modes.c:772:6: warning: comparison of distinct
pointer types ('typeof (mode->clock) *' (aka 'const int *') and
'typeof (&num)' (aka 'unsigned int *'))
[-Wcompare-distinct-pointer-types]
  772 |         if (check_mul_overflow(mode->clock, num, &num))
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2rGK6opE7YJuvUHMLAXMTkCvBsd/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2rGK5umd3ST7IpCpaejp3VuJJxT/

## Build
* kernel: 5.10.233-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: e0db650ec963f170146da2f830585256577a4ae9
* git describe: v5.10.232-139-ge0db650ec963
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.232-139-ge0db650ec963

## Test Regressions (compared to v5.10.231-44-g238644b47ee3)

## Metric Regressions (compared to v5.10.231-44-g238644b47ee3)

## Test Fixes (compared to v5.10.231-44-g238644b47ee3)

## Metric Fixes (compared to v5.10.231-44-g238644b47ee3)

## Test result summary
total: 40675, pass: 27523, fail: 3504, skip: 9568, xfail: 80

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 104 total, 104 passed, 0 failed
* arm64: 31 total, 31 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 25 total, 22 passed, 3 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 24 total, 23 passed, 1 failed
* riscv: 12 total, 12 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 11 total, 10 passed, 1 failed
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

