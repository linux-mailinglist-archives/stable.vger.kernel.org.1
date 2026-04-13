Return-Path: <stable+bounces-237518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lEQNKe8i3WkoaQkAu9opvQ
	(envelope-from <stable+bounces-237518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:07:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CB73F0CE2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD37C3065905
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E21734C124;
	Mon, 13 Apr 2026 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Az2WcVRh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060E339870;
	Mon, 13 Apr 2026 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099663; cv=none; b=HapSC8umT0YRpaiRgW/ON99ZSraw6AArwBkusdt/aZJApzeHeXt2sUCKedbBUFLISCH0NZHxP3bOt4GI3d9xrs/Mia00FH4NfZ+Vxj5AjPBktzF/xPqnTcxeyYd7Pgs0bYifscsi1Dq4kYrh5M9dAbGdY++KDzE5Nhmx3jYxwG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099663; c=relaxed/simple;
	bh=Yy04eHer1TbiydPM2qrOOrBR5lusNukqvSi88DTjSHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNNBqbXs29E7AQdwN6gfZr2JxreJq21QX0bQ9hXxehu6fByh+F34JzLGh5KbWD63gnzWPvik4PNS9jUyGkp7YjOPoP+bOwbZHVqoB6FPmipmqru3L1yp2UTHEPYLHLsTLnj8iWUltITCw20JnI60Idx97AiaBM9DAPm45Jwieng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Az2WcVRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C76C2BCB0;
	Mon, 13 Apr 2026 17:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099663;
	bh=Yy04eHer1TbiydPM2qrOOrBR5lusNukqvSi88DTjSHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Az2WcVRhC8W1g2y8Qj1zt6fna7zc7DSglqcE0OpgAC7SQp89tvHZZTqzMLuHYynue
	 FHZ+zYxEDZ3MH0HsAMm8Y+te3MEg9lKtzoV9HaMI7VQZN9vdML37GRBHdwrXxY4dey
	 ZGhVBSMFvxzDBhK3p4Tvv3bC+pv3RHkRhUQnSWwg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaohe Lin <linmiaohe@huawei.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 419/491] mm/hugetlb: make detecting shared pte more reliable
Date: Mon, 13 Apr 2026 18:01:04 +0200
Message-ID: <20260413155834.712660018@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-237518-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,huawei.com,gmail.com,oracle.com,bytedance.com,linux-foundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,oracle.com:email,linux-foundation.org:email,bytedance.com:email]
X-Rspamd-Queue-Id: 58CB73F0CE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
[ David: We don't have 4eae4efa2c29 ("hugetlb: do early cow when page
  pinned on src mm", so there are some contextual conflicts. ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 99a71943c1f69..a2cab8f2190f8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3827,7 +3827,7 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			    struct vm_area_struct *vma)
 {
-	pte_t *src_pte, *dst_pte, entry, dst_entry;
+	pte_t *src_pte, *dst_pte, entry;
 	struct page *ptepage;
 	unsigned long addr;
 	int cow;
@@ -3867,27 +3867,22 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
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
-- 
2.53.0




