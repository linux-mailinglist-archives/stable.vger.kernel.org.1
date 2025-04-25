Return-Path: <stable+bounces-136705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FD8A9C9B5
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 14:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37A21889CE4
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 12:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40165248862;
	Fri, 25 Apr 2025 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uOM/XCER";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PaD9CuCz"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E2C24C084
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585958; cv=none; b=A2UiVTGj3TBQqscN5+TaAgWxN589QLm0W3sUGIyyaT1pvOek5B4atG+uNBCcy7A5v9Og74/cIAEB9SIbmz/T0xq4bJilWBWbGR6LanXgxeTlTU60bhd0gpAh3sneCEazdlnStXGf+w3TH6S4HX4pdve528sWb8zvSKUJ15o4q9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585958; c=relaxed/simple;
	bh=H5QgxTGDcp3bV6rlCyNMUIg+gRQB7kEG0NCHTr+llpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuA07tOU6mpoopR2E6n9xueZrfzU4hDnaWmnjzSU232pzrdJ0fXrZE33gCRBJ1hl9S6sGhcVrOzJrw5obF1C8vWbuoVUdykXPLw5GKM5n9+eQANsiULzim9G/KUD5+T+wOWUZ2pMJjfn0NPumqy+nGQVFRJru841XfeDmZGjr9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uOM/XCER; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PaD9CuCz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Apr 2025 14:59:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745585953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOPegVJfyq3loWg7ADQIwH6ZTfZTDVoDCfKpvEnt5x0=;
	b=uOM/XCERZerCwrEkLyLHDDnR0/9KvmLsoYw+B3omAdC4thLxaNOZUnNr2rhXST3SEBOL5L
	iC+Hh59nZb0SZIRZ8d5sEjmFMPfsKbMZbPhU+bJKZ7s/AcH8B/7xEbUUciK+7soF3+ljPX
	r9+vuCrZyRBWCCYCHdW9QR/paJpJ58zzjJ0fdMt09Aews7Qy5HPua7ZiK0vYoGEfUCfyR/
	s9MXVa2WKjir+uAigJ1LyVAcjzFM6w63LVqU52frjDkuw4xyDz9bTgzghEBEtLcyGHrsGQ
	QGX+Vz19n+4Nyv9ynG9Yk3Hfpd3gJfeHvFxVeNh3cyIPBgQ5Cc2537RUCblIZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745585953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOPegVJfyq3loWg7ADQIwH6ZTfZTDVoDCfKpvEnt5x0=;
	b=PaD9CuCzZzNitw/LxGRwq5iWq/kLQ0Y9NVgOJFuq0Chav2F4GMYCj1BkX76fmCr4ht4cI9
	2i9FgUKpHLiliyDw==
From: Nam Cao <namcao@linutronix.de>
To: Kai Zhang <zhangkai@iscas.ac.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, stable@vger.kernel.org
Subject: Re: [linux-6.6.y bugreport] riscv: kprobe crash as some patchs lost
Message-ID: <20250425125912.57u73cuH@linutronix.de>
References: <c7e463c0-8cad-4f4e-addd-195c06b7b6de@iscas.ac.cn>
 <2025042250-backlash-shifting-89cf@gregkh>
 <72896429-e966-4f7a-b2f2-ebc33368eb12@iscas.ac.cn>
 <2025042518-craftily-coronary-b63a@gregkh>
 <2095c40a-a5a8-417a-bd0b-47e782e9f42d@iscas.ac.cn>
 <20250425124950.FQzzDETT@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425124950.FQzzDETT@linutronix.de>

On Fri, Apr 25, 2025 at 02:49:52PM +0200, Nam Cao wrote:
> On Fri, Apr 25, 2025 at 08:09:21PM +0800, Kai Zhang wrote:
> > On 4/25/2025 4:07 PM, Greg Kroah-Hartman wrote:
> > > On Fri, Apr 25, 2025 at 04:03:41PM +0800, Kai Zhang wrote:
> > > > On 4/22/2025 4:46 PM, Greg Kroah-Hartman wrote:
> > > > > On Tue, Apr 22, 2025 at 10:58:42AM +0800, Kai Zhang wrote:
> > > > > > In most recent linux-6.6.y tree,
> > > > > > `arch/riscv/kernel/probes/kprobes.c::arch_prepare_ss_slot` still has the
> > > > > > obsolete code:
> > > > > > 
> > > > > >       u32 insn = __BUG_INSN_32;
> > > > > >       unsigned long offset = GET_INSN_LENGTH(p->opcode);
> > > > > >       p->ainsn.api.restore = (unsigned long)p->addr + offset;
> > > > > >       patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
> > > > > >       patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, 1);
> > > > > > 
> > > > > > The last two 1s are wrong size of written instructions , which would lead to
> > > > > > kernel crash, like `insmod kprobe_example.ko` gives:
> > > > > > 
> > > > > > [  509.812815][ T2734] kprobe_init: Planted kprobe at 00000000c5c46130
> > > > > > [  509.837606][    C5] handler_pre: <kernel_clone> p->addr =
> > > > > > 0x00000000c5c46130, pc = 0xffffffff80032ee2, status = 0x200000120
> > > > > > [  509.839315][    C5] Oops - illegal instruction [#1]
> > > > > > 
> > > > > > 
> > > > > > I've tried two patchs from torvalds tree and it didn't crash again:
> > > > > > 
> > > > > > 51781ce8f448 riscv: Pass patch_text() the length in bytes (rebased)
> > > > > > 13134cc94914 riscv: kprobes: Fix incorrect address calculation
> 
> Please don't revert this patch. It fixes another issue.
> 
> You are correct that the sizes of the instructions are wrong. It can still
> happen to work if only one instruction is patched.
> 
> This bug is not specific to v6.6. It is in mainline as well. Therefore fix
> patch should be sent to mainline, and then backport to v6.6.

Sorry, I was confused. This is not in mainline. It has already been fixed
by 51781ce8f448 ("riscv: Pass patch_text() the length in bytes")

But I wouldn't backport that patch, it is bigger than necessary. The patch
I sent in the previous email should be enough.

Nam

