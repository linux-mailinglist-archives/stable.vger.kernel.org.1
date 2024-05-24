Return-Path: <stable+bounces-46061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EC88CE4FB
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 13:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2CC2B214CC
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 11:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C778614C;
	Fri, 24 May 2024 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sz5CeaLt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4791482D8
	for <stable@vger.kernel.org>; Fri, 24 May 2024 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716551468; cv=none; b=eFMffFvx8VNCtbeUSGdjeH0ZRiEbk9r2Zd/YdvuagjTFMgU9WJcWuQI2vCVaFMt1Fez1Zje8lWIMeaBZ1GHvBKBmbkx4pCUfpIMUgL02izH8dzJbGNIPxvrE9RzWXh+WOjDo4sx9MEz+1IoDhRImtm46Reo0J4KzWYxjidJA55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716551468; c=relaxed/simple;
	bh=FCPHFlcxBHbocJtDdR19vK9bHOzjeGF96v/VOE++YcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7MmYf7+3/Ht9xBGR0+r93qEtPPqPyUGkCR5C+M5qZs6SRSD/6BlMjkxrZoCe5OKz4jfC6Sf1AYG+RGcMUuUCo0JHOlpPZrPdVO51P5mdCfVJJMdqu1nL6NBiXx3Jdt47Klinjwv7nBTmiW6YDqyEDuVocV4BX5YqJ3Dw0lG/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sz5CeaLt; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79476195696so198471985a.0
        for <stable@vger.kernel.org>; Fri, 24 May 2024 04:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716551466; x=1717156266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI3rC/mfMOMsxLRVRWjaH05KZLvb2lJoZXHMey213Tg=;
        b=sz5CeaLtZKeY0h+ci5aO0V0b4lNiVoQcTlXpzi96keRYXGWYqR4kZSKU5BIFA2Zxza
         z6vi9twZGPyemwSiJHz2ZehOAuZLpUs4sKxk/R7JH/qWHTbKYdNqcTVCOfb7EhjG0t2w
         phKFakJT5E0RnIDFFu/+6mgG4rMh2kuvflQrQY/58118YQW7n58+7TKg+X1AxUCbxoLM
         XoYFyDX2b8hfmetXZIVrlJP0KYhj+gueTfp7+IOKCmeDb5Sop/lhUWH0mdaGqhG5r/yY
         uGikcO3IMqlloS+mTpZWW7LwNhq+/XMiSTQF6e9w6Jr7wv7uyLLehkb0RaaQnb8+5zIJ
         +hFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716551466; x=1717156266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kI3rC/mfMOMsxLRVRWjaH05KZLvb2lJoZXHMey213Tg=;
        b=W26oq7vxPAWSxLBDGnDySh61sc0X6TtkEMgML37T5Q4kBDAZEREVFfRxubyA9WNcuP
         hdpFMrVmWlFEYpOCsyEzsUtuuqXuvILGp19Wj3UxDLhPGYL/juPsVDXUNrp+wK+hyPM0
         vYBNYmfWjlGYGXqP0aF21OTkjolpTkb6ljhUuXbgjX2OdD2MFx8uRGP50nBtcQ7Fuw8L
         EmBRRp4uASQPNhkUZliEMSMzA+ZaKtqyuDZ7VfvorMdRLT8rnnEjwN+AiuFcbTt6yCHj
         IZ/7XJh4VIsTExsr7NAprn1XYN99wwmNdBROZTYsBn0LUAp1UcqUj3mW/EyqF5XuEZps
         qh0g==
X-Gm-Message-State: AOJu0YyC6bgASSAeADti5QHymdEj6BJ28rsbnRfSaNbfN8TxhPnL4Y8o
	LNBJkC6gBtrApBfw0UBstt4gw1Q5+0PfxKyZGQLKTyJfsF/3ZqCjx7OsaQzGLHG00v7SmsVg3lL
	0Ku2DeUNBMwmN2I1qZuccDBhqnhqROsvbROycLg==
X-Google-Smtp-Source: AGHT+IFZqBtDNWBSwVFl70aifDa3xZX3joiTKqJ0DW9rIZUf8b09hmIcoKQwVdYy5nTXL6+tjZRj4kF9HKabw9bNGEo=
X-Received: by 2002:a05:6214:5781:b0:6ab:99df:40fc with SMTP id
 6a1803df08f44-6abcd19e33cmr20418116d6.46.1716551465697; Fri, 24 May 2024
 04:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130325.743454852@linuxfoundation.org>
In-Reply-To: <20240523130325.743454852@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 24 May 2024 13:50:54 +0200
Message-ID: <CADYN=9KOfUNp7E=sp_1or0YS15cwP0vYQJEhgkxscCUSLjVEzQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/16] 5.4.277-rc1 review
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

On Thu, 23 May 2024 at 15:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.277 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.277-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 35 total, 33 passed, 2 failed
* i386: 23 total, 17 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

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
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
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

