Return-Path: <stable+bounces-126857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78064A73292
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 13:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55A6C7A2A0A
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 12:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FED2144C7;
	Thu, 27 Mar 2025 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7QQm62O"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95338FA6
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079826; cv=none; b=e57LUQ0qXUpjxfKiXrYwiT1y11tImHGr926/jt3Z8CM/uoI+58Snq5fDVFbufPRMqURNa5VN3JawwiRKT/Mf6dHWwNHLHoOVOgtmMhfCHJ+sg7xnocjNQ+FvNYauFUMtT6YXmgH29UxsTXA79/5yBj233Pa7TCfLS1rEh3wonEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079826; c=relaxed/simple;
	bh=x0/E2M0F+EgLHnBAChfuUY4dPirGmTNiotD1PkORt9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltWcA9pvxnRsYjgbgRXFDi3KrJ7HyqoHSGZb1k6p+6Zl/DNRMQjJfjg6sbyF3sHPjPBMPY0iGI/cwmZrjXiDgBjkF0bREmMfIeyo4kEC2MRNJK7EzXFCK529HuJA/ATnmLKtKgFyKzN6DMTlIQPEo4pwIE3jqZ/loQxJ7TGPOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F7QQm62O; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86feb848764so440621241.0
        for <stable@vger.kernel.org>; Thu, 27 Mar 2025 05:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743079822; x=1743684622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YxPf82X3yEknJZahIFwtaw08CtPbnq39I71FWEqVAf8=;
        b=F7QQm62OZHOUaeLPsRQHgemR1rBdyRwYLC/mzeib+x13U1Tb2asL6cwOBqmRZP3fD7
         tvQhPrhkzUSxf9Eij4gUGWkVEqKdqlZ9XWeu73FnEa9MAEu6PvBI2IPj8Ljc8kgQjl+K
         vVwjxC/ZBhVRayWt3slHX7er26mgZ8ilIWL3KnYAtt3g1HjZ3VQYSfYIyu3LhcJGSYQT
         IAftgDXu8sKVgCpBpQvatSFKcWCKgbzEcxuueE/KZtCV4dwdR0HSjwRVUxZglpUYYg6j
         mcAwmap5ttkX+T5POPhlgcHwzKHNnQO7RTW1BjUnPNr/TFFkMlqRd0sX0h9vbX2vt2WL
         8X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743079822; x=1743684622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxPf82X3yEknJZahIFwtaw08CtPbnq39I71FWEqVAf8=;
        b=J2Jv1857kVWFI06oPxd2GBe+9rS2M4fz+V8iOCJx3vUOvvTOiYWqGXvHVpa3EKdfLO
         Aq7gBC1JlTDmTAGGspeEfzLL6JNAHegngSR2r2taYde6CyQaw20kJqZX2QHQ4h3FjDNp
         GXHPxJD1NrNA6zzGYW81B1kWSG4z+6WFHww43ip7Alfp8aoam1K/Aw7kvznYQTm2CO/4
         CO8krUFikIOGA1DwdnBFJtzAd800b9s3rSWfdXA2JQgndIw+y5UCvQOnNLqTB2jrvZap
         ZrKHd5qsSdWp4yqp0zyaXFS243J94CA0IpFREU890x8cZUmpnCoE1XpwVnc/BOSi/kj/
         Z48Q==
X-Gm-Message-State: AOJu0Yw8NI5lHXvHMonaS3+VWTDJmHy06AH2z1GcmuVVY5SB3asPYSjE
	n0CvjLKCdfvRJpWdPa/Vct9IZ0gJDDUx6/8uB4LeS6gzLmAXGygMmEo6ZGgbjCzKp3bNUO3ZWEe
	bHanXF/tUaJaIiql15Lue+vw3siqreeedU/x54Q==
X-Gm-Gg: ASbGncsMfUV0GntrutkhbXUBAZbJ5tPRHZXHu8gSZFgso6+423HNVN8TrzN8DALquEq
	B6AGr2YA4Lt4PTyKhSYoa+D7faffHx+US5cnQUoZOelLW8/yDlrRbSR9vpkrBMWrjtVVF/hRMh1
	/uJKBInBi0K4tHAxGDV9v0O6ndBWEurmVAnYF72AN58v26qCn7RWNdRMnuYHU=
