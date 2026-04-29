Return-Path: <stable+bounces-241862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMJHD4jj8WlZlAEAu9opvQ
	(envelope-from <stable+bounces-241862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:55:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C66B54933BD
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2552D30704F1
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BAF3D6498;
	Wed, 29 Apr 2026 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFmF27x7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF4022689C;
	Wed, 29 Apr 2026 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459771; cv=none; b=SOxEreZkV1zcJ3mWJGLkiIUgUURARd5CcDZeFFQU3+j1dCVeR45wwrvGVx50nYS8JKqd+YN56E87N1mFbGgmcuSn9tdjgeCXKm+XA95L3BcxPJaG6GKIhs17qlhJrCuyrMqhWsp9YN09MOWPz+Qdn6rracZjcO1RzqJ0onm5Btk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459771; c=relaxed/simple;
	bh=h8G3pe9wHkpOMl4+ZrKm3m0KxKNxszJCj/MtOcTz15k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KAHsTc1Cd6aSw6qweYCsKIl6cv3MJPKJekbP7Xl9Yq6RnrNOPhSVmQel1fTPGPxWYKJLU1wdtEVj/oZltTb2PwQYvNUK4MbGctSyI1Li+zLvgFk7Ne4PfItMKFDY+EGeoQdeK6Qd+kbXaGKTtLhInEsTgdYRtk7TFzCJvVuK1CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFmF27x7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC90C19425;
	Wed, 29 Apr 2026 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777459771;
	bh=h8G3pe9wHkpOMl4+ZrKm3m0KxKNxszJCj/MtOcTz15k=;
	h=From:Date:Subject:To:Cc:From;
	b=rFmF27x7gDAney4JA5fUB+9J0z52q/EvgPWwvwRutTckYq/usYVkrX7JnD3qM46A0
	 DRdhZbTpJLOByaVxsiQ4lseeu54JB3LLecnHvugft3f1WeXvbq7eSuaefeCTQgo8Ik
	 HF/8chDDdXlZureCW1LNPvboxX3txMcAQDYY58pecYe0htuSzmUJi1zIHpjDFC0C0i
	 NbYqcoIVMXZn2w062GZEIP+WxsQ8XyYtdDhZyasFAL+2pwUsRRxV3j828eA4yk2Lk9
	 HaXvm++fI8piOcHev3CfYcm/qtwwLNkis5Vt2YxMk1rtO/m4+eAFZM9ahdDvvpPfdP
	 uJ+sufPMeOPtA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 29 Apr 2026 12:49:14 +0200
Subject: [PATCH v2] x86/mm: fix freeing of PMD-sized vmemmap pages
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-vmemmap-v2-1-8dfcacffd877@kernel.org>
X-B4-Tracking: v=1; b=H4sIACni8WkC/2XMQQ7CIBCF4as0sxYDE9JaV96j6WJox5Yo0IAhm
 oa7i926/F9evh0SR8sJrs0OkbNNNvgaeGpgWskvLOxcG1BiKzVeRHbsHG2CjDa97ok67KC+t8h
 3+z6kYay92vQK8XPAWf3WfyMroYRBIsXtbHCStwdHz89ziAuMpZQv+JYdCJ8AAAA=
To: Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Lance Yang <lance.yang@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: C66B54933BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241862-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]

In commit bf9e4e30f353 ("x86/mm: use pagetable_free()"), we switched
from freeing non-boot page tables through __free_pages() to
pagetable_free().

However, the function is also called to free vmemmap pages.

Given that vmemmap pages are not page tables, already the page_ptdesc(page)
is wrong. But worse, pagetable_free() calls

	__free_pages(page, compound_order(page));

As vmemmap pages are not compound pages (see vmemmap_alloc_block()) --
except for HVO, which doesn't apply here -- we will only free the first
page when freeing a PMD-sized vmemmap page, leaking the other ones.

Fix it by properly decoupling pagetable and vmemmap freeing.
free_pagetable() no longer has to mess with SECTION_INFO, as only the
vmemmap is marked like that in register_page_bootmem_memmap().

