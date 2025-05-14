Return-Path: <stable+bounces-144291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0101AAB61A0
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEDA165076
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 04:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615C31E1308;
	Wed, 14 May 2025 04:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTI7ec/o"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E64F1CFBC
	for <stable@vger.kernel.org>; Wed, 14 May 2025 04:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197503; cv=none; b=O+Vi5mlY6f9QEH6lrzwmMBCtl2WqZEjtFJiVOp9icsbdytqk+xDLYdw2GvyHYHELygJlxFq5Cu2Pyc31ti2OO6D+4/LSDXiprHMvUeZrdnaIu7dFS89Qty3FyYGogtzU4OxMkZwKhaAjk4ac2vsQJrgsirtUlMbpFtwN8BdA+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197503; c=relaxed/simple;
	bh=pTWXN+WpeAz8mb8nJjqHbxoeK7Zm10fAvTrwGgvGBZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dOWzgWDCpmxytJRb5geRBH2OvkfxBQPq5fUwFUOKNmi0MEJP23a1gw2qFjsGMGUe/OSGGfX3t85F/HQYLzgv3p+k58uv/e0M4+Z7SqWHS2b7GXZbGBOmVH+zMdrBcq3x3obRN6u5ZUrSA6XNQOQxsCU16jZ10zk9GiroBC+5vcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTI7ec/o; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747197501; x=1778733501;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pTWXN+WpeAz8mb8nJjqHbxoeK7Zm10fAvTrwGgvGBZM=;
  b=cTI7ec/o1iB7jBvpWMDA/qd/6ApPzg1xHnsZPiUnkmbg6U3zKI4IEwls
   5eqgjD98eo9z0jh3213xt/FBs+VpjkJ6nZrrN9xsVUjv011W71zo5oicI
   +ZsWAbZmpsH0LIRYNEtOJ85FfDZN49qzUe394fV90gWGBVEZHTWvQOLsO
   b/vcq8V1BXn5Zjic3gJs6FtbFjDt8fRqNECpi4hZPluTbqJffPu/+vnQC
   +AgRXTSPhLAnVpFZUdI3VJQaZL8onfgbaKDUkn7Qxpu6bDiUw2k4ok235
   om2TNRN7TcTKmJuzchI8Bh/LaO82QxThBW8wpHKfEXLI6yTvbnWbR0MCW
   A==;
X-CSE-ConnectionGUID: jijc5byoQVeA4r6pMNIfyg==
X-CSE-MsgGUID: mNU6GXTEQI2AiCzMSc+fnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="48183255"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="48183255"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 21:38:21 -0700
X-CSE-ConnectionGUID: 7zo3WlsJRLyuMaL8frQCxQ==
X-CSE-MsgGUID: 2AZrROtlT9i13OYv5x1vdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="142790187"
Received: from kandrew-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.10])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 21:38:20 -0700
Date: Tue, 13 May 2025 21:38:19 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>, Dave Hansen <dave.hansen@intel.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH] x86/its: Fix build errors when CONFIG_MODULES=n
Message-ID: <20250513-its-fixes-6-12-v1-1-612ca33e17a6@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIANscJGgC/x3LMQqAMAxA0atIZgNtbRW9ijhIGzWLSiMiFO9uc
 Hx8fgGhzCQwVAUy3Sx87ApbVxC3eV8JOanBGRdMsA3yJbjwQ4ItWodm9n2IqbOJPOh0ZvqrPuP
 0vh98u181YAAAAA==
X-Change-ID: 20250513-its-fixes-6-12-0a495cd71de4
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
This patch applies on top of patches in stable-queue with ITS
mitigation.

 arch/x86/kernel/alternative.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 01aa5a73c82fd8fe33a14a73ebace6d4e3b6b169..29482c52086577757d512942147db7f8d65a34bd 100644
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
change-id: 20250513-its-fixes-6-12-0a495cd71de4


