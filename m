Return-Path: <stable+bounces-150696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23052ACC52C
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267DE1894DDD
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B64231830;
	Tue,  3 Jun 2025 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB/8Z/aT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98022FF2D;
	Tue,  3 Jun 2025 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949309; cv=none; b=T8emeWfnyIMVAn8zrn6PINrs7J4IN0fwwupfk0WePXRvXpGjGP9AzsmEK86nHiTzzqJ0OKdpgq0ArNmdWcQ7e3DdeZ/sqRrXf0xp/zE+DAXdcrMg8siBBDUadn9eiwKypQrbOATWBfjGZjHZqi0KwZYuxijJcDoShDs4iPjy0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949309; c=relaxed/simple;
	bh=4pWOW+RBIFHIb9q6rF9P/XHsaznjSMMvz/Eb9yQQ6HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1v4H0z7NApG9pzp3mJwBEB/1RK5Wae/uf+kpXheyMU6GuyosvN5f0zxPi+PRphdP/uneOQSQDIg7Om98aJ2maV+2PIBPNdRLEDh3VHeIK6fm6BwbJ6DnA4VkqG75EkJ4Xb7l0zMIo8VBcv27h5fB4SVeC73vqjllnkMfIBFYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB/8Z/aT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4557C4CEEF;
	Tue,  3 Jun 2025 11:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748949308;
	bh=4pWOW+RBIFHIb9q6rF9P/XHsaznjSMMvz/Eb9yQQ6HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZB/8Z/aT4mkuPcsRtLhhOGWkquLDQmB/Dk9AB94Wd/oRe4ayNEf5Lmf3V495vQOlX
	 jO8DX3W1Bv6pNHDXW1ogHht5sQx1jnbmuyXQlRQySNFWYeXa6KdZiu+akvZq2ziJbH
	 NcE4e3ImrvZFNDHxiBIrjapgVWz5u5vRHZEHBHvIzI4DA4Y88n6yckHuO4r1CgVNFh
	 CsnmFPELj+mMvoLC2Sp6QrKuW4i0k2ThFvPvIDFJhgJV0Rq++XMsHFXQHYSyVty3HA
	 VzgbmX5YSiaMtuhd00/JC8H3ExzSustMJ7SFeCSIr+077rgROC9RKYLxnB6GzIN2lA
	 37kgr0/3kbcWw==
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	=?UTF-8?q?J=FCrgen=20Gro=DF?= <jgross@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xin Li <xin@zytor.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 5/5] Revert "mm/execmem: Unify early execmem_cache behaviour"
Date: Tue,  3 Jun 2025 14:14:45 +0300
Message-ID: <20250603111446.2609381-6-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603111446.2609381-1-rppt@kernel.org>
References: <20250603111446.2609381-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

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
---
 arch/x86/mm/init_32.c   |  3 ---
 arch/x86/mm/init_64.c   |  3 ---
 include/linux/execmem.h |  8 +-------
 mm/execmem.c            | 40 +++-------------------------------------
 4 files changed, 4 insertions(+), 50 deletions(-)

diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index bb8d99e717b9..148eba50265a 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -30,7 +30,6 @@
 #include <linux/initrd.h>
 #include <linux/cpumask.h>
 #include <linux/gfp.h>
-#include <linux/execmem.h>
 
 #include <asm/asm.h>
 #include <asm/bios_ebda.h>
@@ -756,8 +755,6 @@ void mark_rodata_ro(void)
 	pr_info("Write protecting kernel text and read-only data: %luk\n",
 		size >> 10);
 
-	execmem_cache_make_ro();
-
 	kernel_set_to_readonly = 1;
 
 #ifdef CONFIG_CPA_DEBUG
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 949a447f75ec..7c4f6f591f2b 100644
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
index ca42d5e46ccc..3be35680a54f 100644
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
index 6f7a2653b280..e6c4f5076ca8 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -254,34 +254,6 @@ static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
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
-- 
2.47.2


