Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406E37AA048
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 22:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjIUUfy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 16:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjIUUfk (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 16:35:40 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76678CFF32
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 11:20:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b5a586da6so23803557b3.1
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 11:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695320434; x=1695925234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hw98Zupb8UHh+CqlMSyJaPhi0/ITpRz5yyNHO/GwHao=;
        b=OXQoiftLHS+vkpFjzdG4wZSNGwcqJ3uPKs1hCgcLuhDOUa4fAa3bxLzV4wOcS0nGfv
         jlj4CgYH2GaRKu5Cq3oAYiPW+xjn96HA+p76PI9twOmKaJ+L7bgv53lV0Mn2nOol+kqR
         X3RmpKfHu0vlGMA+l+CDDPoXyLx8VAZrNL6FR48BTXykeqvmQNui27vq02b6x+TGSX/C
         gIo6cVMxXeBCl3dKBFCkLgZWryF0nHyzwDvlR9XZArQ6MZ6vzCkHtqPVSlUJSnPsp0xC
         l3q7GCXxUPoxoaXo2qfeu/Stf6uHSEPELPvNgIAkcPvtaQuIXlN1nrI3L7UUrhVssir0
         ZV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320434; x=1695925234;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hw98Zupb8UHh+CqlMSyJaPhi0/ITpRz5yyNHO/GwHao=;
        b=v6bOfME0LwjK5BsK+w3vDMF2UkKUKDhwXaWL9Ua5P4RjW7lH0Lvgb8d5FYswecvF9w
         +kmDOgzGv1ep7lzU5rt9HUS34CcPIC68cpavLA/FzcUDCMPn/Tm/zGZq58VjgFHy4p9L
         Qop9b0I5cIac2mhssqN04a9Yf/BToy5fKIwBiaY/DAIEpTky5pXzMF/Wi2cKWnxUhK7h
         YFFDHhj7JueA+020kjIrhjO1QK8SyQoOBb9RemHHzoXNxSK3t0VGjbCDRJ2ggwZVcqEF
         fd/jwBMU87o/3Wlv5Xnt4WzfKVwTe4duYMz5wQ2v7FnyPDU7h7HzrNsYj4QNT4kUmqiO
         8FoQ==
X-Gm-Message-State: AOJu0YxMfw2Fz0bktGTIZGMYc5YAuTvj7R45m7k+jDNQ5hVWwjwcaZA9
        hBe5NBqzCKxUpdvI3iIjTXyPFnfGMo/ERQl4JaQ=
X-Google-Smtp-Source: AGHT+IGJgoOxhF4DLozb4xqhSavBmQjQaAZ2tyi0n+ac2tz4zDa9tN5xGVxVwr2RHxAucdD+d6PFSGiWcoQHHGhxMjY=
X-Received: from saranyamohan.svl.corp.google.com ([2620:15c:2a3:200:5dbd:3ff1:e146:3806])
 (user=saranyamohan job=sendgmr) by 2002:a05:690c:831:b0:589:a533:405b with
 SMTP id by17-20020a05690c083100b00589a533405bmr6592ywb.3.1695320434564; Thu,
 21 Sep 2023 11:20:34 -0700 (PDT)
Date:   Thu, 21 Sep 2023 11:20:12 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921182012.3965572-1-saranyamohan@google.com>
Subject: [PATCH] block: fix use-after-free of q->q_usage_counter
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Wensheng <zhangwensheng@huaweicloud.com>,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Hillf Danton <hdanton@sina.com>, Yu Kuai <yukuai3@huawei.com>,
        Dennis Zhou <dennis@kernel.org>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

commit d36a9ea5e7766961e753ee38d4c331bbe6ef659b upstream.

For blk-mq, queue release handler is usually called after
blk_mq_freeze_queue_wait() returns. However, the
q_usage_counter->release() handler may not be run yet at that time, so
this can cause a use-after-free.

Fix the issue by moving percpu_ref_exit() into blk_free_queue_rcu().
Since ->release() is called with rcu read lock held, it is agreed that
the race should be covered in caller per discussion from the two links.

Backport-notes: Not a clean cherry-pick since a lot has changed,
however essentially the same fix.

Reported-by: Zhang Wensheng <zhangwensheng@huaweicloud.com>
Reported-by: Zhong Jinghua <zhongjinghua@huawei.com>
Link: https://lore.kernel.org/linux-block/Y5prfOjyyjQKUrtH@T590/T/#u
Link: https://lore.kernel.org/lkml/Y4%2FmzMd4evRg9yDi@fedora/
Cc: Hillf Danton <hdanton@sina.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Dennis Zhou <dennis@kernel.org>
Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20221215021629.74870-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 block/blk-core.c  | 2 --
 block/blk-sysfs.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0d0dd8151f7..e5eeec801f56 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -414,8 +414,6 @@ void blk_cleanup_queue(struct request_queue *q)
 		blk_mq_sched_free_requests(q);
 	mutex_unlock(&q->sysfs_lock);
 
-	percpu_ref_exit(&q->q_usage_counter);
-
 	/* @q is and will stay empty, shutdown and put */
 	blk_put_queue(q);
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 8c5816364dd1..9174137a913c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -726,6 +726,8 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
 {
 	struct request_queue *q = container_of(rcu_head, struct request_queue,
 					       rcu_head);
+
+	percpu_ref_exit(&q->q_usage_counter);
 	kmem_cache_free(blk_requestq_cachep, q);
 }
 
-- 
2.42.0.515.g380fc7ccd1-goog

