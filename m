Return-Path: <stable+bounces-4969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D76809C3E
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 07:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1205C1F212B0
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 06:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197C4748D;
	Fri,  8 Dec 2023 06:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GUYrbsor"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0F91721
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 22:14:20 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d42c43d8daso11381157b3.0
        for <stable@vger.kernel.org>; Thu, 07 Dec 2023 22:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702016060; x=1702620860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XyO/ljh9FKCeCHVPdhFy9bPgiCVl0Vc+13vD9r1JAPY=;
        b=GUYrbsor2KKaC7Oq15b/4pulJKhW+gjsCS0minnbPPwyvsHQFaZzo35B6Wrlaqc3bG
         ItvYxkU+76n3Gh/uZHpFEDogn6aZo9mMc3qbHzjaFYGQbhtia40wLFS9uGoSVCTs7dwQ
         PYJhdgNM5xAT1dQlLe07Yn03/E+LTNyxZn6cTs9EWKDZqInOttTFuT+H/C6WD2rx7aBZ
         TwTYMvJUIcBsfGP8pHpDUr+9nsqnx6o577bt/yZ9mi+L4sGML9Kk/JP44HPVBhXaAzSO
         dU1FcKVBTT4wm2ZSrl2Bi34BH1HLlEamXWcWlNHdEjmn0DXF5dkorJAp4HYCDis/F9uY
         stfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702016060; x=1702620860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyO/ljh9FKCeCHVPdhFy9bPgiCVl0Vc+13vD9r1JAPY=;
        b=EDbAdGhVxjh6cyZ0kp4XeMmL+ZRkY3oXdAWLeOqQDEyk2cARSPUzJS77myXAq2sBRb
         1T9LJiJaUgti/CZm/d/p30Ld6ER1nf3lLf4+N/HHxcxMuY8lpK1tDXskydAyL6FpU25j
         Hj/wc1b3YtYLrUARMnqu0eLYnAQ3zr0c4/urn2w5siJs+ccC/JHu9UEmogdS/Q/hNNWl
         ix7/onFD6GBsvQ2/bbJvb3winAvMD+jO3qfV1PPJDrxOPCQOwbyu5wSVvLR5ycrTHWy4
         4kzG+QCwmpX8lAMsutK/n/afA/qaJdM4e7JEbEJcI43DDLcDKK67m9RJ6+XRRZCOYMX1
         hnfQ==
X-Gm-Message-State: AOJu0YygKV9Kh00uoUIy77mtGwGGN6773cLtynUEGuDgWkQJsPx6GKWu
	Vm8HPqRzMyb829eIPa5h9sboyu4LBAM=
X-Google-Smtp-Source: AGHT+IHgAD3BUwnh/ze1lDgA5VK1+NfzNOWSF6TnZDywN1IKmaY+ZlKGrPraa9vlIOKdRdO0XE83PMMSUHc=
X-Received: from yuzhao2.bld.corp.google.com ([100.64.188.49]) (user=yuzhao
 job=sendgmr) by 2002:a05:690c:d05:b0:5d3:e8b8:e1fd with SMTP id
 cn5-20020a05690c0d0500b005d3e8b8e1fdmr7250ywb.3.1702016060001; Thu, 07 Dec
 2023 22:14:20 -0800 (PST)
Date: Thu,  7 Dec 2023 23:14:07 -0700
In-Reply-To: <20231208061407.2125867-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208061407.2125867-1-yuzhao@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208061407.2125867-4-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 4/4] mm/mglru: reclaim offlined memcgs harder
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, "T . J . Mercier" <tjmercier@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In the effort to reduce zombie memcgs [1], it was discovered that the
memcg LRU doesn't apply enough pressure on offlined memcgs.
Specifically, instead of rotating them to the tail of the current
generation (MEMCG_LRU_TAIL) for a second attempt, it moves them to the
next generation (MEMCG_LRU_YOUNG) after the first attempt.

Not applying enough pressure on offlined memcgs can cause them to
build up, and this can be particularly harmful to memory-constrained
systems.

On Pixel 8 Pro, launching apps for 50 cycles:
                 Before  After  Change
  Zombie memcgs  45      35     -22%

[1] https://lore.kernel.org/CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com/

Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reported-by: T.J. Mercier <tjmercier@google.com>
Tested-by: T.J. Mercier <tjmercier@google.com>
Cc: stable@vger.kernel.org
---
 include/linux/mmzone.h |  8 ++++----
 mm/vmscan.c            | 24 ++++++++++++++++--------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e3093ef9530f..2efd3be484fd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -524,10 +524,10 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
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
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cac38e9cac86..dad4b80b04cd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4626,7 +4626,12 @@ static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq,
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
@@ -4747,14 +4752,9 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
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
@@ -4762,7 +4762,7 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 
 	if (mem_cgroup_below_low(NULL, memcg)) {
 		/* see the comment on MEMCG_NR_GENS */
-		if (seg != MEMCG_LRU_TAIL)
+		if (lru_gen_memcg_seg(lruvec) != MEMCG_LRU_TAIL)
 			return MEMCG_LRU_TAIL;
 
 		memcg_memory_event(memcg, MEMCG_LOW);
@@ -4778,7 +4778,15 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 
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
-- 
2.43.0.472.g3155946c3a-goog


