Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF16A781F15
	for <lists+stable@lfdr.de>; Sun, 20 Aug 2023 19:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHTR4k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 20 Aug 2023 13:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjHTR4c (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 20 Aug 2023 13:56:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625702D52
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 10:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE8B8612EA
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 17:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7A8C433C8;
        Sun, 20 Aug 2023 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692554062;
        bh=bAq165hLNrLjmbOL546fFrpO4OVC0PyfNbtGDRoHFQU=;
        h=Subject:To:Cc:From:Date:From;
        b=uqHIG6bCW7xQJJpUJEK66RhAs94m4JEAaah36ZTD+rKQ1EpCqK7mIAuEkEkL+dGiA
         HeFCkpHJhWIw0RH4Cd5rcNteQoaaJmZ95FkRNzOQ92euqM5T6Z6iIdBWe8Z9xk4pp2
         OVL+SJmb2BBU44ShxrFEvFjWJhDPl0QY5NdWkFaE=
Subject: FAILED: patch "[PATCH] blk-cgroup: hold queue_lock when removing blkg->q_node" failed to apply to 6.1-stable tree
To:     ming.lei@redhat.com, axboe@kernel.dk, chuhu@redhat.com,
        snitzer@kernel.org, tj@kernel.org, xifeng@redhat.com,
        yukuai3@huawei.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 20 Aug 2023 19:54:19 +0200
Message-ID: <2023082019-brink-buddhist-4d1b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c164c7bc9775be7bcc68754bb3431fce5823822e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082019-brink-buddhist-4d1b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

c164c7bc9775 ("blk-cgroup: hold queue_lock when removing blkg->q_node")
a06377c5d01e ("Revert "blk-cgroup: pin the gendisk in struct blkcg_gq"")
9a9c261e6b55 ("Revert "blk-cgroup: pass a gendisk to blkg_lookup"")
1231039db31c ("Revert "blk-cgroup: move the cgroup information to struct gendisk"")
dcb522014351 ("Revert "blk-cgroup: simplify blkg freeing from initialization failure paths"")
3f13ab7c80fd ("blk-cgroup: move the cgroup information to struct gendisk")
479664cee14d ("blk-cgroup: pass a gendisk to blkg_lookup")
ba91c849fa50 ("blk-rq-qos: store a gendisk instead of request_queue in struct rq_qos")
3963d84df797 ("blk-rq-qos: constify rq_qos_ops")
ce57b558604e ("blk-rq-qos: make rq_qos_add and rq_qos_del more useful")
b494f9c566ba ("blk-rq-qos: move rq_qos_add and rq_qos_del out of line")
f05837ed73d0 ("blk-cgroup: store a gendisk to throttle in struct task_struct")
84d7d462b16d ("blk-cgroup: pin the gendisk in struct blkcg_gq")
180b04d450a7 ("blk-cgroup: remove the !bdi->dev check in blkg_dev_name")
27b642b07a4a ("blk-cgroup: simplify blkg freeing from initialization failure paths")
0b6f93bdf07e ("blk-cgroup: improve error unwinding in blkg_alloc")
f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
dfd6200a0954 ("blk-cgroup: support to track if policy is online")
c7241babf085 ("blk-cgroup: dropping parent refcount after pd_free_fn() is done")
e3ff8887e7db ("blk-cgroup: fix missing pd_online_fn() while activating policy")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c164c7bc9775be7bcc68754bb3431fce5823822e Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 17 Aug 2023 22:17:51 +0800
Subject: [PATCH] blk-cgroup: hold queue_lock when removing blkg->q_node

When blkg is removed from q->blkg_list from blkg_free_workfn(), queue_lock
has to be held, otherwise, all kinds of bugs(list corruption, hard lockup,
..) can be triggered from blkg_destroy_all().

Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: xiaoli feng <xifeng@redhat.com>
Cc: Chunyu Hu <chuhu@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230817141751.1128970-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index fc49be622e05..9faafcd10e17 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -136,7 +136,9 @@ static void blkg_free_workfn(struct work_struct *work)
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
 	if (blkg->parent)
 		blkg_put(blkg->parent);
+	spin_lock_irq(&q->queue_lock);
 	list_del_init(&blkg->q_node);
+	spin_unlock_irq(&q->queue_lock);
 	mutex_unlock(&q->blkcg_mutex);
 
 	blk_put_queue(q);

