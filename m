Return-Path: <stable+bounces-127749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F13CCA7AA7E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AD81768C8
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ADE25A34F;
	Thu,  3 Apr 2025 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR7CM7Mf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6CD25A347;
	Thu,  3 Apr 2025 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707009; cv=none; b=LIKoFYwlkmURDHaci5+8xVccqyuMMNKBfqv/2ZKrJz1OWWOnRrAG4LWUjyhY7A/KgwMDdkdfQIuYW5f14Xw7uEVaUb48B5QXBdKIqBpfTUVfc35KXOpfUDZdzjCZwxIlKxjVKycjzQLx6Op0Oj2UDq9/gpFWzUgN5sBO0mb926w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707009; c=relaxed/simple;
	bh=eaCxgFxvShJDd10VtKlAv+dHnCHIrzL9SeEXbtvwv7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L3LoOpwT60YtHct7D2z1mCx2SdHyywWfwhvs4Rij50ugZ9cxQIsYfbK+DTujdE3Emv5wT0P5CmACQpJoMWmV+JG2LFDFGB4HxD90nxeEjNlE4ep/xyvu1j5o6Hwy34k/8prcVyxMC46KZs8vYnBcnB5fzVHFafCVVMf5UDF+TBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR7CM7Mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCECDC4CEEA;
	Thu,  3 Apr 2025 19:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707009;
	bh=eaCxgFxvShJDd10VtKlAv+dHnCHIrzL9SeEXbtvwv7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XR7CM7MfweS4NSMsfDgz3Kd+kQ28m9XuAV7XOku/Vf8TMw4WfUYkhi5/uRh9yFGje
	 +v1tpLnGORZneOpvApo0LGGXtF6n5tmISMs7OCQ/xzdnziSg4o/Mju7bSvfcoJip6b
	 uuOcm5/BQy06Ducm27L3TdMQ55vw1mM6dSO/73K4+3bsF1ckNeA5B3fYZtx2y8dHQu
	 7/r+SqW5dQw1lNcTlXEVZDXHcwafF2vTLY8EbWBIVNKisEvnLsWnjKZ1gzkSgr6eC7
	 8TB2hL8VvbT33aAJSBeC7Uj/swGQNRmRYcA4Y/LVaZEZb829bJzuhsPH+KD5DfLTvs
	 Szxyl4ch2KLUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.14 34/54] Revert "f2fs: rebuild nat_bits during umount"
Date: Thu,  3 Apr 2025 15:01:49 -0400
Message-Id: <20250403190209.2675485-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 19426c4988aa85298c1b4caf2889d37ec5c80fea ]

This reverts commit 94c821fb286b545d37549ff30a0c341e066f0d6c.

It reports that there is potential corruption in node footer,
the most suspious feature is nat_bits, let's revert recovery
related code.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c |  21 +++------
 fs/f2fs/f2fs.h       |  32 +++++++++++++-
 fs/f2fs/node.c       | 101 ++++++++++---------------------------------
 3 files changed, 59 insertions(+), 95 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index efda9a0229816..86228f82f54d0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1344,21 +1344,13 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	unsigned long flags;
 
-	if (cpc->reason & CP_UMOUNT) {
-		if (le32_to_cpu(ckpt->cp_pack_total_block_count) +
-			NM_I(sbi)->nat_bits_blocks > BLKS_PER_SEG(sbi)) {
-			clear_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
-			f2fs_notice(sbi, "Disable nat_bits due to no space");
-		} else if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG) &&
-						f2fs_nat_bitmap_enabled(sbi)) {
-			f2fs_enable_nat_bits(sbi);
-			set_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
-			f2fs_notice(sbi, "Rebuild and enable nat_bits");
-		}
-	}
-
 	spin_lock_irqsave(&sbi->cp_lock, flags);
 
+	if ((cpc->reason & CP_UMOUNT) &&
+			le32_to_cpu(ckpt->cp_pack_total_block_count) >
+			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks)
+		disable_nat_bits(sbi, false);
+
 	if (cpc->reason & CP_TRIMMED)
 		__set_ckpt_flags(ckpt, CP_TRIMMED_FLAG);
 	else
@@ -1541,8 +1533,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	start_blk = __start_cp_next_addr(sbi);
 
 	/* write nat bits */
