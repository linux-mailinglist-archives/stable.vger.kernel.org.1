Return-Path: <stable+bounces-157081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B721BAE525D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0AB7AF417
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4F41DDC04;
	Mon, 23 Jun 2025 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sk2V+p30"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A21F5820;
	Mon, 23 Jun 2025 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714987; cv=none; b=QtLMJoXHJNNMOO3SIaSeXi+/MgO6wGhoVedcw7y9hAl/vapgHdEVHIERL4Er9TrRoBxvWkXFEZd3uIOXJ73HHGwWZxmrXI2PMjyr0eHLBDw5qrs2HbVwo+66pIpcMjrcEtOCGBDQIbRCyTUGuLZ468IdCR2ayv7tCNxmYFOnBnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714987; c=relaxed/simple;
	bh=Tgon6siZGWaxaYn3WDxTR+ligFlVIZWCQDWxb13zMck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+tTeBnOtRHPbZNWN9bM3Fa5trKo9MYMw1jUt36oo9HG7pZ+6hh3ExkBoerTDQozk02D5VVQ9b8lryYg/cPm76gHM6ffLNaGv59NPW8K6jbLCQVbwkdKgpN/L/OUDD9W8LgfAp9NvUNzY+c7637uPD1ce0Ju4VPubWGnzUXki4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sk2V+p30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27732C4CEEA;
	Mon, 23 Jun 2025 21:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714987;
	bh=Tgon6siZGWaxaYn3WDxTR+ligFlVIZWCQDWxb13zMck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sk2V+p30hWQvE//PVcMWoadSF43HAxfSW2NY/IT+xGlLi0DVJN/PbmDMHQIwUmyq6
	 pmretY88MxzkrhRvlSZhtc85GOszYbyxIBH7pH2xsrezrR6K50INDwxRWedl2NcrHp
	 RMfT2fiXgSSS8jh+bT1RRc60gw9etd0Wycd+X9hY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	Andreas Oetken <andreas.oetken@siemens-energy.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 245/355] nios2: force update_mmu_cache on spurious tlb-permission--related pagefaults
Date: Mon, 23 Jun 2025 15:07:26 +0200
Message-ID: <20250623130634.112329816@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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




