Return-Path: <stable+bounces-144310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6A6AB625F
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 07:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36218637DC
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 05:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6F61519BC;
	Wed, 14 May 2025 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjxUVrdu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FC41CAB3
	for <stable@vger.kernel.org>; Wed, 14 May 2025 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747200960; cv=none; b=EfbDqI/VST6pwEmPjkXSDRjtymwbNVMd4y6Nbv06aJGd8QmY/OmmkmaPDVAikv6o4Fl2gmM9WoHKdq7CYk0zhGpTU8YxxQ+CC8i9bj2odKweL0Vv6xa/vDwkHORgUjh1tkbzAnnjPBJM2CoxxFRExOqLlRvZkllwykAXjyY56Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747200960; c=relaxed/simple;
	bh=dYyJG/SvEQNQRKVtl6mz8pKA6+UnV6JnjCdAucvhB0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bU2iAfke4k5LEgn/uckJPXM1dUfIiMx9LgEORa+RueUIji4KkrmkpTnPunx8jPcKU/qq38s+WGf3hixLihbNekoOFyZEkLR5rjJy3qEKqSpwDWDjoc/TaQAeYX4hmcfP5FYURDR6no6vwP+v9gG/iGTBGanR4Z+SsvBr4YoVNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjxUVrdu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747200958; x=1778736958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dYyJG/SvEQNQRKVtl6mz8pKA6+UnV6JnjCdAucvhB0A=;
  b=bjxUVrduWuhDfEU+MOnR+atsHem76nvfSzyRMiIdzkA1ycjYhzxE1pDv
   gRU/HjyRSiB+YOART8BL5yhPlxy0kr2ZG9xnkLCcbC0sajUuaYA/xAyz9
   RTgptOQFiUWqflz9sexOppC8Ld8GlUvxf6qwec2l96Pn8KzcGRlrgX5V6
   eeLXEzR3Pi7dUq3XGqZ20ylRuldmlWN4EHPAnKZuKof1AjyXjQ/FSlijg
   41MrkLneHTrnXca0Mz6zLk+UD8g2dSn9vOxdR/8alHoYJwce1Yl6A5n6Q
   qAz+pWP2WMsRcDw6yPpK7Nn3cD6Vu1UB3y4DVeI2LvaThYAWGJtQpxtsa
   A==;
X-CSE-ConnectionGUID: qWg6RRWNSTu2I4VQ8l738w==
X-CSE-MsgGUID: OL+0144LShuNg0PncbZ/BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="59738677"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="59738677"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 22:35:58 -0700
X-CSE-ConnectionGUID: AQQSHlJiRPqXVo+pxD5Z2A==
X-CSE-MsgGUID: UPXOSugpQ/iofjixdDkrTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="138359633"
Received: from kandrew-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.10])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 22:35:58 -0700
Date: Tue, 13 May 2025 22:35:57 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 6.1 1/3] x86/alternative: Optimize returns patching
Message-ID: <20250513-its-fixes-6-1-v1-1-757b4ab02c79@linux.intel.com>
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
index 44bff34f7d10cb6868ad079ca1cb87e458d3f91b..dfd5490df0af9e55d1a6ab185ad7cb03bdda4a91 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -769,13 +769,12 @@ static int patch_return(void *addr, struct insn *insn, u8 *bytes)
 {
 	int i = 0;
 
+	/* Patch the custom return thunks... */
 	if (cpu_wants_rethunk_at(addr)) {
-		if (x86_return_thunk == __x86_return_thunk)
-			return -1;
-
 		i = JMP32_INSN_SIZE;
 		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr, x86_return_thunk, i);
 	} else {
+		/* ... or patch them out if not needed. */
 		bytes[i++] = RET_INSN_OPCODE;
 	}
 
@@ -788,6 +787,14 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
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



