Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8EB7ED0A0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbjKOT4q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbjKOT4a (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:56:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E911E1B1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:56:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63936C433C7;
        Wed, 15 Nov 2023 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078186;
        bh=wMlb5+tRy1XI8r/emd/seIcFeN2Uyu9yyh33ODyX22M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0YMOOOmBEnSn/Li+oJRG2fhqdJiJ72KL0lyums6ZuE5FR1+rgzBZi2gwwFfidUUf
         +yFOreL56Bwd0i2fv82/ZaF7nwa/MRSfT+Gvwh8PNgtVoE749rtgJegUY2py6XofZL
         a1ZVLix8TwjhwpvnTAVJkAVDtYu2V23TlnmZufT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gabriel Krisman Bertazi <krisman@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 140/379] io_uring/kbuf: Allow the full buffer id space for provided buffers
Date:   Wed, 15 Nov 2023 14:23:35 -0500
Message-ID: <20231115192653.405650647@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index e45602b02a9f1..57ef6850c6a87 100644
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
 
@@ -281,7 +284,7 @@ int io_remove_buffers_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return -EINVAL;
 
 	tmp = READ_ONCE(sqe->fd);
-	if (!tmp || tmp > USHRT_MAX)
+	if (!tmp || tmp > MAX_BIDS_PER_BGID)
 		return -EINVAL;
 
 	memset(p, 0, sizeof(*p));
@@ -327,7 +330,7 @@ int io_provide_buffers_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 		return -EINVAL;
 
 	tmp = READ_ONCE(sqe->fd);
-	if (!tmp || tmp > USHRT_MAX)
+	if (!tmp || tmp > MAX_BIDS_PER_BGID)
 		return -E2BIG;
 	p->nbufs = tmp;
 	p->addr = READ_ONCE(sqe->addr);
@@ -347,7 +350,7 @@ int io_provide_buffers_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
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



