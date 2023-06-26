Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA6673EA24
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjFZSno (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjFZSno (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:43:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA3D97
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:43:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C44E360F4F
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC971C433C0;
        Mon, 26 Jun 2023 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687805022;
        bh=tZHgfLjBHocg2hzFGgSyjEEIjOmxhRnIKdHVUQjCmHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GMrN36aVZc76sxAOoOH19/vGNfgQInjQLr7XWKawTkigrJWs7yn/e7ZvuOydp+fOr
         nbMhIRbAaZiH68kee1yjxZrCNPiKsSGT+3oPigiNQM5MFf8Tb7kPhudB4mmwZildsA
         945vsB0gnUrDiwtuS1dd7EoiCLz6Mat8CchHUlRw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Marek Majkowski <marek@cloudflare.com>
Subject: [PATCH 5.10 23/81] io_uring/net: save msghdr->msg_control for retries
Date:   Mon, 26 Jun 2023 20:12:05 +0200
Message-ID: <20230626180745.429110033@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
References: <20230626180744.453069285@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

Commit cac9e4418f4cbd548ccb065b3adcafe073f7f7d2 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -581,6 +581,7 @@ struct io_sr_msg {
 	size_t				len;
 	size_t				done_io;
 	struct io_buffer		*kbuf;
+	void __user			*msg_control;
 };
 
 struct io_open {
@@ -4718,10 +4719,16 @@ static int io_setup_async_msg(struct io_
 static int io_sendmsg_copy_hdr(struct io_kiocb *req,
 			       struct io_async_msghdr *iomsg)
 {
+	struct io_sr_msg *sr = &req->sr_msg;
+	int ret;
+
 	iomsg->msg.msg_name = &iomsg->addr;
 	iomsg->free_iov = iomsg->fast_iov;
-	return sendmsg_copy_msghdr(&iomsg->msg, req->sr_msg.umsg,
+	ret = sendmsg_copy_msghdr(&iomsg->msg, req->sr_msg.umsg,
 				   req->sr_msg.msg_flags, &iomsg->free_iov);
+	/* save msg_control as sys_sendmsg() overwrites it */
+	sr->msg_control = iomsg->msg.msg_control;
+	return ret;
 }
 
 static int io_sendmsg_prep_async(struct io_kiocb *req)
@@ -4778,6 +4785,8 @@ static int io_sendmsg(struct io_kiocb *r
 		if (ret)
 			return ret;
 		kmsg = &iomsg;
+	} else {
+		kmsg->msg.msg_control = sr->msg_control;
 	}
 
 	flags = req->sr_msg.msg_flags;


