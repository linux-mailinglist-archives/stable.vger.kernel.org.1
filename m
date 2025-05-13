Return-Path: <stable+bounces-144078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F087AB49C4
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 04:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F6F7AF67C
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 02:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1831D7E52;
	Tue, 13 May 2025 02:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBgMHBW0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB771C683
	for <stable@vger.kernel.org>; Tue, 13 May 2025 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105077; cv=none; b=ZnHqYqcgIYTAP6cshggyjbCTevzrbBjuShwt+imICQllwNGmmoqVLHUFwmGmmufF6QJ3G7Zz50ZvQs8Bu2Ky6ej/idQ1t6yHrE1udyKrUfC0IVWHk5FJIIrafg5qcRnByH8IKLcWqa6KB/L2Rf+UQjva+p5nyjWBJ4r8SfycNbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105077; c=relaxed/simple;
	bh=ES+G86cDYjYQp9Y3Zxggaa2CJObhOkb2cvDRv7PYTmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bucCM2T9uIEEU3bs4kHbtZbAEHsgH5cQmqfRHbb3VnhJEOwrekUh6xvx+geOP9W0+6YD5lNKVeniAhLfIvXEf/2oEsaHBcXuqzaCEOTY3Q68/ovdrqPLDt/cVVa6Wb3Dfl7gKQCaSGmnHAZ6KlM/GgCRbyMeZjt5+zdPo+X29z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBgMHBW0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747105075; x=1778641075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ES+G86cDYjYQp9Y3Zxggaa2CJObhOkb2cvDRv7PYTmE=;
  b=jBgMHBW0yND+Tc/R1FYDhDIZu36hEtz+P+4xSGY3lTKAhUBwk5DyEtaY
   IPpuPmlKdR28WGJO2dSjf6r8HvnaXnNaPs53ks6Xo4vu2of4BEFx41fUV
   nG/hwI2PGnZKtV4zso38vYwd/bCeJtzluhc+0qrhRDLjNnkR2Rmzz1Jqu
   g1q5Wux+S4B2559R9umzrvNb/f/p4MFq+kQivwTSmwdU6Lz6QdCLTwfM6
   d8l+R+b+38Crh3V8zSn8tEQO0izZeRAa1yHqBK/GA1xFY5rsp7uwax+ir
   GWHjg5O03TEBTxt3QLcNP7UM2aBIJkPXAreM1olj7KIOhgRPRcZW/mCEA
   Q==;
X-CSE-ConnectionGUID: Ondq/YVpQcC2m8sEm8dw+w==
X-CSE-MsgGUID: /tOc4caXSReJHfKqlkDvAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48825712"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="48825712"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:57:54 -0700
X-CSE-ConnectionGUID: +y9JScCSSdW8Ih5dU1/+9w==
X-CSE-MsgGUID: ZLXbqpkHT7CsOWpC+plvTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="137278418"
Received: from lvelazqu-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.9])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:57:54 -0700
Date: Mon, 12 May 2025 19:57:54 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.15 01/14] x86,nospec: Simplify {JMP,CALL}_NOSPEC
Message-ID: <20250512-its-5-15-v1-1-6a536223434d@linux.intel.com>
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

From: Peter Zijlstra <peterz@infradead.org>

Have {JMP,CALL}_NOSPEC generate the same code GCC does for indirect
calls and rely on the objtool retpoline patching infrastructure.

There's no reason these should be alternatives while the vast bulk of
compiler generated retpolines are not.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
(cherry picked from commit 09d09531a51a24635bc3331f56d92ee7092f5516)
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



