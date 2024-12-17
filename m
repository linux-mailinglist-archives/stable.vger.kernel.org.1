Return-Path: <stable+bounces-104411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4689F40C0
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 03:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D14162956
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 02:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3921142E77;
	Tue, 17 Dec 2024 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AmgMalE5"
X-Original-To: stable@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13957145335;
	Tue, 17 Dec 2024 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402611; cv=none; b=TUMpaAN0/R8lapDpQ+X+GXSlXXgi35wq9ytabB7M3os3GoJCEVXhyRnvMGqqo8Dw2VX4UYgXk4vT0KsYX9K9a9RVOEgKjYhI3emKvNigEG8Lly82ZHFYMzstxDzjWFir73hZ3/M1Fs5U28QrMelsBcMkC68nEhkRkaiv44adOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402611; c=relaxed/simple;
	bh=KvSHcgGfj5fVpbu4sV7uw540x5cmriVxQ9T+i6eEZbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvVgsJDcnTnn0B20UawDt5BjAiuuA01NyiRKpAV8MzgJjUVC3OTwWhh2S6Y93Hv0A2fJE8algRwbTL5IgIocILMhC5c4OZsera3o7hi5Mv6ddkXWriET4BeJoiVfkyg5thEB9/qDNzbxzxpvrWfvxHboYd25mZrpFBFLo0bamwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AmgMalE5; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734402600; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QCiwhXfJ2Z0HlTT5Ug0kalY1OtMxy3tJMQ6EtfaFoZg=;
	b=AmgMalE5QJrV980BE6thr25qt6e+OL7tX64Fxvv7aeMohY22AkRDbBOb02OKJ8NwRdE3sYLqvhUBlQfe7nhvYFz3NpK0iVti1UjvOKxmjbbPzKIR/tBJ+nK9r/ja23V5yrRI8DgB9UXdVoWYqd35R1Ua6Ce7QejM+3Mz7CV2PF4=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WLguG8A_1734402598 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Dec 2024 10:29:59 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: yangge1116@126.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liuzixing@hygon.cn,
	stable@vger.kernel.org,
	vbabka@suse.cz
Subject: [PATCH] mm: compaction: fix don't use ALLOC_CMA in long term GUP flow
Date: Tue, 17 Dec 2024 10:29:55 +0800
Message-Id: <20241217022955.141818-1-baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <1734350044-12928-1-git-send-email-yangge1116@126.com>
References: <1734350044-12928-1-git-send-email-yangge1116@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Need update cc->alloc_flags to keep the original logic.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 6 ++++--
 mm/page_alloc.c | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index b10d921c237b..d92ba6c4708c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2895,6 +2895,7 @@ static int compact_node(pg_data_t *pgdat, bool proactive)
 	struct compact_control cc = {
 		.order = -1,
 		.mode = proactive ? MIGRATE_SYNC_LIGHT : MIGRATE_SYNC,
+		.alloc_flags = ALLOC_CMA,
 		.ignore_skip_hint = true,
 		.whole_zone = true,
 		.gfp_mask = GFP_KERNEL,
@@ -3039,7 +3040,7 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 
 		ret = compaction_suit_allocation_order(zone,
 				pgdat->kcompactd_max_order,
-				highest_zoneidx, ALLOC_WMARK_MIN);
+				highest_zoneidx, ALLOC_CMA | ALLOC_WMARK_MIN);
 		if (ret == COMPACT_CONTINUE)
 			return true;
 	}
@@ -3060,6 +3061,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		.search_order = pgdat->kcompactd_max_order,
 		.highest_zoneidx = pgdat->kcompactd_highest_zoneidx,
 		.mode = MIGRATE_SYNC_LIGHT,
+		.alloc_flags = ALLOC_CMA | ALLOC_WMARK_MIN,
 		.ignore_skip_hint = false,
 		.gfp_mask = GFP_KERNEL,
 	};
@@ -3080,7 +3082,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 			continue;
 
 		ret = compaction_suit_allocation_order(zone,
-				cc.order, zoneid, ALLOC_WMARK_MIN);
+				cc.order, zoneid, cc.alloc_flags);
 		if (ret != COMPACT_CONTINUE)
 			continue;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ecb2fd770387..1bfdca3f47b3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6456,6 +6456,7 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 		.order = -1,
 		.zone = page_zone(pfn_to_page(start)),
 		.mode = MIGRATE_SYNC,
+		.alloc_flags = ALLOC_CMA,
 		.ignore_skip_hint = true,
 		.no_set_skip_hint = true,
 		.alloc_contig = true,
-- 
2.39.3


