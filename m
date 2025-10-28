Return-Path: <stable+bounces-191523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BE4C16123
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 18:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CD0E35639A
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 17:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2F12BB17;
	Tue, 28 Oct 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pb9rEkPs"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E0434A3CE
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671532; cv=none; b=H/dUa4ix8RYlW7m2nxcevQ2EazhInePCdk0H41lEDVIgbEKdo2r/HOs+9Y+75/g4MTK7EVYmTLYstHdSpAbN3LTgxLq3R2cy0BhZzCHWcltt+cUFdfrd7FSDqetL4ENWk6ZiYCq5+iN2StAmd+XagL+B+hJBcjpbxgRpX0k0Zjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671532; c=relaxed/simple;
	bh=8aY+K6oJRK42GwUHaRODz04gZAOQSJRTEgx7aLu/TlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZCAyz18+AUxg/qENneorm6oh+eJSi5mRYTAUy5J5DBYkcSZO1VopleCj/jSYVe94V9nrAsTuJ9MYAgEiasEjHBcL4XpBW9Y3ec80g4h6l2l3bcNmmZCNB12jPvr0Dy8w+NLSLh91+bdzaDES8ijnkFrWNhfv/Bbbdsr6M2r9Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pb9rEkPs; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-591c9934e0cso9061372e87.0
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761671529; x=1762276329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhaEim7pp67uySZyfPHViLfH6/90BA9wjTtQgKcXy9Q=;
        b=Pb9rEkPsWeLLbybEvDyx3QxAY71+E5MKZwDyzdtndckz1WS4dfBNibLJMyW2YF8wq8
         HGMnrCxoIhCUwTTL08XS592oOGyaRrS/M8uJMAIL2aDQa+UbA/IPykotFI88YfqqQp3N
         z/UQjJW2zxKlhGLdjjBIlNO5auprjrzXXYGEs6S0JSgK7E12b1ZQRcybPcNi3tV/XK+K
         epJrqPflP6oGV7dQSoM99g9kFmqn7JOA5/PfMHpz9iZhjf605WacTOAEEuJUz3Px7L/y
         kypPFvU9et8Imy3tBs3zagYxQE6yVVCiPmZ0bKJbP76C+XroWnUMYoHRdjCQnYpLSzhN
         hTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671529; x=1762276329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhaEim7pp67uySZyfPHViLfH6/90BA9wjTtQgKcXy9Q=;
        b=MKk+aKe7ltgACU7YCv1NBcj6X5Us9gAfiR3cJxFZAlPZo8CavHCkwtN1sZX2zemAAI
         xw63aDlFlDhy9sbVwgXF4XOsYcAO9UKbhcJenkCD1GbqJAomKMhLJmrEjMWDdk8weRPo
         ULBeo9x2A++HHFkA7EcWMSuTwa20CLel/lpuxGD/L6eH6sYJyPnm9TBLGUqE9AEvNXZu
         LZNsUQa1Sx0zqNTekJoIcM669aYA1cbacj/am00g2xD4BbDGpPUoaGfjH3Zr21WdaWZg
         XaWJM/dLlCMSQEmXpu1hQpC+OfedTOPdiugmQaO2f54LnGg68q+SVvfrbc3Hx7rDEqIh
         4pBQ==
X-Gm-Message-State: AOJu0YyPDwfPOmT4RYRXM+xbfmqEWKCm4A9tuys+R43fHO2Kt8XjerPx
	YCnqeBVOiO1cNVmsszDtuIr7pguoBGjqa+6P4Uxejmjk31YFBdM5x5/P1P8SI4dM/rq9Ycfq3ZZ
	rHpHxg6KJfqyWeCKd2rWslVklALBAhKw=
X-Gm-Gg: ASbGnctbMT+FqpH5gb/Nuni7o7+4xjvzd/P21r08uYq7+eQuPJXvvzyupDKPl6cadkS
	oCw0/sIxIk1Dl4mFd7bOWCj2zCZN91nnJPvCLIWphw4LNPE12b7QAta4SFPlBysZu9w8gbT0QHZ
	51ghUM87HPXiOZIvXwIhB03Ms/aii37VV3eU5Hp5uqFAJ4pvE6nP8CgZemojxyb4ItAxHHJ6LO+
	OKosaLYpN7rkbgnYmD2LvrxgZzJeD6Dg9pNRVpl2qC1xnm7H3nTebj0mo9UgP7lUSy3q55SOCbm
	XY/9jF9fXW+l00XtUA==
X-Google-Smtp-Source: AGHT+IGXVzMpnvwsNeD4NLKZTNTvU1+LcBI9oWgBlxyGBWCgiGyua0eoHig285ENZWhSAfa9iwDHF5qVrZu8Qf6uHOQ=
X-Received: by 2002:a05:6512:2312:b0:591:d903:4384 with SMTP id
 2adb3069b0e04-594128df108mr29896e87.51.1761671528566; Tue, 28 Oct 2025
 10:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183514.934710872@linuxfoundation.org>
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Tue, 28 Oct 2025 22:41:56 +0530
X-Gm-Features: AWmQ_bliD54_NlxW6lHqh2heDhMGVKTWJMWeMi93yWM8vkjT7VQBefaXUu-Hg4I
Message-ID: <CAC-m1rq0XORNAq70r7SuRq3=4=QaAkKoPBWZ58uZz5fYH8pPqQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/184] 6.17.6-rc1 review
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

Hi Greg

On Tue, Oct 28, 2025 at 3:23=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.6 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
Build and Boot Report for 6.17.6-rc1

The kernel version 6.17.6-rc1 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.

Build Details :
Kernel Version: 6.17.6-rc1
Source: linux-stable-rc.git
Commit : 10e3f8e671f7771f981d181af9ed5a9382cb11f3

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

