Return-Path: <stable+bounces-203171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FD5CD467E
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 00:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 724483011763
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 23:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FC727B34C;
	Sun, 21 Dec 2025 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BDynJwA1"
X-Original-To: stable@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD38274B59;
	Sun, 21 Dec 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766359794; cv=none; b=catG8duNQ/MleOD6luOLRhJ+fsMRAm49QhDd9nXWzGy964gQiJ7JGYgWhBIIMKhXU7I33Qcx7ptmhGWxmX5KR6pWjL1kNrWrWj9TGf3VStMmwWv/qqP5KKvP8TyMWEEKZVoMyhw+eQkrNYtqePNzllnNTWHH50x21pWW5VEEhW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766359794; c=relaxed/simple;
	bh=Qu/8yBXNwPGMsne8fZEEcokOzBlM9xcKPglJ5w2Mfm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NRyvwpvfFCz0LYYlt4UhGaGC/zYvslpVSiC+8n/APKJNYJbaG94jTf5bi86tR6N6hFKwRlgYSAZtSBbfcmdvrrTTDXFATvdExuz6DGJ6b6INqICZX65vxMZzUoZNaRrFS8mplIx8CRG8pkq4UdK4prtrL3z5bPm4HkhNXFK0hTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BDynJwA1; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1766359786;
	bh=BwRzldu+F4s2f+1UG2tsdvjihgMmQTawixFjZ+I2lJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDynJwA1o3ZkMUeveOgh/2mXgYNsnF7uNZY8CLwxVzfhteYUMZoapgvSgZ0Kh42Vg
	 mgTr5QfA/KJ8+E6xtp387SpJ+iazYrgmw89GHzNJ8w6vjRahtEJNI3HHzMYKgVkglE
	 gJOxN1R2zDSTgte0OaARVZCfKcdAwQYMAF3gkaY7gjiBZHdSE/VAcg1xjztTSuuzen
	 tIE/eOp9HEujiaosjuoYtZc6a9b1S4chzDKhNHwmWNXWNPwVKKuahiIL/NXW476z1W
	 0580dy9d++YNzEfeJtwMzM4zVjh3GvKWLiKuK1kd0ncVpBHiKhYl7YzGqL2Gv4RjzH
	 JDYiy0VryddCg==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:6450:b8a1:16cf:5ecf])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4dZHYQ2Lrjzd8P;
	Sun, 21 Dec 2025 18:29:46 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Brown <broonie@kernel.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH v1 3/5] mm: Take into account mm_cid size for mm_struct static definitions
Date: Sun, 21 Dec 2025 18:29:24 -0500
Message-Id: <20251221232926.450602-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251221232926.450602-1-mathieu.desnoyers@efficios.com>
References: <20251221232926.450602-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both init_mm and efi_mm static definitions need to make room for the
2 mm_cid cpumasks.

This fixes possible out-of-bounds accesses to init_mm and efi_mm.

Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mm_types.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1531df8cda52..aefa64db3499 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1368,7 +1368,7 @@ extern struct mm_struct init_mm;
 
 #define MM_STRUCT_FLEXIBLE_ARRAY_INIT				\
 {								\
-	[0 ... sizeof(cpumask_t)-1] = 0				\
+	[0 ... sizeof(cpumask_t) + MM_CID_STATIC_SIZE - 1] = 0	\
 }
 
 /* Pointer magic because the dynamic array size confuses some compilers. */
@@ -1500,7 +1500,7 @@ static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *
 	mm_init_cid(mm, p);
 	return 0;
 }
-#define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
+# define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
 
 static inline void mm_destroy_cid(struct mm_struct *mm)
 {
@@ -1514,6 +1514,8 @@ static inline unsigned int mm_cid_size(void)
 	return cpumask_size() + bitmap_size(num_possible_cpus());
 }
 
+/* Use NR_CPUS as worse case for static allocation. */
+# define MM_CID_STATIC_SIZE	(2 * sizeof(cpumask_t))
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p) { }
 static inline int mm_alloc_cid(struct mm_struct *mm, struct task_struct *p) { return 0; }
@@ -1522,6 +1524,7 @@ static inline unsigned int mm_cid_size(void)
 {
 	return 0;
 }
+# define MM_CID_STATIC_SIZE	0
 #endif /* CONFIG_SCHED_MM_CID */
 
 struct mmu_gather;
-- 
2.39.5


