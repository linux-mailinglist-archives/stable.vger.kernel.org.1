Return-Path: <stable+bounces-75634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF44973817
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 14:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B03F1B2723D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DAD18CBE0;
	Tue, 10 Sep 2024 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FL1Y99ET"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC2318F2DB
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972903; cv=none; b=AWRWQrvMaNADx3tzEGZ/HGOr4hh8BYEhk/XR5hsvWFh0pbIzr9RKPK8OMZGF8A22RuFPbhxHYHK6oExW5a+vZ+9tPX5ik3GzedVsO0RXN6IldMO8MqCant5cw0Sm/P+6oDMo/wT7JiTE4Cm9bQ1lNDq/BvaTtlCwDjuDNfY4rW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972903; c=relaxed/simple;
	bh=SxAkh8uwuAT5ozfDLH78xfu4BSQGaw3OBgkizGvRl1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9phPzc4QI3BpF1WYZQgjocZNglMrlrcKMQ9DN34T3i2swSIanEsKEDKp17hC8TYW2V9TXUHQfv3hyM0TwIdNvOMMepjDxmiRFWKeTuPDXR1gHXV3QBLQocdTMV01E0qC4I3t3N6cObIuVTaqn/jtdDZ3VE2VMbZeEH8GRFC6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FL1Y99ET; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5012813249cso1044392e0c.2
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 05:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725972901; x=1726577701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VKyjedl/ddqMl2FSPgpGenJy9ELX4V7Sr7TvuPEW+L8=;
        b=FL1Y99ETj94lbEXFmCGW0XZlPfSkzc/bQs52y+09fonLHjt2A07ugzcNKjqK1yYncl
         nCPFN9zF6kWawploi5Skc3fuwyIJyDO+F3A3sTJadpGl7dwE2xmbolmLiD9Q57/nSjif
         O4BjVPJk3qUBZ7MXVTX7frKSF/QaHxz0fFL5i+DQGslDaI29tVeBzCTUDiqf0cp0NGjG
         FtmT0m0FAHiyLLenz5TOO2F93UpZ626Qo+n/h5pmVw8ntZ4GPh1Z86IzNAUSUKJ7Qzys
         lOg5Ox3YCXiGv/4TF/0j8h4qnpm5TU88K8zZUhPFUjr8Y/GyHyvuOvyX9bNa9rpWfkaY
         cs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725972901; x=1726577701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKyjedl/ddqMl2FSPgpGenJy9ELX4V7Sr7TvuPEW+L8=;
        b=byC9QIw3r6m8cn3TfderTDQXhAEYgnxX52aCuYS/1Z7xO3IqlUH7uNG/3uPQu9ncw8
         BXrUIhpZRRCsY+7RJ5zzqtyANAgOBUd3NfcUwuEFdSyghzqsdVv555eDJaiRjYLrUR0Y
         Q3CB0McBkpvK88rOb91OL8Is2Y8VNHc5uW7Ei0m2avCZEHzaTMb+hWgmrkxN5dggHQ0C
         zjwpiA0JERXFxVMvBFMVqMQc+JvxsrvcrXv5zEAvwPSjX0pLsyY5ma//8cpho38SdEut
         68x/D8chN5TOe+zrY9rh7k2rFZy8i/JBWdrnmcERpVaH863HzlEpqUTQZmWZE9CswdrJ
         noMw==
X-Gm-Message-State: AOJu0YyPMU7IE7rtaNFmnfCPMV6dT24LIpMgpEtVzEgkgoiiWERaZdZQ
	VyLRSavxoVlmMPU7glTof7T0J/k1xOdMySjQPX9OxvufxPdcMG9h9bT9ECAHzKktq2h+Fj5YatO
	WyxeWaWxqnNImuv2oRPqy64xaBlNveZPQrC4EOQ==
X-Google-Smtp-Source: AGHT+IE9Y+kfYN5IvRsvDOEmVUj0DoGGOvJjlae15nGIZcPP3XpU1vBEgCqkifEGq8ljbZO+kQainr+wo6QGkyfH4b4=
X-Received: by 2002:a05:6122:ca7:b0:4ed:12b:ec99 with SMTP id
 71dfb90a1353d-50207bfb04bmr11342577e0c.3.1725972900980; Tue, 10 Sep 2024
 05:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910092557.876094467@linuxfoundation.org>
In-Reply-To: <20240910092557.876094467@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 10 Sep 2024 18:24:49 +0530
Message-ID: <CA+G9fYufdd0MGMO1NbXgJwN1+wPHB24_Nrok9TMX=fYKXaxXLA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/192] 6.1.110-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Peter Zijlstra <peterz@infradead.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 15:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.110 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.110-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The SuperH defconfig builds failed due to following build warnings / errors
on the stable-rc linux-6.1.y.

* SuperH, build
  - gcc-8-defconfig
  - gcc-11-shx3_defconfig
  - gcc-11-defconfig
  - gcc-8-shx3_defconfig

Build log:
--------
In file included from  include/linux/mm.h:29,
                 from  arch/sh/kernel/asm-offsets.c:14:
 include/linux/pgtable.h: In function 'pmdp_get_lockless':
 include/linux/pgtable.h:379:20: error: 'pmd_t' has no member named 'pmd_low'
  379 |                 pmd.pmd_low = pmdp->pmd_low;
      |                    ^
 include/linux/pgtable.h:379:35: error: 'pmd_t' has no member named 'pmd_low'
  379 |                 pmd.pmd_low = pmdp->pmd_low;
      |                                   ^~


Metadata:
--------
  build_name: gcc-11-defconfig
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lsNsLYIfqdkNQOzLLZO4lq580E/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lsNsLYIfqdkNQOzLLZO4lq580E/
  git_describe: v6.1.109-193-gb220bb28da0f
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: b220bb28da0f6a629a0d88be3f8e57ea5025c728
  compiler: {'name': 'sh4-linux-gnu-gcc', 'version': '11',
'version_full': 'sh4-linux-gnu-gcc (Debian 11.4.0-5) 11.4.0'}

Steps to reproduce:
-------
 - # tuxmake --runtime podman --target-arch sh --toolchain gcc-11
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

