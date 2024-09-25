Return-Path: <stable+bounces-77739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBCA9869EA
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 01:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A72E281FE7
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 23:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1061A3A80;
	Wed, 25 Sep 2024 23:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wb4CJHyJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA84A00;
	Wed, 25 Sep 2024 23:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307986; cv=none; b=HyAfmu23IlwjJ15GJ6A/Vb2OZV4+VWddaJmoi3t1DiBXYqaU5u+B+3VsCbLW3zYV3SlcFGl3GRRoZ5oXu4bel7m61XxWT9Y5EkYIZJ40wMAtZsR7fKxM57mkmPTEdzdePPcjSAzoagAkW5tu5ZL2XfX8r90fdSrzykuyM7GzkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307986; c=relaxed/simple;
	bh=kRJUa6JzNqkOy3Yp5wDfA42w2JFJa+Z824N4jsJX2vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osyeJXTR4SpQWpC8YdQxICHHHO+yIIGkO7Qhd7fiJvLeLHTCSeRfEcAIkEzLOHbaVohGSdWj83JYpiVJ/vq5YEbjy84PzNFN1LeFCeAtjh/XhoUxTXbkf7Mki3R7nzT6r030do6DqP2RMYcyxWvSvCGl7MpsVgEOa1HOALKhXg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wb4CJHyJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727307984; x=1758843984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kRJUa6JzNqkOy3Yp5wDfA42w2JFJa+Z824N4jsJX2vo=;
  b=Wb4CJHyJl33kmbb68EPPJZD4WASEFwx9kNTLfr96Sa27ywWbWVJmjcGu
   8X5jK41NSLN/mpFXwrJAolFxYvt8o7QF6if/7rRYHacDxmO3KHqsJjwZa
   HYEfANyZcr4KJjcmNQdpLIjF1ix5HTcljozuSjQCPY4XOB0XifOmGWV0B
   WQTInYdYFPIPoTCRIZS8PzuJM/OgrFjLoZ+BzLkSid22pTJqpSdA4nO0B
   tKTMh+g7R3gpMewlpwF5+4L2WxevBtme2O0+Bc7LSF6KZTSuYJnqllvxN
   7I1cH/AnI4pZmAyW2UA4qsyKHpCwAJP3iasZtBbwgZpjD/b+1EMQACGwF
   Q==;
X-CSE-ConnectionGUID: GsTYZ3vpSdiRYmr+RmT3RQ==
X-CSE-MsgGUID: vrDt7b9JSLaL2mD7gTmClA==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="43902658"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="43902658"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 16:46:23 -0700
X-CSE-ConnectionGUID: KSZbMsWbRvya90BG3MH0Dw==
X-CSE-MsgGUID: N9NdVQuORnSp47XdMMGZvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="72075269"
Received: from fecarpio-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.229])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 16:46:23 -0700
Date: Wed, 25 Sep 2024 16:46:16 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v7 3/3] x86/bugs: Use code segment selector for VERW
 operand
Message-ID: <20240925234616.2ublphj3vbluawb3@desk>
References: <20240925-fix-dosemu-vm86-v7-0-1de0daca2d42@linux.intel.com>
 <20240925-fix-dosemu-vm86-v7-3-1de0daca2d42@linux.intel.com>
 <5703f2d8-7ca0-4f01-a954-c0eb1de930b4@citrix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5703f2d8-7ca0-4f01-a954-c0eb1de930b4@citrix.com>

On Thu, Sep 26, 2024 at 12:29:00AM +0100, Andrew Cooper wrote:
> On 25/09/2024 11:25 pm, Pawan Gupta wrote:
> > Robert Gill reported below #GP in 32-bit mode when dosemu software was
> > executing vm86() system call:
> >
> >   general protection fault: 0000 [#1] PREEMPT SMP
> >   CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
> >   Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
> >   EIP: restore_all_switch_stack+0xbe/0xcf
> >   EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> >   ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
> >   DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
> >   CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
> >   Call Trace:
> >    show_regs+0x70/0x78
> >    die_addr+0x29/0x70
> >    exc_general_protection+0x13c/0x348
> >    exc_bounds+0x98/0x98
> >    handle_exception+0x14d/0x14d
> >    exc_bounds+0x98/0x98
> >    restore_all_switch_stack+0xbe/0xcf
> >    exc_bounds+0x98/0x98
> >    restore_all_switch_stack+0xbe/0xcf
> >
> > This only happens in 32-bit mode when VERW based mitigations like MDS/RFDS
> > are enabled. This is because segment registers with an arbitrary user value
> > can result in #GP when executing VERW. Intel SDM vol. 2C documents the
> > following behavior for VERW instruction:
> >
> >   #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
> > 	   FS, or GS segment limit.
> >
> > CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
> > space. Use %cs selector to reference VERW operand. This ensures VERW will
> > not #GP for an arbitrary user %ds.
> >
> > Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
> > Cc: stable@vger.kernel.org # 5.10+
> > Reported-by: Robert Gill <rtgill82@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
> > Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Suggested-by: Brian Gerst <brgerst@gmail.com>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> >  arch/x86/include/asm/nospec-branch.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > index ff5f1ecc7d1e..e18a6aaf414c 100644
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -318,12 +318,14 @@
> >  /*
> >   * Macro to execute VERW instruction that mitigate transient data sampling
> >   * attacks such as MDS. On affected systems a microcode update overloaded VERW
> > - * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
> > + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF. Using %cs
> > + * to reference VERW operand avoids a #GP fault for an arbitrary user %ds in
> > + * 32-bit mode.
> >   *
> >   * Note: Only the memory operand variant of VERW clears the CPU buffers.
> >   */
> >  .macro CLEAR_CPU_BUFFERS
> > -	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> > +	ALTERNATIVE "", __stringify(verw %cs:_ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> >  .endm
> 
> People ought rightly to double-take at this using %cs and not %ss. 
> There is a good reason, but it needs describing explicitly.  May I
> suggest the following:
> 
> *...
> * In 32bit mode, the memory operand must be a %cs reference.  The data
> segments may not be usable (vm86 mode), and the stack segment may not be
> flat (espfix32).
> *...

Thanks for the suggestion. I will include this.

>  .macro CLEAR_CPU_BUFFERS
> #ifdef __x86_64__
>     ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
> #else
>     ALTERNATIVE "", "verw %cs:mds_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
> #endif
>  .endm
> 
> This also lets you drop _ASM_RIP().  It's a cute idea, but is more
> confusion than it's worth, because there's no such thing in 32bit mode.
> 
> "%cs:_ASM_RIP(mds_verw_sel)" reads as if it does nothing, because it
> really doesn't in 64bit mode.

Right, will drop _ASM_RIP() in 32-bit mode and %cs in 64-bit mode.

