Return-Path: <stable+bounces-154609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F219ADE031
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 02:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BBD3AD0C7
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 00:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24771208A7;
	Wed, 18 Jun 2025 00:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dlCF3HG2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D26F29A5
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 00:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750207570; cv=none; b=etbRs1BPzR9z/au9ouJ39SMj7Rh+ecq5iZUz3kWaa2DOiPlNCKt0WnDwyjGAjAZej1VZIHlW6OIJgKraI6SSiUFijKPJrRIsPrqQKvmtse2aShYdgrjh/bbhmRk8EJ6oFYdRhTI4VQevwotC9FekZ+ApeTg6Gp74sbr0xzweS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750207570; c=relaxed/simple;
	bh=GjuSUH45ijiyLhCxG0uOpxtj2D0+ftbUL8WYIg09YmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si2US83TB/YKQFVHld12lIEMP9bUyB2WasXWArgG8exPFNX8/RpiE+WDO3YyW+xF/Y8Vf8M9u+8VRQRLScKQUcXJZ//00sdCU9iPTYnUY424xzah3gj9kjNc24OQR+eBnUmMYhmNKJN5F4Nypc0Hn7mCMt9mxvGRpX8NfBZNAVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dlCF3HG2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750207570; x=1781743570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GjuSUH45ijiyLhCxG0uOpxtj2D0+ftbUL8WYIg09YmM=;
  b=dlCF3HG2xAL/DVklnHgO+wYMbTASNuetEIuJduC0taxjVkTC+SMG9y7D
   dRvhuRlpPOFNalo9gESm5SZ0X6PfJjnkDu7pD3vasi9My0WIE2JxBU0BR
   26vQ2NBJSHMb2eDjhh/rAe+4IkXwEEYdM3DnwlLY+v/+CQ8XzqbZvzgfS
   7u9LkDjAe4E5jP0wa78aefOocZAqU4s9GY/YTF8MHRDY0CM0lmsIMFeLN
   tbEEqLR+dSol6f3UUiJ+p7XDijANyIYar1gXTnCrYBIJ14YYaSv2my/dd
   0w5711jXmE6sd5VVQeTdStqHUv7B72LzmqiMF+OLqAldVzPut954joAMj
   Q==;
X-CSE-ConnectionGUID: vLYffwDNQE+2nbq1l07ttQ==
X-CSE-MsgGUID: VdTQwPXEQ669mst1LDoY0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="69856624"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="69856624"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:46:09 -0700
X-CSE-ConnectionGUID: ZoQnobWGSISldwLD4vjk1A==
X-CSE-MsgGUID: Pxl/YK1JR8Sizc3mQLg97g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="179984752"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:46:09 -0700
Date: Tue, 17 Jun 2025 17:46:08 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.10 v2 08/16] x86/alternatives: Remove faulty optimization
Message-ID: <20250617-its-5-10-v2-8-3e925a1512a1@linux.intel.com>
X-Mailer: b4 0.15-dev-c81fc
References: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>

From: Josh Poimboeuf <jpoimboe@kernel.org>

commit 4ba89dd6ddeca2a733bdaed7c9a5cbe4e19d9124 upstream.

The following commit

  095b8303f383 ("x86/alternative: Make custom return thunk unconditional")

made '__x86_return_thunk' a placeholder value.  All code setting
X86_FEATURE_RETHUNK also changes the value of 'x86_return_thunk'.  So
the optimization at the beginning of apply_returns() is dead code.

Also, before the above-mentioned commit, the optimization actually had a
bug It bypassed __static_call_fixup(), causing some raw returns to
remain unpatched in static call trampolines.  Thus the 'Fixes' tag.

Fixes: d2408e043e72 ("x86/alternative: Optimize returns patching")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/16d19d2249d4485d8380fb215ffaae81e6b8119e.1693889988.git.jpoimboe@kernel.org
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/alternative.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9de566a77a8e..3102e7cf6a48 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -793,14 +793,6 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 {
 	s32 *s;
 
-	/*
-	 * Do not patch out the default return thunks if those needed are the
-	 * ones generated by the compiler.
-	 */
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK) &&
-	    (x86_return_thunk == __x86_return_thunk))
-		return;
-
 	for (s = start; s < end; s++) {
 		void *dest = NULL, *addr = (void *)s + *s;
 		struct insn insn;

-- 
2.43.0



