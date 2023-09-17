Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11A17A38B3
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbjIQTjO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239851AbjIQTiz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:38:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6077F12F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:38:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA15C433C8;
        Sun, 17 Sep 2023 19:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979530;
        bh=46ZZA8owG7T1odFulht/ISNEjQsfMa7qCGjLNTVqitI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtkvHuicy3Q/sxq2v8gCbvVBUIXAbYEx9WjKtvjjeClat0VfZ0Ej+WbVIYi+mhhJi
         yAnvMjxLe1eoeFqtIPp4/t/+i6UmAmhECp3MX7YMn+U19jNhgZTdly7H9ypTGwXtJi
         nUiYFgAOv+ksikq0MXwzdfBQFqVWhJ1Je868EDwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dylan Yudaken <dylany@meta.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 5.10 314/406] io_uring: always lock in io_apoll_task_func
Date:   Sun, 17 Sep 2023 21:12:48 +0200
Message-ID: <20230917191109.591186715@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

From: Dylan Yudaken <dylany@meta.com>

[ upstream commit c06c6c5d276707e04cedbcc55625e984922118aa ]

This is required for the failure case (io_req_complete_failed) and is
missing.

The alternative would be to only lock in the failure path, however all of
the non-error paths in io_poll_check_events that do not do not return
IOU_POLL_NO_ACTION end up locking anyway. The only extraneous lock would
be for the multishot poll overflowing the CQE ring, however multishot poll
would probably benefit from being locked as it will allow completions to
be batched.

So it seems reasonable to lock always.

Signed-off-by: Dylan Yudaken <dylany@meta.com>
Link: https://lore.kernel.org/r/20221124093559.3780686-3-dylany@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    1 +
 1 file changed, 1 insertion(+)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -5571,6 +5571,7 @@ static void io_apoll_task_func(struct io
 	if (ret > 0)
 		return;
 
+	io_tw_lock(req->ctx, locked);
 	io_poll_remove_entries(req);
 	spin_lock(&ctx->completion_lock);
 	hash_del(&req->hash_node);


