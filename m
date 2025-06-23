Return-Path: <stable+bounces-156174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D61AE4E76
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7282F189CBC3
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292C81EE019;
	Mon, 23 Jun 2025 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tudyQ3mJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A190217668
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712759; cv=none; b=t4AZ5u6RCBglvFmyBGG7PmA5V8DWdcJbE7j0dmw8i1DZDpOmW+Gj4FaYsyrgxeswxt+T/g4rMq2v2VIh3PQeH7NcFEcZQK1y9lu18W8tsBiwNKJefcAncGzFxnwTbevMW8KnhLJT+pmhS4Boo1oB8CNXE8x+47bCpBGETbiWTLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712759; c=relaxed/simple;
	bh=QJJddcvfb4kRHAKMSa/fFV0iFteug7n2v+ZY6h+PamU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INOen7rOYUJrJnn8elFjy9zRD5GBH1rhMNERWAdxVZsO/2o90JwLiKacN/FVAqcfa9Ebw05JZfto3o5gb0j6sp0K+27+v7PVoBvvpjTbHkIwgHqE2dG0OHYXTNDqdDn6Dy32bx21dptLfI8UUPQJ5yKF8nehSQ4JrVSw61HjZFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tudyQ3mJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313a188174fso3605329a91.1
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750712757; x=1751317557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pHX9CXX2jp+sc88nWffGW5R0z0vn6Lx1vW0giPA6MfM=;
        b=tudyQ3mJLPhvsewTacLYoZly8DLPPbFYP0Qdext5ZuA04IswIA1Q6EfXhu3HaoiPbg
         7Nw7WrZrGDuZBbs6cSNwfNEcB3XNQtPoatMYo0eSyJV3Z0CHD1YBLmfhk1oC32rkcdyD
         HhmNuDLyHc+wooSrrDqEkW9JfRsLem3aGVTIiqA5wrLmb2o7btZWydVy/17CBxWnYnor
         TvkEwc9WcYOshzgVC2xGhQ4NKd+RYJ3SY3mv9zPDN54xTM9qTMwgDnGZm1g59ov6xNM7
         ZUMZkO4zcTFEYMN3f1EqdMDubip3qqc7GD5Uj1PyTSsbs2CcGG5vcdbWawnhlB0CZr2X
         Fm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750712757; x=1751317557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHX9CXX2jp+sc88nWffGW5R0z0vn6Lx1vW0giPA6MfM=;
        b=QNVxo5NzPpfPEgSTwMgAHw9KJ2CiWe+C/Dbp7/Uv/mpmBkSnuZhnpZ9Vv6lkBNRLDf
         v0mB7OgLu0DSPgaF+Qmv9oRlsgeYbfTwMbPEU8E95WQRhQ9oWxwTMYtZMUQduA4rM4Iu
         SKjhOZZ/bl30jYwwrrQ8UM/7G0B8mCeww2zit1fJJIem0kFIfUKSrcM/FDwZlvXPpZrJ
         IEdSLcIr7wwqALAcQxTHfb15iyO6eq6GVDpOXoYQaRgzF7bRBN+KH0KsJCzh/bA41LLz
         +4nRZ2VEeWgH9fpyPVOVJ2GhXbXVcgoFW39ngcHG2CZ6MGMxPpJLsCwzEgWPkKGj1YaI
         nHCg==
X-Gm-Message-State: AOJu0YyUW/I5uVt4Nvq9gRDj1e+8iboJwmPz45aBLnX89deDfcmXZIqA
	W5XjaVbPg7IKurJBcOwCN5C/TvmFxs3g9TqTu9Xi+dUZgrKmstFLFRwmqVcUDZzlGjOUdYCWMPy
	vVJuazU88BhnlDN6ZEfhFMgaibP3AYtzMeR/OeT706Q==
X-Gm-Gg: ASbGnctmofUVV4Hm5yCRMmllZxiT5GMCdGPz9NKPWsYn4pUR37LAsEHurYBRCnlVPvS
	EY5b8R3gKlKd4gmBgAuM1+yN4b7DTNDu0XqMnRWg9jsA/cq0kI5PIzThSXTjuilYhYCeTlURoYL
	aB6/2UaVtmTxqgBZfZKKAxhidDfSNkILntoRK+scvrZdUcugLfq5hXNo0HsQ3M70ZqmbV5vRrXX
	7uD
X-Google-Smtp-Source: AGHT+IGluWyWYchA0SWpbfOmsSY/NlAvWI3AwaiTmC73117pQczqsC1IpuBOq5vhAW9oC3+ZWrshJwcLG3IOLcWQkbE=
X-Received: by 2002:a17:90b:5586:b0:312:e73e:cded with SMTP id
 98e67ed59e1d1-315ccd7261emr1387255a91.16.1750712757357; Mon, 23 Jun 2025
 14:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617152451.485330293@linuxfoundation.org>
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 24 Jun 2025 02:35:45 +0530
X-Gm-Features: Ac12FXwPGqqVTvOIk9rFpxKVJdoOnBMvXrD0aOMgF5kEpGyYgKGtnJCwPlmxBRU
Message-ID: <CA+G9fYtUjjrzghRQVUJ5ct9zNK2ROcRVOizpT-ZyjzZGRSUz1Q@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/780] 6.15.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Jun 2025 at 20:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.3 release.
> There are 780 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Jun 2025 15:22:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on s390 allmodconfig builds with gcc-13 and clang-20 failed on
the Linux stable-rc 6.15.4-rc1.

Regressions found on s390
* s390, build
  - clang-20-allmodconfig
  - gcc-13-allmodconfig

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: stable-rc 6.15.4-rc1 s390 allmodconfig
sdhci-esdhc-imx.c 'sdhc_esdhc_tuning_restore' defined but not used

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build errors
drivers/mmc/host/sdhci-esdhc-imx.c:1608:13: error:
'sdhc_esdhc_tuning_restore' defined but not used
[-Werror=unused-function]
 1608 | static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/sdhci-esdhc-imx.c:1586:13: error:
'sdhc_esdhc_tuning_save' defined but not used
[-Werror=unused-function]
 1586 | static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
      |             ^~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

## Source
* Kernel version: 6.15.4-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: de19bfa00d6f93fdcd38a5c088466e093af981f2
* Git describe: v6.15.3-593-gde19bfa00d6f
* Project details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.15.y/v6.15.3-593-gde19bfa00d6f/
* Architectures: s390
* Toolchains: gcc-13, clang-20
* Kconfigs: allmodconfig

## Build s390
* Build log: https://qa-reports.linaro.org/api/testruns/28840725/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.15.y/v6.15.3-593-gde19bfa00d6f/build/gcc-13-allmodconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2yuYQdocMC494e6F9GTIAK16EAg/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2yuYQdocMC494e6F9GTIAK16EAg/config

## Steps to reproduce
  - tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig allmodconfig

--
Linaro LKFT
https://lkft.linaro.org

