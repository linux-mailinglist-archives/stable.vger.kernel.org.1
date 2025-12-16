Return-Path: <stable+bounces-202735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 497C4CC50E1
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 20:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 732A7304066C
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 19:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994A43370EA;
	Tue, 16 Dec 2025 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WedSVydp"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79393358AF
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765915178; cv=none; b=HalgSKEjByDh6sSXTabj1TaRdf24FbI2N9ifcOjkz3e8cT81k7yxIz/uBw/7lG565Gq5afhQEOjA97zJP1/jOB1rmt4x5BU6fMIRogudm5AWCGt3dY0pyjZJqRVdJvSgDSol20ktTxD9qz6ijoVvmYZNiFddl7zta3qYskOUDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765915178; c=relaxed/simple;
	bh=8d8vMlcuqrcetGiukAccRMJhujaTPxUi42V0eQLoMBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUOXw6f/xvDL7+iw4mPJQNgCn+xr9j4WEvxHf3BUWBbeb9d/fWrCrXM26qmn7MzqLqiPpDsY8GluUkiIuSbyfKUbH3RFCNS5GTuhRgH7LyYRYI9TGI8w1Gp36gVSVRWfCtNRqBd9pPwvNzdlsHIOhqdQTXHYfnhGmsNDbsfaqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WedSVydp; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37b99da107cso49339841fa.1
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 11:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765915174; x=1766519974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKP3/pV9HL8rJ89JiBKTKQm/pSwijNbQxYatjpzb6Ao=;
        b=WedSVydpy85NYKGNB8ur8X7mjR1Lcu6Amn5VLqvNvETFo2PrM3C0CHmy8KxMOePviI
         0WrEyvVL3pa0cE76LMi+F1D4F2ipZzvaDALNhbcWaVDPOHdsJXhCJsaxCdMmRDhOXx5R
         szEAn9fFCJfDTjSeQqKdinBchJddm5nnQHYnNwcIWQGNbLxA2+NoqtYONLOftkLdBhG+
         OFIkQv5Xc66GnlWy+BfmllogRY8lSVBDsFqLEbVJ5smJK8GG4ONRZiujZPMBZhfEORIC
         vLmLPFAG0xGYBvmH/Qa6d+g9EnzLBve0MX+OcKz+w/aOhV53mY1GaqVT9ow993xNi4nF
         MyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765915174; x=1766519974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKP3/pV9HL8rJ89JiBKTKQm/pSwijNbQxYatjpzb6Ao=;
        b=M8bWCVx8Z3wmBSBiYE9X59G8HXsYnDAUK4MBwIDubHQsVTzHXPz51BqVdgwcMMgY+P
         x2wtsPi7cT8YJiHhqsvVA6+kw+vCXdpAsWNbCDqXFSy6BTe9tgsayuWRjb6UVkd+jNfN
         GzPEx2IruHCM7pKHsqEuj+wls8H2tK6FhOdi7EwMMfGbyw5e5Mv12yxwnD0kt7UQxMCp
         68bXzyIa/YPomjYWfVf99bIYIMG1sEy/4YrdpJlvS/PQlIopel9j0r+krcE8Yb2Q7Ln9
         em8FNJz3Z27wZ8fivaVm+7U/VYg9Ecm1wJ5scbjc0GAhVXLT4HPQ3qF3Q+TSj3pCoFG4
         LHOA==
X-Gm-Message-State: AOJu0YyMgJkU2G8kC5BqdHKvS9iMPvMfOq3xU35AyI4S/7imVsobU1CF
	USl7ljs+QccIJMTpzW9jgewAZG9yyoe7exXEU5oywPVBTavDElmy1jkPE1KtIZt06gLP4vBUUo2
	6AZD5HvLOKDmsCxjpP+YtWqlDqI08Eg0=
X-Gm-Gg: AY/fxX4+Dx+oLhOktlLxZNxhYjldzwoA0A4YgdYr1cfXfC/JlqzJYELjZVQDd4IGD7t
	/Vz048UqYCbdvJxmz2Dn7d5qKPuSoe9Lair7j9WIGoMtytGlCWcNA2dhnxFpAlGUUMewE+RO4Xp
	G2YL3ZBrww3XKtI//lcbkuXQlDPK9emX8nYMve42VRg1egSI+74CDDzL0EDXwW89BA6C1GBVqQJ
	Kg6h/ut3d/30WHs6C7mD4HmDug4Ab1vPml8FiSdVNy6eRUUv7FYwZtBdvkmJ+gwbh53BQOWrNGU
	Q87DCOqhDTnWvzD2BUkcSoKjxmfO
X-Google-Smtp-Source: AGHT+IEoOwx2O+UDgb2f0yIKh4N1D7Pr3XV6xfDNke54zDaPEw72IJS4jRqNFlBTPI0ntktOfvWQhWxSFoYmzXQrTsg=
X-Received: by 2002:a05:651c:1c7:b0:37a:2b5d:e855 with SMTP id
 38308e7fff4ca-37fd08e94d1mr48591801fa.40.1765915173887; Tue, 16 Dec 2025
 11:59:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216111947.723989795@linuxfoundation.org>
In-Reply-To: <20251216111947.723989795@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 17 Dec 2025 01:29:22 +0530
X-Gm-Features: AQt7F2oW5vTlzd7FXzKICbt4nLS9t6NSWyDjk-BuP4m6qMC0a_yiDrofInRso24
Message-ID: <CAC-m1rq9fSvZf5cPy-zAj+vYk3=nODsfT4QL+rcuDeCdqbfctg@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/506] 6.17.13-rc2 review
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

On Tue, Dec 16, 2025 at 6:40=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.13 release.
> There are 506 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Dec 2025 11:18:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.13-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Build and Boot Report for 6.17.13-rc2

The kernel version 6.17.13 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.
No dmesg regressions found.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.17.13
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit :

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

