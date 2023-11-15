Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B79A7DD51A
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376421AbjJaRrO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376395AbjJaRrN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:47:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7508FA6
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:47:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBA4C433C8;
        Tue, 31 Oct 2023 17:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774430;
        bh=k1VfUGf081mtmgogIyUpQ+PftFC6fTgQ/30HEpGonx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqkciNGYxqwJ8mcV75GBLorN8qcUy+yJBLkYpME8B3cyGBfAWjbYB6ydeaLtP+UgR
         DiZiJxydF6SqhylyCbbi/Cs62VPMrfhWVHNp9gK1UC7Y/mImPTXsuH2xb8xsmrkYrG
         GnKGHOA2+pEeycpexvsQCdXpi/Z7yw1Q9NcV92tA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 043/112] btrfs: remove v0 extent handling
Date:   Tue, 31 Oct 2023 18:00:44 +0100
Message-ID: <20231031165902.671556999@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 182741d287fb1ea870ee6ef45aa1915a0b031233 ]

The v0 extent item has been deprecated for a long time, and we don't have
any report from the community either.

So it's time to remove the v0 extent specific error handling, and just
treat them as regular extent tree corruption.

This patch would remove the btrfs_print_v0_err() helper, and enhance the
involved error handling to treat them just as any extent tree
corruption. No reports regarding v0 extents have been seen since the
graceful handling was added in 2018.

This involves:

- btrfs_backref_add_tree_node()
  This change is a little tricky, the new code is changed to only handle
  BTRFS_TREE_BLOCK_REF_KEY and BTRFS_SHARED_BLOCK_REF_KEY.

  But this is safe, as we have rejected any unknown inline refs through
  btrfs_get_extent_inline_ref_type().
  For keyed backrefs, we're safe to skip anything we don't know (that's
  if it can pass tree-checker in the first place).

- btrfs_lookup_extent_info()
- lookup_inline_extent_backref()
- run_delayed_extent_op()
- __btrfs_free_extent()
- add_tree_block()
  Regular error handling of unexpected extent tree item, and abort
  transaction (if we have a trans handle).

- remove_extent_data_ref()
  It's pretty much the same as the regular rejection of unknown backref
  key.
  But for this particular case, we can also remove a BUG_ON().

- extent_data_ref_count()
  We can remove the BTRFS_EXTENT_REF_V0_KEY BUG_ON(), as it would be
  rejected by the only caller.

