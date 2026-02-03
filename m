Return-Path: <stable+bounces-213225-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAZvCefugWlAMwMAu9opvQ
	(envelope-from <stable+bounces-213225-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:49:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 779F3D9514
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2005A300F9A8
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 12:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8310233EAF2;
	Tue,  3 Feb 2026 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bbw4afH4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4716E20B7ED
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122941; cv=none; b=aNvbL7yaC1Kfxr3Dp3wli7jV7c/KNWPsroJXd3KgGv4+6TuondipTixCiWgPYg1YkzTQy5cJ952/pBA2XyOPop6iBw5KOckav3O0wpd09kjEaMm161+OHGoHw+H+zjiWAH9tK/OlRykHjO5TwCP2Cmr4cKmW0B2dk3JTHlrUynU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122941; c=relaxed/simple;
	bh=4Sl+TFQUmezFdpB/HOgWziAcZlWDFpyQ6qZeM53Mkw4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GFZ2Sbze78D/BqFUKa9zPEGO1ko/KnYAse2O7z8OsqxFLa5AQtFah1j0MDOJ73BuBh6yoQClVOcQydLwz1GVpP5BxLV9cS+ny8bSyPofprp1IOXVSmBi6+3phnlr62zszjNlqRSiaLJ14VpQGLIUBAQ2IrRCLYIjl5JLAZJM44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bbw4afH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F088C19421;
	Tue,  3 Feb 2026 12:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770122941;
	bh=4Sl+TFQUmezFdpB/HOgWziAcZlWDFpyQ6qZeM53Mkw4=;
	h=Subject:To:Cc:From:Date:From;
	b=Bbw4afH44sxZ0DJhjYekZmUNAWvVpRARi39m7jHCEjmTTXl5C6LnWHKOb52SFj+jH
	 mBmarPc9fsuvAOSojk/GU0BAU7oGoaDuH3TUlrUTtLskik7jvO2Bmy2ZzHoi+/2WJm
	 tCHlFWa8gpu5ydW9nDTAGFibcy7ohXzp6bQDpRlo=
Subject: FAILED: patch "[PATCH] mm/memory-failure: fix missing ->mf_stats count in hugetlb" failed to apply to 6.6-stable tree
To: jane.chu@oracle.com,Liam.Howlett@oracle.com,akpm@linux-foundation.org,clm@meta.com,david@kernel.org,jiaqiyan@google.com,linmiaohe@huawei.com,lorenzo.stoakes@oracle.com,mhocko@suse.com,muchun.song@linux.dev,nao.horiguchi@gmail.com,osalvador@suse.de,rientjes@google.com,rppt@kernel.org,stable@vger.kernel.org,surenb@google.com,william.roche@oracle.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Feb 2026 13:48:49 +0100
Message-ID: <2026020349-colony-afoot-ad42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213225-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,linux-foundation.org,meta.com,kernel.org,google.com,huawei.com,suse.com,linux.dev,gmail.com,suse.de,vger.kernel.org,infradead.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,infradead.org:email,linux.dev:email,gregkh:email,suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 779F3D9514
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a148a2040191b12b45b82cb29c281cb3036baf90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020349-colony-afoot-ad42@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a148a2040191b12b45b82cb29c281cb3036baf90 Mon Sep 17 00:00:00 2001
From: Jane Chu <jane.chu@oracle.com>
Date: Tue, 20 Jan 2026 16:22:33 -0700
Subject: [PATCH] mm/memory-failure: fix missing ->mf_stats count in hugetlb
 poison

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

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c80c2907da33..473204359e1f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1883,12 +1883,22 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 	return count;
 }
 
