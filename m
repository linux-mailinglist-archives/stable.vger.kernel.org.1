Return-Path: <stable+bounces-46049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EA78CE3F6
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 12:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABCD8B20E27
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 10:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A9984FBE;
	Fri, 24 May 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8tifu8V"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F684FAF
	for <stable@vger.kernel.org>; Fri, 24 May 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716544819; cv=none; b=pAGy3bp4XxyeCNIh7mDPJsqw++6ubTssJE8+2UEm2BV6vutHhsVkWG3NiPdrsokJJIv2WWNLzO3qo6+T4wzbGmtfWW75vQ6RDWDnnw8SOMEHPVRY/RfZxXopyy8L/+21xAoGmX61D+lZkTvkv7H1sMPs74MbcCHRQH1iNGHWoDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716544819; c=relaxed/simple;
	bh=hpFk4i8PrS/oMwXaQpRjkhgzk3MJuGUia63i9iOJwsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4i9EvLmhGa7t6ePS9QC2n9w+nBKMxmKpjKceIo/pFriA4z8dYAqUxdeDfNhX8HzR2U/nK5XrBP+jKXig6i/vgJzY62GWBz8FYWHiFFnpLw6D7I8ZzOfP449Cv5hyxyerKAmBJdiv5CUH0DrQW8Kyzh1PpG0SAhdZhGSplaEilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z8tifu8V; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-627f46fbe14so25212027b3.2
        for <stable@vger.kernel.org>; Fri, 24 May 2024 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716544816; x=1717149616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRcxWj+6/ERB3xCr/ehuFxoGCWgvX4y5qnf6mjSxHVE=;
        b=Z8tifu8Vh/VgUqFc2Hs8gz5NZJIp5EKQRqry3oeZ9fHTrcyXFUjYRXT656cLCljUAu
         JYseh6fUOeB2p8Txe2Yt2xwg1FMT+uWQGcdx7svks75SyRzp7k2KujRUqcsxN7kGzKXj
         LZJvn9h0EhijWk9XXjd1BH24+nE5eseHvY7oQBE1vgOX+iUrhi5PNvIbn1J46eDUdYBo
         dbIUiphQqUx+aIFG8MOMAds2vBNepBRAOoVtZXTUJDFlwIu8jDlLe6kL1l4noXjVz4Ug
         25wnorIXvMrBmpPRRH6sMLzOBFrrrqfw6ckLStqg6af4lQQDdyIvbtOq+MgerKu94uFe
         pj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716544816; x=1717149616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRcxWj+6/ERB3xCr/ehuFxoGCWgvX4y5qnf6mjSxHVE=;
        b=ptQs5i93mVcb8qLzSgxLr0EB9yPMGR7NZJwL2JSOhicoesv2OLIjgXIm7iuPeduwAl
         XewIgZXHkSB9zjkNPLJpk5jTFYDiPqujOn+UkJjxUQ6bAdJWE+e4ALtx6vvSkKXuAKef
         Uqzg6lZMrEA7Ybj2LSnuXIlu1Ldo0u1a8LfjyRDzYgoLQIcu3vwW3Dtap1kKbrXXO6lz
         cDjLUyJAuEgfIaRt32OoWonBJoxlMHavrSVfOu9vXYWgywd3fNH8SMw470GojCuePGEb
         e2Bv+1SliVD795tLI8RpGp0yb4y8z5DZU/ghCiz/pSgpmUwOMhHwJwG8Fl1i8bBtP4Kw
         PEyg==
X-Gm-Message-State: AOJu0YxZqqEdWTuAO2UslOnN1QzkCwwATGGJ16zIC1hekZ+9Z0hu0L7+
	PdvHTNVB9QcrIXwM2FdmSR0dpsyYgFvAL4pEh0zO66KX8FqhI/mUSE5T7GXc74D1CgZNLLhDskd
	lP3FwEYozbTf6uS070dSa7ZDS5QNb29zLnxEdkA==
X-Google-Smtp-Source: AGHT+IFtBXY/ppt8d5YadN9gk4J4si+b0ZW1MOxWyhajukvI0/vvjnxm0TIeFxPO6YclPlY0XTEdYPFBCUF7/UMrYeo=
X-Received: by 2002:a0d:ea47:0:b0:61b:349c:817 with SMTP id
 00721157ae682-62a08d933a1mr16976087b3.12.1716544815763; Fri, 24 May 2024
 03:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130342.462912131@linuxfoundation.org>
In-Reply-To: <20240523130342.462912131@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 24 May 2024 12:00:04 +0200
Message-ID: <CADYN=9JeKd=5f4Vud2ahbe98PaFBdCqjzq++CzFpit255+myKg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/102] 6.6.32-rc1 review
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

On Thu, 23 May 2024 at 15:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.32 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.32-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 128 total, 128 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

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
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
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
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
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
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
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

