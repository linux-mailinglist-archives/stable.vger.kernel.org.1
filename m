Return-Path: <stable+bounces-114674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BDFA2F12F
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031AA3A831A
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E07204879;
	Mon, 10 Feb 2025 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ac7XxLEa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2D75809
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200405; cv=none; b=gyANM+gXEixv21+BhSHb7lWA2s0z0bvnFhdHG3pEsywr8XgxPVEjFfedS2uUVPYSDHLcQq2P3rSSyWB4P1T1VHlSAaY8cjWvNgvryTs1rV1wIX2UQckcz/bORcP6iAbprynuKpa04hHioufVk3Bh/+SG/cskiM1flnEM77KEHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200405; c=relaxed/simple;
	bh=vPqZLJQf1MXAxOelNXAhSMkxBCsNdy15yoDB3rnKJMM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=POe6EvYP7YztSbIaYBT/vv7ceqwNH4xvnv+Wpc2C0tE81fqK19gW3LkGfvZNRW7gD/rFdYW4sRPL95KVxOirxK7DEqwyTn9ZYWwGjCclesU0H3e9G87UyhIeDWzrAqVdyIMfCCyyk25M4S7ejXXOHfwAl/L2aGuFanRLM49bQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ac7XxLEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697EAC4CED1;
	Mon, 10 Feb 2025 15:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739200404;
	bh=vPqZLJQf1MXAxOelNXAhSMkxBCsNdy15yoDB3rnKJMM=;
	h=Subject:To:Cc:From:Date:From;
	b=ac7XxLEaFnZP/f9BfNFqSEzsLBxeHB1llqJLxzsBoG+3ReMO+m0N1/7S5ilivI0yE
	 kodxSD1KoODNmZZY4wyJRM3Ce5zu4WyNYDtb4DlSc+sNP4f69PUCVSXXl4GiHuC49u
	 7/rYLwG5BMT6lGwEiCE8LQuDTccKdmeKwN5knEvY=
Subject: FAILED: patch "[PATCH] mm: gup: fix infinite loop within __get_longterm_locked" failed to apply to 6.1-stable tree
To: zhaoyang.huang@unisoc.com,aijun.sun@unisoc.com,akpm@linux-foundation.org,apopple@nvidia.com,david@redhat.com,jhubbard@nvidia.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 16:13:08 +0100
Message-ID: <2025021008-nemeses-footwork-0f1d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1aaf8c122918aa8897605a9aa1e8ed6600d6f930
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021008-nemeses-footwork-0f1d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1aaf8c122918aa8897605a9aa1e8ed6600d6f930 Mon Sep 17 00:00:00 2001
From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Date: Tue, 21 Jan 2025 10:01:59 +0800
Subject: [PATCH] mm: gup: fix infinite loop within __get_longterm_locked

We can run into an infinite loop in __get_longterm_locked() when
collect_longterm_unpinnable_folios() finds only folios that are isolated
from the LRU or were never added to the LRU.  This can happen when all
folios to be pinned are never added to the LRU, for example when
vm_ops->fault allocated pages using cma_alloc() and never added them to
the LRU.

Fix it by simply taking a look at the list in the single caller, to see if
anything was added.

[zhaoyang.huang@unisoc.com: move definition of local]
  Link: https://lkml.kernel.org/r/20250122012604.3654667-1-zhaoyang.huang@unisoc.com
Link: https://lkml.kernel.org/r/20250121020159.3636477-1-zhaoyang.huang@unisoc.com
Fixes: 67e139b02d99 ("mm/gup.c: refactor check_and_migrate_movable_pages()")
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Aijun Sun <aijun.sun@unisoc.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/gup.c b/mm/gup.c
index 9aaf338cc1f4..3883b307780e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2320,13 +2320,13 @@ static void pofs_unpin(struct pages_or_folios *pofs)
 /*
  * Returns the number of collected folios. Return value is always >= 0.
  */
-static unsigned long collect_longterm_unpinnable_folios(
+static void collect_longterm_unpinnable_folios(
 		struct list_head *movable_folio_list,
 		struct pages_or_folios *pofs)
 {
-	unsigned long i, collected = 0;
 	struct folio *prev_folio = NULL;
 	bool drain_allow = true;
+	unsigned long i;
 
 	for (i = 0; i < pofs->nr_entries; i++) {
 		struct folio *folio = pofs_get_folio(pofs, i);
@@ -2338,8 +2338,6 @@ static unsigned long collect_longterm_unpinnable_folios(
 		if (folio_is_longterm_pinnable(folio))
 			continue;
 
-		collected++;
-
 		if (folio_is_device_coherent(folio))
 			continue;
 
@@ -2361,8 +2359,6 @@ static unsigned long collect_longterm_unpinnable_folios(
 				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
 				    folio_nr_pages(folio));
 	}
-
-	return collected;
 }
 
 /*
@@ -2439,11 +2435,9 @@ static long
 check_and_migrate_movable_pages_or_folios(struct pages_or_folios *pofs)
 {
 	LIST_HEAD(movable_folio_list);
-	unsigned long collected;
 
-	collected = collect_longterm_unpinnable_folios(&movable_folio_list,
-						       pofs);
-	if (!collected)
+	collect_longterm_unpinnable_folios(&movable_folio_list, pofs);
+	if (list_empty(&movable_folio_list))
 		return 0;
 
 	return migrate_longterm_unpinnable_folios(&movable_folio_list, pofs);


