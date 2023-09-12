Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1EB79D31E
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 16:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjILOD1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 10:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbjILOD0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 10:03:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDAE10CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:03:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52e64bc7c10so7399613a12.1
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527401; x=1695132201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyNIM9C/XMs0X4V3zrkH7pEEgLyY9MxvvBvs4w9wSV0=;
        b=JOHmdhzkizvIKF476GYkzhQgUWEPanJNl9mijY1hTDINqULwvC0iSiKJPyN0VlKAmO
         ZrE4hlR/o7J3PQBHi1Bw3stersXlrWIRl5MJ8nZv1UH5/JI611+A3M5G9G9DlAdGL64l
         VP4xFNstBHDDxCgQ5NB2JuY1htIscAYLcNdWmuQeyEgMPAufKd6PGcCRjjaO3ChlT5kA
         HsXmojO8cOOvBKFzhg8+HyhstCqL4EyVCBunaPKZO3l5+qZ7UGPqxun+soidm3nyTBEg
         NXh2zW1tVfo8DyWzR1PV3RFPbLg2ALLgbyl2ot/OSF+rbC5f7R7og9SsCgoWZ60E7GsT
         Ym8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527401; x=1695132201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyNIM9C/XMs0X4V3zrkH7pEEgLyY9MxvvBvs4w9wSV0=;
        b=AoE62ElbbqCauNWn4cJ6aBPT/+3L1DHnlwwDZ8rQNStgeQtJm/txO7QAn9jpjm0zjO
         ZbJBMVCdwEINBHjUVyUTfchd8kwMF/LF4Tcghqr6LDQzeJEAbbZ0umcqNVXTQDzL68d5
         jzbgWCzyIsPHsRhsySUKUUnd37KShEj1y7rVq75q0TVQ7sYWoWYnH8D/6T+cET3KLjSI
         UVQjdQlSa5YVSpeW8SEs60KY9AFSSFnhFcx046HlTYH6PPUtn4JZkYOtzDtgY6jSsgtZ
         nZ+LMRyPdUFsrXI02vL0XSdbJRiGINDskv4IA+yS0R8CBmz+dp0zcLX+d3TFSe75+VOk
         lsjA==
X-Gm-Message-State: AOJu0YwYtLVq4ITbu7USqLXjPZQmFSPUSLX6DEHr1W1jzpiPNrkI/tUK
        MXTpKSiVZtnjF1Z4lQRaUGilJ1pBIzg=
X-Google-Smtp-Source: AGHT+IG5XenvA3rlkU/i2+f5WlU6ykKODugjWAe3Dv+IcLu1smoQnZFBwbINtyljbRef/r2+vC7a1w==
X-Received: by 2002:a17:907:2cf2:b0:99c:55a9:3925 with SMTP id hz18-20020a1709072cf200b0099c55a93925mr9885021ejc.24.1694527400843;
        Tue, 12 Sep 2023 07:03:20 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id ib10-20020a1709072c6a00b009ad8d444be4sm751671ejc.43.2023.09.12.07.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:03:20 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com
Subject: [PATCH 2/3] io_uring: break out of iowq iopoll on teardown
Date:   Tue, 12 Sep 2023 15:02:49 +0100
Message-ID: <649666e4cf7b5b829b12ba14f1648fdba2950d10.1694524751.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694524751.git.asml.silence@gmail.com>
References: <cover.1694524751.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ upstream commit 45500dc4e01c167ee063f3dcc22f51ced5b2b1e9 ]

io-wq will retry iopoll even when it failed with -EAGAIN. If that
races with task exit, which sets TIF_NOTIFY_SIGNAL for all its workers,
such workers might potentially infinitely spin retrying iopoll again and
again and each time failing on some allocation / waiting / etc. Don't
keep spinning if io-wq is dying.

Fixes: 561fb04a6a225 ("io_uring: replace workqueue usage with io-wq")
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io-wq.c    | 10 ++++++++++
 io_uring/io-wq.h    |  1 +
 io_uring/io_uring.c |  3 ++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 81485c1a9879..fe8594a0396c 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -176,6 +176,16 @@ static void io_worker_ref_put(struct io_wq *wq)
 		complete(&wq->worker_done);
 }
 
+bool io_wq_worker_stopped(void)
+{
+	struct io_worker *worker = current->pf_io_worker;
+
+	if (WARN_ON_ONCE(!io_wq_current_is_worker()))
+		return true;
+
+	return test_bit(IO_WQ_BIT_EXIT, &worker->wqe->wq->state);
+}
+
 static void io_worker_cancel_cb(struct io_worker *worker)
 {
 	struct io_wqe_acct *acct = io_wqe_get_acct(worker);
diff --git a/io_uring/io-wq.h b/io_uring/io-wq.h
index bf5c4c533760..48721cbd5f40 100644
--- a/io_uring/io-wq.h
+++ b/io_uring/io-wq.h
@@ -129,6 +129,7 @@ void io_wq_hash_work(struct io_wq_work *work, void *val);
 
 int io_wq_cpu_affinity(struct io_wq *wq, cpumask_var_t mask);
 int io_wq_max_workers(struct io_wq *wq, int *new_count);
+bool io_wq_worker_stopped(void);
 
 static inline bool io_wq_is_hashed(struct io_wq_work *work)
 {
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ca484c4012b5..e5bef0a8e5ea 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -6898,7 +6898,8 @@ static void io_wq_submit_work(struct io_wq_work *work)
 			 */
 			if (ret != -EAGAIN || !(req->ctx->flags & IORING_SETUP_IOPOLL))
 				break;
-
+			if (io_wq_worker_stopped())
+				break;
 			/*
 			 * If REQ_F_NOWAIT is set, then don't wait or retry with
 			 * poll. -EAGAIN is final for that case.
-- 
2.41.0

