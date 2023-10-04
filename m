Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C487B88E4
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbjJDSUi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbjJDSUh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:20:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1845698
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:20:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3D7C433C8;
        Wed,  4 Oct 2023 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443633;
        bh=9jaluEczDjdhsa1kr2CYofKkK74yGoeH8HmSHE1ZWJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n65QLA/ZQLVIhRSi0U3FzZOroFb7brd8zhkl5McfwoGbk7xuFnoGgNZYx+SL/qMhE
         4jGuPYIOcZs6ey6AzSr5xjJMzD3r6cPF5Ce5I3z6lLERsxlGCa1SZo98uGCZ4Y/Ow6
         zAjEfFIPtJ7gOjVB+uuVDji0nM7W66BzmNdBot9k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Leonard <talex5@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 226/259] io_uring/fs: remove sqe->rw_flags checking from LINKAT
Date:   Wed,  4 Oct 2023 19:56:39 +0200
Message-ID: <20231004175227.720245270@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
 io_uring/fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/io_uring/fs.c
+++ b/io_uring/fs.c
@@ -243,7 +243,7 @@ int io_linkat_prep(struct io_kiocb *req,
 	struct io_link *lnk = io_kiocb_to_cmd(req, struct io_link);
 	const char __user *oldf, *newf;
 
-	if (sqe->rw_flags || sqe->buf_index || sqe->splice_fd_in)
+	if (sqe->buf_index || sqe->splice_fd_in)
 		return -EINVAL;
 	if (unlikely(req->flags & REQ_F_FIXED_FILE))
 		return -EBADF;


