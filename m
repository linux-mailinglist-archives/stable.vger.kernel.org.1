Return-Path: <stable+bounces-161826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF89DB03BC0
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 12:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD4E7A8D31
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 10:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F98243369;
	Mon, 14 Jul 2025 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvRnGL8h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F57023A984;
	Mon, 14 Jul 2025 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488313; cv=none; b=aSoH7RIikikPuZORqw0CkS1hIqNz6Fy2uBxVJhTyYp8dHyH/2bMjjfYDlLqMpfTP/Z9HgW2cInLTXS5w2XKrPBf8ElneM+8G+i5Xn2XqoCBgrEpPAo4eUIM3RWab1EQB31N71ZoqQ7S7MiiOUygq/k9S+Wo+M/tH9c7jYAbUk5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488313; c=relaxed/simple;
	bh=+57UPy+qTf25cjB3/LPUH3B7cWaNxCDrc05uMGhvQLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIUWLoh38CTpazkw0liq8wL7cDltLbWfOqAnMXf2xnPgy7Og2beRQmTFwMfcHrhtOUS+YGKzbFywH+/4g0oPNUEE38RjoaVG8kyjf9lysCimWoa4R4XJFDy7SyRhlNkNLI81Yah8U3GGy1hSnBdGz6vXzKSsb0K1+d755eg5+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvRnGL8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9449CC4CEF6;
	Mon, 14 Jul 2025 10:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752488312;
	bh=+57UPy+qTf25cjB3/LPUH3B7cWaNxCDrc05uMGhvQLM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RvRnGL8hLV+iMQFt525uF2/QGslE0TJmTeEVlLHMEOUGk4C7T3WQhPwH0rOgip/vT
	 moBfDx36WrGsnaTe1lzKdpQ5b5ColUw5aChYlPg4ekdSBw0hoWakohY+48+FWjRbhD
	 xKiYALgi1O4ScrvmdyJJWd5tTSJYD+xsP5jUDrMt1WgwN7TsLKaLmvYjI+j+/femJ8
	 7x1SM6uxaydacWii2tN4WMPVCIMm/eEoyjgEGAlMfI+DjDhhBOTyf/pm9EMoE+Vkkg
	 nw4GSsaaGcqB7hzYyTPRtueiRUK0zRIiinMxM6zvePmv2lhLTHoFLAwBM+8+Ruxb7O
	 SEJOIKTecA6sg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so8591416a12.3;
        Mon, 14 Jul 2025 03:18:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdItN5DcS/g9SV+d9I8u+u/5UpmzIlrzuaZT1JqnS1GO5ag7yhDrBkVOJQB/tVN5LfcnjYj6EnEs8Ty9Q=@vger.kernel.org, AJvYcCXzkJVhGib7IFYjt6RLCqZXqDalTbYMz3Bc0mXt3xf9fTN6wToTkp4KWOX/uDwfUyNwq5A/fh7y@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7EphUQ6vYkgSA2c0VJyvPDjIlMBIbrUAo8tK9JIBBxdD4JcWo
	JeZUNZZ098Syw4AmltCEmrw8klHC9xvnrvttlpB7k1mOT4BJ0vxQgE+nHjrP3dDnxifBROUrWSV
	kYoH3c/q8HgHo9MdiKuo+GFKCY0EkYKM=
X-Google-Smtp-Source: AGHT+IEbgsdrEbpMoRTpuQx3aEWsVHDo+zRZGrPlM9uO/YzZhKjwT1oque9/aqHQNdP/KW3JflRrozLBlvMp3rCzrns=
X-Received: by 2002:a05:6402:30bb:b0:60c:4220:5d8b with SMTP id
 4fb4d7f45d1cf-611e84ab122mr8444566a12.17.1752488310997; Mon, 14 Jul 2025
 03:18:30 -0700 (PDT)
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
 <2025071330-alkalize-bonus-ebec@gregkh> <CAAhV-H6MnutZughoES5z_vuZq3PErqMjcJrNEYO+kQLcCQd=sw@mail.gmail.com>
 <2025071306-barber-unbalance-53bb@gregkh>
