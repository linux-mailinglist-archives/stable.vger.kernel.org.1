Return-Path: <stable+bounces-185795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D85E8BDE10E
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 12:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 852C13556A4
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A2631B803;
	Wed, 15 Oct 2025 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U5in4/xl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FF31BCAB
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525086; cv=none; b=gUGugc60LIGWmZc+jE1w3NHPQhPQ1SSLrBqR7EIybRZMAXdVz8dmmyzvhRfpNKP6IZfp1xOwhLtxrn5ix95pMAu7sn3Z6nmORZhQTC+QbkGfTuJQQ8bnkUqDGHXNuHILtARmqcoeFibI5y7Kz57NKUGQ11RqvqhT2Dfc/7DZy5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525086; c=relaxed/simple;
	bh=IkdrhjP2TeVAiIBvyYPNhQRcEZbz/IcIoTnOEx+Y2ww=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y17mKus83wfwgQ6Kl8aI+U5kJk4dGkEcxSz9L6W4UOt6glgGnniv6KWvy02sxDxsKOnhjoL8iNr2KjzW1nLIEZnjrTVwMVrVKZ/VhLKmo2NAfF9c4z5rvriY0ARiQJUbbPjydqsV6bNSt84kV+6ecbPvv+MnYDVRmbQnoY6iNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U5in4/xl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65DBC4CEF8;
	Wed, 15 Oct 2025 10:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760525086;
	bh=IkdrhjP2TeVAiIBvyYPNhQRcEZbz/IcIoTnOEx+Y2ww=;
	h=Subject:To:Cc:From:Date:From;
	b=U5in4/xl2FNA5voiEeqEFkRaSeSl9h+F3F85MYFyQhdyVzY5bkkAHyh363zF3To/Q
	 woouI0Bg8LD1mcz2k696y/8Sp08uDGEpuJbSos/LlQNg1T0O//N8CGUcbj4vSejklL
	 rUgc5beHtiZnSE7Gl/67Gl6f6yIIIbsr6tsw6wvE=
Subject: FAILED: patch "[PATCH] fscontext: do not consume log entries when returning" failed to apply to 5.15-stable tree
To: cyphar@cyphar.com,brauner@kernel.org,dhowells@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Oct 2025 12:44:43 +0200
Message-ID: <2025101543-quake-judicial-9e2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 72d271a7baa7062cb27e774ac37c5459c6d20e22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101543-quake-judicial-9e2e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72d271a7baa7062cb27e774ac37c5459c6d20e22 Mon Sep 17 00:00:00 2001
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 7 Aug 2025 03:55:23 +1000
Subject: [PATCH] fscontext: do not consume log entries when returning
 -EMSGSIZE

Userspace generally expects APIs that return -EMSGSIZE to allow for them
to adjust their buffer size and retry the operation. However, the
fscontext log would previously clear the message even in the -EMSGSIZE
case.

Given that it is very cheap for us to check whether the buffer is too
small before we remove the message from the ring buffer, let's just do
that instead. While we're at it, refactor some fscontext_read() into a
separate helper to make the ring buffer logic a bit easier to read.

Fixes: 007ec26cdc9f ("vfs: Implement logging through fs_context")
Cc: David Howells <dhowells@redhat.com>
Cc: stable@vger.kernel.org # v5.2+
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Link: https://lore.kernel.org/20250807-fscontext-log-cleanups-v3-1-8d91d6242dc3@cyphar.com
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 1aaf4cb2afb2..f645c99204eb 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -18,50 +18,56 @@
 #include "internal.h"
 #include "mount.h"
 
+static inline const char *fetch_message_locked(struct fc_log *log, size_t len,
+					       bool *need_free)
+{
+	const char *p;
+	int index;
+
+	if (unlikely(log->head == log->tail))
+		return ERR_PTR(-ENODATA);
+
+	index = log->tail & (ARRAY_SIZE(log->buffer) - 1);
+	p = log->buffer[index];
+	if (unlikely(strlen(p) > len))
+		return ERR_PTR(-EMSGSIZE);
+
+	log->buffer[index] = NULL;
+	*need_free = log->need_free & (1 << index);
+	log->need_free &= ~(1 << index);
+	log->tail++;
+
+	return p;
+}
+
 /*
  * Allow the user to read back any error, warning or informational messages.
+ * Only one message is returned for each read(2) call.
  */
 static ssize_t fscontext_read(struct file *file,
 			      char __user *_buf, size_t len, loff_t *pos)
 {
 	struct fs_context *fc = file->private_data;
-	struct fc_log *log = fc->log.log;
-	unsigned int logsize = ARRAY_SIZE(log->buffer);
-	ssize_t ret;
-	char *p;
+	ssize_t err;
+	const char *p __free(kfree) = NULL, *message;
 	bool need_free;
-	int index, n;
+	int n;
 
-	ret = mutex_lock_interruptible(&fc->uapi_mutex);
-	if (ret < 0)
-		return ret;
-
-	if (log->head == log->tail) {
-		mutex_unlock(&fc->uapi_mutex);
-		return -ENODATA;
-	}
-
-	index = log->tail & (logsize - 1);
-	p = log->buffer[index];
-	need_free = log->need_free & (1 << index);
-	log->buffer[index] = NULL;
-	log->need_free &= ~(1 << index);
-	log->tail++;
+	err = mutex_lock_interruptible(&fc->uapi_mutex);
+	if (err < 0)
+		return err;
+	message = fetch_message_locked(fc->log.log, len, &need_free);
 	mutex_unlock(&fc->uapi_mutex);
+	if (IS_ERR(message))
+		return PTR_ERR(message);
 
-	ret = -EMSGSIZE;
-	n = strlen(p);
-	if (n > len)
-		goto err_free;
-	ret = -EFAULT;
-	if (copy_to_user(_buf, p, n) != 0)
-		goto err_free;
-	ret = n;
-
-err_free:
 	if (need_free)
-		kfree(p);
-	return ret;
+		p = message;
+
+	n = strlen(message);
+	if (copy_to_user(_buf, message, n))
+		return -EFAULT;
+	return n;
 }
 
 static int fscontext_release(struct inode *inode, struct file *file)