-	if ((cpc->reason & CP_UMOUNT) &&
-			is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG)) {
+	if (enabled_nat_bits(sbi, cpc)) {
 		__u64 cp_ver = cur_cp_version(ckpt);
 		block_t blk;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1afa7be16e7da..5117e1e2e22b3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2219,6 +2219,36 @@ static inline void f2fs_up_write(struct f2fs_rwsem *sem)
 #endif
 }
 
+static inline void disable_nat_bits(struct f2fs_sb_info *sbi, bool lock)
+{
+	unsigned long flags;
+	unsigned char *nat_bits;
+
+	/*
+	 * In order to re-enable nat_bits we need to call fsck.f2fs by
+	 * set_sbi_flag(sbi, SBI_NEED_FSCK). But it may give huge cost,
+	 * so let's rely on regular fsck or unclean shutdown.
+	 */
+
+	if (lock)
+		spin_lock_irqsave(&sbi->cp_lock, flags);
+	__clear_ckpt_flags(F2FS_CKPT(sbi), CP_NAT_BITS_FLAG);
+	nat_bits = NM_I(sbi)->nat_bits;
+	NM_I(sbi)->nat_bits = NULL;
+	if (lock)
+		spin_unlock_irqrestore(&sbi->cp_lock, flags);
+
+	kvfree(nat_bits);
+}
+
+static inline bool enabled_nat_bits(struct f2fs_sb_info *sbi,
+					struct cp_control *cpc)
+{
+	bool set = is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
+
+	return (cpc) ? (cpc->reason & CP_UMOUNT) && set : set;
+}
+
 static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
 {
 	f2fs_down_read(&sbi->cp_rwsem);
@@ -3662,7 +3692,6 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from);
 int f2fs_truncate_xattr_node(struct inode *inode);
 int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
 					unsigned int seq_id);
-bool f2fs_nat_bitmap_enabled(struct f2fs_sb_info *sbi);
 int f2fs_remove_inode_page(struct inode *inode);
 struct page *f2fs_new_inode_page(struct inode *inode);
 struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
@@ -3687,7 +3716,6 @@ int f2fs_recover_xattr_data(struct inode *inode, struct page *page);
 int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
 int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum);
-void f2fs_enable_nat_bits(struct f2fs_sb_info *sbi);
 int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 int f2fs_build_node_manager(struct f2fs_sb_info *sbi);
 void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c1274bcec68b4..9f6cca183c608 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2276,24 +2276,6 @@ static void __move_free_nid(struct f2fs_sb_info *sbi, struct free_nid *i,
 	}
 }
 
-bool f2fs_nat_bitmap_enabled(struct f2fs_sb_info *sbi)
-{
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	unsigned int i;
-	bool ret = true;
-
-	f2fs_down_read(&nm_i->nat_tree_lock);
-	for (i = 0; i < nm_i->nat_blocks; i++) {
-		if (!test_bit_le(i, nm_i->nat_block_bitmap)) {
-			ret = false;
-			break;
-		}
-	}
-	f2fs_up_read(&nm_i->nat_tree_lock);
-
-	return ret;
-}
-
 static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
 							bool set, bool build)
 {
@@ -2972,23 +2954,7 @@ static void __adjust_nat_entry_set(struct nat_entry_set *nes,
 	list_add_tail(&nes->set_list, head);
 }
 
-static void __update_nat_bits(struct f2fs_nm_info *nm_i, unsigned int nat_ofs,
-							unsigned int valid)
-{
-	if (valid == 0) {
-		__set_bit_le(nat_ofs, nm_i->empty_nat_bits);
-		__clear_bit_le(nat_ofs, nm_i->full_nat_bits);
-		return;
-	}
-
-	__clear_bit_le(nat_ofs, nm_i->empty_nat_bits);
-	if (valid == NAT_ENTRY_PER_BLOCK)
-		__set_bit_le(nat_ofs, nm_i->full_nat_bits);
-	else
-		__clear_bit_le(nat_ofs, nm_i->full_nat_bits);
-}
-
-static void update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
+static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 						struct page *page)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
@@ -2997,7 +2963,7 @@ static void update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 	int valid = 0;
 	int i = 0;
 
-	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
+	if (!enabled_nat_bits(sbi, NULL))
 		return;
 
 	if (nat_index == 0) {
@@ -3008,36 +2974,17 @@ static void update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 		if (le32_to_cpu(nat_blk->entries[i].block_addr) != NULL_ADDR)
 			valid++;
 	}
