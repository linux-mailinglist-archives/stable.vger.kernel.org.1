Return-Path: <stable+bounces-196822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8166C82B65
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 23:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7735E3ACEAD
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 22:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8563451AA;
	Mon, 24 Nov 2025 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjS+27sM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4B73446A9
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 22:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023739; cv=none; b=S2OMuukFg3Y2YhE/GGvjteAPWCmOW2lC2ncAgUe6eg7/UMk6LFZVEFolEHtd9ek+xPE7TInVPG1h1LFIwPu/TGcB9GSJZYnJwM1BJEhanagtbxrwMJWUl26csUwslWNXnz43/USkjw+sp9vMhDWUdTw7PW8YfTNL0cF5tjIRBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023739; c=relaxed/simple;
	bh=wwn3C6SmwXX7qD1vR5eRR/72OXtljhMYw/HHmwjIllA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tw4CLvFA26p1YDC7d+/efFUamuco6AXOXsJgw93UZFm21AtZAYhuJ948jgTO40xSHUI8QWs1+9EM22Ds+b/HBOPf4jetjo68s8cr7zFYiL8G1gM5SXHdtGTP6zqmfe18e9hC8TGFxuwXbr3wqsiPNh7CW/tECNPtooVXv6VquVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rjS+27sM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2980343d9d1so33085ad.1
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 14:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764023737; x=1764628537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rm7sHRT2eanco6NQl01CJ9NC4dDuPgnR1DJ0V4Elc4=;
        b=rjS+27sMFWiTYM9Eb9w+M4Onv2sj2pI9vqKruw72DlG7UgyOmXNe/TbvPGltykwrST
         xtJuxhJYzfWgXYe3gY+y73mJXoe58AE7aPUybe+5MVaiLY1St3bgOYZ5b1DXKpf0jMM9
         oCmkmXnaI8YOETPV5EGblaxTxLE+dtf4d6NCMbbC7kd1DNpHKcOVjqJ0/I0cnMp71+0A
         89gMns67Qw15/xZSHTs7OXZE8OCe4z819w4U4/46y1tYImbxvAZt9G91FhDIdqFKKT5b
         DDplfTCTF8istliS3RZ38bHyrOVxr9c8EMGs32yHAJtTKSKUnNjWwu9YmLX8Xz0hRgag
         xBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764023737; x=1764628537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0rm7sHRT2eanco6NQl01CJ9NC4dDuPgnR1DJ0V4Elc4=;
        b=UtCO2neR3ZgCQ29GnSXNM8pdd7V0fMtjfmHVJRHaZxcShLsU2m0yS90R4wp3mhHQA7
         A3NJ9SL3eVmG24lI9QvWNlk2DAsJ1nYJWJGknPEiTB0hNrVYTzW/jJbkOGpQ1s3B+mB2
         6rr8g2cFbNrXKObkIvXflyuRyMPcKnB1u5DOXh2lM5z2044BN4EKmGy1yrWoZ/biuJHj
         vmNj7D0QUnnLnTx/sDWD3TvX85eTd1Ui95B+A9TbjY5URisBsFE4VZkPVDrh6DZgrfuU
         13QiJpTcigM1mQMkyiGK3KmqwoUvglMQkpDG5fxLE0vUtl2pkripmshVgHVgiIkaQjvV
         jR3A==
X-Forwarded-Encrypted: i=1; AJvYcCUhWM15WO8qfgUEUuCo0O/sZqbnm0EfchFnI99W4Eiq75Bd9DjYBkc5/ozzzG1QZYEg8daSbkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztxzv6IVvcSy5rxpTlFX0d5FnE+tG7kw5VuwqlR2K4X9/cvtsu
	lONQpj/aKovBbw1cF++rp47G9p+BWWRyqdGqUimymi6LqYodLse9Iasj5Btlr4r00wA6tpn2ODy
	4wjm3YmZbu0n8b6LJvCKnQIqS2kXeWhkvE9ewtoOK
