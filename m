Return-Path: <stable+bounces-200788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD38CB570D
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 11:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4D0630019FB
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 10:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1450A2E284B;
	Thu, 11 Dec 2025 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J21q/YOn"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584A6274B4A
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765447371; cv=none; b=Hxc5bcsc801ZMWzCbj7bYK+Mo+JRfQ19Dil61dgs7wVK6YET/a/+tEWT+ZRFQEjPRAW4oGehBzTPREu3gxL1gVdTkuxwUZfciVPc+Djv3CTsrnaGjXk1sRIBxiCDRJ/TL2IbNmCQzkoMtkq3Wl1UDBcs1QOSPh2X8/nOAGKlVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765447371; c=relaxed/simple;
	bh=dXaw93R+o/MRj9zr+K8C4AeIIxYVXalR0ZpE/LV15N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYbj1pD9VdCHo2Kchg7Av12VPfRpdlL1fMIRYIvjnnwxJuQkyBPqzloXmUWmdsO7zZKSh8Mi7NWjKLmxUH3X3mKwuTJ3rp3W/ie72JoJEGLzuQRRuejRYqdSjf/1f2GFmpkKE3Ysmm/kVnyPP+UUE1zNFItm7an15VlqlVcVpK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J21q/YOn; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37ce27af365so5514651fa.0
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 02:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765447368; x=1766052168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4W+SY0l9++XGnbu/FMYs0nB91d5urXymPiJIGdOaOQ=;
        b=J21q/YOnJdvQsf5XkChzCY8Z3jqruSeVaBQnJdScpFhI8Wmha/k274M7jQO2ZpMC2o
         NUuNNjrV9pcjBu9h8BoOzlH5ReeBUf6SIKqXl+5Kc9qiG8vs6kt+T0e0Wsik7cxiRRCN
         0AJZ7AnFD/PnEM+2FDV4u9B+NL0pXCN1hsYhdDUmQj3qjts6HyuR+5+1zY/pKMAxPVRQ
         XqXK7b84XuF0zv7dMJVngtjmk9LTSf2hSETcRUpvYhZ6iJDmr5/LJgVEkzruolpY1O9v
         MxGwgWtwgynVaumPjc3wS8zGv2Palb2Tg2+FhephjT2hFwBb+UfL0bQK57D+Ce1QuPlB
         IQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765447368; x=1766052168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V4W+SY0l9++XGnbu/FMYs0nB91d5urXymPiJIGdOaOQ=;
        b=iek1rkRs3DVkJg9q3qyDmhFXvH1suginRXS0WffdwGnFSCmCSIdiNFk+vDcrY4OaKC
         xvO4B+umoORNu2DCNgx7WiTpBqp6Jb6Mg6hL94O2+DucXXZODSxfsCJ5TGfajjwgpf6j
         rfYqkQon5TeSFmBCr1aPit/7kJrkFGwyija5/42F1YLmwp7ApEsYqCJksfoUeeMumCDH
         +Tb9yxoCgSYBTbexM/bx5yQ7isN80uXLgbP638UbHnVe2ribNKNXCZ/NmsZ6GzsOBm95
         EDD6+4jyQaUsiTskInjrv53ripizrxhWPjuirB9CiRfzjbXc62sa38Nkd6qesGvxCCqp
         Gldg==
X-Gm-Message-State: AOJu0YyrrzxwsxxXd8Pvo0gzajSD9VXiYbVxsm/f89YlYW8qmX0DeY1w
	0+K2OgMePBf8wkBQfOa7rqR7UJNSEE1dhx1PltY8COH7ilkxUNB2ak/rSXtvS+vhgtQye7iiZJR
	S29O1qH2GUeBGnbcx5USEIjrP9oSm/F4=
X-Gm-Gg: AY/fxX7nKgAyTmZSExf02JdLlruYQ/syfg0QWym2ju8SZxKHlxeFvdizyPqMWkdzEuL
	NzrJVvv/jVPFxEv2LYeJ3HfDI5EKyn2tZPnAWBsfb0283qONmZQ46VkrU+jEiH+gD2OMXe2iCJx
	cfPDEMPjkHW+Dc4QG9jgrpcTVBqNY9eT8CKECh/pUnpdeWBvpwGDG5IB1dIThSn0xrtKl1waCRG
	sJ2cC1ECcPrOfomaXGQBePDOfbb9OhNHdG86txeFNij33gRHKNJf0FaWe0fARodgG+gO4EDkiCj
	J1OqU5cxwYoTf3DJ8JCTQZw4CSSybfZ2yF4b0Sf8
X-Google-Smtp-Source: AGHT+IFIlPAKzLFZDPIpgnt0sLPNEYBWRYuk5a0n+3NKzujEjvPba1ZFRDRDx5s1nzLXH2bRjLyNmsVwJKpuoHx4iOw=
X-Received: by 2002:a05:6512:154a:b0:598:ee5f:82a8 with SMTP id
 2adb3069b0e04-598ee5f8378mr1509180e87.0.1765447368155; Thu, 11 Dec 2025
 02:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210072947.850479903@linuxfoundation.org>
In-Reply-To: <20251210072947.850479903@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 11 Dec 2025 15:32:35 +0530
X-Gm-Features: AQt7F2qrOVU3vTssdHqmPCZo_HyxgtJqiWoQWtPxVkOk8fQOa9WGH63jzLbcpJE
Message-ID: <CAC-m1rrpPDjF=kCXQfAaB7BVOAyRRJSCs54GFffxzhs_g7M-8Q@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/60] 6.17.12-rc1 review
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

On Wed, Dec 10, 2025 at 1:05=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.12 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 12 Dec 2025 07:29:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Build and Boot Report for 6.17.12-rc1

The kernel version 6.17.12 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.
No dmesg regressions found.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.17.12
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit : e7c0ca6d291c41a8a9648a5016ce9b73e492aa3d

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

