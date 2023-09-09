Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E319679981E
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 14:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbjIIMxV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 08:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjIIMxU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 08:53:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE59CD6
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 05:53:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E51CC433C9;
        Sat,  9 Sep 2023 12:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694263996;
        bh=KSnf6w7zD4UuVwm4b/zBPvBwLlK6y3JjR11xJUBLq/o=;
        h=Subject:To:Cc:From:Date:From;
        b=UppRpMrGahpUaM/qXfgTHE4FnL1e/egmpekUtImLF/+T7h3ZKJQiMgX+QRm/qw84T
         DVCpqF4MfrYBkDls/Wl4AZrd6S8KmeQZ1r80v6KDwuXrDrZAPNL/iju/ay0UllwEs6
         fjUwf2hxEBcoGZauUPJBgfE60rFfWR/PUC8LPRlc=
Subject: FAILED: patch "[PATCH] io_uring/net: don't overflow multishot recv" failed to apply to 6.1-stable tree
To:     asml.silence@gmail.com, axboe@kernel.dk
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 09 Sep 2023 13:53:09 +0100
Message-ID: <2023090909-retool-handled-9615@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
git cherry-pick -x b2e74db55dd93d6db22a813c9a775b5dbf87c560
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090909-retool-handled-9615@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

b2e74db55dd9 ("io_uring/net: don't overflow multishot recv")
d86eaed185e9 ("io_uring: cleanup io_aux_cqe() API")
ea97f6c8558e ("io_uring: add support for multishot timeouts")
a282967c848f ("io_uring: encapsulate task_work state")
13bfa6f15d0b ("io_uring: remove extra tw trylocks")
9d2789ac9d60 ("block/io_uring: pass in issue_flags for uring_cmd task_work handling")
6bb30855560e ("io_uring: if a linked request has REQ_F_FORCE_ASYNC then run it async")
f58680085478 ("io_uring: add reschedule point to handle_tw_list()")
50470fc5723a ("io_uring: return normal tw run linking optimisation")
31f084b7b028 ("io_uring: simplify fallback execution")
b0b7a7d24b66 ("io_uring: return back links tw run optimisation")
c3f4d39ee4bc ("io_uring: optimise deferred tw execution")
360173ab9e1a ("io_uring: move io_run_local_work_locked")
3e5655552a82 ("io_uring: mark io_run_local_work static")
2f413956cc8a ("io_uring: don't set TASK_RUNNING in local tw runner")
140102ae9a9f ("io_uring: move defer tw task checks")
1414d6298584 ("io_uring: kill io_run_task_work_ctx")
f36ba6cf1ab6 ("io_uring: don't iterate cq wait fast path")
0c4fe008c9cb ("io_uring: rearrange defer list checks")
6e5aedb9324a ("io_uring/poll: attempt request issue after racy poll wakeup")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b2e74db55dd93d6db22a813c9a775b5dbf87c560 Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Fri, 11 Aug 2023 13:53:42 +0100
Subject: [PATCH] io_uring/net: don't overflow multishot recv

Don't allow overflowing multishot recv CQEs, it might get out of
hand, hurt performance, and in the worst case scenario OOM the task.

Cc: stable@vger.kernel.org
Fixes: b3fdea6ecb55c ("io_uring: multishot recv")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/0b295634e8f1b71aa764c984608c22d85f88f75c.1691757663.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/net.c b/io_uring/net.c
index 1599493544a5..8c419c01a5db 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -642,7 +642,7 @@ static inline bool io_recv_finish(struct io_kiocb *req, int *ret,
 
 	if (!mshot_finished) {
 		if (io_aux_cqe(req, issue_flags & IO_URING_F_COMPLETE_DEFER,
-			       *ret, cflags | IORING_CQE_F_MORE, true)) {
+			       *ret, cflags | IORING_CQE_F_MORE, false)) {
 			io_recv_prep_retry(req);
 			/* Known not-empty or unknown state, retry */
 			if (cflags & IORING_CQE_F_SOCK_NONEMPTY ||

