Return-Path: <stable+bounces-83148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4D6995FB1
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 08:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B515281BEB
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 06:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B678416F282;
	Wed,  9 Oct 2024 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIf2J41x"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4540849
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454972; cv=none; b=aVCraGpLTRufJmQvkagmY027dVMGMagtbmffHembzkcAU1PtB954UUx2SvmRZnP3+Yca6eZ66D58/WSna2yjMVmRg/UrOMmLF2z9A47eCyMBEXYfB9DDjYbubnKaRGYgTcOopw4Yya9Lqumd62TyWyumsI+YCuy8DMjyy0huwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454972; c=relaxed/simple;
	bh=70XTPMcMP2KIi3tLbcqxxoESA7Ui9Epoi5qeJRsiekQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOIw2+TgKZnMS6WCyRW1xzgaQX85LF7+UUSnB3dqybQ+YPa6mIe42w/Q+8xWnkZgm5PjscVSmAWE6iOZ80whPJJgfQGztgYjvYJAjGZXgwygCiPDVcDRLrUr/rmhrSnZ4BE1c3vJnkkgcp3csLXHfBoeDJxvGh61T3jkeWMn/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EIf2J41x; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4a3c11892ecso2126401137.2
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 23:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728454970; x=1729059770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RopoYYi2hlVFFuKNg1HoN6+xeEu++B4y+INQW7poSdo=;
        b=EIf2J41x4NGT+uOTYTdKiGZeGO+VSJMRcnugn/JE1ft8HpH2g0sSp1LDRP1DmgxJpD
         CpqyMYX3znbjLppgtATDVA+Ow+NTWDV1I0jGt0mN67tmI9WnRg1Fx5HrO0T0W8J7VzoO
         dn0I6dxHE44YrxdKaFu2/S4YENdsolPW1FT3GpOKYYu9ckYcCBRVcpOIGn6KFuYzbH83
         XhRg6Pc3jssO6elX0jq1m7/yHXbRGjVEozbYtUk839Wwn56FoFxFssCIb8xGEfCYp/JQ
         3HSLeGMJ+05MfsVtA7RsJIsJDcPuehP03ohMgQWi1IrdluXGBM1F2dF/iMMCOsQTDQh2
         2Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728454970; x=1729059770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RopoYYi2hlVFFuKNg1HoN6+xeEu++B4y+INQW7poSdo=;
        b=GaqLU5TfTCcILpQkhG/w9s16KYSbCjD76WrqBfFYwPfNhJQbptnBOIhqtoXV2qoNGP
         lN0zl0LcHZWm4NAkvytA8Ki7ndoLrGgW7TY5Q+jNMHuRg+VlqjELh7JLGBdZL74gbvwm
         rkt40brOloDtEgOs9malZ1UHhtmz4nKt8lspCCa4pFW00FJvDmWT4Oyfqs/M4upguMCh
         Cz/Se+EgCvgSmkdKChqsLh2vUQx93KO4jUxFMvDMMW77183ffh9boLwWIbLqPaEaD8am
         t1VUvJ8OY1KKfzUYLxgWafEaQuzd3hUoI29TPfoYgWwXBDmHs02GQ+zqZKBKGPNVoaL2
         41QA==
X-Gm-Message-State: AOJu0YwhY2+OlkUw+jzloE5Nhi5KUFPGo2JtClhJCs6aF+MWp/369jF8
	An5uEVpJ6u0wTiYCX//S9e0znT9Zutg98HAVoevuMJnLY+EZaa7SRPBS0k1+ePlR2cWskz4ofLu
	xwyPr0BVjvAM0PEjR9bWZqglTWeY/DQ9YHHAzSg==
X-Google-Smtp-Source: AGHT+IEAUqkOgdIyJ+oc3tAQuAWemtC8mERexWMYrIgvafEvJqHf5S3kt2FSt5RKqD7Xtn9v+WxuHwBHNNsPLb6nxAw=
X-Received: by 2002:a05:6102:c48:b0:4a3:e55d:eff5 with SMTP id
 ada2fe7eead31-4a448d66a20mr868134137.9.1728454970015; Tue, 08 Oct 2024
 23:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008115648.280954295@linuxfoundation.org>
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Oct 2024 11:52:38 +0530
Message-ID: <CA+G9fYv=Ld-YCpWaV2X=ErcyfEQC8DA1jy+cOhmviEHGS9mh-w@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/482] 6.10.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 17:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.14 release.
> There are 482 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.14-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The LTP syscalls fanotify22 test failed  (broken).
This regression is noticed on linux.6.10.y, linux.6.11.y and linux.6.6.y.

We are bisecting this issue.

 ltp-syscalls
  - fanotify22

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log,
-----------
fanotify16.c:751[  452.527701] EXT4-fs error (device loop0):
__ext4_remount:6522: comm fanotify22: Abort forced by user
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1106: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.47.1 (20-May-2024)
tst_test.c:1120: TINFO: Mounting /dev/loop0 to
/scratch/ltp-6nPLv2EGcV/LTP_fanbDvQcT/test_mnt fstyp=ext4 flags=0
tst_test.c:1733: TINFO: LTP version: 20240524
tst_test.c:1617: TINFO: Timeout per run is 0h 02m 30s
fanotify.h:122: TINFO: fid(test_mnt/internal_dir/bad_dir) =
6bd2dab9.86fe4716.7e82.df82837f.0...
fanotify.h:122: TINFO: fid(test_mnt/internal_dir) =
6bd2dab9.86fe4716.7e81.beaa198d.0...
fanotify22.c:278: TINFO: Umounting
/scratch/ltp-6nPLv2EGcV/LTP_fanbDvQcT/test_mnt
debugfs 1.47.1 (20-May-2024)
debugfs 1.47.1 (20-May-2024)
fanotify22.c:281: TINFO: Mounting /dev/loop0 to
/scratch/ltp-6nPLv2EGcV/LTP_fanbDvQcT/test_mnt fstyp=ext4 flags=0
fanotify.h:122: TINFO: fid(test_mnt) = 6bd2dab9.86fe4716.2.0.0...
fanotify22.c:59: TINFO: Mounting /dev/loop0 to
/scratch/ltp-6nPLv2EGcV/LTP_fanbDvQcT/test_mnt fstyp=ext4 flags=21
fanotify22.c:59: TBROK: mount(/dev/loop0, test_mnt, ext4, 33,
0x5659a1d5) failed: EROFS (30)

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=124e7c61deb2

Summary:
passed   0
failed   0
broken   1

--
Linaro LKFT
https://lkft.linaro.org

