Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F71D73E8CD
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjFZS3q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjFZS3a (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:29:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDD12710
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:29:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 845D760F40
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F915C433CB;
        Mon, 26 Jun 2023 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804141;
        bh=SesFy4arrJuGxDVjfRSOZoNezECgi4DJkjPU9W0ROvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hX1F+qPOcJvOIi2Kl2mt0TwX3VVpYKen3Kt9bPcrMoytiHR9+a4IDgZCYlD96Q/xL
         glsKEgiW2hP2IonB6LBc38/5/Zn4OPDolUcWOTDPKdeCFe2M0EWqD3WFPZGdUm2huI
         RPQ35ziJjygp2UODhsg8Jf94nEFTLNq66fQcxHJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Metzmacher <metze@samba.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 056/170] io_uring/net: disable partial retries for recvmsg with cmsg
Date:   Mon, 26 Jun 2023 20:10:25 +0200
Message-ID: <20230626180803.093850140@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

commit 78d0d2063bab954d19a1696feae4c7706a626d48 upstream.

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
 io_uring/net.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -781,16 +781,19 @@ retry_multishot:
 	flags = sr->msg_flags;
 	if (force_nonblock)
 		flags |= MSG_DONTWAIT;
-	if (flags & MSG_WAITALL)
-		min_ret = iov_iter_count(&kmsg->msg.msg_iter);
 
 	kmsg->msg.msg_get_inq = 1;
-	if (req->flags & REQ_F_APOLL_MULTISHOT)
+	if (req->flags & REQ_F_APOLL_MULTISHOT) {
 		ret = io_recvmsg_multishot(sock, sr, kmsg, flags,
 					   &mshot_finished);
-	else
+	} else {
+		/* disable partial retry for recvmsg with cmsg attached */
+		if (flags & MSG_WAITALL && !kmsg->msg.msg_controllen)
+			min_ret = iov_iter_count(&kmsg->msg.msg_iter);
+
 		ret = __sys_recvmsg_sock(sock, &kmsg->msg, sr->umsg,
 					 kmsg->uaddr, flags);
+	}
 
 	if (ret < min_ret) {
 		if (ret == -EAGAIN && force_nonblock) {


