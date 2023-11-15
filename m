Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1231E7ECE5D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjKOTmi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbjKOTmh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:42:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FDA189
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:42:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38603C433C7;
        Wed, 15 Nov 2023 19:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077353;
        bh=7T5TyUKHxv90Dpi3iiIrcPHkYg9+7e7cdx1sds/479o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ncLn8nuNa7zqhRm+pdbPkL6xsoebunm7bQ1kfDOiMAtiVe01NdHaF3nfrbGXeTD4g
         /7VswFhxDwYgDp+LOcCXNC3QBN4I8UX+MCSA/5DBoBF7M1VM+5b5aGqtkdeGkPwobD
         844/oB5h+F2HJK0u+WKF/nbaN3WpaQD2AJ4QXta0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gabriel Krisman Bertazi <krisman@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 250/603] io_uring/kbuf: Allow the full buffer id space for provided buffers
Date:   Wed, 15 Nov 2023 14:13:15 -0500
Message-ID: <20231115191630.553839404@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriel Krisman Bertazi <krisman@suse.de>

[ Upstream commit f74c746e476b9dad51448b9a9421aae72b60e25f ]

nbufs tracks the number of buffers and not the last bgid. In 16-bit, we
have 2^16 valid buffers, but the check mistakenly rejects the last
bid. Let's fix it to make the interface consistent with the
documentation.

Fixes: ddf0322db79c ("io_uring: add IORING_OP_PROVIDE_BUFFERS")
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
Link: https://lore.kernel.org/r/20231005000531.30800-3-krisman@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/kbuf.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 74a4f9600642f..f6e5ae026e4be 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -19,12 +19,15 @@
 
 #define BGID_ARRAY	64
 
+/* BIDs are addressed by a 16-bit field in a CQE */
+#define MAX_BIDS_PER_BGID (1 << 16)
+
 struct io_provide_buf {
 	struct file			*file;
 	__u64				addr;
 	__u32				len;
 	__u32				bgid;
-	__u16				nbufs;
+	__u32				nbufs;
 	__u16				bid;
 };
 
@@ -289,7 +292,7 @@ int io_remove_buffers_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return -EINVAL;
 
 	tmp = READ_ONCE(sqe->fd);
-	if (!tmp || tmp > USHRT_MAX)
+	if (!tmp || tmp > MAX_BIDS_PER_BGID)
 		return -EINVAL;
 
 	memset(p, 0, sizeof(*p));
@@ -332,7 +335,7 @@ int io_provide_buffers_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 		return -EINVAL;
 
 	tmp = READ_ONCE(sqe->fd);
-	if (!tmp || tmp > USHRT_MAX)
+	if (!tmp || tmp > MAX_BIDS_PER_BGID)
 		return -E2BIG;
 	p->nbufs = tmp;
 	p->addr = READ_ONCE(sqe->addr);
@@ -352,7 +355,7 @@ int io_provide_buffers_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 	tmp = READ_ONCE(sqe->off);
 	if (tmp > USHRT_MAX)
 		return -E2BIG;
-	if (tmp + p->nbufs > USHRT_MAX)
+	if (tmp + p->nbufs > MAX_BIDS_PER_BGID)
 		return -EINVAL;
 	p->bid = tmp;
 	return 0;
-- 
2.42.0



