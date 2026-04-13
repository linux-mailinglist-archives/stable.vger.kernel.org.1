Return-Path: <stable+bounces-236730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNvaIA8f3WmSaAkAu9opvQ
	(envelope-from <stable+bounces-236730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:51:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 015C33F0014
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 761943192E6A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D3130BBAE;
	Mon, 13 Apr 2026 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ENj9TrLj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109A530BB9B;
	Mon, 13 Apr 2026 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097646; cv=none; b=l5SOgtokcDCE5E1wXUnDq7VKlZrrwjC09a+CZhlGKAmKKXUAuqSjNS11y3Ao89aP2W7MB6tQ9q0IR3BSgihBCb843LVIbA24DZljBt3MShqv13v+nNn4SsQRpe2xulB3RVxBhwS8QwIw1CyZq8Gs7Fr1HGplgXBjDYVY/MYF6JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097646; c=relaxed/simple;
	bh=Dn9PIaGAcUfRz6Sw57luEwxiL2OrKyOIg3OgZABTHWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k320mTMV5ah7YxyfrGkHVPv9iwIPg/LQEXPRQ629OELEORCC/2ui4ZISdmQkLDT8hm2NFn6IsNKBu2L1r5A1RtCU3+/Xx+lK+/K3uNNwGxgdBEL/gBHXIvDeDEwg5yZibsoNqaR+PrltQazayM/jakOs3KOOIS7bC2OlvNvfkEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ENj9TrLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72887C2BCAF;
	Mon, 13 Apr 2026 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097646;
	bh=Dn9PIaGAcUfRz6Sw57luEwxiL2OrKyOIg3OgZABTHWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENj9TrLjRTe2Y6A0LKejFz0jCZtPQoR9Agmhh/2SORn8lzyJosvBoW5wMo7XvACxL
	 V1kEhPfO+H2wazfr5H+1CnFZTBbxBnMc+QzMz8qFXghXP7AV/RrY/6e1RrqQs44SuU
	 Oay69zN47rug2YcjDDAs2dsMhXG89sWXjNu1sbJU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Laurence Oberman <loberman@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Uschakow, Stanislav" <suschako@amazon.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 217/570] mm/hugetlb: fix two comments related to huge_pmd_unshare()
Date: Mon, 13 Apr 2026 17:55:48 +0200
Message-ID: <20260413155838.583756031@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236730-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazon.de:email]
X-Rspamd-Queue-Id: 015C33F0014
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand (Red Hat) <david@kernel.org>

commit 3937027caecb4f8251e82dd857ba1d749bb5a428 upstream.

Ever since we stopped using the page count to detect shared PMD page
tables, these comments are outdated.

The only reason we have to flush the TLB early is because once we drop the
i_mmap_rwsem, the previously shared page table could get freed (to then
get reallocated and used for other purpose).  So we really have to flush
the TLB before that could happen.

So let's simplify the comments a bit.

The "If we unshared PMDs, the TLB flush was not recorded in mmu_gather."
part introduced as in commit a4a118f2eead ("hugetlbfs: flush TLBs
correctly after huge_pmd_unshare") was confusing: sure it is recorded in
the mmu_gather, otherwise tlb_flush_mmu_tlbonly() wouldn't do anything.
So let's drop that comment while at it as well.

We'll centralize these comments in a single helper as we rework the code
next.

Link: https://lkml.kernel.org/r/20251223214037.580860-3-david@kernel.org
Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: "Uschakow, Stanislav" <suschako@amazon.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/hugetlb.c |   24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4552,17 +4552,10 @@ void __unmap_hugepage_range(struct mmu_g
 	tlb_end_vma(tlb, vma);
 
 	/*
-	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
-	 * could defer the flush until now, since by holding i_mmap_rwsem we
-	 * guaranteed that the last refernece would not be dropped. But we must
-	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
-	 * dropped and the last reference to the shared PMDs page might be
-	 * dropped as well.
-	 *
-	 * In theory we could defer the freeing of the PMD pages as well, but
-	 * huge_pmd_unshare() relies on the exact page_count for the PMD page to
-	 * detect sharing, so we cannot defer the release of the page either.
-	 * Instead, do flush now.
+	 * There is nothing protecting a previously-shared page table that we
+	 * unshared through huge_pmd_unshare() from getting freed after we
+	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
+	 * succeeded, flush the range corresponding to the pud.
 	 */
 	if (force_flush)
 		tlb_flush_mmu_tlbonly(tlb);
@@ -5708,11 +5701,10 @@ unsigned long hugetlb_change_protection(
 		cond_resched();
 	}
 	/*
-	 * Must flush TLB before releasing i_mmap_rwsem: x86's huge_pmd_unshare
-	 * may have cleared our pud entry and done put_page on the page table:
-	 * once we release i_mmap_rwsem, another task can do the final put_page
-	 * and that page table be reused and filled with junk.  If we actually
-	 * did unshare a page of pmds, flush the range corresponding to the pud.
+	 * There is nothing protecting a previously-shared page table that we
+	 * unshared through huge_pmd_unshare() from getting freed after we
+	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
+	 * succeeded, flush the range corresponding to the pud.
 	 */
 	if (shared_pmd)
 		flush_hugetlb_tlb_range(vma, range.start, range.end);



