Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB507DD54E
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376517AbjJaRtT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376531AbjJaRtO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:49:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0E0189
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:49:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9335CC433C9;
        Tue, 31 Oct 2023 17:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774548;
        bh=gp19PSaQSop4kM00JnB7rMmQTj1HseEFfkGNp9qG5LU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJ46aQADzputGFS2nPRbJo0CXrZV2Xx5Xr9rF+XwUViVoxw5qgs/5d0QBkP/kfX7O
         SDY7co+Go9OvfZWGnpxULtSRmjcU7ibZ/P2Vwfvd7qfrVLRSFLblrI7rxZ3H2nLoTU
         n1IBeehmZbI0ELg/dM1qmNG4HnbAwuHvQ6o3xSV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gabriel Krisman Bertazi <krisman@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 083/112] io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid
Date:   Tue, 31 Oct 2023 18:01:24 +0100
Message-ID: <20231031165903.925483686@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 7644b1a1c9a7ae8ab99175989bfc8676055edb46 upstream.

We could race with SQ thread exit, and if we do, we'll hit a NULL pointer
dereference when the thread is cleared. Grab the SQPOLL data lock before
attempting to get the task cpu and pid for fdinfo, this ensures we have a
stable view of it.

Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218032
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/fdinfo.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index 76c279b13aee4..b603a06f7103d 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -49,7 +49,6 @@ static __cold int io_uring_show_cred(struct seq_file *m, unsigned int id,
 static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
 					  struct seq_file *m)
 {
-	struct io_sq_data *sq = NULL;
 	struct io_overflow_cqe *ocqe;
 	struct io_rings *r = ctx->rings;
 	unsigned int sq_mask = ctx->sq_entries - 1, cq_mask = ctx->cq_entries - 1;
@@ -60,6 +59,7 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
 	unsigned int cq_shift = 0;
 	unsigned int sq_shift = 0;
 	unsigned int sq_entries, cq_entries;
+	int sq_pid = -1, sq_cpu = -1;
 	bool has_lock;
 	unsigned int i;
 
@@ -137,13 +137,19 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
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
 		struct file *f = io_file_from_index(&ctx->file_table, i);
-- 
2.42.0



