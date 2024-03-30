Return-Path: <stable+bounces-33844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDA4892C4F
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 19:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8241F22C87
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 18:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E253BBDB;
	Sat, 30 Mar 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oVqBydrj"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CB22AF13
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711822234; cv=none; b=U7PuI0F2LDoH1cEm20VhYxWK8HcxF1+KLJnH6BUkOkRqrqdF0MSLjqOan3X93++zH9FkZBbR3XZ4qgFBvp+ZK66d81poQmufUq9J7BiKicyAv2mGCOeEr1yGULeq8/fOITbLTLlVHWdDlQ+6Krf+4VGc4Z9AfEpw4hasOVNtV3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711822234; c=relaxed/simple;
	bh=dS+V5WBjK+sCCwX4j0eFy32Wbymu8/uzasCQWpiz6OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcU8x9vgl1Kq83Aadi2CQJclv7ewl6iGjlXjvg517DM2To2X4Sqt+HrEENC6G4Sl+bCHA39ZEYVtDfe7/NZElr3xLJbz6sbl/znPheuE9OgkENG4MEl0PJAaLXyk6qreGs3qsqZj29cPKZbMxj/KmPRDLhBGZr8PQZZKCOKk3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oVqBydrj; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nbS0cWsrZzwZS68L2ctJXK/10H73/rI+D5l/NRdZIWw=; b=oVqBydrjQA+NWCuJug3mYcrx0Z
	3PnU+8oRR1YbjKXclJ76IsWwUAZZ6tVjXEwXOs4+aQIQaPUcOxdql8pI2FQRCccok+mf/tZNKg2MG
	sdWT+caLfjq3VHpPAYWM7O6q4YqTaH+ba3Oa8df7zpEXoiXZUGfcrSwCsnWNHK8L2Rn97eZHAwnKG
	VjDyfFDnE63wfEHy8fnreYGuFRJq/jnFGYjIsFuW7m7N0cGEnWSmZwWzAXYfhGaCDtfD5M3BjWhex
	iLVxt32IV+sl4Z9v07rDCwhWIcKiltiAH/+c2hUZHCw3xIUEXTmO8tmuqgDY3in+xuyK9TdPSeTn3
	C9sin56A==;
