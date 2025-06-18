Return-Path: <stable+bounces-154614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ED1ADE036
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 02:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2260E17B8DD
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 00:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41098208A7;
	Wed, 18 Jun 2025 00:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHJaSm+X"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE37429A5
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 00:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750207648; cv=none; b=pBWD6WclRhpaCeGLucTodRC8kh2dWoUewXGukEig2jrA/L3XumR+3aW3K/cZoA1cjL+iWIqN116sX+Xq/4iIHPHwaPX0l46MeFtrN7wTtdyvEceIJ/0Bz/Q5pJgBFFIBsv0LzYJOfn8xwyQr9lwxNS4l6aHct0KOUqXbY0A8F6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750207648; c=relaxed/simple;
	bh=Yy2LOTafPK1ZGRYYUWRR/Vv4RQXggASaYwyOOlnKRFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAPY5d1tZN9Qs3mFA/TVDrUhN8Vmum96vbjTLh2FD9GHAcLET0EDDxTmO+jA+BCUjGNrlxu9/uwS6lypIlQ6a8utz8527TuOyJMcy75U01hGnmXSQwmBX4iwQFahPjBx4vvU0W6ZqZZ20q5ZFL76mVO58Lltj427Ry5prsDVbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHJaSm+X; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750207646; x=1781743646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yy2LOTafPK1ZGRYYUWRR/Vv4RQXggASaYwyOOlnKRFo=;
  b=WHJaSm+XJby6793WYRB7StjKzlt+B7Eg3RHmBzhVXBuoO+Hnlb9V/cKD
   0QQWA2BysmjGAhtWCPtgNBNZvNqKyQ6sjuReWu67XWVM0CREQnZgxPyeH
   DmpKpIM43NQiank4fLgXelexlyFufuz8SdFSvvwdp4fQYuvr4lfxyFS5T
   oC2hURFwGfrCeYu4co8b5U4upV7GIdD33d7pvFv7QpMXxLTQHRaa8d8Bx
   Tx0m65rb4T3Yo9/hdKxH+UYSAV84mqBtQYlrx+3rJuXoZ877/7npxHS+Z
   7hZNjA4saEWCdb1oKJyA+N+26qkyxx0y2a4vBB98/19UOF/2v0T3I6E5N
   g==;
X-CSE-ConnectionGUID: AZaBRsKzT86NjRYl9mD8tg==
X-CSE-MsgGUID: LJAl4CtqQciZtwD0vXEZtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52491183"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="52491183"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:47:26 -0700
X-CSE-ConnectionGUID: 1Zk3CWvbTgOGSxhWgbtGBw==
X-CSE-MsgGUID: kvoyAcwARECri5FwJ40f0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="149600231"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:47:26 -0700
Date: Tue, 17 Jun 2025 17:47:25 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.10 v2 13/16] x86/modules: Set VM_FLUSH_RESET_PERMS in
 module_alloc()
Message-ID: <20250617-its-5-10-v2-13-3e925a1512a1@linux.intel.com>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 4c4eb3ecc91f4fee6d6bf7cfbc1e21f2e38d19ff upstream.

Instead of resetting permissions all over the place when freeing module
memory tell the vmalloc code to do so. Avoids the exercise for the next
upcoming user.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111143.406703869@infradead.org
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/ftrace.c       | 2 --
 arch/x86/kernel/kprobes/core.c | 1 -
 arch/x86/kernel/module.c       | 8 ++++----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index fba03ad16cce..bb02d5d474c2 100644
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
index d481825f12bf..5254317125d8 100644
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
index 455e195847f9..e28c701e8f8b 100644
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
2.43.0



