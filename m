Return-Path: <stable+bounces-87628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 069889A8AD7
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 21:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885EA1F2226E
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 19:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7588A1FB3F4;
	Mon, 21 Oct 2024 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erQlEZ4F"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46941D0E2F
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538738; cv=none; b=LvnrQXmeN1pNKO0tx9+lDOu6Gf6NHgaqsjmCLXWbdGKroTVLBmgVPB3QqCA+x8fn2BiY3WvCrNBF5bKNBVyYtwAi2GhM4+3eyt+c6c3TfAsuosaAm9GjyRsTSSvV9ebdOGiRVTzIXZXIOdOlNvSm7PxOpDg5YcwB/5venX7byc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538738; c=relaxed/simple;
	bh=39yXzsbEVAnhGU9F9Q4jIZeDJdzY9UAjmvAgreporMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDxlS0nKly7SnXR2ciIXFgKMA75fEaxXgFl/B51nurZZmjt+axtm0ru3+Q0WJHZlpJEWwswqszFJnOc1mXZxRkThwtto4sQLHPiqkCWFJ6dzHk5JFVZChjyqfs10ANt5p3Qekj3mgY2DIYtDK5+k0L/flZzHwX+6aZQKOLZcnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=erQlEZ4F; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4a47cdaf158so1418718137.0
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 12:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729538735; x=1730143535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddjIRK0h2N+TtLtOm19QTadObnytcTIMmkiX9ZGErp4=;
        b=erQlEZ4FM9o+/f8aqVeBi1U6hjv7uO000SJ4IWZYOrfkz0wq8V17IckWxolrAnAamM
         LRjgmxhbYLkFU7KdnrvdcuXVqJE3y25VcCMA0NfOdNBEhu61fiHyT0X5osRcc6w36nXX
         st62NI4sldFLFp2wcul9xx7vglMTqo7fShPXmULS1WTIhya2O/SUq4p0rvQbq0vdC/jr
         ARgRZiwuV/F9ZIH2rl7v8V0Ii1Gh+2Z4Jrr5d8G4sOKk3Pli1AqV9nXNaJEXN3VRXj5j
         9ViJQrWK4vKitu6KmAc+OJZ1R6y7GA5LvRVe849pyxcauiX8eWuvk6EvwpzIprnKVuXt
         hDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729538735; x=1730143535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddjIRK0h2N+TtLtOm19QTadObnytcTIMmkiX9ZGErp4=;
        b=fNnrG9+YuNmwXU4mGT1IqHSjiiNuQWILtATzGfKO94p1WxzTErUqP24irB/2XfbLyE
         20VgUOjid+xA35vsvtghLYNONLRUDvnsqRciKduyGJwmUO1xlwXWREt6oRlz3+sBwo0t
         EPsvA3XB0fOLQIGtESRaIxAJ+eDziP3CK3Iv1SKtX99cUVClCB6KJ4yOj/FngpYskAcK
         E1KKvTNd/zvanIXbN/pYfyJo3L3I29z66zfeJroJdwyXgr2ohiOOBKyNf2lmiLFpzzdk
         XWTIwwwrVZtBERHoreOn6MFsedZlfZmq2VU0AUBtu5aklhgIgCXc/bYDfCW0yjpNoDix
         0beQ==
X-Gm-Message-State: AOJu0YxkIeVSE+P9aiJyDmu/EkOEvNVn+Y580QtTGhvR5S9szYXBsyrW
	iTh8s217d94J2Ljpaak9cU17+i6WbL2KjIwhTujrc4/Gtqbv2/CW3hjuTm+GDqDR1J8nuEKYTHV
	npQ3z9szkfA5QXHtDDnbWuBz064aLYKHKQOk9+g==
X-Google-Smtp-Source: AGHT+IHqjjHFZnJR7XHWSlS4Z0c2Ba7H3ulN6LRShf5mzStW412b1YId+gX/N/k5EJ+koqn0VKg+qW7lpGT9P4yN0Zc=
X-Received: by 2002:a05:6102:c8c:b0:4a3:dd83:c0bc with SMTP id
 ada2fe7eead31-4a5d6ac17e3mr9459635137.15.1729538734673; Mon, 21 Oct 2024
 12:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021102247.209765070@linuxfoundation.org>
In-Reply-To: <20241021102247.209765070@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 22 Oct 2024 00:55:23 +0530
Message-ID: <CA+G9fYsmcUHgwL44T8cWdOr=qs0NyNZjP2kotKVOi=cGXt=ZQQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/82] 5.15.169-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Oct 2024 at 16:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.169 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.169-rc1.gz
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
-----
The following build warnings have been noticed on 32-bit kernel builds.
fs/udf/namei.c:747:12: warning: stack frame size (1544) exceeds limit
(1024) in 'udf_rename' [-Wframe-larger-than]
  747 | static int udf_rename(struct user_namespace *mnt_userns,
struct inode *old_dir,
      |

Build log link,
------------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2nkFEUWzJg4an4au6=
tEGcCBQ873/

## Build
* kernel: 5.15.169-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 4d74f086d8cf173c105457670e3c58190f13c06c
* git describe: v5.15.168-83-g4d74f086d8cf
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.168-83-g4d74f086d8cf

## Test Regressions (compared to v5.15.167-692-g63cec7aeaef7)

## Metric Regressions (compared to v5.15.167-692-g63cec7aeaef7)

## Test Fixes (compared to v5.15.167-692-g63cec7aeaef7)

## Metric Fixes (compared to v5.15.167-692-g63cec7aeaef7)

## Test result summary
total: 50075, pass: 36724, fail: 1689, skip: 11593, xfail: 69

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

