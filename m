Return-Path: <stable+bounces-161654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E858B01C1F
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 14:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D6E7621DD
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 12:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CE5298987;
	Fri, 11 Jul 2025 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFMWAsX0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D3F4A24;
	Fri, 11 Jul 2025 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752237280; cv=none; b=RgadvAbo0jfSBSDnjT0WQ6i6ufN0Us+tiAw12h5iq6+uIdpm/UUCTsXbDJBym0u+1OjeAWKOEQJudIJAvF+ypNg9nbTYNAf5fxqUGHoyKUUibQhQNoTr/QUvbp3h6L8tY9EeJex346WUMQWk6/NMoOTmbD6rBHvMdpJmXInCphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752237280; c=relaxed/simple;
	bh=iPzBUak9frIQPxX1OSSUONLfOETT41XmEQPiZTZmh90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlF46Y6RNdENqOOxnucMe8wg4gk2ySMHeYwd3tEPRRMRdJ36+UA3nKYj16lsAx13VrI+inxQnf6CHY4guJaPALzNvzd0OhXoqKTR0rfqhUO1lN6IyaM760UXNOq5+Fm92ggsmP0mHEIePBrMNZlGonUy5UnSTOcU+RH6oBoATH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFMWAsX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CB4C4CEF8;
	Fri, 11 Jul 2025 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752237280;
	bh=iPzBUak9frIQPxX1OSSUONLfOETT41XmEQPiZTZmh90=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EFMWAsX0WDIhXrSqySOFTtd74au8J70vA2APRHzPRgkGeOKVAf7UP/cYx/ndgq86e
	 9QmhwR2dEuSegz7my3puu2hUendHXmgBukaue/oMYFibCQP54iVLGPMvyyFSbt2iFM
	 cuVcNHfaiL66rhJMLw3GoNLglnaEEGnf3cFQiWvKGkPoHPyS+G6iNlkOAscu8STCp9
	 eX59TUAzVP0DgZPyRPIWl14+wxtJ56NtV8rY0MPPiRKP0Do6EAJ6UnW4C1GLamKY2S
	 BS0ZKl6WJnRVjFSvzD8AYspsFlBi6d1Ibyu8ObFoiLHEe9Mo4eXC1crjxhgfNQQN1F
	 WkVty5MGtoIyw==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so3159929a12.1;
        Fri, 11 Jul 2025 05:34:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/EiORnDVAne5h3dxzO8SJOUEKoalsf+u3QhS9hftZyZ9of9meBpC+b1tbpIhDjxu8IkB5102/@vger.kernel.org, AJvYcCW0R0hZ9570G5AvALUHRelcNLPZzyR00GzZ5x2do73K+65Zp2XfLRzUs4L2RekxoKRp4zWhOfkK+qb2OZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY5RVJxvE1Jb0BAIFc0qtYjR2zpggycyNqDrHE3uOME27ZHtDS
	Pxsum+CJRHX4fzSr2pNl9262J+7aUaJc099/yuSAR/Y2H9G8Iu8tFijqKsQSdgNs7ZKTqLvY2bc
	VvcrIHmIcqIYL4ig+bfh5iO+5aBjVgPo=
X-Google-Smtp-Source: AGHT+IEluutpYJhPNDQCqi/aWbbEENSWhbRoj7AH++W2t36i/1/OdG3p5utN3ZMcp6elFijTRbgenLzeZgoi4oOtBwo=
X-Received: by 2002:a05:6402:1e92:b0:607:32e8:652 with SMTP id
 4fb4d7f45d1cf-611e84997a1mr2486337a12.19.1752237278630; Fri, 11 Jul 2025
 05:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711102455.3673865-1-chenhuacai@loongson.cn> <2025071130-mangle-ramrod-38ff@gregkh>
In-Reply-To: <2025071130-mangle-ramrod-38ff@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 11 Jul 2025 20:34:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7oEv5jPufY+J-0wOax=m1pszck1__Ptapz5pmzYU5KHg@mail.gmail.com>
X-Gm-Features: Ac12FXwdjQ3g5zxmjsCe_SAgVWzfc3x861r0WM0FTkTcHpT0fUNhHKvncL8LWXI
Message-ID: <CAAhV-H7oEv5jPufY+J-0wOax=m1pszck1__Ptapz5pmzYU5KHg@mail.gmail.com>
Subject: Re: [PATCH] init: Handle bootloader head in kernel parameters
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Greg,

On Fri, Jul 11, 2025 at 7:06=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Jul 11, 2025 at 06:24:55PM +0800, Huacai Chen wrote:
> > BootLoader may pass a head such as "BOOT_IMAGE=3D/boot/vmlinuz-x.y.z" t=
o
> > kernel parameters. But this head is not recognized by the kernel so wil=
l
> > be passed to user space. However, user space init program also doesn't
> > recognized it.
>
> Then why is it on the kernel command line if it is not recognized?
UEFI put it at the beginning of the command line, you can see it from
/proc/cmdline, both on x86 and LoongArch.

>
> > KEXEC may also pass a head such as "kexec" on some architectures.
>
> That's fine, kexec needs this.
>
> > So the the best way is handle it by the kernel itself, which can avoid
> > such boot warnings:
> >
> > Kernel command line: BOOT_IMAGE=3D(hd0,1)/vmlinuz-6.x root=3D/dev/sda3 =
ro console=3Dtty
> > Unknown kernel command line parameters "BOOT_IMAGE=3D(hd0,1)/vmlinuz-6.=
x", will be passed to user space.
>
> Why is this a problem?  Don't put stuff that is not needed on the kernel
> command line :)
Both kernel and user space don't need it, and if it is passed to user
space then may cause some problems. For example, if there is
init=3D/bin/bash, then bash will crash with this parameter.

>
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  init/main.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/init/main.c b/init/main.c
> > index 225a58279acd..9e0a7e8913c0 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -545,6 +545,7 @@ static int __init unknown_bootoption(char *param, c=
har *val,
> >                                    const char *unused, void *arg)
> >  {
> >       size_t len =3D strlen(param);
> > +     const char *bootloader[] =3D { "BOOT_IMAGE", "kexec", NULL };
>
> You need to document why these are ok to "swallow" and not warn for.
Because they are bootloader heads, not really a wrong parameter. We
only need a warning if there is a wrong parameter.

>
>
> >
> >       /* Handle params aliased to sysctls */
> >       if (sysctl_is_alias(param))
> > @@ -552,6 +553,12 @@ static int __init unknown_bootoption(char *param, =
char *val,
> >
> >       repair_env_string(param, val);
> >
> > +     /* Handle bootloader head */
>
> Handle it how?
argv_init and envp_init arrays will be passed to userspace, so just
return early (before argv_init and envp_init handling) can avoid it
being passed.

Huacai

>
> confused,
>
> greg k-h

