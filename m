Return-Path: <stable+bounces-203384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB3DCDCF3E
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 18:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AE98306E26F
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 17:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36A2328243;
	Wed, 24 Dec 2025 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="azpTgwXx"
X-Original-To: stable@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10691314D2F;
	Wed, 24 Dec 2025 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766597655; cv=none; b=hEZ0IXk+ygVgvuVtPs0tL5ydr91xtw+3I0g3XPGUxky/lrNOeg3WxqjREmOlAbGsXa+KTi2G3c4PEDWtmQglWtU4bVYEcTZGUenO7DmUCgnmwhrRa9Seqlm+gva8d6xZ9BYw+ZE9eIwhbxsl+wQJrFl1VhkF5Mvfrj0igO6P7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766597655; c=relaxed/simple;
	bh=atWssxs+RIcjWyqrHPYSzQAP5QOUdHyokABMAGKdIkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1yv3I3IrfNiTSu11UIVq0CJTueY47KW37JV7MizIpYAQWFPNCjWmKz++m/CtF6VOBzssdG3gpHKIClkuX5Wk5oVeULx55QCrN3yZpZndwplVyK50hF3jOoOklHT1A5xvLnx3IfHWMSX5YWDLC0a2YgzJ5pR17r16q7kElHy4ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=azpTgwXx; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1766597645;
	bh=WIh1XzVs83L7IUYypMXcMemNQQ0OLf+PJujjXTHlUNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azpTgwXxj0eWzpifwpvE/easXXJA1SasvPI3MXVrTCE0gfqrkvb3denE9UoKHQKr4
	 WJU2h/pONKmiU8CDPPYQYKm6TwgFUAM1FiF5sKOsjaG3tFfXEoU5DbmfvP1dJL6TF3
	 Jwd+PyGrO2g2bLMnk1LuLnzXMFhGU/nYtLisiWHv8xuoSFDJQp7LM+Rh+KioSrvOmp
	 W6XlG6TfMMe7eu6lL6ierMwvJ3wFhbWO9buO3LM1I62Oiei0+ytfkbuSgAhjweTUT3
	 BKdUdEgJ2lpleMXSeGKDxJQ+iplAWpL8ca5z87F12ZkpHcxsexTgQc7GMKloh484lM
	 FcGFA3UfPh/uA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4dbzWd5XcRzfHr;
	Wed, 24 Dec 2025 12:34:05 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	stable@vger.kernel.org,
	linux-mm@kvack.org,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/3] mm: Take into account mm_cid size for mm_struct static definitions
Date: Wed, 24 Dec 2025 12:33:58 -0500
Message-Id: <20251224173358.647691-4-mathieu.desnoyers@efficios.com>
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

Both init_mm and efi_mm static definitions need to make room for the
2 mm_cid cpumasks.

This fixes possible out-of-bounds accesses to init_mm and efi_mm.

Add a space between # and define for the mm_alloc_cid() definition to
make it consistent with the coding style used in the rest of this header
file.

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
index 110b319a2ffb..aa4639888f89 100644
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
 
+/* Use 2 * NR_CPUS as worse case for static allocation. */
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


