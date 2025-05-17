Return-Path: <stable+bounces-144652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAC0ABA6DD
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 02:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6234C00BE
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 00:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ED41FC8;
	Sat, 17 May 2025 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtOU0nK1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9191D136E
	for <stable@vger.kernel.org>; Sat, 17 May 2025 00:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440110; cv=none; b=BvlCRbn8Yip85oEsA4f61K94yBZFmdp/PaTdcJKKQ/9SfXAY/S2ow4boVzjcz7PZyOJegnnOs9dCSeAYrAc4Yo6dTbT0P11IokBzda2A9Ya9Aif2tTdaKfNtYirmto+/v5qqeM7491vidl/I1OjeZrdKD11JwU6ToUe0Kz5oxmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440110; c=relaxed/simple;
	bh=iid/FYx0WFroZqNgtWUXU+cdIMczXORXi/sthvSeLx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD/Eeu4A2OdCQC/dbWmmAlIxYDS88iuN+3GmzTaZcVvI0oJ81iQrnfZcwhEjsy3HmzIPgYx2uxRS91LvIoj5zK3XQPXefj1n1qn3c5EvP4x+emN4I7ZJO1KUrfAVo5a8ZIXjE5kMhv9QJgNNXs3AkkMizKmn8IeSVKNjrjMnSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtOU0nK1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747440109; x=1778976109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iid/FYx0WFroZqNgtWUXU+cdIMczXORXi/sthvSeLx4=;
  b=PtOU0nK1y6F5jGrCGj0k14+Zc7dFKccf4PasY7xSj0dlCk+yq1DNRY1X
   R0zxAdPqVq0NYMpHh+NCCXYqekXinHMNQLJZ2ob0zqR0QBi+okarCNb37
   IbCrRX2eGRgbj+/PnXAK3coA5b+xFHz+dz/Pt7xg0ijF0EmLXA1laIH9w
   Ulb2yQLaRCSY9fbhxbv86qMT25eaNWSQ7+v//r7TtQ+3TNVyqM4ZO/Zcu
   y2l+HroEP4EjM+827ZxFezsxNyD2lAXJR+VLSmBtDdMkUup/Zao5wtd4s
   PxvH2E4RYnGyqTTC5AN9CTWFOM8ZHcPal194wH4E2MJpBRCWCrDbuXBJU
   g==;
X-CSE-ConnectionGUID: 29ONmyrxTVirJRPpgppe0A==
X-CSE-MsgGUID: 0Sxqn/0eRwyg0Apkt/43qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49122612"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="49122612"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:01:48 -0700
X-CSE-ConnectionGUID: SB7w86ZUS/a4bHIbJGPGJQ==
X-CSE-MsgGUID: GenZsT7PR6eil/pl9cRT3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="143808520"
Received: from yzhou16-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.16])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:01:48 -0700
Date: Fri, 16 May 2025 17:01:47 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 5.15 v3 09/16] x86/alternatives: Remove faulty optimization
Message-ID: <20250516-its-5-15-v3-9-16fcdaaea544@linux.intel.com>
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



