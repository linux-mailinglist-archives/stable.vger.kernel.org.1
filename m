Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9267A7B64
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjITLvt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjITLvj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:51:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2CACE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:51:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4783EC433CB;
        Wed, 20 Sep 2023 11:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210692;
        bh=lC0320bE+MUSpYUq1M4XR00wOSdL0QPTABCw/MWwoNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8vPaivs7I5pVP9nZGEtgsStaRmkg/2jIIHMnLT2tujNvjfJt1LamLEasLGnWjAuk
         pZ3D8JSKOPxQciBH+eRHb+7A97b7R+q9QrJ7DcY/MLgqZz44mDrc6sVD3OvOhgJ8pn
         pLWa0ar9HJewlsnVkBy6x82/em2dYSGDQMWcLSs0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+a4c6e5ef999b68b26ed1@syzkaller.appspotmail.com,
        Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.5 170/211] io_uring/net: fix iter retargeting for selected buf
Date:   Wed, 20 Sep 2023 13:30:14 +0200
Message-ID: <20230920112851.160600434@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

commit c21a8027ad8a68c340d0d58bf1cc61dcb0bc4d2f upstream.

When using selected buffer feature, io_uring delays data iter setup
until later. If io_setup_async_msg() is called before that it might see
not correctly setup iterator. Pre-init nr_segs and judge from its state
whether we repointing.

Cc: stable@vger.kernel.org
Reported-by: syzbot+a4c6e5ef999b68b26ed1@syzkaller.appspotmail.com
Fixes: 0455d4ccec548 ("io_uring: add POLL_FIRST support for send/sendmsg and recv/recvmsg")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/0000000000002770be06053c7757@google.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/net.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -183,6 +183,10 @@ static int io_setup_async_msg(struct io_
 	memcpy(async_msg, kmsg, sizeof(*kmsg));
 	if (async_msg->msg.msg_name)
 		async_msg->msg.msg_name = &async_msg->addr;
+
+	if ((req->flags & REQ_F_BUFFER_SELECT) && !async_msg->msg.msg_iter.nr_segs)
+		return -EAGAIN;
+
 	/* if were using fast_iov, set it to the new one */
 	if (iter_is_iovec(&kmsg->msg.msg_iter) && !kmsg->free_iov) {
 		size_t fast_idx = iter_iov(&kmsg->msg.msg_iter) - kmsg->fast_iov;
@@ -542,6 +546,7 @@ static int io_recvmsg_copy_hdr(struct io
 			       struct io_async_msghdr *iomsg)
 {
 	iomsg->msg.msg_name = &iomsg->addr;
+	iomsg->msg.msg_iter.nr_segs = 0;
 
 #ifdef CONFIG_COMPAT
 	if (req->ctx->compat)


