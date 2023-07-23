Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817A775E1F5
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 14:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjGWMy6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 08:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGWMy6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 08:54:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6A2138
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 05:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B82B260CF5
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 12:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4C6C433C7;
        Sun, 23 Jul 2023 12:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690116895;
        bh=4FQIyOF/UnjbSVnx+OWbYd2pYM9/XtV0ZkhT6XrkdBs=;
        h=Subject:To:Cc:From:Date:From;
        b=p3vw1ZK7HETaOZfc9dU5AWeXitoTe+RgRdLUaf+Y9h3vpqE2RcASS/Ju7oE28L3LH
         2iajewMiLmO8su0PRdqwcGCZrEFTDfBmb3Ko+u8x1HAvskzLl+ElKB1mIabfkJdlPK
         IlhQYq+/1rhAGki5oVtRrd1Et42kJuIdvOGZj+iI=
Subject: FAILED: patch "[PATCH] io_uring: treat -EAGAIN for REQ_F_NOWAIT as final for io-wq" failed to apply to 5.15-stable tree
To:     axboe@kernel.dk
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 14:54:52 +0200
Message-ID: <2023072352-cage-carnage-b38a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a9be202269580ca611c6cebac90eaf1795497800
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072352-cage-carnage-b38a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

a9be20226958 ("io_uring: treat -EAGAIN for REQ_F_NOWAIT as final for io-wq")
ed29b0b4fd83 ("io_uring: move to separate directory")
d01905db14eb ("io_uring: clean iowq submit work cancellation")
255657d23704 ("io_uring: clean io_wq_submit_work()'s main loop")
90fa02883f06 ("io_uring: implement async hybrid mode for pollable requests")
3b44b3712c5b ("io_uring: split logic of force_nonblock")
9882131cd9de ("io_uring: kill io_wq_current_is_worker() in iopoll")
9983028e7660 ("io_uring: optimise req->ctx reloads")
5e49c973fc39 ("io_uring: clean up io_import_iovec")
51aac424aef9 ("io_uring: optimise io_import_iovec nonblock passing")
c88598a92a58 ("io_uring: optimise read/write iov state storing")
538941e2681c ("io_uring: encapsulate rw state")
d886e185a128 ("io_uring: control ->async_data with a REQ_F flag")
30d51dd4ad20 ("io_uring: clean up buffer select")
ef05d9ebcc92 ("io_uring: kill off ->inflight_entry field")
6f33b0bc4ea4 ("io_uring: use slist for completion batching")
c450178d9be9 ("io_uring: dedup CQE flushing non-empty checks")
4c928904ff77 ("block: move CONFIG_BLOCK guard to top Makefile")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a9be202269580ca611c6cebac90eaf1795497800 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 20 Jul 2023 13:16:53 -0600
Subject: [PATCH] io_uring: treat -EAGAIN for REQ_F_NOWAIT as final for io-wq

io-wq assumes that an issue is blocking, but it may not be if the
request type has asked for a non-blocking attempt. If we get
-EAGAIN for that case, then we need to treat it as a final result
and not retry or arm poll for it.

Cc: stable@vger.kernel.org # 5.10+
Link: https://github.com/axboe/liburing/issues/897
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index a9923676d16d..5e97235a82d6 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1948,6 +1948,14 @@ void io_wq_submit_work(struct io_wq_work *work)
 		ret = io_issue_sqe(req, issue_flags);
 		if (ret != -EAGAIN)
 			break;
+
+		/*
+		 * If REQ_F_NOWAIT is set, then don't wait or retry with
+		 * poll. -EAGAIN is final for that case.
+		 */
+		if (req->flags & REQ_F_NOWAIT)
+			break;
+
 		/*
 		 * We can get EAGAIN for iopolled IO even though we're
 		 * forcing a sync submission from here, since we can't

