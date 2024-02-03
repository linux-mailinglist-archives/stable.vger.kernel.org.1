Return-Path: <stable+bounces-18699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C41848698
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 14:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2795AB28F1D
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646284F20C;
	Sat,  3 Feb 2024 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="JNJ2Ax2U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98765D904
	for <stable@vger.kernel.org>; Sat,  3 Feb 2024 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706968142; cv=none; b=RXOu2aNQP15ry1Yie4gwkapiiFGuUowQmFpiXhPMz859wAN2MjeK2ooscIQstC5wHimMdG6rCOkNNfLWOhcIwTlfw0cGe9Sf3jxv5i6iPBkJ4SrVt8yA5ynk6HTyowP7K5dqD2SfbwvaB4CBhoNf5dNlwozu7otAS7r/n6PJ2ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706968142; c=relaxed/simple;
	bh=zrF3irUwnrdNP7FMC6C5/C1TKOlChsEbui8AaDKbpBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcuNDyH/ad+J6B0bxaLQy3bpg2hv6HwcRJ2nzL02jUB7AMciz7r9brAbW1Cej6ZuufeximSOYwmbP3I2cWweIKF+nWCB6057z2pWuBW8Da0Gst9QkC4J5mmdrRJWtqO4bS5wyjgbEukqwtxAB1hh/8BqOiXBjW3KW4g9ik0Hyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=JNJ2Ax2U; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so2146020a91.1
        for <stable@vger.kernel.org>; Sat, 03 Feb 2024 05:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1706968139; x=1707572939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0/nxMUqpRTi8jjAM49HCOb52nB9yGpz/fFP3sr9Ovg=;
        b=JNJ2Ax2U8C7NKzlrxlygZIQK8L+vOW8IFYn9Jw4EI4WH8QOZhXugnPhfs1hvwdHkah
         SvKV7X+0l8HtNTL3kkWAPO4TY1xdvcqUwogwccWdIlVmWxuQ+RC9Pv5Sh/N8MoultjBb
         s6khzvBh2fvUyBtYOgsohQBgFWBCQa0e1lCR4Pz+jiJmMfvbXcLGgAdkpNXnIe5cMZf2
         8bX21LmPB5+GSK3ypv1ysiGEPEcm6BZKU8CNSEsbzRGy4w1kC7tI5QTFd1poMIURnv3K
         JD0NK4nyS3IjX1/YiRv/S1Ny2L1WlRGDY86UM7yOk8S+HHyB3RPiLexlq1pUgetoEFqk
         B6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706968139; x=1707572939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0/nxMUqpRTi8jjAM49HCOb52nB9yGpz/fFP3sr9Ovg=;
        b=uL0RPMhearTI478kQt1TPX5WLClUCsnqfJZn5W5yiB8WTeL8dqhClTVIzYkSTBDqHU
         K1VpYxEPjPlfC/BBAeJgTAAj5mNRU1CJCRwsP3dFBMgI2NqxTm/lzlVP7XYf239P6HYV
         Zld0QY0MNa13OS8JnS8hHZX4OAu8CMMWE2Vr2feR0G54renifLYXrYDtyG7Mqj424yXU
         zSsk5cRBpiGo4+sGB7k4jo2Ir7HdmtSl4Yiu58az1mGPGqKJ02WzF2O+x+/qFDzV1Pna
         ij3HUPYfknI8dguj38h1DmErTbX2zZ6gfJlxn8qt7hf/0M8Uf3TXOt86hekixIYAY+pu
         0UjQ==
X-Gm-Message-State: AOJu0Yz/U67p4iItuZPyTFLAg0mBUFE3Bd45/7+i4z4Xxp5YpiTg2Fia
	MW2zc4EvxE7Lbkn3R41Je3BfT0xsolEkWwmOn2pMdW3GxOkGZS5kBnk0r9v+aWsuVIlZkKfQAA2
	n+tPovohtWwVgZI8WfW+2p1icyCWDMqr7DTGluA==
X-Google-Smtp-Source: AGHT+IEocWB16L1EG/HpxOXkrTVWk8Pkve8M5gMV7M9fc7jLH1KbVGt2V/vu1tsLFiZmtqlSbNEGm8aLlgF3mID0lic=
X-Received: by 2002:a17:90a:d717:b0:296:5c13:6ea7 with SMTP id
 y23-20020a17090ad71700b002965c136ea7mr2095454pju.25.1706968139041; Sat, 03
 Feb 2024 05:48:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203035359.041730947@linuxfoundation.org>
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 3 Feb 2024 22:48:48 +0900
Message-ID: <CAKL4bV59sRxqmyn33Xyh9uU8EMxytfqqNFAKxAdFALdWXzr-pQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/322] 6.6.16-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Sat, Feb 3, 2024 at 1:16=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.16 release.
> There are 322 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 05 Feb 2024 03:51:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.16-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.16-rc1 tested.

Build successfully completed.
Boot error.

After selecting the rc kernel in grub I can't proceed further

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

