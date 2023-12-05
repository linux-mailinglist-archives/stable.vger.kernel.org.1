Return-Path: <stable+bounces-4717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092C0805A47
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 17:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77D31F2175D
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 16:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2201D584C7;
	Tue,  5 Dec 2023 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fn1nSC1A"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08E019B
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 08:49:01 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7bb4b7eb808so1973202241.3
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 08:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701794941; x=1702399741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YfqclM3ZkWiAXDbZmcjbBwB6xmJbMZCT4iOO/IexVc0=;
        b=fn1nSC1AhZaI/jDXiQ29B/j5H6DSsxhadFaNMyO+yYYxUdllanCvc+HFE+J0CjVYJA
         HJ74tcMFq7pixIc+i2+KSSUyrcXTBwBlDEXMo/gfk77G/9wYsGg2P9YUIotYBNq24CoD
         axeWez0VQ0bJow945POWHHyIn+jIJ/pRGFET+bafhmS7gTTDiRIkl1oiK4l+6v0VQB6y
         qa2vJnu+cxTGyJLXbp5s3W7Cf49THF8XP4ZW5sFF7yX4WSfZefUmL+lbr6yhaTgV8BRm
         KWRCIC6mlH175l1lYtmm5BlYm4DtczdNWzlMVHu6Hm1Wk1rK1SmXPmvNm9uQBMZkLxfb
         UP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701794941; x=1702399741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfqclM3ZkWiAXDbZmcjbBwB6xmJbMZCT4iOO/IexVc0=;
        b=atmd+DHEA//Gi6feKP0KcV5qSrbEtPASxkr14mf822YnGxKf4E8K6E2e7DDJJixXxe
         xfKxOFARlbJ4dAmvW9myPUiue03ahWM0J2SPdWk9iutoc/froOf6qJz5w63VnhE0Kv6o
         XuvZI6h32el97arcpokGbHn+ARk/Cq0lHOk0CVsl5NYgIigiLyt0dfcz2uqZo4r6fqb9
         AlvgWzjT4uJyBRzCyNLhQy5xoQXPnFEbOxehF5VQvoMUKyUqy5oSA0B9rdxWyZ7Fa17q
         o71zmSFdB2d30RUTCQCVJng9/ZFSqBfYLI94d2q7sG0MJ9MrGvvbMJr5pAG3cTW78onz
         UDLw==
X-Gm-Message-State: AOJu0YwJaunM454Iy+VWN/BbSUbFHcwEaehSIYNekzGrI1GUbzaVy3qq
	MiQtmzGSesBdEgiyy4jjjtoddmm7/tKiFxVU1Wk3yg==
X-Google-Smtp-Source: AGHT+IHus3uB7dNMpJ0cP1uy5kkamJOMFLF8zMXjR6WyF50uZ0U0xiaK7tFOWnFeBiVqsPbRDg47o04MaF15ciRegfc=
X-Received: by 2002:a05:6102:34e2:b0:462:c2e9:6dda with SMTP id
 bi2-20020a05610234e200b00462c2e96ddamr3198642vsb.31.1701794940837; Tue, 05
 Dec 2023 08:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205031519.853779502@linuxfoundation.org>
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 5 Dec 2023 22:18:49 +0530
Message-ID: <CA+G9fYs-XB29+aZ2kk9psA+MTo8PCh0owWgwGRiq8JK60CuUtg@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/67] 5.15.142-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	Gaurav Batra <gbatra@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Dec 2023 at 09:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.142 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Following powerpc build failures noticed.

* powerpc, build
  - clang-17-defconfig - FAILED
  - gcc-12-defconfig - FAILED
  - gcc-8-defconfig - FAILED

build error:
---
arch/powerpc/platforms/pseries/iommu.c: In function 'find_existing_ddw':
arch/powerpc/platforms/pseries/iommu.c:908:49: error: 'struct dma_win'
has no member named 'direct'
  908 |                         *direct_mapping = window->direct;
      |                                                 ^~

suspected commit:
powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping
for SR-IOV device
 [ Upstream commit 3bf983e4e93ce8e6d69e9d63f52a66ec0856672e ]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.141-68-gbff845be423f/testrun/21492943/suite/build/test/gcc-12-defconfig/details/
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.141-68-gbff845be423f/testrun/21492943/suite/build/test/gcc-12-defconfig/history/


--
Linaro LKFT
https://lkft.linaro.org

