Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE5C79981A
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 14:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbjIIMw4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 08:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjIIMw4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 08:52:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FF1CDE
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 05:52:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DDCC433C8;
        Sat,  9 Sep 2023 12:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694263972;
        bh=B/ddGnZzyzynxijuiAgHNYcKXAbrZ/vDK6cFya4Fyyc=;
        h=Subject:To:Cc:From:Date:From;
        b=oRdIcAWQfGUHD0wZ9/UjFA/8iX9pqSCLh8kn+91dtH+KohAskLNTMXSKcCWBthCxM
         G8mBi/v623S6npRhSBbsC+PIFzGsKgKLzVlWU/SM4ST313RyxuJka0pCT00EGWZ03r
         BKqUX1CJhpI33AtBJuqaPPpwBDIenXC9R12mz6/E=
Subject: FAILED: patch "[PATCH] io_uring: break iopolling on signal" failed to apply to 5.4-stable tree
To:     asml.silence@gmail.com, axboe@kernel.dk
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 09 Sep 2023 13:52:39 +0100
Message-ID: <2023090939-bunkmate-clutch-4fc1@gregkh>
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x dc314886cb3d0e4ab2858003e8de2917f8a3ccbd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090939-bunkmate-clutch-4fc1@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

dc314886cb3d ("io_uring: break iopolling on signal")
ed29b0b4fd83 ("io_uring: move to separate directory")
5ba3c874eb8a ("io_uring: make io_do_iopoll return number of reqs")
87a115fb715b ("io_uring: force_nonspin")
b688f11e86c9 ("io_uring: utilize the io batching infrastructure for more efficient polled IO")
5a72e899ceb4 ("block: add a struct io_comp_batch argument to fops->iopoll()")
013a7f954381 ("block: provide helpers for rq_list manipulation")
afd7de03c526 ("block: remove some blk_mq_hw_ctx debugfs entries")
3e08773c3841 ("block: switch polling to be bio based")
6ce913fe3eee ("block: rename REQ_HIPRI to REQ_POLLED")
d729cf9acb93 ("io_uring: don't sleep when polling for I/O")
ef99b2d37666 ("block: replace the spin argument to blk_iopoll with a flags argument")
28a1ae6b9dab ("blk-mq: remove blk_qc_t_valid")
efbabbe121f9 ("blk-mq: remove blk_qc_t_to_tag and blk_qc_t_is_internal")
c6699d6fe0ff ("blk-mq: factor out a "classic" poll helper")
f70299f0d58e ("blk-mq: factor out a blk_qc_to_hctx helper")
71fc3f5e2c00 ("block: don't try to poll multi-bio I/Os in __blkdev_direct_IO")
4c928904ff77 ("block: move CONFIG_BLOCK guard to top Makefile")
349302da8352 ("block: improve batched tag allocation")
0f38d7664615 ("blk-mq: cleanup blk_mq_submit_bio")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc314886cb3d0e4ab2858003e8de2917f8a3ccbd Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Wed, 9 Aug 2023 16:20:21 +0100
Subject: [PATCH] io_uring: break iopolling on signal

Don't keep spinning iopoll with a signal set. It'll eventually return
back, e.g. by virtue of need_resched(), but it's not a nice user
experience.

Cc: stable@vger.kernel.org
Fixes: def596e9557c9 ("io_uring: support for IO polling")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/eeba551e82cad12af30c3220125eb6cb244cc94c.1691594339.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index d0888907527d..ad4ffd3a876f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1673,6 +1673,9 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, long min)
 			break;
 		nr_events += ret;
 		ret = 0;
+
+		if (task_sigpending(current))
+			return -EINTR;
 	} while (nr_events < min && !need_resched());
 
 	return ret;

