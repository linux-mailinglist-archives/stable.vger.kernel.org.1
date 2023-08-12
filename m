Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B7977A190
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 19:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjHLR5P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 13:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjHLR5O (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 13:57:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3D510F2
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 10:57:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28C6261018
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 17:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3996CC433C7;
        Sat, 12 Aug 2023 17:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691863036;
        bh=8ADq9qdYXTvn6b3xSLIwTNs6Xtw+hr5iwXY/8BQ2duw=;
        h=Subject:To:Cc:From:Date:From;
        b=LUsO7EdMnwYD87SFpvl1OGdyUCqVl6nGTzHnjfkxyamo3E2H9TIBC9PuBQQLP6Grz
         oRko0d6J8bqKU7rkFT9HEzMmzo6COrfrjQZM+J9sN9Njl0zygsz+z6ewR6TZSkZKJ7
         RzctljwHcUdKhyFqxZqYEaye6nRT5x1s6ikIR3zI=
Subject: FAILED: patch "[PATCH] nvme: core: don't hold rcu read lock in" failed to apply to 6.4-stable tree
To:     ming.lei@redhat.com, anuj20.g@samsung.com, axboe@kernel.dk,
        guazhang@redhat.com, joshi.k@samsung.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 19:57:14 +0200
Message-ID: <2023081213-glamorous-appliance-33dd@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x a7a7dabb5dd72d2875bc3ce56f94ea5ceb259d5b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081213-glamorous-appliance-33dd@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a7a7dabb5dd72d2875bc3ce56f94ea5ceb259d5b Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 9 Aug 2023 10:04:40 +0800
Subject: [PATCH] nvme: core: don't hold rcu read lock in
 nvme_ns_chr_uring_cmd_iopoll

Now nvme_ns_chr_uring_cmd_iopoll() has switched to request based io
polling, and the associated NS is guaranteed to be live in case of
io polling, so request is guaranteed to be valid because blk-mq uses
pre-allocated request pool.

Remove the rcu read lock in nvme_ns_chr_uring_cmd_iopoll(), which
isn't needed any more after switching to request based io polling.

Fix "BUG: sleeping function called from invalid context" because
set_page_dirty_lock() from blk_rq_unmap_user() may sleep.

Fixes: 585079b6e425 ("nvme: wire up async polling for io passthrough commands")
Reported-by: Guangwu Zhang <guazhang@redhat.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Guangwu Zhang <guazhang@redhat.com>
Link: https://lore.kernel.org/r/20230809020440.174682-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 5c3250f36ce7..d39f3219358b 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -786,11 +786,9 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 	if (!(ioucmd->flags & IORING_URING_CMD_POLLED))
 		return 0;
 
-	rcu_read_lock();
 	req = READ_ONCE(ioucmd->cookie);
 	if (req && blk_rq_is_poll(req))
 		ret = blk_rq_poll(req, iob, poll_flags);
-	rcu_read_unlock();
 	return ret;
 }
 #ifdef CONFIG_NVME_MULTIPATH

