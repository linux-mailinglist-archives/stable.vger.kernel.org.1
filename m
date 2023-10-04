Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7277B88AB
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjJDSSZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243892AbjJDSJU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:09:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26E9C9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:09:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFE9C433C8;
        Wed,  4 Oct 2023 18:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442955;
        bh=IRofGcQLhywcNGP1TyhfFty64M6KwyUFRifPZjmLgOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4Ur+VuNwZtddrkaPAY09fuaHM1vJGCv7dKACbQQFdm7fhd+1nfjgycXl7KbpoNNX
         mUe4fmnSN8tZONtxkuwMRoeNM4YvS6cMfEF7H6Bm8nHq039x/7ypj28YfxK8S9bnZO
         gbMPv3t6RokxE1fqMksxI4qaJMHbF/GJD2s0URfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Leonard <talex5@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 169/183] io_uring/fs: remove sqe->rw_flags checking from LINKAT
Date:   Wed,  4 Oct 2023 19:56:40 +0200
Message-ID: <20231004175211.118225963@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit a52d4f657568d6458e873f74a9602e022afe666f upstream.

This is unionized with the actual link flags, so they can of course be
set and they will be evaluated further down. If not we fail any LINKAT
that has to set option flags.

Fixes: cf30da90bc3a ("io_uring: add support for IORING_OP_LINKAT")
Cc: stable@vger.kernel.org
Reported-by: Thomas Leonard <talex5@gmail.com>
Link: https://github.com/axboe/liburing/issues/955
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -4038,7 +4038,7 @@ static int io_linkat_prep(struct io_kioc
 
 	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
-	if (sqe->ioprio || sqe->rw_flags || sqe->buf_index || sqe->splice_fd_in)
+	if (sqe->ioprio || sqe->buf_index || sqe->splice_fd_in)
 		return -EINVAL;
 	if (unlikely(req->flags & REQ_F_FIXED_FILE))
 		return -EBADF;


