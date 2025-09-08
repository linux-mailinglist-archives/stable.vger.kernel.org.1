Return-Path: <stable+bounces-178950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3A6B4983C
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 20:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1083A8464
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 18:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5AE1FDA;
	Mon,  8 Sep 2025 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qorINlAy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D53A8F7
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355910; cv=none; b=OnHfLFgvU6WPUBTXrVR6FdfI30zSDrrM3MnaOxv1soLol+gDKB4yGjZ8wFeHTpS8Vlyl27nh9NL8pWgsGR7uOVOVVivsf9a2pAnIxkx+0DjVfdi3f9BHbnTbMmCW5vVDi9IDaZZ5RfHjp1mjyUB2S/+MWdEa/AOZDvZRK28Q6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355910; c=relaxed/simple;
	bh=GU4hHeFvwVnk7kq2RXY5Xg8cjjx6Qu6aF+dHzVCs+uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cwd5qMwh+T54OyKn0NkI09ROLuO9R0PLdmW8RNIm5RvL6G3GgSK17es0mDqxv3VEnlrOI65SYu4/+T2JklP4GlwNzvJXRUy4QBoXbQP8dlQT7Mw2gEGKBx6NTgBmHCyTTRPpyeTsCpT3Ehu3VMsMDQwQY/1ACGvMJ5RdYDy/B9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qorINlAy; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-323266d6f57so5301360a91.0
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757355908; x=1757960708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IWBcug01b4npQiJZok8CrAZHtpv3BYuhLyiOQ73LoE=;
        b=qorINlAym036wgvLtgZ9wTH0YE0hJy0H0XTSHMs+67xEvkiypRfmsCStL3qfCCV3r4
         58H9fbAB6e4obJTtWSFgUUM+RrDOBo7kf28nS2pQaKWnyI178mvdY7zAl+j0fWbVqBcp
         JUFaBK7ypT6EJJ6yLqk68EBmBSqXFdUUg5Y9QGNhXexKzmtCCATFVCp5wELE6VRhdWRd
         a8OU6kNVlNp951+cFncpseh72pVTtwO6lHLLMh8/f0dBYKH+vOmG+IRF6iRAJ6NOOM5a
         tZ+U1YsUj3OrMHkAj5o2Dra7W8B/RgzujEgnGlCs+QpT7J7krIdcrnnUEN/PIpjCC2a1
         AXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757355908; x=1757960708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IWBcug01b4npQiJZok8CrAZHtpv3BYuhLyiOQ73LoE=;
        b=cY1hCO+mhWBEDwbcWovJ1ZqphHwG/shu4JXHzyC1iHDG2LzVtZPAvnbJyvUAwyIiYM
         KDdyJyj8pTe9qhhTS3hfPmnvFqqPjeFqGdpjP+LKBtkZRIRNN27OwxAH/E/n6JKziUBn
         H/pbojEntEI/BlUYmVXwjMhOR/OGvoiwdtOEqqh6CqHuG0hF8OmcOmY71DV7HlYkOZCk
         006FjoCBDJTU9rxux9mYfz+bTacUrTSsbhSqF82hfG3qQFKYRfVh2nYE/0MT1mBAWgX2
         /ocopIpCh8CPxGAHS5Qs4xMOxMLXdb7iBvn7aha3KTgXy3ijDwscaPncN/iGnLmU8oKV
         NhYw==
X-Gm-Message-State: AOJu0YxyBKzbLeTOFpidt3p/JD+1X7u/QS/wAOhqQgkmFEqZKS6F4qTf
	wVl/YPq9GcFVqvzCOEJQ1CRQJF3xDvReqfHDcAzEpwyvMKdv3+su2S/gzIQx7qQexkUCpKyQ9I6
	laqHmCXD/yqnQ4ChOX42Cf3zybbwgqLMpRqx7RdwjTA==
