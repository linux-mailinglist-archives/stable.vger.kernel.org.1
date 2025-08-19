Return-Path: <stable+bounces-171694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A95B2B59D
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75CEC18A4DC6
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0713F3A1D2;
	Tue, 19 Aug 2025 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3BaMBxw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65A3451D0
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755565075; cv=none; b=tKbHob2tWVVdnAEBAc3A6Ov77vUJKBmPNpveJ/T4Z1+ieWKAdy9NUwMzquK/Z7amRBu1A9I1Eua3GDOh1pU02ZDkLx4w5FQX5IYANDqJgIPxtt5w0bQ59Q/7tkcXOylW0+YWoDbV4x39deX2ilzIMxKQY2ib1KIgdZLs018Qb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755565075; c=relaxed/simple;
	bh=SdRVhIqpQ/H19DMFewp5+JWLWEKcj2/7Mv/J+Cu80kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzQbU23QJ4UOT39YR+U2/9qlBmDLQa5XVXeNDa+yca5P1Y82Yd1fU/PF8wQpNZAZumgSVcP3+pTXceYdkxRUn4rlvs3KvdXidlS8Zx6jdeidHLc0YH33hfePabTWq432RPEKOKQ2PaA3OJDXBgb7iokKP6cGduFUlM/1H0ruxjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3BaMBxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DE8C113D0;
	Tue, 19 Aug 2025 00:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755565075;
	bh=SdRVhIqpQ/H19DMFewp5+JWLWEKcj2/7Mv/J+Cu80kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P3BaMBxw37zchNYDhfbVl4l2ow/bdYxUuNRbdbQGiY1xMgGahhB7JFrrZIfDsPl/U
	 ZukNJ36dOm3OG9cPpcVQejXGv2UM5bwX15240W+0UQoE2fVtafCzhSssDjAbv4Xv71
	 1tSSCmQyF1EvRjEs/bJY0TClk+IwSwPSW6W79AZV4vzqDmrNqtAAk2C2Jo+3dClZdQ
	 Sydijo3vmaX3DGQVsOAS9gG+/DGdGIG3f5VfXUB1NV97WIU5zTxJPTLFiSx8Cg3j8M
	 OYSnIjDfpD91mj5NCIen8cPxDQh/yfY7y1Q/sKtWtO1EKvoR/UmiHmnLOhD6vJ0bf2
	 gX7jRJt+nT0Ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] btrfs: always abort transaction on failure to add block group to free space tree
Date: Mon, 18 Aug 2025 20:57:51 -0400
Message-ID: <20250819005751.234544-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819005751.234544-1-sashal@kernel.org>
References: <2025081810-washer-purchase-bdf5@gregkh>
 <20250819005751.234544-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 1f06c942aa709d397cf6bed577a0d10a61509667 ]

Only one of the callers of __add_block_group_free_space() aborts the
transaction if the call fails, while the others don't do it and it's
either never done up the call chain or much higher in the call chain.

So make sure we abort the transaction at __add_block_group_free_space()
if it fails, which brings a couple benefits:

1) If some call chain never aborts the transaction, we avoid having some
   metadata inconsistency because BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE is
   cleared when we enter __add_block_group_free_space() and therefore
   __add_block_group_free_space() is never called again to add the block
   group items to the free space tree, since the function is only called
   when that flag is set in a block group;

2) If the call chain already aborts the transaction, then we get a better
   trace that points to the exact step from __add_block_group_free_space()
   which failed, which is better for analysis.

So abort the transaction at __add_block_group_free_space() if any of its
steps fails.

CC: stable@vger.kernel.org # 6.6+
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/free-space-tree.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index be682925a14a..8efe3a9369df 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1371,12 +1371,17 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 	clear_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags);
 
 	ret = add_new_free_space_info(trans, block_group, path);
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		return ret;
+	}
 
-	return __add_to_free_space_tree(trans, block_group, path,
-					block_group->start,
-					block_group->length);
+	ret = __add_to_free_space_tree(trans, block_group, path,
+				       block_group->start, block_group->length);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
+
+	return 0;
 }
 
 int add_block_group_free_space(struct btrfs_trans_handle *trans,
@@ -1401,9 +1406,6 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
 	}
 
 	ret = __add_block_group_free_space(trans, block_group, path);
-	if (ret)
-		btrfs_abort_transaction(trans, ret);
-
 out:
 	btrfs_free_path(path);
 	mutex_unlock(&block_group->free_space_lock);
-- 
2.50.1


