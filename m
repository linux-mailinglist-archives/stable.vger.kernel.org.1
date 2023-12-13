Return-Path: <stable+bounces-5062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DF080AD63
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 20:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F56281971
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 19:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F423C55C25;
	Fri,  8 Dec 2023 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gF4LljHs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06E50242;
	Fri,  8 Dec 2023 19:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B674C433C9;
	Fri,  8 Dec 2023 19:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702065246;
	bh=kPe4IlVI1Y6qbWtcuvmAbELeLWJsURoB5Z3rxJ76ac4=;
	h=Date:To:From:Subject:From;
	b=gF4LljHsdJQiGpMI9fNuZwZTPTbWcJFFXHpFj+h+vGJDRw1Rwa5gSCDHYNBrGQe1x
	 lv+9M7JFpPEIV0s8Nwn2MQjtITym4mMr4xHhpf8R7vjiWd+YXP3VoaluOyxoppHgLP
	 lZBphnZrwsr8bLFjEJOL1C9XbQ9rnYdRQTVB8GPs=
Date: Fri, 08 Dec 2023 11:54:05 -0800
To: mm-commits@vger.kernel.org,tjmercier@google.com,stable@vger.kernel.org,ryncsn@gmail.com,quic_charante@quicinc.com,kaleshsingh@google.com,jaroslav.pulchart@gooddata.com,hdanton@sina.com,yuzhao@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-mglru-reclaim-offlined-memcgs-harder.patch added to mm-hotfixes-unstable branch
Message-Id: <20231208195406.3B674C433C9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm/mglru: reclaim offlined memcgs harder
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-mglru-reclaim-offlined-memcgs-harder.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-mglru-reclaim-offlined-memcgs-harder.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Yu Zhao <yuzhao@google.com>
Subject: mm/mglru: reclaim offlined memcgs harder
Date: Thu, 7 Dec 2023 23:14:07 -0700

In the effort to reduce zombie memcgs [1], it was discovered that the
memcg LRU doesn't apply enough pressure on offlined memcgs.  Specifically,
instead of rotating them to the tail of the current generation
(MEMCG_LRU_TAIL) for a second attempt, it moves them to the next
generation (MEMCG_LRU_YOUNG) after the first attempt.

Not applying enough pressure on offlined memcgs can cause them to build
up, and this can be particularly harmful to memory-constrained systems.

On Pixel 8 Pro, launching apps for 50 cycles:
                 Before  After  Change
  Zombie memcgs  45      35     -22%

[1] https://lore.kernel.org/CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com/

Link: https://lkml.kernel.org/r/20231208061407.2125867-4-yuzhao@google.com
Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reported-by: T.J. Mercier <tjmercier@google.com>
Tested-by: T.J. Mercier <tjmercier@google.com>
Cc: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/mmzone.h |    8 ++++----
 mm/vmscan.c            |   24 ++++++++++++++++--------
 2 files changed, 20 insertions(+), 12 deletions(-)

--- a/include/linux/mmzone.h~mm-mglru-reclaim-offlined-memcgs-harder
+++ a/include/linux/mmzone.h
@@ -519,10 +519,10 @@ void lru_gen_look_around(struct page_vma
  * 1. Exceeding the soft limit, which triggers MEMCG_LRU_HEAD;
  * 2. The first attempt to reclaim a memcg below low, which triggers
  *    MEMCG_LRU_TAIL;
- * 3. The first attempt to reclaim a memcg below reclaimable size threshold,
- *    which triggers MEMCG_LRU_TAIL;
- * 4. The second attempt to reclaim a memcg below reclaimable size threshold,
- *    which triggers MEMCG_LRU_YOUNG;
+ * 3. The first attempt to reclaim a memcg offlined or below reclaimable size
+ *    threshold, which triggers MEMCG_LRU_TAIL;
+ * 4. The second attempt to reclaim a memcg offlined or below reclaimable size
+ *    threshold, which triggers MEMCG_LRU_YOUNG;
  * 5. Attempting to reclaim a memcg below min, which triggers MEMCG_LRU_YOUNG;
  * 6. Finishing the aging on the eviction path, which triggers MEMCG_LRU_YOUNG;
  * 7. Offlining a memcg, which triggers MEMCG_LRU_OLD.
--- a/mm/vmscan.c~mm-mglru-reclaim-offlined-memcgs-harder
+++ a/mm/vmscan.c
@@ -4598,7 +4598,12 @@ static bool should_run_aging(struct lruv
 	}
 
 	/* try to scrape all its memory if this memcg was deleted */
-	*nr_to_scan = mem_cgroup_online(memcg) ? (total >> sc->priority) : total;
+	if (!mem_cgroup_online(memcg)) {
+		*nr_to_scan = total;
+		return false;
+	}
+
+	*nr_to_scan = total >> sc->priority;
 
 	/*
 	 * The aging tries to be lazy to reduce the overhead, while the eviction
@@ -4719,14 +4724,9 @@ static int shrink_one(struct lruvec *lru
 	bool success;
 	unsigned long scanned = sc->nr_scanned;
 	unsigned long reclaimed = sc->nr_reclaimed;
-	int seg = lru_gen_memcg_seg(lruvec);
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
-	/* see the comment on MEMCG_NR_GENS */
-	if (!lruvec_is_sizable(lruvec, sc))
-		return seg != MEMCG_LRU_TAIL ? MEMCG_LRU_TAIL : MEMCG_LRU_YOUNG;
-
 	mem_cgroup_calculate_protection(NULL, memcg);
 
 	if (mem_cgroup_below_min(NULL, memcg))
@@ -4734,7 +4734,7 @@ static int shrink_one(struct lruvec *lru
 
 	if (mem_cgroup_below_low(NULL, memcg)) {
 		/* see the comment on MEMCG_NR_GENS */
-		if (seg != MEMCG_LRU_TAIL)
+		if (lru_gen_memcg_seg(lruvec) != MEMCG_LRU_TAIL)
 			return MEMCG_LRU_TAIL;
 
 		memcg_memory_event(memcg, MEMCG_LOW);
@@ -4750,7 +4750,15 @@ static int shrink_one(struct lruvec *lru
 
 	flush_reclaim_state(sc);
 
-	return success ? MEMCG_LRU_YOUNG : 0;
+	if (success && mem_cgroup_online(memcg))
+		return MEMCG_LRU_YOUNG;
+
+	if (!success && lruvec_is_sizable(lruvec, sc))
+		return 0;
+
+	/* one retry if offlined or too small */
+	return lru_gen_memcg_seg(lruvec) != MEMCG_LRU_TAIL ?
+	       MEMCG_LRU_TAIL : MEMCG_LRU_YOUNG;
 }
 
 #ifdef CONFIG_MEMCG
_

Patches currently in -mm which might be from yuzhao@google.com are

mm-mglru-fix-underprotected-page-cache.patch
mm-mglru-try-to-stop-at-high-watermarks.patch
mm-mglru-respect-min_ttl_ms-with-memcgs.patch
mm-mglru-reclaim-offlined-memcgs-harder.patch


