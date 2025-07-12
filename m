Return-Path: <stable+bounces-161739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 341F8B02BAB
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 17:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C01A3B4359
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 15:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCF8288C89;
	Sat, 12 Jul 2025 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkJJ39Gl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC27288C2C;
	Sat, 12 Jul 2025 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752333538; cv=none; b=Bx983FhaLi7BDVABFq8YLZTZXpkZfNVZpPTICmqHZ88auZCD6LGyw5/YJMjAIX9goHNA4m+BykXLr1cHcA4shxyoULo0sQgeEQ95OofgngthEEoZv0cgYEYG3KCu5LIDiqB5IZZD1uU95SysAlq40lHAVeYriM75W6TviDDcH3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752333538; c=relaxed/simple;
	bh=oBuInK/Er1FzxA1L8e6FwS1J0+Ud/HnGx2Yd/U2ONAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAEJ9UiU1GJCILfF+iPpzPInSBFKhTlARHE7/4iLTbJ47C7EA3a/vAlu0YHOz7QJlSta+cgZytng8qWfL2NvOt4CeLxIXx/JnxuDPB+RXPSXWb/bcxr2v+WxcEVJbN/ZOqXPdHLue5NKQTtjNDgq1ELsfSX09DOKgNqcpQP8pyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkJJ39Gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3461BC4CEF9;
	Sat, 12 Jul 2025 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752333538;
	bh=oBuInK/Er1FzxA1L8e6FwS1J0+Ud/HnGx2Yd/U2ONAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tkJJ39GlvkgSbwm68I7ha4Vn08nRXL4aMAdBQOuPNMVRAA90HpjfAO6q6a3WAcbir
	 BQh7BN28+rV38rwU89D6AOZYUU7rVe8aj9KFjPK3jSpsWcTLSoCAZe8H38srsxgZDg
	 8/o3IBbLw9nCDu76HmBvxy7Xv45vpHeHRR/qGTat8YgOI15Zi+fdsa9KGSjpNwbszM
	 ghQbpKD9JzbKZqhESYr/MRSzZ088/nuCSazUuSPIde1jSKauMI2Tsof1c/GB3AJXmu
	 qThTq51OQvSA2Ue3o8JUzySPvfO/Zq8siYZieoLQYgioqrGcsS/i65pXPy4StllEuR
	 GTTbZW1YEhF7A==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso5725908a12.2;
        Sat, 12 Jul 2025 08:18:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVh7Kk0WLWsB7KUOSXeVnBNXKWM9ASLlN4cp7lctkGlsoTawSY9FS620QBFzP1n9N//HX1oIAZk@vger.kernel.org, AJvYcCWc2JQI2iS2LrGorfjtIvAyycFhCqX1lFbA7PX/eSNA7vAXp1qyA2KvGIB4WfJb/81o6jVh1//+yX7pYfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUzry7KxYYntL2SxWCcuZXms2FxJCxpyn9QsQPQ8BLHybLNx7W
	+lEOhD6K+9n7s4e6n1A7dGCHHNOeO8tdwbVTfEX/aqix8KL5NDZBjhQbnLmtAJGftCEGymu0Gz5
	4kN/pju00ua4Kzf6SOgZaaeba2yRnkrM=
X-Google-Smtp-Source: AGHT+IFrzSZLNInWS+8kFPoqYt/MMfdTYQoSCkNyar2BMbLSJNWC8sQxzSzjG5tUH1/1HNQ6F/ZaEFU5n43ZNhmmJwI=
X-Received: by 2002:a05:6402:34c7:b0:5fe:7b09:9e27 with SMTP id
 4fb4d7f45d1cf-611e7c21fb6mr6228271a12.12.1752333536713; Sat, 12 Jul 2025
 08:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711102455.3673865-1-chenhuacai@loongson.cn>
 <2025071130-mangle-ramrod-38ff@gregkh> <CAAhV-H7oEv5jPufY+J-0wOax=m1pszck1__Ptapz5pmzYU5KHg@mail.gmail.com>
 <2025071116-pushchair-happening-a4cf@gregkh> <CAAhV-H69oz-Rmz4Q2Gad-x5AR0C2cxtK7Mgsc5iJHALP_NcEhw@mail.gmail.com>
 <2025071150-oasis-chewy-4137@gregkh>
