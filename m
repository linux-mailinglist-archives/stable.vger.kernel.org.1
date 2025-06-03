Return-Path: <stable+bounces-150699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1829FACC582
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41602188235E
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2597F2248A0;
	Tue,  3 Jun 2025 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnia4+Rw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3785015573F
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950340; cv=none; b=XhtU3+mWUwJaOc3rRlpD172g9uOICAamotSk/OsSSY8S/fKlNW1/r5zhAMKFPDbFeaD407iaCSKuB1yMlgj2yz7LnQqfTch8CdnSIE2AVXa9hL2L7tFrOu8jNjlY74h7w+VcOFdZ07ei2zp8mgBNqsvV9grmdrAP2g834gNXgpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950340; c=relaxed/simple;
	bh=C9gRWlLfBi0YKgBn0SoTcZxQPj4DkPXCPkpzlSXSJqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3SPLBtthf15vy/u2FnLpYdghucqSyehsnqFLT8mowCVHS4ObjG5s8FVa4bjmVh0pQhVwh5+n4phhgHHQ8Gtw96K8fqfcZn8HSXTQtymsrQSSMGpoDiGBvHSpJLh/rN53YTqt/VYgqI/dZLdbgwCw0fTEs26CvcxatScrzjbAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rnia4+Rw; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5a88b34a6so491816485a.3
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748950338; x=1749555138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Atrc7hSG4Wq+YEOtslDiDaD9TR06OeEIkbilhWvmPY=;
        b=rnia4+RwMIZNqLgs2DfZpr5Q6LuUBdGLWAE+f/viVpLHq8q0uvzU7veadLc+SUkI50
         NhjnmtIacvFVbEj4qT8AUxb6bWF/NckNDWkuqQcYRkKaS3hrLv4q3mbdy0kBwIZNqm8p
         lx5RqnkB8/2VMdO6OeU+zoSzM2EdYosyMwLbqLJ/SelBmkbeVUoiLl9NT4cIEx5aRulV
         XqhAtaBli2e4/0nsq6qNULXDkXKSZBIhn8DdXE444i5YSDeFVmaijbMVjwoVxo9qK+p8
         hZLNK0bOk6gsub4vkxT2vWzFtc2Nc2+QRdy8aHI0pnIqrB3Md/+GVRjdrLCUfTag9wax
         ntIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748950338; x=1749555138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Atrc7hSG4Wq+YEOtslDiDaD9TR06OeEIkbilhWvmPY=;
        b=A/C1VZWHRNEBPlUDza8SY7ZtB3MqTbTakBW9yZ9IKB/Xx70q3Rv06e3nSZ5ax+xeSs
         0q/GtMhFUvGer0flPCGJHKBOFbx92NTwzowuaHwNIKDha7G65+77JOryufa0/OApcQSY
         aJrroXmyPKzBucvidclD8GH/VwfUWyk5D44rLHfc1haXJMFeSUyWoh/MX9RNNYmCw6ba
         /8llZlOhty4Fq3HcujEpstchJBO61I3JkRNg8u/7F7jLjrXZbIXh4dEK203iKIEYKq1l
         ypH1zsDaB0mOhe5H2pkaV/1uPzUaldLBrlt+/tHg6kZZOD14PWK4lanEKE+wczAGX7wq
         9dJg==
X-Gm-Message-State: AOJu0YwOW7LthkEYI+R94/0Av38auBZMTi7fbbqnhmGkKpbStYIVPDru
	0uegUavNOMbXanrgZocvOJMrtImFy+IdDCFGR3+cYf6qoGUI9XCJFxTcjBmY3ixOx7bx/ga6b3n
	Tykprbw58vao6kvTovXq0Ryo2jgUfI/jnM+YclwGcPA==
X-Gm-Gg: ASbGncvEARYQyvOC7jjQQ3xiLYK1zjcVMX/JWx5AFWbLafOuHiCvc+lXfeJj6TpNQqZ
	Wjmn6BU8+5pnFO/rxFccBbT3C5h4RS5p6I6uegAowE1K0zNfHBi2X2yBJzhLrh+HHD2vSp84cwo
	l5GgX0t/cQy4o5QkBS/CKJ8Rq3Mvhr5K0=
X-Google-Smtp-Source: AGHT+IH6CJu60GvORvqxJTYPklRaw8iQFScWg5PgSdR9bv70h3hv92ChYzgfJyf3St4K9Fc9ny/UTGzMOdn4NZ36zbM=
X-Received: by 2002:a05:620a:4406:b0:7c5:4adb:7819 with SMTP id
 af79cd13be357-7d0a4af0149mr2061854185a.16.1748950337974; Tue, 03 Jun 2025
 04:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602134238.271281478@linuxfoundation.org>
In-Reply-To: <20250602134238.271281478@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 3 Jun 2025 17:02:05 +0530
X-Gm-Features: AX0GCFt8z_HGqiWFmGilVaVi001nq_yq_XNavx9fqIS6CTpy8M6ngbWXGV8DcCY
Message-ID: <CA+G9fYufqNSo+bhq_JQgEPNo0pKFPhuWQQbmGd8_HOE9LX1-7Q@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/55] 6.12.32-rc1 review
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

On Mon, 2 Jun 2025 at 19:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.32 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.32-rc1.gz
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
* kernel: 6.12.32-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ce2ebbe0294cb1fbd36bf75316d94f81f26e582b
* git describe: v6.12.31-56-gce2ebbe0294c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.31-56-gce2ebbe0294c

## Test Regressions (compared to v6.12.30-627-g3fc6e1848884)

## Metric Regressions (compared to v6.12.30-627-g3fc6e1848884)

## Test Fixes (compared to v6.12.30-627-g3fc6e1848884)

## Metric Fixes (compared to v6.12.30-627-g3fc6e1848884)

## Test result summary
total: 309879, pass: 285936, fail: 4866, skip: 18494, xfail: 583

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 23 passed, 2 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

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
* kselftest-fpu
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mm
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
* lava
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
* modules
* perf
* rcutorture
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

