Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFFE79D316
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 16:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjILOCk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 10:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjILOCj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 10:02:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263CC10D0
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:02:35 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52e297c7c39so7147278a12.2
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527353; x=1695132153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdtkLoX+w5ob14LhXRy+VOaTCqm0oWjRfcaFxvvYWQI=;
        b=oRmWSo2iWYcDYTfu/s9d8qawK13ai6hkI7g/1eTclEaOZL3fM4iDsKqspPvH+AYX0P
         A10x0OQBJvekehXueu+AwveduL+G4Pq1tr2xAgnk16Npiz/j297l3atFpHrAFh09k5n7
         yzpXfPE32xsadnvwteYgot5cWj1/grIcLIBAKz3lsb2pBjQb9/o03HL/QZDO0XxPoMpY
         xNMhrrUaUUV0bDygnw9pZuVdZKyb+LzuqipV7L82fKWBNWTraIqVCOeSj097q3HmabBM
         i87vYFglrKh6/lANTvvlb716P0yY1QMEf9pKiu4N1eXloQ+AG0498hg5XvLB1fhE+oX5
         a9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527353; x=1695132153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdtkLoX+w5ob14LhXRy+VOaTCqm0oWjRfcaFxvvYWQI=;
        b=pmWR2W6ax6WvpeBo1rPyGvnOB6f1igSz8LNm/WmmkosuM5ui31jWbLAPn9maGIKscW
         YM8TSwxuiL2H3l4LTqdeCZg6qfXvbx3KyMgcvNRk12AlO66h0IZeqY2iB42iH7UYAIXd
         nHQ88lm0RoSaHCY+1vnYKq/FPVbLEeVzK1ljbL7Ygpy/bntkNgSFrOOeEQ8vWWby4Svc
         DhPK3CDtYuBr3JwYD49W55pwDAjI1G1rkeggTd1n1Ofobsks6LYUmqIP77w2ZnzbH2d4
         7nBdYMihUpV7kCpeS5Q3/1DwKU+xkRJGO93KerC+L+6esML5UDyBYgbA5eHwjlpdY5bC
         Pb4A==
X-Gm-Message-State: AOJu0YzyvET6b0LSMbgTlAmiZLbQXZFp6HhWORak+IUPP9pDlkEi/4Jb
        Lo+cSLFDh4YrbImTUFWMUbAcUKAgS0I=
X-Google-Smtp-Source: AGHT+IF0losri3uQQvcN2bZG37XtzOyrRvKYXtprDXnOFTPJ8PAqTeWxL5KYXlpuoh/fHcSJTbrLww==
X-Received: by 2002:a17:907:3f99:b0:9a1:d5de:5e3 with SMTP id hr25-20020a1709073f9900b009a1d5de05e3mr12901131ejc.54.1694527353255;
        Tue, 12 Sep 2023 07:02:33 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id pk24-20020a170906d7b800b0098d2d219649sm6997770ejb.174.2023.09.12.07.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:02:32 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com
Subject: [PATCH 2/3] io_uring: break out of iowq iopoll on teardown
Date:   Tue, 12 Sep 2023 15:02:00 +0100
Message-ID: <5acefe363814fb8fcfc4426c0bd2f45ae6418921.1694522363.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694522363.git.asml.silence@gmail.com>
References: <cover.1694522363.git.asml.silence@gmail.com>
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
index fec6b6a409e7..077c9527be37 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -7069,7 +7069,8 @@ static void io_wq_submit_work(struct io_wq_work *work)
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

