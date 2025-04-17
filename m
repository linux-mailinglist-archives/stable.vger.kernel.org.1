Return-Path: <stable+bounces-133011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D0BA919A1
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F23E7A6D96
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6885213E63;
	Thu, 17 Apr 2025 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Algrndio"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665F32DFA42
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886835; cv=none; b=OckIHU+2K8rnTGlLkVP1MgfnwNETRpG1b3KNst7qmQCo2b0pch7zl1QaJoHurGPogKZRGDwXFSICzGDGqvrqkQ5TaJNu8MOgA7BwihOQLTyV1corivtNohNQCV3p7D5CJSspGPYoLTDS1i4c6PtLufYw0r3I35AiSGZ+9ccOOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886835; c=relaxed/simple;
	bh=S3FrdqJzBQZnnFwb3t8JL7kCVgRWc+p/dWGqK5H8Xoo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=snd6k1Fs7t+ih8XLTJH5Wh8Ys+fz72FMQ5omrRXh5SKrORuXBrBenX+I99Abtf0bdftzYJEusAelqAPJEu46Me4c4lyWxDFm3kKpaRGuvpMLeJc5nO+6GG5kICm6K7pgCiSHSuTyJLp1FHVgEOLK7H7TFrTfuFAXtojNNnvRjxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Algrndio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBDFC4CEE4;
	Thu, 17 Apr 2025 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744886835;
	bh=S3FrdqJzBQZnnFwb3t8JL7kCVgRWc+p/dWGqK5H8Xoo=;
	h=Subject:To:Cc:From:Date:From;
	b=Algrndio77BKzNZcloOvXMKi5wlJADXqblG5mh5SDvjvhe5UmpoibaTe6rxOueAkF
	 SAkJJm9JmD560lxNWb2QQsOV9gbCNMxywVWjDBOcgLscmU8kDCIm1mguiTLrm72NsK
	 eOIt9Bu1jEWvje/EU8GAi6sq9aZQNRpfZcaqljzw=
Subject: FAILED: patch "[PATCH] io_uring: don't post tag CQEs on file/buffer registration" failed to apply to 6.14-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:47:12 +0200
Message-ID: <2025041712-twine-constrict-d32d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x ab6005f3912fff07330297aba08922d2456dcede
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041712-twine-constrict-d32d@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab6005f3912fff07330297aba08922d2456dcede Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Fri, 4 Apr 2025 15:46:34 +0100
Subject: [PATCH] io_uring: don't post tag CQEs on file/buffer registration
 failure

Buffer / file table registration is all or nothing, if it fails all
resources we might have partially registered are dropped and the table
is killed. If that happens, it doesn't make sense to post any rsrc tag
CQEs. That would be confusing to the application, which should not need
to handle that case.

Cc: stable@vger.kernel.org
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Fixes: 7029acd8a9503 ("io_uring/rsrc: get rid of per-ring io_rsrc_node list")
Link: https://lore.kernel.org/r/c514446a8dcb0197cddd5d4ba8f6511da081cf1f.1743777957.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 5e64a8bb30a4..b36c8825550e 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -175,6 +175,18 @@ void io_rsrc_cache_free(struct io_ring_ctx *ctx)
 	io_alloc_cache_free(&ctx->imu_cache, kfree);
 }
 
+static void io_clear_table_tags(struct io_rsrc_data *data)
+{
+	int i;
+
+	for (i = 0; i < data->nr; i++) {
+		struct io_rsrc_node *node = data->nodes[i];
+
+		if (node)
+			node->tag = 0;
+	}
+}
+
 __cold void io_rsrc_data_free(struct io_ring_ctx *ctx,
 			      struct io_rsrc_data *data)
 {
@@ -583,6 +595,7 @@ int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 	io_file_table_set_alloc_range(ctx, 0, ctx->file_table.data.nr);
 	return 0;
 fail:
+	io_clear_table_tags(&ctx->file_table.data);
 	io_sqe_files_unregister(ctx);
 	return ret;
 }
@@ -902,8 +915,10 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 	}
 
 	ctx->buf_table = data;
-	if (ret)
+	if (ret) {
+		io_clear_table_tags(&ctx->buf_table);
 		io_sqe_buffers_unregister(ctx);
+	}
 	return ret;
 }
 


