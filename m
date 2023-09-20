Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B781F7A7C48
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjITMAJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjITL7r (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:59:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C574AD
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:59:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68D6C433C9;
        Wed, 20 Sep 2023 11:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211182;
        bh=40U12+fto3gwOH/AouhAN4Q+kGqMviCGCGwCa+Xd4Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XeM2EG6ctLS5vZ8dB7fkiYU2YeSF1Wn70S1+MXF9/oehaputmoz+oB9rfmklC9VZt
         EoIZlFOvtgrDv7dNTH/IJX+tEUw087WHBcFHq2sWSkKY8nguiIxjIE2KOGxsOHPSes
         kSHv6iAswSG4fLBEDGNAR0Bk/aAfsbLMnI/5sz44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+a4c6e5ef999b68b26ed1@syzkaller.appspotmail.com,
        Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 113/139] io_uring/net: fix iter retargeting for selected buf
Date:   Wed, 20 Sep 2023 13:30:47 +0200
Message-ID: <20230920112839.775377148@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -170,6 +170,10 @@ static int io_setup_async_msg(struct io_
 	memcpy(async_msg, kmsg, sizeof(*kmsg));
 	if (async_msg->msg.msg_name)
 		async_msg->msg.msg_name = &async_msg->addr;
+
+	if ((req->flags & REQ_F_BUFFER_SELECT) && !async_msg->msg.msg_iter.nr_segs)
+		return -EAGAIN;
+
 	/* if were using fast_iov, set it to the new one */
 	if (!kmsg->free_iov) {
 		size_t fast_idx = kmsg->msg.msg_iter.iov - kmsg->fast_iov;
@@ -529,6 +533,7 @@ static int io_recvmsg_copy_hdr(struct io
 			       struct io_async_msghdr *iomsg)
 {
 	iomsg->msg.msg_name = &iomsg->addr;
+	iomsg->msg.msg_iter.nr_segs = 0;
 
 #ifdef CONFIG_COMPAT
 	if (req->ctx->compat)


