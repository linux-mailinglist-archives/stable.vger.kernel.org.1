Return-Path: <stable+bounces-171728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C111FB2B71F
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BCC1B660C0
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1C4218ABD;
	Tue, 19 Aug 2025 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYlwPtu2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7361DA4E
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571222; cv=none; b=Bth/1mEZ3frqtRRy7o0b2Q7LvIRHa0DIBkZPh6yf6XiIB16oVZk2aDnenh3t4Da1589AhhVW0rQ1VUyrdA8W2KFbsMffFXAmqJkdU7QEuYtJrdo8qxbls3XYabiyXS6ruOL04HTXASJqw5u4GDFA6DyiXwY/RTGCejMPOg2XR5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571222; c=relaxed/simple;
	bh=alCnTTcoSxpMY1BCbmWBjgZKFx1Alr9YoigsoZyHAj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lR5saUdIwU/DABGZHoXE3bcHvp5sMtYnEPPiKycxkea9Ez2AhMD322K8dOlM9KBSqFPnCcxeltecByZvaLaXNkTf61GbAS8BrRlWtCNEz3TS6Ww5MSMVqwfH6nqnLcobUKbL6Xk3hcjsxL3L1YTAIzm4s2WRLULkgtXS2hIeMPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYlwPtu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2E7C4CEEB;
	Tue, 19 Aug 2025 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755571222;
	bh=alCnTTcoSxpMY1BCbmWBjgZKFx1Alr9YoigsoZyHAj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MYlwPtu2btZCiBL6eYHBhLOPOahK9b/krSWHVUDS7njiqUSUq9KG8wjdvHfzj29ol
	 LdTV8/yG/W4ym+0Yqv7e8IWitOEoi81m8bfAoPcB8BWfRDZHOpN9n9fgRQ4hFCrw++
	 EjL92t8oPt+7uYv+UTe/wXViKbGFaPADOgEETn6kfY4n08oyQYHdMKxxgzcPnhXPwn
	 CxWs9jrl2QF1wY+sX808oj5F2Ai5W/Nk8tkCb5wyyt5/n2zD0qpJUuz3anzn350EwF
	 aVRVcnaOOA4YIOz+L//RZrRp4y3v6vrr4x1mKMUrjH5bgRXsLKImbeyBa9/h12vyzT
	 kH8CWJARDtE+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/7] btrfs: send: factor out common logic when sending xattrs
Date: Mon, 18 Aug 2025 22:40:14 -0400
Message-ID: <20250819024020.291759-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081840-stomp-enhance-b456@gregkh>
References: <2025081840-stomp-enhance-b456@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 17f6a74d0b89092e38e3328b66eda1ab29a195d4 ]

We always send xattrs for the current inode only and both callers of
send_set_xattr() pass a path for the current inode. So move the path
allocation and computation to send_set_xattr(), reducing duplicated
code. This also facilitates an upcoming patch.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 005b0a0c24e1 ("btrfs: send: use fallocate for hole punching with send stream v2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e2ead36e5be4..bb24c1a00f6e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4879,11 +4879,19 @@ static int process_all_refs(struct send_ctx *sctx,
 }
 
 static int send_set_xattr(struct send_ctx *sctx,
-			  struct fs_path *path,
 			  const char *name, int name_len,
 			  const char *data, int data_len)
 {
-	int ret = 0;
+	struct fs_path *path;
+	int ret;
+
+	path = fs_path_alloc();
+	if (!path)
+		return -ENOMEM;
+
+	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, path);
+	if (ret < 0)
+		goto out;
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_SET_XATTR);
 	if (ret < 0)
@@ -4897,6 +4905,8 @@ static int send_set_xattr(struct send_ctx *sctx,
 
 tlv_put_failure:
 out:
+	fs_path_free(path);
+
 	return ret;
 }
 
@@ -4924,19 +4934,13 @@ static int __process_new_xattr(int num, struct btrfs_key *di_key,
 			       const char *name, int name_len, const char *data,
 			       int data_len, void *ctx)
 {
-	int ret;
 	struct send_ctx *sctx = ctx;
-	struct fs_path *p;
 	struct posix_acl_xattr_header dummy_acl;
 
 	/* Capabilities are emitted by finish_inode_if_needed */
 	if (!strncmp(name, XATTR_NAME_CAPS, name_len))
 		return 0;
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
-
 	/*
 	 * This hack is needed because empty acls are stored as zero byte
 	 * data in xattrs. Problem with that is, that receiving these zero byte
@@ -4953,15 +4957,7 @@ static int __process_new_xattr(int num, struct btrfs_key *di_key,
 		}
 	}
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto out;
-
-	ret = send_set_xattr(sctx, p, name, name_len, data, data_len);
-
-out:
-	fs_path_free(p);
-	return ret;
+	return send_set_xattr(sctx, name, name_len, data, data_len);
 }
 
 static int __process_deleted_xattr(int num, struct btrfs_key *di_key,
@@ -5831,7 +5827,6 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
  */
 static int send_capabilities(struct send_ctx *sctx)
 {
-	struct fs_path *fspath = NULL;
 	struct btrfs_path *path;
 	struct btrfs_dir_item *di;
 	struct extent_buffer *leaf;
@@ -5857,25 +5852,19 @@ static int send_capabilities(struct send_ctx *sctx)
 	leaf = path->nodes[0];
 	buf_len = btrfs_dir_data_len(leaf, di);
 
-	fspath = fs_path_alloc();
 	buf = kmalloc(buf_len, GFP_KERNEL);
-	if (!fspath || !buf) {
+	if (!buf) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, fspath);
-	if (ret < 0)
-		goto out;
-
 	data_ptr = (unsigned long)(di + 1) + btrfs_dir_name_len(leaf, di);
 	read_extent_buffer(leaf, buf, data_ptr, buf_len);
 
-	ret = send_set_xattr(sctx, fspath, XATTR_NAME_CAPS,
+	ret = send_set_xattr(sctx, XATTR_NAME_CAPS,
 			strlen(XATTR_NAME_CAPS), buf, buf_len);
 out:
 	kfree(buf);
-	fs_path_free(fspath);
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.50.1


