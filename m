Return-Path: <stable+bounces-77746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20695986A5D
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 03:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976F91F21842
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 01:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665CD157490;
	Thu, 26 Sep 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUqGxOpB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715BD139B;
	Thu, 26 Sep 2024 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727312691; cv=none; b=mOB//SAoj1XgvE+ADaRfMo7u0bXl6X3pImu4ZuGd7ml86C3hn/TxGXy9huWj619hPVS2FmLb0ZHiQw2ff/UgeiNBI7RVUHi2pmwl95mRLeqE056O3mB8VfJKFKsaboIYZZsBMTiWxZA5m3RzJPHkZ9Q/b+IfuCyqX0w2JQGV/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727312691; c=relaxed/simple;
	bh=QvlnnNUVYxnwOzsWATvhGRZbzYi5uagbR8NvXqupzlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8MFuYGRe1O5Dlm0AvsYgwFJRNolQkOl4/IdNDj8pxxHINVbPhNNeR1l0pyAbL6rLG2Kce+K7HWzyq7cTDGZnSFdxMJXJgE1xx0L3lXl3gq4HaGB22YtVDoPQGl9syRXXw7zLjZTt0C5xOIvsyzVdqEqZME46Xcqn5lbRyxMY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUqGxOpB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727312690; x=1758848690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QvlnnNUVYxnwOzsWATvhGRZbzYi5uagbR8NvXqupzlg=;
  b=KUqGxOpBe8yYq28AynK4ks+UkIjDRur489NY/XDD/XcRxQE9wNsQzR0I
   equtXXV6LHpVjKdf1ztwdHn8GLIwB/bxbD4jezVAluD3u0Anzrz1ko1Nj
   kfXgViqCVj22wEnKqRW77RRZPCeE8d4qTcXum5OCmdjJyzdYOYotqxkhT
   4TxUBTf1n6xLGflP86FC0JW/BxcC66DLXszvHsJzb4RKojKB0TpF8G61O
   cBv5Qnrz9umq93WpOOFwlJaQ4vxNygkNZdASyq+ru1jJF1/0JnzXpjgII
   tqXtm3Y0L91ALuBo9kXGrAHF/+EpuQ8uUtcJ3/ZLodVATsnPfWqg7hK+A
   g==;
X-CSE-ConnectionGUID: PPfHcGvFSxam1+lTEB0f6g==
X-CSE-MsgGUID: 9z6gcjKnTMqpA85QW/rOzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="48921163"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="48921163"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 18:04:48 -0700
X-CSE-ConnectionGUID: E+yqVkt4SDGhw4Bu6ten7A==
X-CSE-MsgGUID: tksoldQWT+SDIQabVb+4HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="72752985"
Received: from fecarpio-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.229])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 18:04:47 -0700
Date: Wed, 25 Sep 2024 18:04:40 -0700
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
Message-ID: <20240926010440.oz42o7onxmmkejvn@desk>
References: <20240925-fix-dosemu-vm86-v7-0-1de0daca2d42@linux.intel.com>
 <20240925-fix-dosemu-vm86-v7-3-1de0daca2d42@linux.intel.com>
 <5703f2d8-7ca0-4f01-a954-c0eb1de930b4@citrix.com>
 <20240925234616.2ublphj3vbluawb3@desk>
 <20240926001729.2unwdxtcnnkf3k3t@desk>
 <4ca44b13-2442-4d59-8716-df43c3692a8a@citrix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ca44b13-2442-4d59-8716-df43c3692a8a@citrix.com>

