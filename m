Return-Path: <stable+bounces-154608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71658ADE02F
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 02:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CEC189AFD4
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 00:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5867522EE5;
	Wed, 18 Jun 2025 00:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AmkpVB1l"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2AE29A5
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 00:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750207556; cv=none; b=AMbgfnUHe2dvqyJuOR7mjHn8ybaqtnJVH3bzd7XwlX68rkpxktxKUmbT+F9Teglc2FumbEBWzMMbB2tymgVa87TlHm0Bq5AQsObbxYHm4CmHJILXux+xi2fGRYNtAb5BkwwnU9YkYWTCkkNugwdXYDXIQE7vw6pyCtDk+C89m/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750207556; c=relaxed/simple;
	bh=1h0pwJyR1BVupDYP39whlqk6+94y/+SiPklZGT+TNhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2q68qBF5saO7RcYZhp+741GzZf3nY8BuGHBw8VeEFt9fByXYuKvEOdUSHFIqqeL7A9gAnLRPSyE/SBcq8igLNlJt88ZWlzkHDshsPYGGLMt9mXeJ7Suu9wrBqt+v6Msl902BHN++r54UupgAj+QweuuQu0UpcZfcl7PiWed830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AmkpVB1l; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750207555; x=1781743555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1h0pwJyR1BVupDYP39whlqk6+94y/+SiPklZGT+TNhs=;
  b=AmkpVB1lEd4rcDzc6i26kDtYZkf30asxL/ihXx4NW1DKFWUt5lbg8njd
   ese76+sIcx12syvwthX7UioZ5zsPWQ5j/7XIIOji1F9dwJP7/xInCeZow
   uE048CMKZ758N4149/UKcCn4KRiRGccA58AtJS0yKKocByKnI7mY9duBh
   A1L7oC5yRs5IKQfaaj4CNZhMSCnJmXy54vvW0FRXL5kpSGB8oB+bpuQig
   VPZL3Y/wGLnB0AmE7LpUuUuGJu4ZAcKBsTKTHKwaryCrj2zZ8gtR9JAOK
   cRUHoyemE99cOB8/1P1Wgg9gzh3zKMXgEutny1Q0cL1Zos3R0j6xB7hmB
   A==;
X-CSE-ConnectionGUID: C9CVoQQWQqOLjoteuCr3Ng==
X-CSE-MsgGUID: sjPJ6vkySlqrgGzgF/yXWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="62685112"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="62685112"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:45:54 -0700
X-CSE-ConnectionGUID: GLvQN1KLQXyhx+5GSsrQog==
X-CSE-MsgGUID: DH/ElwTrQW+TA18aKJAOog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="149001092"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:45:53 -0700
Date: Tue, 17 Jun 2025 17:45:53 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.10 v2 07/16] x86/alternative: Optimize returns patching
Message-ID: <20250617-its-5-10-v2-7-3e925a1512a1@linux.intel.com>
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
index d8e16c479fd0..9de566a77a8e 100644
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
2.43.0



