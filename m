Return-Path: <stable+bounces-161758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E97AB0307C
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 11:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E388317E95A
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 09:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CAA2E40B;
	Sun, 13 Jul 2025 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CiugZelt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDFCF4FA;
	Sun, 13 Jul 2025 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752399328; cv=none; b=Z8ybPRHgiGkarhbz4QygTzh8ChVJmwIy43m9WtLzO2DTYdeHKjVMNUbhncrvQUJYoPthCDi/1BG1TOW7tA1/aqlNEoUaS2TPt9mdRLzjqfKEGaIzSa+JdNm8CHb6yosnRHHcQLwseoTDcfISUvePh3RfE+cWcnArORVdPjgBDq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752399328; c=relaxed/simple;
	bh=Di228D3he1kxfcQNeDttgDNudPZC7dWeCIHqqV3j/+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j26fOuLodvVn+CdSKG1OlovfDwvkS4ljWwOIfbyP7GKMcuPoDjzWnRYGFOqEy6CZ7tt4V6beIaiOd6LodE53N2b3bApUs6tICUhT5C6OWrIXY9mhyqXr3GlhzBlk7WxPvM2UVducutLtoihbJiAGnMDxYpopTK4pglRLhooZdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CiugZelt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC30C4CEE3;
	Sun, 13 Jul 2025 09:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752399328;
	bh=Di228D3he1kxfcQNeDttgDNudPZC7dWeCIHqqV3j/+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CiugZeltTFj7XoOE7eyXEHykY+ug0GRTmmZQkfFBClWEylCuUKJa+T47ord1c/+Uz
	 UvHGZitaPcdtzs98B1sClpdsTvICmGT3ETjmXhi4jzyNaYO04gZsrYFpVUSM9ZM2F9
	 O6d0gpQ7KFbU51hNtgufoKwnoXK9D/msksiuipYc=
Date: Sun, 13 Jul 2025 11:35:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] init: Handle bootloader head in kernel parameters
Message-ID: <2025071306-barber-unbalance-53bb@gregkh>
References: <20250711102455.3673865-1-chenhuacai@loongson.cn>
 <2025071130-mangle-ramrod-38ff@gregkh>
 <CAAhV-H7oEv5jPufY+J-0wOax=m1pszck1__Ptapz5pmzYU5KHg@mail.gmail.com>
 <2025071116-pushchair-happening-a4cf@gregkh>
 <CAAhV-H69oz-Rmz4Q2Gad-x5AR0C2cxtK7Mgsc5iJHALP_NcEhw@mail.gmail.com>
 <2025071150-oasis-chewy-4137@gregkh>
 <CAAhV-H4kzxR9e762r+ZzCyPrUemDtwqXvp_BJY3R1O1MPV9hrw@mail.gmail.com>
 <2025071330-alkalize-bonus-ebec@gregkh>
 <CAAhV-H6MnutZughoES5z_vuZq3PErqMjcJrNEYO+kQLcCQd=sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6MnutZughoES5z_vuZq3PErqMjcJrNEYO+kQLcCQd=sw@mail.gmail.com>

