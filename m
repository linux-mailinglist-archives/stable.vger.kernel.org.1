Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D8D79D2F1
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 15:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjILN4D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 09:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjILN4D (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 09:56:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDA510CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:55:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-991c786369cso752655866b.1
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694526957; x=1695131757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNATBqQkrzucu4XcmaiQw+FIi05QkAQzXZHaSywWXk0=;
        b=a4g50x7pAZy2F9licYUJz28hGlU6WxraVFx3mgS+dlXHiWwgGdffsCXlmIPfrL53rG
         MO6G0eMdGPNLs0pPgCEmXJGk42WY4FMONdXUFtHf8hHhjTP3u/Y3qS5iL5PNjDvAiG5K
         9vvrWR6YU+bQwdtiTtjem2xCJui+0E3fy5mUnLwHDRKzngJgq8l1aX91IP96CGC9bmuD
         iHY9cSUwXRD4FVVi++jeDPLrNLBk096tO7y8vRcgXJGz73zwbRgNc0q52zWUz36kj9F0
         Vq7P/nz7fMbmeG8vIabxPfvyIh6IUvrSgarufQp6KZKoFAM50hnbpAKpADGFMgjjfVM+
         I/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526957; x=1695131757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNATBqQkrzucu4XcmaiQw+FIi05QkAQzXZHaSywWXk0=;
        b=oHHg3dy6J0YMDz+dP1wnIFf9uNVLrelcgI7omd9oEDdQNgVjk75uatIxaTN1y4wEGp
         8U3YphG8Kl3o0uLZV7imeNYTQjpZzSaprllXOsfHqGywjx6DLMZbciw7IRskEoJovnZu
         boQMzPt0GaT25xS90LcVLilkl3bgXeq87YfU/5yTQByCr3OzuyEmnVfVkyEpgi2tSQ90
         O8GrS0hhzpSDbj9QWSLbhyCZVpJ7B1Jv/UQBynmu0OOixzfe0dKeUtKJ+euTtelBZwjU
         VDTb/ZjeW7HZP0lSWxw6sewh6Z56lWR5IilgLGQ631xCJdnGvPG1o/3wcTGFZDw8idNK
         GyOA==
X-Gm-Message-State: AOJu0Yyn7g49uW6ZubonOtbur5ewsXC28AMXz6+GWcCe64f9iKdtDG/I
        jW5hL9SnhO8mA6qzKzylFSkcpvXcsWY=
X-Google-Smtp-Source: AGHT+IGSK/kruHoc/AfdKdP9wcexN6wg/g0aFeA0BRstEXtaCJhGfRNcIAHP3v7i9BLkL9JJBh6DCQ==
X-Received: by 2002:a17:906:74c5:b0:9aa:1e2f:7a9c with SMTP id z5-20020a17090674c500b009aa1e2f7a9cmr6710336ejl.8.1694526956936;
        Tue, 12 Sep 2023 06:55:56 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id d12-20020a170906344c00b009a5c98fd82asm6802337ejb.81.2023.09.12.06.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:55:56 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com
Subject: [PATCH 1/3] io_uring: cleanup io_aux_cqe() API
Date:   Tue, 12 Sep 2023 14:55:22 +0100
Message-ID: <96a6688caabe6dffc6dd0755e11f41dc6f9729fe.1694479828.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694479828.git.asml.silence@gmail.com>
References: <cover.1694479828.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ upstream commit d86eaed185e9c6052d1ee2ca538f1936ff255887 ]

Everybody is passing in the request, so get rid of the io_ring_ctx and
explicit user_data pass-in. Both the ctx and user_data can be deduced
from the request at hand.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/io_uring.c | 4 +++-
 io_uring/io_uring.h | 2 +-
 io_uring/net.c      | 9 ++++-----
 io_uring/poll.c     | 4 ++--
 io_uring/timeout.c  | 4 ++--
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index d3b36197087a..d31765694d44 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -933,9 +933,11 @@ bool io_post_aux_cqe(struct io_ring_ctx *ctx, u64 user_data, s32 res, u32 cflags
 	return __io_post_aux_cqe(ctx, user_data, res, cflags, true);
 }
 
