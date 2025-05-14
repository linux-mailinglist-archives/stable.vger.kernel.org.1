Return-Path: <stable+bounces-144322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FAFAB62C0
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19E019E025D
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BFC1EFFAC;
	Wed, 14 May 2025 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUUChILb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2041E5B68
	for <stable@vger.kernel.org>; Wed, 14 May 2025 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202941; cv=none; b=apye2h2j5oVaq6Y6MLh/W7cfqloCyFZvhQn06pxSBMAJrE0dNX0FKW6g07x5T3LWIx2mwn1fi/ClGPuuW/x6oF5Xo+l6uQ913Lo0vpRZWvaICRoGErQJryoGed7QnnmDK/VgcXLfnrp6YJyvFPobMJoSfMXYMsJD65fg6u9/fWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202941; c=relaxed/simple;
	bh=iid/FYx0WFroZqNgtWUXU+cdIMczXORXi/sthvSeLx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxbcuSOYFqxpY8mqyxE6JcvKX4jN3dohI7DAgplcwiaVgpTCF8+MLqlGYyd0H0VAmQZajwCNct2OVQvgp7hglv437UEhti2Aab70hvtW4PCCuD5uft/c80B/QbKuhqFJRNgAsy4TFlRu+VcWXCKOp1nIjDI4yLi6FD/mHoTx4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUUChILb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747202940; x=1778738940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iid/FYx0WFroZqNgtWUXU+cdIMczXORXi/sthvSeLx4=;
  b=JUUChILbUoLKDCHsra1ZFcnh0hRF2uYXtRiesC3E34m+Rzgm+lQYUldi
   kuqtHu4xziEPXmh5FT7UL0V1TZwDR2pWUkG//9/npkoTpbRNEkE7PKuig
   sxlzp9uEdqzE8u3aqGQ5e7nsi7LuYQQHRzuqWnSg6WiWbtyNjFOFxYB6L
   I+XUbPbV0DCsXkrepNkleUbrfsXIJXst82ZnwJHVL/h+5OrLZClpzdgN4
   oeVGP1jiNRfwL30cCjY36x4QnGDjKqcpDlXZ3LYMZK6/b6bUbOMTBfxTg
   yfQiMcdk2Xjb0QFTuTqYnz9Mmz0T/276BodcFLwpNwiEbQ/hIEruYmBPR
   A==;
X-CSE-ConnectionGUID: xudqjeaeSLqDuc1Ravsg2g==
X-CSE-MsgGUID: /lU8xnzvTJaKTtqE8iQ3ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="48190838"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="48190838"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:08:59 -0700
X-CSE-ConnectionGUID: qZ8bZutGQPq8muYfWFkYMg==
X-CSE-MsgGUID: URQR7ChpRsOs6Y45iDL7Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="137982227"
Received: from rshah-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.11])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:08:58 -0700
Date: Tue, 13 May 2025 23:08:58 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.15 v2 09/14] x86/alternatives: Remove faulty optimization
Message-ID: <20250513-its-5-15-v2-9-90690efdc7e0@linux.intel.com>
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
index 26841dbaed76324df3c22b41c996bc81dab4ca17..5951c77723787401f8ddb470fdcda76a488ca524 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -638,14 +638,6 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
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



