Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5F6799821
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 14:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbjIIMxl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 08:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjIIMxl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 08:53:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382CECD6
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 05:53:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87388C433C7;
        Sat,  9 Sep 2023 12:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694264016;
        bh=92jq3++p8H9xq/BjYTkSdbuCfLv6eh20w3gmQu0KzQI=;
        h=Subject:To:Cc:From:Date:From;
        b=FwEwXL57805KUyxdQ1ERdVJUnahBiOcLkTqIy/K6Dl1/iIoqn+cJC2vNJ18GybI6W
         +8BQTz3yOc4DDybomEFSJD3J+DQ9NkqUeXOlgUF+t9HjWCuusD1twtZNGsYUuI+bbc
         BQplesVjysBJL3ziYHFaynXfvpuYrEWmfleoaOuw=
Subject: FAILED: patch "[PATCH] io_uring/net: don't overflow multishot accept" failed to apply to 6.1-stable tree
To:     asml.silence@gmail.com, axboe@kernel.dk
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 09 Sep 2023 13:53:26 +0100
Message-ID: <2023090926-basics-violet-94a6@gregkh>
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
git cherry-pick -x 1bfed23349716a7811645336a7ce42c4b8f250bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090926-basics-violet-94a6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

1bfed2334971 ("io_uring/net: don't overflow multishot accept")
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

From 1bfed23349716a7811645336a7ce42c4b8f250bc Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Fri, 11 Aug 2023 13:53:41 +0100
Subject: [PATCH] io_uring/net: don't overflow multishot accept

Don't allow overflowing multishot accept CQEs, we want to limit
the grows of the overflow list.

Cc: stable@vger.kernel.org
Fixes: 4e86a2c980137 ("io_uring: implement multishot mode for accept")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/7d0d749649244873772623dd7747966f516fe6e2.1691757663.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/net.c b/io_uring/net.c
index eb1f51ddcb23..1599493544a5 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1367,7 +1367,7 @@ int io_accept(struct io_kiocb *req, unsigned int issue_flags)
 	if (ret < 0)
 		return ret;
 	if (io_aux_cqe(req, issue_flags & IO_URING_F_COMPLETE_DEFER, ret,
-		       IORING_CQE_F_MORE, true))
+		       IORING_CQE_F_MORE, false))
 		goto retry;
 
 	return -ECANCELED;