-bool io_aux_cqe(struct io_ring_ctx *ctx, bool defer, u64 user_data, s32 res, u32 cflags,
+bool io_aux_cqe(const struct io_kiocb *req, bool defer, s32 res, u32 cflags,
 		bool allow_overflow)
 {
+	struct io_ring_ctx *ctx = req->ctx;
+	u64 user_data = req->cqe.user_data;
 	struct io_uring_cqe *cqe;
 	unsigned int length;
 
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 97cfb3f2f06d..ad67bff51465 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -47,7 +47,7 @@ int io_run_task_work_sig(struct io_ring_ctx *ctx);
 void io_req_defer_failed(struct io_kiocb *req, s32 res);
 void io_req_complete_post(struct io_kiocb *req, unsigned issue_flags);
 bool io_post_aux_cqe(struct io_ring_ctx *ctx, u64 user_data, s32 res, u32 cflags);
-bool io_aux_cqe(struct io_ring_ctx *ctx, bool defer, u64 user_data, s32 res, u32 cflags,
+bool io_aux_cqe(const struct io_kiocb *req, bool defer, s32 res, u32 cflags,
 		bool allow_overflow);
 void __io_commit_cqring_flush(struct io_ring_ctx *ctx);
 
diff --git a/io_uring/net.c b/io_uring/net.c
index c8a4b2ac00f7..bd25c1adbf13 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -634,8 +634,8 @@ static inline bool io_recv_finish(struct io_kiocb *req, int *ret,
 	}
 
 	if (!mshot_finished) {
-		if (io_aux_cqe(req->ctx, issue_flags & IO_URING_F_COMPLETE_DEFER,
-			       req->cqe.user_data, *ret, cflags | IORING_CQE_F_MORE, true)) {
+		if (io_aux_cqe(req, issue_flags & IO_URING_F_COMPLETE_DEFER,
+			       *ret, cflags | IORING_CQE_F_MORE, true)) {
 			io_recv_prep_retry(req);
 			return false;
 		}
@@ -1308,7 +1308,6 @@ int io_accept_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 int io_accept(struct io_kiocb *req, unsigned int issue_flags)
 {
-	struct io_ring_ctx *ctx = req->ctx;
 	struct io_accept *accept = io_kiocb_to_cmd(req, struct io_accept);
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 	unsigned int file_flags = force_nonblock ? O_NONBLOCK : 0;
@@ -1358,8 +1357,8 @@ int io_accept(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (ret < 0)
 		return ret;
-	if (io_aux_cqe(ctx, issue_flags & IO_URING_F_COMPLETE_DEFER,
-		       req->cqe.user_data, ret, IORING_CQE_F_MORE, true))
+	if (io_aux_cqe(req, issue_flags & IO_URING_F_COMPLETE_DEFER, ret,
+		       IORING_CQE_F_MORE, true))
 		goto retry;
 
 	return -ECANCELED;
diff --git a/io_uring/poll.c b/io_uring/poll.c
index a78b8af7d9ab..b57e5937573d 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -300,8 +300,8 @@ static int io_poll_check_events(struct io_kiocb *req, struct io_tw_state *ts)
 			__poll_t mask = mangle_poll(req->cqe.res &
 						    req->apoll_events);
 
-			if (!io_aux_cqe(req->ctx, ts->locked, req->cqe.user_data,
-					mask, IORING_CQE_F_MORE, false)) {
+			if (!io_aux_cqe(req, ts->locked, mask,
+					IORING_CQE_F_MORE, false)) {
 				io_req_set_res(req, mask, 0);
 				return IOU_POLL_REMOVE_POLL_USE_RES;
 			}
diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 350eb830b485..fb0547b35dcd 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -73,8 +73,8 @@ static void io_timeout_complete(struct io_kiocb *req, struct io_tw_state *ts)
 
 	if (!io_timeout_finish(timeout, data)) {
 		bool filled;
-		filled = io_aux_cqe(ctx, ts->locked, req->cqe.user_data, -ETIME,
-				    IORING_CQE_F_MORE, false);
+		filled = io_aux_cqe(req, ts->locked, -ETIME, IORING_CQE_F_MORE,
+				    false);
 		if (filled) {
 			/* re-arm timer */
 			spin_lock_irq(&ctx->timeout_lock);
-- 
2.41.0

