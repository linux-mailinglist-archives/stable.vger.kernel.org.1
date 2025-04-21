Return-Path: <stable+bounces-134878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FBAA956B8
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 21:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17626174265
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 19:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012F11EF091;
	Mon, 21 Apr 2025 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4Jh238l"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308AB1E9B1A;
	Mon, 21 Apr 2025 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745263327; cv=none; b=pw6x9aa7qpHaR/7JOdcxZ7QhjUpABqoZkoXnjufl+tkjfxLvrAQwjKTAxMFNhMKillPW2zslWz+9M0hEpkc1W6olfZXOZ+vRf8hfmd5sMgYuq5asp4Qg9RxBzXtkCicAOV3ai7+3w3BGnHgs+42EwrCZsPR93qQS7kLdvh2z10U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745263327; c=relaxed/simple;
	bh=NGCt/qFOAddy/Rt8qNrQ8XyhdO6JLq5G3d3sBCsFn30=;
	h=Subject:To:Cc:From:Date:Message-Id; b=SQ+ke5QmMVQjldCsRTQEnV7ljGlm1OGUZqkOYXVg46WB4xbT1r6DmTA0woAyzu58f5gjrUWYxx9bUTiEs0xqEm27H4tyPLOlcUaxrv0kVWausJVNzrOuroVGAfS8+g5FdT7IgM+tYDIeqWdWWs3JcKiDHCBo9xcZqBvudZgBxFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4Jh238l; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745263326; x=1776799326;
  h=subject:to:cc:from:date:message-id;
  bh=NGCt/qFOAddy/Rt8qNrQ8XyhdO6JLq5G3d3sBCsFn30=;
  b=N4Jh238ldtm9Ep2EUm+O0FuDw465xinUagHi63Cg51eFSwWlxjGuwgCA
   ShikNljj7hqJfs/lCVG12dw8bMuWtkJlvPnefTuTQ1ZwcleFilJOGyrkK
   TeCpAvUep56xHIWaRVcmi/tIfoQsnulS4FimPINmZLbgYFXQm4acJW6op
   T1afljhWhXTI3FqR+vnBFxIUysSweVVCIfn+r+D+VBStKTDgivmJQP6ZD
   m8mQypUDsiRtyakrbliywvGMw3nXOZ7iiwpsLkefi+rHS9bBAOX5mnsKR
   q/GSQzRueHCw4vgRnu+Ev7Xird7nQg2bNaJkmDZ5mnxkpD8HkmW++24iL
   Q==;
X-CSE-ConnectionGUID: xqu9rPUcQ5OG4H7EhVh91Q==
X-CSE-MsgGUID: kkgnDOUWQwKXABnyJqW7/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="49468973"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="49468973"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 12:22:05 -0700
X-CSE-ConnectionGUID: /je7+TMVQXK1po4JC+2KNQ==
X-CSE-MsgGUID: WdZ6EfUeSZi2Vd1V5XfB1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="136951549"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa005.jf.intel.com with ESMTP; 21 Apr 2025 12:22:05 -0700
Subject: [PATCH] Handle Ice Lake MONITOR erratum
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, andrew.cooper3@citrix.com, Dave Hansen <dave.hansen@linux.intel.com>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, Rafael J. Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, stable@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Mon, 21 Apr 2025 12:22:05 -0700
Message-Id: <20250421192205.7CC1A7D9@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Andrew Cooper reported some boot issues on Ice Lake servers when
running Xen that he tracked down to MWAIT not waking up. Do the safe
thing and consider them buggy since there's a published erratum.
Note: I've seen no reports of this occurring on Linux.

Add Ice Lake servers to the list of shaky MONITOR implementations with
no workaround available. Also, before the if() gets too unwieldy, move
it over to a x86_cpu_id array. Additionally, add a comment to the
X86_BUG_MONITOR consumption site to make it clear how and why affected
CPUs get IPIs to wake them up.

There is no equivalent erratum for the "Xeon D" Ice Lakes so
INTEL_ICELAKE_D is not affected.

The erratum is called ICX143 in the "3rd Gen Intel Xeon Scalable
Processors, Codename Ice Lake Specification Update". It is Intel
document 637780, currently available here:

	https://cdrdv2.intel.com/v1/dl/getContent/637780

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org

---

 b/arch/x86/include/asm/mwait.h |    3 +++
 b/arch/x86/kernel/cpu/intel.c  |   17 ++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff -puN arch/x86/kernel/cpu/intel.c~ICX-MONITOR-bug arch/x86/kernel/cpu/intel.c
--- a/arch/x86/kernel/cpu/intel.c~ICX-MONITOR-bug	2025-04-18 13:54:46.022590596 -0700
+++ b/arch/x86/kernel/cpu/intel.c	2025-04-18 15:15:19.374365069 -0700
@@ -513,6 +513,19 @@ static void init_intel_misc_features(str
 }
 
 /*
+ * These CPUs have buggy MWAIT/MONITOR implementations that
+ * usually manifest as hangs or stalls at boot.
+ */
+#define MWAIT_VFM(_vfm)	\
+	X86_MATCH_VFM_FEATURE(_vfm, X86_FEATURE_MWAIT, 0)
+static const struct x86_cpu_id monitor_bug_list[] = {
+	MWAIT_VFM(INTEL_ATOM_GOLDMONT),
+	MWAIT_VFM(INTEL_LUNARLAKE_M),
+	MWAIT_VFM(INTEL_ICELAKE_X),	/* Erratum ICX143 */
+	{},
+};
+
+/*
  * This is a list of Intel CPUs that are known to suffer from downclocking when
  * ZMM registers (512-bit vectors) are used.  On these CPUs, when the kernel
  * executes SIMD-optimized code such as cryptography functions or CRCs, it
@@ -565,9 +578,7 @@ static void init_intel(struct cpuinfo_x8
 	     c->x86_vfm == INTEL_WESTMERE_EX))
 		set_cpu_bug(c, X86_BUG_CLFLUSH_MONITOR);
 
-	if (boot_cpu_has(X86_FEATURE_MWAIT) &&
-	    (c->x86_vfm == INTEL_ATOM_GOLDMONT ||
-	     c->x86_vfm == INTEL_LUNARLAKE_M))
+	if (x86_match_cpu(monitor_bug_list))
 		set_cpu_bug(c, X86_BUG_MONITOR);
 
 #ifdef CONFIG_X86_64
diff -puN arch/x86/include/asm/mwait.h~ICX-MONITOR-bug arch/x86/include/asm/mwait.h
--- a/arch/x86/include/asm/mwait.h~ICX-MONITOR-bug	2025-04-18 15:17:18.353749634 -0700
+++ b/arch/x86/include/asm/mwait.h	2025-04-18 15:20:06.037927656 -0700
@@ -110,6 +110,9 @@ static __always_inline void __sti_mwait(
  * through MWAIT. Whenever someone changes need_resched, we would be woken
  * up from MWAIT (without an IPI).
  *
+ * Buggy (X86_BUG_MONITOR) CPUs will never set the polling bit and will
+ * always be sent IPIs.
+ *
  * New with Core Duo processors, MWAIT can take some hints based on CPU
  * capability.
  */
_

