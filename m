Return-Path: <stable+bounces-62518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53AE93F50F
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564021F2230F
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF20147C60;
	Mon, 29 Jul 2024 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kyW7z6jj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8114430A
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255610; cv=none; b=N6E1qvDQM7D0Pjn70NQueh0NqE/jsO/JdEo/GOGENlQ13eww2eoeE0yKYv0EK0oziX+1UhELedp5CyMbwvHk7XhP7Cytq188RQSucQVo2l3MOoFPAU9WE+V+wGk48RKU14GK/OSaxebbmoPpYJl+ZmSXdLdoFykF3nR1MAKls74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255610; c=relaxed/simple;
	bh=lxuczo1UQ2NGpzatXJXh/O1hXyhQMlybk+nT3bWiSm4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J1fEx2CgjwNKlJoRU8nFJyNHX+WFsbBETsvlfB4Gq6+Ov1n0ek5EsGBbGjJ1l1cvDInNYl4ZVRKrnLRToiUb/eZmYMnjxU1JTgOho9cfqN7chIwdGSFi0xLkl1hjvwyHAt5wuiZmAa+Si2MS8Bdfhn7ZnzEj0XWNIly+WyymoCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kyW7z6jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C817C4AF0C;
	Mon, 29 Jul 2024 12:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722255609;
	bh=lxuczo1UQ2NGpzatXJXh/O1hXyhQMlybk+nT3bWiSm4=;
	h=Subject:To:Cc:From:Date:From;
	b=kyW7z6jj4TZwF823VuV9KbyuQH/XlV8A5WaB2FYYeBlPI4IKLS77hLAgUVKCE8E6U
	 t9DtRtyx5RNat1vwYTJVB1tpFPKjuuvlnRE6KMUTqd54/aTTkTQFgKKYTG7YDf31qs
	 mLvtu50RITKpK8E4SW66pXzgyrllD+qm57QGFy8w=
Subject: FAILED: patch "[PATCH] mm/page_alloc: fix pcp->count race between drain_pages_zone()" failed to apply to 6.6-stable tree
To: lizhijian@fujitsu.com,akpm@linux-foundation.org,david@redhat.com,stable@vger.kernel.org,vbabka@suse.cz,yaoxt.fnst@fujitsu.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:20:03 +0200
Message-ID: <2024072902-yippee-superbowl-f065@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 66eca1021a42856d6af2a9802c99e160278aed91
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072902-yippee-superbowl-f065@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

66eca1021a42 ("mm/page_alloc: fix pcp->count race between drain_pages_zone() vs __rmqueue_pcplist()")
55f77df7d715 ("mm: page_alloc: control latency caused by zone PCP draining")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 66eca1021a42856d6af2a9802c99e160278aed91 Mon Sep 17 00:00:00 2001
From: Li Zhijian <lizhijian@fujitsu.com>
Date: Tue, 23 Jul 2024 14:44:28 +0800
Subject: [PATCH] mm/page_alloc: fix pcp->count race between drain_pages_zone()
 vs __rmqueue_pcplist()

It's expected that no page should be left in pcp_list after calling
zone_pcp_disable() in offline_pages().  Previously, it's observed that
offline_pages() gets stuck [1] due to some pages remaining in pcp_list.

Cause:
There is a race condition between drain_pages_zone() and __rmqueue_pcplist()
involving the pcp->count variable. See below scenario:

         CPU0                              CPU1
    ----------------                    ---------------
                                      spin_lock(&pcp->lock);
                                      __rmqueue_pcplist() {
zone_pcp_disable() {
                                        /* list is empty */
                                        if (list_empty(list)) {
                                          /* add pages to pcp_list */
                                          alloced = rmqueue_bulk()
  mutex_lock(&pcp_batch_high_lock)
  ...
  __drain_all_pages() {
    drain_pages_zone() {
      /* read pcp->count, it's 0 here */
      count = READ_ONCE(pcp->count)
      /* 0 means nothing to drain */
                                          /* update pcp->count */
                                          pcp->count += alloced << order;
      ...
                                      ...
                                      spin_unlock(&pcp->lock);

In this case, after calling zone_pcp_disable() though, there are still some
pages in pcp_list. And these pages in pcp_list are neither movable nor
isolated, offline_pages() gets stuck as a result.

Solution:
Expand the scope of the pcp->lock to also protect pcp->count in
drain_pages_zone(), to ensure no pages are left in the pcp list after
zone_pcp_disable()

[1] https://lore.kernel.org/linux-mm/6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com/

Link: https://lkml.kernel.org/r/20240723064428.1179519-1-lizhijian@fujitsu.com
Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Reported-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7ac8d61148fe..28f80daf5c04 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2343,16 +2343,20 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
 	struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-	int count = READ_ONCE(pcp->count);
-
-	while (count) {
-		int to_drain = min(count, pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
-		count -= to_drain;
+	int count;
 
+	do {
 		spin_lock(&pcp->lock);
-		free_pcppages_bulk(zone, to_drain, pcp, 0);
+		count = pcp->count;
+		if (count) {
+			int to_drain = min(count,
+				pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
+
+			free_pcppages_bulk(zone, to_drain, pcp, 0);
+			count -= to_drain;
+		}
 		spin_unlock(&pcp->lock);
-	}
+	} while (count);
 }
 
 /*


