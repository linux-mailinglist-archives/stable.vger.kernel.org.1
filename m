Return-Path: <stable+bounces-144292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C850DAB61B5
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B434A399B
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 04:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0871F30BB;
	Wed, 14 May 2025 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lj6fKk25"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4214400
	for <stable@vger.kernel.org>; Wed, 14 May 2025 04:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197974; cv=none; b=AU8UnbcdNnyUOyLg1D5OL2DDK92BZhZk/2/ayFBOolfKNtncp8m6OflnjcNY89y5GETK0I8c8oyEyC96UAebOqgnK6C+g7K0cZVmr2wUf1vOzoNw+pRcO6lqF8+O1Q+c8pS5liIgNOsRmwUWyBbFuQt16Q/CHpBUxI3ZaRiYcPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197974; c=relaxed/simple;
	bh=hNL3U8h/W+yTBmbVUZZovEK3UkAs3d+xSaScnike4QE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ELtTqYizW+bEY8P5gPVDbx6L2Ha8qeDjLzvJjlNjYXJSeQYN887HxOndMiGck87xdf8EjHzw/z+E8Z/LQMYySb9eaQ8LOCbikGCe6nNTDda9wBFD8vPkAjMm+cFxuH+DzGhP13gtuo9vUBwm702BX9k5uraoBwyH9/MnDUYT1bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lj6fKk25; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747197973; x=1778733973;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hNL3U8h/W+yTBmbVUZZovEK3UkAs3d+xSaScnike4QE=;
  b=lj6fKk25UaHdWQ/Qws/12yHxUmj0aH4+zKkVei0gx941fGtdZGRW/DwC
   4JaL4lFwOZekhvUalIeKq0w3BPEbv/cihYgN77QSBJd5ghYUCasxgEmjF
   pnjl8SC1irMvvx7YwER/7//zQoInNhSK4ty2Ecd9INpHxc4rUuL2kr9Px
   RRd/caoxjy8IRL32Rkus1NlQFaeE8U/1Bdp+oIzR1BpnK7BvLEj/TtU4/
   L4YqZYQiVYIbovu+hGZac3pPQ/YorlDRqAmebHodm4PmegmsX5gpIvfuW
   qw2j+2XvzkPI9uTVd18PIqAqkJykdR28ru8id4T327kdA+ROzt4XJe09o
   Q==;
X-CSE-ConnectionGUID: OfXCRRFwTliCwSl837p6Qw==
X-CSE-MsgGUID: kjpPlJxcRs6fP0xvZHBq8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="71574727"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="71574727"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 21:46:12 -0700
X-CSE-ConnectionGUID: U3eYwMt2Qjid11sxWW5kEw==
X-CSE-MsgGUID: HP/tyG6sQ1qlh1b+HRXnCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="142678584"
Received: from kandrew-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.10])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 21:46:12 -0700
Date: Tue, 13 May 2025 21:46:08 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>, Dave Hansen <dave.hansen@intel.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH] x86/its: Fix build errors when CONFIG_MODULES=n
Message-ID: <20250513-its-fixes-6-6-v1-1-2bec01a29b09@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAEkfJGgC/x2LQQqAIBAAvyJ7TlBTo74SHSK32ouFGxFIf2+JO
 Q3DVGAshAyDqlDwJqYji9hGwbLPeUNNSRycccEE22q6WK/0IOso9L1B733yKXYgz1nwj7KM0/t
 +OcejJl8AAAA=
X-Change-ID: 20250513-its-fixes-6-6-990e444d4d67
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
index 6085919d3b3ebbf57b4c6f257eb30d0781569fe4..5a0b84e21285d16b7869b59c7d9e622a99c7ad7a 100644
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
 
 DEFINE_FREE(its_execmem, void *, if (_T) module_memfree(_T));
 
@@ -198,6 +202,7 @@ static void *its_alloc(void)
 	if (!page)
 		return NULL;
 
+#ifdef CONFIG_MODULES
 	if (its_mod) {
 		void *tmp = krealloc(its_mod->its_page_array,
 				     (its_mod->its_num_pages+1) * sizeof(void *),
@@ -208,6 +213,7 @@ static void *its_alloc(void)
 		its_mod->its_page_array = tmp;
 		its_mod->its_page_array[its_mod->its_num_pages++] = page;
 	}
+#endif /* CONFIG_MODULES */
 
 	return no_free_ptr(page);
 }

---
change-id: 20250513-its-fixes-6-6-990e444d4d67


