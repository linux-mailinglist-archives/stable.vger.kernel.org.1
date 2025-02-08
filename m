Return-Path: <stable+bounces-114373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D18A2D4E9
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 09:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF026162960
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 08:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0961F18B492;
	Sat,  8 Feb 2025 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ArsdlewN"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15048199E8B
	for <stable@vger.kernel.org>; Sat,  8 Feb 2025 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739004317; cv=none; b=Gkzch8FCudVEQaVsbgUxu7b7+Hz3164OS3B1h3k9YEuCe1pC6969CdS0/7a5iYU25pVxF8Mdix8EG5DugK0g1YninmhnJvL7HV1n2cWxxFyWpwbD9chGOOsMGto2v2XcgYCrBv0oqGpuZ6aIc2UCocxEwNYGFl2VeA5O3hhuEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739004317; c=relaxed/simple;
	bh=J5mX84KnrzbDIJ/Zs3E706BBl/ys0tPdax4iGiBbC7E=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=MWbmKEViHjAZt4KF9GCr+55R+UOswZU+A5+v2HdcJ3kqzlWnKIF955X4QwViSdoHgdGiVMwmGdsFb2HbEDCBurEg1WYhX1u2NQCeA09snPPNfO5TxxOo8vqyPC42kaJp0lIvohriAx201aqWCDuHPdzqhK76z9A/Y//ZW9Jaiho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ArsdlewN; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739004309; bh=MmXMjHgydLc4UZXP10Nze/S1FozzldGZhKnHd3Z4RF4=;
	h=From:To:Cc:Subject:Date;
	b=ArsdlewNwd/K20JCCnIa6VI+pY4/NUcJTORbK5NNA75O0SybX1X0VgKQofxvNW6wq
	 FVE5Aymahm7yE5Nvzgrujp1EbesiQ8gNENkdmTRMzOp9bEJ62isblbbliPClc4avsF
	 otmsCGZhc4z8J0qW+0NEyhCBikpLaNcs4Lje0wOQ=
Received: from public ([120.244.194.36])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id AE80A416; Sat, 08 Feb 2025 16:43:40 +0800
X-QQ-mid: xmsmtpt1739004220ta5xu864e
Message-ID: <tencent_88A2019F96BD26EB234812CF7A176706E605@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznbEXmb/9Ji6eDpAmSnDjiVWIjdUn22Ql6qwYXNGelPvSud4XWxB
	 sAj+UfthBe7Z1DSJftF8beQBSm0SNNjXHfRsNyANE5u8F5J8VlnSNIxZXVTooumHIkOoRjitJDS1
	 0GfQsGbCPuP1Ho9py57D2ied0llQ5B70Iwbt8vwNyIZ25MkBKyuJpOO28QQEgjhmEZ1p/wXgG9/j
	 xePxNP3JJxQbwakFh/O+mjcvCzW/VIrf6xTdYPGuFSZszTgdVSlXkqltoMKYEju1n+GIy0NlMdq5
	 sBiDMRQ60Z0oEMFFw1fyXbXqOjVQcCSBIanqSCOldlXB+q0v16LVJr6LKLtvVSzClRaYIUxY3Roy
	 Hh/H8KnmHTPv1aETRtXtnRIvC0Sqm1p8BAoLf8rBBNSdLQ+lv1YPNGDTJ3XmwtDV6gdq52rlz6Sa
	 FMTH+TXUNKCzSKt9wjQsqvY2cE64wvuzDMTpgiSquesnYtuSG2jBJbvN3YDprtu0LDEqRS9KJDIp
	 6xe69wZW9UGAA5cVpuvFFgcxg1o9MfK5a+2QqIKTxqMCO+x+cCgeixQocyVZSwVRUb1+nCXwwa+L
	 fEITID4g7FxiZJVBABbjj65JM6nNunZcXBtjO/DJCEXVG/pvrHphZjniNzIe4tbYmQj6cl8CCtJO
	 bg5Bp8Fy+6k20eN4wEQNeAmERsdHJP/dr36zPlXr1o8GWwrJq5Ap283ldTikhAJs76aMtRC8RtP2
	 AauK4tdluActIf31fIRhsKO7kbbxSX1P+f/ySmPkwESUqzFI49hj7rhEBwoGi+w4ZgoA4fNJX84l
	 P5nueOKtEuGRUQTC9xLpAlmMxU5/JLTyWTFidDGTKte58G7Oq3L2ZcOW87Ap8FCtstYm2QiD9+nR
	 FjHFAa3ZoMoeC36QedU6HYhJw36+n6RTPTnzRhslHitnq8u0fQjgohyYXLSS+uFFH2NXi0AyNJbK
	 Ir10CCFGhqzgi6x4PshJNP7BTvjl3N04InxPQvNNbozg9UV6anH2cAwpDgE5TA82/bhT/9y1mUBv
	 7YO7v2O0AGAKTfgRzfduTXMu5skrI=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: lanbincn@qq.com
To: stable@vger.kernel.org
Cc: Zizhi Wo <wozizhi@huawei.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Bin Lan <lanbincn@qq.com>
Subject: [PATCH 6.1.y] cachefiles: Fix NULL pointer dereference in object->file
Date: Sat,  8 Feb 2025 16:43:39 +0800
X-OQ-MSGID: <20250208084339.2779-1-lanbincn@qq.com>
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
index bde23e156a63..fd71775c703a 100644
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


