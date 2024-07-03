Return-Path: <stable+bounces-56922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC679255FD
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 10:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44333B20D66
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA6413B5A6;
	Wed,  3 Jul 2024 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsx8idnL"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555D0133291
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719997035; cv=none; b=mgzUgdsRKXaR3h4qM+fsJL6mqozIPILDNKoIk3RzP6z5oQIPiV0XH4l855Co/tCYFkU27LtR5MiFK2By/Kq3j3Bv66kM3WFCdz1qXpRo+qhpssEuGLgyOmID4newsW4fWj6zEZW6Uk0a8OA5bd5cMwesgzlPP39orsE0dNqLtsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719997035; c=relaxed/simple;
	bh=9P6gVWhaXfdGANh8cYupR+qgTAfXCsxjmt6x8vMHMpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKXPRhBYjuaQGy+G0w1NKzJYaO6mmwtefY2cFVhfB0AVSvg+WOVvNk5Gh2DuI1CeuSacHeDVinQh7oHQTCEmSTN9flnOUbFbXWWad2x6nKkyDz3Npf70qbpRnng6EWq8dYAoEWJkT/rp4a5Ee/DNWfy1Gj4cHt6Jc9S/ax6IlAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fsx8idnL; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48f8f50e3b2so280252137.0
        for <stable@vger.kernel.org>; Wed, 03 Jul 2024 01:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719997032; x=1720601832; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0XEWnCj/mm3W7EIrD6z86rzpuQbyYOSDTNQl49iY71I=;
        b=fsx8idnLP4bPFk8NM87V+KyMSUBNZnzAjsrjFWjThoQga3vI28v7W6Enk8d7lGEbap
         IM47muNUKtfvi5BCOW0f8VpUNh7T1+T6wsC5ci3oXxrUPm3f/wwDwmwALFOlXtQnAPJT
         vL3IntqdNIJNU8oNJWtPgsoQtUvjlQBSI2H9joEI6SDUrWV9Ph/OAz+Fp0Gw2z6ALiFR
         LS0kD/ge0Sm+HbLbOCMXPa0RcAa3NCVx6Y96mLK8VHREl4RGn+Uh2s7qGKpZp79YM8i1
         qZtml49l2Er8SMuosQEd1pas4sTXD8VaJDL1F+N3GpBEvUtWY0VrtZCge/QVdZ3yNXLk
         Xl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719997032; x=1720601832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XEWnCj/mm3W7EIrD6z86rzpuQbyYOSDTNQl49iY71I=;
        b=iykcfEUwafnWqHloGIwsM2OzWIgTuM3035Im3O4E2rqrtdf38L8CQd8FGps6r9Q48C
         O4ml2oJ+hFEebQCoNEn206QvpNxD1DZHLs82GBh4pUbsKkJXec+ZRviaC5vkBvklGGxq
         YPNOLb8cvkKC9UmsbokEU3FMtAMxPZgSeYHmClPxosOk0YE4FerTqf44qZkMZ/9FPT0q
         b3bkx9pFwGFPh5f7t4wmRDYKyD/YZ/NW+wsJ1MKp0WoxhYtfnCLm1F6LdqLL2CanQSg+
         8zUBSy+JwbZgL7iSIVj3qGE5k5OaYLAY9euQ75xzkkzXJ8P37xfczd7dZCh429nerWxM
         Whvg==
X-Gm-Message-State: AOJu0Yw7ynSbtqZs9BYTWW4lzQRlAFLx7FRRTfBMv/XGFf9HT27brCNW
	HqnlPJDRiPq81tDJ/AgZSak/oqo8akyY7unGCYOAt/gI+2WMFpigSN60dIFarrA1zVMpbBX510e
	K8nLezS1i29tcU9j7017QPigv+XV7/TNGtrEcZA==
X-Google-Smtp-Source: AGHT+IHbkTRDyG2HvcG78gWTpQrxuOu/Y619sixvhYwI9yjX/IBnZ5qIyumvtHGWox7D6ggwzTkyRtApm42tixwUx2M=
X-Received: by 2002:a67:bd07:0:b0:48f:b5c1:7269 with SMTP id
 ada2fe7eead31-48fdeb0acc6mr352839137.0.1719997032251; Wed, 03 Jul 2024
 01:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702170233.048122282@linuxfoundation.org>
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Jul 2024 14:27:00 +0530
Message-ID: <CA+G9fYs=KkeYFMS01s3VZmeSYd1zJphinPFCk1G2AJ7LZ=+8=A@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/163] 6.6.37-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 22:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.37 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.37-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following powerpc builds failed on stable-rc 6.6.

powerpc:
 - gcc-13-defconfig
 - clang-18-defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
arch/powerpc/net/bpf_jit_comp.c: In function 'bpf_int_jit_compile':
arch/powerpc/net/bpf_jit_comp.c:208:17: error: ignoring return value
of 'bpf_jit_binary_lock_ro' declared with attribute
'warn_unused_result' [-Werror=unused-result]
  208 |                 bpf_jit_binary_lock_ro(bpf_hdr);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors


Steps to reproduce:
---
 tuxmake --runtime podman --target-arch powerpc --toolchain gcc-13
--kconfig defconfig


Build log, Build configs and build details,
-------------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.36-164-gca32fab2f2f9/testrun/24498135/suite/build/test/gcc-13-defconfig/log
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2ihU8SlMSZyrWYYdCJrskJS7cLd/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2ihU8SlMSZyrWYYdCJrskJS7cLd/config
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.36-164-gca32fab2f2f9/testrun/24498135/suite/build/test/gcc-13-defconfig/details/

metadata:
------
* kernel: 6.6.37-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: ca32fab2f2f9ffc305606cc41fe02e41bce06dd6
* git describe: v6.6.36-164-gca32fab2f2f9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.36-164-gca32fab2f2f9

--
Linaro LKFT
https://lkft.linaro.org

