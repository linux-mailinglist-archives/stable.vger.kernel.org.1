Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF27E7EA3C9
	for <lists+stable@lfdr.de>; Mon, 13 Nov 2023 20:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjKMTcn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 13 Nov 2023 14:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjKMTcm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 13 Nov 2023 14:32:42 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD85A10DA
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 11:32:39 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6b243dc6aeeso4995109b3a.3
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 11:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699903959; x=1700508759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GT3vPc/tLnO0kk7aDMvVZDA5ydL+LMqnJRb5R7u2Fh4=;
        b=QX/6DxpCa664BzvGkY1FSPJPIIxmaP4ESAPkMT+2NaJS6PaelySIIFFoluz9J4tQrs
         Wdrs3hpJSS5ciGw6u4Xtqc+APuL5pC5FsCmIQVuCzUnloOIo31eeOlS+NwrNIMd3gijv
         lCiotk6EYI1PBqALte1+JtXVAw8DST71UbK56dC3CwnYyqkyz6khB0+wcmRppz5I8ZH5
         pInL+RrPLpn86OeJgfMMx9BVvNnTZ2f5ljl9QlgDDt1Eg8o5Ce0nhif+Ko/mN5MhuD0N
         LHYWx1o2nTT6m9rF94dIuKHFwxry15UC3/psgJRMvgB6YhkM67coXpGcDmMSfuNCutbn
         vh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699903959; x=1700508759;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GT3vPc/tLnO0kk7aDMvVZDA5ydL+LMqnJRb5R7u2Fh4=;
        b=LbMEQNz6pQJCotXH5BEK5SBbp49AF2u1Vkf4/8Qj0PHNrredzlLkH6VD92ozsVGCZq
         2WmOxp9dpQhL6oXz0R4ufLSpWy213+WMiUNfJT8GH5aX6/FtYonytkZeIJvXfIS7zaoV
         h26ZPMHdtL1jBsVnGI2cnXgicwZRMJ9W7rbLDpQIfwdiI18Vbsd9R0bINnSuf8Wbu+UL
         qpZsYKWnjU+pzVtpcdSyvmxm5PRr6Yc45y0jlXGsGw6l+Uzb8mlFpNhfS3IDnGoYG6rs
         mkIotcdxf+dfVEFiR3Kw9EUwgdgOgF5ck/WgC5LzvbopxaEIRlbatjoW9meRqwFHY6j/
         4rYg==
X-Gm-Message-State: AOJu0YyV2+zeueCT81gBgweVXvvcNBUZthC6NXnhVUg67fa813J8/r9s
        c6cMdkSZI+KQy6UVq6CELY5SVMpghzNx1xvpMSKz/zuYQPn8RP6POJERMgn8Y7fh6xgbQhyIn5f
        nLzqf/h/zsw+Mb/KS7ex6NznGfgzPiJ6LSYhv7Tm4zmnrEXluVtdaxnbyrrw=
X-Google-Smtp-Source: AGHT+IEJEseLymP9cfx2ekmOUCGU9sNfhjSGXN+3k33yUFJ/q3Bgsci8o8t7I/vxPdCYbca1+kIX0v6lTA==
X-Received: from hegao.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:394a])
 (user=hegao job=sendgmr) by 2002:a05:6a00:8a81:b0:6c3:36c7:27de with SMTP id
 id1-20020a056a008a8100b006c336c727demr2164769pfb.0.1699903959187; Mon, 13 Nov
 2023 11:32:39 -0800 (PST)
Date:   Mon, 13 Nov 2023 19:32:27 +0000
In-Reply-To: <20231113193227.154296-1-hegao@google.com>
Mime-Version: 1.0
References: <20231113193227.154296-1-hegao@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231113193227.154296-2-hegao@google.com>
Subject: [PATCH 5.15] io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid
From:   He Gao <hegao@google.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        He Gao <hegao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 7644b1a1c9a7ae8ab99175989bfc8676055edb46 ]

We could race with SQ thread exit, and if we do, we'll hit a NULL pointer
dereference when the thread is cleared. Grab the SQPOLL data lock before
attempting to get the task cpu and pid for fdinfo, this ensures we have a
stable view of it.

Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218032
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: He Gao <hegao@google.com>
---
 io_uring/io_uring.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index d00bedfdadbb..e26292d8b845 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -10411,7 +10411,7 @@ static int io_uring_show_cred(struct seq_file *m, unsigned int id,
 
 static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 {
-	struct io_sq_data *sq = NULL;
+	int sq_pid = -1, sq_cpu = -1;
 	bool has_lock;
 	int i;
 
@@ -10424,13 +10424,19 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 	has_lock = mutex_trylock(&ctx->uring_lock);
 
 	if (has_lock && (ctx->flags & IORING_SETUP_SQPOLL)) {
-		sq = ctx->sq_data;
-		if (!sq->thread)
-			sq = NULL;
+		struct io_sq_data *sq = ctx->sq_data;
+
+		if (mutex_trylock(&sq->lock)) {
+			if (sq->thread) {
+				sq_pid = task_pid_nr(sq->thread);
+				sq_cpu = task_cpu(sq->thread);
+			}
+			mutex_unlock(&sq->lock);
+		}
 	}
 
-	seq_printf(m, "SqThread:\t%d\n", sq ? task_pid_nr(sq->thread) : -1);
-	seq_printf(m, "SqThreadCpu:\t%d\n", sq ? task_cpu(sq->thread) : -1);
+	seq_printf(m, "SqThread:\t%d\n", sq_pid);
+	seq_printf(m, "SqThreadCpu:\t%d\n", sq_cpu);
 	seq_printf(m, "UserFiles:\t%u\n", ctx->nr_user_files);
 	for (i = 0; has_lock && i < ctx->nr_user_files; i++) {
 		struct file *f = io_file_from_index(ctx, i);
-- 
2.42.0.869.gea05f2083d-goog

