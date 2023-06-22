Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C90739A8A
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 10:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjFVIrA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 04:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjFVIqm (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 04:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C8530E4
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 01:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687423425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hsp1wQu2X2nYe9KSjQosq+KIdmLssGP1CLoUN2sv5ss=;
        b=fh0yexIB6wHEtHbxLCmgQpyzM6tPuvM9OswM+NGEHmMGKJ+TgC+Ao49n+t7c7UO0fhpAV/
        GCtNzd/ruFO7jJWNXqQy2KkFvkpvtzjzfVtmgNv8keWYu1l2qJHMK7q9ukUaD82o7PxlpI
        5AOo9a5NjFAPX3mLgWIZD/NZWgNpNho=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-HtCwnymZMPqV7jJbet8iFA-1; Thu, 22 Jun 2023 04:43:41 -0400
X-MC-Unique: HtCwnymZMPqV7jJbet8iFA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20AC83C108D2;
        Thu, 22 Jun 2023 08:43:41 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C20C425359;
        Thu, 22 Jun 2023 08:43:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        stable@vger.kernel.org, Jay Shin <jaeshin@redhat.com>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH] block: make sure local irq is disabled when calling __blkcg_rstat_flush
Date:   Thu, 22 Jun 2023 16:42:49 +0800
Message-Id: <20230622084249.1208005-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

When __blkcg_rstat_flush() is called from cgroup_rstat_flush*() code
path, interrupt is always disabled.

When we start to flush blkcg per-cpu stats list in __blkg_release()
for avoiding to leak blkcg_gq's reference in commit 20cb1c2fb756
("blk-cgroup: Flush stats before releasing blkcg_gq"), local irq
isn't disabled yet, then lockdep warning may be triggered because
the dependent cgroup locks may be acquired from irq(soft irq) handler.

Fix the issue by disabling local irq always.

Fixes: 20cb1c2fb756 ("blk-cgroup: Flush stats before releasing blkcg_gq")
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/linux-block/pz2wzwnmn5tk3pwpskmjhli6g3qly7eoknilb26of376c7kwxy@qydzpvt6zpis/T/#u
Cc: stable@vger.kernel.org
Cc: Jay Shin <jaeshin@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-cgroup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index f0b5c9c41cde..dce1548a7a0c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -970,6 +970,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 	struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
 	struct llist_node *lnode;
 	struct blkg_iostat_set *bisc, *next_bisc;
+	unsigned long flags;
 
 	rcu_read_lock();
 
@@ -983,7 +984,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 	 * When flushing from cgroup, cgroup_rstat_lock is always held, so
 	 * this lock won't cause contention most of time.
 	 */
-	raw_spin_lock(&blkg_stat_lock);
+	raw_spin_lock_irqsave(&blkg_stat_lock, flags);
 
 	/*
 	 * Iterate only the iostat_cpu's queued in the lockless list.
@@ -1009,7 +1010,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 			blkcg_iostat_update(parent, &blkg->iostat.cur,
 					    &blkg->iostat.last);
 	}
-	raw_spin_unlock(&blkg_stat_lock);
+	raw_spin_unlock_irqrestore(&blkg_stat_lock, flags);
 out:
 	rcu_read_unlock();
 }
-- 
2.40.1

