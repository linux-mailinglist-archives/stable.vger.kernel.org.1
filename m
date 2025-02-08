Return-Path: <stable+bounces-114374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04FBA2D4EC
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 09:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108063AB0D8
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 08:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93C19DF6A;
	Sat,  8 Feb 2025 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wVlP0Gtp"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6519C575
	for <stable@vger.kernel.org>; Sat,  8 Feb 2025 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739004476; cv=none; b=m8+0Z81xpOcsZF59jou2CyL1ydTe/+sFnKzD3vtZbab2tlXCyJK6aUhvUzYpYVmJyOsCgYYMQi5+g4md7pNmvYOu/IVE6hOWO4uE04g269uh4AeBihpp10/TI8/rGr/OiVnQ81LrDPVfro8HBD9SKudkWsDfg2w8RWfocqmvngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739004476; c=relaxed/simple;
	bh=z33Wv2yvfklD/bHersSBuRqN3SZEjyC8+00cb19KRGk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=GK643ap76aQdwSL0SXfMiDF6y94YzI5mTj1e0na0i30i9diZjKL9oKwbYHbyIvux5spmnNRI3pLKr5kIen9mlQlAYnGYAD3IMvseY4rJzyO10VmrRDfGrcZEDdjY43Yr3b6gAfkuITeW+LpRgGN6Dr68w5dLZRPu9cSo0ByQdWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wVlP0Gtp; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739004162; bh=xa35FHGH+hKL0dDsszce8LNTvFipAzZjA1Vg6v2oLDg=;
	h=From:To:Cc:Subject:Date;
	b=wVlP0GtpwxoAUV9hJaJ3xLvJCk5/9gHV2fk6+FCxPqLVLXFlpc1QfqW2SpRHV5zNy
	 ilimvBtJjGEWLUkaX2jeHuMqRdsbickWev/dgn28pjOkIBOCL9Ik21eOaG1HQXy8Q0
	 k2wt/xqYK+56gQzdk9dKrxP9H4P9jeHltCH6lw+0=
Received: from public ([120.244.194.36])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id A99966E9; Sat, 08 Feb 2025 16:42:25 +0800
X-QQ-mid: xmsmtpt1739004145tqy8j21cb
Message-ID: <tencent_CA2A6D5D0DDB079164A7B5098E0E0C7CC306@qq.com>
X-QQ-XMAILINFO: MRLc0g//fdpv3DPca3qSQGDkQev8aSvrb/NcqgsqHXMtAPOqXWlWJtjhRJbZvA
	 SoQV4S7Pa21Gwvi91505HX8VurYnufwtHLCEFT2e5/j9x5uSE3W5NVi6WBX1NKpdQRu9CyxTbySI
	 AlYKp6puvZVSal7A6+LczAMILGkI+/s30jL9xeS1zEH9Zc2k1tM/P8eVuzVGTEsCFwPRyOyTM8Fd
	 aXbDuKEL+XSDLuf30HH99aNJrXD4KqlnXYBWWcmb3qHzBaheHHY6lAHAJo91oJVCb37Yf7Cq+JoJ
	 zrcpbVSdDto2noHHkkzAgt8/LiboOuXiTGLGlSYFVCBGNQ7m8PHe9DmUE6Nn1o0EI3FekL20/Fl/
	 isrSyxUrdKFIkQUiA0sUIdrLmFwz6SJLkV5kjk+3i5/fIczy6DevPJQyNz304VqvR4xChJUm3+Pi
	 d/QLSJVz7mPHaKdLpz9a46aNmGnL1mCJ/dnTRKtNGcj89QySm41gcXc0ILVudCEGH0vlEAY4Y2q0
	 Ukq7q4BTT8Vt8caixHmqRjYzvXWJcO1cTt9Y3lGIm9zl61Feua3k0WwZDpgkKLpgwzSVwE2E4IBt
	 sAzNQlsmq6VoobhlWm2hXzbHXiVEnvl9aHdpxUrVi/n+bAXiVRm4exa8MP/GwkUiH6tOVcwWPuRE
	 q0sMmrGhV3s67wUBLy04D8AU9E6G5mqzswh+qf+dmcYCIXnYijyv6bc2Nmw+NbZKdDDjUBOdr7Xr
	 WNdiTNNgCYGqnSQb0EjJcqU/zn2vogja+tb21MurgtJIyrNnqxEPG3WPsuXb+5C1bbv8janLFzgz
	 +5eXMgjMENaG1qTIvJOvdOMHjNvXYKQ1eMqHac/oTtSzVwDZwhhvc0ZTOHyL65qwDal64hDOAwok
	 7VqHqrrHowBPeSaGKbbAgP4gIa/kjEhQBtK+64DG8ESF5/rMXcqjFk+SklAY1DG9J2BFTTPU0c5Q
	 YV9zkc938SNm67RbabO4KloBaHhBOhsETW8AJLMn8=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: lanbincn@qq.com
