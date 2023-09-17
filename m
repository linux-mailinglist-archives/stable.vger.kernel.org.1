Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762507A3A45
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbjIQUCL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjIQUBk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:01:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DED91A4
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:00:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316FAC433C8;
        Sun, 17 Sep 2023 20:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980831;
        bh=KkNcjq1dxyEckrVtKdsBJGRfEbywks8JtlWhA8n4NOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O+0+p4rpqQz6cac2mHvNA86sUXSueq40dJGCzkJzBb6lqxj23r69buPT1QZIHPku8
         c6vw4RMyyUKp/59jC+Mhv0Mw+k0FF7qYd1AMZwY+lagFGATnMZ2C50KL/ydArLxgaV
         HAm4MyQbuTXevNxp5YtIIzjCGTjdXsWcbRHEv5fA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dylan Yudaken <dylany@meta.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 6.1 005/219] io_uring: revert "io_uring fix multishot accept ordering"
Date:   Sun, 17 Sep 2023 21:12:12 +0200
Message-ID: <20230917191041.158454836@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

From: Dylan Yudaken <dylany@meta.com>

[ upstream commit 515e26961295bee9da5e26916c27739dca6c10e1 ]

This is no longer needed after commit aa1df3a360a0 ("io_uring: fix CQE
reordering"), since all reordering is now taken care of.

This reverts commit cbd25748545c ("io_uring: fix multishot accept
ordering").

Signed-off-by: Dylan Yudaken <dylany@meta.com>
Link: https://lore.kernel.org/r/20221107125236.260132-2-dylany@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/net.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1337,12 +1337,12 @@ retry:
 		return IOU_OK;
 	}
 
-	if (ret >= 0 &&
-	    io_post_aux_cqe(ctx, req->cqe.user_data, ret, IORING_CQE_F_MORE, false))
+	if (ret < 0)
+		return ret;
+	if (io_post_aux_cqe(ctx, req->cqe.user_data, ret, IORING_CQE_F_MORE, true))
 		goto retry;
 
-	io_req_set_res(req, ret, 0);
-	return (issue_flags & IO_URING_F_MULTISHOT) ? IOU_STOP_MULTISHOT : IOU_OK;
+	return -ECANCELED;
 }
 
 int io_socket_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)