On Sun, Jul 13, 2025 at 05:11:20PM +0800, Huacai Chen wrote:
> On Sun, Jul 13, 2025 at 4:30 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Jul 12, 2025 at 11:18:44PM +0800, Huacai Chen wrote:
> > > On Fri, Jul 11, 2025 at 9:04 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Fri, Jul 11, 2025 at 08:51:28PM +0800, Huacai Chen wrote:
> > > > > On Fri, Jul 11, 2025 at 8:41 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Fri, Jul 11, 2025 at 08:34:25PM +0800, Huacai Chen wrote:
> > > > > > > Hi, Greg,
> > > > > > >
> > > > > > > On Fri, Jul 11, 2025 at 7:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jul 11, 2025 at 06:24:55PM +0800, Huacai Chen wrote:
> > > > > > > > > BootLoader may pass a head such as "BOOT_IMAGE=/boot/vmlinuz-x.y.z" to
> > > > > > > > > kernel parameters. But this head is not recognized by the kernel so will
> > > > > > > > > be passed to user space. However, user space init program also doesn't
> > > > > > > > > recognized it.
> > > > > > > >
> > > > > > > > Then why is it on the kernel command line if it is not recognized?
> > > > > > > UEFI put it at the beginning of the command line, you can see it from
> > > > > > > /proc/cmdline, both on x86 and LoongArch.
> > > > > >
> > > > > > Then fix UEFI :)
> > > > > >
> > > > > > My boot command line doesn't have that on x86, perhaps you need to fix
> > > > > > your bootloader?
> > > > > Not only UEFI, Grub also do this, for many years, not now. I don't
> > > > > know why they do this, but I think at least it is not a bug. For
> > > > > example, maybe it just tells user the path of kernel image via
> > > > > /proc/cmdline.
> > > > >
> > > > > [chenhuacai@kernelserver linux-official.git]$ uname -a
> > > > > Linux kernelserver 6.12.0-84.el10.x86_64 #1 SMP PREEMPT_DYNAMIC Tue
> > > > > May 13 13:39:02 UTC 2025 x86_64 GNU/Linux
> > > > > [chenhuacai@kernelserver linux-official.git]$ cat /proc/cmdline
> > > > > BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.12.0-84.el10.x86_64
> > > > > root=UUID=c8fcb11a-0f2f-48e5-a067-4cec1d18a721 ro
> > > > > crashkernel=2G-64G:256M,64G-:512M
> > > > > resume=UUID=1c320fec-3274-4b5b-9adf-a06
> > > > > 42e7943c0 rhgb quiet
> > > >
> > > > Sounds like a bootloader bug:
> > > >
> > > > $ cat /proc/cmdline
> > > > root=/dev/sda2 rw
> > > >
> > > > I suggest fixing the issue there, at the root please.
> > > Grub pass BOOT_IMAGE for all EFI-based implementations, related commits of Grub:
> > > https://cgit.git.savannah.gnu.org/cgit/grub.git/commit/?id=16ccb8b138218d56875051d547af84410d18f9aa
> > > https://cgit.git.savannah.gnu.org/cgit/grub.git/commit/?id=25953e10553dad2e378541a68686fc094603ec54
> >
> > From 2005 and 2011?  Why have we not had any reports of this being an
> > issue before now?  What changed in the kernel recently?
> As said before, just in some corner cases it causes problems, but
> corner case doesn't means nothing.
> 
> >
> > > Linux kernel treats BOOT_IMAGE as an "offender" of unknown command
> > > line parameters, related commits of kernel:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=86d1919a4fb0d9c115dd1d3b969f5d1650e45408
> >
> > So in 2021 we started printing out command line arguments that were
> > "wrong", so is this when everyone noticed that grub was wrong?
> Somebody may think a warning is harmless, somebody thinks a warning
> means a problem needs to fix.

Great, then fix it in grub to not do this :)

Are we supposed to paper over the bugs in all bootloaders?  Especially
for ones that we have the source to?

> > > There are user space projects that search BOOT_IMAGE from /proc/cmdline:
> > > https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/util.go
> > > (search getBootOptions)
> > > https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/main.go
> > > (search getKernelReleaseWithBootOption)
> >
> > What does it use these options for that it can't get from the valid ones
> > instead?
> Some projects have fallback methods, some projects don't work, but at
> least this means some user space programs depend on it already.
> 
> >
> > > So, we can say Grub pass BOOT_IMAGE is reasonable and there are user
> > > space programs that hope it be in /proc/cmdline.
> >
> > But who relies on this that never noticed the kernel complaining about
> > it for the past 4 years?
> So If I'm the first man who notices this and wants to improve
> something, then it is my mistake?

No, not at all, I'm saying to fix the root problem here please.  And
that root problem is grub adding stuff that causes warnings in Linux to
happen.  Why is this Linux's issue to handle?

thanks,

greg k-h

