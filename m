Return-Path: <stable+bounces-265791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OBPbK/GPMWolmwUAu9opvQ
	(envelope-from <stable+bounces-265791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:03:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEB4693C33
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:03:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=zVtDBxLm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265791-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265791-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF82B30074FC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDF23CEBBD;
	Tue, 16 Jun 2026 18:03:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6850F3C09E1;
	Tue, 16 Jun 2026 18:03:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633004; cv=none; b=oZ49w1p9FOu78r1Es3xf8fx5qoUqRxi1tfrha2KOfdL6wCVJcd7y5qXAHI1antvsW1JokmyBoKmrs+m0EfH+/jChg711kmrcNj0RHRjn3tW3yTLHuNucU7JecAw0MjZ+rHrV3uAZPov1Adw7WysTp5/4QJlzStMvtO1nD7Siwdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633004; c=relaxed/simple;
	bh=tQyJHr65FK7aPrhPbTU25vwvxPEWN2FiGdmOkO7iRL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNPv5+cwAPGyT46FidbauiryfxQqouuL43SXHAsrY0cIMw6BYaqy3DQttvkefGC9sZMTMh0YzSmz3Ii+Mb4UtqG+JKBYP8KtGDUCpMHQh8hOzP+ga7KDFRnt6MAvtQw519qd1uyU7COecNNo//xmn/oA2tZnQJ1wwha3kKEBsgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zVtDBxLm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7C71F00A3A;
	Tue, 16 Jun 2026 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781633003;
	bh=oFc3LuetWF/xd7NBzhgo4SGtfAGa2CwoUBKIVmtJm8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zVtDBxLm62cCqpYB7gUfDY+732asCBiRTucAXYmrRXgToco3/FFMmgCmda6643JAF
	 lcu57oZ/OA+PAx1xJAhvnAAdKhnMA/2WkYfrfQBKlBBql4heK/6vfl/qXl0ryU1ef6
	 6s2MT9UZ+7RBOoUQufKpJ6A+p9c6IfyJhsIrL/cE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jane Chu <jane.chu@oracle.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Chris Mason <clm@meta.com>,
	David Hildenbrand <david@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jiaqi Yan <jiaqiyan@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	William Roche <william.roche@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 485/522] mm/memory-failure: fix missing ->mf_stats count in hugetlb poison
Date: Tue, 16 Jun 2026 20:30:32 +0530
Message-ID: <20260616145148.505966103@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265791-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jane.chu@oracle.com,m:linmiaohe@huawei.com,m:clm@meta.com,m:david@kernel.org,m:rientjes@google.com,m:jiaqiyan@google.com,m:Liam.Howlett@oracle.com,m:lorenzo.stoakes@oracle.com,m:willy@infradead.org,m:mhocko@suse.com,m:rppt@kernel.org,m:muchun.song@linux.dev,m:nao.horiguchi@gmail.com,m:osalvador@suse.de,m:surenb@google.com,m:william.roche@oracle.com,m:akpm@linux-foundation.org,m:sashal@kernel.org,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,oracle.com,huawei.com,meta.com,kernel.org,google.com,infradead.org,suse.com,linux.dev,gmail.com,suse.de,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABEB4693C33

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jane Chu <jane.chu@oracle.com>

[ Upstream commit a148a2040191b12b45b82cb29c281cb3036baf90 ]

When a newly poisoned subpage ends up in an already poisoned hugetlb
folio, 'num_poisoned_pages' is incremented, but the per node ->mf_stats is
not.  Fix the inconsistency by designating action_result() to update them
both.

While at it, define __get_huge_page_for_hwpoison() return values in terms
of symbol names for better readibility.  Also rename
folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison() since the
function does more than the conventional bit setting and the fact three
possible return values are expected.

Link: https://lkml.kernel.org/r/20260120232234.3462258-1-jane.chu@oracle.com
Fixes: 18f41fa616ee ("mm: memory-failure: bump memory failure stats to pglist_data")
Signed-off-by: Jane Chu <jane.chu@oracle.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Chris Mason <clm@meta.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Jiaqi Yan <jiaqiyan@google.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: William Roche <william.roche@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3c2d42b8ee34 ("mm/memory-failure: fix hugetlb_lock AA deadlock in get_huge_page_for_hwpoison")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory-failure.c |   71 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 28 deletions(-)

--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1730,12 +1730,22 @@ static unsigned long __free_raw_hwp_page
 	return count;
 }
 
