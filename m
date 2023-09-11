Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960FA79B5EF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbjIKVsX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbjIKOnk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:43:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3966DCF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:43:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BB7C433C8;
        Mon, 11 Sep 2023 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443415;
        bh=sY2tCPx522qtUB3LByl0b9OQzI23estZhuzoKHMwj2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xa1LtoaeL60y54UUyCKL7DIaWSTHjws7UQrc9s37UlAzuW7TS687sB8IRUiX/4FR5
         DWWQ8PyV5PS6ZQRbkIrT33/dqQ9fYXzhycXuqoR94gkhaOIw7u4HEcL4tmmOA4nctD
         AAMBXzUjr6nOpsXTBI6yGbjXo6emHVOeh+DAWOJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 370/737] io_uring: fix drain stalls by invalid SQE
Date:   Mon, 11 Sep 2023 15:43:49 +0200
Message-ID: <20230911134700.882368429@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit cfdbaa3a291d6fd2cb4a1a70d74e63b4abc2f5ec ]

cq_extra is protected by ->completion_lock, which io_get_sqe() misses.
The bug is harmless as it doesn't happen in real life, requires invalid
SQ index array and racing with submission, and only messes up the
userspace, i.e. stall requests execution but will be cleaned up on
ring destruction.

Fixes: 15641e427070f ("io_uring: don't cache number of dropped SQEs")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/66096d54651b1a60534bb2023f2947f09f50ef73.1691538547.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index a57bdf336ca8a..d029e578bdfe1 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2468,7 +2468,9 @@ static bool io_get_sqe(struct io_ring_ctx *ctx, const struct io_uring_sqe **sqe)
 	}
 
 	/* drop invalid entries */
+	spin_lock(&ctx->completion_lock);
 	ctx->cq_extra--;
+	spin_unlock(&ctx->completion_lock);
 	WRITE_ONCE(ctx->rings->sq_dropped,
 		   READ_ONCE(ctx->rings->sq_dropped) + 1);
 	return false;
-- 
2.40.1