In-Reply-To: <2025071306-barber-unbalance-53bb@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 14 Jul 2025 18:18:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7P352ujN-ki=vGxSY2DQPnwMWFq=3i+-LywBLMG3iqeQ@mail.gmail.com>
X-Gm-Features: Ac12FXygS4qiUkiWUpWDgdRwfIMJyn6wDTCQVcKxzmp_IilR1J7VWEyTwUbL9Xg
Message-ID: <CAAhV-H7P352ujN-ki=vGxSY2DQPnwMWFq=3i+-LywBLMG3iqeQ@mail.gmail.com>
Subject: Re: [PATCH] init: Handle bootloader head in kernel parameters
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 5:35=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sun, Jul 13, 2025 at 05:11:20PM +0800, Huacai Chen wrote:
> > On Sun, Jul 13, 2025 at 4:30=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Sat, Jul 12, 2025 at 11:18:44PM +0800, Huacai Chen wrote:
> > > > On Fri, Jul 11, 2025 at 9:04=E2=80=AFPM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > On Fri, Jul 11, 2025 at 08:51:28PM +0800, Huacai Chen wrote:
> > > > > > On Fri, Jul 11, 2025 at 8:41=E2=80=AFPM Greg KH <gregkh@linuxfo=
undation.org> wrote:
> > > > > > >
> > > > > > > On Fri, Jul 11, 2025 at 08:34:25PM +0800, Huacai Chen wrote:
> > > > > > > > Hi, Greg,
> > > > > > > >
> > > > > > > > On Fri, Jul 11, 2025 at 7:06=E2=80=AFPM Greg KH <gregkh@lin=
uxfoundation.org> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Jul 11, 2025 at 06:24:55PM +0800, Huacai Chen wro=
te:
> > > > > > > > > > BootLoader may pass a head such as "BOOT_IMAGE=3D/boot/=
vmlinuz-x.y.z" to
> > > > > > > > > > kernel parameters. But this head is not recognized by t=
he kernel so will
> > > > > > > > > > be passed to user space. However, user space init progr=
am also doesn't
> > > > > > > > > > recognized it.
> > > > > > > > >
> > > > > > > > > Then why is it on the kernel command line if it is not re=
cognized?
> > > > > > > > UEFI put it at the beginning of the command line, you can s=
ee it from
> > > > > > > > /proc/cmdline, both on x86 and LoongArch.
> > > > > > >
> > > > > > > Then fix UEFI :)
> > > > > > >
> > > > > > > My boot command line doesn't have that on x86, perhaps you ne=
ed to fix
> > > > > > > your bootloader?
> > > > > > Not only UEFI, Grub also do this, for many years, not now. I do=
n't
> > > > > > know why they do this, but I think at least it is not a bug. Fo=
r
> > > > > > example, maybe it just tells user the path of kernel image via
> > > > > > /proc/cmdline.
> > > > > >
> > > > > > [chenhuacai@kernelserver linux-official.git]$ uname -a
> > > > > > Linux kernelserver 6.12.0-84.el10.x86_64 #1 SMP PREEMPT_DYNAMIC=
 Tue
> > > > > > May 13 13:39:02 UTC 2025 x86_64 GNU/Linux
> > > > > > [chenhuacai@kernelserver linux-official.git]$ cat /proc/cmdline
> > > > > > BOOT_IMAGE=3D(hd0,gpt2)/vmlinuz-6.12.0-84.el10.x86_64
> > > > > > root=3DUUID=3Dc8fcb11a-0f2f-48e5-a067-4cec1d18a721 ro
> > > > > > crashkernel=3D2G-64G:256M,64G-:512M
> > > > > > resume=3DUUID=3D1c320fec-3274-4b5b-9adf-a06
> > > > > > 42e7943c0 rhgb quiet
> > > > >
> > > > > Sounds like a bootloader bug:
> > > > >
> > > > > $ cat /proc/cmdline
> > > > > root=3D/dev/sda2 rw
> > > > >
> > > > > I suggest fixing the issue there, at the root please.
> > > > Grub pass BOOT_IMAGE for all EFI-based implementations, related com=
mits of Grub:
> > > > https://cgit.git.savannah.gnu.org/cgit/grub.git/commit/?id=3D16ccb8=
b138218d56875051d547af84410d18f9aa
> > > > https://cgit.git.savannah.gnu.org/cgit/grub.git/commit/?id=3D25953e=
10553dad2e378541a68686fc094603ec54
> > >
> > > From 2005 and 2011?  Why have we not had any reports of this being an
> > > issue before now?  What changed in the kernel recently?
> > As said before, just in some corner cases it causes problems, but
> > corner case doesn't means nothing.
> >
> > >
> > > > Linux kernel treats BOOT_IMAGE as an "offender" of unknown command
> > > > line parameters, related commits of kernel:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D86d1919a4fb0d9c115dd1d3b969f5d1650e45408
> > >
> > > So in 2021 we started printing out command line arguments that were
> > > "wrong", so is this when everyone noticed that grub was wrong?
> > Somebody may think a warning is harmless, somebody thinks a warning
> > means a problem needs to fix.
>
> Great, then fix it in grub to not do this :)
>
> Are we supposed to paper over the bugs in all bootloaders?  Especially
> for ones that we have the source to?
>
> > > > There are user space projects that search BOOT_IMAGE from /proc/cmd=
line:
> > > > https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/util.=
go
> > > > (search getBootOptions)
> > > > https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/main.=
go
> > > > (search getKernelReleaseWithBootOption)
> > >
> > > What does it use these options for that it can't get from the valid o=
nes
> > > instead?
> > Some projects have fallback methods, some projects don't work, but at
> > least this means some user space programs depend on it already.
> >
> > >
> > > > So, we can say Grub pass BOOT_IMAGE is reasonable and there are use=
r
> > > > space programs that hope it be in /proc/cmdline.
> > >
> > > But who relies on this that never noticed the kernel complaining abou=
t
> > > it for the past 4 years?
> > So If I'm the first man who notices this and wants to improve
> > something, then it is my mistake?
>
> No, not at all, I'm saying to fix the root problem here please.  And
> that root problem is grub adding stuff that causes warnings in Linux to
> happen.  Why is this Linux's issue to handle?
As I said before:

Corner cases have had problems since 2005, and just because they are
corner cases, they are not noticed by everyone. But once they are
noticed, they need to be fixed. And we cannot change Grub (LILO do the
same thing) now, because user space relies on it already.

>
> thanks,
>
> greg k-h

