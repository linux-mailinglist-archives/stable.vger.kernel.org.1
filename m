Return-Path: <stable+bounces-126572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A61EA70496
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 16:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02FE166935
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 15:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4951025B67E;
	Tue, 25 Mar 2025 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJ2c7OP2"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FE913D8A0
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915277; cv=none; b=YNjFzYV9iaQSV/xZw0In5b3O90JJxs6E4wMF6t0ynk0SQBT0Zs8+9TaZWEGle2wGNB6nOW1SbJcGZqg/1W3xI5VIQCGh9hoUJ8UTSUwpiN9aj/ugt5EB2wkxKnfefd7TB7TWw5YOEe845H7wyN3oDRwJ7aEQbJOuYWybBpdtoAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915277; c=relaxed/simple;
	bh=iSmodtdY7Dchcz1A/sUPS+H3SHiLLQyywM4beAv33u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edZPr4Iw27Z/A7BlS75+b80bSL1etNpWWb7pZNFKdxVhq7p6Atj6YwaMKHHRjWBbEHrzgsIUsuv3wBQYu3WrMJ5wBeD6P3wjtG2g/l/7ogI2M1n2x5xGOrxVu3Bwljk1J3Rq0pQdTOY2pnOAeBNw9S2/1bEGZZAQEcZgmpMqExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lJ2c7OP2; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5259331b31eso2635174e0c.0
        for <stable@vger.kernel.org>; Tue, 25 Mar 2025 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742915274; x=1743520074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ASRZZn4DjAVCiGVwyErb4eVcqvprss3kx2mpnoqQ/Aw=;
        b=lJ2c7OP2ctgy0sc4pykNStYO3q/NHZCwjiKUv8QE7ho11GEihMp+VE05S2NYUJmUJb
         jM4U3gtcEogTOOSekGOjc5BlpmuF47WJqVR9d3r/9HeJgxW+yap4dEDtdMcoD766bCD9
         kF0R5PjdemnYDPc6/fKm4++DrneK0PHlcs6BKRwu03DEDVONg9l/QK0nk/No1op2BaM9
         Owfget9il+fzpy3iTpkw4x35Lnz12id8pVHkNnkvp34+ftBAX9kK27njAfra5KRjfaGY
         V+EQbo72jEYebQHN2MpsRL8UuiHMKgzPFTWMPBmdN9Hykk6lhmXxdcEl3xCMUZ42cosM
         pjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742915274; x=1743520074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASRZZn4DjAVCiGVwyErb4eVcqvprss3kx2mpnoqQ/Aw=;
        b=v0HzHuRbhKsZcuCY6yhRngH6PmXpf5XuofazjK9m8hj4E98gYY3TScJSOerk7K9kXB
         GZSYWQRG0V8ZLgvaKjP/Vw7J1KY4/lQlVO3Z9bAIPdb2IZ5cndpSl45laosCt/E6S9/H
         yIb3ZRQpzkIdndajQ+TsbUHFANzhR1+5Anbfbsf30aXvb7YEgLl8HMRZyUprY1GxA+y+
         uN1adL3Zx0r8W77NWhV3tG3BckgpYD4htWjPnoTDom3FMXmsw4ylP4Sx4KX5mrBfTAQY
         KCz2Ays4/zzKhQUKl2vpmhgjaaR88GIgqrtCiQFkbBfZZVXrrKTdc/iXgJnWtmAsPRGe
         Y+Jg==
X-Gm-Message-State: AOJu0YxWtxbRCdizJpxNvnNMqxWyGS1Da2HDKXLsTKBuFL4J+K8M4E2Q
	Pqk5Mj6r18mgP0nplc9Te47/26H7yBAs+JMHHjZv+46ZmztadzpCgLmiqVcR4YvnGgptNXd5i1Y
	K2s9BUziJROvacRUYae0XBP0MJUZQoxFPX+qOnQ==
X-Gm-Gg: ASbGncuZC1gE5M5dS9EvoNqYNykuw2GaET1+MK6wZFe3T8qL4oJ6hh60yHKyDp/pInd
	XyHiWXBMtU9wNfyIw4CiAbC7P1GAgLVCEM/3WKaK3fwhOpcwHsoqwIS5K1IHIW2jdH1U65/dcEI
	mZ0N5X2JVLMR396vLxu/TBokBGvLvE0+cjF5puV8Ha/ufjEyqyuZFpWGH0HTM=
X-Google-Smtp-Source: AGHT+IGJxNNn58Pr6BXkc8yTC7dt3Dz8oYa2jVHYnOw8DdFwyMT+9nGnrZ/TQ+Sepc3obyBo9xvaY36PFzfQAXxFVmo=
X-Received: by 2002:a05:6122:2810:b0:520:60c2:3fb with SMTP id
 71dfb90a1353d-525a80d5eb4mr10912049e0c.0.1742915273945; Tue, 25 Mar 2025
 08:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325122144.259256924@linuxfoundation.org>
In-Reply-To: <20250325122144.259256924@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 25 Mar 2025 20:37:42 +0530
X-Gm-Features: AQ5f1Jo5lbttZtSAb6LnZgDq3AuZotqFT2rixgG9lx0L7Z-hkj4vcw5915tDF-M
Message-ID: <CA+G9fYvWau1nC8wmpWkxG8gWPaRMP9pbkh2eNsAZoUMeRPgzqA@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/77] 6.6.85-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 18:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.85 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Mar 2025 12:21:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.85-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Regressions on arm64 rk3399 dtb builds failed with gcc-13 the
stable-rc 6.6.85-rc1

First seen on the v6.6.83-245-gc1fb5424adea
 Good: v6.6.84
 Bad: 6.6.85-rc1

* arm64, build
  - gcc-13-defconfig

Regression Analysis:
 - New regression? yes
 - Reproducibility? Yes


Build regression: arm64 dtb rockchip non-existent node or label "vcca_0v9"
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
arch/arm64/boot/dts/rockchip/rk3399.dtsi:221.23-266.4: ERROR
(phandle_references):
/pcie@f8000000: Reference to non-existent node or label "vcca_0v9"

  also defined at arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi:659.8-669.3

## Source
* Kernel version: 6.6.85-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: c1fb5424adea53e3a4d8b2018c5e974f7772af29
* Git describe: v6.6.83-245-gc1fb5424adea
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-245-gc1fb5424adea/

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-245-gc1fb5424adea/testrun/27760755/suite/build/test/gcc-13-defconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-245-gc1fb5424adea/testrun/27763720/suite/build/test/gcc-13-defconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-245-gc1fb5424adea/testrun/27760755/suite/build/test/gcc-13-defconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uoHmBcVLd60GQ0SVHWAaZRZfNd/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2uoHmBcVLd60GQ0SVHWAaZRZfNd/config

## Steps to reproduce
 - # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig defconfig


--
Linaro LKFT
https://lkft.linaro.org