To: stable@vger.kernel.org
Cc: Zizhi Wo <wozizhi@huawei.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Bin Lan <lanbincn@qq.com>
Subject: [PATCH 6.6.y] cachefiles: Fix NULL pointer dereference in object->file
Date: Sat,  8 Feb 2025 16:42:25 +0800
X-OQ-MSGID: <20250208084225.2467-1-lanbincn@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zizhi Wo <wozizhi@huawei.com>

commit 31ad74b20227ce6b40910ff78b1c604e42975cf1 upstream.

At present, the object->file has the NULL pointer dereference problem in
ondemand-mode. The root cause is that the allocated fd and object->file
lifetime are inconsistent, and the user-space invocation to anon_fd uses
object->file. Following is the process that triggers the issue:

	  [write fd]				[umount]
cachefiles_ondemand_fd_write_iter
				       fscache_cookie_state_machine
					 cachefiles_withdraw_cookie
  if (!file) return -ENOBUFS
					   cachefiles_clean_up_object
					     cachefiles_unmark_inode_in_use
					     fput(object->file)
					     object->file = NULL
  // file NULL pointer dereference!
  __cachefiles_write(..., file, ...)

Fix this issue by add an additional reference count to the object->file
before write/llseek, and decrement after it finished.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Link: https://lore.kernel.org/r/20241107110649.3980193-5-wozizhi@huawei.com
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Bin Lan <lanbincn@qq.com>
---
 fs/cachefiles/interface.c | 14 ++++++++++----
 fs/cachefiles/ondemand.c  | 30 ++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 35ba2117a6f6..3e63cfe15874 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -327,6 +327,8 @@ static void cachefiles_commit_object(struct cachefiles_object *object,
 static void cachefiles_clean_up_object(struct cachefiles_object *object,
 				       struct cachefiles_cache *cache)
 {
+	struct file *file;
+
 	if (test_bit(FSCACHE_COOKIE_RETIRED, &object->cookie->flags)) {
 		if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
 			cachefiles_see_object(object, cachefiles_obj_see_clean_delete);
@@ -342,10 +344,14 @@ static void cachefiles_clean_up_object(struct cachefiles_object *object,
 	}
 
 	cachefiles_unmark_inode_in_use(object, object->file);
-	if (object->file) {
-		fput(object->file);
-		object->file = NULL;
-	}
+
+	spin_lock(&object->lock);
+	file = object->file;
+	object->file = NULL;
+	spin_unlock(&object->lock);
+
+	if (file)
+		fput(file);
 }
 
 /*
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index d1a0264b08a6..3389a373faf6 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -61,20 +61,26 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 {
 	struct cachefiles_object *object = kiocb->ki_filp->private_data;
 	struct cachefiles_cache *cache = object->volume->cache;
-	struct file *file = object->file;
+	struct file *file;
 	size_t len = iter->count;
 	loff_t pos = kiocb->ki_pos;
 	const struct cred *saved_cred;
 	int ret;
 
-	if (!file)
+	spin_lock(&object->lock);
+	file = object->file;
+	if (!file) {
+		spin_unlock(&object->lock);
 		return -ENOBUFS;
+	}
+	get_file(file);
+	spin_unlock(&object->lock);
 
 	cachefiles_begin_secure(cache, &saved_cred);
 	ret = __cachefiles_prepare_write(object, file, &pos, &len, true);
 	cachefiles_end_secure(cache, saved_cred);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	trace_cachefiles_ondemand_fd_write(object, file_inode(file), pos, len);
 	ret = __cachefiles_write(object, file, pos, iter, NULL, NULL);
@@ -83,6 +89,8 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 		kiocb->ki_pos += ret;
 	}
 
+out:
+	fput(file);
 	return ret;
 }
 
@@ -90,12 +98,22 @@ static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
 					    int whence)
 {
 	struct cachefiles_object *object = filp->private_data;
-	struct file *file = object->file;
+	struct file *file;
+	loff_t ret;
 
-	if (!file)
+	spin_lock(&object->lock);
+	file = object->file;
+	if (!file) {
+		spin_unlock(&object->lock);
 		return -ENOBUFS;
+	}
+	get_file(file);
+	spin_unlock(&object->lock);
 
-	return vfs_llseek(file, pos, whence);
+	ret = vfs_llseek(file, pos, whence);
+	fput(file);
+
+	return ret;
 }
 
 static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
-- 
2.43.0


