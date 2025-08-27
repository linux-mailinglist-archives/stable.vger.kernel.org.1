Return-Path: <stable+bounces-176475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1177DB37EA3
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCE6687ABF
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF51341AA6;
	Wed, 27 Aug 2025 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVuqSURM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CAE28E5F3
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286366; cv=none; b=ubHTi/zCH/3Raj1HZv84A8jh1wfKoUE7xENnF8BNGSE8zd2ezpUqkrXNP7gnSCCq1QaoIZaaI2TpPbNCgWBONNLMVzlua+p+e1DXUsWFQ96u6QVQxsHZ3P739lOrRrzzzdNXsE5nJpp0LrHEUvuORsUJ9JzQwfRyfbdvidY0hQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286366; c=relaxed/simple;
	bh=ST7Wxgfln22XFCCAyDOOJmi3XyDqdq9JV2DBdDFoT5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3s/eKNSktbqYlhVuruyPuG5foZO/jDNfrLWx4zxs5xvcbK9oBlhcE9pnFzi8zdH5BfcV+FCav90BpO2oBSEgtqj+G2uPI+UebjOFZBp4RpSed6gERcE32Lmd6YOeE0P0TvXztqaOXXFvXNr+EZa/SDHBOD04UP2uTBs9lISUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XVuqSURM; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70dc4d786f2so5262746d6.1
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 02:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756286362; x=1756891162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAGP6+v0aqIanlLZq8tKQXuL2ZD/uNz3eVRe0XnECB4=;
        b=XVuqSURMeBPIPDWj10l++pRi+jZ6HFgHDmH2P54rWIL34RJmIwHNwwwd8GHAEyOKn4
         EO312slC9L0WAusF19t/xujQzUx2DBQONmsLzsp1Y6BsJWCKMehIz5kadMySq/NPjqhG
         4YxuEYX1o0u5lwg5fE9swwuM1mK2PBLey7tvuTm4sEL90/eJMID0B2tBoDG0Ol7TG8pF
         NzM2lvpXsi6Hn71nhKfHmm0OgYbinq7uxsz0ltRjiq/PIohDL/xZGKCp0Ady6ISwVc61
         U4YJUR9TJpQuh1YCvIURGcng1aZ2Mlcg0O18M3z1v0jZV+F7L2ZohOdOkqeU+zzNFvfH
         xQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756286362; x=1756891162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAGP6+v0aqIanlLZq8tKQXuL2ZD/uNz3eVRe0XnECB4=;
        b=k+CHX3DksPZKp8w/lvHNN2IQyyCf3uHzaFPUnOBOsGBkKx1cLbe7RcRnYE6uvPL0bS
         Rr0F0FsD5REdplWiHbeHxrHzlyyubX9ntJLdant0I+X7zIYHi3MW232cd9bUhIxS6sQt
         PcrJJ86ASYfIkh6RY9ZoU3GV/eChf0jm6mFdOJ5Gmi1y4byzj9vecijNYqdtKrfyw1in
         iCnA+P+y5uDLsAoxzVHUngCobLHdsxbRUDxE0AHtHwL8nF7ksXO9XfDDyzD2vLJrf4XC
         yY+FR5zjTWmQPTl+Guqi8atKua1VzWvSm12vLHsx1jwY+Yhm7WN1jXpJ/tVshKydW6zp
         HLQA==
X-Forwarded-Encrypted: i=1; AJvYcCV3dh35l2O7ed4VIuNpp4/3Dh5NG6OMCm7flBJLZUaXaEygDSSd3gi2wucnGjfGjDjf3Ug1oTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO4oKomW9cjnjS51lSaKzl2Rt9aX2fgwpWAmOYyVerVA3m1srh
	Y2P+xR7I0G1Q4ZSmbO6CX1Vxe4JBQXlKMUrfSvOty1s4QlvMIy5b36332Y1VUpUhQd6PMR0Ghyd
	d5llWXYcJcVqIp6/jU+u8oxQhagz9ZUpRxWlbsvgdPg==
X-Gm-Gg: ASbGncu2mUOplWJfR+kcGSIIikQDRgYPUAYVSSAGFQCjnn3VbBbaeOU+od5NE/jrE4a
	nESQ2lPtYdn7rNbVrn3J6qkzGC5mB8C3SdrnAqTDgeF2rctVxsMg03xU6VcilVyrkmd36OKgmfi
	kP9/os5MjTDmGqqD9xBBZpOWA0wVOOOQu2Q6McEu6vJhXoMLaH8cj86Qo01zr/eIEqkZGFqnJNw
	44dOYvJwjzvGR7a
