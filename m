Return-Path: <stable+bounces-265790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gqv9FC2QMWpEmwUAu9opvQ
	(envelope-from <stable+bounces-265790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:04:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD017693C76
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:04:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ucmNL33j;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265790-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265790-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C38C3162293
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7EF3CEBBD;
	Tue, 16 Jun 2026 18:03:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A73CE4BA;
	Tue, 16 Jun 2026 18:03:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632997; cv=none; b=ISygdhqoa4vjwvShIGUI/rjJUMBAR73zVAcQkLzfDUbJT1Q3yeWQBytBQPmQ29XnfU4xipijyZ4j/heAkuMC2CQB7dDU5Zx+XPIMUlV/1y8ulv6+lZl2JA9VrnpcmvpLClXxmMd1ILxidyqa4h7qFSn6ns/1Hw9kn1Ax5azNI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632997; c=relaxed/simple;
	bh=C/rLPt2uQwHV6wBYTbGdpfZkYYAHgzT399z6WUX3YIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtc0dtD2hb/xBWkvMBIvtCI+88XeMudn7ag8KLA+sVYaNxuRvz4hK1hv4mJmwX0PQbC9ZXV/ooS7nFVa9dnCC93HCpfVYemOh2hWym6wCNVWGF7ln0YPdwDidepuu/uH2g8hwBP3+mV33Cai/tMTZAfAtMSQYVJQgTWwMW7lIyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ucmNL33j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC631F000E9;
	Tue, 16 Jun 2026 18:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632996;
	bh=jCyltodAg8gxFes0RQlJKVIOiG4fCC7AAO6V5VV/dMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ucmNL33jUn7Wz9PluXSQWa6D5mBFZO8AZUtW73OQuLSY54kJMwCM1fUhSHVRocDVS
	 zZG1MO6HABcCyaGnyXrTGiie7dBqNdvigadjXSdgMagezfPqJhJmuqvavaJPJHehvl
	 w16O4R4EibPwO+JQ7kHdS7wRdy9FuBlKWlLBI+70=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 484/522] mm/hugetlb: rename folio_putback_active_hugetlb() to folio_putback_hugetlb()
Date: Tue, 16 Jun 2026 20:30:31 +0530
Message-ID: <20260616145148.461646504@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265790-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:david@redhat.com,m:baolin.wang@linux.alibaba.com,m:willy@infradead.org,m:muchun.song@linux.dev,m:sidhartha.kumar@oracle.com,m:akpm@linux-foundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,linux-foundation.org:email,vger.kernel.org:from_smtp,alibaba.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD017693C76

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

[ Upstream commit b235448e8cab7eea17d164efc7bf55505985ba65 ]

Now that folio_putback_hugetlb() is only called on folios that were
previously isolated through folio_isolate_hugetlb(), let's rename it to
match folio_putback_lru().

Add some kernel doc to clarify how this function is supposed to be used.

Link: https://lkml.kernel.org/r/20250113131611.2554758-5-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3c2d42b8ee34 ("mm/memory-failure: fix hugetlb_lock AA deadlock in get_huge_page_for_hwpoison")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/hugetlb.h |    4 ++--
 mm/hugetlb.c            |   15 +++++++++++++--
 mm/migrate.c            |    6 +++---
 3 files changed, 18 insertions(+), 7 deletions(-)

--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -185,7 +185,7 @@ long hugetlb_unreserve_pages(struct inod
 int folio_isolate_hugetlb(struct page *page, struct list_head *list);
 int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags);
-void putback_active_hugepage(struct page *page);
+void folio_putback_hugetlb(struct page *page);
 void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
 void free_huge_page(struct page *page);
 void hugetlb_fix_reserve_counts(struct inode *inode);
@@ -443,7 +443,7 @@ static inline int get_huge_page_for_hwpo
 	return 0;
 }
 
-static inline void putback_active_hugepage(struct page *page)
+static inline void folio_putback_hugetlb(struct page *page)
 {
 }
 
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7458,7 +7458,7 @@ follow_huge_pgd(struct mm_struct *mm, un
  * it is already isolated/non-migratable.
  *
  * On success, an additional page reference is taken that must be dropped
- * using putback_active_hugepage() to undo the isolation.
+ * using folio_putback_hugetlb() to undo the isolation.
  *
  * Return: 0 if isolation worked, otherwise -EBUSY.
  */
@@ -7509,7 +7509,18 @@ int get_huge_page_for_hwpoison(unsigned
 	return ret;
 }
 
-void putback_active_hugepage(struct page *page)
+/**
+ * folio_putback_hugetlb - unisolate a hugetlb page
+ * @page: the isolated hugetlb page
+ *
+ * Putback/un-isolate the hugetlb page that was previous isolated using
+ * folio_isolate_hugetlb(): marking it non-isolated/migratable and putting it
+ * back onto the active list.
+ *
+ * Will drop the additional page reference obtained through
+ * folio_isolate_hugetlb().
+ */
+void folio_putback_hugetlb(struct page *page)
 {
 	spin_lock_irq(&hugetlb_lock);
 	SetHPageMigratable(page);
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -142,7 +142,7 @@ void putback_movable_pages(struct list_h
 
 	list_for_each_entry_safe(page, page2, l, lru) {
 		if (unlikely(PageHuge(page))) {
-			putback_active_hugepage(page);
+			folio_putback_hugetlb(page);
 			continue;
 		}
 		list_del(&page->lru);
@@ -1371,7 +1371,7 @@ static int unmap_and_move_huge_page(new_
 
 	if (folio_ref_count(src) == 1) {
 		/* page was freed from under us. So we are done. */
-		putback_active_hugepage(hpage);
+		folio_putback_hugetlb(hpage);
 		return MIGRATEPAGE_SUCCESS;
 	}
 
@@ -1455,7 +1455,7 @@ out_unlock:
 	folio_unlock(src);
 out:
 	if (rc == MIGRATEPAGE_SUCCESS)
-		putback_active_hugepage(hpage);
+		folio_putback_hugetlb(hpage);
 	else if (rc != -EAGAIN)
 		list_move_tail(&src->lru, ret);
 