- btrfs_print_leaf()
  Remove the handling for BTRFS_EXTENT_REF_V0_KEY.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: eb96e221937a ("btrfs: fix unwritten extent buffer after snapshotting a new subvolume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/backref.c              | 29 +++++++++++----------------
 fs/btrfs/extent-tree.c          | 35 ++++++++++++++++++++-------------
 fs/btrfs/messages.c             |  6 ------
 fs/btrfs/messages.h             |  2 --
 fs/btrfs/print-tree.c           | 10 ++++------
 fs/btrfs/relocation.c           | 11 ++++++-----
 include/trace/events/btrfs.h    |  1 -
 include/uapi/linux/btrfs_tree.h |  6 +++++-
 8 files changed, 48 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 79336fa853db3..b7d54efb47288 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3373,7 +3373,6 @@ int btrfs_backref_add_tree_node(struct btrfs_backref_cache *cache,
 				struct btrfs_key *node_key,
 				struct btrfs_backref_node *cur)
 {
-	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct btrfs_backref_edge *edge;
 	struct btrfs_backref_node *exist;
 	int ret;
@@ -3462,25 +3461,21 @@ int btrfs_backref_add_tree_node(struct btrfs_backref_cache *cache,
 			ret = handle_direct_tree_backref(cache, &key, cur);
 			if (ret < 0)
 				goto out;
-			continue;
-		} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
-			ret = -EINVAL;
-			btrfs_print_v0_err(fs_info);
-			btrfs_handle_fs_error(fs_info, ret, NULL);
-			goto out;
-		} else if (key.type != BTRFS_TREE_BLOCK_REF_KEY) {
-			continue;
+		} else if (key.type == BTRFS_TREE_BLOCK_REF_KEY) {
+			/*
+			 * key.type == BTRFS_TREE_BLOCK_REF_KEY, inline ref
+			 * offset means the root objectid. We need to search
+			 * the tree to get its parent bytenr.
+			 */
+			ret = handle_indirect_tree_backref(cache, path, &key, node_key,
+							   cur);
+			if (ret < 0)
+				goto out;
 		}
-
 		/*
-		 * key.type == BTRFS_TREE_BLOCK_REF_KEY, inline ref offset
-		 * means the root objectid. We need to search the tree to get
-		 * its parent bytenr.
+		 * Unrecognized tree backref items (if it can pass tree-checker)
+		 * would be ignored.
 		 */
-		ret = handle_indirect_tree_backref(cache, path, &key, node_key,
-						   cur);
-		if (ret < 0)
-			goto out;
 	}
 	ret = 0;
 	cur->checked = 1;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2cf8d646085c2..14ea6b587e97b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -187,8 +187,10 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			num_refs = btrfs_extent_refs(leaf, ei);
 			extent_flags = btrfs_extent_flags(leaf, ei);
 		} else {
-			ret = -EINVAL;
-			btrfs_print_v0_err(fs_info);
+			ret = -EUCLEAN;
+			btrfs_err(fs_info,
+			"unexpected extent item size, has %u expect >= %zu",
+				  item_size, sizeof(*ei));
 			if (trans)
 				btrfs_abort_transaction(trans, ret);
 			else
@@ -624,12 +626,12 @@ static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
 		ref2 = btrfs_item_ptr(leaf, path->slots[0],
 				      struct btrfs_shared_data_ref);
 		num_refs = btrfs_shared_data_ref_count(leaf, ref2);
-	} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
-		btrfs_print_v0_err(trans->fs_info);
-		btrfs_abort_transaction(trans, -EINVAL);
-		return -EINVAL;
 	} else {
-		BUG();
+		btrfs_err(trans->fs_info,
+			  "unrecognized backref key (%llu %u %llu)",
+			  key.objectid, key.type, key.offset);
+		btrfs_abort_transaction(trans, -EUCLEAN);
+		return -EUCLEAN;
 	}
 
 	BUG_ON(num_refs < refs_to_drop);
