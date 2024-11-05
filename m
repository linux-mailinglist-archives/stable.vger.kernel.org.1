Return-Path: <stable+bounces-89879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A73A9BD27A
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32EE21F22FC4
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D771D90A4;
	Tue,  5 Nov 2024 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z8kSvi+s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDDD13D531
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824591; cv=none; b=UqXqjcwnCstTvUpGFdNmUyCoL440vXQadrxD4lY9TCSFBybmzhkfX4NXhdsrmCIhQ9aeBQS5JJZP8g6clVyZGRKdjBZGj4zApIBmFS9xPszizMYYYuX7D8P/hKRZ35DIN8z4V6OKC7oPL5SmypXgIlxPo5jIe9EYpIMIkDZJI4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824591; c=relaxed/simple;
	bh=D3oMKEXKZ8dBassaS+Cdd0p5yJc8rZHASzwoG85c5Wc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oiksnz+5a4Oi2EqIwWaO0ftOLYKGYAMmkz3b2cVEgmP8Xl0gC0EqYCZr9Vomldtu0GtcbGhFvqUlo2tjWKRS7Y1oyvc4Rbf95QiA4M5pWvXWzeXmOrmLMM6TRYEfkB/zRyliSey6V79ZQm3rfrj6CVmxJCpphmGSof2JppoCwFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z8kSvi+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF6BC4CED2;
	Tue,  5 Nov 2024 16:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730824591;
	bh=D3oMKEXKZ8dBassaS+Cdd0p5yJc8rZHASzwoG85c5Wc=;
	h=Subject:To:Cc:From:Date:From;
	b=Z8kSvi+sPcZ6NkkX2NLkiHUK5o+cviqZYqUmfwbg5rwGTg8GGxsNL3l9lhD+XGLq5
	 GxJG0orF/mzWhPihHO//hOxumryveMOafi6UxrqO+mzkKfNiTjaGcFXYTiTXrO/fiB
	 4MTtIDzLUwuH1jbjsIseaEIjPc+MJztXlma1ub8I=
Subject: FAILED: patch "[PATCH] mm: avoid unconditional one-tick sleep when swapcache_prepare" failed to apply to 6.6-stable tree
To: baohua@kernel.org,akpm@linux-foundation.org,chrisl@kernel.org,david@redhat.com,hannes@cmpxchg.org,hughd@google.com,kaleshsingh@google.com,kasong@tencent.com,liyangouwen1@oppo.com,mhocko@suse.com,minchan@kernel.org,sj@kernel.org,stable@vger.kernel.org,surenb@google.com,v-songbaohua@oppo.com,willy@infradead.org,ying.huang@intel.com,yosryahmed@google.com,yuzhao@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:36:06 +0100
Message-ID: <2024110505-january-napped-4f1b@gregkh>
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
git cherry-pick -x 01626a18230246efdcea322aa8f067e60ffe5ccd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110505-january-napped-4f1b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 01626a18230246efdcea322aa8f067e60ffe5ccd Mon Sep 17 00:00:00 2001
From: Barry Song <baohua@kernel.org>
Date: Fri, 27 Sep 2024 09:19:36 +1200
Subject: [PATCH] mm: avoid unconditional one-tick sleep when swapcache_prepare
 fails

Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
introduced an unconditional one-tick sleep when `swapcache_prepare()`
fails, which has led to reports of UI stuttering on latency-sensitive
Android devices.  To address this, we can use a waitqueue to wake up tasks
that fail `swapcache_prepare()` sooner, instead of always sleeping for a
full tick.  While tasks may occasionally be woken by an unrelated
`do_swap_page()`, this method is preferable to two scenarios: rapid
re-entry into page faults, which can cause livelocks, and multiple
millisecond sleeps, which visibly degrade user experience.

Oven's testing shows that a single waitqueue resolves the UI stuttering
issue.  If a 'thundering herd' problem becomes apparent later, a waitqueue
hash similar to `folio_wait_table[PAGE_WAIT_TABLE_SIZE]` for page bit
locks can be introduced.

[v-songbaohua@oppo.com: wake_up only when swapcache_wq waitqueue is active]
  Link: https://lkml.kernel.org/r/20241008130807.40833-1-21cnbao@gmail.com
Link: https://lkml.kernel.org/r/20240926211936.75373-1-21cnbao@gmail.com
Fixes: 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reported-by: Oven Liyang <liyangouwen1@oppo.com>
Tested-by: Oven Liyang <liyangouwen1@oppo.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory.c b/mm/memory.c
index 3ccee51adfbb..bdf77a3ec47b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4187,6 +4187,8 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -4199,6 +4201,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *swapcache, *folio = NULL;
+	DECLARE_WAITQUEUE(wait, current);
 	struct page *page;
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
@@ -4297,7 +4300,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 					 * Relax a bit to prevent rapid
 					 * repeated page faults.
 					 */
+					add_wait_queue(&swapcache_wq, &wait);
 					schedule_timeout_uninterruptible(1);
+					remove_wait_queue(&swapcache_wq, &wait);
 					goto out_page;
 				}
 				need_clear_cache = true;
@@ -4604,8 +4609,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	/* Clear the swap cache pin for direct swapin after PTL unlock */
-	if (need_clear_cache)
+	if (need_clear_cache) {
 		swapcache_clear(si, entry, nr_pages);
+		if (waitqueue_active(&swapcache_wq))
+			wake_up(&swapcache_wq);
+	}
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4620,8 +4628,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_unlock(swapcache);
 		folio_put(swapcache);
 	}
-	if (need_clear_cache)
+	if (need_clear_cache) {
 		swapcache_clear(si, entry, nr_pages);
+		if (waitqueue_active(&swapcache_wq))
+			wake_up(&swapcache_wq);
+	}
 	if (si)
 		put_swap_device(si);
 	return ret;


