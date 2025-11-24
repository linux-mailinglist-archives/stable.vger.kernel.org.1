Return-Path: <stable+bounces-196769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D33C81DD0
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 18:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6DD3A4041
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 17:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFC01C5D72;
	Mon, 24 Nov 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5k5cuvT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F7258CE2
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004642; cv=none; b=faKQOs7KjZBOV+2QE1p4lfnAOxrNwk4t7tGwQ6WfoAhSCnslokulDrF2tx/fSSf0PtR1B7QXqswaBcbrO3sgu3Gg4vL9XxByF2W9u9A6UA065HmHn/kTFtnr/HdQJpzX0PGbVfpQeUGCTI9NkmEkXgDy8/ot4O9b1R+WkKEHQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004642; c=relaxed/simple;
	bh=3IVlH/BmEL7ZwvQnDmDQqe2KdwvLwDZ2pI/M4hSkyF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKxs5X2i+33iN/34znY9tdAurKCpuYNqAZTJYEoRyEkxA0Bl4jMc4VftLopJF4sy5BphNxCX9zIlQ9BT6cgSREKfXK/cuIvVOtvAIzqGNYa2zBPLD+VQhHvokw+Ynbrvyh7t+WVB6h9Huv5KmYEcbZWadcMZQjFdWNYb1QI4a1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5k5cuvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCA0C116C6;
	Mon, 24 Nov 2025 17:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764004642;
	bh=3IVlH/BmEL7ZwvQnDmDQqe2KdwvLwDZ2pI/M4hSkyF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O5k5cuvT8HqKbJte/IL/+Ur8Ge6n3GUWPVPCZD87sir4y5cCp9CRi+o9m9K0yoLd/
	 idsj8KEhADt32qVHTZjcjpumlISPAUpP+ST8eIdGxPuDzmYMLkEdZMUBvV00u8YPb3
	 sUv8kYyi31+dEwlv5s29K1Mvyz3Jxd4VwdatlKCWFaH7LrBzQZcoKDfLulB0DdikRm
	 bHw5PN+KM6TEr9K0dA6NgHXD2GqImacCfBmhSezPkRcgSvlRu8o7V8eWXIw4e+CaU4
	 IWcEm6NoLkmOCPylYQ2k7izBxhf4NM0CRCH3y1PSmUd87QdBHHhDjcVof6OxQzjsk1
	 wH0Grze4ntlyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] s390/cpufeature: Convert MACHINE_HAS_RDP to cpu_has_rdp()
Date: Mon, 24 Nov 2025 12:17:18 -0500
Message-ID: <20251124171719.4158053-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124171719.4158053-1-sashal@kernel.org>
References: <2025112418-impish-remix-d936@gregkh>
 <20251124171719.4158053-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 15a36036e792f4eec0fc59833dde688024e036fc ]

Convert MACHINE_HAS_... to cpu_has_...() which uses test_facility() instead
of testing the machine_flags lowcore member if the feature is present.

test_facility() generates better code since it results in a static branch
without accessing memory. The branch is patched via alternatives by the
decompressor depending on the availability of the required facility.

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Stable-dep-of: 31475b88110c ("s390/mm: Fix __ptep_rdp() inline assembly")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/cpufeature.h | 1 +
 arch/s390/include/asm/pgtable.h    | 5 +++--
 arch/s390/include/asm/setup.h      | 2 --
 arch/s390/kernel/early.c           | 2 --
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/cpufeature.h b/arch/s390/include/asm/cpufeature.h
index 496d0758b902f..641a2780fd5a6 100644
--- a/arch/s390/include/asm/cpufeature.h
+++ b/arch/s390/include/asm/cpufeature.h
@@ -22,6 +22,7 @@ enum {
 
 int cpu_have_feature(unsigned int nr);
 
+#define cpu_has_rdp()		test_facility(194)
 #define cpu_has_seq_insn()	test_facility(85)
 
 #endif /* __ASM_S390_CPUFEATURE_H */
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 5ee73f245a0c0..4714640f0c403 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -14,6 +14,7 @@
 
 #include <linux/sched.h>
 #include <linux/mm_types.h>
+#include <linux/cpufeature.h>
 #include <linux/page-flags.h>
 #include <linux/radix-tree.h>
 #include <linux/atomic.h>
@@ -1302,7 +1303,7 @@ static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
 	 * PTE does not have _PAGE_PROTECT set, to avoid unnecessary overhead.
 	 * A local RDP can be used to do the flush.
 	 */
-	if (MACHINE_HAS_RDP && !(pte_val(*ptep) & _PAGE_PROTECT))
+	if (cpu_has_rdp() && !(pte_val(*ptep) & _PAGE_PROTECT))
 		__ptep_rdp(address, ptep, 0, 0, 1);
 }
 #define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
@@ -1317,7 +1318,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 {
 	if (pte_same(*ptep, entry))
 		return 0;
-	if (MACHINE_HAS_RDP && !mm_has_pgste(vma->vm_mm) && pte_allow_rdp(*ptep, entry))
+	if (cpu_has_rdp() && !mm_has_pgste(vma->vm_mm) && pte_allow_rdp(*ptep, entry))
 		ptep_reset_dat_prot(vma->vm_mm, addr, ptep, entry);
 	else
 		ptep_xchg_direct(vma->vm_mm, addr, ptep, entry);
diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index 50b943f301553..07e7dab27dfac 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -33,7 +33,6 @@
 #define MACHINE_FLAG_GS		BIT(16)
 #define MACHINE_FLAG_SCC	BIT(17)
 #define MACHINE_FLAG_PCI_MIO	BIT(18)
-#define MACHINE_FLAG_RDP	BIT(19)
 
 #define LPP_MAGIC		BIT(31)
 #define LPP_PID_MASK		_AC(0xffffffff, UL)
@@ -94,7 +93,6 @@ extern unsigned long mio_wb_bit_mask;
 #define MACHINE_HAS_GS		(get_lowcore()->machine_flags & MACHINE_FLAG_GS)
 #define MACHINE_HAS_SCC		(get_lowcore()->machine_flags & MACHINE_FLAG_SCC)
 #define MACHINE_HAS_PCI_MIO	(get_lowcore()->machine_flags & MACHINE_FLAG_PCI_MIO)
-#define MACHINE_HAS_RDP		(get_lowcore()->machine_flags & MACHINE_FLAG_RDP)
 
 /*
  * Console mode. Override with conmode=
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 4d0112adbcaa6..a6f248ea01007 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -267,8 +267,6 @@ static __init void detect_machine_facilities(void)
 		get_lowcore()->machine_flags |= MACHINE_FLAG_PCI_MIO;
 		/* the control bit is set during PCI initialization */
 	}
-	if (test_facility(194))
-		get_lowcore()->machine_flags |= MACHINE_FLAG_RDP;
 }
 
 static inline void save_vector_registers(void)
-- 
2.51.0


