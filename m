Return-Path: <stable+bounces-161657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BB5B01CF3
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 15:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D325BB43ECA
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 13:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AA32D29DF;
	Fri, 11 Jul 2025 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NA7nERxy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48222D23B7;
	Fri, 11 Jul 2025 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239095; cv=none; b=QRt6/JKBb3Y/oy5s8kmxaP89y9hKo4aYytUfaA3sgRr0aMqgU5XIGCgNzQKMnfsmGTx2Xw7ZQN7Ajfzs17ZDNpb5pMNZg2OpBOHzlpbAldsQP9LQ5mXgElyeoDR64l82Mh4hZmA2tzQCKvC7dwZNxRs75M1MaCEzRCIMSfYI11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239095; c=relaxed/simple;
	bh=6z7oU0uU765/J04iCHJScJt3NL1bbMh6XXWNMVbsBPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/I0fS4ee3Hi+Zvh2iG1JB5BbzOMQbgBxS/InZVBUbEc90ShQCTfUn6lZ4YGwq0RXMZIJAk+wZFK4PD88KPv+sd8g5hu1AJWhIbH3Vaf/r3JspOA0FOhMsGKzLgLx1rl9sTuxx1Xksts0JUS7ZkPz0ZzlH5S0Nee5rjVfa58zWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NA7nERxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA92C4CEED;
	Fri, 11 Jul 2025 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752239095;
	bh=6z7oU0uU765/J04iCHJScJt3NL1bbMh6XXWNMVbsBPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NA7nERxyXOPPYjjmf5rAr/5bp9wlPl996XUM0MI4V/3f/4Dnodkv1kOlPMUJ/X7h3
	 icwK9F0dkr1sCjoeL5WDUZn8p+7MePz45E3nbBcNeqd/y8cYt1DagNFxsBxGkjEJzx
	 jfuiM6cSXXxsViPE0YmiqqMx8GEN8bq7dFZ9oJVI=
Date: Fri, 11 Jul 2025 15:04:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] init: Handle bootloader head in kernel parameters
Message-ID: <2025071150-oasis-chewy-4137@gregkh>
References: <20250711102455.3673865-1-chenhuacai@loongson.cn>
 <2025071130-mangle-ramrod-38ff@gregkh>
 <CAAhV-H7oEv5jPufY+J-0wOax=m1pszck1__Ptapz5pmzYU5KHg@mail.gmail.com>
 <2025071116-pushchair-happening-a4cf@gregkh>
 <CAAhV-H69oz-Rmz4Q2Gad-x5AR0C2cxtK7Mgsc5iJHALP_NcEhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H69oz-Rmz4Q2Gad-x5AR0C2cxtK7Mgsc5iJHALP_NcEhw@mail.gmail.com>

On Fri, Jul 11, 2025 at 08:51:28PM +0800, Huacai Chen wrote:
> On Fri, Jul 11, 2025 at 8:41 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jul 11, 2025 at 08:34:25PM +0800, Huacai Chen wrote:
> > > Hi, Greg,
> > >
> > > On Fri, Jul 11, 2025 at 7:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Fri, Jul 11, 2025 at 06:24:55PM +0800, Huacai Chen wrote:
> > > > > BootLoader may pass a head such as "BOOT_IMAGE=/boot/vmlinuz-x.y.z" to
> > > > > kernel parameters. But this head is not recognized by the kernel so will
> > > > > be passed to user space. However, user space init program also doesn't
> > > > > recognized it.
> > > >
> > > > Then why is it on the kernel command line if it is not recognized?
> > > UEFI put it at the beginning of the command line, you can see it from
> > > /proc/cmdline, both on x86 and LoongArch.
> >
> > Then fix UEFI :)
> >
> > My boot command line doesn't have that on x86, perhaps you need to fix
> > your bootloader?
> Not only UEFI, Grub also do this, for many years, not now. I don't
> know why they do this, but I think at least it is not a bug. For
> example, maybe it just tells user the path of kernel image via
> /proc/cmdline.
> 
> [chenhuacai@kernelserver linux-official.git]$ uname -a
> Linux kernelserver 6.12.0-84.el10.x86_64 #1 SMP PREEMPT_DYNAMIC Tue
> May 13 13:39:02 UTC 2025 x86_64 GNU/Linux
> [chenhuacai@kernelserver linux-official.git]$ cat /proc/cmdline
> BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.12.0-84.el10.x86_64
> root=UUID=c8fcb11a-0f2f-48e5-a067-4cec1d18a721 ro
> crashkernel=2G-64G:256M,64G-:512M
> resume=UUID=1c320fec-3274-4b5b-9adf-a06
> 42e7943c0 rhgb quiet

Sounds like a bootloader bug:

$ cat /proc/cmdline
root=/dev/sda2 rw

I suggest fixing the issue there, at the root please.

> > > > > KEXEC may also pass a head such as "kexec" on some architectures.
> > > >
> > > > That's fine, kexec needs this.
> > > >
> > > > > So the the best way is handle it by the kernel itself, which can avoid
> > > > > such boot warnings:
> > > > >
> > > > > Kernel command line: BOOT_IMAGE=(hd0,1)/vmlinuz-6.x root=/dev/sda3 ro console=tty
> > > > > Unknown kernel command line parameters "BOOT_IMAGE=(hd0,1)/vmlinuz-6.x", will be passed to user space.
> > > >
> > > > Why is this a problem?  Don't put stuff that is not needed on the kernel
> > > > command line :)
> > > Both kernel and user space don't need it, and if it is passed to user
> > > space then may cause some problems. For example, if there is
> > > init=/bin/bash, then bash will crash with this parameter.
> >
> > Again, fix the bootloader to not do this, why is the kernel responsible
> > for this?
> >
> > What has suddenly changed to now require this when we never have needed
> > it before?
> Because init=/bin/bash is not a usual use case, so in most cases it is
> just a warning in dmesg. But once we see it, we need to fix it.

Why is this the kernel's fault?

Again, what changed in the kernel to cause this to happen?  I think you
are seeing bugs in bootloaders, NOT in the kernel.  Fix the issue at the
root, don't paper over the problem in the kernel for something that is
NOT the kernel's fault.

> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > ---
> > > > >  init/main.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/init/main.c b/init/main.c
> > > > > index 225a58279acd..9e0a7e8913c0 100644
> > > > > --- a/init/main.c
> > > > > +++ b/init/main.c
> > > > > @@ -545,6 +545,7 @@ static int __init unknown_bootoption(char *param, char *val,
> > > > >                                    const char *unused, void *arg)
> > > > >  {
> > > > >       size_t len = strlen(param);
> > > > > +     const char *bootloader[] = { "BOOT_IMAGE", "kexec", NULL };
> > > >
> > > > You need to document why these are ok to "swallow" and not warn for.
> > > Because they are bootloader heads, not really a wrong parameter. We
> > > only need a warning if there is a wrong parameter.
> >
> > Again, fix the bootloader.
> But I don't think this is a bootloader bug.

Seems like it is if nothing changed in the kernel and this just started
showing up now :)

Unless you can find a kernel commit that caused this issue?

thanks,

greg k-h

