Return-Path: <stable+bounces-152332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4E5AD4303
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 21:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4930B3A424F
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 19:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401B626462E;
	Tue, 10 Jun 2025 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iA/TKtMG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E3923183E
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584547; cv=none; b=BDBtYUg/FmR4nXo9s7IzpArCWwtj+ir0citi0tvaOKBgHh/4ukGkJhbtX2WgNiSDM2pOY8x4n2XZr+Gil/ord3mh6ql+JLM/QG5Q/hcNwwXr0k36Q5D6zBfKcePvAkFLoFu5PZ6Y0ooV8uV+teaQe9ce7T6Xmjs/4o0FN9J8wMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584547; c=relaxed/simple;
	bh=zVP0DTOTLgwvPnLe0QJv1NibHrrHbtbqmYu8G13pwYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=behUHmaa4mKp6FYPcAkklckanh8g07uMM/yjmlIyQjIFgXbPb055B8qNPEsXdurjEC9xBT8BRvuj6uKJGWeTtwikFZSm3q3bGd2ompyN1492U4oKQ8a7429/r5dO8Ec+pFiPuNyd6+nZ3AU+jdRJAKzv4BXq2QCpjdVbMQ5n72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iA/TKtMG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749584546; x=1781120546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zVP0DTOTLgwvPnLe0QJv1NibHrrHbtbqmYu8G13pwYE=;
  b=iA/TKtMG0/Fjcx/HibWSYRD0RGx672Qp8iEIktJK6eX6/nz8aW4ryv/4
   rjzVKqx5xtXhfnC8RiMKgGX/O9gcsy5R0+ALoLRsako86U3oTfvzploHH
   q0iaVajk3Y9CDLVui69vrYEINR6b6HlCtE/82YIO6+wKMav+ZLGJOxYFc
   0cfaYdrJGSb/RrTvcageXKKUTqo/PAtewKxkKCRIa8Vm1zOsGwLz3CG/4
   WwSuLW35ZKBYOnm6am8jDCgeexFxlAdg06SeGhIAtGgmMOjLv6iod8KAE
   +tvJTx1GGd1b8+5MuE06ukHlPMuFZQlf9rpjnFYGyo5zZCB1EvMQulRlk
   A==;
X-CSE-ConnectionGUID: b8qAVMo8TceOLTzW2TwXKQ==
X-CSE-MsgGUID: ZMK3BvIWQHCFBpnYRkpGOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51569236"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51569236"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:42:26 -0700
X-CSE-ConnectionGUID: xPRBPAw0R02jUkR/MF0Pkw==
X-CSE-MsgGUID: qxqjDQEnSzSkuJ7LnhXJkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="177869509"
Received: from bdahal-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:42:25 -0700
Date: Tue, 10 Jun 2025 12:42:24 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [RFC PATCH 5.10 08/16] x86/alternatives: Remove faulty optimization
Message-ID: <20250610-its-5-10-v1-8-64f0ae98c98d@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/alternative.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9de566a77a8e6b9ca2610edda731cd2f089e6b0b..3102e7cf6a48375a2216303b0e1769532ed37270 100644
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
2.34.1



