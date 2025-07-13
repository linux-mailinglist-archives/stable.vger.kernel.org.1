Return-Path: <stable+bounces-161756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF331B03058
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 11:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B738189E3B6
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 09:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083061C6FE9;
	Sun, 13 Jul 2025 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeXe2OoW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E08156677;
	Sun, 13 Jul 2025 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752397894; cv=none; b=uUTzoaRxrHXtamv5+eiz/S+RhC9GsEM5+TS62/Mb47fop8Sr6nQVeZL9i124ksDaThTlrxUOUbiHd86LrPe5VvPKBNDRj7DVKhgXDVwYmafQSAvwvf9j8oih0TqLJ/gpn3rfJVTOdbr1ykUg4SX4yhpSgxqSyfeUkgjeb9ohmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752397894; c=relaxed/simple;
	bh=jYc/JBkIqI2qidnuOUAQsyRiugJlGm80lkYZ1ZsmbeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfuIG0ATgI7/IvRiN9PZcQ1QxsjNOhEiSAtseZNDulBuB7206VGS/P+0uBErGjn5CBcLuQOhC3WTEoA5n2RzXsBvI5Nox0eNY9jEJj4BkyK1/c+T0+hoC3Dm/hKYnl0moL3lT7wnDj1IUr7Lq1FjstoSk4X7g6KBrUAdRip+DPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeXe2OoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE4FC4CEF8;
	Sun, 13 Jul 2025 09:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752397894;
	bh=jYc/JBkIqI2qidnuOUAQsyRiugJlGm80lkYZ1ZsmbeA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jeXe2OoWP6kja9kGnl3caJLASNYpaeebqKphRQ7PGaDrLjnLVXr+oJ586JN88WqhL
	 zrbyXEdE5XimYiqROmFK0hHXKgFec7Y8EXux2XUzE/zluRU81ea4Ama36IlTdoo5tZ
	 2l0nNL8wAGxjMdpyGVaZy5+ovTYNsqNL6cWdTxX2Auieiu9t+i9IH9QKXvM91fxu6e
	 QPrKZlvTRfLfh2f2CUO7rNKdZ0eJVzDO1RFFRwE0h2PKmOH3POZLq4laAL1pctuvHw
	 CqRBdiDu1KfWU0XDr+JAm6jEJM9ZBdLST36zjvhN5uEcKZzQt0v59tLTdPsRT/A3Ci
	 AkIqHAstN1JXA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so6241254a12.0;
        Sun, 13 Jul 2025 02:11:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUk0thKk/TqtuVF3QTr8dOG/Irx9WgVDnTEK5AO4PtRNhR7evGVyVSplYqmStO2fuSjXl2jztyHMzf4ulc=@vger.kernel.org, AJvYcCWNdp/EvbSNUYMPxH8Yz5hmnWSesfM2yjCvRtFPRvu9jwLDWAiCN9VM7+niAY0TgjY39VGAA1QL@vger.kernel.org
X-Gm-Message-State: AOJu0YwtOFAx1Zzyle4KvlhGe9SB0SuWX9CiFKlJ9yutYJvCEWi98Ulx
	tTEHM1NeHfG/fQznvnLefke59J+ySBR83shMozUY1GNvSdCqeLpAKlSGwzZvZrnNjA7ObJJsm4X
	KOTlxotV0Wol0ik55tPvkSrrxda8xF/Q=
X-Google-Smtp-Source: AGHT+IFGDEnDkIgL9O5BsubJZOH+0Tc4zaGFNY39k9QQWMzB7p1zAMJ5ZxPdewcj0eP+jmcUKEPKpmXm+6seUoHzW8Y=
X-Received: by 2002:a05:6402:210c:b0:608:493a:cccf with SMTP id
 4fb4d7f45d1cf-611e84ff961mr8284018a12.30.1752397892987; Sun, 13 Jul 2025
 02:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711102455.3673865-1-chenhuacai@loongson.cn>
 <2025071130-mangle-ramrod-38ff@gregkh> <CAAhV-H7oEv5jPufY+J-0wOax=m1pszck1__Ptapz5pmzYU5KHg@mail.gmail.com>
 <2025071116-pushchair-happening-a4cf@gregkh> <CAAhV-H69oz-Rmz4Q2Gad-x5AR0C2cxtK7Mgsc5iJHALP_NcEhw@mail.gmail.com>
 <2025071150-oasis-chewy-4137@gregkh> <CAAhV-H4kzxR9e762r+ZzCyPrUemDtwqXvp_BJY3R1O1MPV9hrw@mail.gmail.com>
 <2025071330-alkalize-bonus-ebec@gregkh>
