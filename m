Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF13479D301
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 15:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjILN5t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 09:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjILN5t (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 09:57:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21A710CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:57:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50079d148aeso9660322e87.3
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527063; x=1695131863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c1LeQu01317Q0qq5OkcGMQDNokxTJLkgDXt6L2uJc8=;
        b=apeyNTKu8S9k8pbpKyQjscZO1p2/HAMUhR8IdypQGPUk7aPVA/mLIP5OJyMWj5Wg5r
         ydrSyIY6ogAoIzcLB9aHbDwnbWgbonil990SD3p2KhjE2I2ekEu4UQVR6AkIAnu1ngAX
         rWwZM0y5gvmShliYT9tfNlIGhselerK7ZaoZtZ6wjDRTRLjQDf+POSaULJHCKDr+H0bo
         /Ygq4jc1t8TbR5qbfm4mCOmxkzKvQ5z5e+j5p5G5U20UJhOq/OaV3X9DqpPa/3tiMjOJ
         FVBgeNUdc4uFXbMft95zfGOslQLWArCp6uuk/stISAsHfJ97PlRy1e1kW5m9lnzemI7F
         jurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527063; x=1695131863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3c1LeQu01317Q0qq5OkcGMQDNokxTJLkgDXt6L2uJc8=;
        b=Qm4AKTwnFWFn4cnj6MGjsIYMXcbv7vjmTuAuDwREN/gqXttfu/++aoHiZ0SiPdATCH
         Nr5LJhNInTOtflpBs3wNNYQrVAnVK61L5qHXTtDF7qafaMIhVR/7mHryDmPCWLqg+i5h
         qS0tZn94mU9LQyJpS62JM27rhFPMBASrunGYKnn1qG3CUfcmn63iXk4HZ1qtRySVDOOj
         XRRKY4i2jDVzcrhDahI44rWrALl1ykGtWOnETJZt0kBFspocgMoO57pRWOOma1qZ+9/G
         VE/Sx3bbklRSQF0Jcl1C+tj0mA8xjRyc8MPfjJnRmiSalAZf6inFNwCqHyxsmhCE9SBV
         M81Q==
X-Gm-Message-State: AOJu0YyEkRLkYoSvdLa+LltUNvtWHLYMMe7M1jqwhL4r+E3ykusJENBE
        u3Clu6zuEvCjA084m+0k3s9HWFKNJeA=
X-Google-Smtp-Source: AGHT+IGdnop3Kv5wWXrYqUY20GyGicrtJTt9Ey7uyKIJ183aW7C0QYKDg4XSfozWMhNffnBGCMehcQ==
X-Received: by 2002:a2e:9dc6:0:b0:2b9:daa4:f4b6 with SMTP id x6-20020a2e9dc6000000b002b9daa4f4b6mr9894942ljj.45.1694527062803;
        Tue, 12 Sep 2023 06:57:42 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906805200b0099cadcf13cesm6863182ejw.66.2023.09.12.06.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:57:42 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com
Subject: [PATCH 5/6] io_uring/sqpoll: fix io-wq affinity when IORING_SETUP_SQPOLL is used
Date:   Tue, 12 Sep 2023 14:57:07 +0100
Message-ID: <2134e6af307e20b62a591aa57169277ab2cee0bb.1694486400.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694486400.git.asml.silence@gmail.com>
References: <cover.1694486400.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ upstream commit ebdfefc09c6de7897962769bd3e63a2ff443ebf5 ]

If we setup the ring with SQPOLL, then that polling thread has its
own io-wq setup. This means that if the application uses
IORING_REGISTER_IOWQ_AFF to set the io-wq affinity, we should not be
setting it for the invoking task, but rather the sqpoll task.

Add an sqpoll helper that parks the thread and updates the affinity,
and use that one if we're using SQPOLL.

Fixes: fe76421d1da1 ("io_uring: allow user configurable IO thread CPU affinity")
Cc: stable@vger.kernel.org # 5.10+
Link: https://github.com/axboe/liburing/discussions/884
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/io-wq.c    |  7 +++++--
 io_uring/io-wq.h    |  2 +-
 io_uring/io_uring.c | 29 ++++++++++++++++++-----------
 io_uring/sqpoll.c   | 15 +++++++++++++++
 io_uring/sqpoll.h   |  1 +
 5 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index dc3d4b835622..98ac9dbcec2f 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1350,13 +1350,16 @@ static int io_wq_cpu_offline(unsigned int cpu, struct hlist_node *node)
 	return __io_wq_cpu_online(wq, cpu, false);
 }
 