-
-	__update_nat_bits(nm_i, nat_index, valid);
-}
-
-void f2fs_enable_nat_bits(struct f2fs_sb_info *sbi)
-{
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	unsigned int nat_ofs;
-
-	f2fs_down_read(&nm_i->nat_tree_lock);
-
-	for (nat_ofs = 0; nat_ofs < nm_i->nat_blocks; nat_ofs++) {
-		unsigned int valid = 0, nid_ofs = 0;
-
-		/* handle nid zero due to it should never be used */
-		if (unlikely(nat_ofs == 0)) {
-			valid = 1;
-			nid_ofs = 1;
-		}
-
-		for (; nid_ofs < NAT_ENTRY_PER_BLOCK; nid_ofs++) {
-			if (!test_bit_le(nid_ofs,
-					nm_i->free_nid_bitmap[nat_ofs]))
-				valid++;
-		}
-
-		__update_nat_bits(nm_i, nat_ofs, valid);
+	if (valid == 0) {
+		__set_bit_le(nat_index, nm_i->empty_nat_bits);
+		__clear_bit_le(nat_index, nm_i->full_nat_bits);
+		return;
 	}
 
-	f2fs_up_read(&nm_i->nat_tree_lock);
+	__clear_bit_le(nat_index, nm_i->empty_nat_bits);
+	if (valid == NAT_ENTRY_PER_BLOCK)
+		__set_bit_le(nat_index, nm_i->full_nat_bits);
+	else
+		__clear_bit_le(nat_index, nm_i->full_nat_bits);
 }
 
 static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
@@ -3056,7 +3003,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	 * #1, flush nat entries to journal in current hot data summary block.
 	 * #2, flush nat entries to nat page.
 	 */
-	if ((cpc->reason & CP_UMOUNT) ||
+	if (enabled_nat_bits(sbi, cpc) ||
 		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
 		to_journal = false;
 
@@ -3103,7 +3050,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	if (to_journal) {
 		up_write(&curseg->journal_rwsem);
 	} else {
-		update_nat_bits(sbi, start_nid, page);
+		__update_nat_bits(sbi, start_nid, page);
 		f2fs_put_page(page, 1);
 	}
 
@@ -3134,7 +3081,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * during unmount, let's flush nat_bits before checking
 	 * nat_cnt[DIRTY_NAT].
 	 */
-	if (cpc->reason & CP_UMOUNT) {
+	if (enabled_nat_bits(sbi, cpc)) {
 		f2fs_down_write(&nm_i->nat_tree_lock);
 		remove_nats_in_journal(sbi);
 		f2fs_up_write(&nm_i->nat_tree_lock);
@@ -3150,7 +3097,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * entries, remove all entries from journal and merge them
 	 * into nat entry set.
 	 */
-	if (cpc->reason & CP_UMOUNT ||
+	if (enabled_nat_bits(sbi, cpc) ||
 		!__has_cursum_space(journal,
 			nm_i->nat_cnt[DIRTY_NAT], NAT_JOURNAL))
 		remove_nats_in_journal(sbi);
@@ -3187,18 +3134,15 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 	__u64 cp_ver = cur_cp_version(ckpt);
 	block_t nat_bits_addr;
 
+	if (!enabled_nat_bits(sbi, NULL))
+		return 0;
+
 	nm_i->nat_bits_blocks = F2FS_BLK_ALIGN((nat_bits_bytes << 1) + 8);
 	nm_i->nat_bits = f2fs_kvzalloc(sbi,
 			F2FS_BLK_TO_BYTES(nm_i->nat_bits_blocks), GFP_KERNEL);
 	if (!nm_i->nat_bits)
 		return -ENOMEM;
 
-	nm_i->full_nat_bits = nm_i->nat_bits + 8;
-	nm_i->empty_nat_bits = nm_i->full_nat_bits + nat_bits_bytes;
-
-	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
-		return 0;
-
 	nat_bits_addr = __start_cp_addr(sbi) + BLKS_PER_SEG(sbi) -
 						nm_i->nat_bits_blocks;
 	for (i = 0; i < nm_i->nat_bits_blocks; i++) {
@@ -3215,12 +3159,13 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 
 	cp_ver |= (cur_cp_crc(ckpt) << 32);
 	if (cpu_to_le64(cp_ver) != *(__le64 *)nm_i->nat_bits) {
-		clear_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
-		f2fs_notice(sbi, "Disable nat_bits due to incorrect cp_ver (%llu, %llu)",
-			cp_ver, le64_to_cpu(*(__le64 *)nm_i->nat_bits));
+		disable_nat_bits(sbi, true);
 		return 0;
 	}
 
+	nm_i->full_nat_bits = nm_i->nat_bits + 8;
+	nm_i->empty_nat_bits = nm_i->full_nat_bits + nat_bits_bytes;
+
 	f2fs_notice(sbi, "Found nat_bits in checkpoint");
 	return 0;
 }
@@ -3231,7 +3176,7 @@ static inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
 	unsigned int i = 0;
 	nid_t nid, last_nid;
 
-	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
+	if (!enabled_nat_bits(sbi, NULL))
 		return;
 
 	for (i = 0; i < nm_i->nat_blocks; i++) {
-- 
2.39.5


