Return-Path: <stable+bounces-9016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACA28206D5
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 16:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9791F21684
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50248F65;
	Sat, 30 Dec 2023 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="S4SKqaUR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FD18F5C
	for <stable@vger.kernel.org>; Sat, 30 Dec 2023 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28bd85bda06so3583791a91.3
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 07:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1703948729; x=1704553529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TEYAiX+bNQzKptVufen3ugGP71A82gfbOiCal17chk=;
        b=S4SKqaURfYE+r6c6svDG+4FCeWB7lpBP2h5TxRxzls2gvQIJa2h6EfLC9Zu5xI5oC2
         UuyFZPIkZly3ZXaz3ldnhkHIk/Tx41b3xCZo5pGyMtGLns2GFeP/KcGItGalW8oTMjIG
         H3sSHE2v0A5bAO1dtUkdRyOt39MAv+CeW601sBz8H1cRH1bpof69lGV7d6Z410DmKl08
         /TPSmchLpbflHPqL8epu6I5CR/xLVnuKEFQ7LF9oXUaAQAXmyeXnUtnD5qPt1N6rRQjs
         zfdOzCFNBkcsCKFj9523inOCu2YONXRLEZti8nqzgVtUOXTn3W/2z5l2O4x2v/jMNru1
         XM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703948729; x=1704553529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TEYAiX+bNQzKptVufen3ugGP71A82gfbOiCal17chk=;
        b=paDe9aWW8hFsWmm1sNkZnH5+Mumcq1vah6JqU/7Wl8a1BzGQstaIl4uXPNhX5+6bJj
         tWtEA76DfojcbzA5Tc5jYYn5wPTNQdexyQwW5M2mQaLPOZ1JYRkxYrFn3Qg3eLETrq4C
         IgGT8o6VLqm/s6le/T94/giN/kDWVWFX+opQlHe3WeC57kL+uGsl6+3zTZk7nTvrPNum
         VDyi7+NI3WzCauxwmZH2Qzb5DVWNuGfhjs0iZoKxJaO9Q4hEqS5ebtXmCwVYdbQ0T4S0
         s4ggADUXIPA0bci2DLV9LYdoR4juEzDM6lPz5y+SMNIKsKVIGHkcM90MkfN+VXpKoJ6i
         5QQw==
X-Gm-Message-State: AOJu0YxrL02PjgEHQczgBuL0jFJSz6Ri6vHYTn2qQLemCdPfQBMN/NQX
	dwOpcevPi06xXrHAE8plb/XxnXd3VJiICDJtHPMfDSsG+p8Aqw==
X-Google-Smtp-Source: AGHT+IEmKJ6+SVcBplkQkP6nIVcPQFmJeBLzWGJdt3El4x6EUmZ7FEIfxnhfLwwI27JJCMsJdHQs7z4nykiFFhUIj+g=
X-Received: by 2002:a17:90a:f182:b0:28c:3b37:acb0 with SMTP id
 bv2-20020a17090af18200b0028c3b37acb0mr3473793pjb.17.1703948729452; Sat, 30
 Dec 2023 07:05:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230115812.333117904@linuxfoundation.org>
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 31 Dec 2023 00:05:18 +0900
Message-ID: <CAKL4bV5hCwCxCX28akpXFE178ny0s_rSXuJK3JYz=RC6z=tYTw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/156] 6.6.9-rc1 review
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

On Sat, Dec 30, 2023 at 9:01=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.9 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 01 Jan 2024 11:57:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.9-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.9-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Sat Dec 30 23:43:57 JST 2023

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

