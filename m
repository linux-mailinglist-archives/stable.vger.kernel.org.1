Return-Path: <stable+bounces-47177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD588D0CEE
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA4CB20C24
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCA51607AF;
	Mon, 27 May 2024 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ydmv7oQL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1E515FCE9;
	Mon, 27 May 2024 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837869; cv=none; b=AxYphHxKqKwq72FTBBs5g6GMueFlRT9UV9EATWhCmvhbE2PITRixANXv5k+MJJX/0gMwUaEYfzI6FWQYT8lIvaFdqcvvIuc/8mGS44fs8zxeaJDWsU+ee/CSrPJLtpcl9LmWfp/NPzIGv2P6BflzliMhDFbLr5fvcocod6TQu3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837869; c=relaxed/simple;
	bh=qWaHv3AOxFNfOXWTzclFObiHUKrDaV86+qTPG6Q5bww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnLp8Aq8lpeLRHJ+8RINdyiZzNQnudGqChTb/xg8YgfqhomHG4ezcvdnKVyj6MuzTe8pHFPOSNFTOwT4xd/01ZadUeg1CPKWREmhzLEGfcUlYgO7LiKUefiyzft8DdSBq4rI0mdxlgiDk8mlQnGXgQTgB8g4ZekiMglU2YWTluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ydmv7oQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A5AC2BBFC;
	Mon, 27 May 2024 19:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837868;
	bh=qWaHv3AOxFNfOXWTzclFObiHUKrDaV86+qTPG6Q5bww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ydmv7oQLGKPIng/r6cvzd538TmhKfUs0RlPN+09RUqTHUKlYg1Q9hJ1T2evZGxguB
	 XHHe0N+bS8bXH0IQzEKundymsJUnZZJwpqkqyqHAUMY5W9vfhhm4PM6Nw2SdHJWerw
	 Bpb+n4vkGmWxb3y24YeqlZQkZyIv0XCMQRmX8bXE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 135/493] shmem: Fix shmem_rename2()
Date: Mon, 27 May 2024 20:52:17 +0200
Message-ID: <20240527185634.881995353@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit ad191eb6d6942bb835a0b20b647f7c53c1d99ca4 ]

When renaming onto an existing directory entry, user space expects
the replacement entry to have the same directory offset as the
original one.

Link: https://gitlab.alpinelinux.org/alpine/aports/-/issues/15966
Fixes: a2e459555c5f ("shmem: stable directory offsets")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/20240415152057.4605-4-cel@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/libfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index bb6731fa63059..ef700d39f0f35 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -365,6 +365,9 @@ int simple_offset_empty(struct dentry *dentry)
  *
  * Caller provides appropriate serialization.
  *
+ * User space expects the directory offset value of the replaced
+ * (new) directory entry to be unchanged after a rename.
+ *
  * Returns zero on success, a negative errno value on failure.
  */
 int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
@@ -372,8 +375,14 @@ int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
 {
 	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
 	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
+	long new_offset = dentry2offset(new_dentry);
 
 	simple_offset_remove(old_ctx, old_dentry);
+
+	if (new_offset) {
+		offset_set(new_dentry, 0);
+		return simple_offset_replace(new_ctx, old_dentry, new_offset);
+	}
 	return simple_offset_add(new_ctx, old_dentry);
 }
 
-- 
2.43.0




