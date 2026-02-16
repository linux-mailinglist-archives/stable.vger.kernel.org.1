Return-Path: <stable+bounces-216744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIvOAABVk2lD3gEAu9opvQ
	(envelope-from <stable+bounces-216744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 18:33:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F2F146BB3
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 18:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7048302C36D
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3EE2D780E;
	Mon, 16 Feb 2026 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N873rruI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036EB33993
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771263209; cv=none; b=KXpcTRlj4WdWsFTuBbmUruUa4Qt3crDFVNskNLgcsPsqQsiw4Gwg3w5fM0sWpcTpKUkaa41RpvFk367FCHozC0l1DjA+FnoDVTAWBjWwiaT8CoxhtdwSOb1p9T6iMeJU2qgGXbPFoISp0CUPi+WfQFxDoG03fPgeNnTwpKgKTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771263209; c=relaxed/simple;
	bh=8k4q/fvvO0NSlXrLk8jJ1qLslSXvw1uLD3oYggRvfMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfVqLUpuJM4vJP7d8aRMXbVbQlTpWNVEPAmuUT2lVxznCZIX7kA6aPmNYOwL6xkz7Dp6V0Zmns/rxG/tQI1Upeq6P6JiFa5Ac3a0XC9AmxG0ZqT4Q5lqYyqWo91x3xoAAoYy+aTIMI7wsBRhO67NVQ4puDbTzmkyh5pL0LdcAp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N873rruI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0624FC116C6;
	Mon, 16 Feb 2026 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771263208;
	bh=8k4q/fvvO0NSlXrLk8jJ1qLslSXvw1uLD3oYggRvfMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N873rruIGmvhpULLwhsz2IAPtZs2PSNq86iKrhAn6+rtW7uJ+PO8jH/vL6U1KOIhz
	 ytksSVsD1w8JpVUSIZKZUCH/8yQ1vle1lvc/LDT4hWukhRC0T3z1wCY/0pGtO8VMNS
	 d6seC5HEHz/bVlFmMWcoUncXRiplaGrLe7zmkAqwr1tiTKG5f02mfY8IJyk2R81ZZy
	 NuUz+hSLkDL5uI6sMN3O61lN6ZDIlF1iuH/b8n0MEiMqnKmaUlwdq52cTjBjHxxpu8
	 hDKFzR/qJIwKTBpZvMY/ZJ7SG2/6S2PCesVIVNkshHAUxYj4iDn5mGT9uAQRej9gkB
	 tRhim/sLZdLYg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Laurence Oberman <loberman@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Uschakow, Stanislav" <suschako@amazon.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y 3/4] mm/hugetlb: fix two comments related to huge_pmd_unshare()
Date: Mon, 16 Feb 2026 18:33:09 +0100
Message-ID: <20260216173310.230841-4-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216173310.230841-1-david@kernel.org>
References: <2026012603-stingily-washbasin-9371@gregkh>
 <20260216173310.230841-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216744-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,linux-foundation.org:email,suse.de:email]
X-Rspamd-Queue-Id: A1F2F146BB3
X-Rspamd-Action: no action

From: "David Hildenbrand (Red Hat)" <david@kernel.org>

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
(cherry picked from commit 3937027caecb4f8251e82dd857ba1d749bb5a428)
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 25d945899cca..05cc63556350 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5435,17 +5435,10 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
@@ -6695,11 +6688,10 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
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
-- 
2.43.0