-static int hugetlb_set_page_hwpoison(struct page *hpage, struct page *page)
+#define	MF_HUGETLB_FREED		0	/* freed hugepage */
+#define	MF_HUGETLB_IN_USED		1	/* in-use hugepage */
+#define	MF_HUGETLB_NON_HUGEPAGE		2	/* not a hugepage */
+#define	MF_HUGETLB_FOLIO_PRE_POISONED	3	/* folio already poisoned */
+#define	MF_HUGETLB_PAGE_PRE_POISONED	4	/* exact page already poisoned */
+#define	MF_HUGETLB_RETRY		5	/* hugepage is busy, retry */
+/*
+ * Set hugetlb page as hwpoisoned, update page private raw hwpoison list
+ * to keep track of the poisoned pages.
+ */
+static int hugetlb_update_hwpoison(struct page *hpage, struct page *page)
 {
 	struct llist_head *head;
 	struct raw_hwp_page *raw_hwp;
 	struct llist_node *t, *tnode;
-	int ret = TestSetPageHWPoison(hpage) ? -EHWPOISON : 0;
+	int ret = TestSetPageHWPoison(hpage) ? MF_HUGETLB_FOLIO_PRE_POISONED : 0;
 
 	/*
 	 * Once the hwpoison hugepage has lost reliable raw error info,
@@ -1743,13 +1753,13 @@ static int hugetlb_set_page_hwpoison(str
 	 * so skip to add additional raw error info.
 	 */
 	if (HPageRawHwpUnreliable(hpage))
-		return -EHWPOISON;
+		return MF_HUGETLB_FOLIO_PRE_POISONED;
 	head = raw_hwp_list_head(hpage);
 	llist_for_each_safe(tnode, t, head->first) {
 		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
 
 		if (p->page == page)
-			return -EHWPOISON;
+			return MF_HUGETLB_PAGE_PRE_POISONED;
 	}
 
 	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
@@ -1804,41 +1814,38 @@ void hugetlb_clear_page_hwpoison(struct
 
 /*
  * Called from hugetlb code with hugetlb_lock held.
- *
- * Return values:
- *   0             - free hugepage
- *   1             - in-use hugepage
- *   2             - not a hugepage
- *   -EBUSY        - the hugepage is busy (try to retry)
- *   -EHWPOISON    - the hugepage is already hwpoisoned
  */
 int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 {
 	struct page *page = pfn_to_page(pfn);
 	struct page *head = compound_head(page);
-	int ret = 2;	/* fallback to normal page handling */
 	bool count_increased = false;
+	int ret, rc;
 
-	if (!PageHeadHuge(head))
+	if (!PageHeadHuge(head)) {
+		ret = MF_HUGETLB_NON_HUGEPAGE;
 		goto out;
-
-	if (flags & MF_COUNT_INCREASED) {
-		ret = 1;
+	} else if (flags & MF_COUNT_INCREASED) {
+		ret = MF_HUGETLB_IN_USED;
 		count_increased = true;
 	} else if (HPageFreed(head)) {
-		ret = 0;
+		ret = MF_HUGETLB_FREED;
 	} else if (HPageMigratable(head)) {
-		ret = get_page_unless_zero(head);
-		if (ret)
+		if (get_page_unless_zero(head)) {
+			ret = MF_HUGETLB_IN_USED;
 			count_increased = true;
+		} else {
+			ret = MF_HUGETLB_FREED;
+		}
 	} else {
-		ret = -EBUSY;
+		ret = MF_HUGETLB_RETRY;
 		if (!(flags & MF_NO_RETRY))
 			goto out;
 	}
 
-	if (hugetlb_set_page_hwpoison(head, page)) {
-		ret = -EHWPOISON;
+	rc = hugetlb_update_hwpoison(head, page);
+	if (rc >= MF_HUGETLB_FOLIO_PRE_POISONED) {
+		ret = rc;
 		goto out;
 	}
 
@@ -1854,6 +1861,12 @@ out:
  * with basic operations like hugepage allocation/free/demotion.
  * So some of prechecks for hwpoison (pinning, and testing/setting
  * PageHWPoison) should be done in single hugetlb_lock range.
+ * Returns:
+ *	0		- not hugetlb, or recovered
+ *	-EBUSY		- not recovered
+ *	-EOPNOTSUPP	- hwpoison_filter'ed
+ *	-EHWPOISON	- folio or exact page already poisoned
+ *	-EFAULT		- kill_accessing_process finds current->mm null
  */
 static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb)
 {
@@ -1865,23 +1878,25 @@ static int try_memory_failure_hugetlb(un
 	*hugetlb = 1;
 retry:
 	res = get_huge_page_for_hwpoison(pfn, flags);
-	if (res == 2) { /* fallback to normal page handling */
+	if (res == MF_HUGETLB_NON_HUGEPAGE) { /* fallback to normal page handling */
 		*hugetlb = 0;
 		return 0;
-	} else if (res == -EHWPOISON) {
+	} else if (res == MF_HUGETLB_FOLIO_PRE_POISONED ||
+		   res == MF_HUGETLB_PAGE_PRE_POISONED) {
 		pr_err("%#lx: already hardware poisoned\n", pfn);
+		res = -EHWPOISON;
 		if (flags & MF_ACTION_REQUIRED) {
 			head = compound_head(p);
 			res = kill_accessing_process(current, page_to_pfn(head), flags);
 		}
 		return res;
-	} else if (res == -EBUSY) {
+	} else if (res == MF_HUGETLB_RETRY) {
 		if (!(flags & MF_NO_RETRY)) {
 			flags |= MF_NO_RETRY;
 			goto retry;
 		}
 		action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
-		return res;
+		return -EBUSY;
 	}
 
 	head = compound_head(p);
@@ -1890,7 +1905,7 @@ retry:
 	if (hwpoison_filter(p)) {
 		hugetlb_clear_page_hwpoison(head);
 		unlock_page(head);
-		if (res == 1)
+		if (res == MF_HUGETLB_IN_USED)
 			put_page(head);
 		return -EOPNOTSUPP;
 	}
@@ -1899,7 +1914,7 @@ retry:
 	 * Handling free hugepage.  The possible race with hugepage allocation
 	 * or demotion can be prevented by PageHWPoison flag.
 	 */
-	if (res == 0) {
+	if (res == MF_HUGETLB_FREED) {
 		unlock_page(head);
 		if (__page_handle_poison(p) > 0) {
 			page_ref_inc(p);



