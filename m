Return-Path: <stable+bounces-3210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4087FEEDE
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 13:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5931C281C6B
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 12:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A884A46435;
	Thu, 30 Nov 2023 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GGI2nGPI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B34E34555
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 12:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21150C433C7;
	Thu, 30 Nov 2023 12:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701346937;
	bh=gwb1GBCsOvRHdGI7B2sk516Lc3TuyoRMTLmOUTD6IZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGI2nGPIYKKd8tWoXxm0BcxkSPS09xrNN85hFWy3ZjE5uzF6oNcw1jBk2zHf7vj4w
	 urKSfjKns5+gWnqGTzlE4bQtGjBFsLMvlD5rKxGmHeUIB9mNYRb7y8t8Vys9aYDe0r
	 9kYEWx20QyeGI+91wvfmox21LOjxorR0jLGvpw4Q=
Date: Thu, 30 Nov 2023 12:22:14 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Ronald Monthero <debug.penguin32@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Backport submission - rcu: Avoid tracing a few functions
 executed in stop machine
Message-ID: <2023113012-humorous-marshy-3060@gregkh>
References: <CALk6Uxo5ymxu_P_7=LnLZwTgjYbrdE7gzwyeQVxeR431SPuxyw@mail.gmail.com>
 <2023112431-matching-imperfect-1b76@gregkh>
 <CALk6UxqZtm_MR9cYyN2UvTF_7xPH0D-zQ_uUjZKjNGfU-JOX-A@mail.gmail.com>
 <CALk6Uxoq=f7ews1Beve3qW_38w0sw1fnpJvmwMDfxy9eM+1AmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALk6Uxoq=f7ews1Beve3qW_38w0sw1fnpJvmwMDfxy9eM+1AmA@mail.gmail.com>

On Thu, Nov 30, 2023 at 10:07:03PM +1000, Ronald Monthero wrote:
> On Thu, Nov 30, 2023 at 12:08 AM Ronald Monthero
> <debug.penguin32@gmail.com> wrote:
> >
> > On Sat, Nov 25, 2023 at 2:10 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Nov 21, 2023 at 12:09:38AM +1000, Ronald Monthero wrote:
> > > > Dear stable maintainers,
> > > > I like to indicate the oops encountered and request the below patch to
> > > > be backported to v 5.15. The fix is important to avoid recurring oops
> > > > in context of rcu detected stalls.
> > > >
> > > > subject: rcu: Avoid tracing a few functions executed in stop machine
> > > > commit  48f8070f5dd8
> > > > Target kernel version   v 5.15
> > > > Reason for Application: To avoid oops due to rcu_prempt detect stalls
> > > > on cpus/tasks
> > > >
> > > > Environment and oops context: Issue was observed in my environment on
> > > > 5.15.193 kernel (arm platform). The patch is helpful to avoid the
> > > > below oops indicated in [1] and [2]
> > >
> > > As the patch does not apply cleanly, we need a working and tested
> > > backport so we know to apply the correct version.
> > >
> > > Can you please provide that as you've obviously already done this?
> >
> > Hi Greg,
> > Sorry I notice my typo error 193 instead of 93. I have tested on the
> > 5.15.93-rt58  kernel.
> 
> Hi Greg,
> I used a 5.15.93 kernel
> - on arm32 bit platform I tested with 5.15.93-rt58 (rt kernel) ,  on
> real hardware - Freescale LS1021A, 32 bit Cortex A7 processor
> - on x86_64 platform I tested non rt kernel 5.15.93  -  virtual
> machine - qemu platform
> 
> Below is the build log after patch to kernel/rcu/tree.h on x86_64
> 
> linux-5.15.93$ make
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND objtool
>   DESCEND bpf/resolve_btfids
>   CHK     include/generated/compile.h
>   CC      kernel/rcu/tree.o                         <<<
>   AR      kernel/rcu/built-in.a                     <<<
>   AR      kernel/built-in.a
>   CHK     kernel/kheaders_data.tar.xz
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   LD      vmlinux.o
>   MODPOST vmlinux.symvers
>   MODINFO modules.builtin.modinfo
>   GEN     modules.builtin
>   LD      .tmp_vmlinux.btf
>   BTF     .btf.vmlinux.bin.o
>   LD      .tmp_vmlinux.kallsyms1
> 
> < snipped >
> 
>   BTF [M] sound/usb/usx2y/snd-usb-usx2y.ko
>   BTF [M] sound/virtio/virtio_snd.ko
>   BTF [M] sound/x86/snd-hdmi-lpe-audio.ko
>   BTF [M] sound/xen/snd_xen_front.ko
>   BTF [M] virt/lib/irqbypass.ko
> linux-5.15.93$

I don't understand what you are showing here, sorry.

I do not have a working backport anywhere that I can see, that is what
we need.  As you seem to have one, can you please submit it?

Also note, if you are using the -rt kernel, that changes lots of stuff
that we know nothing about, please work with the -rt kernel developers
about that.

thanks,

greg k-h

