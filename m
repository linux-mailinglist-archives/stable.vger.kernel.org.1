Return-Path: <stable+bounces-106036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A0C9FB7E4
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 00:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F77B16313D
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 23:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADB01D04A4;
	Mon, 23 Dec 2024 23:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="MhLrA/nw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B35D18A6D7
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 23:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734996241; cv=none; b=cTCFq+yIANVTsJD7GXng/UBZFWroS2g/VdktQOBvBlx+7pGeSS59FHtB0S08prd/5yjVO1H7HmmLjZTwvO8nDkh7m1YJejciZftiMua3jw5DbkR5Ae/DO6z/KDAgCfXC7+t5WZHTE8QY5mKcju6x2DVjo94qe5je8bH6uAsZOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734996241; c=relaxed/simple;
	bh=XxRBMrZwBvgLFSVqcmdNITUgVenxPQ6jGTOI3cDVu+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvfK1bj1Cwol+OTDnSbuc4JxU2ZOzV1cW4GNn90tBsnl7Hq3fz/V7Vfk0xW4a06lIDltvmO6jsMFKOtoVKWn5il2y6sVXzVDh8cDW3wdgk+G/3Biz/s48XSG+aR1XAIwTi7RXTGruXwfyvP0knTsPLAHFBGOrx202nkE+MvuXXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=MhLrA/nw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215770613dbso32356895ad.2
        for <stable@vger.kernel.org>; Mon, 23 Dec 2024 15:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1734996239; x=1735601039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nu8BnE+0embuj0Jexzr2atsg2wE/YBGIbUUyn+izezU=;
        b=MhLrA/nw6eiLxHewRDV7bMUIXraXE6mTNLyBCAM5fmgT/38O76hj+FF18eKdGfHDdg
         VVW6Se4EscT+81f4p4cWbAIgimv61lsv0Q7ZIq0EaKae7jykT9amgjiOcTKXj5fFkqq3
         4sYM3saAjwDGbT5R91RknWRmgPYndOccMEewyt7xypaIu6Phi8MQdC5mVzOni6oy31Ke
         VKfpZiFdszzVWx+Nan0ioBkiIzEq1x3/LWHdNff4YzGoxWCWRSc+DkBjeUySI69t0r+m
         pSOCXiO2wk500B1rJqU9JVHZh0FcCsVsIwc+OVIq7TjqG3v7jOi7AEbZX0FDmqrF2nIg
         mvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734996239; x=1735601039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nu8BnE+0embuj0Jexzr2atsg2wE/YBGIbUUyn+izezU=;
        b=Npoejd6sojkSEvxTFT4EJOsrm4GfLdHXeFAnptpdWjGF5K5mtkXGtKhXkwYE7cLwrs
         LrcNoUFfVnlFqgVwwu8p0Jyyv9EOvh1dBQ8xiLJRM99EBSJfvgdFjNg5g4SJLPmzvnhb
         1r82hOsTGwzitVFNhSjr6BXNysWaffop9iL2vXxxQ24aJccaj45cS9qQsvSitXDu758d
         ugid/lNUYxAHzABVtBfs4VFWa5jLt07A82rQUh6FrJfaMPNaMttie2l2GDI4xs8i84eD
         6bvPCK2CuFAgvfSqGeC8leVsN6xJPMlLJ0zsCNjoM0Lfvw203tekXc3mOtEx1+iuOJWH
         08ig==
X-Gm-Message-State: AOJu0YwfEfdoytP5rPkpoA9PYHQ4h/05Upwai7YMfhoZT6rkrSBLuzzf
	Zfeb9Re4LD+o+SNM726uUEHW58cGyFajYzUt4mO6LwQFLrhUTLeNLj3b+mUw5IrAuZMfPUEcBdJ
	1WhKm9ZjhvmLajxtjHiMZfqYhP0FkS4yOYwILBQ==
X-Gm-Gg: ASbGnctqYGcQTkCQd+ft8UBqN5LpZ3RfFRXOEz0J5bdKQ5brnYBLJT5+xxebjVkcTAS
	R7zDTcQvAYJOcSuyQNqz0Q4g0E8NUcd930q/l
X-Google-Smtp-Source: AGHT+IHFm2Y/NQwVFIvuy9YKniReoPPy7ISeUyNFk29SB3r9RmBIqfjn2PVmpP7CAYc+6F8IqCch4cyqAhj/oNUAT6Y=
X-Received: by 2002:a17:90a:d00b:b0:2ee:9a82:5a93 with SMTP id
 98e67ed59e1d1-2f452e1d13amr22438502a91.14.1734996238883; Mon, 23 Dec 2024
 15:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223155408.598780301@linuxfoundation.org>
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 24 Dec 2024 08:23:48 +0900
Message-ID: <CAKL4bV6N+Kj7_6VGOxKX3kom5Mj+H-GUwEbe2T0JN9c7D+LgEg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/160] 6.12.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Dec 24, 2024 at 1:00=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.7 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.12.7-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.12.7-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Tue Dec 24 07:47:05 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

