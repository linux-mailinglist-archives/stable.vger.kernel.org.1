Return-Path: <stable+bounces-118555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0CCA3EF1F
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 09:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2543B56CA
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2357A202F8B;
	Fri, 21 Feb 2025 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="aB/+4/3L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C32F202C23
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127888; cv=none; b=A6uWdjZAsk2R/srAuapV2+Ll/ZmvXgs2dO1Z3a+KPeBrM6CDTSpHpUGJx6hFIugqsGvjYOY2g7EUUYuD9ckedZpndOa8RTX/FptMKLhuIClDJ1i5M0nIzDmI1k6z3ZOKS2Rtwgo7GGPGEjvFtq04IzLToepTrGai6VaW0O096Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127888; c=relaxed/simple;
	bh=j/wOYnB67jjGhylOIqHHXdLyAsqr7kq9q2ecSsLgwdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwBrqSFHqiP+TrstLXHQm5+oQBCEdqSBRqxeHt6r+Xn7t37Lnalu13iVifkbdUCCtpGguDxSJZBnv7zMEHwWOnnekShTjsVIX8J3hBih9liC232vD3zGHdg/983hywHpTclsPl7HZPOv0bI+2tbC+7bgcVO1nMpSSohsXSqqarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=aB/+4/3L; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f42992f608so3017177a91.0
        for <stable@vger.kernel.org>; Fri, 21 Feb 2025 00:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1740127885; x=1740732685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO8S0SaLHILveS4ht7ABmq8EQhy1d2PZCdXORUNN1qU=;
        b=aB/+4/3LeZY2VcBpWCSw1l76RmbN5kLS5h5DCWOocNB5ZGmuaP4Y6uEAzJiw7ny/Ri
         /w5QEa9ENrXr1lRwB7GqCKBwUYhy1h5ebdLWIgvfYh6PF+W//xT5vG75KZ3L8Qrpria3
         zpmbqKmJNLiX9CPbKqjaItqV3w8Hz/AC9jjJH6AAm3uMmy3pJ7no1DAxGudMyYKEgyal
         zvgg12RmZwfVqe3XnS3PcpxzB4JbseLQGVre65Hji1Lg6eNUMApGazNmR/RdHSC1tItb
         rcpByZRlt7WeuOK8JkQSrsW08bVsCwuJO/AzFEsC1PdN5fW6U4ScARBNWsps2vdbj/Ro
         RI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740127885; x=1740732685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XO8S0SaLHILveS4ht7ABmq8EQhy1d2PZCdXORUNN1qU=;
        b=CcsPBIN3l46UhLUlNWs8w4uJdD/T+vxGDO5m47+nUzLjT8T+V7USb0H9IMoMW2Vv6v
         eaGjuyRpeQjpogzS3QNMHSUGUgYGQw/157kIX+vZtfSzADBdXreC3Gcs1vj3zS8RvPaM
         Dqnyvv02AHla72LYySfhU16QvhdA173aboXp6b8g2J71Yysn4DQwwsCKcwO8h1vkb8Bi
         WOQKLb9ZZI2s8W5VzLf3hRW4NAosH92WXbdbVQ9T4Dp65yKPqKVmAruX9MBwf4fgOpcu
         cE9UsC2GO8FZoRW/8Ygm68Uioqr3Kptz72e+GK3O4kuuplJmqEEBpALIeCovnSpjNhdT
         uKdA==
X-Gm-Message-State: AOJu0YxXy/AM32mpeAfFP/cX6LGJ8hW6HHN4JcRaK0AjLk9DCZBIerQH
	D5ux3oquSH7ccVzPrtQntA09/OFUuuTjL34wUYSBp2Npq+3ZMTlRzon5h41D2yUKxlgahbM+nPO
	ijcAfHDGuwmNH3W0eOzPGkPwVGHze9iOVI0/QBQ==
X-Gm-Gg: ASbGncuDZ+yFw7C307I2D5iZlmcmFsA9kMO9lZR7WvOUKOJYf4pKDKYfpQIw44BwoSH
	xNnBv4GQWtjNBQSObOqdKhzbdu0CtKZXc7zMRYCL0+eatQNtlwPabsDMK7r+pRcG9VOj3ZA7xQ6
	QxrAPLQtc=
X-Google-Smtp-Source: AGHT+IEys1/8M/P5ptc+GdcwlwtIRcEANusxbYrUGgN9ECPEJXUzZ5K8uZ0Zj8B3SEJuEhZa535B38wLxLJpyCPHfMY=
X-Received: by 2002:a17:90b:1dcb:b0:2f8:4a3f:dd2d with SMTP id
 98e67ed59e1d1-2fce78d1b51mr4418486a91.15.1740127885545; Fri, 21 Feb 2025
 00:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104454.293283301@linuxfoundation.org>
In-Reply-To: <20250220104454.293283301@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 21 Feb 2025 17:50:49 +0900
X-Gm-Features: AWEUYZmUcCpUlvaYFgWvcXhbRnoQJXLD6KDcZQvtYu61SAoEEDpaEQOuReQ8_i8
Message-ID: <CAKL4bV7rLDPWnveigQc3ak9O5aUMNM6iQ+h7Bki39fGH31GcPA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/225] 6.12.16-rc2 review
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

On Thu, Feb 20, 2025 at 8:00=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.16 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Feb 2025 10:44:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.16-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.12.16-rc2rv tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.12.16-rc2rv-gc3d6b353438e
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Fri Feb 21 17:21:36 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