X-Gm-Gg: ASbGncsjrxVd0ARWOajtNO+W4XvDnjA3OVx5VPiE+pa8qYJY63jbhI8fTcV5d41zeer
	E3x/iDkP2Lsv9He1MZvsW78jikSmJvOeTtZ/8Vunpy6KliWGi9lDS6IIYs9jkPcF5n1NNg9np0d
	WCiKuvf/YeVEgOe+DE2G5AZEuaxH4rXVmiZqqshQpmZwiCSfrXe9Iv238i5iJiQ5RAvBDMP0Ech
	ZIXnhhesoNqY9hTV05qMlGQV97wkA0vUdxcev8LB9GQ6VSyZYIo79eEH5NS1sGVmpK8HEQJJDZt
	4RyFjLFI/Zq97Sv7xw==
X-Google-Smtp-Source: AGHT+IHj9/tnJHkNQasTrRWqFjaqKqLyMbw17kMKkgYlBrWWXZgHdvHNrG+sKdBSH0wLKK9FFJY53g7/1x/HEEkUnRM=
X-Received: by 2002:a17:90b:3806:b0:327:dc81:b39e with SMTP id
 98e67ed59e1d1-32d43f1891amr10097489a91.13.1757355908088; Mon, 08 Sep 2025
 11:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907195603.394640159@linuxfoundation.org>
In-Reply-To: <20250907195603.394640159@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 8 Sep 2025 23:54:56 +0530
X-Gm-Features: AS18NWD9pYZXIPgJSNXVjAumK8DAoDrS_GW9AD1G0s-Kl9qADSuGItB5Vl0yLJY
Message-ID: <CA+G9fYvQw_pdKz73GRytQas+ysZzRRu7u3dRHMcOhutvcE4rHA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/64] 5.15.192-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Sept 2025 at 01:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.192 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.192-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

While building Linux stable-rc 5.15.192-rc1 the arm64 allyesconfig
builds failed.

* arm64, build
  - gcc-12-allyesconfig

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: stable-rc 5.15.192-rc1 arm64 allyesconfig
qede_main.c:199:35: error: initialization of void from incompatible
pointer

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

### build log
drivers/net/ethernet/qlogic/qede/qede_main.c:199:35: error:
initialization of 'void (*)(void *, u16,  u16)' {aka 'void (*)(void *,
short unsigned int,  short unsigned int)'} from incompatible pointer
type 'void (*)(void *, void *, u8)' {aka 'void (*)(void *, void *,
unsigned char)'} [-Werror=3Dincompatible-pointer-types]
  199 |                 .arfs_filter_op =3D qede_arfs_filter_op,
      |                                   ^~~~~~~~~~~~~~~~~~~

This was reported on the Linux next-20250428 tag,
https://lore.kernel.org/all/CA+G9fYs+7-Jut2PM1Z8fXOkBaBuGt0WwTUvU=3D4cu2O8i=
QdwUYw@mail.gmail.com/

## Build
* kernel: 5.15.192-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ccdfe77d4229628515f4f822400fe6414b9861f8
* git describe: v5.15.190-99-gccdfe77d4229
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.190-99-gccdfe77d4229

## Test Regressions (compared to v5.15.190-34-g29918c0c5b35)
* arm64, build
  - gcc-12-allyesconfig

Build log: https://qa-reports.linaro.org/api/testruns/29791503/log_file/
Build details: https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.=
15.y/v5.15.190-99-gccdfe77d4229/log-parser-build-gcc/gcc-compiler-drivers_n=
et_ethernet_qlogic_qede_qede_main_c-error-initialization-of-void-void-u-u-f=
rom-incompatible-pointer-type-void-void-void-u/
Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32O3I8js=
bRRLOu0azhrfBwOPAjC/
Build config: https://storage.tuxsuite.com/public/linaro/lkft/builds/32O3I8=
jsbRRLOu0azhrfBwOPAjC/config

--
Linaro LKFT
https://lkft.linaro.org

