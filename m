Return-Path: <stable+bounces-144315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDDFAB62B6
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569844637F7
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6CC1E5B68;
	Wed, 14 May 2025 06:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBRwDrph"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E05F433A8
	for <stable@vger.kernel.org>; Wed, 14 May 2025 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202833; cv=none; b=lJjak/zMdX9jgAzyO1G0Gwa6KJ5MIfs2wDEwttbzR86/X36EGjO9mpWyqssNx2hlsbMhrGdLX5pzYUvR7+ttSnu1IAIrcQp39QTCDdJ1SePgM+RTqb3ieJYzy+ySr9ediWj52RiuH6DfJDA7PvbjwmeSvg7EuZrkO/3ThMly/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202833; c=relaxed/simple;
	bh=O1AoQkdhKpQj26YUpFFNc4eYyaMVIPdxPdw0UQAVoKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqIK4YwZGcgWC9zYvDdKNlIkh+UHgO6uxvxQssdc/EI6WiQNtLQHsIpS9GiXSBP7rseIVgZeBP3uvAtVm5ZubpbTE+a82oppkDrswDoMmE/Uz+C/s61YhAcpbITUvWc+yGZvzEOz2lU29yG4MM5iD0bkvW+2KDg7QFuxDe8J2vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBRwDrph; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747202831; x=1778738831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O1AoQkdhKpQj26YUpFFNc4eYyaMVIPdxPdw0UQAVoKw=;
  b=CBRwDrphl0wiGbS5uM8LYt7RQXazW9404fk8vTOwNuoibA/O+eTTPAlu
   L+NjB3aPEwH1RuBNJWybAxuKbFEus3L8AnuKqnO4EZDB106EI2yyBrvh5
   aBdOrqmG2GPwhNVbm5G4izzJqk/ab/FSmoSHQEwZ1giA02REftfTe9VhZ
   C2qHJuOxMi3KonPus7hQssz6U4FqONHgl6lhGf7nETbs4p1Fwx07j3IEj
   dUeM1hOlbTluBgaX1mXtQHGvjoDpTh7ytXE9r/0TJJA1DWZ/pDzP+6TNj
   o+o3MKKXgG0GFSe9XGOTZt9BoYkLwn2SJErnZmOCD5Mt/GYUXuI8SivHU
   A==;
X-CSE-ConnectionGUID: kyObDPBNQfWG5+bG/gcPVg==
X-CSE-MsgGUID: DeJB1x19T0OHNTacJuk1Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="60419938"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="60419938"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:07:11 -0700
X-CSE-ConnectionGUID: c51FyUcJSJyDpIVFYMV1TQ==
X-CSE-MsgGUID: YrkLCW3mQJSx+e41NmWvrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="137658645"
Received: from rshah-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.11])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:07:11 -0700
Date: Tue, 13 May 2025 23:07:10 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.15 v2 02/14] x86/speculation: Simplify and make CALL_NOSPEC
 consistent
Message-ID: <20250513-its-5-15-v2-2-90690efdc7e0@linux.intel.com>
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



