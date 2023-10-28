Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBDD7DA57A
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 09:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjJ1H1m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 28 Oct 2023 03:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1H1m (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 28 Oct 2023 03:27:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9DFAF
        for <stable@vger.kernel.org>; Sat, 28 Oct 2023 00:27:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACB8C433C7;
        Sat, 28 Oct 2023 07:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698478059;
        bh=9QhIMSStImYf9zTtzdbgeOGlsqe5CxuQ+TjuXi0vGzo=;
        h=Subject:To:Cc:From:Date:From;
        b=qctPcw54HN1u0/iLJFy8hkr1JasnbhJ76EoLwMTchnCaTIGHES2SRwWU267/J3mu6
         L7EwzEa7ijfm+4aE7QfEhU3t5L/1VE6WuzUeBSlx0OBr3UTGkCf3Xj/4SrAvGAqWwF
         Ur8HoP4ySyFavZnY2wgqwrpKlaSXkU21maKRLtvk=
Subject: FAILED: patch "[PATCH] io_uring/fdinfo: lock SQ thread while retrieving thread" failed to apply to 6.1-stable tree
To:     axboe@kernel.dk, krisman@suse.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 28 Oct 2023 09:27:35 +0200
Message-ID: <2023102835-margarine-credibly-e8ca@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7644b1a1c9a7ae8ab99175989bfc8676055edb46
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102835-margarine-credibly-e8ca@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7644b1a1c9a7ae8ab99175989bfc8676055edb46 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Sat, 21 Oct 2023 12:30:29 -0600
Subject: [PATCH] io_uring/fdinfo: lock SQ thread while retrieving thread
 cpu/pid

We could race with SQ thread exit, and if we do, we'll hit a NULL pointer
dereference when the thread is cleared. Grab the SQPOLL data lock before
attempting to get the task cpu and pid for fdinfo, this ensures we have a
stable view of it.

Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218032
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index c53678875416..f04a43044d91 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -53,7 +53,6 @@ static __cold int io_uring_show_cred(struct seq_file *m, unsigned int id,
 __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *f)
 {
 	struct io_ring_ctx *ctx = f->private_data;
-	struct io_sq_data *sq = NULL;
 	struct io_overflow_cqe *ocqe;
 	struct io_rings *r = ctx->rings;
 	unsigned int sq_mask = ctx->sq_entries - 1, cq_mask = ctx->cq_entries - 1;
@@ -64,6 +63,7 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *f)
 	unsigned int cq_shift = 0;
 	unsigned int sq_shift = 0;
 	unsigned int sq_entries, cq_entries;
+	int sq_pid = -1, sq_cpu = -1;
 	bool has_lock;
 	unsigned int i;
 
@@ -143,13 +143,19 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *f)
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

