Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4131073B390
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjFWJ3N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjFWJ3L (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:29:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7088D9D
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:29:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D55E619E3
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 09:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEAAC433C0;
        Fri, 23 Jun 2023 09:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687512549;
        bh=dhArZYu+rFwgHFm3o+sJW66mgzBny9VFDuZUjCo4PXo=;
        h=Subject:To:Cc:From:Date:From;
        b=WubIuPow5bmx5a6BJoSAzCYeojwukQc2hHhajzGCggMwTuBAffEEsUYogYmvWhmEu
         pDEsHClgX+mkaQwzkWbimY7DChxxSqqglP5/9pmg80bDI5SaHlRUuZLmKe/PO57Ba3
         k75C+l2FJiOiB5vnztqy2DQsDu3zT0LqMQbVh+4s=
Subject: FAILED: patch "[PATCH] io_uring/poll: serialize poll linked timer start with poll" failed to apply to 6.3-stable tree
To:     axboe@kernel.dk, querijnqyn@gmail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 23 Jun 2023 11:29:06 +0200
Message-ID: <2023062306-omen-dance-80f0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x ef7dfac51d8ed961b742218f526bd589f3900a59
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062306-omen-dance-80f0@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ef7dfac51d8ed961b742218f526bd589f3900a59 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Sat, 17 Jun 2023 19:50:24 -0600
Subject: [PATCH] io_uring/poll: serialize poll linked timer start with poll
 removal

We selectively grab the ctx->uring_lock for poll update/removal, but
we really should grab it from the start to fully synchronize with
linked timeouts. Normally this is indeed the case, but if requests
are forced async by the application, we don't fully cover removal
and timer disarm within the uring_lock.

Make this simpler by having consistent locking state for poll removal.

Cc: stable@vger.kernel.org # 6.1+
Reported-by: Querijn Voet <querijnqyn@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/poll.c b/io_uring/poll.c
index c90e47dc1e29..a78b8af7d9ab 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -977,8 +977,9 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_hash_bucket *bucket;
 	struct io_kiocb *preq;
 	int ret2, ret = 0;
-	struct io_tw_state ts = {};
+	struct io_tw_state ts = { .locked = true };
 
+	io_ring_submit_lock(ctx, issue_flags);
 	preq = io_poll_find(ctx, true, &cd, &ctx->cancel_table, &bucket);
 	ret2 = io_poll_disarm(preq);
 	if (bucket)
@@ -990,12 +991,10 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 		goto out;
 	}
 
-	io_ring_submit_lock(ctx, issue_flags);
 	preq = io_poll_find(ctx, true, &cd, &ctx->cancel_table_locked, &bucket);
 	ret2 = io_poll_disarm(preq);
 	if (bucket)
 		spin_unlock(&bucket->lock);
-	io_ring_submit_unlock(ctx, issue_flags);
 	if (ret2) {
 		ret = ret2;
 		goto out;
@@ -1019,7 +1018,7 @@ found:
 		if (poll_update->update_user_data)
 			preq->cqe.user_data = poll_update->new_user_data;
 
-		ret2 = io_poll_add(preq, issue_flags);
+		ret2 = io_poll_add(preq, issue_flags & ~IO_URING_F_UNLOCKED);
 		/* successfully updated, don't complete poll request */
 		if (!ret2 || ret2 == -EIOCBQUEUED)
 			goto out;
@@ -1027,9 +1026,9 @@ found:
 
 	req_set_fail(preq);
 	io_req_set_res(preq, -ECANCELED, 0);
-	ts.locked = !(issue_flags & IO_URING_F_UNLOCKED);
 	io_req_task_complete(preq, &ts);
 out:
+	io_ring_submit_unlock(ctx, issue_flags);
 	if (ret < 0) {
 		req_set_fail(req);
 		return ret;

