Return-Path: <stable+bounces-206140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4799ACFD9BC
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 13:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78E89300DB9C
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 12:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432C4312801;
	Wed,  7 Jan 2026 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="rF82IAUJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604AE2F657C
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788393; cv=none; b=Z3gIrNwe9deRalbCGyF550B5bekT+OiF569o8pzRGLeSSKLW3bIpng5GzTel97QV1D9uoS4oczOsO+4Ao0Niz+QmKLqIQD/rkJ0s8BqxWzT+uYDlluVa3on9lGPy7iaRACwRZi/J8G4Z/kGut7PtWTDuy6qDTywyvmwFrL7fWK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788393; c=relaxed/simple;
	bh=Mu1+X8A0XxLtnlBs/EBN9zzVFOHeTf0WZ4E98xG+KMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9Z+seMnHckhIUOeO0920fG7v2lQwIZ72toZ/ErI6QMwCQWIAA3T0UZ1PnOJaKdtsC0pCS6YKB+Gr1pvXBAxkV5mIe2Dc396AhdY7NhVznax/6GKcWajuM/pA/YHKTJjOvZ1eaN2eNIJ5beZ+xlQB4Mood6ghSTgwWPJpY+wUmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=rF82IAUJ; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1205a8718afso1569553c88.0
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 04:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1767788389; x=1768393189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvuE9ihmFnCr8o2OGtZIe27QeseGcOqNk9QMk+mpu0g=;
        b=rF82IAUJlEsHheBhF36b2teQsu+GHeGj/MaRX65hS0Bptqs9ki/o3koo1/NFpbRzx4
         f5S7BxC6qZ7xIdqksJBxrSKpGdvf+Tm8rP/MVP6aJt18SEOpvzrgPpEDisSkmMdYa86C
         wIBCImLZ0ZPz+wr7aEubzJjmwNtGg0vuWuxue3rji7xWdlUaW89SG9TwW/BiCc+3F78L
         CBcIUtWQ9hS7u7Nu/A86ZeUNwZnpRlvmXuSsfksDZ1iuRK3v7SS1m4HyiwECw8nfx6t1
         FwJzolwQRwU6EDAb1GJfv3+/XyxDn230/+eua2glarovg3yprDnsoMsFgwGBIiiVjUZV
         udTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788389; x=1768393189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pvuE9ihmFnCr8o2OGtZIe27QeseGcOqNk9QMk+mpu0g=;
        b=XIeMwhbQjD3oemn4flcRjd9hYfjswDsHoeEq/wxLdJTiIlSzkM2rn5xr33N4sRaVek
         2Z+hBJd/KEhrIAVfmJuJsDaJpSemJMb5Uo+BcsEirqJllI1nZjcuUj4KBNWnhRylm7ll
         izO6bddATnrSecnfkT7SkOJtetvkBXyTSaM9iZBDIab3qB8/runuv8xsBUJlMAHl+8nf
         VlXjHhpF9GFguiMudY+HvodxT3z+87LNizCQbBc4EmRe06X1TUohJF5dU8u7Yw7e6DFO
         ZYQ9iqCJsWDvP+HVfoo5S5ED4rdEZ5ik81kYxHiaJVokn8FiMlS5V9NCGA5C46lXETg5
         m9Ow==
X-Gm-Message-State: AOJu0YzVfh73TX37rqoEz7MJ/FpjM4N8NnCWEZtoXVnr1fV8lQ7Chp2h
	6vUOdEy3fEcOXI6ZfkOxKj029te0X5bzInP4QXKa2C58/gUUcukRhVeDSYXfGPPU1RB/orIz95h
	nuQFPaB6rLk6ZiXkQwzsddYF0oXNw8aB5lKI2q2Okpg==
X-Gm-Gg: AY/fxX61mE9d/1DY5Dbi//wzrAqKqHDWYBOQvc00MGbSi1UtjufZfuqf28IKxxEhG8p
	2PTlARqfIDVcm0xyoT7e+A5qfnR4Hdp9FKsMEnkyB9729yi9UZm9OPjKOhQoisbC48lXuGi83ZX
	hCD1ee4gJ/6Y9Sk2aFmyQaqI+qysku388D9mq8OUw6khZjgj41byEVNEHVxsMtT0Aj5gK2+Q2Qe
	pu2bWvfaiW5MzmQEOS79sT9x7vkg1tQjgcPtdOG5ooVDIuRwOz3Jy+2TgfyZv59qtJ6w32UTdBZ
	gsoyZ51IUjksL2tPRr/bURmo+OHe
X-Google-Smtp-Source: AGHT+IEft3dUm/8D/0fazDdjnIvv6B0r6uOHtwuQTQ5AJ6PLdsByaL+oeh7g9t0imBgPdmNGxDZXaRbbbRdl34DkKFA=
X-Received: by 2002:a05:7022:609f:b0:11b:9386:a38c with SMTP id
 a92af1059eb24-121f8b9d9a2mr1756023c88.47.1767788389155; Wed, 07 Jan 2026
 04:19:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106170547.832845344@linuxfoundation.org>
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 7 Jan 2026 21:19:33 +0900
X-Gm-Features: AQt7F2pjHlkRuctOjxZHGF_9I6pM9iXzbiWpVFuOQU8IzapoOg5lJtYWzMdAwIM
Message-ID: <CAKL4bV5FRteV1L23Vdu3xfkvnibXeg0Z14ghV1rXPEFnxthpZw@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/312] 6.18.4-rc1 review
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

On Wed, Jan 7, 2026 at 3:41=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.4 release.
> There are 312 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 08 Jan 2026 17:04:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.18.4-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.18.4-rc1rv-gdc7c4cd6ae5e
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20251112, GNU ld (GNU
Binutils) 2.45.1) #1 SMP PREEMPT_DYNAMIC Wed Jan  7 20:49:02 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

