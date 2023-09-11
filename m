Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70B079B3D1
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjIKVEs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239502AbjIKOWV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:22:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFC5DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:22:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ECBC433C8;
        Mon, 11 Sep 2023 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442136;
        bh=uK6B+E+MEo2nobXMhOl0ICGnD4aF0mNB5RLoXeypuu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B7YtKr1WTF09XhM/ct3Ej6YOfuehtr77p5UZVsDGbWZ/cvcC9UIKGDU/6XkarbJt7
         yZ7EoHuKn8loGd6/lpixX/4DFXd05ZIF9L2QMVjdq5k5Cc+7I0uThfldKqo5Fx7PjH
         WxXqsLwUJfiBKdsWDLEQgSyrNbyEiWrbaWZhra0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.5 658/739] io_uring: fix false positive KASAN warnings
Date:   Mon, 11 Sep 2023 15:47:37 +0200
Message-ID: <20230911134709.489927597@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

commit 569f5308e54352a12181cc0185f848024c5443e8 upstream.

io_req_local_work_add() peeks into the work list, which can be executed
in the meanwhile. It's completely fine without KASAN as we're in an RCU
read section and it's SLAB_TYPESAFE_BY_RCU. With KASAN though it may
trigger a false positive warning because internal io_uring caches are
sanitised.

Remove sanitisation from the io_uring request cache for now.

Cc: stable@vger.kernel.org
Fixes: 8751d15426a31 ("io_uring: reduce scheduling due to tw")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/c6fbf7a82a341e66a0007c76eefd9d57f2d3ba51.1691541473.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    1 -
 io_uring/io_uring.h |    1 -
 2 files changed, 2 deletions(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -229,7 +229,6 @@ static inline void req_fail_link_node(st
 static inline void io_req_add_to_cache(struct io_kiocb *req, struct io_ring_ctx *ctx)
 {
 	wq_stack_add_head(&req->comp_list, &ctx->submit_state.free_list);
-	kasan_poison_object_data(req_cachep, req);
 }
 
 static __cold void io_ring_ctx_ref_free(struct percpu_ref *ref)
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -354,7 +354,6 @@ static inline struct io_kiocb *io_extrac
 	struct io_kiocb *req;
 
 	req = container_of(ctx->submit_state.free_list.next, struct io_kiocb, comp_list);
-	kasan_unpoison_object_data(req_cachep, req);
 	wq_stack_extract(&ctx->submit_state.free_list);
 	return req;
 }


