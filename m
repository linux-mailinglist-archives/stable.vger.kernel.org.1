Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC37EA3D9
	for <lists+stable@lfdr.de>; Mon, 13 Nov 2023 20:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjKMTjx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 13 Nov 2023 14:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMTjx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 13 Nov 2023 14:39:53 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F47CD71
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 11:39:50 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7c97d5d5aso70019127b3.3
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 11:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699904389; x=1700509189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R/68J+WARFu850pKEUUsOf7d0hLLxTS5SQF0qAu0GGQ=;
        b=efbTj49rOOD00xLAAbI8v9GmLTG2Di7CqPac3K/ruLPxUXTI2GDie83zxuvu4Qj0Ks
         skfTozHtLrs6s1Ml0bjrsd2OgG9vymtRJAJnnCCd8yNxop2pML9LNluLW1dcwGN9DiKh
         uFLMsGwl/cevSyxbtWfJNyXirVAWNan8AVuuqMSszaphGZTmqvqiqTd2YC7yFQPoQcPZ
         sT3pi++LGndOQUgApbGRoJmD/8YZcbGgY5r5CA1SCqC+0jNmIfiG9QIKIoPJiJc1DwDh
         BCW/gx9ZrasqOA2Mc9gskG+R4YcDr2iNHYGocY2mxT74zyaj1l7K4hdEsoxwNPsacikx
         EPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699904389; x=1700509189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/68J+WARFu850pKEUUsOf7d0hLLxTS5SQF0qAu0GGQ=;
        b=LsH4Et1yuSER3QqOnOo7JCyiK3NDKF1PKhqosdXrEd9JyivKFvpLIPKTswGBk+N7Y+
         kvOmInszWv5DzTbgPBLC5RZT0p2FCtpGGKSy31KthFOY0VsrLktUE3rwvcqyLgd5mRrI
         rEboeA5hw23ld3qAKv+vRpNNzuXqc8Ox97Pm1rhMmXyj7KHYPXrPBWPMJa2r5x1zlrDG
         Vp43r6Z0zhhGpUNexaNOmyk2h9gHGZT/0E0/O7oZXyMXMM6t13tIgsRntP1jXafiVT6l
         e0Ja0RuNLP6fqajeiuf/Bwif6LD3R/a2kx1MeOEcR2F250wrSX5uUU/+t3aOjjuQWhL4
         64Kg==
X-Gm-Message-State: AOJu0YwfTymD2uCktIApSsgaupyy2qJxDSTSKrSIAmjFo0aEwGgihyZK
        bkRRuh1aMjCBFqEk+DhGRbawO0vetKxKs3w9BqBXV+UvHipA9v3TfxFRQDXYd3rCNVxqF+r7Khm
        pJn395yxS4mdbI+LDt2YeYB2VjmKJE+CJKUMWfk6Vna6xBcUvB13hMzM7oVM=
X-Google-Smtp-Source: AGHT+IFLgZ1kP+DKtn3B9rDMQ0PwgZWoocNl5TOhoqYI3hqEpLPbf5cLTReeFscNDCEmg1zq0IWKKaxCgg==
X-Received: from hegao.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:394a])
 (user=hegao job=sendgmr) by 2002:a0d:d247:0:b0:5a8:28e5:ca68 with SMTP id
 u68-20020a0dd247000000b005a828e5ca68mr200332ywd.5.1699904389485; Mon, 13 Nov
 2023 11:39:49 -0800 (PST)
Date:   Mon, 13 Nov 2023 19:39:40 +0000
In-Reply-To: <20231113193940.156928-1-hegao@google.com>
Mime-Version: 1.0
References: <20231113193940.156928-1-hegao@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231113193940.156928-2-hegao@google.com>
Subject: [PATCH 5.10] io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid
From:   He Gao <hegao@google.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        He Gao <hegao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index 800b5cc385af..1fe05e70cc79 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -10238,7 +10238,7 @@ static int io_uring_show_cred(struct seq_file *m, unsigned int id,
 
 static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 {
-	struct io_sq_data *sq = NULL;
+	int sq_pid = -1, sq_cpu = -1;
 	bool has_lock;
 	int i;
 
@@ -10251,13 +10251,19 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
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

