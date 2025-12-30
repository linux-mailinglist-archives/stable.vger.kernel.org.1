Return-Path: <stable+bounces-204280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1563BCEA899
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 20:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29601301BE96
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 19:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD3F2E091D;
	Tue, 30 Dec 2025 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRphHN9I"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4511B042E
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767123008; cv=none; b=bu828CNnZIkPDZzyeGod9OWh2dXF0yu3br2pTBzHnwP78GSAJ+c6F/A08BuaEyDwycRAZZuVzlOOgE33ZTX6oJzjG891ujQwpcQ0UO8gmCUuy1fdGN+4V5Jjig5mWkmbUaWfOot74eisCyY268lEpwhHNqbbOVgNAr2BAGwQGuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767123008; c=relaxed/simple;
	bh=VOG1S3/hPGN625m7jo9CcGLdrvR/LyclfuVau8azLdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVoGw0utQ04Xe0y5SUKldByheba4ZLWZf71vQhRbdqqMHZyyyx4gbDP9ngpB/ZESRSShuzgRJKzyaHbvfnjzbadAx7SgnHW09MORINUT+F3zZUSXcEltn3vD+f7Z66RFQWVZS/DTI3eZBQK4J1u3LwfeS0+058JF54LHxYz0jGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRphHN9I; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37fdb95971eso76133481fa.1
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 11:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767123004; x=1767727804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKPOxdFvjNOz9JlYzXz/QJIIlpA6vvDk1R0yH4qi2ao=;
        b=QRphHN9IgA1lL48FhsGsi3cWTrrY3nciup4m8J2euuROmCG+BtgKfK40QcIxtQ7lVy
         0boxmW4JBp4kL6eF16ZDn364f72Wo3DVz2TuL/y3Y9oLvlYPDfVNI6OpMk6Pf+8hvJuv
         Bx1PJzIDKlL7Kzj1v8gYIZQWXx/ov/ODe0YNtENtg46z1+JqT1Vuu+kEb936cdWVNJOb
         kXiCL6mxx89UjMMdUL0AijaaipoC5KXeKz7byBAt4DQTOaOj3sn5GOrCTa/uRaO5cYiq
         T2e8RNCyg7JpFZaHfwuMDP9A/1NRbb5NacwE1ttmxzwaR9f640buGRKKb8aLKDsJfQlz
         +RvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767123004; x=1767727804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LKPOxdFvjNOz9JlYzXz/QJIIlpA6vvDk1R0yH4qi2ao=;
        b=pEztW+7/HUBR4lqIoV8NS9ToCecto/0CSoOdHbQsw8lQ+GFcAbbj0Y4vhJjabUQKct
         dTY6lgemKobK63M4yzi47yflpiDZ7+Q5OSv/rEUcjJgJ2plxIkdjdO8ovUz0lkykbNdn
         S4jVng4LAbc4fhw7VAGJ3guRoXGTvu0o6paNdyFq+D7s2+zbe/tPTo6/CTIHuUPhyZPa
         IdQmZx2aaGIVwPVVARfTFINczKhcZrz9HwacbyAHHGfazV8lPoSG+yf2aDrkf17wSbdv
         q9m58rmfQJK4PN5Bt8DEbwpF643RuUiQLurpQw7rQv7ZTWQ3EDsjCLV3xcTa1GtOp/3c
         GGNA==
X-Gm-Message-State: AOJu0Yy2LT915tUdkBufLr0UNWEDigpnyyzYvvWPbhWNOru2deZUdLg8
	3/lFFvaVDMFOXTgoOvmowk4ZFT5nAmSGCySgnNfH0eOEyU92X6a0TNQ9gISi/uYSqYv7jabZMez
	/u3VvJc/xe9GN7krAxZweEeqda6MKJn5pLr5G
X-Gm-Gg: AY/fxX6ydrygGUSTM3YikZz7ddUZpHQt/jwW/9h1TVlB0gjPshrGrTVHHxmNlQ+T5F2
	trzbxmoreTp2PXD4Mnap415v69HwH/yRyJSczzij3RxSmqgjshxgF/BEfzAjo71pVeTU6/qpG4f
	6i9ayne3G/ukuct5SVxW1anejsI2pKQ9DCTJH2Ao5rMk9dT2LZ56okqhFD6MAHNdfzxmjpxenmO
	1EsvbasZKGoP5IHiSfxnIbpxA9Btuc/Pha/ztadM/CLKJ+Y/RmYA35OEbtPFdaAVHGEWXB5LZ5t
	bnBQ9+XXAj8VdCgJ08XV6QapM/eoXTwquQuFtZQ=
X-Google-Smtp-Source: AGHT+IFElL4UyDpI2pVT853yD7czcRF3ovEXW+NcmNMICaMJyVmaMk4AVn3L9PKTtjh7GXPRGmRHUPcLvUfWOf+57ek=
X-Received: by 2002:a05:651c:325b:b0:37f:a216:e455 with SMTP id
 38308e7fff4ca-381215d0e05mr109636731fa.18.1767123003342; Tue, 30 Dec 2025
 11:30:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229160724.139406961@linuxfoundation.org>
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 31 Dec 2025 00:59:51 +0530
X-Gm-Features: AQt7F2oMihyvHbVC_-x05OR2oAVUqQkLTRw7FDc00WccKyvAY6qIsH9VEp9ab6U
Message-ID: <CAC-m1ro7r5Ss9GSmTzr8Mj7HjjrV9P9nPcjWgMowzEU_MjH0mg@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/430] 6.18.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 9:46=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.3 release.
> There are 430 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 31 Dec 2025 16:06:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
The Linux kernel version 6.18.3 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig).

Both build and boot processes completed successfully on arm64 and x86_64.
The kernel operated as expected in the virtualized environments, and no iss=
ues
were observed. No dmesg regressions were found.

Build details:
Architectures: arm64, x86_64
Kernel version: 6.18.3
Configuration: defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit: 685a8a2ad6494bf0b31b9421d98414225146b792
Tested-by: Dileep Malepu dileep.debian@gmail.com

Best regards,
Dileep Malepu

