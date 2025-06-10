Return-Path: <stable+bounces-152331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48395AD4302
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 21:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4F73A4242
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 19:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925F826462E;
	Tue, 10 Jun 2025 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ffp7pIR3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D132123183E
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584531; cv=none; b=QbLHbT1OBAhmFuck3I3/YXN1nHtZQrkgmSH3n/t9RCWt0Unt160rlmeFNTU1naE1w20VQ8uvwAMmmEPV09OBdlwq5QxqLIDDHuMwOVIPkEuyir3CaAo+zu0rVH0CMJkOQku7KD2jZseBCLx9QT6k3ZWHzj+yF6ddiRYVbVapBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584531; c=relaxed/simple;
	bh=sPG8UqgT8GLGUgPkdD//fFsRViFHa2XdYfU7AaUI+WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJpT4E4dM5u7+AaFxvvJPX5drKX7SKB/F5KR8Iaf1NHFtldA2G8aEZ09Of8fbn5liT2etqq9q5vkmZD46mgF/mZfrBu53tSVYM7ji69w7HR2eCKtIl5+afXnqUufHmhlBftvgtEzhV6oP52hdeEQTBy6Ux/KPXEJHqF+L9FztMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ffp7pIR3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749584530; x=1781120530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sPG8UqgT8GLGUgPkdD//fFsRViFHa2XdYfU7AaUI+WY=;
  b=ffp7pIR3BHepqScRq6VVsuYB8oG6N1I1AfXNBfJ1T05BYeHfnUzrVXIy
   mbJhLHf06CM0wf2kcIwOetl/YYikmk3x4S93uIMX02eO3eVRHhGhoOQUP
   CSpOBwLZ7dOQ/7Nx5bHeaph5QVEbHV5ivphrBhcrG6LbVZfQemoLArQg6
   3pfhWV5W6dPkqEiOpkRhEzzQJ8hDqYePLZWrcyLNY4QMBWOR9vlvN9J7m
   r7uzgxLPrShggWIRCZxJIMUGlWKkj3habQYIdOgduRaj829T/YstG1LEd
   ouCanR8XwTYy+iMxHd8FTeCGuAfM/KFLHnTxVDzZk6FB+6cC8euhTIT9X
   g==;
X-CSE-ConnectionGUID: wQ+fESEARVeN5oOaStLfgA==
X-CSE-MsgGUID: neRk1KDhQmufDDjLKN10iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51569225"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51569225"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:42:10 -0700
X-CSE-ConnectionGUID: wany9ZOsQZSYDlbfPGB0LA==
X-CSE-MsgGUID: zfZEnmzcSmiTf2pB3YTrFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="177869496"
Received: from bdahal-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:42:09 -0700
Date: Tue, 10 Jun 2025 12:42:08 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC PATCH 5.10 07/16] x86/alternative: Optimize returns patching
Message-ID: <20250610-its-5-10-v1-7-64f0ae98c98d@linux.intel.com>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/alternative.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d8e16c479fd0508fceecedae19e992516aeecc9e..9de566a77a8e6b9ca2610edda731cd2f089e6b0b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -775,13 +775,12 @@ static int patch_return(void *addr, struct insn *insn, u8 *bytes)
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
 
@@ -794,6 +793,14 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
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



