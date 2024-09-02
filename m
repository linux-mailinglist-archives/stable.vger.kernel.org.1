Return-Path: <stable+bounces-72691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D4E96829C
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 11:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDB51C21DE2
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 09:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D40DF71;
	Mon,  2 Sep 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zu8xWofJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E88A18757D
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267671; cv=none; b=pzsnVnJhfKtW/nK3VuuymGnLcSZC1B3vlf9e2m9alQ4vSDtrvyz3Gi+65Y6c4uItHjwuZ4LYDfcAZqOuWz7uDan8VdVQgg3DbTPCQF6rPUrHZKxbY0SgilFGMsO4uByvXXfQYl+XndffH1uk9bLYphQMYMpmkTI6r4bbAG3RvSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267671; c=relaxed/simple;
	bh=UF/oNZ5SbgpZ4WIfaXfqh3OBB6cIqxui1RRnAIkH+PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbbryqHaFvl7t1JZheQOpLDrQqZl1827z1GJNLKZIkVRORfvC52oUB7zhXINBcxmp1Pk9p2dW8f65LYi+y3ljiF7CJqDP2+DhqFNhY5Vy4aNc5RKo/qfK0ukS/2c/7AOO8PX//2rCcuRiD4/IPFaVZhplz/QLR8vY8Gt3+w/Av0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zu8xWofJ; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-498cf14a848so1411523137.3
        for <stable@vger.kernel.org>; Mon, 02 Sep 2024 02:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725267669; x=1725872469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qqSh94kF96VerY0m3+ny14R8sqauQwh7BBb3bguK3jo=;
        b=Zu8xWofJASIFEOZC0HRN6C21QBC3rDmPK3KiMfJquClm31PtTEMPhooMXdzc2TwgZd
         i1TfR3FqMD9ZW4Ld15TA030GCXOK7hf6Uj0sv4PKHypTpsO+LcUpA16MQoF7k5njO2v3
         h7Bkr24+F0XxOOVPSW1mR/ck/DDkl3rUyqfRx9cRsQssq2X9Du/VKfn+52am+8TtDE8i
         3EAam1K9rqeopLSAQyKFKV6NnFndhRkrc6QAiYmNTmMsIDiFSub4z6orvBFG6dVGScm1
         SD/YtHA+lcNE3sQeoEqqZhJpIMxspPKxWCio6q1aK5r90/PhaqTlObYn6PkUsL5Zy9GW
         Uugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725267669; x=1725872469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqSh94kF96VerY0m3+ny14R8sqauQwh7BBb3bguK3jo=;
        b=CmLgnWLtbJCH3tDHAqGIMa01h/tnXfVwE4JQ7jBg3upUE9aZ7oXZ2VyVm3ncGphvpG
         YWGnepiRup1xhJUJLOVSdxGdOPyBOndXEXtPWBNPbmJ8LN5GcZFk5WgF1/1R/qk/Gz7s
         8TmpDP82rTFI2mvD4pq95N++JbWoKeoznoQv7YT1uLwHLUlHgTfDQQVHhUjhw0stbh+Y
         Uy2yzol5MKhNmI/MNStmx1ZTy1wJWUzy3jxlWbW0JxlDWErf/Bc36z+63yd8ZADteYKQ
         UDWvn8QpEckV0fEPVMyGGYzwcs9J20XSQ3sy7KjhCOc4KFgrepSsAxxQ3fi0JCMmJHFZ
         UC2A==
X-Gm-Message-State: AOJu0YxoJpKZhm1/Wry9YSk0fXGk27g2nuZjOi2K2sj0rAHDWFUv4xaD
	xFhloo33OkynWDPiGBoQUCgmdRg+gl0pTxXma9JiuTkTyNZxMIIBCwbrUmnB/1mWb0kzrwu26KW
	/9vqVSzy3j9eMutnHOr3gdg7nVC98FqGw09TNZg==
X-Google-Smtp-Source: AGHT+IEvo6sNwVTRnSmRm3IVSdi1vc5y1sUmNJLRLJrwsKN7lJkndFUCHSw+iSloG1P66HIall33Bpam1LCeHWDoX0M=
X-Received: by 2002:a05:6102:a53:b0:498:e25c:738f with SMTP id
 ada2fe7eead31-49a5ae82463mr15833583137.18.1725267669045; Mon, 02 Sep 2024
 02:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901160803.673617007@linuxfoundation.org>
In-Reply-To: <20240901160803.673617007@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 2 Sep 2024 14:30:57 +0530
Message-ID: <CA+G9fYscUiPT0Eo9yo4UhJq2jjYtvLhOofQKhAMEOiVueR-Vaw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/98] 4.19.321-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, aleksander.lobakin@intel.com, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 21:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.321 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.321-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Apart from Powerpc build regressions we have noticed s390 build regression.
The S390 defconfig builds failed on Linux stable-rc 4.19.321-rc1 due to
following build warnings / errors with clang-18 and gcc-12.

This is a same problem on current stable-rc review on
   - 4.19.321-rc1 review

In the case of stable-rc linux-4.19.y

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Following two commits have been added on 4.19.321-rc1.
-------
  s390/cio: rename bitmap_size() -> idset_bitmap_size()
  commit c1023f5634b9bfcbfff0dc200245309e3cde9b54 upstream.

  bitmap: introduce generic optimized bitmap_size()
  commit a37fbe666c016fd89e4460d0ebfcea05baba46dc upstream.


build log:
--------
drivers/s390/cio/idset.c: In function 'idset_bitmap_size':
drivers/s390/cio/idset.c:21:28: error: implicit declaration of
function 'size_mul' [-Werror=implicit-function-declaration]
   21 |         return bitmap_size(size_mul(num_ssid, num_id));
      |                            ^~~~~~~~
include/uapi/linux/const.h:32:44: note: in definition of macro
'__ALIGN_KERNEL_MASK'
   32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
      |                                            ^
include/linux/kernel.h:58:33: note: in expansion of macro '__ALIGN_KERNEL'
   58 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
      |                                 ^~~~~~~~~~~~~~
include/linux/bitmap.h:215:34: note: in expansion of macro 'ALIGN'
  215 | #define bitmap_size(nbits)      (ALIGN(nbits, BITS_PER_LONG) /
BITS_PER_BYTE)
      |                                  ^~~~~
drivers/s390/cio/idset.c:21:16: note: in expansion of macro 'bitmap_size'
   21 |         return bitmap_size(size_mul(num_ssid, num_id));
      |                ^~~~~~~~~~~
cc1: some warnings being treated as errors

Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.320-99-g0cc44dd838a6/testrun/24994013/suite/build/test/gcc-12-defconfig/log


metadata:
----
  git describe: v4.19.320-99-g0cc44dd838a6
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 0cc44dd838a6e3fee60d7af3ca412c4d1b824562
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lTf8qakoJKDjTgS3TvH3naApk1/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lTf8qakoJKDjTgS3TvH3naApk1/
  toolchain: clang-18 and gcc-12
  config: defconfig
  arch: S390

Steps to reproduce:
---------
- tuxmake --runtime podman --target-arch s390 --toolchain gcc-12
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

