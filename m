Return-Path: <stable+bounces-27543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFFD879EFA
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 23:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A1E1C21C50
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 22:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282AD1CA8F;
	Tue, 12 Mar 2024 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="II1enuu/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCBFBE7D
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710283235; cv=none; b=VgmV6xvBOBPcaepgmc9zq2tKnmXJPxTkF9i/QMDpuHfk/qfdvNzll6xqNHfylCJ9D8Dk8MxZ38x2syYkQzPEPMQwPjYKYKRKAptaNe+aambgyYnbN/94JtGYB9/i3sXmr089imONqw52x9NZ7wwo/9GaAVtD/dNze8SssPlj8/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710283235; c=relaxed/simple;
	bh=cBVtSlVD4/Cv1kmS5H8Mtu4sJfuUkQzH9i1+sWlSql4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4dQZUP7VbgYNKUqTnFvL6mGSwc6JgD95PhUE97tdTaz5Qs2mXL92ea7g/dfxMn7viQ8IZZAjQIKxYOYMpMtMgdnVFoYceT8vRM6fiU5g9h5vMGnb/2unJ39GLULnmrI0hLl1HqFgDrxE2PaYeZhGZ8lnY6veXkx5oZff8LEyLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=II1enuu/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710283234; x=1741819234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cBVtSlVD4/Cv1kmS5H8Mtu4sJfuUkQzH9i1+sWlSql4=;
  b=II1enuu/vkk2DisfX5lKHwPEQpiEANAdUz4y9ORUNtpMHVHmCTFZ+9Yk
   JNu0LQynf1hdmRBD+EbLq2xWYpgrmHvWtMU+jwm9bkCR9WXOvMg21IK/h
   Mxyoe6GZcKCQk7GMFlyyzTaQcwjeVibBGoJU4EnalVK9tX7a112c/vmN4
   yVKJCIwYi7izwYghu0k92usSCWeGSlenlJDuvnooYaS9qsjIkDCnwgVJP
   TskMJPZy2OZbGXrbBM402U52pEw/ifzCIpIS6Oc/4bBkMhnFQ7CDzpMAK
   YJ5bVxZuBdFCqxe/Z1NN7zYGxW8xSi8LTrGuJGxRoQO4/bl7H9bJ5V46U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22475867"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22475867"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:40:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12116109"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:40:34 -0700
Date: Tue, 12 Mar 2024 15:40:33 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5.10.y v2 02/11] x86/bugs: Add asm helpers for executing VERW
Message-ID: <20240312-delay-verw-backport-5-10-y-v2-2-ad081ccd89ca@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240312-delay-verw-backport-5-10-y-v2-0-ad081ccd89ca@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-delay-verw-backport-5-10-y-v2-0-ad081ccd89ca@linux.intel.com>

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
 arch/x86/include/asm/cpufeatures.h   |  1 +
 arch/x86/include/asm/nospec-branch.h | 15 +++++++++++++++
 3 files changed, 39 insertions(+)

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
index 5a54c3685a06..90079ab77fb5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -300,6 +300,7 @@
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+18) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
+#define X86_FEATURE_CLEAR_CPU_BUF	(11*32+19) /* "" Clear CPU buffers using VERW */
 
 #define X86_FEATURE_SRSO		(11*32+24) /* "" AMD BTB untrain RETs */
 #define X86_FEATURE_SRSO_ALIAS		(11*32+25) /* "" AMD BTB untrain RETs through aliasing */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 7711ba5342a1..abbddf7c3290 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -182,6 +182,19 @@
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
@@ -362,6 +375,8 @@ DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
 
 DECLARE_STATIC_KEY_FALSE(mmio_stale_data_clear);
 
+extern u16 mds_verw_sel;
+
 #include <asm/segment.h>
 
 /**

-- 
2.34.1



