Return-Path: <stable+bounces-152337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF61DAD4312
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 21:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06BF1889520
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 19:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94EC264A6D;
	Tue, 10 Jun 2025 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMf/Gzgz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20916264630
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584625; cv=none; b=HUlChfHkYIuNV/rNqBoPQ+/p0xI9BW7uJCjeTP6DO16cYdFzqlkJ8sBA0R6NrGv5+aEJs+jgSOwoGTwfDD+IAxM/pz5gFLigsiIybBr6U0sOySm3ny0OZaaqEFwBKWIFKEWFL8ESMKWlhI+RRTCC4iSuPkZq/6B8BSjT3oiAnoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584625; c=relaxed/simple;
	bh=aUNNMTNNLyAQTILwPzkjNuN9sQo1Zur8RntZ3dGvLto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMvdRqRrE4wwci5dJOL2tsnc8AN2vOQpWPwneOz/5Zzi6w8X6lMxBF+LcKWqrEEQMO/WFegklEX/DUgHWP4Qxl1kAd1HZmhGWBahiT2xSrXwamn3jilNFeeoh4Ag1cFIGiQ6I7QlPAANleSR5gR6uT7cpOxj3iOqBpyACR3aDGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMf/Gzgz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749584624; x=1781120624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aUNNMTNNLyAQTILwPzkjNuN9sQo1Zur8RntZ3dGvLto=;
  b=WMf/GzgzyWphJ8MkPHmhGcLONXJf6GSl2lBm3fEkqJDo/2a08RLxwVzG
   ywj9Tr/ISPUjgHB5P7l3VnQbcPllykhln4wXIy2XDr2JsI2VdrJND5GNq
   jK6Cl07WbHkRy7M/rOAjpHGkKfo+7s+WmAiDGhU3EcdG5dU608SButfkA
   btZHxJjj3vusC7CW7oAR4zJmlQeFdOmXeAK3k4KflkPhuVOZ8UhAqS7lC
   zQoPGoaHnHZj8k51Y3J73hSf/9h4X8ngF4THWPFv2ML4lF+xiNmwTTI6n
   v52DrrvDYBOdA99oj5IWG0xAJFjAxHsAfofToTpqbjZwrZZrgCFnEolum
   A==;
X-CSE-ConnectionGUID: AFwknNW/QSeh4DYAp7HGhw==
X-CSE-MsgGUID: m+YIYi9wS1eeQTW7y01IqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="55375291"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="55375291"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:43:43 -0700
X-CSE-ConnectionGUID: hdcV0qV/Q9GfMCzx9J+lew==
X-CSE-MsgGUID: h9G6sSeFQjW6KLTdz1/VLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="150786612"
Received: from bdahal-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.44])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:43:43 -0700
Date: Tue, 10 Jun 2025 12:43:42 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC PATCH 5.10 13/16] x86/modules: Set VM_FLUSH_RESET_PERMS in
 module_alloc()
Message-ID: <20250610-its-5-10-v1-13-64f0ae98c98d@linux.intel.com>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 4c4eb3ecc91f4fee6d6bf7cfbc1e21f2e38d19ff upstream.

Instead of resetting permissions all over the place when freeing module
memory tell the vmalloc code to do so. Avoids the exercise for the next
upcoming user.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111143.406703869@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/ftrace.c       | 2 --
 arch/x86/kernel/kprobes/core.c | 1 -
 arch/x86/kernel/module.c       | 8 ++++----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index fba03ad16cceb1e17a64559989660327ce09a866..bb02d5d474c28370c9e420caeb9209d2569514b0 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -422,8 +422,6 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
-	set_vm_flush_reset_perms(trampoline);
-
 	if (likely(system_state != SYSTEM_BOOTING))
 		set_memory_ro((unsigned long)trampoline, npages);
 	set_memory_x((unsigned long)trampoline, npages);
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index d481825f12bfee53177399ad5ad6aaf7a7fa9c6b..5254317125d89514539137f18e1f3ebeedea45dd 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -403,7 +403,6 @@ void *alloc_insn_page(void)
 	if (!page)
 		return NULL;
 
-	set_vm_flush_reset_perms(page);
 	/*
 	 * First make the page read-only, and only then make it executable to
 	 * prevent it from being W+X in between.
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 455e195847f9e9502b4cc9a3d470f60be3ae70d7..e28c701e8f8b0f09324dc7af7f27e66e2c5482e0 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -73,10 +73,10 @@ void *module_alloc(unsigned long size)
 		return NULL;
 
 	p = __vmalloc_node_range(size, MODULE_ALIGN,
-				    MODULES_VADDR + get_module_load_offset(),
-				    MODULES_END, GFP_KERNEL,
-				    PAGE_KERNEL, 0, NUMA_NO_NODE,
-				    __builtin_return_address(0));
+				 MODULES_VADDR + get_module_load_offset(),
+				 MODULES_END, GFP_KERNEL, PAGE_KERNEL,
+				 VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
+				 __builtin_return_address(0));
 	if (p && (kasan_module_alloc(p, size) < 0)) {
 		vfree(p);
 		return NULL;

-- 
2.34.1



