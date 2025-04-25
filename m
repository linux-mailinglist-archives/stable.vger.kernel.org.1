Return-Path: <stable+bounces-136703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16599A9C93C
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 14:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87AB83B00A9
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 12:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B001247285;
	Fri, 25 Apr 2025 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PVa9uy1b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8JoYq9+L"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D37A12CD8B
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585396; cv=none; b=Y9W3iT/UoJO8MuvwP/SAbp/DjzQP91/+95owu6N6d1Em8F1MG6MdyOblc2hIYFsebJeC7o2/ZsCNC05zGut1VmdgSx/ISpWT67DfOtcKTe9n0/+kL4R8oKtOwq3nxasvshCCZNWUs1iJlG8lWbLPYAjbdN0g9bDNjNCvPGy87ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585396; c=relaxed/simple;
	bh=0pXx59Pnj24KBPIQ7eFkjTtGzO3GH74Bt5Tdgo4Z1PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvUAqd0VhC3qIGFSIuwTu8NcDo8kVS3060HdPfODWOvVSGZ9Yt3z3WYHQKu3bXC0MoV7QBGSQA8RWDGKg9j/15irqHB7zHX4TrDkvJY3AOAmbe7uB3e2C3KaoLpONF+DN3giGuiE6pG3b4gb8r0ZEiiq7ylPEF84bDZSizYfKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PVa9uy1b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8JoYq9+L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Apr 2025 14:49:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745585392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/FyPt/SFa/8BOfuWyr6443EPo7xFnaGhBOqn6noZMkY=;
	b=PVa9uy1bAz6z0qOVXHPCIld1bhFHa0JPJvtSFdNFtYRnQF7qW9IvyIorWO/V5Pbd2ChE4R
	xXIx0Dvt4nTHruaoknSovQQB/2m27TI75zO50xoaXDIdz5MHSGXtvftJ1UIHcf4vKFjMRo
	y0Z/W9jCMCbU7DwvPi30tGInWx2/qmOiCPKSOt3psUI0GzLSVgs/7A+y2rAfq69jM6uVBp
	rFXLm/shKx5WmGbMpzuReBaExDrs6EvUlhcOcDWMbJfSzhec0fI2tmFuAyr6TFI2kGRSKR
	UGXiamPWvxhv9Wnwph7Ik/m5h45AD4NAWwEHzJytGB5dadre805Oe/EAi/4RPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745585392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/FyPt/SFa/8BOfuWyr6443EPo7xFnaGhBOqn6noZMkY=;
	b=8JoYq9+L1p49ccRTOGCL+U0nPSbGscT1EPrBszV8pWG9tRPe8UxcSNKoE1wD+q//mF2Lm9
	9bL2BaYLNGwykfDg==
From: Nam Cao <namcao@linutronix.de>
To: Kai Zhang <zhangkai@iscas.ac.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, stable@vger.kernel.org
Subject: Re: [linux-6.6.y bugreport] riscv: kprobe crash as some patchs lost
Message-ID: <20250425124950.FQzzDETT@linutronix.de>
References: <c7e463c0-8cad-4f4e-addd-195c06b7b6de@iscas.ac.cn>
 <2025042250-backlash-shifting-89cf@gregkh>
 <72896429-e966-4f7a-b2f2-ebc33368eb12@iscas.ac.cn>
 <2025042518-craftily-coronary-b63a@gregkh>
 <2095c40a-a5a8-417a-bd0b-47e782e9f42d@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2095c40a-a5a8-417a-bd0b-47e782e9f42d@iscas.ac.cn>

On Fri, Apr 25, 2025 at 08:09:21PM +0800, Kai Zhang wrote:
> Hi Nam,
> 
> I reported a riscv kprobe bug of linux-6.6.y. It seems that
> 03753bfacbc6(riscv: kprobes: Fix incorrect address calculation) should be
> reverted. There are a lot of changes of riscv kprobe in upstream. I'm not
> all in sure of my suggested fix. Will you kind to help?

Certainly.

> Thanks,
> laokz
> 
> On 4/25/2025 4:07 PM, Greg Kroah-Hartman wrote:
> > On Fri, Apr 25, 2025 at 04:03:41PM +0800, Kai Zhang wrote:
> > > On 4/22/2025 4:46 PM, Greg Kroah-Hartman wrote:
> > > > On Tue, Apr 22, 2025 at 10:58:42AM +0800, Kai Zhang wrote:
> > > > > In most recent linux-6.6.y tree,
> > > > > `arch/riscv/kernel/probes/kprobes.c::arch_prepare_ss_slot` still has the
> > > > > obsolete code:
> > > > > 
> > > > >       u32 insn = __BUG_INSN_32;
> > > > >       unsigned long offset = GET_INSN_LENGTH(p->opcode);
> > > > >       p->ainsn.api.restore = (unsigned long)p->addr + offset;
> > > > >       patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
> > > > >       patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, 1);
> > > > > 
> > > > > The last two 1s are wrong size of written instructions , which would lead to
> > > > > kernel crash, like `insmod kprobe_example.ko` gives:
> > > > > 
> > > > > [  509.812815][ T2734] kprobe_init: Planted kprobe at 00000000c5c46130
> > > > > [  509.837606][    C5] handler_pre: <kernel_clone> p->addr =
> > > > > 0x00000000c5c46130, pc = 0xffffffff80032ee2, status = 0x200000120
> > > > > [  509.839315][    C5] Oops - illegal instruction [#1]
> > > > > 
> > > > > 
> > > > > I've tried two patchs from torvalds tree and it didn't crash again:
> > > > > 
> > > > > 51781ce8f448 riscv: Pass patch_text() the length in bytes (rebased)
> > > > > 13134cc94914 riscv: kprobes: Fix incorrect address calculation

Please don't revert this patch. It fixes another issue.

You are correct that the sizes of the instructions are wrong. It can still
happen to work if only one instruction is patched.

This bug is not specific to v6.6. It is in mainline as well. Therefore fix
patch should be sent to mainline, and then backport to v6.6.

Can you please verify if the below patch fixes your crash?

Best regards,
Nam

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 4fbc70e823f0..dc431b965bc3 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -28,8 +28,8 @@ static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 
 	p->ainsn.api.restore = (unsigned long)p->addr + offset;
 
-	patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
-	patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, 1);
+	patch_text_nosync(p->ainsn.api.insn, &p->opcode, offset);
+	patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, sizeof(insn));
 }
 
 static void __kprobes arch_prepare_simulate(struct kprobe *p)

