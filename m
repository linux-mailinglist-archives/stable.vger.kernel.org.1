Return-Path: <stable+bounces-144643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 582FCABA6D1
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 01:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4271DA0858D
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 23:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44701280A3B;
	Fri, 16 May 2025 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkagaMpZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8640A23644F
	for <stable@vger.kernel.org>; Fri, 16 May 2025 23:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747439987; cv=none; b=VzcU10+hkpxyIMFb/8kuBOdjY/YDwSr7O6nEBQB/9GmjSFZ9hvwEAxnfiP0MUtzpiCa+fLh0VYvR4sFyX6Ir4nkLDsOuQE6uu7P26t1ZjkSrlPXZlYnlNvaAjgvawheoumG+F9V72JHvdrLnVS5yhiTmYdiCRmJH+hM5wI9roEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747439987; c=relaxed/simple;
	bh=8dphv/f2Nd5rYkngK6mIBlo5HEjp20PMB6jSpXcQ7Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Btr+NW7fnhwkHffkIniarVVpDiTTAhu8lyXgrgDUbTXmpQURxHABNtj+jUsn29N6vHWzSQnnVu1bUUT2+EWvdERnMV10fx0rMDzchN53fmmzZCd7NDAZBy6osLmbUDnhheJQwhR/NsyUvhWk76lMabxtJL8LZDcMrw2yv254L0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkagaMpZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747439986; x=1778975986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8dphv/f2Nd5rYkngK6mIBlo5HEjp20PMB6jSpXcQ7Pk=;
  b=nkagaMpZG7e0Pd7PiwHVO9rSOsf+4fIFP+7+KvlGtqIDHyIDzR9scCBp
   RBmXiH2Fj22XyvzGGz/Mdm4y7A/yZahsBKKBUoxcOftwakMZR06P+lwpq
   nX6pB2FRdTr4YZsPL64IvBUa2aTbuqnMqYhk22uu/E2yBEOp5gBKjD6B6
   2yZ5GCh8EifD8F/DoCZEF3GMAzQojFSrPVClmLxUvM7UMxAmMehGy3HrZ
   GiMybYaAFj8hX5a2SrkW390RrgFigAMGaI+2rNBh9y2zWYqEL9URTP5UK
   p3VsphAx0dc2yhPGWi0u1w0x1AvPXIvYZ7A8bK1+6OUDthzh2Nh0/jYci
   Q==;
X-CSE-ConnectionGUID: EjEhhMEbRAWeQhLFE3QFKQ==
X-CSE-MsgGUID: aRypmBfrS/iJOL/NH5NeFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="60081441"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="60081441"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 16:59:45 -0700
X-CSE-ConnectionGUID: /IkE6EQHTkGrFH93aRJ74Q==
X-CSE-MsgGUID: e7KfOohOSleVbMkafwoK3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="162140866"
Received: from yzhou16-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.16])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 16:59:44 -0700
Date: Fri, 16 May 2025 16:59:44 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.15 v3 01/16] x86,nospec: Simplify {JMP,CALL}_NOSPEC
Message-ID: <20250516-its-5-15-v3-1-16fcdaaea544@linux.intel.com>
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



