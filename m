Return-Path: <stable+bounces-191979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77D1C27857
	for <lists+stable@lfdr.de>; Sat, 01 Nov 2025 06:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225A31B21D16
	for <lists+stable@lfdr.de>; Sat,  1 Nov 2025 05:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032A2246768;
	Sat,  1 Nov 2025 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMEdI9FR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E23188734
	for <stable@vger.kernel.org>; Sat,  1 Nov 2025 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761973848; cv=none; b=bBli+CTCbsA31LzHGFVo6kaokhLYhfN+2bSI8awuBeRrhMNARQtIZTkmv6nBwfrirNyTf9rGyeoy739ObZ6tCEYXdCVz75SpTJb9ICWS5E4V75ssphH5NCLcUGGlpQ3Km/eG8BKw25V+RSff+SsfSE5aJ9gTxReKnVygbFz0NBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761973848; c=relaxed/simple;
	bh=eOlM1uFeuGo4OskzqCGnrLnEeqaOGDwuYrRt8MXSqLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJe0dXwMImF2rp4UZAI5HTZrWFqOt5mzoyeB11+vubuQxa2dY/1CUadiuZw80W2hILu92TDNpPJazHCmEnDl+PKFEa7jK0YoDU3PV+uof/dNAG92k5x6lq8UXq0nz1UGsBupaZogOauux7Q3T2+wnuf9ceBHYTvaGkeAY1JUVo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMEdI9FR; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-378ddffb497so35216621fa.2
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 22:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761973845; x=1762578645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDBf0EPKFSh2QRdvgUh08qctzAfCvCuzR3NbXNNUNTg=;
        b=iMEdI9FRmOCKFSJDM5JHp1I8ENxi/wN4KiN0O7101WgZCIqjWQO1V3mZjc991Sdfg+
         xophtcs1ENxjmtluIGZo/0uqdsu61PRh7f7ep8OqFVDDj/UXK0yPchVfBNoH2W+MB1sD
         o+ibQO7SYZybvTMduEz5Jla5jw1HsQHyotq6LwOMawQJ/pcw3400uovKSFNoOvBS6nLv
         94bscpKVQoGdlGAj6avqDbvIEvbtqo820oGU2nPvcz9Zg+TdehJ1Cr4TfX/rYxgzazyu
         Tybg3eITahSfMt3CCBFhJ5ociJ2XZeuTlVW2ks2ojm3vlSJompwmx1PLmF85Gw2Qcnu9
         gtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761973845; x=1762578645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDBf0EPKFSh2QRdvgUh08qctzAfCvCuzR3NbXNNUNTg=;
        b=v5gVRHxTrupT2G3ZSOMToGICGT8oPdYNaYXkQ9d1NNbEWLgDbKChRB7Ue/+1Y6oPc3
         QIPJJ3eNHv/+V0bSclvIypQ7F6q1uJ3tghEgwB4ka/aNfz0vFIRUu1aiOoZm7FuwDug/
         V1Qgd91ahxayNV15EWu9J4yBGXm7oGl5lojdd9z/Z7Xuy2ItP8cjgSInPVYeKYpetJUM
         QMqc6HOGh6JxIyyNk51xMVVYqBzHR/MRUO0n+wl5tuu4OZfQ/oenkfiTS6VB52QswS7I
         W0Bc8eQsiYDTDS/YbJZ2NodvfprkYPOn6Bdq7N3utv4au0xGEQgbpKPZ4VXSYIuT+RN4
         agBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNuW72l2omxXmumM+D7Ibqr0atQRgtavcvM0b4wAqZ3Y2ccey6ELWSRPpRTDpPy9Ihql0WcgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/1AbDDy0LRyy25aN4ia65zUCOcjPAXZkL5R8oMI24nmrkjwuN
	HLVzuLaR5B4E1cboJvV1gplBQn1s7GmjncGlkkzHjnaI+4nkqAWP9qrapajwW0YDjcyFUa9b/Ga
	bM1rcOC3gNhMFewviZ+0zBpcrH0a2xQE=
X-Gm-Gg: ASbGnct85FAxmGzjY9ohzNx+nsWIMiGQL2HKwtFBraOGHEku46FXYsyUHScSm0UHRT9
	c0iRCAKszH2CuHSUvwRgeubNRbhEij0mo4/AbBXXv7AIu8+z/YXhyrLp0ofdsdXR2AsGV0iwvHf
	ZZLK83lakyi+DAXm5AO+6Iji8WZ9dTgegRdDHD3Et+/gcUpodyfSgnny4u2RewSquK9qrRn1uaB
	k8wSYXFodTP7STWiNgvg0VY7GnYoDbxN63i/tXZjtTe0h+drav6p1rX7aX8q2Dtu2QrvrwPVLbb
	yr3KfJEGxBQRmpu63w==
X-Google-Smtp-Source: AGHT+IEgcVh16NBSlAcq0VebB5Gm+0g5P4XcZHFf7Hd8YhrkSByvbyzY03uBh9X6qmIXljQ+9mmdAKbfTpWuA4Lurqw=
X-Received: by 2002:a05:651c:2049:b0:376:4320:e33b with SMTP id
 38308e7fff4ca-37a18dee5f8mr15061341fa.47.1761973844866; Fri, 31 Oct 2025
 22:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031140043.939381518@linuxfoundation.org> <19689e2c-5dd1-4c3f-a243-84b69a552f91@googlemail.com>
In-Reply-To: <19689e2c-5dd1-4c3f-a243-84b69a552f91@googlemail.com>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Sat, 1 Nov 2025 10:40:32 +0530
X-Gm-Features: AWmQ_bl-6-f_3Ztgk64RenjMy1dM7NuNxp6tpcUL91fjp2wWmf8Gqa3cmQnHIAQ
Message-ID: <CAC-m1rqVAbQ4HUQibgheOZ6HJf57wmC-MAApAyuuQ63oeDGRHw@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/40] 6.12.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 10:04=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.57 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.57-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Build and Boot Report for 6.12.57-rc1

The kernel version 6.12.57-rc1 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.12.57-rc1
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit : c3010c2f692bb27dc44fd2318888446944f5846e

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

