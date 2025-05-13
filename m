Return-Path: <stable+bounces-144080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A49AB49C6
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 04:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B6A19E8198
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 02:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744721C2437;
	Tue, 13 May 2025 02:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zfya9R7J"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631B1C683
	for <stable@vger.kernel.org>; Tue, 13 May 2025 02:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105108; cv=none; b=taMG6Ux2sEAUXc9nz5qx/Y7JsopSYoE/5NOtR6zpXCi5iUhON1RBqcSQm0BzR5TicSLLBau3MxdvARCvSLXX2K0HmD1ZL0RwMFL+2ahAh3YCdMWv7rUQLAW/JE6VYxirepX7cyB6drKKo5VpLolAdNIJCi6f1rR777YAoYKrmrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105108; c=relaxed/simple;
	bh=+/YI0S18jPqJopaQprHR1V3MNh1pHtctH4ctgknaW5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBVeVodpv9XWC/4X2t+pZpu1eWz3mZ3rhCsxxH5xLUljOAn9LKMbO6t3abql2i7kNBzbDhOhic5UvO0B1xk77K6JtVOpk6a8s196KZN6Q7aACmHTkwWKXnaXgtpoXDEnAXUCLzSAx1UF4VRyHOqXfeTa8R2BCZqQuLOAw9A/fHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zfya9R7J; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747105107; x=1778641107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+/YI0S18jPqJopaQprHR1V3MNh1pHtctH4ctgknaW5c=;
  b=Zfya9R7JBvjwa/BUL++qXepYnMIyjuEcmvI+phoc4DTfBrcNzXUzhukO
   kAsY6zUFq5fvYYjYPwVO8lNRY8SY8IRm9TMipBaYUEwakIzljtusAQCOv
   PqSUDSUspqYYGnsQlnhmNzR2xlRWqDX94ZXWAU6cdrgaZLWumF3b9eFzB
   4gkd2YiVjC/1FSTcOtvBvccYTPqERfgp2TNe/ZkOm9L8O7+AyzwHL5gDX
   ECk+A5kd0I7yPyzdOdx+6Fe3CG3oqT4Nnvhp2i9LhgI7HtpbBYUVu3rFF
   BsbDUhwBWEAlr+j6DqutEBcg1QJbPVfnf+yIOAmjP3HVROznj/ZS3MOCN
   Q==;
X-CSE-ConnectionGUID: 0mVe+wWYQAm3GiwziOuy4Q==
X-CSE-MsgGUID: Wr/Cjs/PTTOa9R0ia2xnfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="51583525"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="51583525"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:58:26 -0700
X-CSE-ConnectionGUID: hnRQiYMJT8adkVoN0JkbHA==
X-CSE-MsgGUID: zkB/Sy6dSiqT4LsKbCKM2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="137576210"
Received: from lvelazqu-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.9])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:58:26 -0700
Date: Mon, 12 May 2025 19:58:25 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.15 03/14] x86/speculation: Add a conditional CS prefix to
 CALL_NOSPEC
Message-ID: <20250512-its-5-15-v1-3-6a536223434d@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250512-its-5-15-v1-0-6a536223434d@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512-its-5-15-v1-0-6a536223434d@linux.intel.com>

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



