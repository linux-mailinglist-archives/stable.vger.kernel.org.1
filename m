Return-Path: <stable+bounces-174215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA60CB36218
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15848A2AB8
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7858F221704;
	Tue, 26 Aug 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nCo+MM3+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33019223DE5;
	Tue, 26 Aug 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213799; cv=none; b=GIvBkbgTQoDO1/1dqHB61JXhKFkGDblDk9xHLrKLKFVBedE/qKESLg0N0nKe9ye6xVqY+iR16eXkAvTeb09RoeK+p5RLBC1svqmJGeFCea4UN9gOsuH3LI9+CuyAhsLwQ20Wz74+JRKR6iaU4/Usb6bAqb/2eR8krV/2Y2WtI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213799; c=relaxed/simple;
	bh=YasQYO9WFSfQlg+rtnbNGbGjqGHt22Tx+blOIXBHC/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwXQK01vxO4QYS9sihrrymExYGs/e8bRBKcjEDsEjMWRgxsOnSkuQBf4DipKtwD3TSqjXJ2UvJPJLVftkMnbf6Z/AxJGAUY3YQYC5y8guWC0D2++v9DeDjZUJwHoJasnTRKZfo664xNyO2DVDj30+RFYtSqBcqxKSHt78+wTpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nCo+MM3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B0BC4CEF1;
	Tue, 26 Aug 2025 13:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213799;
	bh=YasQYO9WFSfQlg+rtnbNGbGjqGHt22Tx+blOIXBHC/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nCo+MM3+XmmJpDoL+0g91AdG6iC7fD7XGmUAQagrD5u7MtPbXAATPOqF5zi5vC0Jb
	 II9MXJcNIF9noxfHsfeCBWd+nnf9vKe+b6eFhueWwsaHPxv9qp08J6qvqSEG1IceNL
	 7kPXc1Be2PNkJJqmje5OqhZeWNvtyrcMAfnvB5/M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 452/587] btrfs: constify more pointer parameters
Date: Tue, 26 Aug 2025 13:10:01 +0200
Message-ID: <20250826111004.459238146@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Sterba <dsterba@suse.com>

[ Upstream commit ca283ea9920ac20ae23ed398b693db3121045019 ]

Continue adding const to parameters.  This is for clarity and minor
addition to safety. There are some minor effects, in the assembly code
and .ko measured on release config.

Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/backref.c           |    6 +++---
 fs/btrfs/block-group.c       |   34 +++++++++++++++++-----------------
 fs/btrfs/block-group.h       |   11 +++++------
 fs/btrfs/block-rsv.c         |    2 +-
 fs/btrfs/block-rsv.h         |    2 +-
 fs/btrfs/ctree.c             |   14 +++++++-------
 fs/btrfs/ctree.h             |    6 +++---
 fs/btrfs/discard.c           |    4 ++--
 fs/btrfs/file-item.c         |    4 ++--
 fs/btrfs/file-item.h         |    2 +-
 fs/btrfs/inode-item.c        |   10 +++++-----
 fs/btrfs/inode-item.h        |    4 ++--
 fs/btrfs/space-info.c        |   17 ++++++++---------
 fs/btrfs/space-info.h        |    6 +++---
 fs/btrfs/tree-mod-log.c      |   14 +++++++-------
 fs/btrfs/tree-mod-log.h      |    6 +++---
 fs/btrfs/zoned.c             |    2 +-
 fs/btrfs/zoned.h             |    4 ++--
 include/trace/events/btrfs.h |    6 +++---
 19 files changed, 76 insertions(+), 78 deletions(-)