X-Gm-Gg: ASbGncu4fa4sO+vi8APB0m2uR0CYIKh/ci4zSQzA7Vd0fWv5j43DAI31ccOdLf/K7jd
	i3iGSL+5UAsm5ByXE6/mG/OQTTRcayGF3AYhs1nBppDF5+q38R7EfRdLpinEYw/HZFUJ2qxrLAy
	y/y4ZWzvOAGz9aXbF1r8NbabNLnPV4Kj3DKL+BEeaWuirPszRZVAH1xDxxCQ3RBj2kqxTlwr5qo
	fwtib9o1uGjk8VNliewTtRYhNUPH/BPjxI6kZk3fZEjxAhCYziXSawHYBk57T4yIrdTwjS9Bo1e
	YeoWVTG2V2wCeEZhObKizqgFXWaQ
X-Google-Smtp-Source: AGHT+IEvA8d/tes341pYVwfvG5w7JYfrKXszTFNpK95gXKemJVaDaZml8nzLkZsHA7yM8KvhAf2HiKyxbQ9t/OMpykg=
X-Received: by 2002:a17:902:dac1:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-29bac26a085mr212105ad.7.1764023737246; Mon, 24 Nov 2025
 14:35:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176398914850.89.13888454130518102455@f771fd7c9232> <20251124220404.GA2853001@ax162>
In-Reply-To: <20251124220404.GA2853001@ax162>
From: Guenter Roeck <groeck@google.com>
Date: Mon, 24 Nov 2025 14:35:26 -0800
X-Gm-Features: AWmQ_bkxc4I8qhn5g5WZJ0gfV7C1dK0WPhgr9qMe0bfuYOJKDNVyUvJJdliHFtE
Message-ID: <CABXOdTfbsoNdv6xMCppMq=JsfNBarp6YyFV4por3eA3cSWdT7g@mail.gmail.com>
Subject: Re: [REGRESSION] stable-rc/linux-6.12.y: (build) variable 'val' is
 uninitialized when passed as a const pointer arg...
To: Nathan Chancellor <nathan@kernel.org>
Cc: kernelci@lists.linux.dev, kernelci-results@groups.io, gus@collabora.com, 
	stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 2:04=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Mon, Nov 24, 2025 at 12:59:08PM -0000, KernelCI bot wrote:
> > Hello,
> >
> > New build issue found on stable-rc/linux-6.12.y:
> >
> > ---
> >  variable 'val' is uninitialized when passed as a const pointer argumen=
t here [-Werror,-Wuninitialized-const-pointer] in drivers/staging/rtl8712/r=
tl8712_cmd.o (drivers/staging/rtl8712/rtl8712_cmd.c) [logspec:kbuild,kbuild=
.compiler.error]
> > ---
> >
> > - dashboard: https://d.kernelci.org/i/maestro:5b83acc62508c670164c5fceb=
3079a2d7d74e154
> > - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git
> > - commit HEAD:  d5dc97879a97b328a89ec092271faa3db9f2bff3
> > - tags: v6.12.59
> >
> >
> > Log excerpt:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > drivers/staging/rtl8712/rtl8712_cmd.c:148:28: error: variable 'val' is =
uninitialized when passed as a const pointer argument here [-Werror,-Wunini=
tialized-const-pointer]
> >   148 |                 memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);
> >       |                                          ^~~
> > 1 error generated.
>
> This comes from a new subwarning of -Wuninitialized introduced in
> clang-21:
>
>   https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd09=
1d441f19b319e
>
> This driver was removed upstream in commit 41e883c137eb ("staging:
> rtl8712: Remove driver using deprecated API wext") in 6.13 so this only
> impacts stable.
>
> This certainly does look broken...
>
>   static u8 read_rfreg_hdl(struct _adapter *padapter, u8 *pbuf)
>   {
>       u32 val;
>       void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
>       struct cmd_obj *pcmd  =3D (struct cmd_obj *)pbuf;
>
>       if (pcmd->rsp && pcmd->rspsz > 0)
>           memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);
>
> Presumably this is never actually hit? It is rather hard to follow the
> indirection in this driver but it does not seem like _Read_RFREG is ever
> set as a cmdcode? Unfortunately, the only maintainer I see listed for
> this file is Florian Schilhabel but a glance at lore shows no recent
> activity so that probably won't be too much help. At the very least, we
> could just zero initialize val, it cannot be any worse than what it is
> currently doing and copying stack garbage?
>

Or backport the patch removing the driver ? It is in staging, after
all, so I don't know if there is value in trying to keep it alive in
6.12.y.

Guenter

> Cheers,
> Nathan
>

