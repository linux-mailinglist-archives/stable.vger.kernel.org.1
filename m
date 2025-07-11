Return-Path: <stable+bounces-161655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EE2B01C2E
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 14:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF12C3B24EE
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 12:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628A22BE7A1;
	Fri, 11 Jul 2025 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uVow4T2a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70723C26;
	Fri, 11 Jul 2025 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752237663; cv=none; b=VV1/jdq81I5PeuFbAAdC6vf0VTefUuRUq9GVrfzFlXZUGXq4hs+v60yDH0e5afqwwKEx+QAnP/m5MUMz+WayYmyptXTLNwV/1T7BF98rMQYK1afUtqo8Qu3t80K00xChR6XJSUJKaTtr1W7EPIL7ne0YsFmgQ5vcG++Bwvg14I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752237663; c=relaxed/simple;
	bh=ZY/3jhhQdoYpMzj9GfQknWGqsGqw2sazOyOKr5CRDvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlfapTNaGUAOM1LpjS0WgZWuJQggiEmukrIelleRzsZlb+bW5GdsoXMVMLyvVzeaFbfGxWzNZWV3vZd+TYoseADBuhqbG/z1dlwix1KRSVkll5r4UPeIO/aAZ8HeCpd5jhQEno5MFVWD38K33Q1BrKQE4bI1MRdgs65fS7qwx2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uVow4T2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBDBC4CEED;
	Fri, 11 Jul 2025 12:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752237662;
	bh=ZY/3jhhQdoYpMzj9GfQknWGqsGqw2sazOyOKr5CRDvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVow4T2adzLEVIod2EBHm1qDxHBcgYCw8wBhok7q3V/qPxwbsc7IXI/pQ1rkTErXy
	 HBU5MbXB+cpcCSlrFdVHC6bL6EdbJDBtDKqD0RdLIspNWGfdk1z0RASrTk7CInnBd4
	 oRuPdbViCeT6AcdxS6AIUziaAeWg25pIaX8QlVZg=
Date: Fri, 11 Jul 2025 14:40:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] init: Handle bootloader head in kernel parameters
Message-ID: <2025071116-pushchair-happening-a4cf@gregkh>
References: <20250711102455.3673865-1-chenhuacai@loongson.cn>
 <2025071130-mangle-ramrod-38ff@gregkh>
 <CAAhV-H7oEv5jPufY+J-0wOax=m1pszck1__Ptapz5pmzYU5KHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7oEv5jPufY+J-0wOax=m1pszck1__Ptapz5pmzYU5KHg@mail.gmail.com>

On Fri, Jul 11, 2025 at 08:34:25PM +0800, Huacai Chen wrote:
> Hi, Greg,
> 
> On Fri, Jul 11, 2025 at 7:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jul 11, 2025 at 06:24:55PM +0800, Huacai Chen wrote:
> > > BootLoader may pass a head such as "BOOT_IMAGE=/boot/vmlinuz-x.y.z" to
> > > kernel parameters. But this head is not recognized by the kernel so will
> > > be passed to user space. However, user space init program also doesn't
> > > recognized it.
> >
> > Then why is it on the kernel command line if it is not recognized?
> UEFI put it at the beginning of the command line, you can see it from
> /proc/cmdline, both on x86 and LoongArch.

Then fix UEFI :)

My boot command line doesn't have that on x86, perhaps you need to fix
your bootloader?

> > > KEXEC may also pass a head such as "kexec" on some architectures.
> >
> > That's fine, kexec needs this.
> >
> > > So the the best way is handle it by the kernel itself, which can avoid
> > > such boot warnings:
> > >
> > > Kernel command line: BOOT_IMAGE=(hd0,1)/vmlinuz-6.x root=/dev/sda3 ro console=tty
> > > Unknown kernel command line parameters "BOOT_IMAGE=(hd0,1)/vmlinuz-6.x", will be passed to user space.
> >
> > Why is this a problem?  Don't put stuff that is not needed on the kernel
> > command line :)
> Both kernel and user space don't need it, and if it is passed to user
> space then may cause some problems. For example, if there is
> init=/bin/bash, then bash will crash with this parameter.

Again, fix the bootloader to not do this, why is the kernel responsible
for this?

What has suddenly changed to now require this when we never have needed
it before?

> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  init/main.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/init/main.c b/init/main.c
> > > index 225a58279acd..9e0a7e8913c0 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -545,6 +545,7 @@ static int __init unknown_bootoption(char *param, char *val,
> > >                                    const char *unused, void *arg)
> > >  {
> > >       size_t len = strlen(param);
> > > +     const char *bootloader[] = { "BOOT_IMAGE", "kexec", NULL };
> >
> > You need to document why these are ok to "swallow" and not warn for.
> Because they are bootloader heads, not really a wrong parameter. We
> only need a warning if there is a wrong parameter.

Again, fix the bootloader.

> > >
> > >       /* Handle params aliased to sysctls */
> > >       if (sysctl_is_alias(param))
> > > @@ -552,6 +553,12 @@ static int __init unknown_bootoption(char *param, char *val,
> > >
> > >       repair_env_string(param, val);
> > >
> > > +     /* Handle bootloader head */
> >
> > Handle it how?
> argv_init and envp_init arrays will be passed to userspace, so just
> return early (before argv_init and envp_init handling) can avoid it
> being passed.

You need to document this way better.

But again, please just fix your bootloader to not pass on lines to the
kernel that it can not parse.

thanks,

greg k-h

