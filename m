Return-Path: <stable+bounces-232828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MS7IjhTzWkMcAYAu9opvQ
	(envelope-from <stable+bounces-232828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:17:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E131A37E858
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E52083022636
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 17:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408D746AF3D;
	Wed,  1 Apr 2026 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV6KweNH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B7175A8D
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775063207; cv=none; b=YlFaANBB6WwGYD4fMTuzXA3W5fUnrYZKVX+TrrP989QjkqoCPyOQZXL/+YtGo7tbhivBwmDhsUP9Ds4jK5M0sBUzMEnVT94x9lq7tciGO1efSs2SiAfEurYz/X8Ai15VjMq6RnFVXb+u/fhuZCnxEd+AhbREVBRx8PoajwRpUzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775063207; c=relaxed/simple;
	bh=8lZoCUyvFmnP5Wd9m3GEvWu9X1eyyUT1Z0CYUYT0ssM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaLqPZr4+mSKQM4f+tMkIa/ErZVofQu4kUCLNDIhknf+nuAHxxUMQzZvkfStX5MarT/fsCtELJjtjn8bhoNNOb9Cl78Tt8FWNo/r9rh+mvN81zlm2JlbC+GEOmzOS2PKFvnfNYnFeUIyas5MBOdpElwzhqhV3kVBqEHiPdyQ2lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AV6KweNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB4DC4CEF7;
	Wed,  1 Apr 2026 17:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775063206;
	bh=8lZoCUyvFmnP5Wd9m3GEvWu9X1eyyUT1Z0CYUYT0ssM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AV6KweNHZOHtnq0JHxIGaNBMUwLf9d5gi3UyjJesWcYUlT3K4MiRrgPtYOW7eIz3R
	 fnz/JVJ46ykcR08n/MOqhKoS4d1mJDqfWqs3zbxNsekX6IFYya8kMUO/pKbo3SedLb
	 KBWUoDopnOX3Iwmr3Mj0HiH8GE12RrQu373MadS8+MfL7JGoPyQ/HceJ6mgR2UFrYi
	 NUzR0ibG+V1zNLy7ncZVxOmvD7S7gfKbXbTL4bUrlN1tWkMuJHWBwRnBiKkASOOkZ8
	 UEEJAx7H2I5/gL+pFjmsiCpIvEW5aJ3qFfMs4839ujAoX5ojA4M+H2cX8O/4dHBx5N
	 OtbReKuMbtfgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Lance Yang <lance.yang@linux.dev>,
	Wei Yang <richard.weiyang@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] mm: replace READ_ONCE() with standard page table accessors
Date: Wed,  1 Apr 2026 13:06:42 -0400
Message-ID: <20260401170643.151278-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033034-amount-briar-a849@gregkh>
References: <2026033034-amount-briar-a849@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arm.com,redhat.com,linux.dev,gmail.com,linux-foundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232828-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E131A37E858
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Anshuman Khandual <anshuman.khandual@arm.com>

[ Upstream commit c0efdb373c3aaacb32db59cadb0710cac13e44ae ]

Replace all READ_ONCE() with a standard page table accessors i.e
pxdp_get() that defaults into READ_ONCE() in cases where platform does not
override.

Link: https://lkml.kernel.org/r/20251007063100.2396936-1-anshuman.khandual@arm.com
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: ffef67b93aa3 ("mm/memory: fix PMD/PUD checks in follow_pfnmap_start()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c            | 10 +++++-----
 mm/hmm.c            |  2 +-
 mm/memory.c         |  4 ++--
 mm/mprotect.c       |  2 +-
 mm/sparse-vmemmap.c |  2 +-
 mm/vmscan.c         |  2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index d105817a0c9aa..937865ecfae00 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1013,7 +1013,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	pudp = pud_offset(p4dp, address);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (!pud_present(pud))
 		return no_page_table(vma, flags, address);
 	if (pud_leaf(pud)) {
@@ -1038,7 +1038,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 	p4d_t *p4dp, p4d;
 
 	p4dp = p4d_offset(pgdp, address);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get(p4dp);
 	BUILD_BUG_ON(p4d_leaf(p4d));
 
 	if (!p4d_present(p4d) || p4d_bad(p4d))
@@ -3301,7 +3301,7 @@ static int gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr,
 
 	pudp = pud_offset_lockless(p4dp, p4d, addr);
 	do {
-		pud_t pud = READ_ONCE(*pudp);
+		pud_t pud = pudp_get(pudp);
 
 		next = pud_addr_end(addr, end);
 		if (unlikely(!pud_present(pud)))
@@ -3327,7 +3327,7 @@ static int gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
 
 	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
 	do {
-		p4d_t p4d = READ_ONCE(*p4dp);
+		p4d_t p4d = p4dp_get(p4dp);
 
 		next = p4d_addr_end(addr, end);
 		if (!p4d_present(p4d))
@@ -3349,7 +3349,7 @@ static void gup_fast_pgd_range(unsigned long addr, unsigned long end,
 
 	pgdp = pgd_offset(current->mm, addr);
 	do {
-		pgd_t pgd = READ_ONCE(*pgdp);
+		pgd_t pgd = pgdp_get(pgdp);
 
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
diff --git a/mm/hmm.c b/mm/hmm.c
index a67776aeb0199..a27866a1d9bd5 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -423,7 +423,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 	/* Normally we don't want to split the huge page */
 	walk->action = ACTION_CONTINUE;
 
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (!pud_present(pud)) {
 		spin_unlock(ptl);
 		return hmm_vma_walk_hole(start, end, -1, walk);
diff --git a/mm/memory.c b/mm/memory.c
index 090e9c6f99920..d27cd9a7443ce 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6451,12 +6451,12 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 		goto out;
 
 	p4dp = p4d_offset(pgdp, address);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get(p4dp);
 	if (p4d_none(p4d) || unlikely(p4d_bad(p4d)))
 		goto out;
 
 	pudp = pud_offset(p4dp, address);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (pud_none(pud))
 		goto out;
 	if (pud_leaf(pud)) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6f450af3252eb..a7c2d7c68a6a5 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -447,7 +447,7 @@ static inline long change_pud_range(struct mmu_gather *tlb,
 			break;
 		}
 
-		pud = READ_ONCE(*pudp);
+		pud = pudp_get(pudp);
 		if (pud_none(pud))
 			continue;
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index c3353cd442a5d..3e88708886e37 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -337,7 +337,7 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 			return -ENOMEM;
 
 		pmd = pmd_offset(pud, addr);
-		if (pmd_none(READ_ONCE(*pmd))) {
+		if (pmd_none(pmdp_get(pmd))) {
 			void *p;
 
 			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0ceed77af0fbd..deeb4310fd54c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3631,7 +3631,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
 	pud = pud_offset(p4d, start & P4D_MASK);
 restart:
 	for (i = pud_index(start), addr = start; addr != end; i++, addr = next) {
-		pud_t val = READ_ONCE(pud[i]);
+		pud_t val = pudp_get(pud + i);
 
 		next = pud_addr_end(addr, end);
 
-- 
2.53.0


