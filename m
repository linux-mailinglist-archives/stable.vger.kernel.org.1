Return-Path: <stable+bounces-76574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CAD97AEC5
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 12:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BE628383B
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FDE169AC5;
	Tue, 17 Sep 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sstSTs6V"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26EA170A3F
	for <stable@vger.kernel.org>; Tue, 17 Sep 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569030; cv=none; b=kNJH8d7hDcuyCWdFDfPcdqZ36WiXreMEPkqSjzULzfCCm7DCAKlWKgw3ykEXA8gs8VL4gqhcjAPem7WTCLjGFjTI8P4gBLmxOGNhzSBWADFxriPhXM0ffDRB64gATmxMdosMvWJZ2J2cILQj+E9/Aly2OTV9El4NfOA4ObO+nV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569030; c=relaxed/simple;
	bh=rAUoQ4nus9+gGnXZO4GR16ay3famp7WL4FkpgBIVWUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7YwXiO8VmH72XOBvld9As4AYctLhvwiDmRspaQB749oiGILObGwOPtN7j4IGjmJeilRdqHMAw8coGUvBqdHgjjI5RDaSN/btdmMFNSQp/0NyuTC/Kz4yrSQ4eft3UP8MmCTIe3Uov4KvIq3sIwA9j3bNebJjc8Vh2e758QKlw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sstSTs6V; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-49bc1b1368fso2592792137.1
        for <stable@vger.kernel.org>; Tue, 17 Sep 2024 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726569023; x=1727173823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TiSL4J7L8lMiEUKJ3FGpFS/7E/wv/Xs1VRoLh25eebs=;
        b=sstSTs6VNOKqvK/uhvKhCNmEzG9dK4Mh1KxBFQl5JDZoOgEM8Xh5hc3sBCeryZaMJi
         LG2v/rbPzwqDHlt2xovQx45QiW9TCc+/bxhO5ZexUO07pB6blRLs4OY4V/j0Heq9Kd+d
         a615cKnZkbUMs5Y7nSmGeSce1Bws1pvcHcrKpeVzdHoXqCoRK5sk4jzdU/YO+TLIHNH+
         EsdlEGNkolXiyGdt14FYc0oElpkSJXR7TI+Bh6llzJyI7JH6qQm0IUn9hJtXZtPmvjoU
         rBcwA/NGA0j0tXu7PAclba/fsh2gUVW3nl+/6l85wKsn9lHdat36VXR7RbuqXqLa2ANL
         1mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726569023; x=1727173823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiSL4J7L8lMiEUKJ3FGpFS/7E/wv/Xs1VRoLh25eebs=;
        b=owCi4PZK1+IMeigQnx4ynsZToTg/dKllZqeGvSFewGoU5SRBJooIBtXgmRMKXYI1yX
         xbyVKXA+kdw/VzeF1e7uRtGfkU3Fw2JTaUyGU2nZoBd/TD7oaMDSt04CA3PhFZ+3+sOA
         INv028Mgj60lKvRFGca5BTulTpadeImPSZlX2S/goJZN2G91EbGSeds/EQxD9ZqfLQ0F
         Hz4NJ99qtPVRo7FQWjB2FitLpJWHJOz5TkiUtulCQ5xU2MHm0SYS0BFN/SBG2nRk2CKO
         nJJDw1Etyqxp3W9e+W/hKuDtB95D5vIXckOSdAsd2TVgNLNYtRuozxv54aZ/wekNQpLm
         C8hw==
X-Gm-Message-State: AOJu0YxvQT1jjFoJEsE2r44vly+JC12Ilqz04mow8DPuKwCaJYNtppxh
	VPBaHXsd3Mre+JzjydFYEUictIeLhS+gja2Z4zTuLe9PgdbJWyi3CzfbenTfF7DYCEscMoD9qDc
	nNwQ+nR522trmYnXsZeMHmvhOngkh3PhAKd5mJwraXFd8928YoMM=
X-Google-Smtp-Source: AGHT+IEVb9UtvU3qIrJ3hyC4983sMEXpKsLF/53bfiXaTkarBvujHfkK9GFkmBvRc6GUz54Xmq2wvMJKl1xR3mITQ20=
X-Received: by 2002:a05:6102:b0d:b0:493:c261:1a9c with SMTP id
 ada2fe7eead31-49d42165fe1mr12824423137.5.1726569022577; Tue, 17 Sep 2024
 03:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916114224.509743970@linuxfoundation.org>
In-Reply-To: <20240916114224.509743970@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 17 Sep 2024 16:00:10 +0530
Message-ID: <CA+G9fYv+OXhNPn87X4O9w8-HzGP04USge-et0b3Y4ncU9tussg@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/91] 6.6.52-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 17:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.52 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Sep 2024 11:42:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.52-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The s390 builds failed on the Linux stable-rc linux-6.6.y and linux-6.10.y due
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


First seen on v6.6.51-92-gfd49ddc1e5f8
  Good: v6.6.51
  BAD:  v6.6.51-92-gfd49ddc1e5f8

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build log:
--------
arch/s390/kernel/setup.c: In function 'reserve_lowcore':
arch/s390/kernel/setup.c:748:31: error: implicit declaration of
function 'get_lowcore'; did you mean 'setup_lowcore'?
[-Werror=implicit-function-declaration]
  748 |         void *lowcore_start = get_lowcore();
      |                               ^~~~~~~~~~~
      |                               setup_lowcore
arch/s390/kernel/setup.c:748:31: warning: initialization of 'void *'
from 'int' makes pointer from integer without a cast
[-Wint-conversion]
arch/s390/kernel/setup.c:752:21: error: '__identity_base' undeclared
(first use in this function)
  752 |         if ((void *)__identity_base < lowcore_end) {
      |                     ^~~~~~~~~~~~~~~
arch/s390/kernel/setup.c:752:21: note: each undeclared identifier is
reported only once for each function it appears in
In file included from include/linux/bits.h:21,
                 from arch/s390/include/asm/ptrace.h:10,
                 from arch/s390/include/asm/lowcore.h:13,
                 from arch/s390/include/asm/current.h:13,
                 from include/linux/sched.h:12,
                 from arch/s390/kernel/setup.c:21:
include/linux/minmax.h:31:9: error: first argument to
'__builtin_choose_expr' not a constant
   31 |
__builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),
 \
      |         ^~~~~~~~~~~~~~~~~~~~~

Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.51-92-gfd49ddc1e5f8/testrun/25153617/suite/build/test/gcc-13-defconfig/log
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9YUHx7PsQwr4lBdvjITAfP9Pp/

Build failed comparison:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.51-92-gfd49ddc1e5f8/testrun/25153617/suite/build/test/gcc-13-defconfig/history/

metadata:
----
  git describe: v6.6.51-92-gfd49ddc1e5f8
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: fd49ddc1e5f8121355db23e04b94f6df460a5051
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9YUHx7PsQwr4lBdvjITAfP9Pp/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9YUHx7PsQwr4lBdvjITAfP9Pp/
  toolchain: gcc-13, gcc-8 and clang-19
  config: defconfig
  arch: s390

Steps to reproduce:
---------
 - # tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

