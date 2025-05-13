Return-Path: <stable+bounces-144079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ED4AB49C5
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 04:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D79B3BCCB7
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 02:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569111D47B4;
	Tue, 13 May 2025 02:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSVu8hlC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60721C683
	for <stable@vger.kernel.org>; Tue, 13 May 2025 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105092; cv=none; b=akACcrNM5t7C8ADKvkrznFaPojqQYtR1KigPOFxOV5vwJ97g19phN3ShJF8m3owncHptQjfwD+R/tPZNiTCXt+QCiZ/YX8YZCZ2mqxOX4tYnJmrNHVkgasokIbV8KhVJOKEWjONcZkUe+NHK6J8n3pMMysMRm/jlPVeX/E4o0W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105092; c=relaxed/simple;
	bh=O1AoQkdhKpQj26YUpFFNc4eYyaMVIPdxPdw0UQAVoKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqUKkn6Tro5G73/RIlH/zb95niU4Uj7zthv1x+TuUZ+lFDXONbBTWYJAbrFwgg5/LR6jd+j/hh7+vEBEmEZeVjAagy2nTHrMNhHXBc64PkV3WYMvX2aW7fVebpshrkJ2XyAGhWcEfriKJ2+jR7w+Fe+uSDqFOgPPGww6pZuUWwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSVu8hlC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747105090; x=1778641090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O1AoQkdhKpQj26YUpFFNc4eYyaMVIPdxPdw0UQAVoKw=;
  b=PSVu8hlCug7EcMSc2Jxq5EPiSMlU28TS4Rx8nhpdTPS9R2IOYcFpfjLG
   S0N0fwPzAbwLaIFM0t0Xi/wPEyVXteqtTiXrg0YDYOVTeUGgb3/kO0Egf
   VGQO2WVGkiFt9G+bui6DG1ZHMa72lwxuyeCIpDCsKvMs0sjRrH/XJEifr
   J/SrLn4OeNxR/eB8V2x1M++PHMs5vtSmNroAKyv5d3YoO/qkd3qM8y9vH
   T5FiVwSy9Y8UbfiYCkTwVpiW5aO6qaVf+3gjoRAWTM1EZ5ngbP79kkSDc
   0ZGIuATrILiz0gUtmdaeRqPQ1qjE7k0YGZJSyaBTipXS0yDdl77aClCr3
   w==;
X-CSE-ConnectionGUID: Es+Jbmo1RMic7a5b58d8BQ==
X-CSE-MsgGUID: R2KwwUxYSm26p8gPYuY5tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48825724"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="48825724"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:58:10 -0700
X-CSE-ConnectionGUID: HKR/juYQTIegagbe5djA/g==
X-CSE-MsgGUID: r522bEw/Ry2GmYrDVqr3Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="137278443"
Received: from lvelazqu-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.9])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:58:10 -0700
Date: Mon, 12 May 2025 19:58:09 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.15 02/14] x86/speculation: Simplify and make CALL_NOSPEC
 consistent
Message-ID: <20250512-its-5-15-v1-2-6a536223434d@linux.intel.com>
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



