Return-Path: <stable+bounces-148864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F132ACA79B
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 03:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED9B18878CE
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2585280333;
	Sun,  1 Jun 2025 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2RjZdor"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57242C1048;
	Sun,  1 Jun 2025 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821500; cv=none; b=Ps+L4xCuBp9ZjxAiBHFZRb2t/5nJoOK/ajJnQ6nr7wj9VHQeB+zL6du3WjG1+1lxDSHajrSTO3N9V2YIRwcMp9YyvpZf9qqThiX3wpW+aQAT3GqlQgUhuJY5zUmI7w984NtAxw47ROmguDGVz6JpJoAgOlSRGo+cg1wdwWpUaFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821500; c=relaxed/simple;
	bh=vnvLqyBIVwfZvNLvrQzF2E/E0/diNDCTCISSGGMsA0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mPBu42V5zwSV37neT+PdQfKjRTOZn/gE/21BtGwqjik7mOSeXTqa9s7BmTGQdmM0N/waNjcT1wRTQxULJFcNCzeCI8xt3PtjTsiYgYsINcdTM+doopURCHMU7KJlre2xtvgFqbEMhW2pjgGmo+3qu1Q+zCMy6S/1WYORV3yQHHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2RjZdor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2A2C4CEE7;
	Sun,  1 Jun 2025 23:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821500;
	bh=vnvLqyBIVwfZvNLvrQzF2E/E0/diNDCTCISSGGMsA0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2RjZdorOOUtMtgjC4wSBLB5ZEma4mi0W7/VYLCJzJnkEzYC52b7tMRnyfcpVVHzE
	 h4nFDXwmBolazUPF2mzVyR4eeGnHot/J1mfkmnAfFWBfv+mJq81M7O7mlpBmj6ipsR
	 /Ryqd2Hsww3xfHVKif21CShxkJMcfkiS4cISPtAPDgeCqTNUymiq2lWzwmD8d+ibao
	 OcVNTfYyxMiCpuYcdw8TXAzmkdkLZ3A9uAWKYYBI4eZIsNemQoNSMp2ajI0Et2HFWo
	 rfPy4TdyBqcAJmlAhRMiqnyAo3yLnbWOE9haR8mgCjaZ/JAas9kEjaGJJyRMC4wi3i
	 cujON7ioTlRlQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Simon Schuster <schuster.simon@siemens-energy.com>,
	Andreas Oetken <andreas.oetken@siemens-energy.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 26/34] nios2: force update_mmu_cache on spurious tlb-permission--related pagefaults
Date: Sun,  1 Jun 2025 19:43:50 -0400
Message-Id: <20250601234359.3518595-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601234359.3518595-1-sashal@kernel.org>
References: <20250601234359.3518595-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Simon Schuster <schuster.simon@siemens-energy.com>

[ Upstream commit 2d8a3179ea035f9341b6a73e5ba4029fc67e983d ]

NIOS2 uses a software-managed TLB for virtual address translation. To
flush a cache line, the original mapping is replaced by one to physical
address 0x0 with no permissions (rwx mapped to 0) set. This can lead to
TLB-permission--related traps when such a nominally flushed entry is
encountered as a mapping for an otherwise valid virtual address within a
process (e.g. due to an MMU-PID-namespace rollover that previously
flushed the complete TLB including entries of existing, running
processes).

The default ptep_set_access_flags implementation from mm/pgtable-generic.c
only forces a TLB-update when the page-table entry has changed within the
page table:

	/*
	 * [...] We return whether the PTE actually changed, which in turn
	 * instructs the caller to do things like update__mmu_cache. [...]
	 */
	int ptep_set_access_flags(struct vm_area_struct *vma,
				  unsigned long address, pte_t *ptep,
				  pte_t entry, int dirty)
	{
		int changed = !pte_same(*ptep, entry);
		if (changed) {
			set_pte_at(vma->vm_mm, address, ptep, entry);
			flush_tlb_fix_spurious_fault(vma, address);
		}
		return changed;
	}

However, no cross-referencing with the TLB-state occurs, so the
flushing-induced pseudo entries that are responsible for the pagefault
in the first place are never pre-empted from TLB on this code path.

This commit fixes this behaviour by always requesting a TLB-update in
this part of the pagefault handling, fixing spurious page-faults on the
way. The handling is a straightforward port of the logic from the MIPS
architecture via an arch-specific ptep_set_access_flags function ported
from arch/mips/include/asm/pgtable.h.

Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
Signed-off-by: Andreas Oetken <andreas.oetken@siemens-energy.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees for the
following reasons: **1. Fixes a Real User-Affecting Bug:** The commit
addresses infinite page fault loops that can occur when: - NIOS2's
software-managed TLB encounters spurious permission-related page faults
- TLB entries flushed to physical address 0x0 with no permissions
persist due to MMU-PID-namespace rollovers - The generic
`ptep_set_access_flags` implementation fails to flush these stale TLB
entries because it only flushes when the PTE actually changes in the
page table **2. Small, Contained Fix:** The code change is minimal and
surgical: - Adds an arch-specific `ptep_set_access_flags` function in
`arch/nios2/include/asm/pgtable.h:284-297` - Always returns `true` to
force `update_mmu_cache` execution, ensuring TLB invalidation even when
the PTE hasn't changed - Identical pattern to MIPS architecture
(arch/mips/include/asm/pgtable.h), proven and stable **3. Architecture-
Specific with No Side Effects:** - Only affects NIOS2 architecture
(`arch/nios2/include/asm/pgtable.h`) - No cross-architecture
dependencies or changes to core MM code - Uses existing `set_ptes()` and
`update_mmu_cache` infrastructure **4. Consistent with Similar
Backported Fixes:** - Similar commit #5 (xtensa: define update_mmu_tlb
function) was marked **YES** for backport with `Cc:
stable@vger.kernel.org # 5.12+` - Both fix TLB invalidation issues in
software-managed TLB architectures - Both address spurious page fault
scenarios **5. Meets Stable Tree Criteria:** - **Important bugfix**:
Prevents infinite page fault loops - **Minimal risk**: Architecture-
specific, follows proven MIPS pattern - **No architectural changes**:
Uses existing MM infrastructure - **Confined to subsystem**: Limited to
NIOS2 TLB management The fix directly addresses a critical reliability
issue where users experience system hangs due to infinite page faults,
making it an ideal candidate for stable backporting.

 arch/nios2/include/asm/pgtable.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index 2600d76c310c4..966fef8249bbb 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -277,4 +277,20 @@ extern void __init mmu_init(void);
 extern void update_mmu_cache(struct vm_area_struct *vma,
 			     unsigned long address, pte_t *pte);
 
+static inline int pte_same(pte_t pte_a, pte_t pte_b);
+
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+static inline int ptep_set_access_flags(struct vm_area_struct *vma,
+					unsigned long address, pte_t *ptep,
+					pte_t entry, int dirty)
+{
+	if (!pte_same(*ptep, entry))
+		set_ptes(vma->vm_mm, address, ptep, entry, 1);
+	/*
+	 * update_mmu_cache will unconditionally execute, handling both
+	 * the case that the PTE changed and the spurious fault case.
+	 */
+	return true;
+}
+
 #endif /* _ASM_NIOS2_PGTABLE_H */
-- 
2.39.5


