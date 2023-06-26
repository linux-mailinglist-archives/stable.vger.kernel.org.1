Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D75073E8EA
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjFZSap (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjFZSaI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6161708
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67D0F60F39
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8D2C433C8;
        Mon, 26 Jun 2023 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804206;
        bh=XkCv8m+SwglEKpH2hgINfBZTfuigdB5mMl/5EvINsKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SsVu8bTXSQbKP3ecYJVt1pGD833vJw3z4adETwpzdOW6tzQa6q9ghq8ScYJ+h0idy
         gYWm+oe0tnHx5hXpouxYsyNkEipqgchRSyuEse6oLps6JTzX+tgZx+kOVX3kIHLXWm
         sagj09emDjHXR188zHl0xumtxQRDX1hOxPuwwzdI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Querijn Voet <querijnqyn@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 076/170] io_uring/poll: serialize poll linked timer start with poll removal
Date:   Mon, 26 Jun 2023 20:10:45 +0200
Message-ID: <20230626180804.026649747@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

Commit ef7dfac51d8ed961b742218f526bd589f3900a59 upstream.

We selectively grab the ctx->uring_lock for poll update/removal, but
we really should grab it from the start to fully synchronize with
linked timeouts. Normally this is indeed the case, but if requests
are forced async by the application, we don't fully cover removal
and timer disarm within the uring_lock.

Make this simpler by having consistent locking state for poll removal.

Cc: stable@vger.kernel.org # 6.1+
Reported-by: Querijn Voet <querijnqyn@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/poll.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -993,8 +993,9 @@ int io_poll_remove(struct io_kiocb *req,
 	struct io_hash_bucket *bucket;
 	struct io_kiocb *preq;
 	int ret2, ret = 0;
-	bool locked;
+	bool locked = true;
 
+	io_ring_submit_lock(ctx, issue_flags);
 	preq = io_poll_find(ctx, true, &cd, &ctx->cancel_table, &bucket);
 	ret2 = io_poll_disarm(preq);
 	if (bucket)
@@ -1006,12 +1007,10 @@ int io_poll_remove(struct io_kiocb *req,
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
@@ -1035,7 +1034,7 @@ found:
 		if (poll_update->update_user_data)
 			preq->cqe.user_data = poll_update->new_user_data;
 
-		ret2 = io_poll_add(preq, issue_flags);
+		ret2 = io_poll_add(preq, issue_flags & ~IO_URING_F_UNLOCKED);
 		/* successfully updated, don't complete poll request */
 		if (!ret2 || ret2 == -EIOCBQUEUED)
 			goto out;
@@ -1043,9 +1042,9 @@ found:
 
 	req_set_fail(preq);
 	io_req_set_res(preq, -ECANCELED, 0);
-	locked = !(issue_flags & IO_URING_F_UNLOCKED);
 	io_req_task_complete(preq, &locked);
 out:
+	io_ring_submit_unlock(ctx, issue_flags);
 	if (ret < 0) {
 		req_set_fail(req);
 		return ret;


