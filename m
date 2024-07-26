Return-Path: <stable+bounces-61908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AD993D789
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 19:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F62283DB6
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49A917C9F3;
	Fri, 26 Jul 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IlUmKUE7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C208711C83
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014586; cv=none; b=Po3+wtblB/ZzwvPGLWe5fA0bgRWu82tD8Zelw5CsXQiBsPPJGEr99+sdwZowOjkLJ5sMdVtXNTL+oaOLCPjecXRXdc2ldy+4I4gDDJgvxlZTYs+JQ9JS8t5ONxNX9AT75r2zccGU6R8eOaEyHURVWk//7+Q/MWT3hJOvVJhgaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014586; c=relaxed/simple;
	bh=HpHTJ8UAXqg/qBRJFXcpcuJ6jv0Otx1tVvvLI8oym48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXYCOYwjSbJC4dt1MPeSW0nvDBq7cChqboFTi8zLy23Pm75vxrobVus1Amb88MmDkxSf7UR1U/PegjBkDJsI4xQIcrG7cvneaElYBtpuc+u5eDHOuRACQtpUz0vpkZC0K2GqaoaLWUoMWYhqyk0HqamlRVK0HTlJQ8OaX/oX5N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IlUmKUE7; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-821eab936d6so259020241.3
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722014583; x=1722619383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/1YORL54OykD9JzBMiqR9I0uazQS9lBK5x2oq741pw=;
        b=IlUmKUE7UnGIk7eTOAJe88WXj2y6392/AbX1OaEm3p9q2MG4XiYdMpSJlY4E449MvN
         y78+eeSCLuiQAEtmBOec68iZHawcSPEMRav0Lhaa6hXcMztMXlFvodXFGjYjhtNeyqid
         ql1/OGPRVA0ZqyQrFWXs4OobKiI0VyGy5ffLLfNUekj6dP9lTlSihMAiLJuzJhUx6bVs
         p+KuZvbBC6zHfK2G5pjxT+p6GmVEuJzS/Pf/mrg2osZ+UkQfuwblEDAHkcwQ02qL5Nvs
         wklVArarz7MptNcA+lSLCJyw3tWb4dGC8BgwdKATuWbBhkjHnb6hR61819KVRRdCgEnp
         emWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014583; x=1722619383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/1YORL54OykD9JzBMiqR9I0uazQS9lBK5x2oq741pw=;
        b=YCPqqRTBNak0p9NG+WOxXJzhFfNqxdGp0ugZLG9KnxGt3IecUAB+YVCWw3NZzhLnTG
         /2JKVmiRb0DbvdeGalTX8SGlXcwuj7gbx0tJWslmcvDF/b+BK3Vf5tHakiFu/sA3oQwn
         ZHgP1ob5jurqndYyXvACoKQ3EpB1r6iZuCH827MISFXbwqyfmfOXNDzyVTkOXyqyzTKL
         yoOfvKTqCAZR5KzfYEOtwLjnTBsd5qsXLrUByNR+C0Tyk3iLKKCLFFaHodl83kS2DSgt
         yzyVRWkmLpqCeLEu9y3lYS1g17K+RYYGo73SCnA5/YYIfHZpkbObIMJoxsmzkaqJ73So
         E3Og==
X-Gm-Message-State: AOJu0YwjMpvuJI1MZEeHokbMBzZX5Ka0FkSTNQaiPcVlliW5aJ3IRK7R
	jbZfRseXdTUgbQyG2v8A9papcpGnVZNYzuoP1yyZBZAmxiy5UXkTryR9f5GEp3xSRgOottcCPXo
	V8NvV/Tn1jfvXKS0vNYBJTwDM5M7o1fM2arMayg==
X-Google-Smtp-Source: AGHT+IGcIjjEnlgMUd1S7i+4XbE3oBcN328lCJDqimct0ReISUdhwEXhTa7kb9Dz9WVySZcaD0vx1mFeWij5asC3euU=
X-Received: by 2002:a05:6102:6c6:b0:492:aa42:e0ce with SMTP id
 ada2fe7eead31-493fad44a1cmr344643137.20.1722014582616; Fri, 26 Jul 2024
 10:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726070533.519347705@linuxfoundation.org>
In-Reply-To: <20240726070533.519347705@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 26 Jul 2024 22:52:51 +0530
Message-ID: <CA+G9fYtK3xz6Miez9vThbnUYDLU1YvP+W4DxB0EBG4wxV7dM+A@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/32] 4.19.319-rc2 review
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

On Fri, 26 Jul 2024 at 12:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.319 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 28 Jul 2024 07:05:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.319-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.319-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 0a1a65dc05b27c18b8730072d2586708d6d90c12
* git describe: v4.19.318-33-g0a1a65dc05b2
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.318-33-g0a1a65dc05b2

## Test Regressions (compared to v4.19.317-67-g8b5720263ede)

## Metric Regressions (compared to v4.19.317-67-g8b5720263ede)

## Test Fixes (compared to v4.19.317-67-g8b5720263ede)

## Metric Fixes (compared to v4.19.317-67-g8b5720263ede)

## Test result summary
total: 53258, pass: 47351, fail: 237, skip: 5630, xfail: 40

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 102 total, 96 passed, 6 failed
* arm64: 27 total, 22 passed, 5 failed
* i386: 15 total, 12 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 23 total, 18 passed, 5 failed

## Test suites summary
* boot
* kunit
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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

