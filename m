Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6110755485
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjGPUbS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjGPUbS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:31:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3E8126
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:31:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C0A760EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2DAC433C9;
        Sun, 16 Jul 2023 20:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539476;
        bh=8uLWVgUzKUcTbGBBUWSFtguRGiA/2oFlGn4riYrsJpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPTRZSbW5ZKCf1X6P9FnmbYkERHQ8luztcnOfo+xe8uP3st2YnDVCY/bajpsak8zV
         RRrxqgLPqajnEelHpYH/fBHxxN4tKprZ+Wqdy2Q3lPrFGWsy0jOPr1CoDuz3IhyiDw
         iQCjl06TVc3gyiLqJVVDa+kUw1JzPr5ABGJa8ENk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 013/591] blk-mq: fix potential io hang by wrong wake_batch
Date:   Sun, 16 Jul 2023 21:42:32 +0200
Message-ID: <20230716194924.206867704@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 4f1731df60f9033669f024d06ae26a6301260b55 ]

In __blk_mq_tag_busy/idle(), updating 'active_queues' and calculating
'wake_batch' is not atomic:

t1:			t2:
_blk_mq_tag_busy	blk_mq_tag_busy
inc active_queues
// assume 1->2
			inc active_queues
			// 2 -> 3
			blk_mq_update_wake_batch
			// calculate based on 3
blk_mq_update_wake_batch
/* calculate based on 2, while active_queues is actually 3. */

Fix this problem by protecting them wih 'tags->lock', this is not a hot
path, so performance should not be concerned. And now that all writers
are inside the lock, switch 'actives_queues' from atomic to unsigned
int.

Fixes: 180dccb0dba4 ("blk-mq: fix tag_get wait task can't be awakened")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230610023043.2559121-1-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq-debugfs.c |  2 +-
 block/blk-mq-tag.c     | 15 ++++++++++-----
 block/blk-mq.h         |  3 +--
 include/linux/blk-mq.h |  3 +--
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index bd942341b6382..7675e663df365 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -427,7 +427,7 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
 	seq_printf(m, "nr_tags=%u\n", tags->nr_tags);
 	seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
 	seq_printf(m, "active_queues=%d\n",
-		   atomic_read(&tags->active_queues));
+		   READ_ONCE(tags->active_queues));
 
 	seq_puts(m, "\nbitmap_tags:\n");
 	sbitmap_queue_show(&tags->bitmap_tags, m);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a80d7c62bdfe6..100889c276c3f 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -40,6 +40,7 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
 void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	unsigned int users;
+	struct blk_mq_tags *tags = hctx->tags;
 
 	/*
 	 * calling test_bit() prior to test_and_set_bit() is intentional,
@@ -57,9 +58,11 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 			return;
 	}
 
-	users = atomic_inc_return(&hctx->tags->active_queues);
-
-	blk_mq_update_wake_batch(hctx->tags, users);
+	spin_lock_irq(&tags->lock);
+	users = tags->active_queues + 1;
+	WRITE_ONCE(tags->active_queues, users);
+	blk_mq_update_wake_batch(tags, users);
+	spin_unlock_irq(&tags->lock);
 }
 
 /*
@@ -92,9 +95,11 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 			return;
 	}
 
-	users = atomic_dec_return(&tags->active_queues);
-
+	spin_lock_irq(&tags->lock);
+	users = tags->active_queues - 1;
+	WRITE_ONCE(tags->active_queues, users);
 	blk_mq_update_wake_batch(tags, users);
+	spin_unlock_irq(&tags->lock);
 
 	blk_mq_tag_wakeup_all(tags, false);
 }
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 0b2870839cdd6..c6eca452ea2a2 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -362,8 +362,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 			return true;
 	}
 
-	users = atomic_read(&hctx->tags->active_queues);
-
+	users = READ_ONCE(hctx->tags->active_queues);
 	if (!users)
 		return true;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a9764cbf7f8d2..e4f676e1042b5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -745,8 +745,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 struct blk_mq_tags {
 	unsigned int nr_tags;
 	unsigned int nr_reserved_tags;
-
-	atomic_t active_queues;
+	unsigned int active_queues;
 
 	struct sbitmap_queue bitmap_tags;
 	struct sbitmap_queue breserved_tags;
-- 
2.39.2



