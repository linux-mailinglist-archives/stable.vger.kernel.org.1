Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F00173B391
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjFWJ3W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjFWJ3U (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:29:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9EE9D
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12E38619E0
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 09:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEF2C433C8;
        Fri, 23 Jun 2023 09:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687512558;
        bh=Zi/QhBbLXxnNbZhqkOcUampAmEACSt8oeJV30K0tTmQ=;
        h=Subject:To:Cc:From:Date:From;
        b=gEES8esHyYZE48SH1cDV/bZ0n86VS1iuderf/9BEH+8IZyZ3O7c63tQm9ttLoCAPp
         iOA5CQLCn+iBPAdygk95NH6AQtunz+1Qu+JsCiFEyNxcCevYqeejAi8vGIIVqv2U4+
         gVs6WexYdETsS9qUiqWc7noov36ITudRUkA9LIlI=
Subject: FAILED: patch "[PATCH] io_uring/poll: serialize poll linked timer start with poll" failed to apply to 6.1-stable tree
To:     axboe@kernel.dk, querijnqyn@gmail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 23 Jun 2023 11:29:07 +0200
Message-ID: <2023062307-taco-nurture-70a2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x ef7dfac51d8ed961b742218f526bd589f3900a59
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062307-taco-nurture-70a2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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

