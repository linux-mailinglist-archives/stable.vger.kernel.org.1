Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD4470C614
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjEVTO7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjEVTOu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:14:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A877132
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:14:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56CF762736
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715F3C433EF;
        Mon, 22 May 2023 19:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684782876;
        bh=MwUA+lX15dbgD/97QIdc12x72Z9syk8DM+0286i+phM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmtyMaqdsHOrI6jn8heA0g8BoGf8OXy/PVTdEHtBkVxX6+/UeBLeZ8D1ljX7s24G4
         pThOb22fJ5Dhp5O2VUohxxx+zoDO2CIaTzuf7+XeZn1l/48I5AMXiHGv3daQ3OZ+6R
         2BU7xcIXyKbuxxlcuzsDNtxdg/ofeZC4OpKHXelw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 029/203] ext4: allow ext4_get_group_info() to fail
Date:   Mon, 22 May 2023 20:07:33 +0100
Message-Id: <20230522190355.772176758@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit 5354b2af34064a4579be8bc0e2f15a7b70f14b5f ]

Previously, ext4_get_group_info() would treat an invalid group number
as BUG(), since in theory it should never happen.  However, if a
malicious attaker (or fuzzer) modifies the superblock via the block
device while it is the file system is mounted, it is possible for
s_first_data_block to get set to a very large number.  In that case,
when calculating the block group of some block number (such as the
starting block of a preallocation region), could result in an
underflow and very large block group number.  Then the BUG_ON check in
ext4_get_group_info() would fire, resutling in a denial of service
attack that can be triggered by root or someone with write access to
the block device.

For a quality of implementation perspective, it's best that even if
the system administrator does something that they shouldn't, that it
will not trigger a BUG.  So instead of BUG'ing, ext4_get_group_info()
will call ext4_error and return NULL.  We also add fallback code in
all of the callers of ext4_get_group_info() that it might NULL.

Also, since ext4_get_group_info() was already borderline to be an
inline function, un-inline it.  The results in a next reduction of the
compiled text size of ext4 by roughly 2k.

Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20230430154311.579720-2-tytso@mit.edu
Reported-by: syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=69b28112e098b070f639efb356393af3ffec4220
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/balloc.c  | 18 ++++++++++++-
 fs/ext4/ext4.h    | 15 ++---------
 fs/ext4/ialloc.c  | 12 ++++++---
 fs/ext4/mballoc.c | 64 +++++++++++++++++++++++++++++++++++++++--------
 fs/ext4/super.c   |  2 ++
 5 files changed, 82 insertions(+), 29 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 05ff34e925620..fadcb94e80fa1 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -319,6 +319,22 @@ static ext4_fsblk_t ext4_valid_block_bitmap_padding(struct super_block *sb,
 	return (next_zero_bit < bitmap_size ? next_zero_bit : 0);
 }
 
+struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
+					    ext4_group_t group)
+{
+	 struct ext4_group_info **grp_info;
+	 long indexv, indexh;
+
+	 if (unlikely(group >= EXT4_SB(sb)->s_groups_count)) {
+		 ext4_error(sb, "invalid group %u", group);
+		 return NULL;
+	 }
+	 indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
+	 indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
+	 grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
+	 return grp_info[indexh];
+}
+
 /*
  * Return the block number which was discovered to be invalid, or 0 if
  * the block bitmap is valid.
@@ -393,7 +409,7 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 
 	if (buffer_verified(bh))
 		return 0;
-	if (EXT4_MB_GRP_BBITMAP_CORRUPT(grp))
+	if (!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp))
 		return -EFSCORRUPTED;
 
 	ext4_lock_group(sb, block_group);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 80f0942fa1656..b6e2bb6a736b5 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2699,6 +2699,8 @@ extern void ext4_check_blocks_bitmap(struct super_block *);
 extern struct ext4_group_desc * ext4_get_group_desc(struct super_block * sb,
 						    ext4_group_t block_group,
 						    struct buffer_head ** bh);
+extern struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
+						   ext4_group_t group);
 extern int ext4_should_retry_alloc(struct super_block *sb, int *retries);
 
 extern struct buffer_head *ext4_read_block_bitmap_nowait(struct super_block *sb,
@@ -3346,19 +3348,6 @@ static inline void ext4_isize_set(struct ext4_inode *raw_inode, loff_t i_size)
 	raw_inode->i_size_high = cpu_to_le32(i_size >> 32);
 }
 
-static inline
-struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
-					    ext4_group_t group)
-{
-	 struct ext4_group_info **grp_info;
-	 long indexv, indexh;
-	 BUG_ON(group >= EXT4_SB(sb)->s_groups_count);
-	 indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
-	 indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
-	 grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
-	 return grp_info[indexh];
-}
-
 /*
  * Reading s_groups_count requires using smp_rmb() afterwards.  See
  * the locking protocol documented in the comments of ext4_group_add()
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 208b87ce88588..745d781da8915 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -91,7 +91,7 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
 
 	if (buffer_verified(bh))
 		return 0;
-	if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
+	if (!grp || EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
 		return -EFSCORRUPTED;
 
 	ext4_lock_group(sb, block_group);
@@ -293,7 +293,7 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
 	}
 	if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
 		grp = ext4_get_group_info(sb, block_group);
-		if (unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
+		if (!grp || unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
 			fatal = -EFSCORRUPTED;
 			goto error_return;
 		}
@@ -1048,7 +1048,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 			 * Skip groups with already-known suspicious inode
 			 * tables
 			 */
-			if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
+			if (!grp || EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
 				goto next_group;
 		}
 
@@ -1186,6 +1186,10 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 
 		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
 			grp = ext4_get_group_info(sb, group);
+			if (!grp) {
+				err = -EFSCORRUPTED;
+				goto out;
+			}
 			down_read(&grp->alloc_sem); /*
 						     * protect vs itable
 						     * lazyinit
@@ -1529,7 +1533,7 @@ int ext4_init_inode_table(struct super_block *sb, ext4_group_t group,
 	}
 
 	gdp = ext4_get_group_desc(sb, group, &group_desc_bh);
-	if (!gdp)
+	if (!gdp || !grp)
 		goto out;
 
 	/*
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 820804a7afe6e..4cc635633f789 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -745,6 +745,8 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 	MB_CHECK_ASSERT(e4b->bd_info->bb_fragments == fragments);
 
 	grp = ext4_get_group_info(sb, e4b->bd_group);
+	if (!grp)
+		return NULL;
 	list_for_each(cur, &grp->bb_prealloc_list) {
 		ext4_group_t groupnr;
 		struct ext4_prealloc_space *pa;
@@ -1110,9 +1112,9 @@ mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
 
 static noinline_for_stack
 void ext4_mb_generate_buddy(struct super_block *sb,
-				void *buddy, void *bitmap, ext4_group_t group)
+			    void *buddy, void *bitmap, ext4_group_t group,
+			    struct ext4_group_info *grp)
 {
-	struct ext4_group_info *grp = ext4_get_group_info(sb, group);
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
 	ext4_grpblk_t i = 0;
@@ -1233,6 +1235,8 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 			break;
 
 		grinfo = ext4_get_group_info(sb, group);
+		if (!grinfo)
+			continue;
 		/*
 		 * If page is uptodate then we came here after online resize
 		 * which added some new uninitialized group info structs, so
@@ -1298,6 +1302,10 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 				group, page->index, i * blocksize);
 			trace_ext4_mb_buddy_bitmap_load(sb, group);
 			grinfo = ext4_get_group_info(sb, group);
+			if (!grinfo) {
+				err = -EFSCORRUPTED;
+				goto out;
+			}
 			grinfo->bb_fragments = 0;
 			memset(grinfo->bb_counters, 0,
 			       sizeof(*grinfo->bb_counters) *
@@ -1308,7 +1316,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 			ext4_lock_group(sb, group);
 			/* init the buddy */
 			memset(data, 0xff, blocksize);
