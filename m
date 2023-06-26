Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8C873E9BD
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjFZSje (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjFZSjd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:39:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086ECCC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0638760EFC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C421C433C8;
        Mon, 26 Jun 2023 18:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804769;
        bh=skUKu08vtIeaZlk9bosRzJGpXUH41bWtQeJykdtETKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SE8cJ3dB2jbAiO6E0g/B3UjpvLedgIN9W4KW5tgl9lFIndkj8Y/rXsbEAVx1oWC30
         IQPl2G3P88lowoKhrblMEb7qyfem8j4svo4ZBejTo/zUUy4qEexPTSrK5p5c32f71d
         txBuaZk13HvjUm2jz0CypaJauJ3K1cGlySG3WE5Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Metzmacher <metze@samba.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 34/96] io_uring/net: disable partial retries for recvmsg with cmsg
Date:   Mon, 26 Jun 2023 20:11:49 +0200
Message-ID: <20230626180748.367453596@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
References: <20230626180746.943455203@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

Commit 78d0d2063bab954d19a1696feae4c7706a626d48 upstream.

We cannot sanely handle partial retries for recvmsg if we have cmsg
attached. If we don't, then we'd just be overwriting the initial cmsg
header on retries. Alternatively we could increment and handle this
appropriately, but it doesn't seem worth the complication.

Move the MSG_WAITALL check into the non-multishot case while at it,
since MSG_WAITALL is explicitly disabled for multishot anyway.

Link: https://lore.kernel.org/io-uring/0b0d4411-c8fd-4272-770b-e030af6919a0@kernel.dk/
Cc: stable@vger.kernel.org # 5.10+
Reported-by: Stefan Metzmacher <metze@samba.org>
Reviewed-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -5201,7 +5201,7 @@ static int io_recvmsg(struct io_kiocb *r
 	flags = req->sr_msg.msg_flags;
 	if (force_nonblock)
 		flags |= MSG_DONTWAIT;
-	if (flags & MSG_WAITALL)
+	if (flags & MSG_WAITALL && !kmsg->msg.msg_controllen)
 		min_ret = iov_iter_count(&kmsg->msg.msg_iter);
 
 	ret = __sys_recvmsg_sock(sock, &kmsg->msg, req->sr_msg.umsg,


