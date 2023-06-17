Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52C6733F78
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 10:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjFQIL1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 17 Jun 2023 04:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjFQIL0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Jun 2023 04:11:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD7D1BF2
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 01:11:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B19D760A5A
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 08:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3147C433C0;
        Sat, 17 Jun 2023 08:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686989484;
        bh=UPTs6/Pz5O4fIYtFg5EUZjtsitOKREkTmlQQLNq86XM=;
        h=Subject:To:Cc:From:Date:From;
        b=2KLbtFJAPDpzMdK0LfbWHbhdDPgiygYRK/WUIZt5OjmI65W9zCkBu7GHoazNDbtCa
         wg6nLnWCe4hpn5/S4Kq4dBDwlGQbqqV9ai3IEJzo0bsZi5gYP1PVCEUTt75Xml4noP
         qZRqaxyVskzq461zuO7oFFDKW7FbddreZJmBvcx4=
Subject: FAILED: patch "[PATCH] io_uring/net: save msghdr->msg_control for retries" failed to apply to 5.10-stable tree
To:     axboe@kernel.dk, marek@cloudflare.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 17 Jun 2023 10:11:21 +0200
Message-ID: <2023061721-shaft-lion-f22c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x cac9e4418f4cbd548ccb065b3adcafe073f7f7d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061721-shaft-lion-f22c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cac9e4418f4cbd548ccb065b3adcafe073f7f7d2 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 12 Jun 2023 13:51:36 -0600
Subject: [PATCH] io_uring/net: save msghdr->msg_control for retries

If the application sets ->msg_control and we have to later retry this
command, or if it got queued with IOSQE_ASYNC to begin with, then we
need to retain the original msg_control value. This is due to the net
stack overwriting this field with an in-kernel pointer, to copy it
in. Hitting that path for the second time will now fail the copy from
user, as it's attempting to copy from a non-user address.

Cc: stable@vger.kernel.org # 5.10+
Link: https://github.com/axboe/liburing/issues/880
Reported-and-tested-by: Marek Majkowski <marek@cloudflare.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/net.c b/io_uring/net.c
index 89e839013837..51b0f7fbb4f5 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -65,6 +65,7 @@ struct io_sr_msg {
 	u16				addr_len;
 	u16				buf_group;
 	void __user			*addr;
+	void __user			*msg_control;
 	/* used only for send zerocopy */
 	struct io_kiocb 		*notif;
 };
@@ -195,11 +196,15 @@ static int io_sendmsg_copy_hdr(struct io_kiocb *req,
 			       struct io_async_msghdr *iomsg)
 {
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
+	int ret;
 
 	iomsg->msg.msg_name = &iomsg->addr;
 	iomsg->free_iov = iomsg->fast_iov;
-	return sendmsg_copy_msghdr(&iomsg->msg, sr->umsg, sr->msg_flags,
+	ret = sendmsg_copy_msghdr(&iomsg->msg, sr->umsg, sr->msg_flags,
 					&iomsg->free_iov);
+	/* save msg_control as sys_sendmsg() overwrites it */
+	sr->msg_control = iomsg->msg.msg_control;
+	return ret;
 }
 
 int io_send_prep_async(struct io_kiocb *req)
@@ -297,6 +302,7 @@ int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (req_has_async_data(req)) {
 		kmsg = req->async_data;
+		kmsg->msg.msg_control = sr->msg_control;
 	} else {
 		ret = io_sendmsg_copy_hdr(req, &iomsg);
 		if (ret)

