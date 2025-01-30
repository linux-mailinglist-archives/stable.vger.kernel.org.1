Return-Path: <stable+bounces-111319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74943A22E73
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FD01886B69
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D5A1E3775;
	Thu, 30 Jan 2025 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ipO2avnR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7AFC13D;
	Thu, 30 Jan 2025 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245665; cv=none; b=j/OYCQgKDR+QTyTruvIaeB+EYcjpBXX08Jp0Bjrv+uoHbMh9MDs2RNO15Yy6i+SIkjvRLYExA+rjfbD+XUEPeg+H6i1O+SGK08snxJQ5q8hD7C2X6SPV6wK12shjZzhlWKdfmDrs2gn9YzsgCm04MMYJhFoPlPPFE/cSkWGx/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245665; c=relaxed/simple;
	bh=zE6a5SHmXazMrEX+gdVZe9ivl0SwhxzDs84juOBW/tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AO3cQaRKoybnHDHDXovDZXg7EjlVXH6OwaHalGooC1kgFF/nLObgKEXfg8LHyaIu9+Hs1qUzW6JlGH2iFiX5oYS1dCetxNrhqy1lEFHWHu7whk2gO52JzwlCFjP4e82K5vQSfs2c3g1zNrRTcUCbjIuu7n/425o9Bqiip1hRzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ipO2avnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8887EC4CEE0;
	Thu, 30 Jan 2025 14:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738245664;
	bh=zE6a5SHmXazMrEX+gdVZe9ivl0SwhxzDs84juOBW/tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ipO2avnRx4FpCINEY6nMc24B0QFB95/wQvmN39FPOyh35oq2KsEdL6PdN0HEa7dWI
	 CNs0mDEtr+v3KpvVtI2rD1udaQDdH79OomqTq8GN9yrErYOcfbVSULQPkWpxY2rEtu
	 4n7C2n4oHEoPHAV9yvfCG5czMhzOwgUp8F9qms0I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Yang Erkun <yangerkun@huawei.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.12 19/40] Revert "libfs: Add simple_offset_empty()"
Date: Thu, 30 Jan 2025 14:59:19 +0100
Message-ID: <20250130133500.482477799@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130133459.700273275@linuxfoundation.org>
References: <20250130133459.700273275@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Chuck Lever <chuck.lever@oracle.com>

commit d7bde4f27ceef3dc6d72010a20d4da23db835a32 upstream.

simple_empty() and simple_offset_empty() perform the same task.
The latter's use as a canary to find bugs has not found any new
issues. A subsequent patch will remove the use of the mtree for
iterating directory contents, so revert back to using a similar
mechanism for determining whether a directory is indeed empty.

Only one such mechanism is ever needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/20241228175522.1854234-3-cel@kernel.org
Reviewed-by: Yang Erkun <yangerkun@huawei.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/libfs.c         |   32 --------------------------------
 include/linux/fs.h |    1 -
 mm/shmem.c         |    4 ++--
 3 files changed, 2 insertions(+), 35 deletions(-)

--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -326,38 +326,6 @@ void simple_offset_remove(struct offset_
 }
 
 /**
- * simple_offset_empty - Check if a dentry can be unlinked
- * @dentry: dentry to be tested
- *
- * Returns 0 if @dentry is a non-empty directory; otherwise returns 1.
- */
-int simple_offset_empty(struct dentry *dentry)
-{
-	struct inode *inode = d_inode(dentry);
-	struct offset_ctx *octx;
-	struct dentry *child;
-	unsigned long index;
-	int ret = 1;
-
-	if (!inode || !S_ISDIR(inode->i_mode))
-		return ret;
-
-	index = DIR_OFFSET_MIN;
-	octx = inode->i_op->get_offset_ctx(inode);
-	mt_for_each(&octx->mt, child, index, LONG_MAX) {
-		spin_lock(&child->d_lock);
-		if (simple_positive(child)) {
-			spin_unlock(&child->d_lock);
-			ret = 0;
-			break;
-		}
-		spin_unlock(&child->d_lock);
-	}
-
-	return ret;
-}
-
-/**
  * simple_offset_rename - handle directory offsets for rename
  * @old_dir: parent directory of source entry
  * @old_dentry: dentry of source entry
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3434,7 +3434,6 @@ struct offset_ctx {
 void simple_offset_init(struct offset_ctx *octx);
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
-int simple_offset_empty(struct dentry *dentry);
 int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
 			 struct inode *new_dir, struct dentry *new_dentry);
 int simple_offset_rename_exchange(struct inode *old_dir,
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3700,7 +3700,7 @@ static int shmem_unlink(struct inode *di
 
 static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	if (!simple_offset_empty(dentry))
+	if (!simple_empty(dentry))
 		return -ENOTEMPTY;
 
 	drop_nlink(d_inode(dentry));
@@ -3757,7 +3757,7 @@ static int shmem_rename2(struct mnt_idma
 		return simple_offset_rename_exchange(old_dir, old_dentry,
 						     new_dir, new_dentry);
 
-	if (!simple_offset_empty(new_dentry))
+	if (!simple_empty(new_dentry))
 		return -ENOTEMPTY;
 
 	if (flags & RENAME_WHITEOUT) {



