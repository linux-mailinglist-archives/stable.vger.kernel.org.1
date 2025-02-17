Return-Path: <stable+bounces-116573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17826A3827A
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 12:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E833AC213
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26EF219A66;
	Mon, 17 Feb 2025 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="cn7eGseI"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FE1C2EF
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793268; cv=none; b=oVGRAgS2POb42ckKI4lx3HVepngfJY4bIOo1ykY/6yGhQ6wW6HNkCJ9ni9duUSL09WqWqZzCRTNlb+Q44Be4liTCr99/3D0C4+JNyKdYysrp3tGC9jkzqs5kuDlAnzPRd1qXlNtHss9xr+F6k6sYnEXLWtbPE0J8qDi751psMkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793268; c=relaxed/simple;
	bh=Ou7nePRxroTuiDKGaYMJaIt89/+wwwGXHEM2WKXbY1k=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=pG7aRlplzKGl2eGGtEHzjXuXoEyX9KSoos0CdP+GN7FLz/w8ksV9q1d8v+9NW/OLMtSB7B0xfBDKieQa0AGiNBMEUIR+H6oWJ6dta5tUYGTQOR3RhnX9slkncs2+Z/NXt3wvYFHCgJGGxJvxijhcmLxb2C5nMGrMhJ5KYWZE0XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=cn7eGseI; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1739793258;
	bh=xrDQl6URn9iFlgHqvuOB8xc5otCb8KhpKUZSAHiLQgo=;
	h=From:To:Cc:Subject:Date;
	b=cn7eGseIEfVMGEIVaDI/1J99xA8r2a862sOsjRE+IAPe9EV1iaZO7502+JG2MAs8i
	 dVEKHdxGJEkA2JH+sUekRd8gl111n5nizEZFNHW1HUrNtc23ft4fJY7vOrXSKcvaF9
	 BKdl+6RQmGXe5EAbBssu2ng9+52MBHfQsoZsu3OU=
Received: from public ([120.244.194.234])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id BF2B84FF; Mon, 17 Feb 2025 19:47:50 +0800
X-QQ-mid: xmsmtpt1739792870tnmpchkrz
Message-ID: <tencent_6D9AAE8F6E49296B401C0C188B06785AAC07@qq.com>
X-QQ-XMAILINFO: NGHdgOcrWZQ96jzqPzsSVO8enQPIJZdiK0YZ/dnfNMra7gKHvgACd0WXrsrmnl
	 kz1VGCLPNu1EmFC5+eIGJdVQUCItD1cf0KVD2nzhF+8FTfaQU/fzi7gUDz4XKxb1HIvZvmSyQEXG
	 Sb07E4v3QGEXQDEDP/9CGoZFMFDnR5nSAkm6hliYPgZ3uu2UpZmxe9etz678aforRyqN7mT2FT/j
	 QixSO1mEAyJDNP+NeLJoQZCU7226CUn0xwbjMWb+xiDgwAGAXyqzM8W5gAxS7M3hxcNmdfaJQtip
	 LfKfeZF0qSoCx3EDwl29hmvqMjfotR86LRf6VueiafBRK82/EkCFy/voNpZ9iBQ6658FlHYWTjuZ
	 BX01SprSrYGSYJchDLVYk9ZoQq7Llt2tPZRibPuAyVIFck1PT+WpAMD9EE22diA/37GOuf/OcvEp
	 Hxit4mMz3/SL2UEiCLkYk/n1k+XjJH6RVGdU3k7+FuQ66J6NN9YvC1edC0UdMBxSzeT7ZSKMrInl
	 pWPo2AdPh5+vlZqTB3Z5qogD5DbmNAwfIJxNPYVO5NG8Cx3Jwm+/TohM8l75Lk/fpxV7rqunJndN
	 rhsjTUeDAPGFfkbURMGUZfDNDZvBdVAADUchBcHLbOBzOQrlT86sZIkHqBisFYvvtEmGKm2E92nR
	 noPeeGiNvw0xxrDvHvt2r13IMzZXQs3+6XlzY51IRN/c5iGW6TY90wo0Ae5wMPSL7KSq4GOtOaNM
	 1bTFGyFWKHYJ4bjZJiOlhn0vLByFI8J/mTNOndrAoTj9jVZqRSzwP8X2SVItUWrJ/QUTbY7uVcET
	 r3waJixnO7U1EbcQYoN/+GKDg/uPqXojFBaJkqzI4eEw6REk7ivnDaEOgJQ/9eqciADUFLKrRmw0
	 fAEX1ySwO2IcXLH7zny/GnBEdvtYxNHaJTrmd1Rl5PFRNiuWpzSqAB6mwE+ZZC5HtQpX/pZ+cfFN
	 0eHYGR7S2DZTNErcs/8oXreZvfl1z8uUMzQyfZAfhpoOaWyL7MFQ==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.15.y] f2fs: fix to wait dio completion
Date: Mon, 17 Feb 2025 19:47:53 +0800
X-OQ-MSGID: <20250217114753.1713-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

commit 96cfeb0389530ae32ade8a48ae3ae1ac3b6c009d upstream.

It should wait all existing dio write IOs before block removal,
otherwise, previous direct write IO may overwrite data in the
block which may be reused by other inode.

Cc: stable@vger.kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 fs/f2fs/file.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b38ce5a7a2ef..685a14309406 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -965,6 +965,13 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 				return err;
 		}
 
+		/*
+		 * wait for inflight dio, blocks should be removed after
+		 * IO completion.
+		 */
+		if (attr->ia_size < old_size)
+			inode_dio_wait(inode);
+
 		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		filemap_invalidate_lock(inode->i_mapping);
 
@@ -1790,6 +1797,12 @@ static long f2fs_fallocate(struct file *file, int mode,
 	if (ret)
 		goto out;
 
+	/*
+	 * wait for inflight dio, blocks should be removed after IO
+	 * completion.
+	 */
+	inode_dio_wait(inode);
+
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
 		if (offset >= inode->i_size)
 			goto out;
-- 
2.43.0