Received: from [179.93.174.199] (helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rqd9k-00H2UH-Ue; Sat, 30 Mar 2024 19:10:17 +0100
Date: Sat, 30 Mar 2024 15:10:12 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, kernel-dev@igalia.com
Subject: Re: [PATCH 5.15 v2 0/3] Support static calls with LLVM-built kernels
Message-ID: <ZghVhD7pYQKDmXes@quatroqueijos.cascardo.eti.br>
References: <20240318133907.2108491-1-cascardo@igalia.com>
 <2024032948-oversight-spoiler-b1e6@gregkh>
 <Zgfh8t49ySdA6dTW@quatroqueijos.cascardo.eti.br>
 <2024033003-unplug-anthem-a453@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024033003-unplug-anthem-a453@gregkh>

On Sat, Mar 30, 2024 at 11:11:14AM +0100, Greg KH wrote:
> On Sat, Mar 30, 2024 at 06:57:06AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > On Fri, Mar 29, 2024 at 01:50:11PM +0100, Greg KH wrote:
> > > On Mon, Mar 18, 2024 at 10:39:04AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > > > Otherwise, we see warnings like this:
> > > > 
> > > > [    0.000000][    T0] ------------[ cut here ]------------
> > > > [    0.000000][    T0] unexpected static_call insn opcode 0xf at kvm_vcpu_reload_apic_access_page+0x17/0x30
> > > > [    0.000000][    T0] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/static_call.c:88 __static_call_validate+0x68/0x70
> > > > [    0.000000][    T0] Modules linked in:
> > > > [    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.151-00083-gf200c7260296 #68 fe3cb25cf78cb710722bb5acd1cadddd35172924
> > > > [    0.000000][    T0] RIP: 0010:__static_call_validate+0x68/0x70
> > > > [    0.000000][    T0] Code: 0f b6 4a 04 81 f1 c0 00 00 00 09 c1 74 cc 80 3d be 2c 02 02 00 75 c3 c6 05 b5 2c 02 02 01 48 c7 c7 38 4f c3 82 e8 e8 c8 09 00 <0f> 0b c3 00 00 cc cc 00 53 48 89 fb 48 63 15 31 71 06 02
> > > > e8 b0 b8
> > > > [    0.000000][    T0] RSP: 0000:ffffffff82e03e70 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
> > > > [    0.000000][    T0] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
> > > > [    0.000000][    T0] RDX: 0000000000000000 RSI: ffffffff82e03ce0 RDI: 0000000000000001
> > > > [    0.000000][    T0] RBP: 0000000000000001 R08: 00000000ffffffff R09: ffffffff82eaab70
> > > > [    0.000000][    T0] R10: ffffffff82e2e900 R11: 205d305420202020 R12: ffffffff82e51960
> > > > [    0.000000][    T0] R13: ffffffff81038987 R14: ffffffff81038987 R15: 0000000000000001
> > > > [    0.000000][    T0] FS:  0000000000000000(0000) GS:ffffffff83726000(0000) knlGS:0000000000000000
> > > > [    0.000000][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [    0.000000][    T0] CR2: ffff888000014be8 CR3: 00000000037b2000 CR4: 00000000000000a0
> > > > [    0.000000][    T0] Call Trace:
> > > > [    0.000000][    T0]  <TASK>
> > > > [    0.000000][    T0]  ? __warn+0x75/0xe0
> > > > [    0.000000][    T0]  ? report_bug+0x81/0xe0
> > > > [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> > > > [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> > > > [    0.000000][    T0]  ? early_fixup_exception+0x44/0xa0
> > > > [    0.000000][    T0]  ? early_idt_handler_common+0x2f/0x40
> > > > [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> > > > [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> > > > [    0.000000][    T0]  ? __static_call_validate+0x68/0x70
> > > > [    0.000000][    T0]  ? arch_static_call_transform+0x5c/0x90
> > > > [    0.000000][    T0]  ? __static_call_init+0x1ec/0x230
> > > > [    0.000000][    T0]  ? static_call_init+0x32/0x70
> > > > [    0.000000][    T0]  ? setup_arch+0x36/0x4f0
> > > > [    0.000000][    T0]  ? start_kernel+0x67/0x400
> > > > [    0.000000][    T0]  ? secondary_startup_64_no_verify+0xb1/0xbb
> > > > [    0.000000][    T0]  </TASK>
> > > > [    0.000000][    T0] ---[ end trace 8c8589c01f370686 ]---
> > > > 
> > > > 
> > > > 
> > > > Peter Zijlstra (3):
> > > >   x86/alternatives: Introduce int3_emulate_jcc()
> > > >   x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
> > > >   x86/static_call: Add support for Jcc tail-calls
> > > > 
> > > >  arch/x86/include/asm/text-patching.h | 31 +++++++++++++++
> > > >  arch/x86/kernel/alternative.c        | 56 +++++++++++++++++++++++-----
> > > >  arch/x86/kernel/kprobes/core.c       | 38 ++++---------------
> > > >  arch/x86/kernel/static_call.c        | 49 ++++++++++++++++++++++--
> > > >  4 files changed, 132 insertions(+), 42 deletions(-)
> > > 
> > > Why is there a v2 series here?  Are the ones I just took not correct?
> > > 
> > > confused,
> > > 
> > > greg k-h
> > 
> > Because Sasha questioned the presence of the first 2 patches in the series
> > while they were not backported to 6.1. Then, I looked at the 6.1 backport for
> > reference and determined they were not really necessary if I picked the same
> > changes that the 6.1 backport applied.
> 
> So is what I queued up correct or not?
> 
> still confused,
> 
> greg k-h
> 

Either version are good. I understand there is a preference for v2 since it
doesn't include a change that was not applied in a later series, 6.1.y.

Cascardo.

