Return-Path: <stable+bounces-144644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96F5ABA6D3
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 02:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8B14E686C
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 00:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE27280CFC;
	Sat, 17 May 2025 00:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="II7ftFPd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0163C23644F
	for <stable@vger.kernel.org>; Sat, 17 May 2025 00:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440002; cv=none; b=VDxFuT42ayZg9p9FDIupvnVcHaAgh/epB1RRr4+HRU5lhmOmxm3H1F9sNbsQ1oSbi+hQocu/fLErtcdeP07WT0v8QWPtld9O9pg/3CzsluzAXKOKC0MstI0wt0svQoboxwmzyhKCkJmaiCTc710T4vGjuD4XzEKskYlPWIiA5WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440002; c=relaxed/simple;
	bh=O1AoQkdhKpQj26YUpFFNc4eYyaMVIPdxPdw0UQAVoKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bevZ3qnDvB3xkCJ6vineBsRGtIXNNPBqE3Gq5zYG6SUVPBQer4mc8Nxp87oufBYqhkOw+eoAtRLJObao+InrPKZKgDELqxcsYrqMMfyitOSzN7wDVInd6gUqhTkpncWmu0wXYCLk2hBzVMcvwoZFzE/YT7Ms2YMg2gLm5hoKuYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=II7ftFPd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747440001; x=1778976001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O1AoQkdhKpQj26YUpFFNc4eYyaMVIPdxPdw0UQAVoKw=;
  b=II7ftFPdZfPAmf0qeazevevJkDwJb3U9me2q3dgjJq5n7ZxXrgBRR5hC
   /2wMcFhwqr4bTPfaykMc++Kh8/+0e1+1bV6wzmqNnAm29T56juSc/qU1M
   b4MYXpQnv2qm6akz6g/P73/sFrjIyVs6Cg7QJwFdz4ovXa0VoAVIOy58c
   bSshFAiBj3VDWO20+0jo1mfdcKEpZcoyIa8l8H4I/rt1T/O3ocUowkC3v
   sCugrEt6DT/icvc7i42KhFlavJG8AH77JZwGYpmvfGC0erT3NZjopQSAt
   fXDjKX1ccyjiaN3Nc4u2gCLmBJc/XojXqD2RHV9UhcfmMY4lyiQooT4R8
   w==;
X-CSE-ConnectionGUID: c7tPvWCfTvqA7JV7DzFdAw==
X-CSE-MsgGUID: Me8j1ThPTc6RDScj8zURQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49298325"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="49298325"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:00:00 -0700
X-CSE-ConnectionGUID: 4sC+5efnRjigb7U5shKGMw==
X-CSE-MsgGUID: CAFybGDzQXCIOWBvR/M25Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="142820084"
Received: from yzhou16-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.16])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:00:00 -0700
Date: Fri, 16 May 2025 16:59:59 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.15 v3 02/16] x86/speculation: Simplify and make CALL_NOSPEC
 consistent
Message-ID: <20250516-its-5-15-v3-2-16fcdaaea544@linux.intel.com>
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

commit cfceff8526a426948b53445c02bcb98453c7330d upstream.

CALL_NOSPEC macro is used to generate Spectre-v2 mitigation friendly
indirect branches. At compile time the macro defaults to indirect branch,
and at runtime those can be patched to thunk based mitigations.

This approach is opposite of what is done for the rest of the kernel, where
the compile time default is to replace indirect calls with retpoline thunk
calls.

Make CALL_NOSPEC consistent with the rest of the kernel, default to
retpoline thunk at compile time when CONFIG_RETPOLINE is
enabled.

  [ pawan: s/CONFIG_MITIGATION_RETPOLINE/CONFIG_RETPOLINE/ ]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250228-call-nospec-v3-1-96599fed0f33@linux.intel.com
---
 arch/x86/include/asm/nospec-branch.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 1a825dca11a71c72701882f067d555df8fd1f8e1..031a38366b0dd1e35a82e49d6b18147ada7dd80c 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -285,16 +285,11 @@ extern retpoline_thunk_t __x86_indirect_thunk_array[];
  * Inline asm uses the %V modifier which is only in newer GCC
  * which is ensured when CONFIG_RETPOLINE is defined.
  */
-# define CALL_NOSPEC						\
-	ALTERNATIVE_2(						\
-	ANNOTATE_RETPOLINE_SAFE					\
-	"call *%[thunk_target]\n",				\
-	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
-	X86_FEATURE_RETPOLINE,					\
-	"lfence;\n"						\
-	ANNOTATE_RETPOLINE_SAFE					\
-	"call *%[thunk_target]\n",				\
-	X86_FEATURE_RETPOLINE_LFENCE)
+#ifdef CONFIG_RETPOLINE
+#define CALL_NOSPEC	"call __x86_indirect_thunk_%V[thunk_target]\n"
+#else
+#define CALL_NOSPEC	"call *%[thunk_target]\n"
+#endif
 
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 

-- 
2.34.1



