Return-Path: <stable+bounces-59046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9836A92DC74
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 01:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E531F25E3F
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 23:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34EB14EC4A;
	Wed, 10 Jul 2024 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lW1IzOpI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4112BF23;
	Wed, 10 Jul 2024 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653383; cv=none; b=RXhMUhM2K/6Nc+/5dVeK1kq3L+HHAxukY8WKl4s+W77QUpIYEG26wzPypfjl7enihej4Gq7GvOvV4bnS5T3lS+JBA1/1+r/Wanl+Kc72ABV0YQrdV99RET1TIrVLy2CgQkvwkldmWx+zdplhmzyb4OP77uvgEh3bJ6XhE5ymX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653383; c=relaxed/simple;
	bh=fer+00iaGcBfnRBG7yRtqmNuSbkPeeQfXN4EbD/eWvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o57gnDesIqmELJQZnN79m8lVlE4mbqLmjzrJeHZRiXuPpwfJr2kV2xd19gf2EW6rXLxl8HlYwux4Oily3KRVO2eIfWbWYZDvpmbZfKoKJ0PYolx1fhZEEW3j7+hOmdxGComMKhNdXdbGEgcD42BBs3lpp0ut41dC/HQikpJOT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lW1IzOpI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720653382; x=1752189382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fer+00iaGcBfnRBG7yRtqmNuSbkPeeQfXN4EbD/eWvk=;
  b=lW1IzOpIZO7/7LhjXdqwHc6qayrLYFEfCI8Tp4h+ohM059bccsOvzdBM
   aMGpOHGNinI6gHITM6mcZg2NshhibwcZ8iOkZQ/SsuDclhr3p4AZe+nXl
   FM2RjtRy0wvC1C08gZoZZAx8z/Bz4deTTuZl3OYHkNatmL5spWfY0pykl
   vb0CKmQH8q/ppERaPdLUrjwleVUXpu+cBNx5nnyLwSjO27bpQbeYwuF4Y
   ZlXLzcySuhvuLn7Nyr3kxLGAYoTikwTnpxnVUOOblhdytK4SlGPnaSK6/
   NLaiv15wGGsVzrILA4K9TTw7VWv6n70Mh/l2ppyuYnSHvBkQ0I2zAkWZM
   Q==;
X-CSE-ConnectionGUID: NM0g50VXSmyQs2FcCEhJiA==
X-CSE-MsgGUID: UatasSfmQfaR3UH663DxRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18141153"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18141153"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 16:16:21 -0700
X-CSE-ConnectionGUID: ZJi+3G5qT+S7/VBH0Q/g5A==
X-CSE-MsgGUID: rHmOepUKSWGsFSH4Lkd/hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48336145"
Received: from kwangwoo-mobl1.gar.corp.intel.com (HELO desk) ([10.209.72.253])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 16:16:22 -0700
Date: Wed, 10 Jul 2024 16:16:09 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] x86/entry_32: Use stack segment selector for VERW
 operand
Message-ID: <20240710231609.rbxd7m5mjk53rthl@desk>
References: <20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com>
 <8551ef61-71fb-18f3-a8a8-6c7c3ed731e6@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8551ef61-71fb-18f3-a8a8-6c7c3ed731e6@gmail.com>

