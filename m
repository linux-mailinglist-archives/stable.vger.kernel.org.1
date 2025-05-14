Return-Path: <stable+bounces-144312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA565AB6263
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 07:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4540916E15A
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 05:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D641F429C;
	Wed, 14 May 2025 05:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0VBtm8n"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5927486334
	for <stable@vger.kernel.org>; Wed, 14 May 2025 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747200991; cv=none; b=pkrSdtKzMkBOUJ/d7r633UTjJY5vcy+PjNqAWBOTRFvwjFyZ/SFBX3+AInu/pUqvCK53Bf7qb0PBPemR6Gnc/2ojQGh/PkbxT6bdOlF4Yf1kLKzUVRdj8Yib/Aiar8CBz6ShdRprB2A0as5Mref0Zg3bv6Kh/0DYR8yNzHNjSVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747200991; c=relaxed/simple;
	bh=AYUg2L72Sv2IiHiHjWoic8BSG6tvbOpIEW7yNHE4y9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hr7eHrKyEfvufKpPq6BdktenABdoAwR6VppTvlo/QzvL3etMA/fOCuguDg1T1a72FKYCyw0I+x617MCcl1yj4klwX4DVpdpIwgXvoM5kHuZ2+Tu8QfvszkGKiwZPJhgbDwJ/whcnGBmh+jPbvm+DgF8XlnHgx+lQds/HEOkrAvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0VBtm8n; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747200990; x=1778736990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AYUg2L72Sv2IiHiHjWoic8BSG6tvbOpIEW7yNHE4y9o=;
  b=S0VBtm8nypaO4XVW5quwhuvu2b0fjnHvvdoQbU7sjJLtXtlNEcp4S7Hw
   c4ZLDivg2rwvgrTXYLR87Zmg49Sg0xdJ/jI6o2GesAjkCdYtIR/HgY+ge
   IxFGvlc0SaImiXMgySApXVrxHL1Vk9xYb6GvDiWKgtmrwWUWQGNzcm7gg
   ruD2Vl/CuWygUEjgPZRdB19SGySmaC9sUV5se5uZhw0kbHPWqkRCMP6MW
   uzBSLE6mAMCyw5LReF0ONtaThf5KJGz4xfmKKb1GWX+VLkJ8Ott9dJy/7
   6J300flkVc5NRUBInmgjQQTG6NE9WohPni8TOPTA8pVJWveSkFrZEMQsN
   g==;
X-CSE-ConnectionGUID: KJnDhx/CSwCHxAHJKgXGBw==
X-CSE-MsgGUID: zEZ5Bh37RWSaWTzENeIuFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="59708229"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="59708229"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 22:36:29 -0700
X-CSE-ConnectionGUID: oyV0A8SGRdGFDUipVIIxPg==
X-CSE-MsgGUID: d+lP3vaJT/OdMj8JoWsjdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="137975879"
Received: from kandrew-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.10])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 22:36:29 -0700
Date: Tue, 13 May 2025 22:36:28 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 6.1 3/3] x86/its: Fix build errors when CONFIG_MODULES=n
Message-ID: <20250513-its-fixes-6-1-v1-3-757b4ab02c79@linux.intel.com>
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
index 023899e9ebd16ba223a1de91da9bcb43666788f9..843bda0cb5d09a091a06ac7c3b30d5545880e905 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -402,7 +402,9 @@ static int emit_indirect(int op, int reg, u8 *bytes)
 
 #ifdef CONFIG_MITIGATION_ITS
 
+#ifdef CONFIG_MODULES
 static struct module *its_mod;
+#endif
 static void *its_page;
 static unsigned int its_offset;
 
@@ -423,6 +425,7 @@ static void *its_init_thunk(void *thunk, int reg)
 	return thunk;
 }
 
+#ifdef CONFIG_MODULES
 void its_init_mod(struct module *mod)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
@@ -462,6 +465,7 @@ void its_free_mod(struct module *mod)
 	}
 	kfree(mod->its_page_array);
 }
+#endif /* CONFIG_MODULES */
 
 DEFINE_FREE(its_execmem, void *, if (_T) module_memfree(_T));
 
@@ -472,6 +476,7 @@ static void *its_alloc(void)
 	if (!page)
 		return NULL;
 
+#ifdef CONFIG_MODULES
 	if (its_mod) {
 		void *tmp = krealloc(its_mod->its_page_array,
 				     (its_mod->its_num_pages+1) * sizeof(void *),
@@ -482,6 +487,7 @@ static void *its_alloc(void)
 		its_mod->its_page_array = tmp;
 		its_mod->its_page_array[its_mod->its_num_pages++] = page;
 	}
+#endif /* CONFIG_MODULES */
 
 	return no_free_ptr(page);
 }

-- 
2.34.1



