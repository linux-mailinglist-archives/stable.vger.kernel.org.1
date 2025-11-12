Return-Path: <stable+bounces-194631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E4CC53C76
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 18:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F347734420B
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89632D97AF;
	Wed, 12 Nov 2025 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1fvbV+m"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F621D3E8
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969715; cv=none; b=A4GRSNX5/dgtV+HPd1TAuBW9494m/HvoOpuX1fLCHzNgTGmIWgKiouqE8agXuGaUS1ydmB6/A10uIpBqYu3UiDnV2hAoO68L2me0/7D1ucTTMe9AuBfMsiOmbXy2Qq3Bp0lYf6AObRgb5SoSq3cZ00GYMdOx61d/4h0aW8gqGgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969715; c=relaxed/simple;
	bh=alg3GZVbOGWLPqlw23mtYgLHmyaW7rHaNGquInyV+is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WadeQv+ntzzacayOwvYRxp0iDXGclPB9DW5t5IoKLB3UTBlYSJJVWXo/bzo1qTnapQLAkLHUUGhxjXPtO3FNdFfc4bxeqYRk4QPFDHm+xaOXk3Vsop4AR7p4HmC80dOVt4AcWXHklxhW8aIyh5uX4o1Iu6/D9+HOypxTdOTtd1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1fvbV+m; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-594270ec7f9so1126269e87.3
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 09:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762969712; x=1763574512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RtNiaEUI+oSnsJyG/c+SNYFc+FQ7s2DIR24yvY/faE=;
        b=V1fvbV+mMgVSsAB1Nqxpq6G618nkNw/bjmbg7EIoquzEqh8DYGfIi2uzdUkSwP6fV8
         cvSVXqpsi1eE32GbBU+4xz+mKNn1UG04yh8ZeD5HaGEmph9Ymio3Xpm1/yZ5pqlqpwRZ
         fAVcrkZS06I8J2DrauTAi3rYGPXhokJDf/3+K+huiUDRKisK2jaGGo4HkesgTgzwDlVt
         NFRjDyVE6I79t4R/h6ho3V89hbNqOKk9k75kbou0lrOnFyGUQc0TXnmVOFKfLZc9pjjE
         1x80W9OzFFpbnYj9qxMlc7900FP5QC4zyQWXKtJ0+B9r9bO9zXTZ2XZsea12Qhpo5cZD
         jc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762969712; x=1763574512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7RtNiaEUI+oSnsJyG/c+SNYFc+FQ7s2DIR24yvY/faE=;
        b=wXMvv1z8/R+z38sKzrIPH7V9TwNEDOovzW6MWRo7PAonX4KriGzRMY+0ifxFxrN/zA
         p4LxbkWV0xUwU7jKVI1Cj8BUmdMpLEmB0R4WxwSNZrVugKjC23JqL0fvYqfFThbNJUB/
         CbK6LQDklcX2cD9IJLeOHWkMfkVlWjCikGLUEsFkFnnD1Msu1md1ttXHg4txmzsY2Qcc
         pQjSEgLdI4E3ykScJXEwUw5lNlR4HeIYPNTUTiwVncjRTPZyz8wJrGsUJKAFQ3JLlZeC
         2QKjDdR2U8pqfcsdJ2ZNcQaIFc6TuRELef8PmzCkjlmysaw5tFYfw8/gv67jeVGu305R
         mRUQ==
X-Gm-Message-State: AOJu0YxqMqIrKd6sxw3MstptHlzCdyW7P/iklY+oNM20ic+/wA6yco7O
	kdYIUzVBm0rAlyOx0hr9Ojsv5sok41b4V1pkmOhivd1LGCBoBCrbq7oRHlmhmkUVozXe8dv1jkw
	IMVLLvTgyZptgS3qE07T8ZpF0Iqgcqo4=
X-Gm-Gg: ASbGncs6AjdALwbDtDlMGZNtCDprqCkP0ky0lQDP9U+GzLk5SPD7LLnn59TdxJUheWO
	UHvvsVb+ldev9ayNBwtI0gWWC6+QI9E0Nemuxxb4nHKuRFUKwYKZ4LiLj+g0CRWFzC1pQlzx2A6
	Ee6A/evcfmKFaVoBzyhF5cHLqSqrHl4r7tc+dKpFgDYDQHYI/j/zOid7o4Lc6j4E7ZVxOt8id4N
	qGrO0HLSlGssoIrj0C4rZVS4I/AXC7/qtrEiLk2DJpoyXcwrkVuhelbCAKuJshz7n2EHP0=
X-Google-Smtp-Source: AGHT+IFUSyjuKhia9bnSd3m+2XKy8hJzcQ9DOE86De5ut0/zfw/syHIlc0LrALyxrMp9Xpe7aEiZMUHElmGsUj1/cvA=
X-Received: by 2002:a05:6512:12c8:b0:592:fa8a:810d with SMTP id
 2adb3069b0e04-59576e0c293mr1351088e87.16.1762969711505; Wed, 12 Nov 2025
 09:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111004536.460310036@linuxfoundation.org>
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 12 Nov 2025 23:18:19 +0530
X-Gm-Features: AWmQ_bnluPVMUosVyxKqvHFL5eHej5lPP_cCQ5Wjldeq2Z-RlGs2I1Xcdqu8o74
Message-ID: <CAC-m1roJfjSk8iTSGNSE=fELNaUORwFmMS6YpwL6B=Ub=DWHnQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
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

Hiii greg,

On Tue, Nov 11, 2025 at 6:18=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k
>

Build and Boot Report for 6.17.8

The kernel version 6.17.8-rc1 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.17.8-rc1
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit : a0476dc10cb160082a35b307f8dbfe4a066d41ec

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

