Return-Path: <stable+bounces-241401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDsoIkmS72nRCwEAu9opvQ
	(envelope-from <stable+bounces-241401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:43:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAFC4769B4
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 640A7301410A
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E26A3D170C;
	Mon, 27 Apr 2026 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vWYmEbMc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4209D37C927
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308183; cv=none; b=ND5b100GFoUsVjG4Iblawg3KyBv7X1Bimma1R+ZwIMJi0qin4yAD/vsaB+X+LK9WreZN5AiMJ46GFD5WPmbwfPKMt2J71HcyfE8fkuWsSP9bwfcGrwbIQxDQfpRytpZXZnZo5l8DLUDBz0pXJd2IpUKf2C5uJM6R7BtF2PpsVu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308183; c=relaxed/simple;
	bh=6v9ifSE+HKLzzFcySjxNgtrAwJUw57W3Y8g6B7IPcCQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P8gndkiDm5jvGxhxqVAlRJW6kV23LjOR6BM36bNYibFYqnNJqNqPJJFNJea1c9/ZXJRn+XthjbvTcLigY03l4tN0BwUCUhB11H1SsfE1okMcadENlLX4OalGb6uNTBDXnewxr+IzHxr9Lo0BXDL9FjFGYmAV2RwMBPArLDYDy8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vWYmEbMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F5BC19425;
	Mon, 27 Apr 2026 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777308183;
	bh=6v9ifSE+HKLzzFcySjxNgtrAwJUw57W3Y8g6B7IPcCQ=;
	h=Subject:To:Cc:From:Date:From;
	b=vWYmEbMcFnEZPSxFqQ/U5fAgwYRXoezso3WFWZjrz+IINZJ0QQXSculJ+QWLEdkwN
	 h0AqfJ+aTddOg40GJ2APLAa8wfNoanmJfqemD0w7TrVIqSwxDdJDq+j1nLd6bm+O5C
	 dRedbCyPFnGj8jvK3+qX1ZsNY28mL17EgxPvpGiQ=
Subject: FAILED: patch "[PATCH] arm64/mm: Enable batched TLB flush in unmap_hotplug_range()" failed to apply to 6.6-stable tree
To: anshuman.khandual@arm.com,catalin.marinas@arm.com,david@kernel.org,ryan.roberts@arm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Apr 2026 10:42:27 -0600
Message-ID: <2026042727-accent-daylong-5b92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0AAFC4769B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241401-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,gregkh:email,linuxfoundation.org:dkim,arm.com:email]


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 48478b9f791376b4b89018d7afdfd06865498f65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042727-accent-daylong-5b92@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 48478b9f791376b4b89018d7afdfd06865498f65 Mon Sep 17 00:00:00 2001
From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Mon, 9 Mar 2026 02:57:24 +0000
Subject: [PATCH] arm64/mm: Enable batched TLB flush in unmap_hotplug_range()

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

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a6a00accf4f9..5dbf988120c8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1458,10 +1458,14 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 
 		WARN_ON(!pte_present(pte));
 		__pte_clear(&init_mm, addr, ptep);
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
 
@@ -1482,15 +1486,14 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
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
@@ -1515,15 +1518,12 @@ static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
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
@@ -1553,6 +1553,7 @@ static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
 static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 				bool free_mapped, struct vmem_altmap *altmap)
 {
+	unsigned long start = addr;
 	unsigned long next;
 	pgd_t *pgdp, pgd;
 
@@ -1574,6 +1575,9 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 		WARN_ON(!pgd_present(pgd));
 		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
+
+	if (!free_mapped)
+		flush_tlb_kernel_range(start, end);
 }
 
 static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,


