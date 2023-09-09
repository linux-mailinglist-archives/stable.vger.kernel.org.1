Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E7B799820
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 14:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbjIIMxc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 08:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjIIMxc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 08:53:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06EBCDE
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 05:53:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CEBC433C8;
        Sat,  9 Sep 2023 12:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694264008;
        bh=ddA9fhTgysLvivMv4K7fClpl2TnfYjTjAIp+9XeMeXM=;
        h=Subject:To:Cc:From:Date:From;
        b=CJkN1sWqK+CuZhwwuvf4bWYyc8hzPLD+5nKx2AhATV/tEr1OBKS7QCOUMJuSPJXmj
         LaEZ3yIcu8RgjFOosa49WVQOMKl0c+Z7O2IYyB7kxXwDQ0aNhXR14wdk6S3Zq9+xeU
         zlxVBlEtUvQuIbh2GfaUFqncMOewDBPzhRuVinUo=
Subject: FAILED: patch "[PATCH] io_uring/net: don't overflow multishot accept" failed to apply to 6.4-stable tree
To:     asml.silence@gmail.com, axboe@kernel.dk
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 09 Sep 2023 13:53:25 +0100
Message-ID: <2023090925-saline-prorate-1854@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 1bfed23349716a7811645336a7ce42c4b8f250bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090925-saline-prorate-1854@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:

1bfed2334971 ("io_uring/net: don't overflow multishot accept")
d86eaed185e9 ("io_uring: cleanup io_aux_cqe() API")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1bfed23349716a7811645336a7ce42c4b8f250bc Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Fri, 11 Aug 2023 13:53:41 +0100
Subject: [PATCH] io_uring/net: don't overflow multishot accept

Don't allow overflowing multishot accept CQEs, we want to limit
the grows of the overflow list.

Cc: stable@vger.kernel.org
Fixes: 4e86a2c980137 ("io_uring: implement multishot mode for accept")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/7d0d749649244873772623dd7747966f516fe6e2.1691757663.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/net.c b/io_uring/net.c
index eb1f51ddcb23..1599493544a5 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1367,7 +1367,7 @@ int io_accept(struct io_kiocb *req, unsigned int issue_flags)
 	if (ret < 0)
 		return ret;
 	if (io_aux_cqe(req, issue_flags & IO_URING_F_COMPLETE_DEFER, ret,
-		       IORING_CQE_F_MORE, true))
+		       IORING_CQE_F_MORE, false))
 		goto retry;
 
 	return -ECANCELED;

