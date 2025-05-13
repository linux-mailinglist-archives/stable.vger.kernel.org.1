Return-Path: <stable+bounces-144087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC1AAB49CE
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 04:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6347AB17B
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 02:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE5E1D63EE;
	Tue, 13 May 2025 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IW5lvI8V"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905E21D47B4
	for <stable@vger.kernel.org>; Tue, 13 May 2025 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105190; cv=none; b=OsKV7fgd32LHjGQIPQCgs7ycoehWDy5mygegd/pCDe9Uzs+jznaTIfkTGmWetFc8O0bH2JgxYYojQ4DBFeDkH2Sz/5/BD6TRHsBvOjrmQ7mlVn2wDISb1MQjTgLldB7X0JHibOPBCP8Y37nTXwZatgYaW8YuwhpalfgqRuetf7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105190; c=relaxed/simple;
	bh=lM4tZzxGyQzP7oairMCUYnn3vNKj7tbU4Xi7CzY8RxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWDmPUxFS52PIIxFHWjibicTYek/QFgMtLWTooVJsXxrLyHdO349iGOXjoE8FjNQdRq2oj+lGYkf01EkR6bAMHt1x9dc0vF/FpluOzAbFfNoqcWt1tHQMS8ZyF0dnqWgjOfjPUsQeVHVuGvExhIFAjbYvWieyna27/OEmh6XPmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IW5lvI8V; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747105188; x=1778641188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lM4tZzxGyQzP7oairMCUYnn3vNKj7tbU4Xi7CzY8RxM=;
  b=IW5lvI8Vch4WYy2hO87mDoT9OBZJscdnlYLSp0E/lYObbf39cYnkP17b
   lNrVWYWoNmJicw30Bjn+/bl/H1yBbloHt0PKjkkRDQA2txeiS1SiGGcq2
   aMFyBVS5MMQyV7w4BGH42cDsO8hcDL8klWyqkHLPAy60kgIxBVt1gyxie
   lHlIGzpgs6PLZjG7EHtdM2KQjMlRRo9F7w3IZPx9fwZYEQfoYSNAPHsZW
   EfDMs1WEz6hLwG2RPRZnw5CITuY1zpzFNzgULtlB2pODT1dh1aVUw/ei0
   MxCHSi1kvFuD8yQ/HNtCh4LixGWt4f4nPk3SdjkAs3rkRsr3iSHEsptru
   Q==;
X-CSE-ConnectionGUID: uxcISvxzTya2RxbpIj9yZA==
X-CSE-MsgGUID: +s2mTIdRTju4mHP2O49uyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48804101"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="48804101"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:59:46 -0700
X-CSE-ConnectionGUID: cMr1dee8RAqNeGCU5I/mJA==
X-CSE-MsgGUID: lgHgULpCT6OOLzAOfAYlLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="168469492"
Received: from lvelazqu-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.9])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:59:44 -0700
Date: Mon, 12 May 2025 19:59:43 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.15 08/14] x86/alternative: Optimize returns patching
Message-ID: <20250512-its-5-15-v1-8-6a536223434d@linux.intel.com>
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

From: "Borislav Petkov (AMD)" <bp@alien8.de>

commit d2408e043e7296017420aa5929b3bba4d5e61013 upstream.

Instead of decoding each instruction in the return sites range only to
realize that that return site is a jump to the default return thunk
which is needed - X86_FEATURE_RETHUNK is enabled - lift that check
before the loop and get rid of that loop overhead.

Add comments about what gets patched, while at it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230512120952.7924-1-bp@alien8.de
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/alternative.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ddf696742c97263af9cc59c68daf1fd19efee0c6..26841dbaed76324df3c22b41c996bc81dab4ca17 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -620,13 +620,12 @@ static int patch_return(void *addr, struct insn *insn, u8 *bytes)
 {
 	int i = 0;
 
+	/* Patch the custom return thunks... */
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
-		if (x86_return_thunk == __x86_return_thunk)
-			return -1;
-
 		i = JMP32_INSN_SIZE;
 		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr, x86_return_thunk, i);
 	} else {
+		/* ... or patch them out if not needed. */
 		bytes[i++] = RET_INSN_OPCODE;
 	}
 
@@ -639,6 +638,14 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 {
 	s32 *s;
 
+	/*
+	 * Do not patch out the default return thunks if those needed are the
+	 * ones generated by the compiler.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_RETHUNK) &&
+	    (x86_return_thunk == __x86_return_thunk))
+		return;
+
 	for (s = start; s < end; s++) {
 		void *dest = NULL, *addr = (void *)s + *s;
 		struct insn insn;

-- 
2.34.1