In-Reply-To: <2025071330-alkalize-bonus-ebec@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 13 Jul 2025 17:11:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6MnutZughoES5z_vuZq3PErqMjcJrNEYO+kQLcCQd=sw@mail.gmail.com>
X-Gm-Features: Ac12FXzu6A8q3DyUoYTiY0yMVw2eXUDho_X9QXkQwvYecpmppzfmBhUnmI2iIbE
Message-ID: <CAAhV-H6MnutZughoES5z_vuZq3PErqMjcJrNEYO+kQLcCQd=sw@mail.gmail.com>
Subject: Re: [PATCH] init: Handle bootloader head in kernel parameters
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 4:30=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sat, Jul 12, 2025 at 11:18:44PM +0800, Huacai Chen wrote:
> > On Fri, Jul 11, 2025 at 9:04=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Fri, Jul 11, 2025 at 08:51:28PM +0800, Huacai Chen wrote:
> > > > On Fri, Jul 11, 2025 at 8:41=E2=80=AFPM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > On Fri, Jul 11, 2025 at 08:34:25PM +0800, Huacai Chen wrote:
> > > > > > Hi, Greg,
> > > > > >
> > > > > > On Fri, Jul 11, 2025 at 7:06=E2=80=AFPM Greg KH <gregkh@linuxfo=
undation.org> wrote:
> > > > > > >
> > > > > > > On Fri, Jul 11, 2025 at 06:24:55PM +0800, Huacai Chen wrote:
> > > > > > > > BootLoader may pass a head such as "BOOT_IMAGE=3D/boot/vmli=
nuz-x.y.z" to
> > > > > > > > kernel parameters. But this head is not recognized by the k=
ernel so will
> > > > > > > > be passed to user space. However, user space init program a=
lso doesn't
> > > > > > > > recognized it.
> > > > > > >
> > > > > > > Then why is it on the kernel command line if it is not recogn=
ized?
> > > > > > UEFI put it at the beginning of the command line, you can see i=
t from
> > > > > > /proc/cmdline, both on x86 and LoongArch.
> > > > >
> > > > > Then fix UEFI :)
> > > > >
> > > > > My boot command line doesn't have that on x86, perhaps you need t=
o fix
> > > > > your bootloader?
> > > > Not only UEFI, Grub also do this, for many years, not now. I don't
> > > > know why they do this, but I think at least it is not a bug. For
> > > > example, maybe it just tells user the path of kernel image via
> > > > /proc/cmdline.
> > > >
> > > > [chenhuacai@kernelserver linux-official.git]$ uname -a
> > > > Linux kernelserver 6.12.0-84.el10.x86_64 #1 SMP PREEMPT_DYNAMIC Tue
> > > > May 13 13:39:02 UTC 2025 x86_64 GNU/Linux
> > > > [chenhuacai@kernelserver linux-official.git]$ cat /proc/cmdline
> > > > BOOT_IMAGE=3D(hd0,gpt2)/vmlinuz-6.12.0-84.el10.x86_64
> > > > root=3DUUID=3Dc8fcb11a-0f2f-48e5-a067-4cec1d18a721 ro
> > > > crashkernel=3D2G-64G:256M,64G-:512M
> > > > resume=3DUUID=3D1c320fec-3274-4b5b-9adf-a06
> > > > 42e7943c0 rhgb quiet
> > >
> > > Sounds like a bootloader bug:
> > >
> > > $ cat /proc/cmdline
> > > root=3D/dev/sda2 rw
> > >
> > > I suggest fixing the issue there, at the root please.
> > Grub pass BOOT_IMAGE for all EFI-based implementations, related commits=
 of Grub:
> > https://cgit.git.savannah.gnu.org/cgit/grub.git/commit/?id=3D16ccb8b138=
218d56875051d547af84410d18f9aa
> > https://cgit.git.savannah.gnu.org/cgit/grub.git/commit/?id=3D25953e1055=
3dad2e378541a68686fc094603ec54
>
> From 2005 and 2011?  Why have we not had any reports of this being an
> issue before now?  What changed in the kernel recently?
As said before, just in some corner cases it causes problems, but
corner case doesn't means nothing.

>
> > Linux kernel treats BOOT_IMAGE as an "offender" of unknown command
> > line parameters, related commits of kernel:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D86d1919a4fb0d9c115dd1d3b969f5d1650e45408
>
> So in 2021 we started printing out command line arguments that were
> "wrong", so is this when everyone noticed that grub was wrong?
Somebody may think a warning is harmless, somebody thinks a warning
means a problem needs to fix.
>
> > There are user space projects that search BOOT_IMAGE from /proc/cmdline=
:
> > https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/util.go
> > (search getBootOptions)
> > https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/main.go
> > (search getKernelReleaseWithBootOption)
>
> What does it use these options for that it can't get from the valid ones
> instead?
Some projects have fallback methods, some projects don't work, but at
least this means some user space programs depend on it already.

>
> > So, we can say Grub pass BOOT_IMAGE is reasonable and there are user
> > space programs that hope it be in /proc/cmdline.
>
> But who relies on this that never noticed the kernel complaining about
> it for the past 4 years?
So If I'm the first man who notices this and wants to improve
something, then it is my mistake?

>
> > But BOOT_IMAGE should not be passed to the init program. Strings in
> > cmdline contain 4 types: BootLoader head (BOOT_IMAGE, kexec, etc.),
> > kernel parameters, init parameters, wrong parameters.
>
> Then fix grub to not do this.
>
> > The first type is handled (ignored) by this patch, the second type is
> > handled (consumed) by the kernel, and the last two types are passed to
> > user space.
>
> That's not obvious in this patch at all.  If you are doing different
> things, make it separate patches.
>
> And again, fix grub.
>
> > If the first type is also passed to user space, there are meaningless
> > warnings, and (maybe) cause problems with the init program.
>
> So it's been causing problems for all these years (i.e. since 2005)?
>
> What changed that is causing this to be an issue now, and again, why not
> just fix grub?
Corner cases have had problems since 2005, and just because they are
corner cases, they are not noticed by everyone. But once they are
noticed, they need to be fixed. We cannot change Grub (LILO do the
same thing) now, because user space relies on it already.

Huacai

>
> thanks,
>
> greg k-h