-int io_wq_cpu_affinity(struct io_wq *wq, cpumask_var_t mask)
+int io_wq_cpu_affinity(struct io_uring_task *tctx, cpumask_var_t mask)
 {
 	int i;
 
+	if (!tctx || !tctx->io_wq)
+		return -EINVAL;
+
 	rcu_read_lock();
 	for_each_node(i) {
-		struct io_wqe *wqe = wq->wqes[i];
+		struct io_wqe *wqe = tctx->io_wq->wqes[i];
 
 		if (mask)
 			cpumask_copy(wqe->cpu_mask, mask);
diff --git a/io_uring/io-wq.h b/io_uring/io-wq.h
index 31cc5cc9048c..2b2a6406dd8e 100644
--- a/io_uring/io-wq.h
+++ b/io_uring/io-wq.h
@@ -50,7 +50,7 @@ void io_wq_put_and_exit(struct io_wq *wq);
 void io_wq_enqueue(struct io_wq *wq, struct io_wq_work *work);
 void io_wq_hash_work(struct io_wq_work *work, void *val);
 
-int io_wq_cpu_affinity(struct io_wq *wq, cpumask_var_t mask);
+int io_wq_cpu_affinity(struct io_uring_task *tctx, cpumask_var_t mask);
 int io_wq_max_workers(struct io_wq *wq, int *new_count);
 bool io_wq_worker_stopped(void);
 
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 7c8e81057eb1..f413ebed81ab 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3835,16 +3835,28 @@ static int io_register_enable_rings(struct io_ring_ctx *ctx)
 	return 0;
 }
 
+static __cold int __io_register_iowq_aff(struct io_ring_ctx *ctx,
+					 cpumask_var_t new_mask)
+{
+	int ret;
+
+	if (!(ctx->flags & IORING_SETUP_SQPOLL)) {
+		ret = io_wq_cpu_affinity(current->io_uring, new_mask);
+	} else {
+		mutex_unlock(&ctx->uring_lock);
+		ret = io_sqpoll_wq_cpu_affinity(ctx, new_mask);
+		mutex_lock(&ctx->uring_lock);
+	}
+
+	return ret;
+}
+
 static __cold int io_register_iowq_aff(struct io_ring_ctx *ctx,
 				       void __user *arg, unsigned len)
 {
-	struct io_uring_task *tctx = current->io_uring;
 	cpumask_var_t new_mask;
 	int ret;
 
-	if (!tctx || !tctx->io_wq)
-		return -EINVAL;
-
 	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
 		return -ENOMEM;
 
@@ -3865,19 +3877,14 @@ static __cold int io_register_iowq_aff(struct io_ring_ctx *ctx,
 		return -EFAULT;
 	}
 
-	ret = io_wq_cpu_affinity(tctx->io_wq, new_mask);
+	ret = __io_register_iowq_aff(ctx, new_mask);
 	free_cpumask_var(new_mask);
 	return ret;
 }
 
 static __cold int io_unregister_iowq_aff(struct io_ring_ctx *ctx)
 {
-	struct io_uring_task *tctx = current->io_uring;
-
-	if (!tctx || !tctx->io_wq)
-		return -EINVAL;
-
-	return io_wq_cpu_affinity(tctx->io_wq, NULL);
+	return __io_register_iowq_aff(ctx, NULL);
 }
 
 static __cold int io_register_iowq_max_workers(struct io_ring_ctx *ctx,
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 6ffa5cf1bbb8..2949959cbe60 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -423,3 +423,18 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 	io_sq_thread_finish(ctx);
 	return ret;
 }
+
+__cold int io_sqpoll_wq_cpu_affinity(struct io_ring_ctx *ctx,
+				     cpumask_var_t mask)
+{
+	struct io_sq_data *sqd = ctx->sq_data;
+	int ret = -EINVAL;
+
+	if (sqd) {
+		io_sq_thread_park(sqd);
+		ret = io_wq_cpu_affinity(sqd->thread->io_uring, mask);
+		io_sq_thread_unpark(sqd);
+	}
+
+	return ret;
+}
diff --git a/io_uring/sqpoll.h b/io_uring/sqpoll.h
index 0c3fbcd1f583..36245f1afa5e 100644
--- a/io_uring/sqpoll.h
+++ b/io_uring/sqpoll.h
@@ -27,3 +27,4 @@ void io_sq_thread_park(struct io_sq_data *sqd);
 void io_sq_thread_unpark(struct io_sq_data *sqd);
 void io_put_sq_data(struct io_sq_data *sqd);
 int io_sqpoll_wait_sq(struct io_ring_ctx *ctx);
+int io_sqpoll_wq_cpu_affinity(struct io_ring_ctx *ctx, cpumask_var_t mask);
-- 
2.41.0

