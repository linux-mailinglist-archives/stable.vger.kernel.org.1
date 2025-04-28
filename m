Return-Path: <stable+bounces-136801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 105B2A9E933
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 09:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0453B8BAA
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 07:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AFF1E3DD3;
	Mon, 28 Apr 2025 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ckd+OfzZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zyVl2ZHt"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3C11D88A4
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 07:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824983; cv=none; b=Y+O9pxeZV3GSCZtz0BUIvsveTlI98LqtRymsPHHOSdz6I48h1I+EYYNlFFXcv+f2yFI1EIn21U/Ftdvyoz5NqiPeP7G8mSfSuZlwvuVQZGbPIurAbXJIm4wi9zD0GEXqq5Sr+P0WFRjqycT4Ewbh4CVXa0kuEbKVoXl2FbKb2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824983; c=relaxed/simple;
	bh=Lwt1S/+Ij1/ClIYOoM36zrs/p2Rur9qsU6H/lNyxxXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTi8+9oCpfkAkEplX0RNq6cJRCdKaEdvdSlwCw/ysf9rXHb/7RyrA7ikHNr1w3zblupzepeAUE1fWCMX9sQO60HQzyllUfYrCvM3Pf0KDfcim3++IAXowRGzqAlYVRqlSLyRJNAn3mDVk5QQxxOZNBgUlgYim5vbhMgDgVByeng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ckd+OfzZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zyVl2ZHt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Apr 2025 09:22:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745824973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1HDEHPjJ/T281F9ZUUNMCG+X7CH5EYNDAoKwqEqro3Q=;
	b=ckd+OfzZqT42JzX+qYhxDW29MeutQJp+XgS7Dm4yCh4Eng8afTPkSExpkoCEbsx94/VNVl
	hZQU4DHtBd/GAHDuPjqL9RBSvQTgVZKDIFOhVUggRzS90EFHDSlt1HYG4wOrUVPnU0pSPo
	H1vGAYN5ix7TgUpfG1pMsIZfXmekdkQdWK8UjMzYi10hE/nY52UFtNLyO49Ojm3TY14AYh
	626UAxQWraGETTxA1neD0IUTScZLZlEYEumTsHtgVr/85Zr4BwR4NU3YIEOZi5HquHgsCW
	bsfDfDa3MkY94IqVZ+JZny2V/AvINsNmbCbcAK1FTUHbrw02/xN5jWQSssW7Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745824973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1HDEHPjJ/T281F9ZUUNMCG+X7CH5EYNDAoKwqEqro3Q=;
	b=zyVl2ZHtVkoYk+ZCcEvTuoXutcO/vMpuRApEa1/CE5MOufoAUUAbafIzxsOosshOmVqRie
	0s4E8uRGEbNUThAQ==
From: Nam Cao <namcao@linutronix.de>
To: Kai Zhang <zhangkai@iscas.ac.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, stable@vger.kernel.org
Subject: Re: [linux-6.6.y bugreport] riscv: kprobe crash as some patchs lost
Message-ID: <20250428072248.JgEWTcfe@linutronix.de>
References: <c7e463c0-8cad-4f4e-addd-195c06b7b6de@iscas.ac.cn>
 <2025042250-backlash-shifting-89cf@gregkh>
 <72896429-e966-4f7a-b2f2-ebc33368eb12@iscas.ac.cn>
 <2025042518-craftily-coronary-b63a@gregkh>
 <2095c40a-a5a8-417a-bd0b-47e782e9f42d@iscas.ac.cn>
 <20250425124950.FQzzDETT@linutronix.de>
 <20250425125912.57u73cuH@linutronix.de>
 <c66369fa-4042-4a76-9d1c-9e581f003526@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c66369fa-4042-4a76-9d1c-9e581f003526@iscas.ac.cn>

