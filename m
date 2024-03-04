Return-Path: <stable+bounces-25864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D65F186FD5D
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140851C21F7D
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 09:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCD1225AD;
	Mon,  4 Mar 2024 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btlOKZd+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779A9225CB
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544237; cv=none; b=QNjddXRD/oEmgG440UNlbC9/KeDfB0D26PINOaZKIrT/Im6LfBy17CUzuRLamn1Xaa4FKouhA6xJp3ZQm/rXRhr070yG8jDk7FKvVrQ3CSQnekyudhKlWVuidoNgdb9wwp9b1N51LZgfcb/oSngJeIB4aPQYj7akgVg44tC6pQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544237; c=relaxed/simple;
	bh=mcbCYjnz8yBZCJ+vU1YOz39ez/Q4pWi/SPclTCxKfSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKv5y8XljMFQiHuMT+wUyLUkWVuFa8L0k4on7Tk93IxKlsl3sITJqN5hZLIrVZSm0RIClGC/L4s2eE+s2kHYwL3NXOTZ5BZ/dcPj+dk/wuIpE1HR+YclLN2SWNneKkO46eYQqxMSnzP927JIX8bnTfTeVcKyzlfl1z8GeRMASfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btlOKZd+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709544236; x=1741080236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mcbCYjnz8yBZCJ+vU1YOz39ez/Q4pWi/SPclTCxKfSI=;
  b=btlOKZd+ffpkEjK51IxLjrZKN4nB8xE/I2grEPtiklfl07CzqsaKLgB4
   hn/5mqswLo2tKARh36NR4coKFKTi/MEo+OHo2Q+51hpnL6BoMpZOaDGRn
   vD6NiNLw6ereQYoN6v/Y+os51Svw5sAgt4oP3D/NK2stea5M8PfgV+2hV
   cdgq3xfii3+ac+rjoIWlNwqp88dUcmQeZY5LjgUCY5n6vMgMh4ACsXfYi
   uQ5WPFeeDHGYJVTw5QZjHd1OGg79jAqQs6VZDsJdhIb0ZRkB1HbTqZXyX
   rkef2L94XbvEVa9WURCMWcWolFpkmvx47IIa+K6CVNtegoQA3ybXj3ED6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7834872"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7834872"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:23:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8839500"
Received: from smullaly-mobl1.amr.corp.intel.com (HELO desk) ([10.209.64.100])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:23:54 -0800
Date: Mon, 4 Mar 2024 01:23:53 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 6.1.y v2 1/6] x86/bugs: Add asm helpers for executing VERW
Message-ID: <20240304-delay-verw-backport-6-1-y-v2-1-bf4bce517d60@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240304-delay-verw-backport-6-1-y-v2-0-bf4bce517d60@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-delay-verw-backport-6-1-y-v2-0-bf4bce517d60@linux.intel.com>

commit baf8361e54550a48a7087b603313ad013cc13386 upstream.

MDS mitigation requires clearing the CPU buffers before returning to
user. This needs to be done late in the exit-to-user path. Current
location of VERW leaves a possibility of kernel data ending up in CPU
buffers for memory accesses done after VERW such as:

  1. Kernel data accessed by an NMI between VERW and return-to-user can
     remain in CPU buffers since NMI returning to kernel does not
     execute VERW to clear CPU buffers.
  2. Alyssa reported that after VERW is executed,
     CONFIG_GCC_PLUGIN_STACKLEAK=y scrubs the stack used by a system
     call. Memory accesses during stack scrubbing can move kernel stack
     contents into CPU buffers.
  3. When caller saved registers are restored after a return from
     function executing VERW, the kernel stack accesses can remain in
     CPU buffers(since they occur after VERW).

To fix this VERW needs to be moved very late in exit-to-user path.

In preparation for moving VERW to entry/exit asm code, create macros
that can be used in asm. Also make VERW patching depend on a new feature
flag X86_FEATURE_CLEAR_CPU_BUF.

  [pawan: - Runtime patch jmp instead of verw in macro CLEAR_CPU_BUFFERS
	    due to lack of relative addressing support for relocations
	    in kernels < v6.5.
	  - Add UNWIND_HINT_EMPTY to avoid warning:
	    arch/x86/entry/entry.o: warning: objtool: mds_verw_sel+0x0: unreachable instruction]

Reported-by: Alyssa Milburn <alyssa.milburn@intel.com>
Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-1-a6216d83edb7%40linux.intel.com
---
 arch/x86/entry/entry.S               | 23 +++++++++++++++++++++++
 arch/x86/include/asm/cpufeatures.h   |  2 +-
 arch/x86/include/asm/nospec-branch.h | 15 +++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index bfb7bcb362bc..09e99d13fc0b 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -6,6 +6,9 @@
 #include <linux/linkage.h>
 #include <asm/export.h>
 #include <asm/msr-index.h>
+#include <asm/unwind_hints.h>
+#include <asm/segment.h>
+#include <asm/cache.h>
 
 .pushsection .noinstr.text, "ax"
 
@@ -20,3 +23,23 @@ SYM_FUNC_END(entry_ibpb)
 EXPORT_SYMBOL_GPL(entry_ibpb);
 
 .popsection
+
+/*
+ * Define the VERW operand that is disguised as entry code so that
+ * it can be referenced with KPTI enabled. This ensure VERW can be
+ * used late in exit-to-user path after page tables are switched.
+ */
+.pushsection .entry.text, "ax"
+
+.align L1_CACHE_BYTES, 0xcc
+SYM_CODE_START_NOALIGN(mds_verw_sel)
+	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
+	.word __KERNEL_DS
+.align L1_CACHE_BYTES, 0xcc
+SYM_CODE_END(mds_verw_sel);
+/* For KVM */
+EXPORT_SYMBOL_GPL(mds_verw_sel);
+
+.popsection
+
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b122708792c4..b60f24b30cb9 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -304,7 +304,7 @@
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
-
+#define X86_FEATURE_CLEAR_CPU_BUF	(11*32+18) /* "" Clear CPU buffers using VERW */
 
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
 
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index d3706de91a93..2c66b2081f87 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -194,6 +194,19 @@
 #endif
 .endm
 
+/*
+ * Macro to execute VERW instruction that mitigate transient data sampling
+ * attacks such as MDS. On affected systems a microcode update overloaded VERW
+ * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
+ *
+ * Note: Only the memory operand variant of VERW clears the CPU buffers.
+ */
+.macro CLEAR_CPU_BUFFERS
+	ALTERNATIVE "jmp .Lskip_verw_\@", "", X86_FEATURE_CLEAR_CPU_BUF
+	verw _ASM_RIP(mds_verw_sel)
+.Lskip_verw_\@:
+.endm
+
 #else /* __ASSEMBLY__ */
 
 #define ANNOTATE_RETPOLINE_SAFE					\
@@ -375,6 +388,8 @@ DECLARE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 
 DECLARE_STATIC_KEY_FALSE(mmio_stale_data_clear);
 
+extern u16 mds_verw_sel;
+
 #include <asm/segment.h>
 
 /**

-- 
2.34.1



