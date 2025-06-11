Return-Path: <stable+bounces-152401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA522AD4FD2
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 11:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2991BC0054
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 09:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D17325F998;
	Wed, 11 Jun 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kRkdPrHo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ujv5tGVR"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E623E359;
	Wed, 11 Jun 2025 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634232; cv=none; b=cmzU4NCyHgbZXG8zgci/3/42Gl4cxNbB6qHEdZuMRY5fzm//ziZcD6lU586k9BMOw0VEfo9vZIeWtRk84i0vX0aW7rkpdCQ9wXTUHiayHYCfZwKcDZ8Wn9MW99qlyLGlkwEsmEH1sP6thBfhZo5AJvi4WIQ8ozxilMHSIqjswhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634232; c=relaxed/simple;
	bh=FwAOiDl3MtvfzG9l312KJcF0MFWbjWrpxiU3nIfeY/8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SYOF/v9buzUlmtqKfzB2nuFOXRVmCioITY4BPfpmyag5VGO/WBmqkZaS8Ipjaf0iQ36qI2clGx3L1kNchWaULKuVINvlDIleExLU2Jai8jV9G1v/IrMGTgStSp5pFzuU991K0mp9gTiUjNXdHZa6xqekL6HuOp8x4qmWiPJbUdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kRkdPrHo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ujv5tGVR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:30:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749634229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKJp7pU9nvWQ2Qj5PK2ezevfZlLTwny8TAfAbshEmUM=;
	b=kRkdPrHo9k02xAkcloPbVfkguyb4Z9bBkhwOcrCRctFpQMindJ5O4fNYINx4YouM7zL0xV
	FQk8G1NC9R36NKuYunmRKSX4Whd/0KSWC1WwVRiwFaYtRaJq+mG1fRcVYb6QSZg7Fzooh1
	Scy1VllMQ5sYCMZYU3vGAsxDybzhFWYUSkOlC18KoSP2Webou3gpjLBXuZqfTPh+o6ZqKT
	Vg6sSI8A5y3O71AX6/nhZuVCMDMrOzqie+PveOQvg/cOon27gEGSMgriEoBqJiphFcoVv5
	sKrcBpOqdYqenggoHMo+qlLCXrMBYipQvZXKuME98NS9vwUx4U6EN5b82EQVlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749634229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKJp7pU9nvWQ2Qj5PK2ezevfZlLTwny8TAfAbshEmUM=;
	b=Ujv5tGVRGf8MccQuJgyfOtBJPpw3VNGTw85jHq43y0sjQVPmzBLtRufcLY6kVPDLCWFdD4
	0S8w7nlnRnk3WCBw==
From: "tip-bot2 for Mike Rapoport (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] Revert "mm/execmem: Unify early execmem_cache behaviour"
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250603111446.2609381-6-rppt@kernel.org>
References: <20250603111446.2609381-6-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963422844.406.11912503121816984749.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7cd9a11dd0c3d1dd225795ed1b5b53132888e7b5
Gitweb:        https://git.kernel.org/tip/7cd9a11dd0c3d1dd225795ed1b5b53132888e7b5
Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate:    Tue, 03 Jun 2025 14:14:45 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 Jun 2025 11:20:52 +02:00

Revert "mm/execmem: Unify early execmem_cache behaviour"

The commit d6d1e3e6580c ("mm/execmem: Unify early execmem_cache
behaviour") changed early behaviour of execemem ROX cache to allow its
usage in early x86 code that allocates text pages when
CONFIG_MITGATION_ITS is enabled.

The permission management of the pages allocated from execmem for ITS
mitigation is now completely contained in arch/x86/kernel/alternatives.c
and therefore there is no need to special case early allocations in
execmem.

This reverts commit d6d1e3e6580ca35071ad474381f053cbf1fb6414.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20250603111446.2609381-6-rppt@kernel.org
---
 arch/x86/mm/init_32.c   |  3 +---
 arch/x86/mm/init_64.c   |  3 +---
 include/linux/execmem.h |  8 +-------
 mm/execmem.c            | 40 +++-------------------------------------
 4 files changed, 4 insertions(+), 50 deletions(-)

diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 607d6a2..8a34fff 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -30,7 +30,6 @@
 #include <linux/initrd.h>
 #include <linux/cpumask.h>
 #include <linux/gfp.h>
-#include <linux/execmem.h>
 
 #include <asm/asm.h>
 #include <asm/bios_ebda.h>
@@ -749,8 +748,6 @@ void mark_rodata_ro(void)
 	pr_info("Write protecting kernel text and read-only data: %luk\n",
 		size >> 10);
 
-	execmem_cache_make_ro();
-
 	kernel_set_to_readonly = 1;
 
 #ifdef CONFIG_CPA_DEBUG
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ee66fae..fdb6cab 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -34,7 +34,6 @@
 #include <linux/gfp.h>
 #include <linux/kcore.h>
 #include <linux/bootmem_info.h>
-#include <linux/execmem.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
@@ -1392,8 +1391,6 @@ void mark_rodata_ro(void)
 	       (end - start) >> 10);
 	set_memory_ro(start, (end - start) >> PAGE_SHIFT);
 
