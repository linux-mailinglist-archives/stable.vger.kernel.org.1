Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113527556B7
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjGPUxV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjGPUxU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:53:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE91AE9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:53:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85D0160EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FBBC433C7;
        Sun, 16 Jul 2023 20:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540799;
        bh=oyTpk6QWYS8R1ZC3mGdP27MFibbw1ulX2WFlmU42itc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkTacNys3g4yn8InoFE2q3QPOu/MLyk6LziiEQiJOSGBSpp9zeR2OiJVYyEYIPS45
         2zoxbzFzS4Yf6bUXRyrg0gbuxnCU6r7/CjcvEXZvKHEzjPybVuTkZEC6vAyZZ0jvsX
         P/lunuBjQbzM6FvGUbPAim1LFjdc2DZoPvugb3uo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrea Righi <andrea.righi@canonical.com>,
        Jinke Han <hanjinke.666@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 464/591] blk-throttle: Fix io statistics for cgroup v1
Date:   Sun, 16 Jul 2023 21:50:03 +0200
Message-ID: <20230716194935.907582674@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jinke Han <hanjinke.666@bytedance.com>

[ Upstream commit ad7c3b41e86b59943a903d23c7b037d820e6270c ]

After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
the only stable io stats interface of cgroup v1, and these statistics
are done in the blk-throttle code. But the current code only counts the
bios that are actually throttled. When the user does not add the throttle
limit, the io stats for cgroup v1 has nothing. I fix it according to the
statistical method of v2, and made it count all ios accurately.

Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
Tested-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
Acked-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230507170631.89607-1-hanjinke.666@bytedance.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c   | 6 ++++--
 block/blk-throttle.c | 6 ------
 block/blk-throttle.h | 9 +++++++++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 5ee0ae8ddbf6f..e812e48d5bb8a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2008,6 +2008,9 @@ void blk_cgroup_bio_start(struct bio *bio)
 	struct blkg_iostat_set *bis;
 	unsigned long flags;
 
+	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
+		return;
+
 	/* Root-level stats are sourced from system-wide IO stats */
 	if (!cgroup_parent(blkcg->css.cgroup))
 		return;
@@ -2039,8 +2042,7 @@ void blk_cgroup_bio_start(struct bio *bio)
 	}
 
 	u64_stats_update_end_irqrestore(&bis->sync, flags);
-	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
-		cgroup_rstat_updated(blkcg->css.cgroup, cpu);
+	cgroup_rstat_updated(blkcg->css.cgroup, cpu);
 	put_cpu();
 }
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f1bc600c4ded6..d88147d1358fc 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2167,12 +2167,6 @@ bool __blk_throtl_bio(struct bio *bio)
 
 	rcu_read_lock();
 
-	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
-		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
-				bio->bi_iter.bi_size);
-		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
-	}
-
 	spin_lock_irq(&q->queue_lock);
 
 	throtl_update_latency_buckets(td);
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index ef4b7a4de987d..d1ccbfe9f7978 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -185,6 +185,15 @@ static inline bool blk_should_throtl(struct bio *bio)
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
 	int rw = bio_data_dir(bio);
 
+	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
+		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
+			bio_set_flag(bio, BIO_CGROUP_ACCT);
+			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
+					bio->bi_iter.bi_size);
+		}
+		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
+	}
+
 	/* iops limit is always counted */
 	if (tg->has_rules_iops[rw])
 		return true;
-- 
2.39.2



