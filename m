Return-Path: <stable+bounces-185832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB21BDF47C
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 17:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271E63A2805
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D476F06B;
	Wed, 15 Oct 2025 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmjCvqdc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1372C11C9
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540762; cv=none; b=i1JRpNOTyqsW2bT8OH01Cc/2xO8DGKNjwNrTCvlax0A7nFxaC6ujmQD1zlQsFG1z80mGE451hNRNvtaxrOjgcfBZ8FB4U2P7NfXJXvJlObfJtFXQxnpJeKeRy4nYwgQWdq0vEetNC3eC7hRW8AVaSdCm1EbMePUNBvbmgin3FEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540762; c=relaxed/simple;
	bh=k0Y2IvKNmT+hapx7I0XJUN2EvODoE4FPWDZFs4KqQ6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9I9BWs9n5aZ6QpTavPwQ967o4dj9rA7s025eYKHT7JYvCrqqNKkS8Jl0uGGGrs0snTTzr6j83kiW6Z0QKImakWPXaAkrjJj8nXqJJehCk00ceBptc2WKR6RyCxrF4cone2riVpxzopr1G1NqnBBEOSrPoSda6kswzmxbS6uLfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmjCvqdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3C3C113D0;
	Wed, 15 Oct 2025 15:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760540760;
	bh=k0Y2IvKNmT+hapx7I0XJUN2EvODoE4FPWDZFs4KqQ6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmjCvqdcfUGGwY6Oen3+Fi4blnN6290QkNklGDfdR1HFnU7cHhi6ZyW0uXRB9Pxlj
	 Ag5bO2Q9GRM1GHKDQpkSZOL6XIGBtedieK8Yp5/cu/7aWEQhgUpE9ZNGa5EVtCFuOL
	 +ApDXBUaF/ooJ4LvQUU8qRcTddDwBN2p2i3BO0KEvbvn3Q6da9eK9oiVRS0QqyMM3k
	 gD4TjljW3kooO5tEeXYfz0ob+fWIkLh5pDWJVBMlQvvnWRY3pcWsILtwlLSHM0UQ8R
	 ryQVTiqKUtL0xhRPDwZeZIyI8VL+sqle212lDPIZ79y4dE58PumiN2DKmLtuXyheMW
	 vHBVMS/9ecxAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] fscontext: do not consume log entries when returning -EMSGSIZE
Date: Wed, 15 Oct 2025 11:05:55 -0400
Message-ID: <20251015150555.1437678-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015150555.1437678-1-sashal@kernel.org>
References: <2025101543-quake-judicial-9e2e@gregkh>
 <20251015150555.1437678-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksa Sarai <cyphar@cyphar.com>

[ Upstream commit 72d271a7baa7062cb27e774ac37c5459c6d20e22 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fsopen.c | 70 +++++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 27a890aa493ab..056466848979c 100644
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
-- 
2.51.0


