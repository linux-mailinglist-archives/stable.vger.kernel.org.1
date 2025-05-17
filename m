Return-Path: <stable+bounces-144645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E875ABA6D4
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 02:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0BF1BC3053
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 00:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B42B34CDD;
	Sat, 17 May 2025 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIFVbDxJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F4A47
	for <stable@vger.kernel.org>; Sat, 17 May 2025 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440018; cv=none; b=ZKU+Ih/l1KcoFaS8GrGJThQTX9sqzcrk94mcpUBfHntbW7Or2BbifsCD8deBf2JJu2lrmXPezkA2g01M2/7Xn8LxND7u9s4Nc+fXli/rPWhh7L87C4q9+9KCJDd3mobuvS+Xx15XDSlNV1G4707PCcANmmFjvIGbyJ7lqklmpv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440018; c=relaxed/simple;
	bh=+/YI0S18jPqJopaQprHR1V3MNh1pHtctH4ctgknaW5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2xMUgQcYFg/nHtb6wk5R8LaTze/jSGTXEg6pxuvuA696wH7Uqr/TQTr4QPpvq1qpGdDIrnNtwCI8OLg42FIy5tzEjbnNGvzlk6A0UWKMzJ+OdJ3z6Nj3jp/8aPpGMQakVLA5HafvuXWqLgLsm1MhngSqZEGX/hPjxf2YpRm9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIFVbDxJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747440017; x=1778976017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+/YI0S18jPqJopaQprHR1V3MNh1pHtctH4ctgknaW5c=;
  b=CIFVbDxJq3zBDjsmZ7C7howCTDfKpjl+1+Ga2ojjz3mIs+UDq4w/ICFe
   YVvUc2rZWiNB6BCJ4dxD/a4nTday2zuTqYGLxHJqoyej/TCSt2XdtQgVN
   kdulA++v5vpayFNHm7D/trlppVF2OZ1HNjO6e0oYKbzj9X2KueZyYNkuU
   TrehGKQU7UYCRW5lgUXeyuE1cAGFgOHcZy12d0/cXYrLXRWJeC2P1Jfzk
   xEFlcp6PGxC4SZvuF3n0Zi/0hf6D2TaVtCi8Vm2VXCDFOTQ5WhFJ37MNa
   IHjiMR6MDUMffsQWJN/gFvf/9ZH+h6Wf2F6Ee2QtGGvyycTaRDI+O3gnR
   A==;
X-CSE-ConnectionGUID: DOUuw0NnQVCeU5Emh4R6MQ==
X-CSE-MsgGUID: eRk/RaHtRZikhA39Iat3Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="74822835"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="74822835"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:00:15 -0700
X-CSE-ConnectionGUID: U0gKScfVRMugOSU4vpUGvw==
X-CSE-MsgGUID: O+mGEUYMTS2DbpG09oMk6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="138883131"
Received: from yzhou16-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.16])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:00:15 -0700
Date: Fri, 16 May 2025 17:00:15 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 5.15 v3 03/16] x86/speculation: Add a conditional CS prefix
 to CALL_NOSPEC
Message-ID: <20250516-its-5-15-v3-3-16fcdaaea544@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>

commit 052040e34c08428a5a388b85787e8531970c0c67 upstream.

Retpoline mitigation for spectre-v2 uses thunks for indirect branches. To
support this mitigation compilers add a CS prefix with
-mindirect-branch-cs-prefix. For an indirect branch in asm, this needs to
be added manually.

CS prefix is already being added to indirect branches in asm files, but not
in inline asm. Add CS prefix to CALL_NOSPEC for inline asm as well. There
is no JMP_NOSPEC for inline asm.

Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250228-call-nospec-v3-2-96599fed0f33@linux.intel.com
---
 arch/x86/include/asm/nospec-branch.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 031a38366b0dd1e35a82e49d6b18147ada7dd80c..9b16113687e21e0a272ec2fa13b7f144efe833a7 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -119,9 +119,8 @@
 .endm
 
 /*
- * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
- * to the retpoline thunk with a CS prefix when the register requires
- * a RAX prefix byte to encode. Also see apply_retpolines().
+ * Emits a conditional CS prefix that is compatible with
+ * -mindirect-branch-cs-prefix.
  */
 .macro __CS_PREFIX reg:req
 	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15
@@ -281,12 +280,24 @@ extern retpoline_thunk_t __x86_indirect_thunk_array[];
 
 #ifdef CONFIG_X86_64
 
+/*
+ * Emits a conditional CS prefix that is compatible with
+ * -mindirect-branch-cs-prefix.
+ */
+#define __CS_PREFIX(reg)				\
+	".irp rs,r8,r9,r10,r11,r12,r13,r14,r15\n"	\
+	".ifc \\rs," reg "\n"				\
+	".byte 0x2e\n"					\
+	".endif\n"					\
+	".endr\n"
+
 /*
  * Inline asm uses the %V modifier which is only in newer GCC
  * which is ensured when CONFIG_RETPOLINE is defined.
  */
 #ifdef CONFIG_RETPOLINE
-#define CALL_NOSPEC	"call __x86_indirect_thunk_%V[thunk_target]\n"
+#define CALL_NOSPEC	__CS_PREFIX("%V[thunk_target]")	\
+			"call __x86_indirect_thunk_%V[thunk_target]\n"
 #else
 #define CALL_NOSPEC	"call *%[thunk_target]\n"
 #endif

-- 
2.34.1



