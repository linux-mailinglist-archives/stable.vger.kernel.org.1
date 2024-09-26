Return-Path: <stable+bounces-77805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF29987757
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 18:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70AE81C22846
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B6B15B118;
	Thu, 26 Sep 2024 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWra4QLk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E7515A4B0;
	Thu, 26 Sep 2024 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367041; cv=none; b=n/x8MT+MF2ADAaV7rGL/fnPoiBAD/hrifmOG2PKIxyoQToUQ65bY9/41QyDTEPea6htGBhx6mulKiRIiKt29D/3sj7E/2DORT9LZ45LgmgNh/IpW9fC6xWgwRBF068p/pippNfW1TZyFAZ5DGdPLyqNUkuuGhK7xWH+XIW45Iag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367041; c=relaxed/simple;
	bh=Ojz4YdQa8AG+7jrZEpC6wSBAWB4NbUgef4n7LG7D+Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tge0M7nNKm2DeaW7PuSHZYEcBZTn2fmnK9mxiO0b84F0XyMVbBH431qaQzdJHn4l/Ga1hHGO6cVtnEQSusBTCuqn9Aio/a7iFajWXKVj01HOwmqGvX7R0xIXEVw8+88U9q+p1I81y2EpfaembWagamhsJCEfngj8yznZJP3A1CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWra4QLk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727367039; x=1758903039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ojz4YdQa8AG+7jrZEpC6wSBAWB4NbUgef4n7LG7D+Cg=;
  b=lWra4QLk+As/bUbfNteAMxYX2vpH5hyWoCK7RSN2b+QRC5JVHs2pNnYf
   jp8JDj6C5qu2cNV6jUEuhOhpT4e5vXSo4hOID9843d8pYDPuWT8PIHXLG
   Dxa1QlMMcKEaglXHzEidQlKRpcnn5HW12xPsL06OEWjmS84vsWCxDfBuE
   fKvLactj48UgXcBTxoWAzMEETe54J9LVytD5a2+AbHanJFnx/WeqhfzM6
   KB0G4s9d4KX4/GfTX07mKWOd9SuXTdjSXKXweenDFHEWOB5yrW5D/d98H
   8nN3OBHljspXe/S0vYxEm7UDnbNV8QO7CLqLy7lqIYli43MGl5shAgU88
   Q==;
X-CSE-ConnectionGUID: bngjd3HFQ1OjQ9wlfXOwfg==
X-CSE-MsgGUID: fKTvZcKTS3Walm8DE2SLug==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="30273649"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="30273649"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 09:10:38 -0700
X-CSE-ConnectionGUID: R962TzAvRP2WYWxRdt38NA==
X-CSE-MsgGUID: WYZHYSjkQ8GmQn8p6vjCSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="77040367"
Received: from ellisnea-mobl1.amr.corp.intel.com (HELO desk) ([10.125.147.235])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 09:10:39 -0700
Date: Thu, 26 Sep 2024 09:10:31 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20240926161031.dcohgbkbqs4bk32n@desk>
References: <20240925-fix-dosemu-vm86-v7-0-1de0daca2d42@linux.intel.com>
 <20240925-fix-dosemu-vm86-v7-3-1de0daca2d42@linux.intel.com>
 <5703f2d8-7ca0-4f01-a954-c0eb1de930b4@citrix.com>
 <20240925234616.2ublphj3vbluawb3@desk>
 <20240926001729.2unwdxtcnnkf3k3t@desk>
 <555e220d-7ff5-58e4-7ca8-282ca88d8392@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <555e220d-7ff5-58e4-7ca8-282ca88d8392@gmail.com>

On Thu, Sep 26, 2024 at 04:52:53PM +0200, Uros Bizjak wrote:
> > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > index e18a6aaf414c..4228a1fd2c2e 100644
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -318,14 +318,21 @@
> >   /*
> >    * Macro to execute VERW instruction that mitigate transient data sampling
> >    * attacks such as MDS. On affected systems a microcode update overloaded VERW
> > - * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF. Using %cs
> > - * to reference VERW operand avoids a #GP fault for an arbitrary user %ds in
> > - * 32-bit mode.
> > + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
> >    *
> >    * Note: Only the memory operand variant of VERW clears the CPU buffers.
> >    */
> >   .macro CLEAR_CPU_BUFFERS
> > -	ALTERNATIVE "", __stringify(verw %cs:_ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> > +#ifdef CONFIG_X86_64
> > +	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> 
> You should drop _ASM_RIP here and direclty use (%rip). This way, you also
> won't need __stringify:
> 
> ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
> 
> > +#else
> > +	/*
> > +	 * In 32bit mode, the memory operand must be a %cs reference. The data
> > +	 * segments may not be usable (vm86 mode), and the stack segment may not
> > +	 * be flat (ESPFIX32).
> > +	 */
> > +	ALTERNATIVE "", __stringify(verw %cs:mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF
> 
> Also here, no need for __stringify:
> 
> ALTERNATIVE "", "verw %cs:mds_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
> 
> This is in fact what Andrew proposed in his review.

Thanks for pointing out, I completely missed that part. Below is how it
looks like with stringify gone:

--- >8 ---
Subject: [PATCH] x86/bugs: Use code segment selector for VERW operand

Robert Gill reported below #GP in 32-bit mode when dosemu software was
executing vm86() system call:

  general protection fault: 0000 [#1] PREEMPT SMP
  CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
  Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
  EIP: restore_all_switch_stack+0xbe/0xcf
  EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
  ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
  DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
  CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
  Call Trace:
   show_regs+0x70/0x78
   die_addr+0x29/0x70
   exc_general_protection+0x13c/0x348
   exc_bounds+0x98/0x98
   handle_exception+0x14d/0x14d
   exc_bounds+0x98/0x98
   restore_all_switch_stack+0xbe/0xcf
   exc_bounds+0x98/0x98
   restore_all_switch_stack+0xbe/0xcf

This only happens in 32-bit mode when VERW based mitigations like MDS/RFDS
are enabled. This is because segment registers with an arbitrary user value
can result in #GP when executing VERW. Intel SDM vol. 2C documents the
following behavior for VERW instruction:

  #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
	   FS, or GS segment limit.

CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
space. Use %cs selector to reference VERW operand. This ensures VERW will
not #GP for an arbitrary user %ds.

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Cc: stable@vger.kernel.org # 5.10+
Reported-by: Robert Gill <rtgill82@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/nospec-branch.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index ff5f1ecc7d1e..96b410b1d4e8 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -323,7 +323,16 @@
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
 .macro CLEAR_CPU_BUFFERS
-	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
+#ifdef CONFIG_X86_64
+	ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
+#else
+	/*
+	 * In 32bit mode, the memory operand must be a %cs reference. The data
+	 * segments may not be usable (vm86 mode), and the stack segment may not
+	 * be flat (ESPFIX32).
+	 */
+	ALTERNATIVE "", "verw %cs:mds_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
+#endif
 .endm
 
 #ifdef CONFIG_X86_64
-- 
2.34.1


