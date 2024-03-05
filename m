Return-Path: <stable+bounces-26865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931228729C5
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 22:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FA71C21D6D
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 21:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3F012B177;
	Tue,  5 Mar 2024 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mX834fWp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39625A796
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675700; cv=none; b=Kjd+98f3KcnUQ7XDFzG47tLEKqSgiXTHUZCVPygSFsRAaxFRP5stUh2W0eJVdcUXLRUDRl6GsMYuq6WcM59ESiAWliGdHaQI30A2yl5WzMZrZy0xy9k3t4wEVZX+/vRNhair8VMQWYFfQU4BFmWml2YYRFNZ1t6PYXCd04zn4p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675700; c=relaxed/simple;
	bh=cBVtSlVD4/Cv1kmS5H8Mtu4sJfuUkQzH9i1+sWlSql4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooFZxdadc6jOkvwItOcRJLCn0/vubNwb3OmCA/Mu6xiN/4ucdbAtihgki/Q7/IBX/FsLHKjppTqvns4En8lMjfR5UmVuXYTTiXyOkIRpLqc4m7bFz3N2MfJL41t8LXlEePv5dX4jjejVaD7HpJP3wcMcgKv1qBESbN51bdlQWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mX834fWp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709675699; x=1741211699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cBVtSlVD4/Cv1kmS5H8Mtu4sJfuUkQzH9i1+sWlSql4=;
  b=mX834fWpY+B606W6xO1cchW2MD0OthzGot7rUXS5UTLZn2mpr4M1Kk+I
   LTvrXl2/x4NPNk4epNZuCYJhTprzQkP99012x81OQEvNiTSYKEnoulILI
   Jl/2jWIH6QQdoYICnlA4FnFdkoogRQV+AZ8Jc1DZIMbu/DABNke4nkzuf
   /bHn3zAK2Xm3OlqD8sHpxNve3/MqBf6FACUHjuoRpMliyd1DkVqlRfciV
   MQI7wZ02OuvDGOSBTEKwGavCHf40muQuVGds9qMXqPrZDAwTGkqBipPKO
   AeBP6NZdbVJKKW2rvaaCT8Azq6TdMCUh/uE2ykxRzZDVn2dz+ZMi8zyQ1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15662594"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="15662594"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9413566"
Received: from pbemalkh-mobl.amr.corp.intel.com (HELO desk) ([10.209.20.113])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:54:57 -0800
Date: Tue, 5 Mar 2024 13:54:56 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5.10.y 2/7] x86/bugs: Add asm helpers for executing VERW
Message-ID: <20240305-delay-verw-backport-5-10-y-v1-2-50bf452e96ba@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240305-delay-verw-backport-5-10-y-v1-0-50bf452e96ba@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-delay-verw-backport-5-10-y-v1-0-50bf452e96ba@linux.intel.com>

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



