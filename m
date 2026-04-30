Return-Path: <stable+bounces-242090-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJLvBzo+82kGywEAu9opvQ
	(envelope-from <stable+bounces-242090-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:34:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B335F4A2351
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16AFC300102D
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB863E1203;
	Thu, 30 Apr 2026 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO7A+Z6C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374753DB62D;
	Thu, 30 Apr 2026 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777548718; cv=none; b=splggxmjLp9uknjWisywAOqSwYwYwhJ3JAilU3azy4KJ3w2n4NmBpx5o1G4CQJf1zUuaDfECKZRUnzF8+IcQhrXe3auWCOTocqer5F46R8/0MAb9cZHYTV/OjkT5tZ8u16EcOpEgOLDCRdujqKOi4q4ScQ69KqBTRokXYdXk0gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777548718; c=relaxed/simple;
	bh=GAVeUYrfD81Vgxhl/4MJAOtYKmr0cjXk10/5oQ2nEDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T06Fvebz7zj20MmNpB+EVGyY0n+sxIq7emTYgbMgnOL0HH4JpGG4RsRrfsP4iXK9hTiVnHroGgQV5Qwz86yyrT8nuq/9W/otECda1V1BFXh22xxYYaO7IoqwcJrqQ6khvDV3rDu8ppCucFEdfrLoKptCAGowuFk9fA2EDHmExVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO7A+Z6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68341C2BCB3;
	Thu, 30 Apr 2026 11:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777548715;
	bh=GAVeUYrfD81Vgxhl/4MJAOtYKmr0cjXk10/5oQ2nEDM=;
	h=From:Date:Subject:To:Cc:From;
	b=PO7A+Z6CSYSyfV7aQwYqp2SRHmj4kkRrsddLZMzbjtkDjEPu33pdvOLXg1x/cq7Ro
	 tVFeT6roiky4eZBekVtFBAkyN+CpbWOyix2h/s5uO9+He9dYFBy4MhMgso2xGA9nnC
	 z+2VpX4usUvmrArf3ScDgAmL0hh+fukLQ/dfr0SctDhJoRagc2mPhDok1GVJI5Zvbb
	 hM96Jg//w7p6me4AW8RaKiO33otuDKipcx8MzGsI44vVitn8C/mdcvK9NFLnH28ADM
	 QUFx638NESL+SkYYaF4pWrVrk/viM6e2oe6zL9ngteF0RcmTybjp6H0wkODsxZ6Pdj
	 vQKkm8itzQPLw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 30 Apr 2026 13:31:22 +0200
Subject: [PATCH] mm: fix __vm_normal_page() to handle missing support for
 pmd_special()/pud_special()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-pmd_special-v1-1-dbcbcfd72c20@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIk982kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE2MD3YLclPjigtTkzMQcXTNDg5SklBSLxGTjZCWgjoKi1LTMCrBp0bG
 1tQDlEi9iXQAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>, 
 Lance Yang <lance.yang@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Bibo Mao <maobibo@loongson.cn>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: B335F4A2351
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242090-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]

On x86 32-bit with THP enabled, zap_huge_pmd() is seen to generate a
"WARNING: mm/memory.c:735 at __vm_normal_page+0x6a/0x7d", from the
VM_WARN_ON_ONCE(is_zero_pfn(pfn) || is_huge_zero_pfn(pfn)); followed
by "BUG: Bad rss-counter state"s, then later "BUG: Bad page state"s
when reclaim gets to call shrink_huge_zero_folio_scan().

It's as if the _PAGE_SPECIAL bit never got set in the huge_zero pmd:
and indeed, whereas pte_special() and pte_mkspecial() are subject to a
dedicated CONFIG_ARCH_HAS_PTE_SPECIAL, pmd_special() and pmd_mkspecial()
are subject to CONFIG_ARCH_SUPPORTS_PMD_PFNMAP, which is never enabled
on any 32-bit architecture.

While the problem was exposed through commit d80a9cb1a64a ("mm/huge_memory:
add and use normal_or_softleaf_folio_pmd()"), it was an oversight in commit
af38538801c6 ("mm/memory: factor out common code from vm_normal_page_*()")
and would result in other problems:
* huge zero folio accounted in smaps, pagemap (PAGE_IS_FILE) and
  numamaps as file-backed THP
* folio_walk_start() returning the folio even without FW_ZEROPAGE set.
  Callers seem to tolerate that, though.

... and triggering the VM_WARN_ON_ONE(), although never reported so far.

To fix it, teach vm_normal_page_pmd()/vm_normal_page_pud() to consider
whether pmd_special/pud_special is actually implemented.

Fixes: af38538801c6 ("mm/memory: factor out common code from vm_normal_page_*()")
Reported-by: Hugh Dickins <hughd@google.com>
Closes: https://lore.kernel.org/r/74a75b59-2e13-3985-ee99-d5521f39df2a@google.com
Reported-by: Bibo Mao <maobibo@loongson.cn>
Closes: https://lore.kernel.org/r/20260430041121.2839350-1-maobibo@loongson.cn
Debugged-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
This is an alternative to Hugh's patch, whereby we leave pmd_special()
be a NOP and instead teach __vm_normal_page() about lack of support for
pmd_special/pud_special.
---
 mm/memory.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7322a40e73b9..4d84976fc7f4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -612,6 +612,21 @@ static void print_bad_page_map(struct vm_area_struct *vma,
 	dump_stack();
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
+
+static inline bool pgtable_level_has_pxx_special(enum pgtable_level level)
+{
+	switch (level) {
+	case PGTABLE_LEVEL_PTE:
+		return IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL);
+	case PGTABLE_LEVEL_PMD:
+		return IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP);
+	case PGTABLE_LEVEL_PUD:
+		return IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP);
+	default:
+		return false;
+	}
+}
+
 #define print_bad_pte(vma, addr, pte, page) \
 	print_bad_page_map(vma, addr, pte_val(pte), page, PGTABLE_LEVEL_PTE)
 
@@ -684,7 +699,7 @@ static inline struct page *__vm_normal_page(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long pfn, bool special,
 		unsigned long long entry, enum pgtable_level level)
 {
-	if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
+	if (pgtable_level_has_pxx_special(level)) {
 		if (unlikely(special)) {
 #ifdef CONFIG_FIND_NORMAL_PAGE
 			if (vma->vm_ops && vma->vm_ops->find_normal_page)
@@ -699,8 +714,9 @@ static inline struct page *__vm_normal_page(struct vm_area_struct *vma,
 			return NULL;
 		}
 		/*
-		 * With CONFIG_ARCH_HAS_PTE_SPECIAL, any special page table
-		 * mappings (incl. shared zero folios) are marked accordingly.
+		 * With working pte_special()/pmd_special()..., any special page
+		 * table mappings (incl. shared zero folios) are marked
+		 * accordingly.
 		 */
 	} else {
 		if (unlikely(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))) {

---

base-commit: d94322006a51b522dd361128a450bf9e75aad889

change-id: 20260430-pmd_special-610dbdd8ac3c

--

Cheers,

David