--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -222,8 +222,8 @@ static void free_pref(struct prelim_ref
  * A -1 return indicates ref1 is a 'lower' block than ref2, while 1
  * indicates a 'higher' block.
  */
-static int prelim_ref_compare(struct prelim_ref *ref1,
-			      struct prelim_ref *ref2)
+static int prelim_ref_compare(const struct prelim_ref *ref1,
+			      const struct prelim_ref *ref2)
 {
 	if (ref1->level < ref2->level)
 		return -1;
@@ -254,7 +254,7 @@ static int prelim_ref_compare(struct pre
 }
 
 static void update_share_count(struct share_check *sc, int oldcount,
-			       int newcount, struct prelim_ref *newref)
+			       int newcount, const struct prelim_ref *newref)
 {
 	if ((!sc) || (oldcount == 0 && newcount < 1))
 		return;
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -23,7 +23,7 @@
 #include "extent-tree.h"
 
 #ifdef CONFIG_BTRFS_DEBUG
-int btrfs_should_fragment_free_space(struct btrfs_block_group *block_group)
+int btrfs_should_fragment_free_space(const struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 
@@ -53,9 +53,9 @@ static inline bool has_unwritten_metadat
  *
  * Should be called with balance_lock held
  */
-static u64 get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
+static u64 get_restripe_target(const struct btrfs_fs_info *fs_info, u64 flags)
 {
-	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
+	const struct btrfs_balance_control *bctl = fs_info->balance_ctl;
 	u64 target = 0;
 
 	if (!bctl)
@@ -1440,9 +1440,9 @@ out:
 }
 
 static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
-				 struct btrfs_block_group *bg)
+				 const struct btrfs_block_group *bg)
 {
-	struct btrfs_fs_info *fs_info = bg->fs_info;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_transaction *prev_trans = NULL;
 	const u64 start = bg->start;
 	const u64 end = start + bg->length - 1;
@@ -1775,14 +1775,14 @@ static int reclaim_bgs_cmp(void *unused,
 	return bg1->used > bg2->used;
 }
 
-static inline bool btrfs_should_reclaim(struct btrfs_fs_info *fs_info)
+static inline bool btrfs_should_reclaim(const struct btrfs_fs_info *fs_info)
 {
 	if (btrfs_is_zoned(fs_info))
 		return btrfs_zoned_should_reclaim(fs_info);
 	return true;
 }
 
-static bool should_reclaim_block_group(struct btrfs_block_group *bg, u64 bytes_freed)
+static bool should_reclaim_block_group(const struct btrfs_block_group *bg, u64 bytes_freed)
 {
 	const struct btrfs_space_info *space_info = bg->space_info;
 	const int reclaim_thresh = READ_ONCE(space_info->bg_reclaim_threshold);
@@ -2014,8 +2014,8 @@ void btrfs_mark_bg_to_reclaim(struct btr
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
-static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
-			   struct btrfs_path *path)
+static int read_bg_from_eb(struct btrfs_fs_info *fs_info, const struct btrfs_key *key,
+			   const struct btrfs_path *path)
 {
 	struct extent_map_tree *em_tree;
 	struct extent_map *em;
@@ -2067,7 +2067,7 @@ out_free_em:
 
 static int find_first_block_group(struct btrfs_fs_info *fs_info,
 				  struct btrfs_path *path,
-				  struct btrfs_key *key)
+				  const struct btrfs_key *key)
 {
 	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	int ret;
@@ -2659,8 +2659,8 @@ static int insert_block_group_item(struc
 }
 
 static int insert_dev_extent(struct btrfs_trans_handle *trans,
-			    struct btrfs_device *device, u64 chunk_offset,
-			    u64 start, u64 num_bytes)
+			     const struct btrfs_device *device, u64 chunk_offset,
+			     u64 start, u64 num_bytes)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_root *root = fs_info->dev_root;
@@ -2810,7 +2810,7 @@ next:
  * For extent tree v2 we use the block_group_item->chunk_offset to point at our
  * global root id.  For v1 it's always set to BTRFS_FIRST_CHUNK_TREE_OBJECTID.
  */
-static u64 calculate_global_root_id(struct btrfs_fs_info *fs_info, u64 offset)
+static u64 calculate_global_root_id(const struct btrfs_fs_info *fs_info, u64 offset)
 {
 	u64 div = SZ_1G;
 	u64 index;
@@ -3846,8 +3846,8 @@ static void force_metadata_allocation(st
 	}
 }
 
-static int should_alloc_chunk(struct btrfs_fs_info *fs_info,
-			      struct btrfs_space_info *sinfo, int force)
+static int should_alloc_chunk(const struct btrfs_fs_info *fs_info,
+			      const struct btrfs_space_info *sinfo, int force)
 {
 	u64 bytes_used = btrfs_space_info_used(sinfo, false);
 	u64 thresh;
@@ -4222,7 +4222,7 @@ out:
 	return ret;
 }
 
-static u64 get_profile_num_devs(struct btrfs_fs_info *fs_info, u64 type)
+static u64 get_profile_num_devs(const struct btrfs_fs_info *fs_info, u64 type)
 {
 	u64 num_dev;
 
@@ -4629,7 +4629,7 @@ int btrfs_use_block_group_size_class(str
 	return 0;
 }
 
-bool btrfs_block_group_should_use_size_class(struct btrfs_block_group *bg)
+bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg)
 {
 	if (btrfs_is_zoned(bg->fs_info))
 		return false;
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -250,7 +250,7 @@ struct btrfs_block_group {
 	enum btrfs_block_group_size_class size_class;
 };
 
-static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
+static inline u64 btrfs_block_group_end(const struct btrfs_block_group *block_group)
 {
 	return (block_group->start + block_group->length);
 }
@@ -262,8 +262,7 @@ static inline bool btrfs_is_block_group_
 	return (bg->used > 0 || bg->reserved > 0 || bg->pinned > 0);
 }
 
-static inline bool btrfs_is_block_group_data_only(
-					struct btrfs_block_group *block_group)
+static inline bool btrfs_is_block_group_data_only(const struct btrfs_block_group *block_group)
 {
 	/*
 	 * In mixed mode the fragmentation is expected to be high, lowering the
@@ -274,7 +273,7 @@ static inline bool btrfs_is_block_group_
 }
 
 #ifdef CONFIG_BTRFS_DEBUG
-int btrfs_should_fragment_free_space(struct btrfs_block_group *block_group);
+int btrfs_should_fragment_free_space(const struct btrfs_block_group *block_group);
 #endif
 
 struct btrfs_block_group *btrfs_lookup_first_block_group(
@@ -355,7 +354,7 @@ static inline u64 btrfs_system_alloc_pro
 	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
 }
 
-static inline int btrfs_block_group_done(struct btrfs_block_group *cache)
+static inline int btrfs_block_group_done(const struct btrfs_block_group *cache)
 {
 	smp_mb();
 	return cache->cached == BTRFS_CACHE_FINISHED ||
@@ -372,6 +371,6 @@ enum btrfs_block_group_size_class btrfs_
 int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
 				     enum btrfs_block_group_size_class size_class,
 				     bool force_wrong_size_class);
-bool btrfs_block_group_should_use_size_class(struct btrfs_block_group *bg);
+bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg);
 
 #endif /* BTRFS_BLOCK_GROUP_H */
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -547,7 +547,7 @@ try_reserve:
 	return ERR_PTR(ret);
 }
 
-int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
+int btrfs_check_trunc_cache_free_space(const struct btrfs_fs_info *fs_info,
 				       struct btrfs_block_rsv *rsv)
 {
 	u64 needed_bytes;
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -82,7 +82,7 @@ void btrfs_release_global_block_rsv(stru
 struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 					    struct btrfs_root *root,
 					    u32 blocksize);
-int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
+int btrfs_check_trunc_cache_free_space(const struct btrfs_fs_info *fs_info,
 				       struct btrfs_block_rsv *rsv);
 static inline void btrfs_unuse_block_rsv(struct btrfs_fs_info *fs_info,
 					 struct btrfs_block_rsv *block_rsv,
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2719,7 +2719,7 @@ int btrfs_get_next_valid_item(struct btr
  *
  */
 static void fixup_low_keys(struct btrfs_trans_handle *trans,
-			   struct btrfs_path *path,
+			   const struct btrfs_path *path,
 			   struct btrfs_disk_key *key, int level)
 {
 	int i;
@@ -2749,7 +2749,7 @@ static void fixup_low_keys(struct btrfs_
  * that the new key won't break the order
  */
 void btrfs_set_item_key_safe(struct btrfs_trans_handle *trans,
-			     struct btrfs_path *path,
+			     const struct btrfs_path *path,
 			     const struct btrfs_key *new_key)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -2815,8 +2815,8 @@ void btrfs_set_item_key_safe(struct btrf
  * is correct, we only need to bother the last key of @left and the first
  * key of @right.
  */
-static bool check_sibling_keys(struct extent_buffer *left,
-			       struct extent_buffer *right)
+static bool check_sibling_keys(const struct extent_buffer *left,
+			       const struct extent_buffer *right)
 {
 	struct btrfs_key left_last;
 	struct btrfs_key right_first;
@@ -3085,7 +3085,7 @@ static noinline int insert_new_root(stru
  * blocknr is the block the key points to.
  */
 static int insert_ptr(struct btrfs_trans_handle *trans,
-		      struct btrfs_path *path,
+		      const struct btrfs_path *path,
 		      struct btrfs_disk_key *key, u64 bytenr,
 		      int slot, int level)
 {
@@ -4176,7 +4176,7 @@ int btrfs_split_item(struct btrfs_trans_
  * the front.
  */
 void btrfs_truncate_item(struct btrfs_trans_handle *trans,
-			 struct btrfs_path *path, u32 new_size, int from_end)
+			 const struct btrfs_path *path, u32 new_size, int from_end)
 {
 	int slot;
 	struct extent_buffer *leaf;
@@ -4268,7 +4268,7 @@ void btrfs_truncate_item(struct btrfs_tr
  * make the item pointed to by the path bigger, data_size is the added size.
  */
 void btrfs_extend_item(struct btrfs_trans_handle *trans,
-		       struct btrfs_path *path, u32 data_size)
+		       const struct btrfs_path *path, u32 data_size)
 {
 	int slot;
 	struct extent_buffer *leaf;
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -521,7 +521,7 @@ int btrfs_previous_item(struct btrfs_roo
 int btrfs_previous_extent_item(struct btrfs_root *root,
 			struct btrfs_path *path, u64 min_objectid);
 void btrfs_set_item_key_safe(struct btrfs_trans_handle *trans,
-			     struct btrfs_path *path,
+			     const struct btrfs_path *path,
 			     const struct btrfs_key *new_key);
 struct extent_buffer *btrfs_root_node(struct btrfs_root *root);
 int btrfs_find_next_key(struct btrfs_root *root, struct btrfs_path *path,
@@ -555,9 +555,9 @@ int btrfs_block_can_be_shared(struct btr
 int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct btrfs_path *path, int level, int slot);
 void btrfs_extend_item(struct btrfs_trans_handle *trans,
-		       struct btrfs_path *path, u32 data_size);
+		       const struct btrfs_path *path, u32 data_size);
 void btrfs_truncate_item(struct btrfs_trans_handle *trans,
-			 struct btrfs_path *path, u32 new_size, int from_end);
+			 const struct btrfs_path *path, u32 new_size, int from_end);
 int btrfs_split_item(struct btrfs_trans_handle *trans,
 		     struct btrfs_root *root,
 		     struct btrfs_path *path,
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -68,7 +68,7 @@ static int discard_minlen[BTRFS_NR_DISCA
 };
 
 static struct list_head *get_discard_list(struct btrfs_discard_ctl *discard_ctl,
-					  struct btrfs_block_group *block_group)
+					  const struct btrfs_block_group *block_group)
 {
 	return &discard_ctl->discard_list[block_group->discard_index];
 }
@@ -80,7 +80,7 @@ static struct list_head *get_discard_lis
  *
  * Check if the file system is writeable and BTRFS_FS_DISCARD_RUNNING is set.
  */
-static bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
+static bool btrfs_run_discard_work(const struct btrfs_discard_ctl *discard_ctl)
 {
 	struct btrfs_fs_info *fs_info = container_of(discard_ctl,
 						     struct btrfs_fs_info,
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -153,7 +153,7 @@ static inline u32 max_ordered_sum_bytes(
  * Calculate the total size needed to allocate for an ordered sum structure
  * spanning @bytes in the file.
  */
-static int btrfs_ordered_sum_size(struct btrfs_fs_info *fs_info, unsigned long bytes)
+static int btrfs_ordered_sum_size(const struct btrfs_fs_info *fs_info, unsigned long bytes)
 {
 	return sizeof(struct btrfs_ordered_sum) + bytes_to_csum_size(fs_info, bytes);
 }
@@ -1263,7 +1263,7 @@ out:
 
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
-				     struct btrfs_file_extent_item *fi,
+				     const struct btrfs_file_extent_item *fi,
 				     struct extent_map *em)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -62,7 +62,7 @@ int btrfs_lookup_csums_bitmap(struct btr
 			      unsigned long *csum_bitmap);
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
-				     struct btrfs_file_extent_item *fi,
+				     const struct btrfs_file_extent_item *fi,
 				     struct extent_map *em);
 int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 					u64 len);
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -15,7 +15,7 @@
 #include "extent-tree.h"
 #include "file-item.h"
 
-struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
+struct btrfs_inode_ref *btrfs_find_name_in_backref(const struct extent_buffer *leaf,
 						   int slot,
 						   const struct fscrypt_str *name)
 {
@@ -43,7 +43,7 @@ struct btrfs_inode_ref *btrfs_find_name_
 }
 
 struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
-		struct extent_buffer *leaf, int slot, u64 ref_objectid,
+		const struct extent_buffer *leaf, int slot, u64 ref_objectid,
 		const struct fscrypt_str *name)
 {
 	struct btrfs_inode_extref *extref;
@@ -424,9 +424,9 @@ int btrfs_lookup_inode(struct btrfs_tran
 	return ret;
 }
 
-static inline void btrfs_trace_truncate(struct btrfs_inode *inode,
-					struct extent_buffer *leaf,
-					struct btrfs_file_extent_item *fi,
+static inline void btrfs_trace_truncate(const struct btrfs_inode *inode,
+					const struct extent_buffer *leaf,
+					const struct btrfs_file_extent_item *fi,
 					u64 offset, int extent_type, int slot)
 {
 	if (!inode)
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -100,11 +100,11 @@ struct btrfs_inode_extref *btrfs_lookup_
 			  u64 inode_objectid, u64 ref_objectid, int ins_len,
 			  int cow);
 
-struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
+struct btrfs_inode_ref *btrfs_find_name_in_backref(const struct extent_buffer *leaf,
 						   int slot,
 						   const struct fscrypt_str *name);
 struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
-		struct extent_buffer *leaf, int slot, u64 ref_objectid,
+		const struct extent_buffer *leaf, int slot, u64 ref_objectid,
 		const struct fscrypt_str *name);
 
 #endif
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -162,7 +162,7 @@
  *   thing with or without extra unallocated space.
  */
 
-u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
+u64 __pure btrfs_space_info_used(const struct btrfs_space_info *s_info,
 			  bool may_use_included)
 {
 	ASSERT(s_info);
@@ -342,7 +342,7 @@ struct btrfs_space_info *btrfs_find_spac
 }
 
 static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
-			  struct btrfs_space_info *space_info,
+			  const struct btrfs_space_info *space_info,
 			  enum btrfs_reserve_flush_enum flush)
 {
 	u64 profile;
@@ -378,7 +378,7 @@ static u64 calc_available_free_space(str
 }
 
 int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
-			 struct btrfs_space_info *space_info, u64 bytes,
+			 const struct btrfs_space_info *space_info, u64 bytes,
 			 enum btrfs_reserve_flush_enum flush)
 {
 	u64 avail;
@@ -483,8 +483,8 @@ static void dump_global_block_rsv(struct
 	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
 }
 
-static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *info)
+static void __btrfs_dump_space_info(const struct btrfs_fs_info *fs_info,
+				    const struct btrfs_space_info *info)
 {
 	const char *flag_str = space_info_flag_to_str(info);
 	lockdep_assert_held(&info->lock);
@@ -807,9 +807,8 @@ static void flush_space(struct btrfs_fs_
 	return;
 }
 
-static inline u64
-btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
-				 struct btrfs_space_info *space_info)
+static u64 btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
+					    const struct btrfs_space_info *space_info)
 {
 	u64 used;
 	u64 avail;
@@ -834,7 +833,7 @@ btrfs_calc_reclaim_metadata_size(struct
 }
 
 static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info)
+				    const struct btrfs_space_info *space_info)
 {
 	const u64 global_rsv_size = btrfs_block_rsv_reserved(&fs_info->global_block_rsv);
 	u64 ordered, delalloc;
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -165,7 +165,7 @@ struct reserve_ticket {
 	wait_queue_head_t wait;
 };
 
-static inline bool btrfs_mixed_space_info(struct btrfs_space_info *space_info)
+static inline bool btrfs_mixed_space_info(const struct btrfs_space_info *space_info)
 {
 	return ((space_info->flags & BTRFS_BLOCK_GROUP_METADATA) &&
 		(space_info->flags & BTRFS_BLOCK_GROUP_DATA));
@@ -206,7 +206,7 @@ void btrfs_update_space_info_chunk_size(
 					u64 chunk_size);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 					       u64 flags);
-u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
+u64 __pure btrfs_space_info_used(const struct btrfs_space_info *s_info,
 			  bool may_use_included);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
@@ -219,7 +219,7 @@ int btrfs_reserve_metadata_bytes(struct
 void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info);
 int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
-			 struct btrfs_space_info *space_info, u64 bytes,
+			 const struct btrfs_space_info *space_info, u64 bytes,
 			 enum btrfs_reserve_flush_enum flush);
 
 static inline void btrfs_space_info_free_bytes_may_use(
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -171,7 +171,7 @@ static noinline int tree_mod_log_insert(
  * write unlock fs_info::tree_mod_log_lock.
  */
 static inline bool tree_mod_dont_log(struct btrfs_fs_info *fs_info,
-				    struct extent_buffer *eb)
+				    const struct extent_buffer *eb)
 {
 	if (!test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
 		return true;
@@ -189,7 +189,7 @@ static inline bool tree_mod_dont_log(str
 
 /* Similar to tree_mod_dont_log, but doesn't acquire any locks. */
 static inline bool tree_mod_need_log(const struct btrfs_fs_info *fs_info,
-				    struct extent_buffer *eb)
+				    const struct extent_buffer *eb)
 {
 	if (!test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
 		return false;
@@ -199,7 +199,7 @@ static inline bool tree_mod_need_log(con
 	return true;
 }
 
-static struct tree_mod_elem *alloc_tree_mod_elem(struct extent_buffer *eb,
+static struct tree_mod_elem *alloc_tree_mod_elem(const struct extent_buffer *eb,
 						 int slot,
 						 enum btrfs_mod_log_op op)
 {
@@ -222,7 +222,7 @@ static struct tree_mod_elem *alloc_tree_
 	return tm;
 }
 
-int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
+int btrfs_tree_mod_log_insert_key(const struct extent_buffer *eb, int slot,
 				  enum btrfs_mod_log_op op)
 {
 	struct tree_mod_elem *tm;
@@ -259,7 +259,7 @@ out_unlock:
 	return ret;
 }
 
-static struct tree_mod_elem *tree_mod_log_alloc_move(struct extent_buffer *eb,
+static struct tree_mod_elem *tree_mod_log_alloc_move(const struct extent_buffer *eb,
 						     int dst_slot, int src_slot,
 						     int nr_items)
 {
@@ -279,7 +279,7 @@ static struct tree_mod_elem *tree_mod_lo
 	return tm;
 }
 
-int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
+int btrfs_tree_mod_log_insert_move(const struct extent_buffer *eb,
 				   int dst_slot, int src_slot,
 				   int nr_items)
 {
@@ -536,7 +536,7 @@ static struct tree_mod_elem *tree_mod_lo
 }
 
 int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
-			       struct extent_buffer *src,
+			       const struct extent_buffer *src,
 			       unsigned long dst_offset,
 			       unsigned long src_offset,
 			       int nr_items)
--- a/fs/btrfs/tree-mod-log.h
+++ b/fs/btrfs/tree-mod-log.h
@@ -31,7 +31,7 @@ void btrfs_put_tree_mod_seq(struct btrfs
 int btrfs_tree_mod_log_insert_root(struct extent_buffer *old_root,
 				   struct extent_buffer *new_root,
 				   bool log_removal);
-int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
+int btrfs_tree_mod_log_insert_key(const struct extent_buffer *eb, int slot,
 				  enum btrfs_mod_log_op op);
 int btrfs_tree_mod_log_free_eb(struct extent_buffer *eb);
 struct extent_buffer *btrfs_tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
@@ -41,11 +41,11 @@ struct extent_buffer *btrfs_tree_mod_log
 struct extent_buffer *btrfs_get_old_root(struct btrfs_root *root, u64 time_seq);
 int btrfs_old_root_level(struct btrfs_root *root, u64 time_seq);
 int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
-			       struct extent_buffer *src,
+			       const struct extent_buffer *src,
 			       unsigned long dst_offset,
 			       unsigned long src_offset,
 			       int nr_items);
-int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
+int btrfs_tree_mod_log_insert_move(const struct extent_buffer *eb,
 				   int dst_slot, int src_slot,
 				   int nr_items);
 u64 btrfs_tree_mod_log_lowest_seq(struct btrfs_fs_info *fs_info);
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2351,7 +2351,7 @@ void btrfs_free_zone_cache(struct btrfs_
 	mutex_unlock(&fs_devices->device_list_mutex);
 }
 
-bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
+bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -77,7 +77,7 @@ void btrfs_schedule_zone_finish_bg(struc
 				   struct extent_buffer *eb);
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
 void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
-bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info);
+bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info);
 void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logical,
 				       u64 length);
 int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
@@ -237,7 +237,7 @@ static inline void btrfs_clear_data_relo
 
 static inline void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info) { }
 
-static inline bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
+static inline bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info)
 {
 	return false;
 }
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1857,7 +1857,7 @@ TRACE_EVENT(qgroup_update_counters,
 
 TRACE_EVENT(qgroup_update_reserve,
 
-	TP_PROTO(struct btrfs_fs_info *fs_info, struct btrfs_qgroup *qgroup,
+	TP_PROTO(const struct btrfs_fs_info *fs_info, const struct btrfs_qgroup *qgroup,
 		 s64 diff, int type),
 
 	TP_ARGS(fs_info, qgroup, diff, type),
@@ -1883,7 +1883,7 @@ TRACE_EVENT(qgroup_update_reserve,
 
 TRACE_EVENT(qgroup_meta_reserve,
 
-	TP_PROTO(struct btrfs_root *root, s64 diff, int type),
+	TP_PROTO(const struct btrfs_root *root, s64 diff, int type),
 
 	TP_ARGS(root, diff, type),
 
@@ -1906,7 +1906,7 @@ TRACE_EVENT(qgroup_meta_reserve,
 
 TRACE_EVENT(qgroup_meta_convert,
 
-	TP_PROTO(struct btrfs_root *root, s64 diff),
+	TP_PROTO(const struct btrfs_root *root, s64 diff),
 
 	TP_ARGS(root, diff),
 



