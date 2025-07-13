Return-Path: <stable+bounces-161755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE676B02FE3
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 10:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2743717F9E3
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540ED19C55E;
	Sun, 13 Jul 2025 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZENQaCsy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCBA81E;
	Sun, 13 Jul 2025 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752395442; cv=none; b=aNAqP3uWSWS4rT+Kp/8PiN9BHKhsOYSyhykhAi5ipCLiKVIkYxI4aulgF1nfJxA/yPnpxlgv189Z1trwWM8Bud+BzWlNDRfcp7e3hMLGGg0RBSzzInfDf1QavTOm/zPtBhh9v7gSZ8LfejvDF6zhiZi2wyWNypUpl/tUEmL56wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752395442; c=relaxed/simple;
	bh=zbQvE2eH5TdCyV51o1wwmhwiDWOwyFQZ33tGrRQNxFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4IhZYBJELnno2VZGUvRoQRbjzSeSTzlRv1KZ0ty+WT/WIZ8iu9YItY6iCfu9mQwzpDOw8X/aTSek4Vgdajx2HfD18qoIMStMVo+vqN5DkN0Ky2tZzi3kEhlvUniyGbO0btf3L9WqwXFa0AbrlS0KhmE0ZPx6GbuyDxaSbxlI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZENQaCsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B678C4CEE3;
	Sun, 13 Jul 2025 08:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752395441;
	bh=zbQvE2eH5TdCyV51o1wwmhwiDWOwyFQZ33tGrRQNxFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZENQaCsyeJPLWmiwvh7Sgctxg1tTr3wrLzFEKlN92XZe/ykgFjC/HWkjEAlIM9Yqv
	 HAgC9m/MKj5MWTZRYIgqWp2Zm2zP9F8RJXiM+KeB6N3T2ZORqUNXnA9H0ulF+YhVqi
	 F8QxA0BxQMfUc+jEqp6HgrxzQkFvO0Ji0jMNPp/g=
Date: Sun, 13 Jul 2025 10:30:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] init: Handle bootloader head in kernel parameters
Message-ID: <2025071330-alkalize-bonus-ebec@gregkh>
References: <20250711102455.3673865-1-chenhuacai@loongson.cn>
 <2025071130-mangle-ramrod-38ff@gregkh>
 <CAAhV-H7oEv5jPufY+J-0wOax=m1pszck1__Ptapz5pmzYU5KHg@mail.gmail.com>
 <2025071116-pushchair-happening-a4cf@gregkh>
 <CAAhV-H69oz-Rmz4Q2Gad-x5AR0C2cxtK7Mgsc5iJHALP_NcEhw@mail.gmail.com>
 <2025071150-oasis-chewy-4137@gregkh>
 <CAAhV-H4kzxR9e762r+ZzCyPrUemDtwqXvp_BJY3R1O1MPV9hrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4kzxR9e762r+ZzCyPrUemDtwqXvp_BJY3R1O1MPV9hrw@mail.gmail.com>

On Sat, Jul 12, 2025 at 11:18:44PM +0800, Huacai Chen wrote:
> On Fri, Jul 11, 2025 at 9:04 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jul 11, 2025 at 08:51:28PM +0800, Huacai Chen wrote:
> > > On Fri, Jul 11, 2025 at 8:41 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Fri, Jul 11, 2025 at 08:34:25PM +0800, Huacai Chen wrote:
> > > > > Hi, Greg,
> > > > >
> > > > > On Fri, Jul 11, 2025 at 7:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Fri, Jul 11, 2025 at 06:24:55PM +0800, Huacai Chen wrote:
> > > > > > > BootLoader may pass a head such as "BOOT_IMAGE=/boot/vmlinuz-x.y.z" to
> > > > > > > kernel parameters. But this head is not recognized by the kernel so will
> > > > > > > be passed to user space. However, user space init program also doesn't
> > > > > > > recognized it.
> > > > > >
> > > > > > Then why is it on the kernel command line if it is not recognized?
> > > > > UEFI put it at the beginning of the command line, you can see it from
> > > > > /proc/cmdline, both on x86 and LoongArch.
> > > >
> > > > Then fix UEFI :)
> > > >
> > > > My boot command line doesn't have that on x86, perhaps you need to fix
> > > > your bootloader?
> > > Not only UEFI, Grub also do this, for many years, not now. I don't
> > > know why they do this, but I think at least it is not a bug. For
> > > example, maybe it just tells user the path of kernel image via
> > > /proc/cmdline.
> > >
> > > [chenhuacai@kernelserver linux-official.git]$ uname -a
> > > Linux kernelserver 6.12.0-84.el10.x86_64 #1 SMP PREEMPT_DYNAMIC Tue
> > > May 13 13:39:02 UTC 2025 x86_64 GNU/Linux
> > > [chenhuacai@kernelserver linux-official.git]$ cat /proc/cmdline
> > > BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.12.0-84.el10.x86_64
> > > root=UUID=c8fcb11a-0f2f-48e5-a067-4cec1d18a721 ro
> > > crashkernel=2G-64G:256M,64G-:512M
> > > resume=UUID=1c320fec-3274-4b5b-9adf-a06
> > > 42e7943c0 rhgb quiet
> >
> > Sounds like a bootloader bug:
> >
> > $ cat /proc/cmdline
> > root=/dev/sda2 rw
> >
> > I suggest fixing the issue there, at the root please.
> Grub pass BOOT_IMAGE for all EFI-based implementations, related commits of Grub:
> https://cgit.git.savannah.gnu.org/cgit/grub.git/commit/?id=16ccb8b138218d56875051d547af84410d18f9aa
> https://cgit.git.savannah.gnu.org/cgit/grub.git/commit/?id=25953e10553dad2e378541a68686fc094603ec54

From 2005 and 2011?  Why have we not had any reports of this being an
issue before now?  What changed in the kernel recently?

> Linux kernel treats BOOT_IMAGE as an "offender" of unknown command
> line parameters, related commits of kernel:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=86d1919a4fb0d9c115dd1d3b969f5d1650e45408

So in 2021 we started printing out command line arguments that were
"wrong", so is this when everyone noticed that grub was wrong?

> There are user space projects that search BOOT_IMAGE from /proc/cmdline:
> https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/util.go
> (search getBootOptions)
> https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/main.go
> (search getKernelReleaseWithBootOption)

What does it use these options for that it can't get from the valid ones
instead?

> So, we can say Grub pass BOOT_IMAGE is reasonable and there are user
> space programs that hope it be in /proc/cmdline.

But who relies on this that never noticed the kernel complaining about
it for the past 4 years?

> But BOOT_IMAGE should not be passed to the init program. Strings in
> cmdline contain 4 types: BootLoader head (BOOT_IMAGE, kexec, etc.),
> kernel parameters, init parameters, wrong parameters.

Then fix grub to not do this.

> The first type is handled (ignored) by this patch, the second type is
> handled (consumed) by the kernel, and the last two types are passed to
> user space.

That's not obvious in this patch at all.  If you are doing different
things, make it separate patches.

And again, fix grub.

> If the first type is also passed to user space, there are meaningless
> warnings, and (maybe) cause problems with the init program.

So it's been causing problems for all these years (i.e. since 2005)?

What changed that is causing this to be an issue now, and again, why not
just fix grub?

thanks,

greg k-h

