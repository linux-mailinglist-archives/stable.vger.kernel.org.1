Return-Path: <stable+bounces-76571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D952C97AE92
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 12:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8B128199E
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 10:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8008115D5B8;
	Tue, 17 Sep 2024 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQOcBs7I"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9649443
	for <stable@vger.kernel.org>; Tue, 17 Sep 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568193; cv=none; b=CjghCb4qM3JoV2SwAopXFJYey/BFCmz7nk0IbippFSwoTYgQYFoXSvLlW+scbUZ5lb3FduwgGcv4FmSNeWJYMwgR71ojNW6bMCq0pwAWmLsqZxQtl9gJ5sJLSoA7oCSdwizdFUezdZGeFqms2heolYmFYPyDlAk76ahFJwclrJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568193; c=relaxed/simple;
	bh=7uTw2Xdc4FdW8Wguya1dEDJdgUqDCcIuNIjLGieyNvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgfiRlJvd00XbUU+lHKBGQwpQJLNoYF/sVAczH72XJ0SB+da8/nGsjQauOl6D9/AqI2wUezMrZ56gQRBaajIfppDqwfUVOCjpXp2Y+aq8OV3BNUccPTLOwprXWy9S1vkIhyXLMjgFO7kPu4aX4fOfvkQkynQDDrvG+//Zuxhz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gQOcBs7I; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f77be8ffecso59877831fa.1
        for <stable@vger.kernel.org>; Tue, 17 Sep 2024 03:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726568190; x=1727172990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2RIH+rGbvMwZNuIYE1wkPZCJpfjU4C5REBdV9ppb+nc=;
        b=gQOcBs7ISRRRcF8NQRrUWN5KXEX7yQxB0ujlmAhsw6KN40QhGIz4/PZf9gKP/BMFZ1
         Y8oXu1XbhFKLa+GsZU1qRVcaVRDP4P6N94MkLbEk9NEySAOQ+3E2jHFCBYXfUfaJleMG
         VSMdI+GLHf8AKpW6Ll0Jpp/gnLkVi1OCsxxRcR/8NcbYHCqEvCBjT3vZCBE278EHfDhq
         KZBlrsSPmhLW2SODeYO9BFXQXyOaGVtyqEVA+i5ytj/yXjv5HoaPGBmrX5T9vMUgn5ka
         8PpWphUYOlYEYTdKjarFWDUMPNQ19/sdAR2GKEIlAhv2sklCGxYExms/srHXVyj8dy4F
         i4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726568190; x=1727172990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RIH+rGbvMwZNuIYE1wkPZCJpfjU4C5REBdV9ppb+nc=;
        b=jonuVTHVCyc3B0nUp1hzMosMyJcVQFMXcIpeqVCdd4UU3r9z9ooUuV97wVODyqRAPx
         YC4/HB6iV/sHzysTARk3+QdVExQfuOesV099fPy9c4fmb0CJbProZQZaPstOV25GFGAA
         0y2YuMOutMNyeScXHGy+qPFoJHBc8VDCg+cPJf6sfvk7p1EfiPCRup+fHSniCnuA4zns
         EPenC+rpBAu4exl3uILSyHTlgjhQlAzKOlyTTNB59gY7APvw29GBmm9jCRGB4608Qywt
         98DupqcVCecl+xvGwld7SSKf6InRStr693G8n34/4X+NSBoYlBrZk59EU1RDa5Zn6+35
         2ocg==
X-Gm-Message-State: AOJu0YycSenUlLcOcI4LwlGoYa/D7byN8MJcM4L7OS/+k/qE1Fk7xUI/
	n7nL29ranziCvnOTRaVezn2o8mwExeJU5KQM+YmQYBMx4W4YSbNkYDxhGFsvJizs9rWXL8L1KyI
	kys8AHjfLGWudqVHtnkC1H3VKfpbs21/tDiaRoA==
X-Google-Smtp-Source: AGHT+IEwjK+qN1NAncZoepbBFqxMMHpAHTJm2GY7gFtHq4zje3zC3w3ucZADOfEc9PbgoFaEb/FwjyKKPawCwz/1quM=
X-Received: by 2002:a2e:be83:0:b0:2f7:503e:ed43 with SMTP id
 38308e7fff4ca-2f787edf4a8mr102581301fa.26.1726568189502; Tue, 17 Sep 2024
 03:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916114228.914815055@linuxfoundation.org>
In-Reply-To: <20240916114228.914815055@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 17 Sep 2024 15:46:15 +0530
Message-ID: <CA+G9fYvw7WaDjKp+v_snxnhgEzUDD1xZ9udJpqQcgAoQZXK5Vw@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/121] 6.10.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Anders Roxell <anders.roxell@linaro.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 17:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.11 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Sep 2024 11:42:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The s390 builds failed on the Linux stable-rc linux-6.10.y and linux-6.6.y due
to following build warnings / errors with gcc-13 and clang-19 with defconfig.

* s390, build
  - clang-19-allnoconfig
  - clang-19-defconfig
  - clang-19-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-tinyconfig
  - gcc-13-allmodconfig
  - gcc-13-allnoconfig
  - gcc-13-defconfig
  - gcc-13-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig


First seen on v6.10.10-122-ge9fde6b546b5
  Good: v6.10.10
  BAD:  v6.10.10-122-ge9fde6b546b5

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build log:
--------
arch/s390/kernel/setup.c: In function 'reserve_lowcore':
arch/s390/kernel/setup.c:741:31: error: implicit declaration of
function 'get_lowcore'; did you mean 'setup_lowcore'?
[-Werror=implicit-function-declaration]
  741 |         void *lowcore_start = get_lowcore();
      |                               ^~~~~~~~~~~
      |                               setup_lowcore
arch/s390/kernel/setup.c:741:31: warning: initialization of 'void *'
from 'int' makes pointer from integer without a cast
[-Wint-conversion]
cc1: some warnings being treated as errors

Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10.10-122-ge9fde6b546b5/testrun/25149541/suite/build/test/gcc-13-defconfig/log
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9VsokpNpc89Dqg5cG7ddRusdA/

Build failed comparison:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240909/testrun/25079447/suite/build/test/gcc-13-lkftconfig-kunit/history/

metadata:
----
  git describe: v6.10.10-122-ge9fde6b546b5
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: e9fde6b546b56159c192819586894f0e5b8ff6f3
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9VsokpNpc89Dqg5cG7ddRusdA/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9VsokpNpc89Dqg5cG7ddRusdA/
  toolchain: gcc-13, gcc-8 and clang-19
  config: defconfig, tinyconfig and allnoconfig
  arch: s390

Steps to reproduce:
---------
 - # tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

