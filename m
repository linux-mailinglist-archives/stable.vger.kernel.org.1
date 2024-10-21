Return-Path: <stable+bounces-87625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D6D9A7314
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 21:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B43282F39
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 19:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF341D07BF;
	Mon, 21 Oct 2024 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bca4FQxN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A781EEE0
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538319; cv=none; b=S4T9H0bnY5Uz71L66dsURVzFufmoaSvMwTb2QVe3SxSD00KJKEtvmc9ZP3VreTO8HkicqzPfODoOn8qQ56deLqumCwxJdxJmoVCC8ziGiYW6e0LCG2/PvZwNXecUEM2x9SVwb9whsweH8xqcurYxKjQpUTCMnm9v8DAdqhGfPjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538319; c=relaxed/simple;
	bh=B8v2mNbYgZabMxqR2QxOdLJZ2Fk3uTNNvbLH58g2K+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrA7A81Z+sTUwAW/YPU/FsjOgTVDf20kgXdxR1vvnFfbyltfP2LfvHm7GaIi7pXCvPzSsMaLJlxNgL/GPMB0INcmW4HhZVh9cLn/KwRydd9XV5CcK2XquOOV/2ei6jyHvHqhUj4C5Mayo3NG8TB1MUxUJUAnH7cRQdj55Nx6TW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bca4FQxN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729538318; x=1761074318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B8v2mNbYgZabMxqR2QxOdLJZ2Fk3uTNNvbLH58g2K+c=;
  b=Bca4FQxNKxVR/JY85rbXiO5nbqcnmCqNVAB+uM595CpZ2jtV4FtfJusW
   dnAVzcfCLh0zQai6Jax9R04HrXhfXgNVXMrWJX+AWl7vtB6NLVkYbBcGI
   sBUFnFdAkr290HtwIIokuUWmodYMbCz/WgF5hdQHuIB/1o7qnBY/5XWUU
   34nnoy/hAC1XBQtSBYSvWtBPElJ1+U/GvK6373k8klbQLfVuqio2tSoKS
   RqabsvjVkhKxHiUh1Q4EUUXf93eDX4sJ1ldXsMql1hcE6HAanpC0sgdYR
   rTfwgzVYMoX6ElufxcHXQmLECxydnYT/Y8f1xNzG1l0v8Uvi7A69vcRsC
   A==;
X-CSE-ConnectionGUID: nWV9UW01SnmA8Brj8V2UMg==
X-CSE-MsgGUID: UmXcrssaRmiM2NdwQ215qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="39658943"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="39658943"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 12:18:37 -0700
X-CSE-ConnectionGUID: 1e2PcecSTVWXB9ztYks8lg==
X-CSE-MsgGUID: Is1yboutStmjzlAW2kKkBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84437270"
Received: from cphoward-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.124])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 12:18:36 -0700
Date: Mon, 21 Oct 2024 12:18:18 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: andrew.cooper3@citrix.com, brgerst@gmail.com,
	dave.hansen@linux.intel.com, mingo@kernel.org, rtgill82@gmail.com
Subject: [PATCH 5.15.y] x86/bugs: Use code segment selector for VERW operand
Message-ID: <d2fca828795e4980e0708a179bd60b2a89bc8089.1729538132.git.pawan.kumar.gupta@linux.intel.com>
References: <2024102130-saturday-bountiful-5087@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024102130-saturday-bountiful-5087@gregkh>

commit e4d2102018542e3ae5e297bc6e229303abff8a0f upstream.

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

[ mingo: Fixed the SOB chain. ]
[ pawan: Backported to 5.15 ]

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Reported-by: Robert Gill <rtgill82@gmail.com>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: stable@vger.kernel.org # 5.10+
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
Backport is boot tested on x86 64 and 32 mode.

 arch/x86/include/asm/nospec-branch.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index ed582fa98cb2..bdf22582a8c0 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -199,7 +199,16 @@
  */
 .macro CLEAR_CPU_BUFFERS
 	ALTERNATIVE "jmp .Lskip_verw_\@", "", X86_FEATURE_CLEAR_CPU_BUF
-	verw _ASM_RIP(mds_verw_sel)
+#ifdef CONFIG_X86_64
+	verw mds_verw_sel(%rip)
+#else
+	/*
+	 * In 32bit mode, the memory operand must be a %cs reference. The data
+	 * segments may not be usable (vm86 mode), and the stack segment may not
+	 * be flat (ESPFIX32).
+	 */
+	verw %cs:mds_verw_sel
+#endif
 .Lskip_verw_\@:
 .endm
 
-- 
2.34.1