On Wed, Jul 10, 2024 at 11:50:50PM +0200, Uros Bizjak wrote:
> 
> 
> On 10. 07. 24 21:06, Pawan Gupta wrote:
> > Robert Gill reported below #GP when dosemu software was executing vm86()
> > system call:
> > 
> >    general protection fault: 0000 [#1] PREEMPT SMP
> >    CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
> >    Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
> >    EIP: restore_all_switch_stack+0xbe/0xcf
> >    EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> >    ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
> >    DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
> >    CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
> >    Call Trace:
> >     show_regs+0x70/0x78
> >     die_addr+0x29/0x70
> >     exc_general_protection+0x13c/0x348
> >     exc_bounds+0x98/0x98
> >     handle_exception+0x14d/0x14d
> >     exc_bounds+0x98/0x98
> >     restore_all_switch_stack+0xbe/0xcf
> >     exc_bounds+0x98/0x98
> >     restore_all_switch_stack+0xbe/0xcf
> > 
> > This only happens when VERW based mitigations like MDS/RFDS are enabled.
> > This is because segment registers with an arbitrary user value can result
> > in #GP when executing VERW. Intel SDM vol. 2C documents the following
> > behavior for VERW instruction:
> > 
> >    #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
> > 	   FS, or GS segment limit.
> > 
> > CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
> > space. Replace CLEAR_CPU_BUFFERS with a safer version that uses %ss to
> > refer VERW operand mds_verw_sel. This ensures VERW will not #GP for an
> > arbitrary user %ds. Also, in NMI return path, move VERW to after
> > RESTORE_ALL_NMI that touches GPRs.
> > 
> > For clarity, below are the locations where the new CLEAR_CPU_BUFFERS_SAFE
> > version is being used:
> > 
> > * entry_INT80_32(), entry_SYSENTER_32() and interrupts (via
> >    handle_exception_return) do:
> > 
> > restore_all_switch_stack:
> >    [...]
> >     mov    %esi,%esi
> >     verw   %ss:0xc0fc92c0  <-------------
> >     iret
> > 
> > * Opportunistic SYSEXIT:
> > 
> >     [...]
> >     verw   %ss:0xc0fc92c0  <-------------
> >     btrl   $0x9,(%esp)
> >     popf
> >     pop    %eax
> >     sti
> >     sysexit
> > 
> > *  nmi_return and nmi_from_espfix:
> >     mov    %esi,%esi
> >     verw   %ss:0xc0fc92c0  <-------------
> >     jmp     .Lirq_return
> > 
> > Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
> > Cc: stable@vger.kernel.org # 5.10+
> > Reported-by: Robert Gill <rtgill82@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
> > Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Suggested-by: Brian Gerst <brgerst@gmail.com> # Use %ss
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> > v4:
> > - Further simplify the patch by using %ss for all VERW calls in 32-bit mode (Brian).
> > - In NMI exit path move VERW after RESTORE_ALL_NMI that touches GPRs (Dave).
> > 
> > v3: https://lore.kernel.org/r/20240701-fix-dosemu-vm86-v3-1-b1969532c75a@linux.intel.com
> > - Simplify CLEAR_CPU_BUFFERS_SAFE by using %ss instead of %ds (Brian).
> > - Do verw before popf in SYSEXIT path (Jari).
> > 
> > v2: https://lore.kernel.org/r/20240627-fix-dosemu-vm86-v2-1-d5579f698e77@linux.intel.com
> > - Safe guard against any other system calls like vm86() that might change %ds (Dave).
> > 
> > v1: https://lore.kernel.org/r/20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com
> > ---
> > 
> > ---
> >   arch/x86/entry/entry_32.S | 18 +++++++++++++++---
> >   1 file changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> > index d3a814efbff6..d54f6002e5a0 100644
> > --- a/arch/x86/entry/entry_32.S
> > +++ b/arch/x86/entry/entry_32.S
> > @@ -253,6 +253,16 @@
> >   .Lend_\@:
> >   .endm
> > +/*
> > + * Safer version of CLEAR_CPU_BUFFERS that uses %ss to reference VERW operand
> > + * mds_verw_sel. This ensures VERW will not #GP for an arbitrary user %ds.
> > + */
> > +.macro CLEAR_CPU_BUFFERS_SAFE
> > +	ALTERNATIVE "jmp .Lskip_verw\@", "", X86_FEATURE_CLEAR_CPU_BUF
> > +	verw	%ss:_ASM_RIP(mds_verw_sel)
> > +.Lskip_verw\@:
> > +.endm
> 
> Why not simply:
> 
> .macro CLEAR_CPU_BUFFERS_SAFE
> 	ALTERNATIVE "", __stringify(verw %ss:_ASM_RIP(mds_verw_sel)),
> X86_FEATURE_CLEAR_CPU_BUF
> .endm

We can do it this way as well. But, there are stable kernels that don't
support relocations in ALTERNATIVEs. The way it is done in current patch
can be backported without worrying about which kernels support relocations.

