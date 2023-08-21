Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C82783278
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjHUTxs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjHUTxr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:53:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC78EE
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:53:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A1DA64519
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860EFC433C7;
        Mon, 21 Aug 2023 19:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647624;
        bh=Iu3viuHrJiD6osOJsvUHCqDPOmFtWzz0wIksALaInew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ST+y7kKWkMpfNL2tkN69KaTM3v85nlrPgyKtWae2VSxYaAxki2kW3mrAuu8B4I3kX
         f6Y/ikDFmK/16HSCM2hTgk4qq6jEPlSkbPeXuGTcRiYlCnXtonFA7ueNSKXMXZ5d+K
         ZIlLCIHfxn+cLYLXHxSWHUjeyOWKVHIOjIjhVosA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 081/194] btrfs: convert btrfs_block_group::needs_free_space to runtime flag
Date:   Mon, 21 Aug 2023 21:41:00 +0200
Message-ID: <20230821194126.335620968@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: David Sterba <dsterba@suse.com>

[ Upstream commit 0d7764ff58b4b45c39eb03f2c74a819c1a88fa7b ]

We already have flags in block group to track various status bits,
convert needs_free_space as well and reduce size of btrfs_block_group.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 0657b20c5a76 ("btrfs: fix use-after-free of new block group that became unused")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c                 |  2 +-
 fs/btrfs/block-group.h                 |  8 ++------
 fs/btrfs/free-space-tree.c             | 10 +++++-----
 fs/btrfs/tests/free-space-tree-tests.c |  2 +-
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9f5a971bfed42..a726b532b5277 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2543,7 +2543,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	cache->global_root_id = calculate_global_root_id(fs_info, cache->start);
 
 	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
-		cache->needs_free_space = 1;
+		set_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &cache->runtime_flags);
 
 	ret = btrfs_load_block_group_zone_info(cache, true);
 	if (ret) {
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index debd42aeae0f1..dcad5e959b920 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -55,6 +55,8 @@ enum btrfs_block_group_flags {
 	BLOCK_GROUP_FLAG_CHUNK_ITEM_INSERTED,
 	BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
 	BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+	/* Does the block group need to be added to the free space tree? */
+	BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
 };
 
 enum btrfs_caching_type {
@@ -204,12 +206,6 @@ struct btrfs_block_group {
 	/* Lock for free space tree operations. */
 	struct mutex free_space_lock;
 
-	/*
-	 * Does the block group need to be added to the free space tree?
-	 * Protected by free_space_lock.
-	 */
-	int needs_free_space;
-
 	/* Flag indicating this block group is placed on a sequential zone */
 	bool seq_zone;
 
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index a207db9322264..6a44733a95e1c 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -803,7 +803,7 @@ int __remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 	u32 flags;
 	int ret;
 
-	if (block_group->needs_free_space) {
+	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags)) {
 		ret = __add_block_group_free_space(trans, block_group, path);
 		if (ret)
 			return ret;
@@ -996,7 +996,7 @@ int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
 	u32 flags;
 	int ret;
 
-	if (block_group->needs_free_space) {
+	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags)) {
 		ret = __add_block_group_free_space(trans, block_group, path);
 		if (ret)
 			return ret;
@@ -1350,7 +1350,7 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 {
 	int ret;
 
-	block_group->needs_free_space = 0;
+	clear_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags);
 
 	ret = add_new_free_space_info(trans, block_group, path);
 	if (ret)
@@ -1372,7 +1372,7 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
 		return 0;
 
 	mutex_lock(&block_group->free_space_lock);
-	if (!block_group->needs_free_space)
+	if (!test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags))
 		goto out;
 
 	path = btrfs_alloc_path();
@@ -1405,7 +1405,7 @@ int remove_block_group_free_space(struct btrfs_trans_handle *trans,
 	if (!btrfs_fs_compat_ro(trans->fs_info, FREE_SPACE_TREE))
 		return 0;
 
-	if (block_group->needs_free_space) {
+	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags)) {
 		/* We never added this block group to the free space tree. */
 		return 0;
 	}
diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
index 13734ed43bfcb..766117a76d742 100644
--- a/fs/btrfs/tests/free-space-tree-tests.c
+++ b/fs/btrfs/tests/free-space-tree-tests.c
@@ -470,7 +470,7 @@ static int run_test(test_func_t test_func, int bitmaps, u32 sectorsize,
 	}
 	cache->bitmap_low_thresh = 0;
 	cache->bitmap_high_thresh = (u32)-1;
-	cache->needs_free_space = 1;
+	set_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &cache->runtime_flags);
 	cache->fs_info = root->fs_info;
 
 	btrfs_init_dummy_trans(&trans, root->fs_info);
-- 
2.40.1



