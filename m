Return-Path: <stable+bounces-132184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D39EA84FC3
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 00:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D27A9A67C1
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 22:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8070920E003;
	Thu, 10 Apr 2025 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UY5a0are"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2991FC10E;
	Thu, 10 Apr 2025 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744325246; cv=none; b=So3FQXjvpgB9JbeEOeXcGEtQClvDx556rz0uKitS9cjqr4BjoPAZ7kJCu+rWJIoXAWzSw1JtCaDRvtOuY+i21veFdJJBJ+i5DcPn+yTWTt06KZ1s1q7LtM9tLTqLVbCbbsizMPaWXGQ3I8BvViOWAWO6xQvH0cx4zALNXSZI0VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744325246; c=relaxed/simple;
	bh=A0AX2SSzwAMhx3O4Dv35nEotZnC+gkbL/BacOIQobAw=;
	h=Date:To:From:Subject:Message-Id; b=eBaJ8hiDQN2kLOM6fOLtrgUibRKbLQhSSUmT/dQjy2FMEa15YWiBf54JC8LLSRjZzB41Zvl8g9t57SiM1pNmnPFsLnZc1ZHKIbe4jETOsTlyyUc/RnqhCaOMwnc+TPQjpQold+romDAI5SPHzQdfFbU2aL0ujWFeVnuG4/VXNEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UY5a0are; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A094EC4CEEA;
	Thu, 10 Apr 2025 22:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744325245;
	bh=A0AX2SSzwAMhx3O4Dv35nEotZnC+gkbL/BacOIQobAw=;
	h=Date:To:From:Subject:From;
	b=UY5a0areTC9vNHtoeYMqP7HKEkaLm9Q3qjLbzyyv+hP5ZIPhPTzE4jzwAyDhq74AA
	 Wz2y5z4d/eRUP14+T9wyRL8o8tvteDTB/rid12Ff6ie7JMRxDEIqByqonHhH8XB6Js
	 2FSH7ABwitYT88nVAHlp9fizyfAdQSECp9Lkg5yA=
Date: Thu, 10 Apr 2025 15:47:25 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,ryabinin.a.a@gmail.com,npiggin@gmail.com,linux@roeck-us.net,jgross@suse.com,jeremy@goop.org,hughd@google.com,agordeev@linux.ibm.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [to-be-updated] mm-cleanup-apply_to_pte_range-routine.patch removed from -mm tree
Message-Id: <20250410224725.A094EC4CEEA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm: clean up apply_to_pte_range()
has been removed from the -mm tree.  Its filename was
     mm-cleanup-apply_to_pte_range-routine.patch

This patch was dropped because an updated version will be issued

------------------------------------------------------
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: mm: clean up apply_to_pte_range()
Date: Tue, 8 Apr 2025 18:07:31 +0200

Reverse 'create' vs 'mm == &init_mm' conditions and move page table mask
modification out of the atomic context.  This is a prerequisite for fixing
missing kernel page tables lock.

Link: https://lkml.kernel.org/r/0c65bc334f17ff1d7d92d31c69d7065769bbce4e.1744128123.git.agordeev@linux.ibm.com
Fixes: 38e0edb15bd0 ("mm/apply_to_range: call pte function with lazy updates")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Guenetr Roeck <linux@roeck-us.net>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Juegren Gross <jgross@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memory.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

--- a/mm/memory.c~mm-cleanup-apply_to_pte_range-routine
+++ a/mm/memory.c
@@ -2915,24 +2915,28 @@ static int apply_to_pte_range(struct mm_
 				     pte_fn_t fn, void *data, bool create,
 				     pgtbl_mod_mask *mask)
 {
+	int err = create ? -ENOMEM : -EINVAL;
 	pte_t *pte, *mapped_pte;
-	int err = 0;
 	spinlock_t *ptl;
 
-	if (create) {
-		mapped_pte = pte = (mm == &init_mm) ?
-			pte_alloc_kernel_track(pmd, addr, mask) :
-			pte_alloc_map_lock(mm, pmd, addr, &ptl);
+	if (mm == &init_mm) {
+		if (create)
+			pte = pte_alloc_kernel_track(pmd, addr, mask);
+		else
+			pte = pte_offset_kernel(pmd, addr);
 		if (!pte)
-			return -ENOMEM;
+			return err;
 	} else {
-		mapped_pte = pte = (mm == &init_mm) ?
-			pte_offset_kernel(pmd, addr) :
-			pte_offset_map_lock(mm, pmd, addr, &ptl);
+		if (create)
+			pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
+		else
+			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 		if (!pte)
-			return -EINVAL;
+			return err;
+		mapped_pte = pte;
 	}
 
+	err = 0;
 	arch_enter_lazy_mmu_mode();
 
 	if (fn) {
@@ -2944,12 +2948,14 @@ static int apply_to_pte_range(struct mm_
 			}
 		} while (addr += PAGE_SIZE, addr != end);
 	}
-	*mask |= PGTBL_PTE_MODIFIED;
 
 	arch_leave_lazy_mmu_mode();
 
 	if (mm != &init_mm)
 		pte_unmap_unlock(mapped_pte, ptl);
+
+	*mask |= PGTBL_PTE_MODIFIED;
+
 	return err;
 }
 
_

Patches currently in -mm which might be from agordeev@linux.ibm.com are

mm-protect-kernel-pgtables-in-apply_to_pte_range.patch


