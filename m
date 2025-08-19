Return-Path: <stable+bounces-171689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3DAB2B56D
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB14D6260DD
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D61C120;
	Tue, 19 Aug 2025 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdB6jkuj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D485013FEE
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563946; cv=none; b=OWcwOU5lDNlQcbwH5LD+c05kVuLVQaPdwvcWxDbzED3nKR9RN5JO1J697mxNnEFUDC9SHirHjH4s2KydGdchyB1Pnjxrtkn7Zlo4U3eonH22xDEPCEJ317mhqDYetwpX962/b0jHPnasNywEIo9k3FbXiCgYiWEFxuOv9ELsVwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563946; c=relaxed/simple;
	bh=6l5G46t5v8Z0qIuEh6AgE2qrLq9UvkVAMRFm1xo1c8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mplEwJSIMl6UpIspD5awRnGWbQDxt43ns4u3pECp1KpDA2egcBResuYgxlsETorrJjUVvHffuNwR9w8QwkWUgmDqd5jrLqbfgVB6nD77EcfvtrlpNhSvKccDEHTO8i6ss0YoOHg4z7w7TncQBxsswiF6g2AtR1O5+u2923RN0lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdB6jkuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29479C116B1;
	Tue, 19 Aug 2025 00:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755563946;
	bh=6l5G46t5v8Z0qIuEh6AgE2qrLq9UvkVAMRFm1xo1c8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KdB6jkujAOpsVmmZxYm1HN2I4SofML95ynrh5mbN22V87kMKiBeV1RjL2I3ZqX13r
	 7YQ/hi78Ds1gkjhwhE+NUHmip/hHO41ybg+XbQCQBOiVfBNOF69ALb+uVwsC48WMc+
	 tPZoT9TjpUlpABKk2fTVzyjK6bLb7nxCQc38RCQoFihiYjhuAUx9+4qaAqdR8mwVPl
	 TDBrIh1TIKdNPDItdQ5og3Q6hO2PvIpyuD9YgkCxZPrEJUVYuKNmRSNfsEQKTWzaV+
	 CoKImwdotI6XqRgIwft1M1XMbET/IampquZBWaf0f50HXGEVVv1RF+TY1Y3yieyUp+
	 19oT0NIgUkjiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] btrfs: always abort transaction on failure to add block group to free space tree
Date: Mon, 18 Aug 2025 20:39:03 -0400
Message-ID: <20250819003903.227152-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819003903.227152-1-sashal@kernel.org>
References: <2025081809-unwatched-rejoicing-21e4@gregkh>
 <20250819003903.227152-1-sashal@kernel.org>
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
index 6f5ccb7b7db9..51f286d5d00a 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1379,12 +1379,17 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
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
@@ -1409,9 +1414,6 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
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


