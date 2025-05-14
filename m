Return-Path: <stable+bounces-144288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56C0AB611C
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 05:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351244A2416
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 03:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5DC1E1A05;
	Wed, 14 May 2025 03:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LlRapKn8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEB627454
	for <stable@vger.kernel.org>; Wed, 14 May 2025 03:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747192187; cv=none; b=k7QLUdXijk/bzVFHfN77wuSMJ/UuaXd/7cnPXmJLxB8vBLTTyZTIaXJDHZPftLi4sfNcEIZxZkmShpeF/e/Rs8NrLBhsA3OXJW4fPR9PbiNXUS0XW7/5I3F0/wAPOFOSYIgBnGzXjEK/nD3pAKXVMVzUsWxAIcJK89nK8SCa+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747192187; c=relaxed/simple;
	bh=MJZJZQ/a4z1ncA4TDCTztGXCbFeW3SI1VklQuz2Aa1Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JHrvKojp+ipJ9z2uPli+32hPfO2i1AU4QGES1Db5ETQ3aQ6ieMxFwN50007TOJBKR/ObLmDbcZdeQC34S8PvmYwMz7fI+Je4gZaC989ULSYuWpbtOXiBNrH+YXgjgcQ3JOP/A2NmQGWsb8T5BiRQNtudvIjXkSPCzVwiahDEy7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LlRapKn8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747192184; x=1778728184;
  h=date:from:to:subject:message-id:mime-version;
  bh=MJZJZQ/a4z1ncA4TDCTztGXCbFeW3SI1VklQuz2Aa1Y=;
  b=LlRapKn8jsOVYUAekbIXF2fflwv1L8NKD7UzckRM7Q0p+T2Gy1zlnOPv
   1IQQF81CpicY1yI4G+9xhfiJPNw99K3El1Db8VlChbndxL2C3UGpLbJl+
   CbQ08DzoBlLPYwpdxKpm5KgRIKgNjMAlv1WLEzme66b9u6H+cd+RpfCbp
   J9iRjttr3xKsv6WexzxOFno/A+IINjM+JlfNhyvDiNE7559ngN96cQ9S4
   Lp7FA1mxNgRcZLPrKpTk8/BOUJjFwY0I86+4hu5uIDHVo9AJXSl8oRAsM
   vuCNpl8npD/k2wUe4BEf78N0JZV+REvI8YtQA8aukLCmvw4I9h+7IpZUg
   g==;
X-CSE-ConnectionGUID: gczElmU1SWKTjLNoHsP/JQ==
X-CSE-MsgGUID: RAFCoVqLQJ2/se9xsFxOeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="71569568"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="71569568"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 20:09:43 -0700
X-CSE-ConnectionGUID: S2rBrNMQSC29ea2EmRQmYQ==
X-CSE-MsgGUID: docQ2WF7RDSo6NYxJOXZXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="137626630"
Received: from kandrew-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.10])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 20:09:44 -0700
Date: Tue, 13 May 2025 20:09:42 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH 6.14] x86/its: Fix build errors when CONFIG_MODULES=n
Message-ID: <20250513-its-fixes-6-14-v1-1-4c9a36e80c78@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAMnOI2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU0Nj3cySYt20zIrUYl0zXUMTXVPjFINEc0sTM6C0ElBTQVEqWBaoJ1o
 pwDHE2QMkaqZnaKIUW1sLABeZ5dtvAAAA
X-Change-ID: 20250513-its-fixes-6-14-53d0a7946250
X-Mailer: b4 0.14.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Eric Biggers <ebiggers@google.com>

commit 9f35e33144ae5377d6a8de86dd3bd4d995c6ac65 upstream.

Fix several build errors when CONFIG_MODULES=n, including the following:

../arch/x86/kernel/alternative.c:195:25: error: incomplete definition of type 'struct module'
  195 |         for (int i = 0; i < mod->its_num_pages; i++) {

Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/alternative.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 1cdcd79f302d15be44477c7350bf6537a5e42c22..c9b4f388a533530ca59846aea972fded66a37734 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -129,7 +129,9 @@ const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
 
 #ifdef CONFIG_MITIGATION_ITS
 
+#ifdef CONFIG_MODULES
 static struct module *its_mod;
+#endif
 static void *its_page;
 static unsigned int its_offset;
 
@@ -150,6 +152,7 @@ static void *its_init_thunk(void *thunk, int reg)
 	return thunk;
 }
 
+#ifdef CONFIG_MODULES
 void its_init_mod(struct module *mod)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
@@ -188,6 +191,7 @@ void its_free_mod(struct module *mod)
 	}
 	kfree(mod->its_page_array);
 }
+#endif /* CONFIG_MODULES */
 
 static void *its_alloc(void)
 {
@@ -196,6 +200,7 @@ static void *its_alloc(void)
 	if (!page)
 		return NULL;
 
+#ifdef CONFIG_MODULES
 	if (its_mod) {
 		void *tmp = krealloc(its_mod->its_page_array,
 				     (its_mod->its_num_pages+1) * sizeof(void *),
@@ -206,6 +211,7 @@ static void *its_alloc(void)
 		its_mod->its_page_array = tmp;
 		its_mod->its_page_array[its_mod->its_num_pages++] = page;
 	}
+#endif /* CONFIG_MODULES */
 
 	return no_free_ptr(page);
 }

---
base-commit: 982c0c8bc78be18914f38ae20ea0f55e268b88ca
change-id: 20250513-its-fixes-6-14-53d0a7946250

Best regards,
-- 
Thanks,
Pawan



