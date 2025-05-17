Return-Path: <stable+bounces-144651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812CEABA6DC
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 02:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7F13AF7E9
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 00:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5173420ED;
	Sat, 17 May 2025 00:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aeFhG5qH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632B1FC8
	for <stable@vger.kernel.org>; Sat, 17 May 2025 00:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440100; cv=none; b=BH8SmY4KRt4CDsbCMZqtR/CbOwfKrEw9+cw/Wfdpaj81Gwux0mUCE+sG+dcVtfsWriFncKw9tCra3akAgmFJtKQWLC7cBkV7KI4AMG8h9JRcFEneBxtWqH8ogEAf0hWcbS7wC++fiLxqAezcaKVeqqxfaminbQzn4BOqcc2g/6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440100; c=relaxed/simple;
	bh=lM4tZzxGyQzP7oairMCUYnn3vNKj7tbU4Xi7CzY8RxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E42Uw7xfMallkqIcadwDY99RVM6hlZ6/zoviSoN7ibKZlx9Cp40PBdeg66tpEny4Ik0QyiFKS6zNzKg96HrO2rLT1PQOK6ixj5rnzHaqtyAu9qVX2ziy2hqXhLKf5NHCASzNPmQeJoFs0GT1Z+z5A02dwwra0nTNhg4T9EOJuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aeFhG5qH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747440098; x=1778976098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lM4tZzxGyQzP7oairMCUYnn3vNKj7tbU4Xi7CzY8RxM=;
  b=aeFhG5qHwg4S71j1SprZh5DdUS/VCWpwuoZfLs/3S4XgaLRzle5rrJnA
   35F3HevVyhlij1uVLOCyNTfVkd25x7JRgQVpUqo3X67G7XibX2NG/912s
   qoJJ+BHy01qFs3qSOPo4l21aM182JNTcOj9coOdjaC430f+/iQpopdlS2
   f/7LGDeYgRfOZ8wI8yL+KyI+wtj5kNouo5yqd7Wc+zlsS9vdeUpmCnO72
   9gR2DceMj08PXkWGKBmYNbzJWHvpK3paoF6rW5GE0rvFZRmTPVnEX+5J+
   eWj8dGBXuaV333FaNUar5XHE726icri79LAQGTzziaWs3p7khYz/yQMmq
   Q==;
X-CSE-ConnectionGUID: td0akTgHSUmOMyE17Qa9yg==
X-CSE-MsgGUID: Flyr0p0IQDivD1cwmAOUkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49122605"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="49122605"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:01:33 -0700
X-CSE-ConnectionGUID: IgpEgXykSECryVdnOneKSw==
X-CSE-MsgGUID: 5C8Z+/dZRliQ3QqSoQRHPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="143808457"
Received: from yzhou16-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.16])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:01:32 -0700
Date: Fri, 16 May 2025 17:01:32 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.15 v3 08/16] x86/alternative: Optimize returns patching
Message-ID: <20250516-its-5-15-v3-8-16fcdaaea544@linux.intel.com>
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



