Return-Path: <stable+bounces-144316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D80AB62B7
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53153BEAC9
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB3A1EFFAC;
	Wed, 14 May 2025 06:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LPch3Inq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F9433A8
	for <stable@vger.kernel.org>; Wed, 14 May 2025 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202850; cv=none; b=QNlaKzcjKwlYmGRXW/j6lRh12RXNhGY2kxWc+Q5A1MaEeGwcP0PZvFw/3R0uU0fj2YnuLqIxnVqNlyo3QHX4cTCjR46LIZiDdm+XvFluqSPJsG1CwbPY0jdKiUMa1ezUFB4QThK0CbClYuIoED/vBuD/9PZKy7OImb+emjXUWMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202850; c=relaxed/simple;
	bh=+/YI0S18jPqJopaQprHR1V3MNh1pHtctH4ctgknaW5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwFuZbSeOPhGFGzVW66pGDFv5wx4zLX/KoovE+bhXS+P1pv/iZ8+AVYASy5POeYtqW7Dww993cn0hxLDLlrrdgC4jb2J1opif3xQYmZuC5MeVhtTEH74G+WDVY8pm2Xut9OEgqDQVhb8JEL21LKYxzHG4Yh5V+Du2CgtMIx7QvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LPch3Inq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747202847; x=1778738847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+/YI0S18jPqJopaQprHR1V3MNh1pHtctH4ctgknaW5c=;
  b=LPch3Inq0ktfPIHgQZ60evf74nKa7t5NUlM5D8jipa3gW9rxioC9rNR2
   OFxJXqaN/RDpyM8ay3LKM0npwOvVELMJQBteLGJ/UGOKa/8BVgYYa5Btb
   murVqHG8Sl5fRvv+hr2SmsNm1xt91WAdu5iv4hEXjZp0mLFl/MuihmvXe
   MA0ttEGfKHuXXaTaP2iVjglu/6Pnc9iEn+WdfCGiiz3MCR22W7aAZNMut
   Eeu2UZq0KQcgY6cJ1EB8QX3uc8hI6HfaSRdTq0KZ8vQF29iD3ltqiqThD
   CjlQMkyX1XCx9LLPaHuiM98yLrM2l4Wh/qEi176R3iVEbQbVaRMtszgBN
   w==;
X-CSE-ConnectionGUID: xdXLyq9qQdixBHExAPbPsw==
X-CSE-MsgGUID: 6sToQUhpQ8OJwhpswwUrbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="66630079"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="66630079"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:07:26 -0700
X-CSE-ConnectionGUID: A1QSHOz1R7GIj0a8iqgj8g==
X-CSE-MsgGUID: OeKPldWyR9CpdcMfXeCIcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="141963243"
Received: from rshah-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.11])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:07:26 -0700
Date: Tue, 13 May 2025 23:07:25 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 5.15 v2 03/14] x86/speculation: Add a conditional CS prefix
 to CALL_NOSPEC
Message-ID: <20250513-its-5-15-v2-3-90690efdc7e0@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250513-its-5-15-v2-0-90690efdc7e0@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513-its-5-15-v2-0-90690efdc7e0@linux.intel.com>

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



