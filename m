Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2401579981F
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 14:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbjIIMxY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 08:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjIIMxX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 08:53:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0DCCD6
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 05:53:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD01C433C7;
        Sat,  9 Sep 2023 12:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694263999;
        bh=WD3coc/aT7s8QmaZ/JgZ4BbKVcNUuzdRC75MfQpIv1o=;
        h=Subject:To:Cc:From:Date:From;
        b=G7+Zo/1m3DEoQmZSO7csRAHphek0tNOOnFJaU9tc8f987dOkewlgved5jMfnQ4+jo
         IkHFodOGF0Q5LLNj5N/MFaHWUNKUKCQLKaKP8D3TqUzTUXMabFkC3KyLxsp5ZMH2pY
         Q9b3aVLL8A/uoiTL3J5VtfNunsZuUXx4xzQbcqaI=
Subject: FAILED: patch "[PATCH] io_uring/net: don't overflow multishot recv" failed to apply to 6.4-stable tree
To:     asml.silence@gmail.com, axboe@kernel.dk
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 09 Sep 2023 13:53:09 +0100
Message-ID: <2023090908-cursor-reshape-7963@gregkh>
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
git cherry-pick -x b2e74db55dd93d6db22a813c9a775b5dbf87c560
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090908-cursor-reshape-7963@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:

b2e74db55dd9 ("io_uring/net: don't overflow multishot recv")
d86eaed185e9 ("io_uring: cleanup io_aux_cqe() API")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b2e74db55dd93d6db22a813c9a775b5dbf87c560 Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Fri, 11 Aug 2023 13:53:42 +0100
Subject: [PATCH] io_uring/net: don't overflow multishot recv

Don't allow overflowing multishot recv CQEs, it might get out of
hand, hurt performance, and in the worst case scenario OOM the task.

Cc: stable@vger.kernel.org
Fixes: b3fdea6ecb55c ("io_uring: multishot recv")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/0b295634e8f1b71aa764c984608c22d85f88f75c.1691757663.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/net.c b/io_uring/net.c
index 1599493544a5..8c419c01a5db 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -642,7 +642,7 @@ static inline bool io_recv_finish(struct io_kiocb *req, int *ret,
 
 	if (!mshot_finished) {
 		if (io_aux_cqe(req, issue_flags & IO_URING_F_COMPLETE_DEFER,
-			       *ret, cflags | IORING_CQE_F_MORE, true)) {
+			       *ret, cflags | IORING_CQE_F_MORE, false)) {
 			io_recv_prep_retry(req);
 			/* Known not-empty or unknown state, retry */
 			if (cflags & IORING_CQE_F_SOCK_NONEMPTY ||

