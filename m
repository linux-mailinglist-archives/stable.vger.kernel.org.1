Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3161F79D300
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 15:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbjILN5s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 09:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjILN5r (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 09:57:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9B710CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:57:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99357737980so705668266b.2
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527062; x=1695131862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPPsnkXdTjp+WkpoVcm+wA/DxoOzXzoR14ynvIOU62k=;
        b=J4lg+wz2IBBy41UHbLQuHKTEDtCZT5bVYAKFNBqgKOQ5eHZwiBla+ghNKQlRlQ1nAT
         tCCX1qElRVn0F64HUDw88syBY6Flg56OL1+Ux40XxIjg1yQc7R8Pc8/m5Nj3UaGiVvy4
         UV15KgkV9BNUl8eeSaYni9r6B3r8n4Gro9lj6sJ9jy/MlrfS7l1n2MwAYzFhOWSmZpbX
         7Kzi4N522DRHBUfPrPIW2plUBn0XpHeP90oaV43C/hocddHTuv8J/zdsxWHwKxvQyShw
         /lNkqVBJYXJcA0L90VJlCFCNO6xU2P7CoGwER3xBNJHFUssPGwqZq0VQTGx/QJ525cwP
         fSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527062; x=1695131862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPPsnkXdTjp+WkpoVcm+wA/DxoOzXzoR14ynvIOU62k=;
        b=hrkJZKvFiVEXc5CA3OOZPZcvfmPDa/AK0lq9RviTqSPEbLnXdkgrONYPVcdw4zcZo3
         8bbjL19QCEktuLv93zqVLTHhQGh8uhM3r7s1zHvqZQPAHaoKA+oS4VVn9GBNiq/IDSEN
         YgUDM3omL6mJJTnOWulNgdduKXnnyby/eZaJf/D/tg9pru1Vr91U0XtwFk9jd84REBMO
         LM2Euz3OfXul9u2iG0TQnCOaQZSOwcbQJ05wOrMoWWNsRx7wVgU0MfqvNZxpH/WGGwUD
         QZThSE/EMYy+5gbgkCvW03IAIZEi7cmf7+J8GGJ9QumobJY6I/QZVH8Bijhz/HIbmgp4
         /iSg==
X-Gm-Message-State: AOJu0Yz4yPs5wN4p8fYiJWQz/d77GnsIK6Fogv07/NqcZ89ib/uGo6Sp
        AOpmHaEUw37w7gnN8Anjo1+Gr9SglHA=
X-Google-Smtp-Source: AGHT+IFfvG4LV9U6WF6YQm+Y36i2fjGT/MlgVxg9q/dN6owDETAoRg+LHqrU9kgmsVMLc5RTWpQmxg==
X-Received: by 2002:a17:906:2d0:b0:9a1:bd53:b23 with SMTP id 16-20020a17090602d000b009a1bd530b23mr10898649ejk.14.1694527061791;
        Tue, 12 Sep 2023 06:57:41 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906805200b0099cadcf13cesm6863182ejw.66.2023.09.12.06.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:57:41 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com
Subject: [PATCH 4/6] io_uring: break out of iowq iopoll on teardown
Date:   Tue, 12 Sep 2023 14:57:06 +0100
Message-ID: <41ad5b3374b9831935b59e0899f5a6f32463fbd2.1694486400.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694486400.git.asml.silence@gmail.com>
References: <cover.1694486400.git.asml.silence@gmail.com>
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
 io_uring/io_uring.c |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 411bb2d1acd4..dc3d4b835622 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -181,6 +181,16 @@ static void io_worker_ref_put(struct io_wq *wq)
 		complete(&wq->worker_done);
 }
 
+bool io_wq_worker_stopped(void)
+{
+	struct io_worker *worker = current->worker_private;
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
index 31228426d192..31cc5cc9048c 100644
--- a/io_uring/io-wq.h
+++ b/io_uring/io-wq.h
@@ -52,6 +52,7 @@ void io_wq_hash_work(struct io_wq_work *work, void *val);
 
 int io_wq_cpu_affinity(struct io_wq *wq, cpumask_var_t mask);
 int io_wq_max_workers(struct io_wq *wq, int *new_count);
+bool io_wq_worker_stopped(void);
 
 static inline bool io_wq_is_hashed(struct io_wq_work *work)
 {
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 6d455e2428b9..7c8e81057eb1 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1823,6 +1823,8 @@ void io_wq_submit_work(struct io_wq_work *work)
 		if (!needs_poll) {
 			if (!(req->ctx->flags & IORING_SETUP_IOPOLL))
 				break;
+			if (io_wq_worker_stopped())
+				break;
 			cond_resched();
 			continue;
 		}
-- 
2.41.0

