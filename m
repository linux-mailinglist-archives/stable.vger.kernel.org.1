Return-Path: <stable+bounces-144321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE7EAB62BE
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE335463BB3
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF12433A8;
	Wed, 14 May 2025 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpyIlKNe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289DB1E5B68
	for <stable@vger.kernel.org>; Wed, 14 May 2025 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202925; cv=none; b=J/4fFK5uLPrLhPRSdL5jge/tl1wceUm/nqT2o9qLFW7kEY3iAFHFcgv4C7zrCLXgi+YFGqmXa1lO6C/57DaAvj0ulwmefki9TFZpkWDOWF0ChUMPNgNJKhiFie9Ceg0FwgVb42wscjMRd2J77E6LRPN42RslUPDiq7neLdEgdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202925; c=relaxed/simple;
	bh=lM4tZzxGyQzP7oairMCUYnn3vNKj7tbU4Xi7CzY8RxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlIM2kkQ/JLiH7kBoLn5lA106A/+/a8n5/iT3GJEVyRchJ/LuO721xOWosf1oLyJFE8BQsBgKR22NGFTi5XjeUiaANp4cvcnx+Fk/rX+lRO38yeRSA4BqEFfFRDL57LzQ843h/am/+dRiIJ3Hf/LJDBS5X7SgA938FOSN2BQDaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpyIlKNe; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747202924; x=1778738924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lM4tZzxGyQzP7oairMCUYnn3vNKj7tbU4Xi7CzY8RxM=;
  b=mpyIlKNeCOuy6QPR65s3SfgyjyTMLQRL/31F43W8sxU7fodKI6VtnImU
   Xxil9fsvFXjWsPvn8pR++Jw/uf15dTu/5SHFtQyRvL8nmxKBg7qd4JeU4
   QGbg0BVC48TlTl3/deiiBSA2PfAiYJHd61VDwwIlDli6bJMosx125jV+/
   qZukKVKJQCynfAgJsrEwS7PBsGYRkEhT8Vp6iTVuZEeZ3E3dDVC2vDGUX
   FLvUK1IXAKLJLlyRR8byV6FYuQCOJP3RVkZ2pXgyIVMYneTlw/Hy6CSCT
   lSOvTYS44+4Un+5GMdHPCItEQ8Nro2a+b3WQ0tP+Z09rj2JXhHqrNdy9R
   A==;
X-CSE-ConnectionGUID: R1aWdqgzR/mTYpsUoh9z4A==
X-CSE-MsgGUID: Jzc1lMYOSj63XHrv9oiB4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49226293"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="49226293"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:08:43 -0700
X-CSE-ConnectionGUID: EKH1uu0jQzO2xfZjh1CiJQ==
X-CSE-MsgGUID: CkgdiC/5TG+BRbt0tgtq/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="137856289"
Received: from rshah-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.11])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:08:43 -0700
Date: Tue, 13 May 2025 23:08:42 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 5.15 v2 08/14] x86/alternative: Optimize returns patching
Message-ID: <20250513-its-5-15-v2-8-90690efdc7e0@linux.intel.com>
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



