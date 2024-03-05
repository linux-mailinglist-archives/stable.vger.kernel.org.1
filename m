Return-Path: <stable+bounces-26757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE60F871BCC
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 11:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4EB1C2175A
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 10:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8605F86E;
	Tue,  5 Mar 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jHM0j6zL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392FF55C05
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634240; cv=none; b=iU2qYOoPiKVnEG/ISE2BIg2qwq94sG5smXlkKXQzPTh6cgQBJ11Usia3iCEOdXXzgrEFB/jr0kCQGHGprc/ua0JThMh9ZWywQJVwM7VTH671ulLyLlFAqhC0bS+zMxCuiMS7wm3MW+6PpO5UwOnbTaJkgwniv/xypIJNKfxSH9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634240; c=relaxed/simple;
	bh=PqHa9jZYY6n6dlsBNRS5MBKuLT4wieT6fvPpCzLLJ7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfsDWJDaXHXc/DbD2kvt8brpm0hzmzYW/WqAeVqJ9LqLRpEXh1ICcqL0ZX6eNQaZfL0YezkpajCoNnyCCzm5vM77v/bk4SAzPdGvdTrwd4QKIcbAjQVVFryQbTk9KHK/M6qpNWN2y0Jav5nWKzX8iehvyy6xpcH+XTWVzKo09dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jHM0j6zL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56715a6aa55so2685513a12.2
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 02:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709634235; x=1710239035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PlspS2X5YJwHI6bCWiB2Kxx+bO+ABr/mcVKBji0Oxwk=;
        b=jHM0j6zLffqO/iNaKwTcxS1Va63ExTB+Y4QXrkQtiDryTRnuvDCMQW/avXwY6t2Gau
         cXWpkE1cRfd2XUn8l+5N58f3fVBrjKJ5KwmE6UWaTe5myvMtfsfxNVnMmft6eDmtaXZr
         Xk6FhiYn2Nufm046n+nzQU/nSm5N/C0gnxWEF0sJX7taXNKGwCxidr6VUnqwMkiMeod6
         exOO3t2yrOJ/Q7+gF7C42J6lFTr6s/mZ5ZWai0NJkUWKWxvA0BWBvyJOycF+WIRV9XBJ
         w/OZD+6PWQHAoYj7DoaJiEKcxd9PvD+2bMKujic4jnxvAiR0wYHm8mYUFh6MFiU0IJZt
         lnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709634235; x=1710239035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlspS2X5YJwHI6bCWiB2Kxx+bO+ABr/mcVKBji0Oxwk=;
        b=KHqPSk68zBSCT4c8/Iu4vhDfsOZQC6xHAYgcq3xjZrOODwLhniAQKN73F8kJXF+DCl
         wCnGXSOQPm2rRGOxnNUyNFkHXplWkF0ALe1knYM0ru+5YtrqvWPyxAAUpcrm9V7R7xw6
         3LUVGRLOF0zWfYAMATKjg5rtH5Sfe7LO8yf3u2wm0ZN1aYCwWQD85uEHm7uWDpGAM8uB
         BxIPGYVorMH25jsp481+jdCdw59do8xn2+aGfLZPhiK3tBxSkrTfW4HlwRnLRNJ6Bmbv
         COI58G9XUUSdclKdmmKMcHue21FekZqHF4xDXr7k817V6kt/IFAz58ssh0MSRHXKkfgd
         z5kQ==
X-Gm-Message-State: AOJu0YxEFhNarY2poihAvqM6zl/eTtyGzlC2lFPa7RQpv1Q92lzJgDSq
	KPC22vTcoSaWhxZrz5i84jLl7suUMma6YP47V5kDUr/QibIsXKYDvYcts5VYwSFBrGNZOGqNB4F
	sKSxQz4y9Jc8jt9dxMOBM7Lr4wRObI2f4lR17MP19qZiXsnZg5vI=
X-Google-Smtp-Source: AGHT+IGUwEp/+WhHA0uQ0uW2uvX6Vp5aF/NLRg8+micGN3CEaNubXYVANAb9auNn0QNapfA8iEZ3XcUbSMqmSS5KIi8=
X-Received: by 2002:a05:6402:40cc:b0:567:1458:caa with SMTP id
 z12-20020a05640240cc00b0056714580caamr5847164edb.40.1709634235386; Tue, 05
 Mar 2024 02:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211537.631764077@linuxfoundation.org>
In-Reply-To: <20240304211537.631764077@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 5 Mar 2024 15:53:42 +0530
Message-ID: <CA+G9fYsFuQDfvRGyUhLNuFXQc0yfu_eE3pnRYbUD7p9U7GEa9g@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/42] 5.10.212-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 03:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.212 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.212-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Following build failures noticed on riscv.

The riscv defconfig, tinyconfig and allnoconfig builds on 5.10.
The riscv tinyconfig and allnoconfig builds on 5.15.

linux.5.10.y build failures on riscv.
riscv:

  * gcc-8-defconfig
  * clang-17-allnoconfig
  * gcc-12-tinyconfig
  * gcc-8-allnoconfig
  * gcc-8-allmodconfig
  * clang-17-defconfig
  * gcc-12-defconfig
  * clang-17-tinyconfig
  * gcc-12-allmodconfig
  * gcc-8-tinyconfig
  * gcc-12-allnoconfig

linux.5.15.y build failures on riscv.
riscv:
  build:
    * gcc-12-tinyconfig
    * gcc-8-allnoconfig
    * clang-17-tinyconfig
    * gcc-8-tinyconfig
    * gcc-12-allnoconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

arch/riscv/kernel/return_address.c:39:9: error: implicit declaration
of function 'arch_stack_walk' [-Werror=implicit-function-declaration]
   39 |         arch_stack_walk(save_return_addr, &data, current, NULL);
      |         ^~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Suspecting patch,

riscv: add CALLER_ADDRx support
commit 680341382da56bd192ebfa4e58eaf4fec2e5bca7 upstream.

steps to reproduce:
---
# tuxmake --runtime podman --target-arch riscv --toolchain gcc-12
--kconfig defconfig


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/v5.10.210-166-g4b0abedc88b0/testrun/22941782/suite/test/gcc-12-defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/v5.10.210-166-g4b0abedc88b0/testrun/22941144/suite/test/gcc-12-defconfig/history/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2dF5ke88GqtfanduGie1JGLUbVa/

 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/v5.15.149-332-ge7cbbec10c6e/testrun/22942335/suite/test/gcc-12-allnoconfig/history/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2dF68wn0dXbU2xGLRyzsxGdXTyB/


--
Linaro LKFT
https://lkft.linaro.org