In-Reply-To: <2025071150-oasis-chewy-4137@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 12 Jul 2025 23:18:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4kzxR9e762r+ZzCyPrUemDtwqXvp_BJY3R1O1MPV9hrw@mail.gmail.com>
X-Gm-Features: Ac12FXwsrOLHm2zwCsbZIeklHFbvZsw2Idkz2eK6IwezSFPRuRdFcX288N4584o
Message-ID: <CAAhV-H4kzxR9e762r+ZzCyPrUemDtwqXvp_BJY3R1O1MPV9hrw@mail.gmail.com>
Subject: Re: [PATCH] init: Handle bootloader head in kernel parameters
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 9:04=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Jul 11, 2025 at 08:51:28PM +0800, Huacai Chen wrote:
> > On Fri, Jul 11, 2025 at 8:41=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Fri, Jul 11, 2025 at 08:34:25PM +0800, Huacai Chen wrote:
> > > > Hi, Greg,
> > > >
> > > > On Fri, Jul 11, 2025 at 7:06=E2=80=AFPM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > On Fri, Jul 11, 2025 at 06:24:55PM +0800, Huacai Chen wrote:
> > > > > > BootLoader may pass a head such as "BOOT_IMAGE=3D/boot/vmlinuz-=
x.y.z" to
> > > > > > kernel parameters. But this head is not recognized by the kerne=
l so will
> > > > > > be passed to user space. However, user space init program also =
doesn't
> > > > > > recognized it.
> > > > >
> > > > > Then why is it on the kernel command line if it is not recognized=
?
> > > > UEFI put it at the beginning of the command line, you can see it fr=
om
> > > > /proc/cmdline, both on x86 and LoongArch.
> > >
> > > Then fix UEFI :)
> > >
> > > My boot command line doesn't have that on x86, perhaps you need to fi=
x
> > > your bootloader?
> > Not only UEFI, Grub also do this, for many years, not now. I don't
> > know why they do this, but I think at least it is not a bug. For
> > example, maybe it just tells user the path of kernel image via
> > /proc/cmdline.
> >
> > [chenhuacai@kernelserver linux-official.git]$ uname -a
> > Linux kernelserver 6.12.0-84.el10.x86_64 #1 SMP PREEMPT_DYNAMIC Tue
> > May 13 13:39:02 UTC 2025 x86_64 GNU/Linux
> > [chenhuacai@kernelserver linux-official.git]$ cat /proc/cmdline
> > BOOT_IMAGE=3D(hd0,gpt2)/vmlinuz-6.12.0-84.el10.x86_64
> > root=3DUUID=3Dc8fcb11a-0f2f-48e5-a067-4cec1d18a721 ro
> > crashkernel=3D2G-64G:256M,64G-:512M
> > resume=3DUUID=3D1c320fec-3274-4b5b-9adf-a06
> > 42e7943c0 rhgb quiet
>
> Sounds like a bootloader bug:
>
> $ cat /proc/cmdline
> root=3D/dev/sda2 rw
>
> I suggest fixing the issue there, at the root please.
Grub pass BOOT_IMAGE for all EFI-based implementations, related commits of =
Grub:
https://cgit.git.savannah.gnu.org/cgit/grub.git/commit/?id=3D16ccb8b138218d=
56875051d547af84410d18f9aa
https://cgit.git.savannah.gnu.org/cgit/grub.git/commit/?id=3D25953e10553dad=
2e378541a68686fc094603ec54

Linux kernel treats BOOT_IMAGE as an "offender" of unknown command
line parameters, related commits of kernel:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D86d1919a4fb0d9c115dd1d3b969f5d1650e45408

There are user space projects that search BOOT_IMAGE from /proc/cmdline:
https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/util.go
(search getBootOptions)
https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/main.go
(search getKernelReleaseWithBootOption)

So, we can say Grub pass BOOT_IMAGE is reasonable and there are user
space programs that hope it be in /proc/cmdline.

But BOOT_IMAGE should not be passed to the init program. Strings in
cmdline contain 4 types: BootLoader head (BOOT_IMAGE, kexec, etc.),
kernel parameters, init parameters, wrong parameters.

The first type is handled (ignored) by this patch, the second type is
handled (consumed) by the kernel, and the last two types are passed to
user space.

If the first type is also passed to user space, there are meaningless
warnings, and (maybe) cause problems with the init program.


Huacai

>
> > > > > > KEXEC may also pass a head such as "kexec" on some architecture=
s.
> > > > >
> > > > > That's fine, kexec needs this.
> > > > >
> > > > > > So the the best way is handle it by the kernel itself, which ca=
n avoid
> > > > > > such boot warnings:
> > > > > >
> > > > > > Kernel command line: BOOT_IMAGE=3D(hd0,1)/vmlinuz-6.x root=3D/d=
ev/sda3 ro console=3Dtty
> > > > > > Unknown kernel command line parameters "BOOT_IMAGE=3D(hd0,1)/vm=
linuz-6.x", will be passed to user space.
> > > > >
> > > > > Why is this a problem?  Don't put stuff that is not needed on the=
 kernel
> > > > > command line :)
> > > > Both kernel and user space don't need it, and if it is passed to us=
er
> > > > space then may cause some problems. For example, if there is
> > > > init=3D/bin/bash, then bash will crash with this parameter.
> > >
> > > Again, fix the bootloader to not do this, why is the kernel responsib=
le
> > > for this?
> > >
> > > What has suddenly changed to now require this when we never have need=
ed
> > > it before?
> > Because init=3D/bin/bash is not a usual use case, so in most cases it i=
s
> > just a warning in dmesg. But once we see it, we need to fix it.
>
> Why is this the kernel's fault?
>
> Again, what changed in the kernel to cause this to happen?  I think you
> are seeing bugs in bootloaders, NOT in the kernel.  Fix the issue at the
> root, don't paper over the problem in the kernel for something that is
> NOT the kernel's fault.
>
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > > ---
> > > > > >  init/main.c | 7 +++++++
> > > > > >  1 file changed, 7 insertions(+)
> > > > > >
> > > > > > diff --git a/init/main.c b/init/main.c
> > > > > > index 225a58279acd..9e0a7e8913c0 100644
> > > > > > --- a/init/main.c
> > > > > > +++ b/init/main.c
> > > > > > @@ -545,6 +545,7 @@ static int __init unknown_bootoption(char *=
param, char *val,
> > > > > >                                    const char *unused, void *ar=
g)
> > > > > >  {
> > > > > >       size_t len =3D strlen(param);
> > > > > > +     const char *bootloader[] =3D { "BOOT_IMAGE", "kexec", NUL=
L };
> > > > >
> > > > > You need to document why these are ok to "swallow" and not warn f=
or.
> > > > Because they are bootloader heads, not really a wrong parameter. We
> > > > only need a warning if there is a wrong parameter.
> > >
> > > Again, fix the bootloader.
> > But I don't think this is a bootloader bug.
>
> Seems like it is if nothing changed in the kernel and this just started
> showing up now :)
>
> Unless you can find a kernel commit that caused this issue?
>
> thanks,
>
> greg k-h

