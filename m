Return-Path: <stable+bounces-57973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510039267E4
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 20:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4CC8B24CEE
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 18:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174A418735A;
	Wed,  3 Jul 2024 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRCidM4S"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397A7187353
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030328; cv=none; b=jDSCIaeDl/+D4rih+dzpc44zM+uBoe5V5vDKlIvb2a3Ewe8rEq5VN2m+z8tt9h/h31k3WpFj+SOCUEaqYcqvEYuwRh4MzS0tSuexOtzAiy9fFKbDxuuMeXHgnYxJxHEv1zScObjARasFHt2GxyizMD5EKPNermE7SVLmI9Q6U+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030328; c=relaxed/simple;
	bh=fPhCmgnaiDZl2A6WXQkFrJg4shudkED3sjVTlU32HrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XE5xQgb663A3dtpb5D20lnuQLZV9I2e2yNy3luUYbiQdZ5RChsfGm+UyROXZsdE4U3oYijzD+xm5W3nFZEEccZRv9C8P5FLDX+HIYxa4hmYTjRzXg9EYUOPueDj1v2Bqjzfy/MyQHmIqhxlE2rJRtQPNsASP1w4IhfRJZE+WnYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GRCidM4S; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48f3e704576so2247463137.0
        for <stable@vger.kernel.org>; Wed, 03 Jul 2024 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720030326; x=1720635126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mr6GiDtRMzhlcU7TEUxy1mdYCuFY8dTCGfwcOk7GP/c=;
        b=GRCidM4SeL7pYPlPyfabz/S6snuxq8hRjBBi8aHFy4JrXWcjOiRvUgctFLSzR5yEtv
         w1b2YuMUlYjJ3/fvx2oAsiSkzOMftpU61bt1vFkdER8z7H2+J81mgYNiS9eI287dk6mJ
         2FPrumA7VOWtdq4O94kYmRJsnskJfuOSIFv9eVIvdgZBjtHnopLshbmuoXbS8iH7/40Q
         dNDQHHIP+9l1v4H5wpHktVjP6gknhMWTp9Sd1DJif3Kgzir96ccWc/TV+Cb2gXgd/YJn
         787T4U1plp4RuEaM1S1PSyZkEzKjuItdl1w2US01DwEYlnlClWJpS7+rNXSaEqR/EQFi
         xraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030326; x=1720635126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mr6GiDtRMzhlcU7TEUxy1mdYCuFY8dTCGfwcOk7GP/c=;
        b=YKFESKtuaDLY7u/Lr0dInf1xiRyTbx+8SON9Doz/ocz7q1ZNaR3+1+SwAqena6f6mw
         JqOjfueq+heA9yPZYqF1rLyuxNm4n/hNzpuODiMrMBAUP8UWbIpguri3eyqPX86UXU5o
         /F3kClIUp6bGKnNiFZ1+B9e/wpLJrAB8ZJ4EljTN2rnPIH4jk8V+eE3ObUhSZw46WuFG
         FuzIZlnh7Vsa8G3F5buxMixbIiuvJTIHIpfB0Xe5qjT3Yo8cb6i8hg51IA7EVk58Brsq
         dPNSJGQTQSkXYHxwdcJKnewEgKuqWHJE1kUimeCU8syZ4myVunusNr/g7xdvnrvplHEf
         1ycg==
X-Gm-Message-State: AOJu0Yx6giotS0JstM1vR3rsjvNj0w6pgYdx4L/0OdACp7rvOmItDJjp
	mhXNOoRDDA4DPT/rAgwHnMe5W0M+fW1ik569IJO9wjw+IdK2ZFWSYmb9pZv4Y5/nNFb1C2R/iDs
	gx8Rx1vkFnzQt85wNOmYeXMQL4yCPYEfIwuiPm7HG6cbjxW4SAacnAw==
X-Google-Smtp-Source: AGHT+IGGt6bUpa80iJhaddgtZTkRvaBxVD+WY5qQ+Y/sKswvE4heTrLyOi9GRMVgEOs9n0cRyAzD/Roo17eqbs8PbQ4=
X-Received: by 2002:a67:f2d8:0:b0:48f:a858:2b54 with SMTP id
 ada2fe7eead31-48faf140919mr13826176137.26.1720030325982; Wed, 03 Jul 2024
 11:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703102904.170852981@linuxfoundation.org>
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Jul 2024 23:41:54 +0530
Message-ID: <CA+G9fYu8dpsNyqPk53wyq1ZTKmCJ3gUb6JBjH3OM9p2pqL_E-A@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/290] 5.10.221-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 16:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.221 release.
> There are 290 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jul 2024 10:28:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.221-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The s390 builds failed on stable-rc 5.10.221-rc1 due to following build
warnings / errors. These errors were also noticed on stable-rc 5.4.279-rc1.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on s390:

  - gcc-12-defconfig
  - clang-18-defconfig
  - gcc-8-defconfig-fe40093d


Build log:
------
arch/s390/include/asm/cpacf.h: In function 'cpacf_km':
arch/s390/include/asm/cpacf.h:320:29: error: storage size of 'd' isn't known
  320 |         union register_pair d, s;
      |                             ^
arch/s390/include/asm/cpacf.h:320:32: error: storage size of 's' isn't known
  320 |         union register_pair d, s;
      |                                ^
arch/s390/include/asm/cpacf.h:320:32: warning: unused variable 's'
[-Wunused-variable]
arch/s390/include/asm/cpacf.h:320:29: warning: unused variable 'd'
[-Wunused-variable]
  320 |         union register_pair d, s;
      |                             ^               ^

Build log link,
 [1] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.220-291-g4d0fada143ed/testrun/24509787/suite/build/test/gcc-12-defconfig/log


Build config url:
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ijXjGemFUwKSWd98LvKtd4i3uF/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2ijXjGemFUwKSWd98LvKtd4i3uF/

metadata:
  git_describe: v5.10.220-291-g4d0fada143ed
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_short_log: 4d0fada143ed ("Linux 5.10.221-rc1")
  toolchain: gcc-12
  arch: s390

--
Linaro LKFT
https://lkft.linaro.org

