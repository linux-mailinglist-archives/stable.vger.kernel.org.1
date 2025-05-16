Return-Path: <stable+bounces-144633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1F8ABA4CF
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 22:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C376E9E4AF8
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CB919CCEA;
	Fri, 16 May 2025 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWjKnc9H"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44B1A704B
	for <stable@vger.kernel.org>; Fri, 16 May 2025 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747428160; cv=none; b=WWS0yILHrHsTZgWnakUD9az4JxxWLPOBgVfibkuBeidmIXENPCCU6TUBgX7LMCrJDnFFuLkUwpjNTZZAJhAoFqH9r77QQMWB/LAdBsFlH54898/G7LtlGQkx/A+nXSZYuqKDp5V/eDkgHzqz5X0kW22jjgaSZ4y1vdOGVSTDz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747428160; c=relaxed/simple;
	bh=CfY5mlqnN0W9ZjltqMOGgVafiyp7kiSQXRjktrf2Pt4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dVp4HC8kXXURGBhwn2YS7EdV7LzprdoYwHuhwlMVagh1tYjesk/Zs3Hug8H998lxYBr5ssjh1jjf3y1kpyv/O8U07M0EvcSP9RxIELScg7ormQXWTUur1iM9n5NL+u7QYdtkUpoh1D3GZ82JGYyfw6hkNsA4JOR9GfdJswN54QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWjKnc9H; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747428159; x=1778964159;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=CfY5mlqnN0W9ZjltqMOGgVafiyp7kiSQXRjktrf2Pt4=;
  b=GWjKnc9HlLtKzqrTdmSn7bc4iLocA9VZc+HFDsF59kD+pGETfStCOqku
   xutUuyorrVXce088r/ntH3+ioGXTAfmSJt8MndFo3xTjejZC6OEof2sbF
   qQNQTk/Y+J3mp8soRTsiqecFi0SR83qAqQED4K0Tvsda8RPaNrHGwwYK4
   3k5Ph6sXl3SDefVekL9CZTw6+jiH4XCluXCukRKYglfVvLSGL24jSUubg
   tc3FRCMFtrdMevlqGyocAlyYLaNYkIQpY/zSCwHWHh5+1+TjVAG7BKVI+
   rXGpruV+UOyxwEkX/qcTMeoI2DvymDUoHARKn5o+KJPQzfON9bAi/9uqo
   A==;
X-CSE-ConnectionGUID: UMz2aXM2SPaR1KrhyMzXbw==
X-CSE-MsgGUID: V4chq/1pSkiKZ6TdkISYyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="52037631"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="52037631"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 13:42:38 -0700
X-CSE-ConnectionGUID: L97+gUZGQyKfrWXfK0OoQQ==
X-CSE-MsgGUID: whqV5DusQZ+4g1mAcEavXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="162100150"
Received: from yzhou16-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.16])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 13:42:37 -0700
Date: Fri, 16 May 2025 13:42:37 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1] x86/its: Fix build errors when CONFIG_MODULES=n
Message-ID: <20250516-its-module-alloc-fix-6-1-v1-1-f3b597b5ea35@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAIGgJ2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU0Mz3cySYt3c/JTSnFTdxJyc/GTdtMwKXTNdQ93EpCRDwzSjVGMLI0s
 loPaColSgFNjoaKUAxxBnD5ComZ6hUmxtLQBqQjyQeAAAAA==
X-Change-ID: 20250516-its-module-alloc-fix-6-1-abb11f2e3829
X-Mailer: b4 0.14.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025051632-uncaring-immature-ed38@gregkh>

From: Eric Biggers <ebiggers@google.com>

commit 9f35e33144ae5377d6a8de86dd3bd4d995c6ac65 upstream.

Fix several build errors when CONFIG_MODULES=n, including the following:

../arch/x86/kernel/alternative.c:195:25: error: incomplete definition of type 'struct module'
  195 |         for (int i = 0; i < mod->its_num_pages; i++) {

  [ pawan: backport: Bring ITS dynamic thunk code under CONFIG_MODULES ]

Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/alternative.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 44bff34f7d10cb6868ad079ca1cb87e458d3f91b..acf6fce287dc0804cfea0377f6f8714a68d10452 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -402,6 +402,7 @@ static int emit_indirect(int op, int reg, u8 *bytes)
 
 #ifdef CONFIG_MITIGATION_ITS
 
+#ifdef CONFIG_MODULES
 static struct module *its_mod;
 static void *its_page;
 static unsigned int its_offset;
@@ -518,6 +519,14 @@ static void *its_allocate_thunk(int reg)
 
 	return thunk;
 }
+#else /* CONFIG_MODULES */
+
+static void *its_allocate_thunk(int reg)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_MODULES */
 
 static int __emit_trampoline(void *addr, struct insn *insn, u8 *bytes,
 			     void *call_dest, void *jmp_dest)

---
change-id: 20250516-its-module-alloc-fix-6-1-abb11f2e3829