X-Google-Smtp-Source: AGHT+IHJT4hKKSEUXlpmrmhxoV+NJpCfU27nTmRX+PSKGFNIOYp+YtuJN7H/mSdObFWYsi6xV1D2Xzz8lFMeeJw8D60=
X-Received: by 2002:a05:6102:1529:b0:4bb:b589:9d95 with SMTP id
 ada2fe7eead31-4c586ef2197mr3532762137.4.1743079821716; Thu, 27 Mar 2025
 05:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326154349.272647840@linuxfoundation.org>
In-Reply-To: <20250326154349.272647840@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 27 Mar 2025 18:20:10 +0530
X-Gm-Features: AQ5f1JqzxAAFsa6xfl6ahL538LTvEz_6T0WQuL-UCtRCOoqdpwdAR2e1PKOJHcs
Message-ID: <CA+G9fYsRQub2qq0ePDs6aBAc+0qHRGwH_WPsTfhcwkviD1eH1w@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/197] 6.1.132-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Leah Rumancik <leah.rumancik@gmail.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 21:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.132 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 28 Mar 2025 15:43:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.132-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm, arm64, mips, powerpc builds failed with gcc-13 and
clang the stable-rc 6.1.132-rc1 and 6.1.132-rc2.

First seen on the 6.1.132-rc1
 Good: v6.1.131
 Bad: Linux 6.1.132-rc1 and Linux 6.1.132-rc2

* arm, build
  - clang-20-davinci_all_defconfig
  - clang-nightly-davinci_all_defconfig
  - gcc-13-davinci_all_defconfig
  - gcc-8-davinci_all_defconfig

* arm64, build
  - gcc-12-lkftconfig-graviton4
  - gcc-12-lkftconfig-graviton4-kselftest-frag
  - gcc-12-lkftconfig-graviton4-no-kselftest-frag

* mips, build
  - gcc-12-malta_defconfig
  - gcc-8-malta_defconfig

* powerpc, build
  - clang-20-defconfig
  - clang-20-ppc64e_defconfig
  - clang-nightly-defconfig
  - clang-nightly-ppc64e_defconfig
  - gcc-13-defconfig
  - gcc-13-ppc64e_defconfig
  - gcc-13-ppc6xx_defconfig
  - gcc-8-defconfig
  - gcc-8-ppc64e_defconfig
  - gcc-8-ppc6xx_defconfig

Regression Analysis:
 - New regression? yes
 - Reproducibility? Yes

Build regression: arm arm64 mips powerpc xfs_alloc.c 'mp' undeclared
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
fs/xfs/libxfs/xfs_alloc.c: In function '__xfs_free_extent_later':
fs/xfs/libxfs/xfs_alloc.c:2551:51: error: 'mp' undeclared (first use
in this function); did you mean 'tp'?
 2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
      |                                                   ^~


## Source
* Kernel version: 6.1.132-rc2
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: f5ad54ef021f6fb63ac97b3dec5efa9cc1a2eb51
* Git describe: v6.1.131-198-gf5ad54ef021f
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-198-gf5ad54ef021f/

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-198-gf5ad54ef021f/testrun/27785617/suite/build/test/gcc-12-lkftconfig-graviton4-kselftest-frag/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-198-gf5ad54ef021f/testrun/27785617/suite/build/test/gcc-12-lkftconfig-graviton4-kselftest-frag/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-198-gf5ad54ef021f/testrun/27785617/suite/build/test/gcc-12-lkftconfig-graviton4-kselftest-frag/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2urSwNctsyhQzf1j7dvt6nHemP5/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2urSwNctsyhQzf1j7dvt6nHemP5/config

## Steps to reproduce
 - tuxmake --runtime podman --target-arch arm64 --toolchain gcc-12 \
    --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2urSwNctsyhQzf1j7dvt6nHemP5/config
debugkernel dtbs dtbs-legacy headers kernel kselftest modules
 - tuxmake --runtime podman --target-arch arm --toolchain clang-20
--kconfig davinci_all_defconfig LLVM=1 LLVM_IAS=1


--
Linaro LKFT
https://lkft.linaro.org

