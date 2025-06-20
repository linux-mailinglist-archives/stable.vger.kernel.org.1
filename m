Return-Path: <stable+bounces-155056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EB4AE174D
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131044A64A2
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0769A27FD6E;
	Fri, 20 Jun 2025 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2YuKb55L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1457D098
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411002; cv=none; b=rE1mk0g5OR+v4yPewV0lUpRJ00sjiC8SOEokekrW0P/SH1BCBWADs7U4VwYkKhEksl7/66yJZFQFfaFOVMlb00s6BlPKVknuwUTf3GI4jpvbzSdszQStH+NQQpHdWm/MZ8kxLY0a/TmEdgTqfpWXWgkHjTriaqXSIYg/cmpS5lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411002; c=relaxed/simple;
	bh=IaH8xudgdjGtSU+/p2ZZM2/lqcRbMPCel8zXJbKnqIE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f3aLOUSoj0mTrUUm/FnObCc0iPiK0RuXseWjbNixa8u8hPm618YguDm/NiY9tY5E4SNJ0E55bdYg8oQ6nELL9+1umqIz8uhYdlA5rxJRdjrXlYIZRdVplWhjurQsKwL4il8QrKqBan7BQdgAd5J1HG40A8pkO0vnuCy6heQzKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2YuKb55L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB588C4CEE3;
	Fri, 20 Jun 2025 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750411002;
	bh=IaH8xudgdjGtSU+/p2ZZM2/lqcRbMPCel8zXJbKnqIE=;
	h=Subject:To:Cc:From:Date:From;
	b=2YuKb55LY/K8MAayA5Upnk+OeEWr/O5/oNeKWrg//YN3i1qNx3K2vTQ8pd7hBJVYN
	 SzmcUR3SK29P8yiDVWF1aJc/kCQ+mSWQM8orWoB6VFksWXZzvFqdvsWXBeXQeyMCNo
	 kg0GX1lZxMGRL/erI9g9hqPyawKT+bVabJXh8J/8=
Subject: FAILED: patch "[PATCH] mm/khugepaged: fix race with folio split/free using temporary" failed to apply to 6.15-stable tree
To: shivankg@amd.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,bharata@amd.com,david@redhat.com,dev.jain@arm.com,fengwei.yin@intel.com,liam.howlett@oracle.com,lorenzo.stoakes@oracle.com,npache@redhat.com,ryan.roberts@arm.com,stable@vger.kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:16:39 +0200
Message-ID: <2025062039-policy-handheld-01c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 595cf683519ab5a277d258a2251ee8cc7b838d6d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062039-policy-handheld-01c6@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 595cf683519ab5a277d258a2251ee8cc7b838d6d Mon Sep 17 00:00:00 2001
From: Shivank Garg <shivankg@amd.com>
Date: Mon, 26 May 2025 18:28:18 +0000
Subject: [PATCH] mm/khugepaged: fix race with folio split/free using temporary
 reference

hpage_collapse_scan_file() calls is_refcount_suitable(), which in turn
calls folio_mapcount().  folio_mapcount() checks folio_test_large() before
proceeding to folio_large_mapcount(), but there is a race window where the
folio may get split/freed between these checks, triggering:

  VM_WARN_ON_FOLIO(!folio_test_large(folio), folio)

Take a temporary reference to the folio in hpage_collapse_scan_file().
This stabilizes the folio during refcount check and prevents incorrect
large folio detection due to concurrent split/free.  Use helper
folio_expected_ref_count() + 1 to compare with folio_ref_count() instead
of using is_refcount_suitable().

Link: https://lkml.kernel.org/r/20250526182818.37978-1-shivankg@amd.com
Fixes: 05c5323b2a34 ("mm: track mapcount of large folios in single value")
Signed-off-by: Shivank Garg <shivankg@amd.com>
Reported-by: syzbot+2b99589e33edbe9475ca@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6828470d.a70a0220.38f255.000c.GAE@google.com
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Fengwei Yin <fengwei.yin@intel.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mariano Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cdf5a581368b..7731a162a1a7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2293,6 +2293,17 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 			continue;
 		}
 
+		if (!folio_try_get(folio)) {
+			xas_reset(&xas);
+			continue;
+		}
+
+		if (unlikely(folio != xas_reload(&xas))) {
+			folio_put(folio);
+			xas_reset(&xas);
+			continue;
+		}
+
 		if (folio_order(folio) == HPAGE_PMD_ORDER &&
 		    folio->index == start) {
 			/* Maybe PMD-mapped */
@@ -2303,23 +2314,27 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 			 * it's safe to skip LRU and refcount checks before
 			 * returning.
 			 */
+			folio_put(folio);
 			break;
 		}
 
 		node = folio_nid(folio);
 		if (hpage_collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
+			folio_put(folio);
 			break;
 		}
 		cc->node_load[node]++;
 
 		if (!folio_test_lru(folio)) {
 			result = SCAN_PAGE_LRU;
+			folio_put(folio);
 			break;
 		}
 
-		if (!is_refcount_suitable(folio)) {
+		if (folio_expected_ref_count(folio) + 1 != folio_ref_count(folio)) {
 			result = SCAN_PAGE_COUNT;
+			folio_put(folio);
 			break;
 		}
 
@@ -2331,6 +2346,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		 */
 
 		present += folio_nr_pages(folio);
+		folio_put(folio);
 
 		if (need_resched()) {
 			xas_pause(&xas);


