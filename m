Return-Path: <stable+bounces-171687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D33B2B54C
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CA02A2C75
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B313596D;
	Tue, 19 Aug 2025 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyZaFJ8n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86926AD9
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563213; cv=none; b=tfkcVufLXI4zfDANLrxLFdICTbzPq4lIBmVagWdCi/EneSdNqWzmqegDwDjNrHjWvkSrWBlMrR9laz/yb1S0MVcVUA9hNg5rQPWET73SHMN6CkNthCaAViiPLKN8jUHIxgPiqnjw8W/v8R+euHxWqonG80E+NCQW+1IKoUCDWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563213; c=relaxed/simple;
	bh=MIDlb6AFtgY3+q/FK6LhqK1IreTO/8WuFbXgcCtStBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rsvx2KE1CQD7qJ3SvmQgKBxsqg8ilF2/Ro+9p8s8qZx8haPETteMLQk4NpF8YUwReaRVjc/W4ksdXhjC1GRqoS4t8N26MdUYw/+eKrZlpJcDik8VDNkFrgER0389cAMOVi0jWIs3sMTmRzuAPxyrgxvlH616mW83h4bMv8KXr6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyZaFJ8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39052C4CEF1;
	Tue, 19 Aug 2025 00:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755563213;
	bh=MIDlb6AFtgY3+q/FK6LhqK1IreTO/8WuFbXgcCtStBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NyZaFJ8nOFfM7GCloNqM78lPE/cJ5tI95BZAmEmmPwoiebsojU1uXa3ASohcJT7Lj
	 5w+eJuoaiBgfWYFwRPuWdf600lmabAlpJQxUQ6iQ9wVvGxu8h1jlyergO3f+kB5GMD
	 zTJO3w885NBdS6Ch/i1+EhscVX4lLMyxY/Kgu1ER3GiFCESohxqtaJ6WIZLpLpbYJv
	 J6qFV1K+QJJs3Xo5eRAYZUhPJoHhagv8AVAK/ENvEn9DcVECXakO7o+2kMRuDzG2VO
	 h9LVlonukSEbxj7UwRfALTNWit+x5cNUgPOnIPrG7Yc70X8pw6Am6JlinFjR+Z+WIs
	 MM29z3BysKaVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 2/2] btrfs: always abort transaction on failure to add block group to free space tree
Date: Mon, 18 Aug 2025 20:26:50 -0400
Message-ID: <20250819002650.221088-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819002650.221088-1-sashal@kernel.org>
References: <2025081808-companion-arson-989c@gregkh>
 <20250819002650.221088-1-sashal@kernel.org>
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
index d976acf33ab1..100142b73b5e 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1415,12 +1415,17 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 	set_bit(BLOCK_GROUP_FLAG_FREE_SPACE_ADDED, &block_group->runtime_flags);
 
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
@@ -1445,9 +1450,6 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
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


