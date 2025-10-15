Return-Path: <stable+bounces-185850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E795BE03B4
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 20:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FAC401132
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 18:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E42227E05F;
	Wed, 15 Oct 2025 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2kR4PAF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD9F3254B3
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553872; cv=none; b=RQAzwuu86i1Sh1CGiwRn5HTlvkUZ91vcZo+naVk401ZxdQm4vwGyKBNsS3wkNmWdWIuKUGrxAQ4lNfNaj0c7emTKm3hQDsEvmdKyQOGjpkE/HgRHvn6N751PrM2XvzNm4CVV5OFCdENvIKsy85joDZiUKDCXgWyFGRLIcvSMMRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553872; c=relaxed/simple;
	bh=k0Y2IvKNmT+hapx7I0XJUN2EvODoE4FPWDZFs4KqQ6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QC40Du3BDrQXOOygHoM4H+xvxYTv0Z9ef5rfSsvCchIkJIffBaDCaw7SzhiTuQKXmmRzIYnB1c4yaIEe6pC16H5jCBLCBs+wh04rYb2xCh7WLE4vOl+m9+OWkRHErrfc4Hnc/9BI3GYHp0doni1ZcUDgLo62jnyJO/yDfDkURE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2kR4PAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E14C4CEF8;
	Wed, 15 Oct 2025 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760553871;
	bh=k0Y2IvKNmT+hapx7I0XJUN2EvODoE4FPWDZFs4KqQ6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C2kR4PAFKjYV7YLp7lFnCAlGs5YfiekzqjKoOO/Eg7/kt4yrozQBIXeHTPkGvk6Ri
	 8Fg5ph2cWS0sjhVhF+PY8wETQTVdxe0JzivNTs9th7BZHcsB14sPeFMjXYi9fEEtpg
	 6ZvHSqivdFPr8O3xzDlD25avDS9AvRCmVjDkXJYdiuC0ifnGWb2iZM2dQnENEgl4l7
	 8Ko0MoN5peuj8jT1X5xTRypEUwPEjjduOHR9P6q3wDCsYKWz305Uc1N77NIwzK5k6I
	 dLe/CP57nAyshLcjyWIKcSR/95a/tw7gPHLxHs319tgkEI29wQ94QS9DPAQYeC3TNK
	 Q/EcG+i00XMIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] fscontext: do not consume log entries when returning -EMSGSIZE
Date: Wed, 15 Oct 2025 14:44:27 -0400
Message-ID: <20251015184427.1495851-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015184427.1495851-1-sashal@kernel.org>
References: <2025101539-racoon-uneasily-cfd4@gregkh>
 <20251015184427.1495851-1-sashal@kernel.org>
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


