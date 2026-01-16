Return-Path: <stable+bounces-210117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 671D0D387FE
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 21:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E826C30D615F
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 20:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED4F25EF9C;
	Fri, 16 Jan 2026 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kcHkbaNO"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FB01799F
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768596789; cv=none; b=u7GaAx+COwo9gvp2pQiJXgU8UYIbrkhYjglXS4kkHmH7nmHABZv8Z3BGwWJaulzl3T3X6vfTxcVuNHpffHvO9VF0MvaEXXf4aXtyBlZ1KE79dHos5ywyuKHiON1YwVzF/PjlqlZvFV1ISzYKrcPURtsW1oyFLtdm/os4Vd1I4GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768596789; c=relaxed/simple;
	bh=cihrYZNRdjJIuXr0piHB7e8pdjojNx9Q3HggmsK01AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hCoTA+hbl2twojByFnnpAHCIlqGdAi5hY0PJPSIwAPmHP7SRenyR6EbVSx1lc91hXtKHMZd9SOmvzW34kQRzz3GEXDrf1DCbpLC63ZEYTvfYKQvjE63+Euqf7AFwD/C4cfYz7O++qTubUyd4SEgiVeqnnrhGDzyKTbT3xPzThNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kcHkbaNO; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768596786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tfmijTxxqbRMuICsoRtTverNeZ8jwLHJm8kbNLNJYC4=;
	b=kcHkbaNOCn+GafJjIS7kkYKMxNb3mCgXzXJr/82xwYjAxL6ENTLg3HG5Jl53QiozqjlgTK
	J87kA9WkOkTx+qirmSaM/Bn4RTxWN+XmXZeJxqpOnVc6dAO9enpaEmrRvQ085bBEWR7q9p
	5S06TvUh7TM4SJhuaPDbnA7kmaXWf2o=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH] mm: Restore per-memcg proactive reclaim with !CONFIG_NUMA
Date: Fri, 16 Jan 2026 20:52:47 +0000
Message-ID: <20260116205247.928004-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit 2b7226af730c ("mm/memcg: make memory.reclaim interface generic")
moved proactive reclaim logic from memory.reclaim handler to a generic
user_proactive_reclaim() helper to be used for per-node proactive
reclaim.

However, user_proactive_reclaim() was only defined under CONFIG_NUMA,
with a stub always returning 0 otherwise. This broke memory.reclaim on
!CONFIG_NUMA configs, causing it to report success without actually
attempting reclaim.

Move the definition of user_proactive_reclaim() outside CONFIG_NUMA, and
instead define a stub for __node_reclaim() in the !CONFIG_NUMA case.
__node_reclaim() is only called from user_proactive_reclaim() when a
write is made to sys/devices/system/node/nodeX/reclaim, which is only
defined with CONFIG_NUMA.

Fixes: 2b7226af730c ("mm/memcg: make memory.reclaim interface generic")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 mm/internal.h |  8 --------
 mm/vmscan.c   | 13 +++++++++++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 33eb0224f461..9508dbaf47cd 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -615,16 +615,8 @@ extern unsigned long highest_memmap_pfn;
 bool folio_isolate_lru(struct folio *folio);
 void folio_putback_lru(struct folio *folio);
 extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason);
-#ifdef CONFIG_NUMA
 int user_proactive_reclaim(char *buf,
 			   struct mem_cgroup *memcg, pg_data_t *pgdat);
-#else
-static inline int user_proactive_reclaim(char *buf,
-			   struct mem_cgroup *memcg, pg_data_t *pgdat)
-{
-	return 0;
-}
-#endif
 
 /*
  * in mm/rmap.c:
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7b28018ac995..d9918f24dea0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7849,6 +7849,17 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 	return ret;
 }
 
+#else
+
+static unsigned long __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask,
+				    unsigned long nr_pages,
+				    struct scan_control *sc)
+{
+	return 0;
+}
+
+#endif
+
 enum {
 	MEMORY_RECLAIM_SWAPPINESS = 0,
 	MEMORY_RECLAIM_SWAPPINESS_MAX,
@@ -7956,8 +7967,6 @@ int user_proactive_reclaim(char *buf,
 	return 0;
 }
 
-#endif
-
 /**
  * check_move_unevictable_folios - Move evictable folios to appropriate zone
  * lru list
-- 
2.52.0.457.g6b5491de43-goog


