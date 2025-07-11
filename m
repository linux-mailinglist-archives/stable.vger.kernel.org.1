Return-Path: <stable+bounces-161656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14345B01C64
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 14:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2105A03B6
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 12:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FCF21B9C1;
	Fri, 11 Jul 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7pACg4A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3330C2C2ACE;
	Fri, 11 Jul 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238303; cv=none; b=XS5IVRwgExd2VvugYC1fjtgm0UdojmOiI9p46HWGMctUfsOBPnuxdcmCNHQcp7cL4dHnfopmsI/9kmftmIQqqs1mm2T2uPEcpzAYecGhzt0fTFoAudUYStodfCvEDfLX6P1m6KwuNuII0ApQg9BI1lvNVC4or73Urp98MBW/qCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238303; c=relaxed/simple;
	bh=lyUxwBHju02dMiKQLVH2xFYhplRqJaXP98Xc9BmW/VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDHEzUNvoApy/x4unp/LdjQhWpO+divnWEOaK/G++uWW0rHv283mM0cR9sSgQjWtVOUyW6uHJBgGBMOLLwTWQVnXvt6TxCCJfLYsOam+rmhiiIIkyUeBfHie+KJJhI4xZVZTae7hYTxOO33SIej80B2ScyC9uBV5MDe6nMYULC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7pACg4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089F3C4CEF0;
	Fri, 11 Jul 2025 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752238303;
	bh=lyUxwBHju02dMiKQLVH2xFYhplRqJaXP98Xc9BmW/VM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G7pACg4A5gOwlgYcQ0CRPr+uZxp7vRe8+FNW54nisS6mwXxjP6+SAJlNkzvFYjYVz
	 vwVjlz0I14VpKK0gEXcTn72Xqzepi364oowGr6W3O1sCjBJz8fuUxkt4Hn6bfkzH+4
	 r0Ec3UQ1jxZNZdfxlw0JtM3v4py/L85TV4WJIzYRdm75fEI3r5yk9glxXXqrMvnIPl
	 5wpGdMHiWYG7mFlaYeuL0rnNla8j8B9irSDAc8f7yv0JNH4MUKdSk2LQmY4YD759fn
	 2L0tmuypgd2tdc11BdlPdKOevWQRUrdQ/ACWS9fI4h++63ecMnFk95HIW1n8GAnQIx
	 2Nmc1bkP2JGdw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so3928181a12.1;
        Fri, 11 Jul 2025 05:51:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTFD3MMnP98qFmvYdM65kh7crKRJ8Gc9qjJ9mfCr6PuFFlgJX1KV5NiHwFUKScpsFxPnaaEyga@vger.kernel.org, AJvYcCW4h/FwsFdgE3ZbRGPL0Spj+DBZEJKpEFF2/gF8wrir+LKVsHj1O2/zoUX+7WuMcMzpBQ4U8LLTjl6bVZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtDjT9sbOjagYNoYbIlqEr5bR64ihrXmEa0dNHvjiJheniPGui
	3S4sPLF9Say3LMuhM4tb4cGPKsntaNxhMANGBuONwSz4KoNd2qw8ZZVwXNuJeUJkINNAv362EUO
	YLoPQOf3jccUJWyU+9Ihjo0XV/e0vu0k=
X-Google-Smtp-Source: AGHT+IFW/bftZomDuupR4W+DSF41mDHFFf4QUZwB/KJ9wARlJtOAWK9Nyp3GY2X97r0qgDp4UX3BbGkhltmoSabmvDg=
X-Received: by 2002:a05:6402:5144:b0:5fd:c426:9d17 with SMTP id
 4fb4d7f45d1cf-611e84f23ccmr2326985a12.34.1752238301458; Fri, 11 Jul 2025
 05:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711102455.3673865-1-chenhuacai@loongson.cn>
 <2025071130-mangle-ramrod-38ff@gregkh> <CAAhV-H7oEv5jPufY+J-0wOax=m1pszck1__Ptapz5pmzYU5KHg@mail.gmail.com>
 <2025071116-pushchair-happening-a4cf@gregkh>
