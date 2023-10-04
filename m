Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF277B8268
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 16:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjJDOdx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 10:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjJDOdx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 10:33:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B70AAD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 07:33:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC06C433C7;
        Wed,  4 Oct 2023 14:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696430030;
        bh=GK7BvTMAbcdvhCv0efyJwQNXpD0yzb4x0lI2+mM3rzg=;
        h=Subject:To:Cc:From:Date:From;
        b=luY+Gp1fslXBqO05g4gpYascfV9xUFwYRV0bO6bMb3U5l/ClsRCOMnFtiylPBflIj
         CQo4RY3eh5ReTfZsitRVOIsKzasUwcLdwXwLua5zZGXxcjRlHE62CqAvnvpCpJIDxk
         t02hkFL3ytCgK/6CwuhMelqQOcZPSG8uHYC7LBvQ=
Subject: FAILED: patch "[PATCH] io_uring/fs: remove sqe->rw_flags checking from LINKAT" failed to apply to 5.15-stable tree
To:     axboe@kernel.dk, talex5@gmail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 16:33:46 +0200
Message-ID: <2023100446-broiler-liquid-20a4@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
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
git cherry-pick -x a52d4f657568d6458e873f74a9602e022afe666f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100446-broiler-liquid-20a4@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a52d4f657568d6458e873f74a9602e022afe666f Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 28 Sep 2023 09:23:27 -0600
Subject: [PATCH] io_uring/fs: remove sqe->rw_flags checking from LINKAT

This is unionized with the actual link flags, so they can of course be
set and they will be evaluated further down. If not we fail any LINKAT
that has to set option flags.

Fixes: cf30da90bc3a ("io_uring: add support for IORING_OP_LINKAT")
Cc: stable@vger.kernel.org
Reported-by: Thomas Leonard <talex5@gmail.com>
Link: https://github.com/axboe/liburing/issues/955
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/fs.c b/io_uring/fs.c
index f6a69a549fd4..08e3b175469c 100644
--- a/io_uring/fs.c
+++ b/io_uring/fs.c
@@ -243,7 +243,7 @@ int io_linkat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct io_link *lnk = io_kiocb_to_cmd(req, struct io_link);
 	const char __user *oldf, *newf;
 
-	if (sqe->rw_flags || sqe->buf_index || sqe->splice_fd_in)
+	if (sqe->buf_index || sqe->splice_fd_in)
 		return -EINVAL;
 	if (unlikely(req->flags & REQ_F_FIXED_FILE))
 		return -EBADF;

