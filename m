Return-Path: <stable+bounces-185617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789B5BD88E6
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 11:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D8B1923E71
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D537E307ADD;
	Tue, 14 Oct 2025 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yh6uK9pD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B15301483
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435264; cv=none; b=MLOl8g6oYm85+f4DQ6vvKncoVQW3RWhmm5KoR2uWeoVChF1FpqL+WBpem074v4y/VFP8PAjU2JTEeOBZZ6ENr0vkDfjb9/GjRyOv6h20dvXds8tO9fSmdsJOOrKuhfT7E97TH4KahBXGFEnVAWeXNfUgxN7B4k8IBryyrEpwm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435264; c=relaxed/simple;
	bh=gg0Y24dIYAZ/9swvc+xXneDSBAfqAXZZmkspIAVYI2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ri5aZE9sWAzqSvtyMa5H5ZviF+tkVNJEm1Q7S4jnuoNx3sKotWerOIELhG2py8CZOPGUAUrpd3TUKZDjxdWVfn/+jlyLChRTXV2iQaTEmZKEDzEXzZnGuiN1zjJL1yyd0P7nDsa2OjlcXTpnCLhUjFdvJG3CsKPI9hg2cM/P8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yh6uK9pD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59066761388so5745288e87.0
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760435261; x=1761040061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4ZOiD6PpdYn3ZevBQxNWr0OZs11i+ipFFLHeOHI1Bg=;
        b=Yh6uK9pDnaIRU76CInXu/Zs02t9BkmtK6dFgKkHLND9YEFGwu6Sk5p6KowkvnFLkPS
         RqnnD2Ci/qsB6F2iByUT1Od+pCfs5YZtL7cDtn482h7egyx0NHNbN8B7i692UKQETTaN
         npW4CSGdoqkoRr275lwwjkxr8gGh0aVyqPMobNrPxy9K7axwbzJqv8Rt8jZ/Srq6gqHy
         MHZj0VoF20gX99gCBdefNddtyVUm29q8lnDnDpt3zKVuTP/3mouG3xeONBjo4zgkYqqk
         YDiGJn1VkcbuQmWmtRzH4/QUHdGWeCAFThTP++BtiVBqElE+U+MJSU2OJAdyin1Htni+
         e9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435261; x=1761040061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4ZOiD6PpdYn3ZevBQxNWr0OZs11i+ipFFLHeOHI1Bg=;
        b=QcZd/8LDpokhbk0GmFCDV/Y0dmzm0cYCacCkvw6eDYfw/b3x5ULwog2dhiVS9svoAZ
         o5tFnFtKPapiINf+/74EULV0SYdwKLSciH9XyYjz/VWdadLUXF88HHxw5XnuFbN93jk2
         X0gb1nPMMywkSr/gRYVZXfxjcxhcAzXdQd9v0OjbNOPSU+l+pmt5h4sXDbBJmZVwIlNR
         QpB9CUbXuOj6S2+c+myEN8lzsXSHFdG9xWhRfdACYUvo4FeirB3pNihwwiTmaZP47CBO
         R4kQpUwLbECNko3gD4iu6hs/s20KxB/eTFDJc1Mulim9BWshC7JXWHs6Gu4ScFSyAZUb
         Tytw==
X-Gm-Message-State: AOJu0YzpQqAnvyxES3NUPnpMIzAeIUm3mLfvv8R0sJiq566GZ2lixuET
	cIbnWtq6j24oFgTPfaKIAqCnZxPMJjxrv+v7YvK9X5ere60CRl3exdXHHLlYu7q+GLGTg6Udm6R
	cbjBo+bYacA8pV7337B8CT4daJaBG9Dg=
X-Gm-Gg: ASbGncuMP2tgsNO73fjocw1KgMQbL6poezCbUGtX3+Xhpr3jIDgHISWFq9A1i1Ngy3h
	JcSDwJLSi4N/9AjF2N/BTDrlGgqM4r9Lrpa57GJ+/seBWtnfX0bYYQ/xq+r8xpQHF8z9YrvA8UF
	y0F/gsm9sLPhoLhcQSkuCYof1DLMwa6khVOSYZYdFxaqnZPKcNrYDtjmU04HHQQS+h2JgEtzVWd
	TFSDGmwyjAdw+KubFeXYgsO70uYkRsDcry669CJ0FqtY0tv4kcGYlR5S6kfq9EcORaIGw==
X-Google-Smtp-Source: AGHT+IHZa0dg20bxTZleVf8/nqgXxeWzjDoLOqtzcYvlJbfHC0d5D8BumL4rdNdePi72Zvo3aOThOpktfOFcMoXIPSc=
X-Received: by 2002:a05:6512:4004:b0:57b:2783:6d3b with SMTP id
 2adb3069b0e04-5905e28d7f7mr7752126e87.20.1760435260750; Tue, 14 Oct 2025
 02:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013144411.274874080@linuxfoundation.org>
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Tue, 14 Oct 2025 15:17:29 +0530
X-Gm-Features: AS18NWAUa6UI1O8c9zp05XyFaeYEUd0eTcQl_Kt5SBjjdEaOPLRH23oVpWjCIEc
Message-ID: <CAC-m1rrMw=16q7h_jVUkQkxv3scTrBZQ=ctyG_yz7GzhNTx1NA@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/563] 6.17.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hiii Greg,

On Mon, Oct 13, 2025 at 9:29=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.3 release.
> There are 563 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.3-rc1.gz
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

Build and boot tested 6.17.3-rc1 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without any
issues.

Build
kernel: 6.17.1-rc1
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git commit: 99cf54e7bd2fde42d75c71b54fb3652adea2e7a4

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards
Dileep Malepu.

