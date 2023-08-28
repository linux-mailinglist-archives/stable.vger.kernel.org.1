Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF24678ABA7
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjH1Kd0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjH1Kc6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC1212D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:32:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00F3C63D39
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB74C433C8;
        Mon, 28 Aug 2023 10:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218717;
        bh=nNRdEpPlfnw8r5Fj7xeIRM5d9YI9/Ha73iakJfEVzTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m7eD7hm4mPeaDIvLCsxcrcW2HoXndHXQKhZuLCpysTT9OSFx2AQKipWJYePWp5rXZ
         C8zZUrNUQ/cQ9HOeSkX4udJ3/G7/+N5UDtOtPGuqcEVfmtVARe0KF7p1wCDI1grV49
         g/tVVI9zx6EoFosLUGmSBOPkqN6+QRwPBAU/pT84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 059/122] io_uring/msg_ring: move double lock/unlock helpers higher up
Date:   Mon, 28 Aug 2023 12:12:54 +0200
Message-ID: <20230828101158.398763949@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

Commit 423d5081d0451faa59a707e57373801da5b40141 upstream.

In preparation for needing them somewhere else, move them and get rid of
the unused 'issue_flags' for the unlock side.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/msg_ring.c |   47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

--- a/io_uring/msg_ring.c
+++ b/io_uring/msg_ring.c
@@ -24,6 +24,28 @@ struct io_msg {
 	u32 flags;
 };
 
+static void io_double_unlock_ctx(struct io_ring_ctx *octx)
+{
+	mutex_unlock(&octx->uring_lock);
+}
+
+static int io_double_lock_ctx(struct io_ring_ctx *octx,
+			      unsigned int issue_flags)
+{
+	/*
+	 * To ensure proper ordering between the two ctxs, we can only
+	 * attempt a trylock on the target. If that fails and we already have
+	 * the source ctx lock, punt to io-wq.
+	 */
+	if (!(issue_flags & IO_URING_F_UNLOCKED)) {
+		if (!mutex_trylock(&octx->uring_lock))
+			return -EAGAIN;
+		return 0;
+	}
+	mutex_lock(&octx->uring_lock);
+	return 0;
+}
+
 void io_msg_ring_cleanup(struct io_kiocb *req)
 {
 	struct io_msg *msg = io_kiocb_to_cmd(req, struct io_msg);
@@ -51,29 +73,6 @@ static int io_msg_ring_data(struct io_ki
 	return -EOVERFLOW;
 }
 
-static void io_double_unlock_ctx(struct io_ring_ctx *octx,
-				 unsigned int issue_flags)
-{
-	mutex_unlock(&octx->uring_lock);
-}
-
-static int io_double_lock_ctx(struct io_ring_ctx *octx,
-			      unsigned int issue_flags)
-{
-	/*
-	 * To ensure proper ordering between the two ctxs, we can only
-	 * attempt a trylock on the target. If that fails and we already have
-	 * the source ctx lock, punt to io-wq.
-	 */
-	if (!(issue_flags & IO_URING_F_UNLOCKED)) {
-		if (!mutex_trylock(&octx->uring_lock))
-			return -EAGAIN;
-		return 0;
-	}
-	mutex_lock(&octx->uring_lock);
-	return 0;
-}
-
 static struct file *io_msg_grab_file(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_msg *msg = io_kiocb_to_cmd(req, struct io_msg);
@@ -122,7 +121,7 @@ static int io_msg_install_complete(struc
 	if (!io_post_aux_cqe(target_ctx, msg->user_data, ret, 0, true))
 		ret = -EOVERFLOW;
 out_unlock:
-	io_double_unlock_ctx(target_ctx, issue_flags);
+	io_double_unlock_ctx(target_ctx);
 	return ret;
 }
 


