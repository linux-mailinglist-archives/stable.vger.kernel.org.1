Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3080F761494
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbjGYLUn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjGYLUj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6745619A1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4706B6167D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5433CC433C8;
        Tue, 25 Jul 2023 11:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284035;
        bh=SLksFrqLNw2Z8rdcW16EYZ+LOjQF+3Ty8z8pGOeF7SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KoWz1PP+XyTWnSvJ2Q9djdv7/dzgd4jiYhneLHUJ9fA3vJaTy8BvteY+3sqClSl0u
         Xyg1ylUsLfTmwCoTJEcE0Dm9mLklh5QKbTupQMvMl4ZY8y5WfQMDVcCAkdyIkEu+r0
         tkDKmV9bcIx2u7g4UEnsAdmEelCa7XoPBcaxkhVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, dghost david <daviduniverse18@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10 211/509] io_uring: ensure IOPOLL locks around deferred work
Date:   Tue, 25 Jul 2023 12:42:30 +0200
Message-ID: <20230725104603.394974632@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jens Axboe <axboe@kernel.dk>

No direct upstream commit exists for this issue. It was fixed in
5.18 as part of a larger rework of the completion side.

io_commit_cqring() writes the CQ ring tail to make it visible, but it
also kicks off any deferred work we have. A ring setup with IOPOLL
does not need any locking around the CQ ring updates, as we're always
under the ctx uring_lock. But if we have deferred work that needs
processing, then io_queue_deferred() assumes that the completion_lock
is held, as it is for !IOPOLL.

Add a lockdep assertion to check and document this fact, and have
io_iopoll_complete() check if we have deferred work and run that
separately with the appropriate lock grabbed.

Cc: stable@vger.kernel.org # 5.10, 5.15
Reported-by: dghost david <daviduniverse18@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1521,6 +1521,8 @@ static void io_kill_timeout(struct io_ki
 
 static void io_queue_deferred(struct io_ring_ctx *ctx)
 {
+	lockdep_assert_held(&ctx->completion_lock);
+
 	while (!list_empty(&ctx->defer_list)) {
 		struct io_defer_entry *de = list_first_entry(&ctx->defer_list,
 						struct io_defer_entry, list);
@@ -1572,14 +1574,24 @@ static void __io_commit_cqring_flush(str
 		io_queue_deferred(ctx);
 }
 
-static inline void io_commit_cqring(struct io_ring_ctx *ctx)
+static inline bool io_commit_needs_flush(struct io_ring_ctx *ctx)
+{
+	return ctx->off_timeout_used || ctx->drain_active;
+}
+
+static inline void __io_commit_cqring(struct io_ring_ctx *ctx)
 {
-	if (unlikely(ctx->off_timeout_used || ctx->drain_active))
-		__io_commit_cqring_flush(ctx);
 	/* order cqe stores with ring update */
 	smp_store_release(&ctx->rings->cq.tail, ctx->cached_cq_tail);
 }
 
+static inline void io_commit_cqring(struct io_ring_ctx *ctx)
+{
+	if (unlikely(io_commit_needs_flush(ctx)))
+		__io_commit_cqring_flush(ctx);
+	__io_commit_cqring(ctx);
+}
+
 static inline bool io_sqring_full(struct io_ring_ctx *ctx)
 {
 	struct io_rings *r = ctx->rings;
@@ -2518,7 +2530,12 @@ static void io_iopoll_complete(struct io
 			io_req_free_batch(&rb, req, &ctx->submit_state);
 	}
 
-	io_commit_cqring(ctx);
+	if (io_commit_needs_flush(ctx)) {
+		spin_lock(&ctx->completion_lock);
+		__io_commit_cqring_flush(ctx);
+		spin_unlock(&ctx->completion_lock);
+	}
+	__io_commit_cqring(ctx);
 	io_cqring_ev_posted_iopoll(ctx);
 	io_req_free_batch_finish(ctx, &rb);
 }


