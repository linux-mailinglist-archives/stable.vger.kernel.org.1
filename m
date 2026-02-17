Return-Path: <stable+bounces-216825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHwaL3lulGk0DwIAu9opvQ
	(envelope-from <stable+bounces-216825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:34:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF1914CA2D
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75E943038F28
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834BE36B06B;
	Tue, 17 Feb 2026 13:34:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B99361DD0;
	Tue, 17 Feb 2026 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771335267; cv=none; b=fRSpruEpenDKtIKzrCdFjro3D3hAAxVdQsGTgAt48023pJ/xOzGK8xbE2McF5r+8ldJnX0riubGtIyrATasrLtk3aHmDlsoxbIj70gH3FlLh6WjBT7bMyxqBWXgYtD9XLI6EaXgEAYKhp3IP9fXyxibbo6qTFYO3b0f8hSqOwSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771335267; c=relaxed/simple;
	bh=iK/yqa2ak2lrG7lUCl7OJLwUz9BfEnqwW8Ae+N0+tOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OK5KP/4oTHxZ09WGWHB/KZT5zHIScDOTBNSg/dGZU8ol0brtH1Gaecu12Z/WXheQEnyU53u506WI8t82TLudfq/liOGOCZM/xWPuqsvj7e6Zz1Iff2gTx4/UMp1yJW44K2OFRy9128J8PHsXRr1z4VI4NHqd/CiHxaeJpu45oo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F3EF14BF;
	Tue, 17 Feb 2026 05:34:18 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BE5E3F632;
	Tue, 17 Feb 2026 05:34:23 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jack Aboutboul <jaboutboul@microsoft.com>,
	Sharath George John <sgeorgejohn@microsoft.com>,
	Noah Meyerhans <nmeyerhans@microsoft.com>,
	Jim Perrin <Jim.Perrin@microsoft.com>,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>,
	Eric Chanudet <echanude@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.6 1/3] arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
Date: Tue, 17 Feb 2026 13:34:06 +0000
Message-ID: <20260217133411.2881311-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217133411.2881311-1-ryan.roberts@arm.com>
References: <20260217133411.2881311-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-216825-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 3FF1914CA2D
X-Rspamd-Action: no action

[ Upstream commit 5c63db59c5f89925add57642be4f789d0d671ccd ]

A large part of the kernel boot time is creating the kernel linear map
page tables. When rodata=full, all memory is mapped by pte. And when
there is lots of physical ram, there are lots of pte tables to populate.
The primary cost associated with this is mapping and unmapping the pte
table memory in the fixmap; at unmap time, the TLB entry must be
invalidated and this is expensive.

Previously, each pmd and pte table was fixmapped/fixunmapped for each
cont(pte|pmd) block of mappings (16 entries with 4K granule). This means
we ended up issuing 32 TLBIs per (pmd|pte) table during the population
phase.

Let's fix that, and fixmap/fixunmap each page once per population, for a
saving of 31 TLBIs per (pmd|pte) table. This gives a significant boot
speedup.

Execution time of map_mem(), which creates the kernel linear map page
tables, was measured on different machines with different RAM configs:

               | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
               | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
---------------|-------------|-------------|-------------|-------------
               |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
---------------|-------------|-------------|-------------|-------------
before         |  168   (0%) | 2198   (0%) | 8644   (0%) | 17447   (0%)
after          |   78 (-53%) |  435 (-80%) | 1723 (-80%) |  3779 (-78%)

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Tested-by: Eric Chanudet <echanude@redhat.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20240412131908.433043-2-ryan.roberts@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
[ Ryan: Trivial backport ]
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/mmu.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c8e83fe1cd5a7..130e915a3845e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -169,12 +169,9 @@ bool pgattr_change_is_safe(u64 old, u64 new)
 	return ((old ^ new) & ~mask) == 0;
 }

-static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
+static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 		     phys_addr_t phys, pgprot_t prot)
 {
-	pte_t *ptep;
-
-	ptep = pte_set_fixmap_offset(pmdp, addr);
 	do {
 		pte_t old_pte = READ_ONCE(*ptep);

@@ -189,8 +186,6 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,

 		phys += PAGE_SIZE;
 	} while (ptep++, addr += PAGE_SIZE, addr != end);
-
-	pte_clear_fixmap();
 }

 static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
@@ -201,6 +196,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 {
 	unsigned long next;
 	pmd_t pmd = READ_ONCE(*pmdp);
+	pte_t *ptep;

 	BUG_ON(pmd_sect(pmd));
 	if (pmd_none(pmd)) {
@@ -216,6 +212,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 	}
 	BUG_ON(pmd_bad(pmd));

+	ptep = pte_set_fixmap_offset(pmdp, addr);
 	do {
 		pgprot_t __prot = prot;

@@ -226,20 +223,21 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 		    (flags & NO_CONT_MAPPINGS) == 0)
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);

-		init_pte(pmdp, addr, next, phys, __prot);
+		init_pte(ptep, addr, next, phys, __prot);

+		ptep += pte_index(next) - pte_index(addr);
 		phys += next - addr;
 	} while (addr = next, addr != end);
+
+	pte_clear_fixmap();
 }

-static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
+static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		     phys_addr_t phys, pgprot_t prot,
 		     phys_addr_t (*pgtable_alloc)(int), int flags)
 {
 	unsigned long next;
-	pmd_t *pmdp;

-	pmdp = pmd_set_fixmap_offset(pudp, addr);
 	do {
 		pmd_t old_pmd = READ_ONCE(*pmdp);

@@ -265,8 +263,6 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
 		}
 		phys += next - addr;
 	} while (pmdp++, addr = next, addr != end);
-
-	pmd_clear_fixmap();
 }

 static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
@@ -276,6 +272,7 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 {
 	unsigned long next;
 	pud_t pud = READ_ONCE(*pudp);
+	pmd_t *pmdp;

 	/*
 	 * Check for initial section mappings in the pgd/pud.
@@ -294,6 +291,7 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 	}
 	BUG_ON(pud_bad(pud));

+	pmdp = pmd_set_fixmap_offset(pudp, addr);
 	do {
 		pgprot_t __prot = prot;

@@ -304,10 +302,13 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 		    (flags & NO_CONT_MAPPINGS) == 0)
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);

-		init_pmd(pudp, addr, next, phys, __prot, pgtable_alloc, flags);
+		init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);

+		pmdp += pmd_index(next) - pmd_index(addr);
 		phys += next - addr;
 	} while (addr = next, addr != end);
+
+	pmd_clear_fixmap();
 }

 static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
--
2.43.0