On Fri, Apr 25, 2025 at 11:29:17PM +0800, Kai Zhang wrote:
> On 4/25/2025 8:59 PM, Nam Cao wrote:
> > On Fri, Apr 25, 2025 at 02:49:52PM +0200, Nam Cao wrote:
> > > On Fri, Apr 25, 2025 at 08:09:21PM +0800, Kai Zhang wrote:
> > > > On 4/25/2025 4:07 PM, Greg Kroah-Hartman wrote:
> > > > > On Fri, Apr 25, 2025 at 04:03:41PM +0800, Kai Zhang wrote:
> > > > > > On 4/22/2025 4:46 PM, Greg Kroah-Hartman wrote:
> > > > > > > On Tue, Apr 22, 2025 at 10:58:42AM +0800, Kai Zhang wrote:
> > > > > > > > In most recent linux-6.6.y tree,
> > > > > > > > `arch/riscv/kernel/probes/kprobes.c::arch_prepare_ss_slot` still has the
> > > > > > > > obsolete code:
> > > > > > > > 
> > > > > > > >        u32 insn = __BUG_INSN_32;
> > > > > > > >        unsigned long offset = GET_INSN_LENGTH(p->opcode);
> > > > > > > >        p->ainsn.api.restore = (unsigned long)p->addr + offset;
> > > > > > > >        patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
> > > > > > > >        patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, 1);
> > > > > > > > 
> > > > > > > > The last two 1s are wrong size of written instructions , which would lead to
> > > > > > > > kernel crash, like `insmod kprobe_example.ko` gives:
> > > > > > > > 
> > > > > > > > [  509.812815][ T2734] kprobe_init: Planted kprobe at 00000000c5c46130
> > > > > > > > [  509.837606][    C5] handler_pre: <kernel_clone> p->addr =
> > > > > > > > 0x00000000c5c46130, pc = 0xffffffff80032ee2, status = 0x200000120
> > > > > > > > [  509.839315][    C5] Oops - illegal instruction [#1]
> > > > > > > > 
> > > > > > > > 
> > > > > > > > I've tried two patchs from torvalds tree and it didn't crash again:
> > > > > > > > 
> > > > > > > > 51781ce8f448 riscv: Pass patch_text() the length in bytes (rebased)
> > > > > > > > 13134cc94914 riscv: kprobes: Fix incorrect address calculation
> > > 
> > > Please don't revert this patch. It fixes another issue.
> > > 
> > > You are correct that the sizes of the instructions are wrong. It can still
> > > happen to work if only one instruction is patched.
> > > 
> > > This bug is not specific to v6.6. It is in mainline as well. Therefore fix
> > > patch should be sent to mainline, and then backport to v6.6.
> > 
> > Sorry, I was confused. This is not in mainline. It has already been fixed
> > by 51781ce8f448 ("riscv: Pass patch_text() the length in bytes")
> 
> Indeed.
> 
> > But I wouldn't backport that patch, it is bigger than necessary. The patch
> > I sent in the previous email should be enough.
> 
> My suggested fixes are:
> 
> revert 03753bfacbc6(riscv: kprobes: Fix incorrect address calculation)
> apply  51781ce8f448(riscv: Pass patch_text() the length in bytes)
> apply  13134cc94914(riscv: kprobes: Fix incorrect address calculation)

This is probably fine. But I'm paranoid that as 51781ce8f448 ("riscv:
Pass patch_text() the length in bytes") does many things, it may break
something else in v6.6.

Also, just my preference, but I wouldn't revert a commit then apply it
again. I would only cherry-pick 51781ce8f448, and resolve conflicts.

> Because stable-only commit 03753bfacbc6 is actually rebased upstream
> 13134cc94914, and 13134cc94914 relied on 51781ce8f448. So I gave the above
> suggestion. But I'm ok with your previous email patch.

It was just my suggestion. Do as you think best, CC the relevant people
(RISCV maintainers and authors of those commits), see what they think.

Or I could send the diff I sent earlier as a proper patch. Up to you.

Best regards,
Nam

