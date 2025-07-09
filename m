Return-Path: <stable+bounces-161489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D80AFF297
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 22:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D8B3A314E
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 20:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745CC241131;
	Wed,  9 Jul 2025 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKrOCWUk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D791E5B6A
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091482; cv=none; b=eGxEI5taiFz66jZ6Cp4ANkP7ORIWWWpt1AxZr9xqQ6XX0N6PML0M+eLisvAokXXS0qOBpeNZ25uQRgH6BtjdtxfT72CtNCJdIM3hNH2NeMm29fogLry/TsjelGr3QBrIEjlUYOnmV20GFC1WmZd99bl949mFd/5wxovy9dY7ebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091482; c=relaxed/simple;
	bh=6oyYM6Bzq6DIFEVKD4PZ0b1pUz22xCymj9g6kLJahpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtaM2zo4mNYbPTI7+zXsaldTOMzPIRhzgK9TfbJC1hrH2ea6Y0Ky21sq/uOMeV6OSBJiZpRBCJ81NXNHAJDknFhczCP1zecjTid1YIu4Fv4G7gRr9r/ItN4yjo/9lIFFqIoC70jJoQqO9iEk6EprGXAmGyg7jk5CpEef3VNVUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gKrOCWUk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3138e64b3fcso354959a91.2
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752091480; x=1752696280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Suysl+uy0WOM5aXjtyyo3S8JCmjXJX0wRi5U/ew7K4k=;
        b=gKrOCWUkmighhmSL9kPNlHEL1YLWmey5LBro3hqVrzvFwpKVljZBiQKWVIkKOv4VUi
         s3tneXCpUOAJtmpAn48ZB2Ny0JNVtMHi8Ou0FqPOjJU93A4F/HX9tfZ95fGay6JPt9rR
         qTBuO6/1vlwiRBbJYS3qY35EsnwP/vtmlmcfVIRXT3bnBHjvX7kZ93xAF1YvYXV74vFi
         nTM/NEERQDwFb2p8S2ovvbVtos7tPFDW7iqxKTlaADIYECdhs4xEIDbfdRQmaJh7xheP
         v/eLo5BAjrgZVs/tNS3aTszZv4afc76hRfrTuh9FSMaiW9HqVE8/hXdE/C5sose+wQel
         JWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091480; x=1752696280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Suysl+uy0WOM5aXjtyyo3S8JCmjXJX0wRi5U/ew7K4k=;
        b=clIVRs5z4m7hcuqegu2mwpr1/b7xriOi1y3o/F1ZM7j0FwdW4QHzK24Egl8j0d/Idy
         1DHHGbQN0l0g5nmlAUMJrmbxH4YPi0DAtwAsB9iFQuWv36PN2XXhWGStJBHvjqfSp83i
         n81ToME2s1tvrIz/Kx8ykxwjS+v6ZafFuGRaSEFoUeH9TDFFZdCbwFD1/5+be68qj37N
         25y9igwkP4RVksZZSsHnDTwUhRexVl+D40CZfnQ0q0ksfp0+qTuctE7UtfvVbjgu4NDA
         CpsWtp4qxEjWexB/w3+S8bJpkuEDDYDBAGeumWWHMsUBYZHosKwhOVyg1HvVVplgTWI+
         MSvA==
X-Gm-Message-State: AOJu0YzmSMr0Hf8H7cqt5B/uUVrZTn2563FOcXE43a2MENO/4kxQx3L+
	oaEk+1hjQUmJlYQpiJITaD4v30vWy6QDPvt/k06XVOp9TFatudbyzVreYFGMCg34As1TuuDR1R+
	A7782whci8yk7P3t4duWysBrIf4ffuefe+8pP8BVdxw==
X-Gm-Gg: ASbGnctbh3deKQFOmGjvg5NeNI/Ioi9fmvDs1wUor73YVtz+bzaT2oRr3qVJdGrz5Dz
	Qx6dFlk302ayGLLG27kDzVJyDvb0oBkHmjm+X97zOd9M7P+FqIp4faLlcl51iB1Sj82Xfvr3dHj
	HzFmqN6vyRoPwc/3CzyOz4u0tpj05tHY88SRiYddyisejbn7WoD1hpndxh98h1VnO64kLL4RQea
	vs=
X-Google-Smtp-Source: AGHT+IHyb7AodBmFQk72shSQkiCXZlrFkQoW4uGqYTIWPeAZ+h2iGsmtVGE4J9dRdDa0kWaEz27u2ChQkJDWDPr3dqU=
X-Received: by 2002:a17:90b:55d0:b0:31c:3c45:87c with SMTP id
 98e67ed59e1d1-31c3c45088cmr1530172a91.13.1752091479654; Wed, 09 Jul 2025
 13:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708180901.558453595@linuxfoundation.org>
In-Reply-To: <20250708180901.558453595@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 10 Jul 2025 01:34:28 +0530
X-Gm-Features: Ac12FXwQoTBN3H_JtJVT5-ethl5wWUwGHDE-rzunC_bB-mbB4lZM0MGm0RgxXb8
Message-ID: <CA+G9fYtkGSe0MP7+vXEcLxg80VC4-yHtme_xjnK-Dg8LkN1VAQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/81] 6.1.144-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>, alifm@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 23:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.144 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jul 2025 18:08:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.144-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Regression on the stable-rc 6.1.144-rc2 s390 builds failed with clang-20
and gcc-13 toolchains with following build warnings / errors.

* s390, build
  - clang-20-allmodconfig
  - clang-20-defconfig
  - clang-nightly-defconfig
  - gcc-13-allmodconfig
  - gcc-13-defconfig
  - gcc-8-defconfig-fe40093d

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Build regression: stable-rc 6.1.144-rc2 s390 pci_event.c:269:21:
error: no member named 'state_lock' in 'struct zpci_dev'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log

arch/s390/pci/pci_event.c:269:21: error: no member named 'state_lock'
in 'struct zpci_dev'
  269 |                 mutex_lock(&zdev->state_lock);
      |                             ~~~~  ^
arch/s390/pci/pci_event.c:272:24: error: no member named 'state_lock'
in 'struct zpci_dev'
  272 |                         mutex_unlock(&zdev->state_lock);
      |                                       ~~~~  ^
arch/s390/pci/pci_event.c:279:24: error: no member named 'state_lock'
in 'struct zpci_dev'
  279 |                         mutex_unlock(&zdev->state_lock);
      |                                       ~~~~  ^
arch/s390/pci/pci_event.c:285:23: error: no member named 'state_lock'
in 'struct zpci_dev'
  285 |                 mutex_unlock(&zdev->state_lock);
      |                               ~~~~  ^
4 errors generated.

## Source
* Kernel version: 6.1.144-rc2
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 10392f5749b37d327ec5529958e9d5d27cf07b6e
* Git describe: v6.1.143-82-g10392f5749b3
* Project: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.143-82-g10392f5749b3
* Architectures: s390
* Toolchains: gcc-13, clang-20
* Kconfigs: defconfig

## Build
* Build log: https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.1.y/v6.1.143-82-g10392f5749b3/testruns/1565938/
* Build plan:  https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/2zbVlOqL24w4NUJUSg3nXcHGVZ2
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2zbVlOqL24w4NUJUSg3nXcHGVZ2/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2zbVlOqL24w4NUJUSg3nXcHGVZ2/config

## Steps to reproduce
* tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig defconfig


--
Linaro LKFT
https://lkft.linaro.org