-	execmem_cache_make_ro();
-
 	kernel_set_to_readonly = 1;
 
 	/*
diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index ca42d5e..3be3568 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -54,7 +54,7 @@ enum execmem_range_flags {
 	EXECMEM_ROX_CACHE	= (1 << 1),
 };
 
-#if defined(CONFIG_ARCH_HAS_EXECMEM_ROX) && defined(CONFIG_EXECMEM)
+#ifdef CONFIG_ARCH_HAS_EXECMEM_ROX
 /**
  * execmem_fill_trapping_insns - set memory to contain instructions that
  *				 will trap
@@ -94,15 +94,9 @@ int execmem_make_temp_rw(void *ptr, size_t size);
  * Return: 0 on success or negative error code on failure.
  */
 int execmem_restore_rox(void *ptr, size_t size);
-
-/*
- * Called from mark_readonly(), where the system transitions to ROX.
- */
-void execmem_cache_make_ro(void);
 #else
 static inline int execmem_make_temp_rw(void *ptr, size_t size) { return 0; }
 static inline int execmem_restore_rox(void *ptr, size_t size) { return 0; }
-static inline void execmem_cache_make_ro(void) { }
 #endif
 
 /**
diff --git a/mm/execmem.c b/mm/execmem.c
index 9720ac2..2b683e7 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -254,34 +254,6 @@ out_unlock:
 	return ptr;
 }
 
-static bool execmem_cache_rox = false;
-
-void execmem_cache_make_ro(void)
-{
-	struct maple_tree *free_areas = &execmem_cache.free_areas;
-	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
-	MA_STATE(mas_free, free_areas, 0, ULONG_MAX);
-	MA_STATE(mas_busy, busy_areas, 0, ULONG_MAX);
-	struct mutex *mutex = &execmem_cache.mutex;
-	void *area;
-
-	execmem_cache_rox = true;
-
-	mutex_lock(mutex);
-
-	mas_for_each(&mas_free, area, ULONG_MAX) {
-		unsigned long pages = mas_range_len(&mas_free) >> PAGE_SHIFT;
-		set_memory_ro(mas_free.index, pages);
-	}
-
-	mas_for_each(&mas_busy, area, ULONG_MAX) {
-		unsigned long pages = mas_range_len(&mas_busy) >> PAGE_SHIFT;
-		set_memory_ro(mas_busy.index, pages);
-	}
-
-	mutex_unlock(mutex);
-}
-
 static int execmem_cache_populate(struct execmem_range *range, size_t size)
 {
 	unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
@@ -302,15 +274,9 @@ static int execmem_cache_populate(struct execmem_range *range, size_t size)
 	/* fill memory with instructions that will trap */
 	execmem_fill_trapping_insns(p, alloc_size, /* writable = */ true);
 
-	if (execmem_cache_rox) {
-		err = set_memory_rox((unsigned long)p, vm->nr_pages);
-		if (err)
-			goto err_free_mem;
-	} else {
-		err = set_memory_x((unsigned long)p, vm->nr_pages);
-		if (err)
-			goto err_free_mem;
-	}
+	err = set_memory_rox((unsigned long)p, vm->nr_pages);
+	if (err)
+		goto err_free_mem;
 
 	err = execmem_cache_add(p, alloc_size);
 	if (err)

