Return-Path: <stable+bounces-83149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5568A995FBC
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 08:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D186E1F21BE0
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 06:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9FB17B50E;
	Wed,  9 Oct 2024 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ec4qkpFR"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA217B4E5
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455074; cv=none; b=hsVzIhw7pkM3wYL7/libbMVisGAMwVlmwdMcCwroLeRN4yXMG/HSvw49JhrYQ9bk0fRazL0RsG6mRx7REbhUIOErF4A7RwxmeT479A4TQNIFnqU+cMe/nGurq8Q0j2XvBT2Yyf+W6Koe8GDbktcTi1wmzKZLdzuDYYPbiDsb7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455074; c=relaxed/simple;
	bh=qWz892YeKoJrS4nKN2pE68Uc5xhtWRYUGwhxmzGq5Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7o/1LAvJeHCAyfybCB9urN3lpXUsSAMiVFaUmrJJTOU4MbLeSiiWSExFWe8l/+DWC5D5NgUEJm85JbDxyeYydto/mgt379Ovx8CSnBiof8Ci2CYe8wmCN7iaLZaECT5zo7fm9HUTSDAjZZXKta8QReXFTR450G+ASRFFy3loQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ec4qkpFR; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-50a87472832so1717314e0c.3
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728455070; x=1729059870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1K1fYPYOX1vHU5cmuw7GclgV31ArXw6XaL9jukhNp04=;
        b=Ec4qkpFRtXcH8OOWUzquitbCzMJb+BiMIS/sEH0UhwtbYGArpm/mmTHZcjevuvaEnF
         hJyyQMl0l/0H4kYjIxdDGbZa0DBUzj2ucUIZ24uvwCpuAUwaEq7xWUSjPEJLBAbpAWgu
         NQH3tnvJbYn7pa6RJUZ6j/x3koIa7XP74ioQNlDZ8T9w030ysJyJLDSJZVXQgS3PBCuX
         6tOUWXAfef0S3PyKTNOzQuJZ8C9W67P5SK3XF/GQY9T3pUECBDqspPi8lu4RdTh7/C6k
         3mDcLAlysoZYsgoom26UBFG1pMT0oV+qmnUw5llV3LB3KQscdw5ansNM7/qaZHuAu9cd
         K0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728455070; x=1729059870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1K1fYPYOX1vHU5cmuw7GclgV31ArXw6XaL9jukhNp04=;
        b=vsydM+zoZ3HpPL/brGGzgpe6BIia7EyEvZ/0EQbZWxo7BAbMdlUCOZtF9yd9vzyot1
         W9yGFzdewQwztu8KqCCGdm8sbnB5B6yfwU1sDpHg/wpWwPIyj2cV1NyPWIVdcOuhMVhN
         YOi4O4a9J3yqBc6GT0iDZtQKRM1flWIVP9PT1yk7uDaTS44GsRAtlVmNzdDQPLbW/2QA
         BZ4mSU34ObPLuF5X50JjLSf27qg36I/BcU5PYz89flTw8JvyWxQEZc9RMsxRBsCBKMeG
         8yRzPODhOTvJX6NlhYH9/WrmpAGpwGR+9drRLxw8rGbBXXCoFBDkJcYgZCuQH7qfGXEz
         pkYA==
X-Gm-Message-State: AOJu0Yx6X4Do2BRKnWl07HCjEt2TygNZB6CzafelTJJCrva7Xq9YHM6x
	nl5xG2Skf/CCDICYo03BIPPICN2pzWs/dkSD8+ytTmtHK4R+Ty9i7YP/UOmH+Zay6RtCEsdYHHt
	7kalQgSSEtes3tV7GIP33/SGmgsseQOvY4GIACw==
X-Google-Smtp-Source: AGHT+IGGefmdK2gVfzZLdksZc4v9TSdXPzCoi8o8H3xFV8DF12srdbmwB1J3Xnt0YOqBOodOsk3MJVh5Bx0b9g7lKN0=
X-Received: by 2002:a05:6122:3c54:b0:507:9137:f5a7 with SMTP id
 71dfb90a1353d-50cf09d0fc4mr641100e0c.5.1728455070465; Tue, 08 Oct 2024
 23:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008115629.309157387@linuxfoundation.org>
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Oct 2024 11:54:18 +0530
Message-ID: <CA+G9fYttfwQ7s6P2RLc6QA81_DYi5WrpWtiM4gK7_RDG69=6AA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/386] 6.6.55-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 18:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.55 release.
> There are 386 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.55-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The LTP syscalls fanotify22 test failed  (broken).
This regression is noticed on linux.6.6.y, linux.6.10.y and linux.6.11.y.

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

