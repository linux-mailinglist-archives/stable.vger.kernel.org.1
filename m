Return-Path: <stable+bounces-203382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BE9CDCF38
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 18:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14EAB303E660
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 17:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D451430DEBC;
	Wed, 24 Dec 2025 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="wPGl1lV8"
X-Original-To: stable@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A39237163;
	Wed, 24 Dec 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766597653; cv=none; b=D6vUn2MMfIt7Lb9VNTk+xJ62FGE5HTX00V0t7aZxVHJJMeOR+p2eirnQwZUtE3veFUhT5WIE9IJrDXa8oLwt6bFMsDmJ5K/WMZvGbxIeiwnE2HktR6qs+YXtDlRf5KZUcs/aVXIywwJhl5KtrrRZyx2A9GvuHrjrMk4XRCFVBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766597653; c=relaxed/simple;
	bh=dpDggfA1CUPIWadnRIUWexZZYKzKAFim45G5ZHnxFZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G0fICvDbnEGKAvMcZfy6dyBZn6SCX9jmDn7KQ24DiZbYuYlGc//lo0VvruX5h55TcA3b3m0NDc7E4dKmxyd4K6GiiJ9/XdjkqpM8eP8+6w/gE4LfVyGrD++9HjJS4kvY6urerjR2rnm4uVjuwa+ED1Pmrwu2zWFUjZqrVGKJ8JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=wPGl1lV8; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1766597645;
	bh=2CDN18JsLQ2lkxbVIsQQjPwRxfXSOdUFY21zfgGMtQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wPGl1lV8BtmA4wS9kzpWh8wFbWbXztbx81F3m8K9r6NMNkeUCc7vFctVGUWmcmiQr
	 Rj8lbZL82zZVEyBSvdbVlpmqpRpB1InHW2RfF6sQCI/bjZu4CaLolZEYt8XN600fGd
	 1l0Mlu9P9U+WY5noI8j8mDBoQs+LbILtIS4Ia+j7qulcXMQis7kD9gXQoCc0eo1/nU
	 Qi+9AiHBzkSuy7d5379rWGrNdcFtYNuxEZSCnriXfaMEvzKREX3ZJoHVxfoqoSOcyf
	 6oNSC3IfoQehKI/qSrOZWderVFIdT8SexI/hyIGs/3bXjVWJdM8GjfZ3BZG610ABvI
	 ck8PPcc17Z26g==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4dbzWd4H7lzfHq;
	Wed, 24 Dec 2025 12:34:05 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	stable@vger.kernel.org,
	linux-mm@kvack.org,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/3] mm: Rename cpu_bitmap field to flexible_array
Date: Wed, 24 Dec 2025 12:33:57 -0500
Message-Id: <20251224173358.647691-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251224173358.647691-1-mathieu.desnoyers@efficios.com>
References: <20251224173358.647691-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpu_bitmap flexible array now contains more than just the
cpu_bitmap. In preparation for changing the static mm_struct
definitions to cover for the additional space required, change the
cpu_bitmap type from "unsigned long" to "char", require an unsigned long
alignment of the flexible array, and rename the field from "cpu_bitmap"
to "flexible_array".

Introduce the MM_STRUCT_FLEXIBLE_ARRAY_INIT macro to statically
initialize the flexible array. This covers the init_mm and efi_mm
static definitions.

This is a preparation step for fixing the missing mm_cid size for static
mm_struct definitions.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Cc: linux-mm@kvack.org
---
 drivers/firmware/efi/efi.c |  2 +-
 include/linux/mm_types.h   | 13 +++++++++----
 mm/init-mm.c               |  2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index a9070d00b833..3f5c2ae50024 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -73,10 +73,10 @@ struct mm_struct efi_mm = {
 	MMAP_LOCK_INITIALIZER(efi_mm)
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
-	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
 #ifdef CONFIG_SCHED_MM_CID
 	.mm_cid.lock		= __RAW_SPIN_LOCK_UNLOCKED(efi_mm.mm_cid.lock),
 #endif
+	.flexible_array		= MM_STRUCT_FLEXIBLE_ARRAY_INIT,
 };
 
 struct workqueue_struct *efi_rts_wq;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 42af2292951d..110b319a2ffb 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1329,7 +1329,7 @@ struct mm_struct {
 	 * The mm_cpumask needs to be at the end of mm_struct, because it
 	 * is dynamically sized based on nr_cpu_ids.
 	 */
-	unsigned long cpu_bitmap[];
+	char flexible_array[] __aligned(__alignof__(unsigned long));
 };
 
 /* Copy value to the first system word of mm flags, non-atomically. */
@@ -1366,19 +1366,24 @@ static inline void __mm_flags_set_mask_bits_word(struct mm_struct *mm,
 			 MT_FLAGS_USE_RCU)
 extern struct mm_struct init_mm;
 
+#define MM_STRUCT_FLEXIBLE_ARRAY_INIT				\
+{								\
+	[0 ... sizeof(cpumask_t)-1] = 0				\
+}
+
 /* Pointer magic because the dynamic array size confuses some compilers. */
 static inline void mm_init_cpumask(struct mm_struct *mm)
 {
 	unsigned long cpu_bitmap = (unsigned long)mm;
 
-	cpu_bitmap += offsetof(struct mm_struct, cpu_bitmap);
+	cpu_bitmap += offsetof(struct mm_struct, flexible_array);
 	cpumask_clear((struct cpumask *)cpu_bitmap);
 }
 
 /* Future-safe accessor for struct mm_struct's cpu_vm_mask. */
 static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
 {
-	return (struct cpumask *)&mm->cpu_bitmap;
+	return (struct cpumask *)&mm->flexible_array;
 }
 
 #ifdef CONFIG_LRU_GEN
@@ -1469,7 +1474,7 @@ static inline cpumask_t *mm_cpus_allowed(struct mm_struct *mm)
 {
 	unsigned long bitmap = (unsigned long)mm;
 
-	bitmap += offsetof(struct mm_struct, cpu_bitmap);
+	bitmap += offsetof(struct mm_struct, flexible_array);
 	/* Skip cpu_bitmap */
 	bitmap += cpumask_size();
 	return (struct cpumask *)bitmap;
diff --git a/mm/init-mm.c b/mm/init-mm.c
index a514f8ce47e3..c5556bb9d5f0 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -47,7 +47,7 @@ struct mm_struct init_mm = {
 #ifdef CONFIG_SCHED_MM_CID
 	.mm_cid.lock = __RAW_SPIN_LOCK_UNLOCKED(init_mm.mm_cid.lock),
 #endif
-	.cpu_bitmap	= CPU_BITS_NONE,
+	.flexible_array	= MM_STRUCT_FLEXIBLE_ARRAY_INIT,
 	INIT_MM_CONTEXT(init_mm)
 };
 
-- 
2.39.5


