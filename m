Return-Path: <stable+bounces-37786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346A989CA73
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 19:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670DF1C2421D
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 17:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B3143888;
	Mon,  8 Apr 2024 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uKa3+5XH"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D515143867
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596248; cv=none; b=Y5aK4lUwla2XyP/PVyCmpasMD170QM1JfTy/W2m4GZrjijrxmjk+e9HfxROvDIXjk74BuKmPIZ06N0VyrpwMZOzy7K7/VWAMmZhYvz/uob1aiS8zGVRUeJAI0NzYx9LqS6WBywVqIs4B/wdEKXPOvOuxFtG/tVcRmjkG+De133Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596248; c=relaxed/simple;
	bh=cylWH1nnV2bxqs+WbEQuW213MzLnqSLV8ZuKW654Nsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kq2TkxlsFt4G1CCJPjzgz2aAcfH31Io8FMgRmYURGyh01iY1V5JoBNS+xa2SP05VrersrYKf/q1063mDcpkZPcGWPo8f0+Dcm0yMPfu/lzuGH9y5WiCMMWZY3LaBg+JWwp7Tpbu4LkXgTi0L493wJtRZDW8076cAGoq8pUqnoKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uKa3+5XH; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-479de65e08fso830715137.1
        for <stable@vger.kernel.org>; Mon, 08 Apr 2024 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712596245; x=1713201045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dgNLDg69yxbLlzA2rtbGSv5XoBTDQC7WuQwQX8jNXm4=;
        b=uKa3+5XH9/wqnndhQovMxVcKGitMuVXwcJbN41BDJpfFUJrYqQ6CXYNVYRIV7jjABC
         enBwsUBy0qpqqzHZ8O0Yvzpx2RIxx5adVAG/oNiBsilolZwzopxpwL+fvCXe07Y0OyXN
         whh61H4HZ0JKpx9ehnWd9eHd47aiD6Rrv5uU3fn8ht6OPh0oG9FqHlg+rpePYu2DIdhJ
         45K4itBOC7V6DhoHyHbXbQ+NWiy53q91Umk4MgsBPbbulwD3Q/nxZwB9W5D3uLGheg00
         LrVtZoBNH7gT25BturHv/WEAB8qAnFatS/V2OmSIqNSCoDZXlD7hwx+LETdUhpSmU2PG
         JxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712596245; x=1713201045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgNLDg69yxbLlzA2rtbGSv5XoBTDQC7WuQwQX8jNXm4=;
        b=S6szCGer70H6wMilggkWL5QITWlX9ZctNZuxroMvtZR6oFtquKb/qeVmnjQPb5EHai
         61bT8t9LGoQaKyQyWPQVz54fAPfYyheRkyWOTclP2XkNfD213QW7L3aE5Fsxr9fn/oYE
         Z/x0+41Ar9960If2Nl4Bmk3+Zn5mDHcGDkJIZiJNr+Zv5yvr7oxvgGc0sHRIsA+pjdDW
         1jtJe5YVXvAXZdh2h/F/LY2rMGq6rTnz8/qyQYKC0d3G7BiUX8K8vVwjbHZof+Q6ssw3
         Xs0xweMmblKK1tQqf21lcTMO4oLMPx4FPApJIRGmThS726nvb7EwS4iPQrOl9Ny7vQqS
         0lww==
X-Gm-Message-State: AOJu0Yy0X0TpM1n7TK/I9Y6FPo91oN3Dfgjdsr3Kh4P6gtUjiLhQCHI6
	TVlk2DHZ+3IyRgax/Lw++SWF1BhrTf+KKLWo1KGiDof5ZBKdMiB2Jo3LAMuCPvcFDBzQtYHTnmF
	9BPDvYEwj9Cod5jolDZTPVOot8BoLrWa3IEHHvg==
X-Google-Smtp-Source: AGHT+IE4rZuhK6L+sff4J6NG4CwRQVKSfgKAx18voJzxhLCWPvTOZ87xJxM9RoHsSuBANnjuKv9ClsQST7QStSFG6TU=
X-Received: by 2002:a1f:eec2:0:b0:4da:9aa1:dd5e with SMTP id
 m185-20020a1feec2000000b004da9aa1dd5emr6423714vkh.10.1712596245531; Mon, 08
 Apr 2024 10:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408125256.218368873@linuxfoundation.org>
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 8 Apr 2024 22:40:34 +0530
Message-ID: <CA+G9fYvt2MTfghC9OtdV-bFF+dN9sY3MzgpcQ608tSTt3XUBNQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 18:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.85-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The s390 defconfig build failed with gcc-13 and clang-17 due following
build warning / errors on Linux stable-rc linux-6.1.y.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
--------
arch/s390/kernel/perf_pai_crypto.c:40:26: error: field 'mode' has
incomplete type
   40 |         enum paievt_mode mode;          /* Type of event */
      |                          ^~~~


Commit detail,
  s390/pai: rework pai_crypto mapped buffer reference count
  [ Upstream commit d3db4ac3c761def3d3a8e5ea6d05d1636c44c2ba ]

Steps to reproduce:
# tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig defconfig


Links:
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.84-139-g76e1877fe563/testrun/23349327/suite/build/test/gcc-13-defconfig/log
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.84-139-g76e1877fe563/testrun/23349327/suite/build/test/gcc-13-defconfig/details/


--
Linaro LKFT
https://lkft.linaro.org

