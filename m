Return-Path: <stable+bounces-171684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2D3B2B53A
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FBB1964507
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391281CA81;
	Tue, 19 Aug 2025 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV1ttvGN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B7CA4E
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755562604; cv=none; b=fVJnjDhcDFBjyPOfktCu5H//ShCRqZD1rQWG+i2vh3/tbTf5kjcVRbb4Djvi/St2TomCz4TOa3B/f/4G4qsnsb9zdo2pwyKhYRK6TatMkwZEu9E8PnJ+DqknwDukpoqAAe5R8T4S04GM05yJIefViVZN6ILpagKOlCyz72lOHew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755562604; c=relaxed/simple;
	bh=iYv1c3jodLxRJW6DmbuXAzE8cpcjcRvJ0afeoSdqHDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYLte+USoe3eeejE91/Ne2ciJpG/6eUfWd48HGjhG5qHGHxfw8VL0BFA5lwokNN6gFZnC9q8u6WRlZUzLh53/Z7m18dNHRqQsxNut7AVW5h3nmGhGxNw7GkHBlIF6j2adaKnCnA0cbe0QVlYZhdZGcUePGl7TwCsb4TgGJv7y+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MV1ttvGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E982C116C6;
	Tue, 19 Aug 2025 00:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755562603;
	bh=iYv1c3jodLxRJW6DmbuXAzE8cpcjcRvJ0afeoSdqHDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MV1ttvGNSjXmmj/j8406icMR6qeDDFoIz+9IwxI5Upz4HrmS7Al+hB4tLlx6bo8+f
	 /aUlPjhYvXmkqn9VheAH0ZqWb2JPxeywJopsPHdQZBrPFQ2Qu4y9ZoaCdEz1dwPXdA
	 seMuaF5DZcYHBPF5DHBVwenn7ynO1kHrdySGi26v5QlphpnsASjKCYCebd4cmg8JuK
	 685+Sg+i4NIJ2fX1LvexIgbThsLK2RAEPpNI3lcQ0ORmSNQpI46WIs6HCgYXUCqDA/
	 HieQKSFKcgYbMuMP4BNLoLJuYWut5H4VdtQKvObaN9SPTCLIbHBRcQzJXscIgKWS+j
	 gL6GesY4HIetQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 2/2] btrfs: always abort transaction on failure to add block group to free space tree
Date: Mon, 18 Aug 2025 20:16:39 -0400
Message-ID: <20250819001639.204027-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819001639.204027-1-sashal@kernel.org>
References: <2025081808-unneeded-unstuffed-e294@gregkh>
 <20250819001639.204027-1-sashal@kernel.org>
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
index 11f488c096a6..d37ce8200a10 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1431,12 +1431,17 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
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
@@ -1461,9 +1466,6 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
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


