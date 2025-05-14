Return-Path: <stable+bounces-144311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE87FAB6260
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 07:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4304416DA90
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 05:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE741519BC;
	Wed, 14 May 2025 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="alS02xYz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338501CAB3
	for <stable@vger.kernel.org>; Wed, 14 May 2025 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747200975; cv=none; b=Xvp/Hz0qKiM5LXsW+ItAu6Ob/oPFAfpZ2sVLBJpKOxA3RoYpHnBg+ymAcG6X+rR59W6o39osMuNzEtSxcHPzt26OeR12+r7v9MDkgT6ZcS3T2go3xgcqmRHXjj/R09r2VPkChNWsiBsfMD8gIhr0t5RfdeJRUx6j1067ZwLH3cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747200975; c=relaxed/simple;
	bh=KS+lM/d/2LOpM529S2pWuJ4Cb7OEtKYDK6iKIiKNsSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdUlnVTPbryDUWI4FEoIPIrJt2+fJyUMXSTmH9u3rNRUHsKYxqqdNQgigda3sUuuVIUF8q0txmkVWwuvpsGEUY1SgRqjJWvpclag5+HYBKlAqZnhpzptf/uI0R4OuTbhOesOPzUqNPcs56crOv6cKyOZdlaWL1KKZPrPhnspQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=alS02xYz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747200974; x=1778736974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KS+lM/d/2LOpM529S2pWuJ4Cb7OEtKYDK6iKIiKNsSs=;
  b=alS02xYzTLibALJONAEz2e9YOUuh8Sze2g3aFCGEdGUCz5kD+rRKF8tD
   m1ptKoUTK1sScGSJjWoE6QKpwv5KPdwXCj514PQlV4IiScTOuibMySVNg
   mo6b4LVmAFMnPXD4z9INX8SJqj3mdixC8rfiXq0xXoFAw2e2r8HODfKRC
   iZd/8BNhC3mWYXnhS3kC8Zn7oJMKkImtLB+3Ze5TpAwWVHDsztGHEdD/s
   xC7EqYfnzo/NZkbuMXnE4TPIDKpdvBB67PS9gX4zG72m3XLfKXRvMQkRL
   H3I31nH7FZ6r854T92W1q8SEv5QZUZPvDLoYGH/VtDnfKYjSpjjWkJJJ3
   g==;
X-CSE-ConnectionGUID: 8LYTQuMhQZq9Crv6quZrkw==
X-CSE-MsgGUID: jcWNjV09TGS1rPOBGOHqFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="59738695"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="59738695"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 22:36:13 -0700
X-CSE-ConnectionGUID: emfOQWFrTG+aJ4Bjw4ftmA==
X-CSE-MsgGUID: jhwZKybsScy82LDd86YURw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="138359660"
Received: from kandrew-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.10])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 22:36:13 -0700
Date: Tue, 13 May 2025 22:36:12 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 6.1 2/3] x86/alternatives: Remove faulty optimization
Message-ID: <20250513-its-fixes-6-1-v1-2-757b4ab02c79@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250513-its-fixes-6-1-v1-0-757b4ab02c79@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513-its-fixes-6-1-v1-0-757b4ab02c79@linux.intel.com>

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
index dfd5490df0af9e55d1a6ab185ad7cb03bdda4a91..023899e9ebd16ba223a1de91da9bcb43666788f9 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -787,14 +787,6 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
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