In-Reply-To: <2025071116-pushchair-happening-a4cf@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 11 Jul 2025 20:51:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H69oz-Rmz4Q2Gad-x5AR0C2cxtK7Mgsc5iJHALP_NcEhw@mail.gmail.com>
X-Gm-Features: Ac12FXwjmQViTDRFlDw_gjXlsiSf8z8aQReLwHlf5Zckibot1d-vLEa544f80Z4
Message-ID: <CAAhV-H69oz-Rmz4Q2Gad-x5AR0C2cxtK7Mgsc5iJHALP_NcEhw@mail.gmail.com>
Subject: Re: [PATCH] init: Handle bootloader head in kernel parameters
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 8:41=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Jul 11, 2025 at 08:34:25PM +0800, Huacai Chen wrote:
> > Hi, Greg,
> >
> > On Fri, Jul 11, 2025 at 7:06=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Fri, Jul 11, 2025 at 06:24:55PM +0800, Huacai Chen wrote:
> > > > BootLoader may pass a head such as "BOOT_IMAGE=3D/boot/vmlinuz-x.y.=
z" to
> > > > kernel parameters. But this head is not recognized by the kernel so=
 will
> > > > be passed to user space. However, user space init program also does=
n't
> > > > recognized it.
> > >
> > > Then why is it on the kernel command line if it is not recognized?
> > UEFI put it at the beginning of the command line, you can see it from
> > /proc/cmdline, both on x86 and LoongArch.
>
> Then fix UEFI :)
>
> My boot command line doesn't have that on x86, perhaps you need to fix
> your bootloader?
Not only UEFI, Grub also do this, for many years, not now. I don't
know why they do this, but I think at least it is not a bug. For
example, maybe it just tells user the path of kernel image via
/proc/cmdline.

[chenhuacai@kernelserver linux-official.git]$ uname -a
Linux kernelserver 6.12.0-84.el10.x86_64 #1 SMP PREEMPT_DYNAMIC Tue
May 13 13:39:02 UTC 2025 x86_64 GNU/Linux
[chenhuacai@kernelserver linux-official.git]$ cat /proc/cmdline
BOOT_IMAGE=3D(hd0,gpt2)/vmlinuz-6.12.0-84.el10.x86_64
root=3DUUID=3Dc8fcb11a-0f2f-48e5-a067-4cec1d18a721 ro
crashkernel=3D2G-64G:256M,64G-:512M
resume=3DUUID=3D1c320fec-3274-4b5b-9adf-a06
42e7943c0 rhgb quiet

>
> > > > KEXEC may also pass a head such as "kexec" on some architectures.
> > >
> > > That's fine, kexec needs this.
> > >
> > > > So the the best way is handle it by the kernel itself, which can av=
oid
> > > > such boot warnings:
> > > >
> > > > Kernel command line: BOOT_IMAGE=3D(hd0,1)/vmlinuz-6.x root=3D/dev/s=
da3 ro console=3Dtty
> > > > Unknown kernel command line parameters "BOOT_IMAGE=3D(hd0,1)/vmlinu=
z-6.x", will be passed to user space.
> > >
> > > Why is this a problem?  Don't put stuff that is not needed on the ker=
nel
> > > command line :)
> > Both kernel and user space don't need it, and if it is passed to user
> > space then may cause some problems. For example, if there is
> > init=3D/bin/bash, then bash will crash with this parameter.
>
> Again, fix the bootloader to not do this, why is the kernel responsible
> for this?
>
> What has suddenly changed to now require this when we never have needed
> it before?
Because init=3D/bin/bash is not a usual use case, so in most cases it is
just a warning in dmesg. But once we see it, we need to fix it.

>
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  init/main.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/init/main.c b/init/main.c
> > > > index 225a58279acd..9e0a7e8913c0 100644
> > > > --- a/init/main.c
> > > > +++ b/init/main.c
> > > > @@ -545,6 +545,7 @@ static int __init unknown_bootoption(char *para=
m, char *val,
> > > >                                    const char *unused, void *arg)
> > > >  {
> > > >       size_t len =3D strlen(param);
> > > > +     const char *bootloader[] =3D { "BOOT_IMAGE", "kexec", NULL };
> > >
> > > You need to document why these are ok to "swallow" and not warn for.
> > Because they are bootloader heads, not really a wrong parameter. We
> > only need a warning if there is a wrong parameter.
>
> Again, fix the bootloader.
But I don't think this is a bootloader bug.

>
> > > >
> > > >       /* Handle params aliased to sysctls */
> > > >       if (sysctl_is_alias(param))
> > > > @@ -552,6 +553,12 @@ static int __init unknown_bootoption(char *par=
am, char *val,
> > > >
> > > >       repair_env_string(param, val);
> > > >
> > > > +     /* Handle bootloader head */
> > >
> > > Handle it how?
> > argv_init and envp_init arrays will be passed to userspace, so just
> > return early (before argv_init and envp_init handling) can avoid it
> > being passed.
>
> You need to document this way better.
>
> But again, please just fix your bootloader to not pass on lines to the
> kernel that it can not parse.
OK, I will update the document, but again, I don't think this is a
bootloader bug.

Huacai

>
> thanks,
>
> greg k-h