On Thu, Sep 26, 2024 at 01:32:19AM +0100, Andrew Cooper wrote:
> On 26/09/2024 1:17 am, Pawan Gupta wrote:
> > On Wed, Sep 25, 2024 at 04:46:23PM -0700, Pawan Gupta wrote:
> >> On Thu, Sep 26, 2024 at 12:29:00AM +0100, Andrew Cooper wrote:
> >>> On 25/09/2024 11:25 pm, Pawan Gupta wrote:
> >>>> Robert Gill reported below #GP in 32-bit mode when dosemu software was
> >>>> executing vm86() system call:
> >>>>
> >>>>   general protection fault: 0000 [#1] PREEMPT SMP
> >>>>   CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
> >>>>   Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
> >>>>   EIP: restore_all_switch_stack+0xbe/0xcf
> >>>>   EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> >>>>   ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
> >>>>   DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
> >>>>   CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
> >>>>   Call Trace:
> >>>>    show_regs+0x70/0x78
> >>>>    die_addr+0x29/0x70
> >>>>    exc_general_protection+0x13c/0x348
> >>>>    exc_bounds+0x98/0x98
> >>>>    handle_exception+0x14d/0x14d
> >>>>    exc_bounds+0x98/0x98
> >>>>    restore_all_switch_stack+0xbe/0xcf
> >>>>    exc_bounds+0x98/0x98
> >>>>    restore_all_switch_stack+0xbe/0xcf
> >>>>
> >>>> This only happens in 32-bit mode when VERW based mitigations like MDS/RFDS
> >>>> are enabled. This is because segment registers with an arbitrary user value
> >>>> can result in #GP when executing VERW. Intel SDM vol. 2C documents the
> >>>> following behavior for VERW instruction:
> >>>>
> >>>>   #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
> >>>> 	   FS, or GS segment limit.
> >>>>
> >>>> CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
> >>>> space. Use %cs selector to reference VERW operand. This ensures VERW will
> >>>> not #GP for an arbitrary user %ds.
> >>>>
> >>>> Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
> >>>> Cc: stable@vger.kernel.org # 5.10+
> >>>> Reported-by: Robert Gill <rtgill82@gmail.com>
> >>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
> >>>> Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
> >>>> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> >>>> Suggested-by: Brian Gerst <brgerst@gmail.com>
> >>>> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> >>>> ---
> >>>>  arch/x86/include/asm/nospec-branch.h | 6 ++++--
> >>>>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> >>>> index ff5f1ecc7d1e..e18a6aaf414c 100644
> >>>> --- a/arch/x86/include/asm/nospec-branch.h
> >>>> +++ b/arch/x86/include/asm/nospec-branch.h
> >>>> @@ -318,12 +318,14 @@
> >>>>  /*
> >>>>   * Macro to execute VERW instruction that mitigate transient data sampling
> >>>>   * attacks such as MDS. On affected systems a microcode update overloaded VERW
> >>>> - * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
> >>>> + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF. Using %cs
> >>>> + * to reference VERW operand avoids a #GP fault for an arbitrary user %ds in
> >>>> + * 32-bit mode.
> >>>>   *
> >>>>   * Note: Only the memory operand variant of VERW clears the CPU buffers.
> >>>>   */
> >>>>  .macro CLEAR_CPU_BUFFERS
> >>>> -	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> >>>> +	ALTERNATIVE "", __stringify(verw %cs:_ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> >>>>  .endm
> >>> People ought rightly to double-take at this using %cs and not %ss. 
> >>> There is a good reason, but it needs describing explicitly.  May I
> >>> suggest the following:
> >>>
> >>> *...
> >>> * In 32bit mode, the memory operand must be a %cs reference.  The data
> >>> segments may not be usable (vm86 mode), and the stack segment may not be
> >>> flat (espfix32).
> >>> *...
> >> Thanks for the suggestion. I will include this.
> >>
> >>>  .macro CLEAR_CPU_BUFFERS
> >>> #ifdef __x86_64__
> >>>     ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
> >>> #else
> >>>     ALTERNATIVE "", "verw %cs:mds_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
> >>> #endif
> >>>  .endm
> >>>
> >>> This also lets you drop _ASM_RIP().  It's a cute idea, but is more
> >>> confusion than it's worth, because there's no such thing in 32bit mode.
> >>>
> >>> "%cs:_ASM_RIP(mds_verw_sel)" reads as if it does nothing, because it
> >>> really doesn't in 64bit mode.
> >> Right, will drop _ASM_RIP() in 32-bit mode and %cs in 64-bit mode.
> > Its probably too soon for next version, pasting the patch here:
> >
> > ---8<---
> > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > index e18a6aaf414c..4228a1fd2c2e 100644
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -318,14 +318,21 @@
> >  /*
> >   * Macro to execute VERW instruction that mitigate transient data sampling
> >   * attacks such as MDS. On affected systems a microcode update overloaded VERW
> > - * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF. Using %cs
> > - * to reference VERW operand avoids a #GP fault for an arbitrary user %ds in
> > - * 32-bit mode.
> > + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
> >   *
> >   * Note: Only the memory operand variant of VERW clears the CPU buffers.
> >   */
> >  .macro CLEAR_CPU_BUFFERS
> > -	ALTERNATIVE "", __stringify(verw %cs:_ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> > +#ifdef CONFIG_X86_64
> > +	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> > +#else
> > +	/*
> > +	 * In 32bit mode, the memory operand must be a %cs reference. The data
> > +	 * segments may not be usable (vm86 mode), and the stack segment may not
> > +	 * be flat (ESPFIX32).
> > +	 */
> 
> I was intending for this to replace the "Using %cs" sentence, as a new
> paragraph in that main comment block.

The reason I added the comment to 32-bit leg is because most readers will
not care about 32-bit mode. The comment will mostly be a distraction for
majority. People who care about 32-bit mode will read the comment in 32-bit
leg. I can move the comment to main block if you still want.

