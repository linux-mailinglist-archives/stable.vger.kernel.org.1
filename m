Return-Path: <stable+bounces-33820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BEF892A22
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 10:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A6C1F2229F
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45611EF1E;
	Sat, 30 Mar 2024 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Kl6fOLmB"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722981EB2B
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792641; cv=none; b=trBxCKYkimL/+dhQvjutNIDs/m5JpGqddI/uV3cGzrVH/Rg6VikBNHe3X3aGpGcnfVceTyUxf4LK88z0A6EWE9I5zCVJLYHqXnlTgKhPOEoHWPz2ngh9eaKI2mf7uYXJBDnDYpzILvixUlteVFebn2wPs1HnSxhJDwv5/pJmYLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792641; c=relaxed/simple;
	bh=3uzMbcSUMIESFWFp1HKWmJirgjBnLjsYpbc07QGAb6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ87qZGgwkIwG00yqbTRRy9CXD8by4iVz1DfZB+d+daSVJLPtKMJevMuxiP7y0DHOu2hB0q/rVdbJIabHVWuOUpOiLQZkSOPkkQ46X3bnkpy0yZ6sapdapHyo/QztCsHjw+S3RK4jwMIUnrLOC/2exud4RD00agXrYUAg9iem/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Kl6fOLmB; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DAd+OjUdUH2DVvl7zExkVVD/KNpq2g52xOWX7VjTybA=; b=Kl6fOLmB90TF07mo2TfVzc8W9U
	b52/9ieQQyx2ej6+3XbIKMsLRr4eUgtJi7Vs+cU/QH3CQtv0Nwl3ylWXl9OIAbkvA7xgF3l6Z7L8v
	RbrpOa4Fq4zw5Voo+yGn0BxgO2OeJV8PQEqnJMXxPMVxjwRA/Jj3Ywgenn1XuPjlcL/BFk7PC452i
	PJbJez4sRTDHs7nMj476Wk1l0d0U+lIB7/8zuCCegBLrWUJTbPviWsu/15CfK6svMfsyczBsNxJsX
	9x0VVqkCtJozRPHvDtsfe9kQWrs4bOjy3dqNUhbpYonwwH0SlB4cvayBgFhx6obhOPMh1hN8KLc5f
	fTSevJdQ==;
Received: from [179.93.174.199] (helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rqVSa-00GwH2-S8; Sat, 30 Mar 2024 10:57:13 +0100
Date: Sat, 30 Mar 2024 06:57:06 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, kernel-dev@igalia.com
Subject: Re: [PATCH 5.15 v2 0/3] Support static calls with LLVM-built kernels
Message-ID: <Zgfh8t49ySdA6dTW@quatroqueijos.cascardo.eti.br>
References: <20240318133907.2108491-1-cascardo@igalia.com>
 <2024032948-oversight-spoiler-b1e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024032948-oversight-spoiler-b1e6@gregkh>

On Fri, Mar 29, 2024 at 01:50:11PM +0100, Greg KH wrote:
> On Mon, Mar 18, 2024 at 10:39:04AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > Otherwise, we see warnings like this:
> > 
> > [    0.000000][    T0] ------------[ cut here ]------------
> > [    0.000000][    T0] unexpected static_call insn opcode 0xf at kvm_vcpu_reload_apic_access_page+0x17/0x30
> > [    0.000000][    T0] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/static_call.c:88 __static_call_validate+0x68/0x70
> > [    0.000000][    T0] Modules linked in:
> > [    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.151-00083-gf200c7260296 #68 fe3cb25cf78cb710722bb5acd1cadddd35172924
> > [    0.000000][    T0] RIP: 0010:__static_call_validate+0x68/0x70
> > [    0.000000][    T0] Code: 0f b6 4a 04 81 f1 c0 00 00 00 09 c1 74 cc 80 3d be 2c 02 02 00 75 c3 c6 05 b5 2c 02 02 01 48 c7 c7 38 4f c3 82 e8 e8 c8 09 00 <0f> 0b c3 00 00 cc cc 00 53 48 89 fb 48 63 15 31 71 06 02
> > e8 b0 b8
> > [    0.000000][    T0] RSP: 0000:ffffffff82e03e70 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
> > [    0.000000][    T0] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
> > [    0.000000][    T0] RDX: 0000000000000000 RSI: ffffffff82e03ce0 RDI: 0000000000000001
> > [    0.000000][    T0] RBP: 0000000000000001 R08: 00000000ffffffff R09: ffffffff82eaab70
> > [    0.000000][    T0] R10: ffffffff82e2e900 R11: 205d305420202020 R12: ffffffff82e51960
> > [    0.000000][    T0] R13: ffffffff81038987 R14: ffffffff81038987 R15: 0000000000000001
> > [    0.000000][    T0] FS:  0000000000000000(0000) GS:ffffffff83726000(0000) knlGS:0000000000000000
> > [    0.000000][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.000000][    T0] CR2: ffff888000014be8 CR3: 00000000037b2000 CR4: 00000000000000a0
> > [    0.000000][    T0] Call Trace:
> > [    0.000000][    T0]  <TASK>
> > [    0.000000][    T0]  ? __warn+0x75/0xe0
> > [    0.000000][    T0]  ? report_bug+0x81/0xe0
> > [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> > [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> > [    0.000000][    T0]  ? early_fixup_exception+0x44/0xa0
> > [    0.000000][    T0]  ? early_idt_handler_common+0x2f/0x40
> > [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> > [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> > [    0.000000][    T0]  ? __static_call_validate+0x68/0x70
> > [    0.000000][    T0]  ? arch_static_call_transform+0x5c/0x90
> > [    0.000000][    T0]  ? __static_call_init+0x1ec/0x230
> > [    0.000000][    T0]  ? static_call_init+0x32/0x70
> > [    0.000000][    T0]  ? setup_arch+0x36/0x4f0
> > [    0.000000][    T0]  ? start_kernel+0x67/0x400
> > [    0.000000][    T0]  ? secondary_startup_64_no_verify+0xb1/0xbb
> > [    0.000000][    T0]  </TASK>
> > [    0.000000][    T0] ---[ end trace 8c8589c01f370686 ]---
> > 
> > 
> > 
> > Peter Zijlstra (3):
> >   x86/alternatives: Introduce int3_emulate_jcc()
> >   x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
> >   x86/static_call: Add support for Jcc tail-calls
> > 
> >  arch/x86/include/asm/text-patching.h | 31 +++++++++++++++
> >  arch/x86/kernel/alternative.c        | 56 +++++++++++++++++++++++-----
> >  arch/x86/kernel/kprobes/core.c       | 38 ++++---------------
> >  arch/x86/kernel/static_call.c        | 49 ++++++++++++++++++++++--
> >  4 files changed, 132 insertions(+), 42 deletions(-)
> 
> Why is there a v2 series here?  Are the ones I just took not correct?
> 
> confused,
> 
> greg k-h

Because Sasha questioned the presence of the first 2 patches in the series
while they were not backported to 6.1. Then, I looked at the 6.1 backport for
reference and determined they were not really necessary if I picked the same
changes that the 6.1 backport applied.

Thanks.
Cascardo.