-			ext4_mb_generate_buddy(sb, data, incore, group);
+			ext4_mb_generate_buddy(sb, data, incore, group, grinfo);
 			ext4_unlock_group(sb, group);
 			incore = NULL;
 		} else {
@@ -1422,6 +1430,9 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 	might_sleep();
 	mb_debug(sb, "init group %u\n", group);
 	this_grp = ext4_get_group_info(sb, group);
+	if (!this_grp)
+		return -EFSCORRUPTED;
+
 	/*
 	 * This ensures that we don't reinit the buddy cache
 	 * page which map to the group from which we are already
@@ -1496,6 +1507,8 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 
 	blocks_per_page = PAGE_SIZE / sb->s_blocksize;
 	grp = ext4_get_group_info(sb, group);
+	if (!grp)
+		return -EFSCORRUPTED;
 
 	e4b->bd_blkbits = sb->s_blocksize_bits;
 	e4b->bd_info = grp;
@@ -2206,6 +2219,8 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 	struct ext4_free_extent ex;
 
+	if (!grp)
+		return -EFSCORRUPTED;
 	if (!(ac->ac_flags & (EXT4_MB_HINT_TRY_GOAL | EXT4_MB_HINT_GOAL_ONLY)))
 		return 0;
 	if (grp->bb_free == 0)
@@ -2430,7 +2445,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 
 	BUG_ON(cr < 0 || cr >= 4);
 
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp) || !grp))
 		return false;
 
 	free = grp->bb_free;
@@ -2499,6 +2514,8 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	ext4_grpblk_t free;
 	int ret = 0;
 
+	if (!grp)
+		return -EFSCORRUPTED;
 	if (sbi->s_mb_stats)
 		atomic64_inc(&sbi->s_bal_cX_groups_considered[ac->ac_criteria]);
 	if (should_lock) {
@@ -2579,7 +2596,7 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
 		 * prefetch once, so we avoid getblk() call, which can
 		 * be expensive.
 		 */
-		if (!EXT4_MB_GRP_TEST_AND_SET_READ(grp) &&
+		if (gdp && grp && !EXT4_MB_GRP_TEST_AND_SET_READ(grp) &&
 		    EXT4_MB_GRP_NEED_INIT(grp) &&
 		    ext4_free_group_clusters(sb, gdp) > 0 &&
 		    !(ext4_has_group_desc_csum(sb) &&
@@ -2623,7 +2640,7 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 		group--;
 		grp = ext4_get_group_info(sb, group);
 
-		if (EXT4_MB_GRP_NEED_INIT(grp) &&
+		if (grp && gdp && EXT4_MB_GRP_NEED_INIT(grp) &&
 		    ext4_free_group_clusters(sb, gdp) > 0 &&
 		    !(ext4_has_group_desc_csum(sb) &&
 		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
@@ -2883,6 +2900,8 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 		sizeof(struct ext4_group_info);
 
 	grinfo = ext4_get_group_info(sb, group);
+	if (!grinfo)
+		return 0;
 	/* Load the group info in memory only if not already loaded. */
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grinfo))) {
 		err = ext4_mb_load_buddy(sb, group, &e4b);
@@ -2893,7 +2912,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 		buddy_loaded = 1;
 	}
 
-	memcpy(&sg, ext4_get_group_info(sb, group), i);
+	memcpy(&sg, grinfo, i);
 
 	if (buddy_loaded)
 		ext4_mb_unload_buddy(&e4b);
@@ -3265,8 +3284,12 @@ static int ext4_mb_init_backend(struct super_block *sb)
 
 err_freebuddy:
 	cachep = get_groupinfo_cache(sb->s_blocksize_bits);
-	while (i-- > 0)
-		kmem_cache_free(cachep, ext4_get_group_info(sb, i));
+	while (i-- > 0) {
+		struct ext4_group_info *grp = ext4_get_group_info(sb, i);
+
+		if (grp)
+			kmem_cache_free(cachep, grp);
+	}
 	i = sbi->s_group_info_size;
 	rcu_read_lock();
 	group_info = rcu_dereference(sbi->s_group_info);
@@ -3562,6 +3585,8 @@ int ext4_mb_release(struct super_block *sb)
 		for (i = 0; i < ngroups; i++) {
 			cond_resched();
 			grinfo = ext4_get_group_info(sb, i);
+			if (!grinfo)
+				continue;
 			mb_group_bb_bitmap_free(grinfo);
 			ext4_lock_group(sb, i);
 			count = ext4_mb_cleanup_pa(grinfo);
@@ -4466,6 +4491,8 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 	struct ext4_free_data *entry;
 
 	grp = ext4_get_group_info(sb, group);
+	if (!grp)
+		return;
 	n = rb_first(&(grp->bb_free_root));
 
 	while (n) {
@@ -4493,6 +4520,9 @@ void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 	int preallocated = 0;
 	int len;
 
+	if (!grp)
+		return;
+
 	/* all form of preallocation discards first load group,
 	 * so the only competing code is preallocation use.
 	 * we don't need any locking here
@@ -4684,6 +4714,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 
 	ei = EXT4_I(ac->ac_inode);
 	grp = ext4_get_group_info(sb, ac->ac_b_ex.fe_group);
+	if (!grp)
+		return;
 
 	pa->pa_obj_lock = &ei->i_prealloc_lock;
 	pa->pa_inode = ac->ac_inode;
@@ -4737,6 +4769,8 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	atomic_add(pa->pa_free, &EXT4_SB(sb)->s_mb_preallocated);
 
 	grp = ext4_get_group_info(sb, ac->ac_b_ex.fe_group);
+	if (!grp)
+		return;
 	lg = ac->ac_lg;
 	BUG_ON(lg == NULL);
 
@@ -4865,6 +4899,8 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	int err;
 	int free = 0;
 
+	if (!grp)
+		return 0;
 	mb_debug(sb, "discard preallocation for group %u\n", group);
 	if (list_empty(&grp->bb_prealloc_list))
 		goto out_dbg;
@@ -5102,6 +5138,9 @@ static inline void ext4_mb_show_pa(struct super_block *sb)
 		struct ext4_prealloc_space *pa;
 		ext4_grpblk_t start;
 		struct list_head *cur;
+
+		if (!grp)
+			continue;
 		ext4_lock_group(sb, i);
 		list_for_each(cur, &grp->bb_prealloc_list) {
 			pa = list_entry(cur, struct ext4_prealloc_space,
@@ -5908,6 +5947,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	struct buffer_head *bitmap_bh = NULL;
 	struct super_block *sb = inode->i_sb;
 	struct ext4_group_desc *gdp;
+	struct ext4_group_info *grp;
 	unsigned int overflow;
 	ext4_grpblk_t bit;
 	struct buffer_head *gd_bh;
@@ -5933,8 +5973,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	overflow = 0;
 	ext4_get_group_no_and_offset(sb, block, &block_group, &bit);
 
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(
-			ext4_get_group_info(sb, block_group))))
+	grp = ext4_get_group_info(sb, block_group);
+	if (unlikely(!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		return;
 
 	/*
@@ -6537,6 +6577,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 
 	for (group = first_group; group <= last_group; group++) {
 		grp = ext4_get_group_info(sb, group);
+		if (!grp)
+			continue;
 		/* We only do this if the grp has never been initialized */
 		if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
 			ret = ext4_mb_init_group(sb, group, GFP_NOFS);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c527ec2b041fb..bf8a780cd69b6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1017,6 +1017,8 @@ void ext4_mark_group_bitmap_corrupted(struct super_block *sb,
 	struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group, NULL);
 	int ret;
 
+	if (!grp || !gdp)
+		return;
 	if (flags & EXT4_GROUP_INFO_BBITMAP_CORRUPT) {
 		ret = ext4_test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT,
 					    &grp->bb_state);
-- 
2.39.2



