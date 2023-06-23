Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A11073B393
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjFWJ3e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjFWJ3c (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:29:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAC69D
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:29:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8B1A619E0
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 09:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AABC433C8;
        Fri, 23 Jun 2023 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687512571;
        bh=dRThpKqPx7aqAQgTsc9Oh0CtjtY66m5I64cMVC801Q4=;
        h=Subject:To:Cc:From:Date:From;
        b=tSSYuGJekRT/s+p2IL1BTbBc+UzUvibkHLO/gP3KKY7s/KMsq2cpBE/4efTSGRvSr
         gQFCgJsrDR1FM9RGjdjtkpcUcsIGnGrYQq4HQq1SvlElooINDIQITUTpFzzU3NdqxO
         5rlCFRnX6vW5fuzff1oqWRBxqqYIL6LwpVaiJ9Vw=
Subject: FAILED: patch "[PATCH] io_uring/net: clear msg_controllen on partial sendmsg retry" failed to apply to 5.15-stable tree
To:     axboe@kernel.dk, metze@samba.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 23 Jun 2023 11:29:28 +0200
Message-ID: <2023062328-parka-debtor-1040@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b1dc492087db0f2e5a45f1072a743d04618dd6be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062328-parka-debtor-1040@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b1dc492087db0f2e5a45f1072a743d04618dd6be Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 19 Jun 2023 09:35:34 -0600
Subject: [PATCH] io_uring/net: clear msg_controllen on partial sendmsg retry

If we have cmsg attached AND we transferred partial data at least, clear
msg_controllen on retry so we don't attempt to send that again.

Cc: stable@vger.kernel.org # 5.10+
Fixes: cac9e4418f4c ("io_uring/net: save msghdr->msg_control for retries")
Reported-by: Stefan Metzmacher <metze@samba.org>
Reviewed-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/net.c b/io_uring/net.c
index 51b0f7fbb4f5..c0924ab1ea11 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -326,6 +326,8 @@ int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags)
 		if (ret == -EAGAIN && (issue_flags & IO_URING_F_NONBLOCK))
 			return io_setup_async_msg(req, kmsg, issue_flags);
 		if (ret > 0 && io_net_retry(sock, flags)) {
+			kmsg->msg.msg_controllen = 0;
+			kmsg->msg.msg_control = NULL;
 			sr->done_io += ret;
 			req->flags |= REQ_F_PARTIAL_IO;
 			return io_setup_async_msg(req, kmsg, issue_flags);

