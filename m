Return-Path: <stable+bounces-52064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87395907646
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 17:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145452874F6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AFA1494CB;
	Thu, 13 Jun 2024 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6Z2kT5R"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943961494B2
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291636; cv=none; b=Us03EXvq5sOEvbpABXkW1yTl+0bziotlsuExb7UqBIEyVKY9WSn2yCaN9rzq0y8FLaf3Ev79u3LYr2WeL5BbSxc/lU6pdOZIXVpnJI4KLyUVsU835xASsIUUTMW7mqu7FkZ9YYx7VTrv4FHnH6/CleTS/hmEid49Vqoe+VuyX7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291636; c=relaxed/simple;
	bh=14Z/QPjhD+7BffP2eGAJ+9YQJulua94nuc8mbHlPwaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NY7mSRcU4c/d8qaVTSj80Q5ygsqB4QZoSu3XX4i50TKVtTTZbYhECLxHH5nXJf1zYO+dmKaimiHfIUcYL10rRj3MnJvvQCsktkH39TdODS+Dt7BLocIuRCtz/8icM+7mWC/410b7FMpGMus9Ky3Pyiafvz1lxHrBagsT6HdlTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N6Z2kT5R; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-80d6c63af28so439459241.0
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718291633; x=1718896433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YrxYBwFmJZ2ShtzXRL4Y2grRkz6qOWp2v7p/c2wyXj0=;
        b=N6Z2kT5RuXj/Meim/CCyrYJX41k/FWONmJcxc5dAF1lNhYbtPsg7bQGgM4Md6JEYE4
         unbpr0/6Y4VLyZXsF5XozdYmYCEnZtdyZ/FjIYXUyag2OnQtlQwtViXnT2GqjKK2DYvg
         2C2XI9cxxfvaDZzndaL2WX2ZKBLTt00UL97ZUHGkaAZB4AImGFa3oRwvlYIqjfbcQ622
         4ZneCaF59d9e9XjhfhRUTfnMiAtaI7ySxFeGkXlaKyslCB4z4JtUQO5nDpEuTgUirNCe
         iCttsdSgPjcAAPDCvCN3s3JIxN32IJfGg+Gpag+nXDoYMpqG34TGB2SRMmJ+mvM5/xDc
         TzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718291633; x=1718896433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrxYBwFmJZ2ShtzXRL4Y2grRkz6qOWp2v7p/c2wyXj0=;
        b=Dk0KXNGHy/qRolXcwXfaeOx9EviSSKQKgI2HFL1jNg9ht+MWl9XBRG5j98OpMQosS1
         ZmNSjL/Gmeys3dcMMu8i8jcaPYySTYGu8MtlxLL4eXlnJx9qbFPSHnM48Mlo7r/bQZUm
         JMks5JMlAWeZ2+LBFrM3uI4L5HXYABkkqAOzWkqfofcFnbqPuQgWMMi2ENzMOTT2VspV
         21g/mSsaT1g+RwooXBc8U9u4OzQYWDBO8MJT0i4ixgE5XOwhw8vaKpKhCiuYxuBD7kzz
         aWcCOLfrBdoWD/UHuJWpC6YV4Bu3nE99p4ocADXYBq+HNjijJyDZySQfu/nU8i7PbVD7
         TEcg==
X-Gm-Message-State: AOJu0Yz5v9g98Dfy/PXskaE0HwU3eByDik5Q841br0yggzwxygx/wS4/
	d9pOeB28FWXVpzfSszoX6CZ9rQXIhcs+5XVtyesxCfrktL2lJx2ZpC4NeCTipYWOb6bjl/OFCi4
	FWtlzkF80WChWgd9vOtlz9sIA8A89VMFV0pQTmA==
X-Google-Smtp-Source: AGHT+IEN/IxLFSZi+7ySH7Yli8WEc2cF1WYEl0a+Gfrx6rp5ZdvnxPevY6/6w7U4zj4C97saSZZh8hfOmFU6AZ7IZKI=
X-Received: by 2002:a05:6122:c9f:b0:4ed:80:bd85 with SMTP id
 71dfb90a1353d-4ee3df992c1mr183882e0c.5.1718291633421; Thu, 13 Jun 2024
 08:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113247.525431100@linuxfoundation.org>
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 13 Jun 2024 20:43:41 +0530
Message-ID: <CA+G9fYvnVJi1RFhO5f6ZH2mpagZ6jcEdoQAxnSBxWPHsEVQwYg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/317] 5.10.219-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, 
	Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 17:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.219 release.
> There are 317 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.219-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The following build errors are noticed on riscv with clang-18 toolchain
but gcc-12 builds pass.

However, compared with older releases this is a build regression on
stable-rc 5.10.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

riscv:
 defconfig - gcc-12 - PASS
 defconfig - clang-18 - FAILED

Build error:
------
arch/riscv/kernel/stacktrace.c:75:52: error: incompatible pointer to
integer conversion passing 'void *' to parameter of type 'unsigned
long' [-Wint-conversion]
   75 |                                 if
(unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
      |
                ^~~
include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
arch/riscv/kernel/stacktrace.c:75:57: error: incompatible integer to
pointer conversion passing 'unsigned long' to parameter of type 'void
*' [-Wint-conversion]
   75 |                                 if
(unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
      |
                     ^~
include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
2 errors generated.
make[3]: *** [scripts/Makefile.build:286:
arch/riscv/kernel/stacktrace.o] Error 1


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.218-318-g853b71b570fb/testrun/24322227/suite/build/test/clang-18-defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.218-318-g853b71b570fb/testrun/24322227/suite/build/test/clang-18-defconfig/history/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2hp7bDTOjqzNr8hqqSWyMf943W8/

--
Linaro LKFT
https://lkft.linaro.org