-static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
+#define	MF_HUGETLB_FREED		0	/* freed hugepage */
+#define	MF_HUGETLB_IN_USED		1	/* in-use hugepage */
+#define	MF_HUGETLB_NON_HUGEPAGE		2	/* not a hugepage */
+#define	MF_HUGETLB_FOLIO_PRE_POISONED	3	/* folio already poisoned */
+#define	MF_HUGETLB_PAGE_PRE_POISONED	4	/* exact page already poisoned */
+#define	MF_HUGETLB_RETRY		5	/* hugepage is busy, retry */
+/*
+ * Set hugetlb folio as hwpoisoned, update folio private raw hwpoison list
+ * to keep track of the poisoned pages.
+ */
+static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
 {
 	struct llist_head *head;
 	struct raw_hwp_page *raw_hwp;
 	struct raw_hwp_page *p;
-	int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
+	int ret = folio_test_set_hwpoison(folio) ? MF_HUGETLB_FOLIO_PRE_POISONED : 0;
 
 	/*
 	 * Once the hwpoison hugepage has lost reliable raw error info,
@@ -1896,20 +1906,17 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
 	 * so skip to add additional raw error info.
 	 */
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
-		return -EHWPOISON;
+		return MF_HUGETLB_FOLIO_PRE_POISONED;
 	head = raw_hwp_list_head(folio);
 	llist_for_each_entry(p, head->first, node) {
 		if (p->page == page)
-			return -EHWPOISON;
+			return MF_HUGETLB_PAGE_PRE_POISONED;
 	}
 
 	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
 	if (raw_hwp) {
 		raw_hwp->page = page;
 		llist_add(&raw_hwp->node, head);
-		/* the first error event will be counted in action_result(). */
-		if (ret)
-			num_poisoned_pages_inc(page_to_pfn(page));
 	} else {
 		/*
 		 * Failed to save raw error info.  We no longer trace all
@@ -1957,42 +1964,39 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
 
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
 int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				 bool *migratable_cleared)
 {
 	struct page *page = pfn_to_page(pfn);
 	struct folio *folio = page_folio(page);
-	int ret = 2;	/* fallback to normal page handling */
 	bool count_increased = false;
+	int ret, rc;
 
-	if (!folio_test_hugetlb(folio))
+	if (!folio_test_hugetlb(folio)) {
+		ret = MF_HUGETLB_NON_HUGEPAGE;
 		goto out;
-
-	if (flags & MF_COUNT_INCREASED) {
-		ret = 1;
+	} else if (flags & MF_COUNT_INCREASED) {
+		ret = MF_HUGETLB_IN_USED;
 		count_increased = true;
 	} else if (folio_test_hugetlb_freed(folio)) {
-		ret = 0;
+		ret = MF_HUGETLB_FREED;
 	} else if (folio_test_hugetlb_migratable(folio)) {
-		ret = folio_try_get(folio);
-		if (ret)
+		if (folio_try_get(folio)) {
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
 
-	if (folio_set_hugetlb_hwpoison(folio, page)) {
-		ret = -EHWPOISON;
+	rc = hugetlb_update_hwpoison(folio, page);
+	if (rc >= MF_HUGETLB_FOLIO_PRE_POISONED) {
+		ret = rc;
 		goto out;
 	}
 
@@ -2017,10 +2021,16 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
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
-	int res;
+	int res, rv;
 	struct page *p = pfn_to_page(pfn);
 	struct folio *folio;
 	unsigned long page_flags;
@@ -2029,22 +2039,31 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	*hugetlb = 1;
 retry:
 	res = get_huge_page_for_hwpoison(pfn, flags, &migratable_cleared);
-	if (res == 2) { /* fallback to normal page handling */
+	switch (res) {
+	case MF_HUGETLB_NON_HUGEPAGE:	/* fallback to normal page handling */
 		*hugetlb = 0;
 		return 0;
-	} else if (res == -EHWPOISON) {
-		if (flags & MF_ACTION_REQUIRED) {
-			folio = page_folio(p);
-			res = kill_accessing_process(current, folio_pfn(folio), flags);
-		}
-		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
-		return res;
-	} else if (res == -EBUSY) {
+	case MF_HUGETLB_RETRY:
 		if (!(flags & MF_NO_RETRY)) {
 			flags |= MF_NO_RETRY;
 			goto retry;
 		}
 		return action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
+	case MF_HUGETLB_FOLIO_PRE_POISONED:
+	case MF_HUGETLB_PAGE_PRE_POISONED:
+		rv = -EHWPOISON;
+		if (flags & MF_ACTION_REQUIRED) {
+			folio = page_folio(p);
+			rv = kill_accessing_process(current, folio_pfn(folio), flags);
+		}
+		if (res == MF_HUGETLB_PAGE_PRE_POISONED)
+			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
+		else
+			action_result(pfn, MF_MSG_HUGE, MF_FAILED);
+		return rv;
+	default:
+		WARN_ON((res != MF_HUGETLB_FREED) && (res != MF_HUGETLB_IN_USED));
+		break;
 	}
 
 	folio = page_folio(p);
@@ -2055,7 +2074,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		if (migratable_cleared)
 			folio_set_hugetlb_migratable(folio);
 		folio_unlock(folio);
-		if (res == 1)
+		if (res == MF_HUGETLB_IN_USED)
 			folio_put(folio);
 		return -EOPNOTSUPP;
 	}
@@ -2064,7 +2083,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	 * Handling free hugepage.  The possible race with hugepage allocation
 	 * or demotion can be prevented by PageHWPoison flag.
 	 */
-	if (res == 0) {
+	if (res == MF_HUGETLB_FREED) {
 		folio_unlock(folio);
 		if (__page_handle_poison(p) > 0) {
 			page_ref_inc(p);


