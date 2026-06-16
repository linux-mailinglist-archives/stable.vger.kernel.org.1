Return-Path: <stable+bounces-265242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fXfjNdCGMWrJlgUAu9opvQ
	(envelope-from <stable+bounces-265242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:24:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 302E0693186
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:24:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ftLiCbgw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265242-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265242-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F2033178027
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F34A47B415;
	Tue, 16 Jun 2026 17:16:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05BB47A0DA;
	Tue, 16 Jun 2026 17:16:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630209; cv=none; b=Pwt+m9QpLWrPt8EKRzsk3AKE2CHRpzmsir8arXEYDv0d1dk+0tJ/USqKXGUUzYxAilf2hC5XYeMqq5hVECSYG0b1EUjyqulqpUNzvwbafdM2lMW7waQUq/Ipzpn/lEYCDeTzBk0zVSl9Muj//1rLyGsJcHwGPmOvyMxerHnYxZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630209; c=relaxed/simple;
	bh=0GH9Ungm58NMzZ8+NyMvEPyjDAcsF5t/G8gb8Jxk4Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rH6Lf3jAvuTLvi9axRpCkbbuN2HL7bsjddVKg62lL6HHo1QLxhrijjsIpprhx3zTdIO1C85LJe5GeuVNEoHd2d3K0n0MNoli6ggXZSbReYJdR4Nw6pySZLkNWt3xFpxiJ/jWRjtT8NBuSTG2jOGr5251fxc3Q6jmlx0pNlkH7aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ftLiCbgw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7317F1F000E9;
	Tue, 16 Jun 2026 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630203;
	bh=XP9qbnx8MCAD+M0GoRWeR75i2QgJqCKYyyv/Nke0Fq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ftLiCbgw0Wax2kcOrgeWc8lhPCyrv6fElvlQaIGFa/UTkluESfaYBwtG5l5ACwFQ4
	 cPk9kcxvkGwZTZRvoj/Wx6P9ZgkpGhFezgiSuiTI/chD4wYqVChjvisSMKMvlkuali
	 +LEkKbnOHhAi0KwQb1gF+oj1EisAMmPD8Ov78Z1M=
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
Subject: [PATCH 6.6 430/452] mm/hugetlb: rename folio_putback_active_hugetlb() to folio_putback_hugetlb()
Date: Tue, 16 Jun 2026 20:30:57 +0530
Message-ID: <20260616145139.258785247@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265242-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:david@redhat.com,m:baolin.wang@linux.alibaba.com,m:willy@infradead.org,m:muchun.song@linux.dev,m:sidhartha.kumar@oracle.com,m:akpm@linux-foundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,oracle.com:email,alibaba.com:email,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 302E0693186

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -166,7 +166,7 @@ bool folio_isolate_hugetlb(struct folio
 int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				bool *migratable_cleared);
-void folio_putback_active_hugetlb(struct folio *folio);
+void folio_putback_hugetlb(struct folio *folio);
 void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int reason);
 void hugetlb_fix_reserve_counts(struct inode *inode);
 extern struct mutex *hugetlb_fault_mutex_table;
@@ -462,7 +462,7 @@ static inline int get_huge_page_for_hwpo
 	return 0;
 }
 
-static inline void folio_putback_active_hugetlb(struct folio *folio)
+static inline void folio_putback_hugetlb(struct folio *folio)
 {
 }
 
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7259,7 +7259,7 @@ __weak unsigned long hugetlb_mask_last_p
  * it is already isolated/non-migratable.
  *
  * On success, an additional folio reference is taken that must be dropped
- * using folio_putback_active_hugetlb() to undo the isolation.
+ * using folio_putback_hugetlb() to undo the isolation.
  *
  * Return: True if isolation worked, otherwise False.
  */
@@ -7311,7 +7311,18 @@ int get_huge_page_for_hwpoison(unsigned
 	return ret;
 }
 
-void folio_putback_active_hugetlb(struct folio *folio)
+/**
+ * folio_putback_hugetlb - unisolate a hugetlb folio
+ * @folio: the isolated hugetlb folio
+ *
+ * Putback/un-isolate the hugetlb folio that was previous isolated using
+ * folio_isolate_hugetlb(): marking it non-isolated/migratable and putting it
+ * back onto the active list.
+ *
+ * Will drop the additional folio reference obtained through
+ * folio_isolate_hugetlb().
+ */
+void folio_putback_hugetlb(struct folio *folio)
 {
 	spin_lock_irq(&hugetlb_lock);
 	folio_set_hugetlb_migratable(folio);
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -151,7 +151,7 @@ void putback_movable_pages(struct list_h
 
 	list_for_each_entry_safe(folio, folio2, l, lru) {
 		if (unlikely(folio_test_hugetlb(folio))) {
-			folio_putback_active_hugetlb(folio);
+			folio_putback_hugetlb(folio);
 			continue;
 		}
 		list_del(&folio->lru);
@@ -1373,7 +1373,7 @@ static int unmap_and_move_huge_page(new_
 
 	if (folio_ref_count(src) == 1) {
 		/* page was freed from under us. So we are done. */
-		folio_putback_active_hugetlb(src);
+		folio_putback_hugetlb(src);
 		return MIGRATEPAGE_SUCCESS;
 	}
 
@@ -1456,7 +1456,7 @@ out_unlock:
 	folio_unlock(src);
 out:
 	if (rc == MIGRATEPAGE_SUCCESS)
-		folio_putback_active_hugetlb(src);
+		folio_putback_hugetlb(src);
 	else if (rc != -EAGAIN)
 		list_move_tail(&src->lru, ret);
 