The indentation in remove_pmd_table() is messed up, let's fix that
while touching it.

Note that we'll try to get rid of that bootmem info handling soon. For
now, we'll handle it similar to free_pagetable(), just avoiding the
ifdef.

Tested-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Fixes: bf9e4e30f353 ("x86/mm: use pagetable_free()")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Reproduced and tested with a simple VM with a virtio-mem device,
repeatedly adding and removing memory.

Found by code inspection while working on bootmem_info removal.
---
Changes in v2:
- Don't mess with the altmap with PTEs and add a comment why.
- Simplify "unsigned long nr_pages" handling.
- Link to v1: https://lore.kernel.org/r/20260428-vmemmap-v1-1-b2aa1e6db2c0@kernel.org
---
 arch/x86/mm/init_64.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index df2261fa4f98..7e20b22d658b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1014,7 +1014,7 @@ static void __meminit free_pagetable(struct page *page, int order)
 #ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
 		enum bootmem_type type = bootmem_type(page);
 
-		if (type == SECTION_INFO || type == MIX_SECTION_INFO) {
+		if (type == MIX_SECTION_INFO) {
 			while (nr_pages--)
 				put_page_bootmem(page++);
 		} else {
@@ -1028,13 +1028,24 @@ static void __meminit free_pagetable(struct page *page, int order)
 	}
 }
 
-static void __meminit free_hugepage_table(struct page *page,
+static void __meminit free_vmemmap_pages(struct page *page, unsigned int order,
 		struct vmem_altmap *altmap)
 {
-	if (altmap)
-		vmem_altmap_free(altmap, PMD_SIZE / PAGE_SIZE);
-	else
-		free_pagetable(page, get_order(PMD_SIZE));
+	unsigned long nr_pages = 1u << order;
+
+	if (altmap) {
+		vmem_altmap_free(altmap, nr_pages);
+	} else if (PageReserved(page)) {
+		if (IS_ENABLED(CONFIG_HAVE_BOOTMEM_INFO_NODE) &&
+		    bootmem_type(page) == SECTION_INFO) {
+			while (nr_pages--)
+				put_page_bootmem(page++);
+		} else {
+			free_reserved_pages(page, nr_pages);
+		}
+	} else {
+		__free_pages(page, order);
+	}
 }
 
 static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
@@ -1118,7 +1129,8 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
 			return;
 
 		if (!direct)
-			free_pagetable(pte_page(*pte), 0);
+			/* We never populate base pages from the altmap. */
+			free_vmemmap_pages(pte_page(*pte), 0, NULL);
 
 		spin_lock(&init_mm.page_table_lock);
 		pte_clear(&init_mm, addr, pte);
@@ -1153,19 +1165,19 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 			if (IS_ALIGNED(addr, PMD_SIZE) &&
 			    IS_ALIGNED(next, PMD_SIZE)) {
 				if (!direct)
-					free_hugepage_table(pmd_page(*pmd),
-							    altmap);
+					free_vmemmap_pages(pmd_page(*pmd),
+							   PMD_ORDER, altmap);
 
 				spin_lock(&init_mm.page_table_lock);
 				pmd_clear(pmd);
 				spin_unlock(&init_mm.page_table_lock);
 				pages++;
 			} else if (vmemmap_pmd_is_unused(addr, next)) {
-					free_hugepage_table(pmd_page(*pmd),
-							    altmap);
-					spin_lock(&init_mm.page_table_lock);
-					pmd_clear(pmd);
-					spin_unlock(&init_mm.page_table_lock);
+				free_vmemmap_pages(pmd_page(*pmd), PMD_ORDER,
+						   altmap);
+				spin_lock(&init_mm.page_table_lock);
+				pmd_clear(pmd);
+				spin_unlock(&init_mm.page_table_lock);
 			}
 			continue;
 		}

---

base-commit: a2ddbfd1af0f54ea84bf17f0400088815d012e8d

change-id: 20260428-vmemmap-ab4b949aa727

--

Cheers,

David


