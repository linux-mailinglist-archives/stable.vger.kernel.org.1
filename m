Return-Path: <stable+bounces-18788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98C0848F96
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 18:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1790B282FAC
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021E522EF2;
	Sun,  4 Feb 2024 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mpa9jL+R"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315E5249EA
	for <stable@vger.kernel.org>; Sun,  4 Feb 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707066419; cv=none; b=IuIkFDH1W8Dsixdr9KYDPQNI/2wIR5rlx6XnS3iZIVhEYah28MqOXbCxpdGAN5O2Z10fmeJV8O28ZNA2JRTM63WGs236hELnqB5wLdveZuyaQ4lKEm2O2YK5wCu2xrzKMu0ZMue1HX/FFFwK7JTCyKNXHnoRB1XdKTQVmp1BcqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707066419; c=relaxed/simple;
	bh=ByeceGA27Ixs+UrMZ4SRTFzcGbuGmGiLPFgcM7emWsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCfvRzprrNg9x8zApA31fN5WfvebvH8o489s37sK7uGQg239AVstVbG3F8qWj5P3JRBA9pA4vP7RHY1KiN7ceqoG5PVATNJ95CP32gllgtsWmpRpTc+6rLUTgpDRcYhqdLA27FK2l1yD2Raqij0cDapnHqTYXqcgY7kyiTpXADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mpa9jL+R; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4c025d5329dso144373e0c.1
        for <stable@vger.kernel.org>; Sun, 04 Feb 2024 09:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707066417; x=1707671217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fi4AuTTvC82QwungzGuHUs4Rd+GX71D+j2MK7Iqe+OU=;
        b=mpa9jL+R7s/5qnfcE43UTUvnMrgYZuf/h08uQEkxBBMRg4ytgv8PF5C3zFonlHx17z
         bYzS/N3yx7xbwQi1kOb4E3JJOynbt/W8Q1RQjgZKj+nkkXcwHJ7yCzSU0nDQ7e8BwilC
         oDkmT6zpZMo1IgeEvTK0P0bRH68KC49oi9Z16U0od0W0AgNsv4avx29zU/tcS09wP+hG
         GaDBWXD9/icr9aaz9AN172aL2cf4oaTlATGmOjVdoU+cX1JiX4en35FUsAXi3lwkyx97
         U7iJT1s/2WG/DQR8knsSB9jiJB4RpygqdvXSCSjYxc7AWToK9AgVn12BOy4mc3eRMqBu
         2xHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707066417; x=1707671217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fi4AuTTvC82QwungzGuHUs4Rd+GX71D+j2MK7Iqe+OU=;
        b=gWiIkqiGxHCQeBaJZyEbWGcJ59fLOsC7Lcmllu3HVrNJs5Gv3m0exZcXPEI1iVmT0k
         VHkOTzHp6vK6hVVzbRcBr7L/NdWtMRjHXt/+MaGNFLk9iUMWYTY3D7Vu9YKPj+K9mwz4
         6jaQcIsXxXhX0UghMivwkvDtVx90tpNGzOmidHiCVYwijTDP9tTxQOYQ8Q9CnACEcj/X
         oDLq1ll0k+FVO5Vi4IR0NjsjeJsMFVQyN/LIFGIvLz/9CaBWBKtJGkf79VEkNkVuqft1
         460vhEalfK1LnYSBcvEenOxEqscEusS1lCHZaZ4ARNKMx9bAN1NIBf7/DvC7/tGy5aGv
         ijbg==
X-Gm-Message-State: AOJu0Yw0kx3oYJWQbzaNRydlN7yA9l7/grdPv+jwdMOhhvrMfrHiNWLM
	4bmgOFqfnREmP7Yw199t7ttHUOD6xh33JAftHxHMlk0AY5oRLAp7V4UM+6fygKM0aYSaAH+Lw/9
	1dQYPvEfsBgX1VsHejmkUIaLC8mj3e7rvDnGyBg==
X-Google-Smtp-Source: AGHT+IHU6gSbjHEb/W7OF52+o5q4BiVoPlZAYWZnplufKFHK468DFH7McRHN63v7vk8gRYVWC8JKd6ssMXUt4Wa6NWw=
X-Received: by 2002:a05:6122:2001:b0:4c0:2b39:dc86 with SMTP id
 l1-20020a056122200100b004c02b39dc86mr306387vkd.5.1707066415531; Sun, 04 Feb
 2024 09:06:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203174756.358721205@linuxfoundation.org> <CA+G9fYt2je2FKwdgm31isfxF2xm+HAZ-+vfwmiXhS2SpdBGLFw@mail.gmail.com>
In-Reply-To: <CA+G9fYt2je2FKwdgm31isfxF2xm+HAZ-+vfwmiXhS2SpdBGLFw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 4 Feb 2024 22:36:44 +0530
Message-ID: <CA+G9fYtf1Ui3Eb_inQbDuod=0hTx00cGXFJV19xKu+2epUASwg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/221] 6.1.77-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 4 Feb 2024 at 22:27, Naresh Kamboju <naresh.kamboju@linaro.org> wro=
te:
>
> On Sat, 3 Feb 2024 at 23:22, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.1.77 release.
> > There are 221 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patc=
h-6.1.77-rc2.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Results from Linaro=E2=80=99s test farm.
> No regressions on arm64, arm, x86_64, and i386.
>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> NOTE:
> ----
> Following Powerpc defconfig clang nightly build errors noticed linux-6.7.=
y,
> linux-6.6.y, linux-6.1.y and Linux next-20240201 tag.
>
>   error: option '-msoft-float' cannot be specified with '-maltivec'
>   make[5]: *** [scripts/Makefile.build:243: arch/powerpc/lib/xor_vmx.o] E=
rror 1
>
> We may have to wait for the following clang fix patch to get accepted
> into mainline
>  - https://lore.kernel.org/llvm/20240127-ppc-xor_vmx-drop-msoft-float-v1-=
1-f24140e81376@kernel.org/
>
>
> ## Build
> * kernel: 6.6.16-rc2
> * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> * git branch: linux-6.6.y
> * git commit: 8e1719211b07ef9172b231100722f54ffc23ed27
> * git describe: v6.6.15-327-g8e1719211b07
> * test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6=
.15-327-g8e1719211b07

[ My apologies ]
Please ignore this 6.6.16-rc2 report on 6.1.77-rc2 review email.

- Naresh

