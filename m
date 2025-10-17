Return-Path: <stable+bounces-186732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2687BBE9D1A
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F896E681A
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BFE32E155;
	Fri, 17 Oct 2025 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DIDVcqe/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8332E14D;
	Fri, 17 Oct 2025 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714079; cv=none; b=Mus/Cv5ed72K4w1s9k/BjrBHSn3LAXGU0vA6tW3/r6ImPFjLUi3tPxF7DvftYUjKvkLW186foAMXFLNDl69TS/BmkTDkjBEtsefA6J/LBulOpFQDqUQuVL6oM5DfjHM0px5b2LcFc7ECghG5BUz6ukRyZpbTm0nWAEszSez3I70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714079; c=relaxed/simple;
	bh=esOiWYu9JxgqvuxwQdJRm+E6lcLXG0V/syg8fxVSePk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fft5Ns4i7OowBNSlcvpq1Giq4niKGFa9woku52HvRlYR0q9H8piEMhgvOplYqRBS/HqA2wanRzB0V/+19A8jn5e4LvI5TmcGXR3lZ6NUc5pkdVIUitRVIAMxDR+FeH91nhrg+hUJxZqjSqZJWtOdyA5N+KzMOMP/Oskrhk7hkXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DIDVcqe/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33D0C116B1;
	Fri, 17 Oct 2025 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714079;
	bh=esOiWYu9JxgqvuxwQdJRm+E6lcLXG0V/syg8fxVSePk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DIDVcqe/+D8VPdI6plSZuWFnqzRsnIrmlmxNyFnr3xqertIVahL/uMEP6Ou6SntXx
	 yQg2+AVGZw6OkWyLvl/2O1Ycaz/i2iYNOHAbKjAaZYgjEt+TnpmJrCF4LgA4hPiSg0
	 PO+DCaLiIYY8jZa+81+/f9SyIXQoTV+8dC/r5y5Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.12 002/277] fscontext: do not consume log entries when returning -EMSGSIZE
Date: Fri, 17 Oct 2025 16:50:09 +0200
Message-ID: <20251017145147.232638275@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksa Sarai <cyphar@cyphar.com>

commit 72d271a7baa7062cb27e774ac37c5459c6d20e22 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fsopen.c |   70 ++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

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
-
-	ret = mutex_lock_interruptible(&fc->uapi_mutex);
-	if (ret < 0)
-		return ret;
-
-	if (log->head == log->tail) {
-		mutex_unlock(&fc->uapi_mutex);
-		return -ENODATA;
-	}
+	int n;
 
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



