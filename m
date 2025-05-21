Return-Path: <stable+bounces-145924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D90ABFC1E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 19:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8699F4E7DF2
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6889B28033A;
	Wed, 21 May 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="KVrJXRgp"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3694223336;
	Wed, 21 May 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847813; cv=none; b=p9fQq8R2XE5bfZakVKfVfSoO0EEPtWv1A3Jd2dB7aF6CmkDB0bRQbdFfUgtArOfiSa6fbL7jEwhZ+jYXKNwx2xRDkDoBmUS+h1coDqm6WY+psh2zrQtWdkh4H//EqEDQRKSBH2s9ESFVD/8noxAwH/Xa9a4loHPEVbcIsflVoP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847813; c=relaxed/simple;
	bh=lk4vMGf4r3PvnwodoJvGl9A231dx3DNORUyrOL6YXUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkYs+SpADto4KiAzIdPPChpz/6ia9AyPmO9NfELFeTD4GlgOYgMXw/LZsvmKR/pNo3h6rxdzMLEmNOKMDmzPVGPTa8yOHB+c+yGaKTiqGzK/9DgYhiqtM72rLtV5CVjA0KEn7bu0dgDgSciahWjNBSxyG8EMLnJmGuNvWkTxU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=KVrJXRgp; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7954940755C0;
	Wed, 21 May 2025 17:16:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7954940755C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1747847809;
	bh=y257pzFbV3FsJml0EnPy+BpvzX0El1BUpFZD/WGu/Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KVrJXRgpXssrGtebbtD/z2VTAMsBKKs2oNL2cg4DlOMRen8kckXfu45O4Hqhj0gZf
	 ttBDmNuxovqc//ljm2zwW+epyeVeerrgG/XFwW8W5G91PHd7PQxyfWn8FWPjUyRULf
	 gnylj3hNFxARk0/6JEMZIe94lfwa7rPxv00Ctat0=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.15 1/1] x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()
Date: Wed, 21 May 2025 20:16:34 +0300
Message-ID: <20250521171635.848656-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521171635.848656-1-pchelkin@ispras.ru>
References: <20250521171635.848656-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

commit 4c4eb3ecc91f4fee6d6bf7cfbc1e21f2e38d19ff upstream.

Instead of resetting permissions all over the place when freeing module
memory tell the vmalloc code to do so. Avoids the exercise for the next
upcoming user.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111143.406703869@infradead.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 arch/x86/kernel/ftrace.c       | 2 --
 arch/x86/kernel/kprobes/core.c | 1 -
 arch/x86/kernel/module.c       | 9 +++++----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index c15e3bdc61e3..fee8c63e15d4 100644
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
index 99dd504307fd..2a0563780ebb 100644
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
index 183b8d541b54..af8ed77b767c 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -74,10 +74,11 @@ void *module_alloc(unsigned long size)
 		return NULL;
 
 	p = __vmalloc_node_range(size, MODULE_ALIGN,
-				    MODULES_VADDR + get_module_load_offset(),
-				    MODULES_END, gfp_mask,
-				    PAGE_KERNEL, VM_DEFER_KMEMLEAK, NUMA_NO_NODE,
-				    __builtin_return_address(0));
+				 MODULES_VADDR + get_module_load_offset(),
+				 MODULES_END, gfp_mask, PAGE_KERNEL,
+				 VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK,
+				 NUMA_NO_NODE, __builtin_return_address(0));
+
 	if (p && (kasan_module_alloc(p, size, gfp_mask) < 0)) {
 		vfree(p);
 		return NULL;
-- 
2.49.0


