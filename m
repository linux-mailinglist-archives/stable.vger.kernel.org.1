Return-Path: <stable+bounces-200014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA27CA395E
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 13:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1E94306A514
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 12:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD0633D6E4;
	Thu,  4 Dec 2025 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh3btHLf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91850338937
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764850806; cv=none; b=Nn08Ub/MPMCik2EaJ/608QVCp4uDDkGasrGAICP3mHCwt1j56QtEsqWKavUJEiF6P32VfjjvvTSlzyu2XLsOd8G+zrnYBfUv7+L0Ym7ZtnwJHgyhZzvnDlFScORlXPeH87J3xfhXIoqm/9qmJxK4pnRtb4AoleDdiwB+EnVAqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764850806; c=relaxed/simple;
	bh=Sm+2aIqqw/aJL0UULdrPGtoo9777nMIW6rAyg//L9Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLbUtqXTPT3xRn5FK6KNLIg8Mk5iS+6uHshArAf3IImxGexqOjYgdIiU+SHaKrspnIgMmumO10Tjbw3sDTCwYgCgzBI3X0IQnJFBIm1PJWpYPCfV9vJYMIDTH16qh4I8ZMCFIyW7I8mdzDFSMNQn/F0L813vKmtfgzK9L9+b6P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh3btHLf; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59428d2d975so833852e87.3
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 04:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764850803; x=1765455603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVE6hBdJYPcwOdHbdSZFSWUTtXmvEkPiG0rIieF7pLo=;
        b=Qh3btHLfylpomHJmWfUcdGLx6Z36zu5EGHeRIhqZ5Y6Cs6KEjv3bkRWEN6Is35kMcO
         UrowiAVSwPoN5eDqzu9ldmpV7vuR8GSJ7iMGmFl1MRwxYyM3QDzwdLFi4XlXBX7xomB5
         Lhfz8CrfGavr8X3QuJQIOxGlMLJKWwWZSQuS4TSx0ovxU/g2puiMFxXmb56jBg4IceHk
         I+rOUemnbqMfdMWa8zLNMn2H+dQpJoflIypPC8kV0b6bdMNQ7JLkTWd8/i7HvVvuBVz4
         uBhdFWTH5YY0Eanz7K9hz0Zip/srBwUjSW1Qy1dJ6N0iMKeRnWAR9fBG7z6W79Sb4XEu
         KhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764850803; x=1765455603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PVE6hBdJYPcwOdHbdSZFSWUTtXmvEkPiG0rIieF7pLo=;
        b=mFPnXPoEdV/4BPXQ28+PX1NWwS3wh915/EbLg2n8DQAyxsiM6RjJoIwu23CuCw492F
         66N+FxqQ3axK29IKH93z+gmoj4WaRkprPIe3+benBz70VSnJSzkS2+WKJZmu1DlaIa4w
         jzNNJkb7rjEHp+CBEf5boZ2+ys3SEKl4vj3Kkn90Ipjd1XucpjVFv2EtZzTVkUIfUD8r
         54PrYqZK92Hy/WlCfW8MtUoTWY89X9V9phAC9vqPL4HVxRU5DhE91pmjf77uLvKBeQbD
         m0qxY/fUo4o9l3g8sbtMQ9NwyN9J0trMR1VB7qb4QVBWlh0WVcwPGvjxDDA/TVHan7AT
         XzkA==
X-Gm-Message-State: AOJu0YzykhvRMvIlr3ibaw1rBZxoihNopYdSVPTFDVtxN5nQWW3heUKE
	roI1/iqp+iZr6MAzKK2jLnVKbjxKJ4rjo8R8LM/wwFSdxkt2K6ItF13mxcHLA5ybO2HJiOLzYxk
	PoqmNHTHMVyoMqluw9Fcb2tt53YVUWW+5xPti
X-Gm-Gg: ASbGnctiT0zyAEt9A1M2jeVwnAmdI1OJD4t84eGnzqU+0g39hOqGp925ObEy1LwzYvJ
	FIi0TTqR2xTEyyDar9QHU/v3OdvMJQoQnN8JBs5dm0NkhvHURhaWylnjUPEr2xyQ/ORlygapWzQ
	kzXJV8CBlm3wtJ79Jg3PgNVvLw/6l587ESorBj2e7bUQro6ua8b7fbpBChbkqCYYXJ2DyP/7od1
	Btyxi3LbhNjsMLckHcAbv+gP04OEKRrVSfUsMBPDtt5xAbi5yrsaFhQ6U4Pi2yLhHhCZ3lIb12H
	q9IFwEpxyl8tdsoY5zbC8iqEOxQ=
X-Google-Smtp-Source: AGHT+IGLvxVV/M97ZmEkGVvfo4Tf9FL4xyhf//LVP5ERW2nQ+Ke3B00ZYe6M3S+hezXlFm8a8YvGZNIvlr6TcLp6yAE=
X-Received: by 2002:a05:6512:1304:b0:594:341a:ab1e with SMTP id
 2adb3069b0e04-597d66bf1b8mr991213e87.31.1764850802355; Thu, 04 Dec 2025
 04:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152343.285859633@linuxfoundation.org>
In-Reply-To: <20251203152343.285859633@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 4 Dec 2025 17:49:50 +0530
X-Gm-Features: AWmQ_bk0f6iYX6aUaNOnG7cxZkVHJ86386Sxl9-0SaNSWSqrFCgcFoUdQC02II0
Message-ID: <CAC-m1roWM-JydNvmrt0+8XJH4ovapPjO6oe8V0XwA2=xV=Xw=A@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/132] 6.12.61-rc1 review
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

On Wed, Dec 3, 2025 at 10:27=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.61 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.61-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Build and Boot Report for 6.12.61-rc1

The kernel version 6.12.61 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.
No dmesg regressions found.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.12.61
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit : 8402b87f21e8163831f70759368ad9a87192eb40

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

