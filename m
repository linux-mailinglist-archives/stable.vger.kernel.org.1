Return-Path: <stable+bounces-144314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2583BAB62B5
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B332546388D
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807771E5B68;
	Wed, 14 May 2025 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AS4plHhl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344681E1308
	for <stable@vger.kernel.org>; Wed, 14 May 2025 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202819; cv=none; b=TMUKyt0hlHTRJC2JuKADVICOmQfNALzWm4xPxw2Yn/Mkk+CfQ3b20QX27+KSJsJL7zp+h78kvDgQ+DygdV7zpEQfKDM/Ys1D6hziG25M5KrrWo/2CtlckMh/2dTOsC9BzkbFs8/jiIN6+f/5O6p2xFLZYqQ2bTC0r5/PrhIfNUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202819; c=relaxed/simple;
	bh=8dphv/f2Nd5rYkngK6mIBlo5HEjp20PMB6jSpXcQ7Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/1cN2FoEekbc7SHGZeiKQzrVMw4ujt+Cxg5KkAML23dznmh64EuZEbtKRuGvhRzZ8e+0eZshRBNkDMbh7aIS0HkC8cvCWkZgE5N5HLFMAbAMnXEg7lPSadeN2btj7i4UK664LOtQetmVTJz4xsfDG23l269gcQJ3lWxKAYt+0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AS4plHhl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747202816; x=1778738816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8dphv/f2Nd5rYkngK6mIBlo5HEjp20PMB6jSpXcQ7Pk=;
  b=AS4plHhlPQUxjLqnzDIpOyYksRDpdKtKJenLswZVuz4WyU6TBKLtd6b+
   vxjZB4/d3QusXraXMl/dyR9JCQxFfpS/R2/jw6obXC4Pa86QGk1cELGQF
   aHJQuzsUldQePVBOFZ/zh+4Ff+vZJr4Xrhlc7+PuafxEdcHxPjaJVfZDu
   PNmehG0fJ5FJuIWOjIh/2zv5XntSg3i6FrsSmPFqsVDMgwBbhGd6dZMvJ
   epZN+6rC2bt2JQWzRVNiwC0kAfEVxHc8eet8IFK20wyiRA6EJGHs2/JBV
   p/jBrH4QDLki1JD19sWcwVoRXSCdtr1CYgd/8zkODxQd6eeA4E+ejfV9h
   Q==;
X-CSE-ConnectionGUID: QCqsJir2QKaoqz008tuYtQ==
X-CSE-MsgGUID: 9j6wUVBPS8q7i4DvDJZ93w==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="60419918"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="60419918"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:06:55 -0700
X-CSE-ConnectionGUID: vnlUbahaR1+9IsmMkRLzCA==
X-CSE-MsgGUID: ftR+ymvyReaA+Cb5yPFGCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="137658589"
Received: from rshah-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.11])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:06:56 -0700
Date: Tue, 13 May 2025 23:06:55 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.15 v2 01/14] x86,nospec: Simplify {JMP,CALL}_NOSPEC
Message-ID: <20250513-its-5-15-v2-1-90690efdc7e0@linux.intel.com>
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

From: Peter Zijlstra <peterz@infradead.org>

commit 09d09531a51a24635bc3331f56d92ee7092f5516 upstream.

Have {JMP,CALL}_NOSPEC generate the same code GCC does for indirect
calls and rely on the objtool retpoline patching infrastructure.

There's no reason these should be alternatives while the vast bulk of
compiler generated retpolines are not.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/nospec-branch.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index bdf22582a8c0133add704b72f88186d5aed93bab..1a825dca11a71c72701882f067d555df8fd1f8e1 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -118,6 +118,19 @@
 #endif
 .endm
 
+/*
+ * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
+ * to the retpoline thunk with a CS prefix when the register requires
+ * a RAX prefix byte to encode. Also see apply_retpolines().
+ */
+.macro __CS_PREFIX reg:req
+	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15
+	.ifc \reg,\rs
+	.byte 0x2e
+	.endif
+	.endr
+.endm
+
 /*
  * JMP_NOSPEC and CALL_NOSPEC macros can be used instead of a simple
  * indirect jmp/call which may be susceptible to the Spectre variant 2
@@ -125,19 +138,18 @@
  */
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
-		      __stringify(jmp __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
-		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_LFENCE
+	__CS_PREFIX \reg
+	jmp	__x86_indirect_thunk_\reg
 #else
 	jmp	*%\reg
+	int3
 #endif
 .endm
 
 .macro CALL_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg), \
-		      __stringify(call __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
-		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *%\reg), X86_FEATURE_RETPOLINE_LFENCE
+	__CS_PREFIX \reg
+	call	__x86_indirect_thunk_\reg
 #else
 	call	*%\reg
 #endif

-- 
2.34.1



