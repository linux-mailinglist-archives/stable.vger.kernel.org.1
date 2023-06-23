Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAD473B397
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjFWJaS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjFWJaR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50F6BA
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 624AC619C0
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 09:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDDBC433C0;
        Fri, 23 Jun 2023 09:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687512614;
        bh=82p1gzFkK3bk9xQb1jg5d7FDRh+NPTM3IqWoe0sOPdo=;
        h=Subject:To:Cc:From:Date:From;
        b=uW5P+7vYwJ1R+/QGbDbpnOMfEtCutS4Wo5GAXbJaNDope5yK9aj+spmVAwOsbr2PI
         /L09ZGgxMez/2XD6Qaxt3R+FKWdktA4tq+3qSU8MwClvUjfjArF5tdZptqshIMd4M6
         dopF9J9aOXPG/o+WAzYkQGNVTIFrmoWj1XgKUBUM=
Subject: FAILED: patch "[PATCH] io_uring/net: disable partial retries for recvmsg with cmsg" failed to apply to 5.10-stable tree
To:     axboe@kernel.dk, metze@samba.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 23 Jun 2023 11:30:04 +0200
Message-ID: <2023062303-urging-acutely-c0f9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
git cherry-pick -x 78d0d2063bab954d19a1696feae4c7706a626d48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062303-urging-acutely-c0f9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 78d0d2063bab954d19a1696feae4c7706a626d48 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 19 Jun 2023 09:41:05 -0600
Subject: [PATCH] io_uring/net: disable partial retries for recvmsg with cmsg

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

diff --git a/io_uring/net.c b/io_uring/net.c
index c0924ab1ea11..2bc2cb2f4d6c 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -789,16 +789,19 @@ retry_multishot:
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

