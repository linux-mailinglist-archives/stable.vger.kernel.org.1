Return-Path: <stable+bounces-171718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA836B2B6E0
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF137525CCD
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB952C3757;
	Tue, 19 Aug 2025 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spfiq03Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C41EB1AA
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569766; cv=none; b=rDoC81XgRW7LmErAef8bVE/DhrwtxtSWNw1co8p+YIN5KV+LVZO9XtK0w2SK3hYGZS4GpAY9UQ1PWd3wpsU5rpGTr31cYZP8a0ezdJbHqNPbDZcjA8/0S6j+E3j9q+7HrCHEqKwlPg5rotdPiVwoMPVB7eJJLmYB4BNbX/wJzm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569766; c=relaxed/simple;
	bh=L5ExybIRmwx0VAxiJxChUGH6Ki7Dvm2ayrt0LJ0OyyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZAx6oekpfFfRvcml4kjfvxMqqYdtDgFWTLkbN1gw7SyTXHSBGxQl1fVRez+UlW58J/QI4/MjZhCF9j+vXvBTg0/J08I4kX0KvVf0pKOPd15gBeo5+OOp99OCUnqMGfK46KUNyhPNzDjkJaa2hveCcgMXrmUEx2RjkeJKliAKRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spfiq03Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD961C116B1;
	Tue, 19 Aug 2025 02:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755569766;
	bh=L5ExybIRmwx0VAxiJxChUGH6Ki7Dvm2ayrt0LJ0OyyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spfiq03ZhQrgcXu2B+sIcnoozBz2UcUuWDXdC8PDXe7N0AbKsljUIZEORvpsylUSp
	 7LTF/dfVH1TNOR9V5QqXHcd5CZTsbL1U3mxfFg9hRchWokLvDAfFe0YCgJX31sAK+8
	 pqnVqfA+majFsnlIy+vCrC3xfph1L5zaq4oXDqPz+Cc4tgME4HF8YaEs9A2qHPEoDP
	 KF6r2nPVVelWqlIOhoMOF2l71rxolub/TvPdT2ohKVcYN/Y5EnXUaibauUttYVango
	 OjV/dpEiDglDL2eqXKy+583ieiBAyW9yHwWDRQA5rwQgqdmCLulvtNNGq0wbW0qWit
	 25io88aAMaKpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/7] btrfs: send: factor out common logic when sending xattrs
Date: Mon, 18 Aug 2025 22:15:55 -0400
Message-ID: <20250819021601.274993-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081827-washed-yelp-3c3e@gregkh>
References: <2025081827-washed-yelp-3c3e@gregkh>
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
index c843b4aefb8a..464c37c2b33d 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4878,11 +4878,19 @@ static int process_all_refs(struct send_ctx *sctx,
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
@@ -4896,6 +4904,8 @@ static int send_set_xattr(struct send_ctx *sctx,
 
 tlv_put_failure:
 out:
+	fs_path_free(path);
+
 	return ret;
 }
 
@@ -4923,19 +4933,13 @@ static int __process_new_xattr(int num, struct btrfs_key *di_key,
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
@@ -4952,15 +4956,7 @@ static int __process_new_xattr(int num, struct btrfs_key *di_key,
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
@@ -5836,7 +5832,6 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
  */
 static int send_capabilities(struct send_ctx *sctx)
 {
-	struct fs_path *fspath = NULL;
 	struct btrfs_path *path;
 	struct btrfs_dir_item *di;
 	struct extent_buffer *leaf;
@@ -5862,25 +5857,19 @@ static int send_capabilities(struct send_ctx *sctx)
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