X-Google-Smtp-Source: AGHT+IHARRnT1N4zqcCAz12YmvIGWvJHCpnJD8j+bxZUx4ZcX/IZT9D91YgboaHgNiZKqhdNCbez3TH1xfppau7fRw4=
X-Received: by 2002:ad4:5948:0:b0:70d:e0c9:9a01 with SMTP id
 6a1803df08f44-70de0c99baamr14228436d6.7.1756286362306; Wed, 27 Aug 2025
 02:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826110905.607690791@linuxfoundation.org> <ed898a83-48d1-4cce-87b4-b67ee4fdc047@nvidia.com>
 <2025082705-ascent-parted-b05d@gregkh>
In-Reply-To: <2025082705-ascent-parted-b05d@gregkh>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 27 Aug 2025 11:19:11 +0200
X-Gm-Features: Ac12FXzRXKM8eGbos3kIG0i0GrqtW_2Q-_DCFT9bd-DpOvEWNa60MKUm0GzYmCg
Message-ID: <CADYN=9JXM14H+N-08GWxs1xigRKHfy_SrCCJGnhuGyDXgGycVg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/403] 5.4.297-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Aug 2025 at 09:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 26, 2025 at 03:46:37PM +0100, Jon Hunter wrote:
> > Hi Greg,
> >
> > On 26/08/2025 12:05, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.4.297 release.
> > > There are 403 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Thu, 28 Aug 2025 11:08:17 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.297-rc1.gz
> > > or in the git tree and branch at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > >
> > > -------------
> > > Pseudo-Shortlog of commits:
> >
> > ...
> > > Prashant Malani <pmalani@google.com>
> > >      cpufreq: CPPC: Mark driver with NEED_UPDATE_LIMITS flag
> >
> >
> > The above commit is causing the following build failure ...
> >
> >  drivers/cpufreq/cppc_cpufreq.c:410:40: error: =E2=80=98CPUFREQ_NEED_UP=
DATE_LIMITS=E2=80=99 undeclared here (not in a function)
> >   410 |         .flags =3D CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LI=
MITS,
> >       |                                        ^~~~~~~~~~~~~~~~~~~~~~~~=
~~
> >  make[2]: *** [scripts/Makefile.build:262: drivers/cpufreq/cppc_cpufreq=
.o] Error 1
> >
> >
> > This is seen with ARM64 but I am guessing will be seen for
> > other targets too.
>
> Thanks, somehow this missed my build tests.  I've dropped it from the
> tree now and will push out a -rc2.

[for the record]

We also see the following build regression on ARM64 with gcc-12 and clang-2=
0.

Validation is in progress for RC2.


Build Regression: 5.4.297-rc1 arm64 use of undeclared identifier
CPUFREQ_NEED_UPDATE_LIMITS

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Build
* kernel: 5.4.297-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 8387e34ec6fea83fa8bf03ffa1c8c0144d801c14
* git describe: v5.4.296-404-g8387e34ec6fe
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
96-404-g8387e34ec6fe

## Test Regressions (compared to v5.4.295-145-g6d1abaaa322e)
* arm64, build
  - clang-20-defconfig
  - clang-20-defconfig-00b6e174
  - clang-20-lkftconfig
  - clang-20-lkftconfig-no-kselftest-frag
  - clang-nightly-defconfig
  - clang-nightly-defconfig-00b6e174
  - clang-nightly-lkftconfig
  - gcc-12-lkftconfig

/builds/linux/drivers/cpufreq/cppc_cpufreq.c:410:33: error: use of
undeclared identifier 'CPUFREQ_NEED_UPDATE_LIMITS'
  410 |         .flags =3D CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS=
,
      |                                        ^
1 error generated.
make[3]: *** [/builds/linux/scripts/Makefile.build:262:
drivers/cpufreq/cppc_cpufreq.o] Error 1


log file: https://qa-reports.linaro.org/api/testruns/29678460/log_file/
Build detailes:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.4.y/v5.4.296-40=
4-g8387e34ec6fe/build/clang-20-lkftconfig/


## Metric Regressions (compared to v5.4.295-145-g6d1abaaa322e)

## Test Fixes (compared to v5.4.295-145-g6d1abaaa322e)

## Metric Fixes (compared to v5.4.295-145-g6d1abaaa322e)

## Test result summary
total: 22051, pass: 15817, fail: 1724, skip: 4433, xfail: 77

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 131 passed, 0 failed
* arm64: 31 total, 8 passed, 23 failed
* i386: 18 total, 13 passed, 5 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 9 total, 3 passed, 6 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

## Test suites summary
* boot
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* lava
* libhugetlbfs
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

