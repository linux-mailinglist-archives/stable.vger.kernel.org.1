Return-Path: <stable+bounces-241756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEh0Bk/68GlpbgEAu9opvQ
	(envelope-from <stable+bounces-241756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:19:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7C548A934
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03822300C823
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7771647AF56;
	Tue, 28 Apr 2026 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsdXeF8v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D64477E3D;
	Tue, 28 Apr 2026 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400393; cv=none; b=Z3KCAyQYIH/Uc8n3330nJdnTmKvF0uA6/7Vg+DjlMPPiRKQDeA5kAI3PMN6buXcRZqbHYc8UhvXya9eW4flULTB9vY7ZzsKH3IC853Sl6SgzhQ+eIQGb8QAixEgorC0fxFQmAP3g+XnITLM6+TKMVaCgI1PqFjaCjOaUZB370ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400393; c=relaxed/simple;
	bh=IIgS0AwRcjrTKP1+26SpC0X687fjJgcOkUNS9W2I8Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sO1xoq3OXMa1EXHWmZRYtwZJpdWft2hBKjCoUZFZlIp1SrWzKHq3Mk7qV/gJiqhSmptP+K5no7GQhoThbEfusE7Gqnlx3loiGdI6NCidNNHtOn4Gykq5+mqztsOSyQvh8tTC9cXlxnEK3qH4Jjv/HsHNnSa6o4uOu4e20mqER5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsdXeF8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FC6C2BCAF;
	Tue, 28 Apr 2026 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777400392;
	bh=IIgS0AwRcjrTKP1+26SpC0X687fjJgcOkUNS9W2I8Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bsdXeF8vvCoI3aZG24eKRZxfzdAWS24Tyr5d/guTbpbNgNaP/scHtndlMkIvnsRG3
	 o02p+aLeVmg5gOspT/wd38/dB9ma4bujRwhMl5g96bFFgzJa83AiQtBGrtkRH6XKrG
	 U55JrlD4WY+Wyj8wOKDV1HA/dY7e8JTy8tZUJIDNB9QjsDMnPL/z/1Rn1NpUxNBBAr
	 TBKebtrYO3ZkEvAPO3ftapCQLd0Fy2O5jsAIh6U/T8ehEp+HbUdGrI0KFJXKwiUGk+
	 4nzkaNpxVqeK7rAJ+H7tgegYCsjzhaSLloyT54UfhJr92j2WLSJujfzTwIkpv83BX1
	 wA1s57OlQIt/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] arm64/mm: Enable batched TLB flush in unmap_hotplug_range()
Date: Tue, 28 Apr 2026 14:19:49 -0400
Message-ID: <20260428181949.3127002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042727-detonate-paging-829b@gregkh>
References: <2026042727-detonate-paging-829b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7D7C548A934
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241756-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email]

From: Anshuman Khandual <anshuman.khandual@arm.com>

[ Upstream commit 48478b9f791376b4b89018d7afdfd06865498f65 ]

During a memory hot remove operation, both linear and vmemmap mappings for
the memory range being removed, get unmapped via unmap_hotplug_range() but
mapped pages get freed only for vmemmap mapping. This is just a sequential
operation where each table entry gets cleared, followed by a leaf specific
TLB flush, and then followed by memory free operation when applicable.

This approach was simple and uniform both for vmemmap and linear mappings.
But linear mapping might contain CONT marked block memory where it becomes
necessary to first clear out all entire in the range before a TLB flush.
This is as per the architecture requirement. Hence batch all TLB flushes
during the table tear down walk and finally do it in unmap_hotplug_range().

Prior to this fix, it was hypothetically possible for a speculative access
to a higher address in the contiguous block to fill the TLB with shattered
entries for the entire contiguous range after a lower address had already
been cleared and invalidated. Due to the table entries being shattered, the
subsequent TLB invalidation for the higher address would not then clear the
TLB entries for the lower address, meaning stale TLB entries could persist.

Besides it also helps in improving the performance via TLBI range operation
along with reduced synchronization instructions. The time spent executing
unmap_hotplug_range() improved 97% measured over a 2GB memory hot removal
in KVM guest.

This scheme is not applicable during vmemmap mapping tear down where memory
needs to be freed and hence a TLB flush is required after clearing out page
table entry.

Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Closes: https://lore.kernel.org/all/aWZYXhrT6D2M-7-N@willie-the-truck/
Fixes: bbd6ec605c0f ("arm64/mm: Enable memory hot remove")
Cc: stable@vger.kernel.org
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ replaced `__pte_clear()` with `pte_clear()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/mmu.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e9288b28cb1e3..cbba5e73099fe 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -925,10 +925,14 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 
 		WARN_ON(!pte_present(pte));
 		pte_clear(&init_mm, addr, ptep);
-		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-		if (free_mapped)
+		if (free_mapped) {
+			/* CONT blocks are not supported in the vmemmap */
+			WARN_ON(pte_cont(pte));
+			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 			free_hotplug_page_range(pte_page(pte),
 						PAGE_SIZE, altmap);
+		}
+		/* unmap_hotplug_range() flushes TLB for !free_mapped */
 	} while (addr += PAGE_SIZE, addr < end);
 }
 
@@ -949,15 +953,14 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
 		WARN_ON(!pmd_present(pmd));
 		if (pmd_sect(pmd)) {
 			pmd_clear(pmdp);
-
-			/*
-			 * One TLBI should be sufficient here as the PMD_SIZE
-			 * range is mapped with a single block entry.
-			 */
-			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-			if (free_mapped)
+			if (free_mapped) {
+				/* CONT blocks are not supported in the vmemmap */
+				WARN_ON(pmd_cont(pmd));
+				flush_tlb_kernel_range(addr, addr + PMD_SIZE);
 				free_hotplug_page_range(pmd_page(pmd),
 							PMD_SIZE, altmap);
+			}
+			/* unmap_hotplug_range() flushes TLB for !free_mapped */
 			continue;
 		}
 		WARN_ON(!pmd_table(pmd));
@@ -982,15 +985,12 @@ static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
 		WARN_ON(!pud_present(pud));
 		if (pud_sect(pud)) {
 			pud_clear(pudp);
-
-			/*
-			 * One TLBI should be sufficient here as the PUD_SIZE
-			 * range is mapped with a single block entry.
-			 */
-			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-			if (free_mapped)
+			if (free_mapped) {
+				flush_tlb_kernel_range(addr, addr + PUD_SIZE);
 				free_hotplug_page_range(pud_page(pud),
 							PUD_SIZE, altmap);
+			}
+			/* unmap_hotplug_range() flushes TLB for !free_mapped */
 			continue;
 		}
 		WARN_ON(!pud_table(pud));
@@ -1020,6 +1020,7 @@ static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
 static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 				bool free_mapped, struct vmem_altmap *altmap)
 {
+	unsigned long start = addr;
 	unsigned long next;
 	pgd_t *pgdp, pgd;
 
@@ -1041,6 +1042,9 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 		WARN_ON(!pgd_present(pgd));
 		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
+
+	if (!free_mapped)
+		flush_tlb_kernel_range(start, end);
 }
 
 static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,
-- 
2.53.0