@@ -660,7 +662,6 @@ static noinline u32 extent_data_ref_count(struct btrfs_path *path,
 	leaf = path->nodes[0];
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 
-	BUG_ON(key.type == BTRFS_EXTENT_REF_V0_KEY);
 	if (iref) {
 		/*
 		 * If type is invalid, we should have bailed out earlier than
@@ -881,8 +882,10 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	item_size = btrfs_item_size(leaf, path->slots[0]);
 	if (unlikely(item_size < sizeof(*ei))) {
-		err = -EINVAL;
-		btrfs_print_v0_err(fs_info);
+		err = -EUCLEAN;
+		btrfs_err(fs_info,
+			  "unexpected extent item size, has %llu expect >= %zu",
+			  item_size, sizeof(*ei));
 		btrfs_abort_transaction(trans, err);
 		goto out;
 	}
@@ -1683,8 +1686,10 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 	item_size = btrfs_item_size(leaf, path->slots[0]);
 
 	if (unlikely(item_size < sizeof(*ei))) {
-		err = -EINVAL;
-		btrfs_print_v0_err(fs_info);
+		err = -EUCLEAN;
+		btrfs_err(fs_info,
+			  "unexpected extent item size, has %u expect >= %zu",
+			  item_size, sizeof(*ei));
 		btrfs_abort_transaction(trans, err);
 		goto out;
 	}
@@ -3113,8 +3118,10 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	item_size = btrfs_item_size(leaf, extent_slot);
 	if (unlikely(item_size < sizeof(*ei))) {
-		ret = -EINVAL;
-		btrfs_print_v0_err(info);
+		ret = -EUCLEAN;
+		btrfs_err(trans->fs_info,
+			  "unexpected extent item size, has %u expect >= %zu",
+			  item_size, sizeof(*ei));
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index 23fc11af498ac..21f2d101f681d 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -252,12 +252,6 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt,
 }
 #endif
 
-void __cold btrfs_print_v0_err(struct btrfs_fs_info *fs_info)
-{
-	btrfs_err(fs_info,
-"Unsupported V0 extent filesystem detected. Aborting. Please re-create your filesystem with a newer kernel");
-}
-
 #if BITS_PER_LONG == 32
 void __cold btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info)
 {
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index deedc1a168e24..1ae6f8e23e071 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -181,8 +181,6 @@ do {								\
 #define ASSERT(expr)	(void)(expr)
 #endif
 
-void __cold btrfs_print_v0_err(struct btrfs_fs_info *fs_info);
-
 __printf(5, 6)
 __cold
 void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index aa06d9ca911d9..0c93439e929fb 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -95,8 +95,10 @@ static void print_extent_item(const struct extent_buffer *eb, int slot, int type
 	int ref_index = 0;
 
 	if (unlikely(item_size < sizeof(*ei))) {
-		btrfs_print_v0_err(eb->fs_info);
-		btrfs_handle_fs_error(eb->fs_info, -EINVAL, NULL);
+		btrfs_err(eb->fs_info,
+			  "unexpected extent item size, has %u expect >= %zu",
+			  item_size, sizeof(*ei));
+		btrfs_handle_fs_error(eb->fs_info, -EUCLEAN, NULL);
 	}
 
 	ei = btrfs_item_ptr(eb, slot, struct btrfs_extent_item);
@@ -291,10 +293,6 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 			       btrfs_file_extent_num_bytes(l, fi),
 			       btrfs_file_extent_ram_bytes(l, fi));
 			break;
-		case BTRFS_EXTENT_REF_V0_KEY:
-			btrfs_print_v0_err(fs_info);
-			btrfs_handle_fs_error(fs_info, -EINVAL, NULL);
-			break;
 		case BTRFS_BLOCK_GROUP_ITEM_KEY:
 			bi = btrfs_item_ptr(l, i,
 					    struct btrfs_block_group_item);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5f4ff7d5b5c19..d69a331a6d113 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3256,12 +3256,13 @@ static int add_tree_block(struct reloc_control *rc,
 			if (type == BTRFS_TREE_BLOCK_REF_KEY)
 				owner = btrfs_extent_inline_ref_offset(eb, iref);
 		}
-	} else if (unlikely(item_size == sizeof(struct btrfs_extent_item_v0))) {
-		btrfs_print_v0_err(eb->fs_info);
-		btrfs_handle_fs_error(eb->fs_info, -EINVAL, NULL);
-		return -EINVAL;
 	} else {
-		BUG();
+		btrfs_print_leaf(eb);
+		btrfs_err(rc->block_group->fs_info,
+			  "unrecognized tree backref at tree block %llu slot %u",
+			  eb->start, path->slots[0]);
+		btrfs_release_path(path);
+		return -EUCLEAN;
 	}
 
 	btrfs_release_path(path);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index a8206f5332e99..da0734b182f2f 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -38,7 +38,6 @@ struct find_free_extent_ctl;
 	__print_symbolic(type,						\
 		{ BTRFS_TREE_BLOCK_REF_KEY, 	"TREE_BLOCK_REF" },	\
 		{ BTRFS_EXTENT_DATA_REF_KEY, 	"EXTENT_DATA_REF" },	\
-		{ BTRFS_EXTENT_REF_V0_KEY, 	"EXTENT_REF_V0" },	\
 		{ BTRFS_SHARED_BLOCK_REF_KEY, 	"SHARED_BLOCK_REF" },	\
 		{ BTRFS_SHARED_DATA_REF_KEY, 	"SHARED_DATA_REF" })
 
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index ab38d0f411fa4..fc3c32186d7eb 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -220,7 +220,11 @@
 
 #define BTRFS_EXTENT_DATA_REF_KEY	178
 
-#define BTRFS_EXTENT_REF_V0_KEY		180
+/*
+ * Obsolete key. Defintion removed in 6.6, value may be reused in the future.
+ *
+ * #define BTRFS_EXTENT_REF_V0_KEY	180
+ */
 
 #define BTRFS_SHARED_BLOCK_REF_KEY	182
 
-- 
2.42.0



