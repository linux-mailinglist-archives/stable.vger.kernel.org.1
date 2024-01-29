Return-Path: <stable+bounces-16925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E40840F10
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E1D1C230CC
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F2715AAD0;
	Mon, 29 Jan 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ex7CQM0V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB7E15AAC4;
	Mon, 29 Jan 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548380; cv=none; b=oOXNr4J9tnMwl+XvTSD3ShE9agEJE6fvd1vFMUVM20SVesPncW2GGvQC5szx5vldI046aiCZuRFedwzIaJ16j6domWpfFP+AsRFI+tyj8ghMp4O1AjXw7/aIF8txYKLi4rxGWLE0QkLyxst9WT23ncnburZTjCJH3uWIfMN2jIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548380; c=relaxed/simple;
	bh=XWhkfZ+mq65ja5o57tU1juVQHZrfe/mNazKb/TS/1Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpmoy/nkZ6uPgZnVPFVl74quIw+zdd/eNAhC6Ujb/TOu2XS3vrprXj3w8hdF3gU25uIbJps1346sbczvMi7FcTyUKi2w8fLqZqnJpVySYmDt7iW6Fr14Dl7iK+fxfdx1Ap23Dd3RD1laJcazbq3CIARXTNe//9dlL5UHBX/MVpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ex7CQM0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA8BC43394;
	Mon, 29 Jan 2024 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548380;
	bh=XWhkfZ+mq65ja5o57tU1juVQHZrfe/mNazKb/TS/1Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ex7CQM0VFmRJMrGGsQPv56V3+DL/jDCh/gKGxu4BiXFKH6OWQ8WHOAwT0+tkTClD2
	 Ctpg62wa/e4kj6YiLmxTVqM9COc0arA266gI+NduXu+PtdSAuwsNJ0bWgeBQ3le6gV
	 kT8es/EzNILWuEGU5hT/28KTAipWbGOOFWMpc62U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 151/185] fs/pipe: move check to pipe_has_watch_queue()
Date: Mon, 29 Jan 2024 09:05:51 -0800
Message-ID: <20240129170003.439219599@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129165958.589924174@linuxfoundation.org>
References: <20240129165958.589924174@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit b4bd6b4bac8edd61eb8f7b836969d12c0c6af165 ]

This declutters the code by reducing the number of #ifdefs and makes
the watch_queue checks simpler.  This has no runtime effect; the
machine code is identical.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Message-Id: <20230921075755.1378787-2-max.kellermann@ionos.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: e95aada4cb93 ("pipe: wakeup wr_wait after setting max_usage")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pipe.c                 | 12 +++---------
 include/linux/pipe_fs_i.h | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 42c7ff41c2db..e8082ffe5171 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -436,12 +436,10 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
-#ifdef CONFIG_WATCH_QUEUE
-	if (pipe->watch_queue) {
+	if (pipe_has_watch_queue(pipe)) {
 		ret = -EXDEV;
 		goto out;
 	}
-#endif
 
 	/*
 	 * If it wasn't empty we try to merge new data into
@@ -1320,10 +1318,8 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	unsigned int nr_slots, size;
 	long ret = 0;
 
-#ifdef CONFIG_WATCH_QUEUE
-	if (pipe->watch_queue)
+	if (pipe_has_watch_queue(pipe))
 		return -EBUSY;
-#endif
 
 	size = round_pipe_size(arg);
 	nr_slots = size >> PAGE_SHIFT;
@@ -1375,10 +1371,8 @@ struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice)
 
 	if (file->f_op != &pipefifo_fops || !pipe)
 		return NULL;
-#ifdef CONFIG_WATCH_QUEUE
-	if (for_splice && pipe->watch_queue)
+	if (for_splice && pipe_has_watch_queue(pipe))
 		return NULL;
-#endif
 	return pipe;
 }
 
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 28b3c6a67397..1f1e7ae95320 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -124,6 +124,22 @@ struct pipe_buf_operations {
 	bool (*get)(struct pipe_inode_info *, struct pipe_buffer *);
 };
 
+/**
+ * pipe_has_watch_queue - Check whether the pipe is a watch_queue,
+ * i.e. it was created with O_NOTIFICATION_PIPE
+ * @pipe: The pipe to check
+ *
+ * Return: true if pipe is a watch queue, false otherwise.
+ */
+static inline bool pipe_has_watch_queue(const struct pipe_inode_info *pipe)
+{
+#ifdef CONFIG_WATCH_QUEUE
+	return pipe->watch_queue != NULL;
+#else
+	return false;
+#endif
+}
+
 /**
  * pipe_empty - Return true if the pipe is empty
  * @head: The pipe ring head pointer
-- 
2.43.0




