Return-Path: <stable+bounces-217258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DgzEymclWnxSgIAu9opvQ
	(envelope-from <stable+bounces-217258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:02:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E560155C2E
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D27713047BF3
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 11:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549B73093B2;
	Wed, 18 Feb 2026 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAioAEop"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187232989B7
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771412500; cv=none; b=mVaiN7uUBnWLfhlrhyJXc5jWI248oMTaxafOPw+8tJBqApdxT6Es/37dX16FwG0l5X8/XXoPGq+R6dzRJ1+erfcIzjqvlD8ccPcTxKhy7LvDJxThoAw3itcjFC7asnrr4W8Cbhyitj4BA4U90apBPPNirboZskxd05jlKpUcCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771412500; c=relaxed/simple;
	bh=8tgzchpV8d+z0g8pxmYh3QpOKC5UJ4tOe/CguvbW/eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5EB1EdK00rW+DP7kbedBkNhwCTsZ3216uazy22TleBQFX7w7d01jJM0/8018HcezU/Wl6KiaGGoNLqQ3cvEPEd2Nuj4xDoCRXXwC2KB7oIEKTAKNlYiaxVTspAz/pt+Z46wIu8BFFpdM+jVqrbcAua71ql89KkT0pmpEXwzWwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAioAEop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2054C19425;
	Wed, 18 Feb 2026 11:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771412499;
	bh=8tgzchpV8d+z0g8pxmYh3QpOKC5UJ4tOe/CguvbW/eI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WAioAEop8PvlX0aN+H42ku2aA/91uZ2+X+OFiD+gYB5KrXphyNuGFEql8U2CwZOOB
	 xuDvlffJvNe2ESHvIOx+y3/rQYcUgowkbQAKb5MZR0zrsQ0xLx+RJ0uYtc7YM33sU3
	 Nmg8/DJkF4EeJrXBxBnnF1eStxDnlRMdeFAYzOhKdjFAZN6jVGcy6pWnGBpj2GDZPf
	 w5mvZH55aMxuuVUqqjTycLCq6VPgMy3KFl06H8ebVxprQCYtZgBTILT+We6sXy0O6J
	 /wot86el/wnhkbKFYJl2P90TKpXscqWgpJ8tZzlGKaNjTX73ODe094Q+C1ww80GmPO
	 u077j2bqbpK5Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	Miaohe Lin <linmiaohe@huawei.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Subject: [PATCH 5.15.y 1/6] mm/hugetlb: make detecting shared pte more reliable
Date: Wed, 18 Feb 2026 12:01:24 +0100
Message-ID: <20260218110129.41578-2-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218110129.41578-1-david@kernel.org>
References: <2026012608-tulip-moisten-c6f6@gregkh>
 <20260218110129.41578-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kvack.org,huawei.com,gmail.com,oracle.com,bytedance.com,linux-foundation.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217258-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E560155C2E
X-Rspamd-Action: no action

From: Miaohe Lin <linmiaohe@huawei.com>

If the pagetables are shared, we shouldn't copy or take references.  Since
src could have unshared and dst shares with another vma, huge_pte_none()
is thus used to determine whether dst_pte is shared.  But this check isn't
reliable.  A shared pte could have pte none in pagetable in fact.  The
page count of ptep page should be checked here in order to reliably
determine whether pte is shared.

[lukas.bulwahn@gmail.com: remove unused local variable dst_entry in copy_hugetlb_page_range()]
  Link: https://lkml.kernel.org/r/20220822082525.26071-1-lukas.bulwahn@gmail.com
Link: https://lkml.kernel.org/r/20220816130553.31406-7-linmiaohe@huawei.com
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 3aa4ed8040e1535d95c03cef8b52cf11bf0d8546)
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 70ceac102a8d..c0719ece2b7f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4304,7 +4304,7 @@ hugetlb_install_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr
 int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			    struct vm_area_struct *vma)
 {
-	pte_t *src_pte, *dst_pte, entry, dst_entry;
+	pte_t *src_pte, *dst_pte, entry;
 	struct page *ptepage;
 	unsigned long addr;
 	bool cow = is_cow_mapping(vma->vm_flags);
@@ -4343,28 +4343,23 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 		/*
 		 * If the pagetables are shared don't copy or take references.
-		 * dst_pte == src_pte is the common case of src/dest sharing.
 		 *
+		 * dst_pte == src_pte is the common case of src/dest sharing.
 		 * However, src could have 'unshared' and dst shares with
-		 * another vma.  If dst_pte !none, this implies sharing.
-		 * Check here before taking page table lock, and once again
-		 * after taking the lock below.
+		 * another vma. So page_count of ptep page is checked instead
+		 * to reliably determine whether pte is shared.
 		 */
-		dst_entry = huge_ptep_get(dst_pte);
-		if ((dst_pte == src_pte) || !huge_pte_none(dst_entry))
+		if (page_count(virt_to_page(dst_pte)) > 1)
 			continue;
 
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
 		src_ptl = huge_pte_lockptr(h, src, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		entry = huge_ptep_get(src_pte);
-		dst_entry = huge_ptep_get(dst_pte);
 again:
-		if (huge_pte_none(entry) || !huge_pte_none(dst_entry)) {
+		if (huge_pte_none(entry)) {
 			/*
-			 * Skip if src entry none.  Also, skip in the
-			 * unlikely case dst entry !none as this implies
-			 * sharing with another vma.
+			 * Skip if src entry none.
 			 */
 			;
 		} else if (unlikely(is_hugetlb_entry_migration(entry) ||
@@ -4423,7 +4418,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					restore_reserve_on_error(h, vma, addr,
 								new);
 					put_page(new);
-					/* dst_entry won't change as in child */
+					/* huge_ptep of dst_pte won't change as in child */
 					goto again;
 				}
 				hugetlb_install_page(vma, dst_pte, addr, new);
-- 
2.43.0


