Return-Path: <stable+bounces-68614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED6695332F
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CF7288AD9
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F51A01D4;
	Thu, 15 Aug 2024 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rFGAsCgr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA41AC8AE;
	Thu, 15 Aug 2024 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731121; cv=none; b=GOQqP4O+BDAkzItC4C3h0pNh+9E0eSayAZAdm2CtNowTjr5fDmBmWjblpZCYn42whRyxok+z3wuV/hyQ4pjCyKom/OI8GaVbislJJ6Ol/HTz855iVydUDsT+YFJZQlOWGjRRsPUO7yj0CzBvkoHSZOFy3JaKKqNr6EgbYiYNTuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731121; c=relaxed/simple;
	bh=KLfJtPzFCa3a0818zZtX7vxR6KA2YyhEAVQI9YSb4Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lonww4spGjt6JKoQwqyG5LfaxZTUZ5gS4/VjbLb/MHA9R8J1BRAXGQHfCoZGTHqlxI/39h2Or6Bc0kpX/0MLO7n6vxhNTxpvF7VoQ745ql5cKXUmWn5DBCOjuAzX6qHdTIkaA05gZq6Y63pF8tUV/i/03YAc11hkiQ64YryMSXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rFGAsCgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D79AC32786;
	Thu, 15 Aug 2024 14:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731121;
	bh=KLfJtPzFCa3a0818zZtX7vxR6KA2YyhEAVQI9YSb4Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rFGAsCgrIHlR+e+A+1dA73IgFekrbEs/shslMe56XAUjQb6g3R6B9u6dQ687q4H5f
	 yhBvkT34/wsvMTgnTEOJ6btyFMtKYE+kGcKLVfaa5Vg7+LjhC7a5IpPhtMt2OwImtQ
	 JurzcXy6BJzfuF1+BaNkhOklQd4k3TMvM1lxkV2M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+6030b3b1b9bf70e538c4@syzkaller.appspotmail.com,
	"=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" <ernesto.mnd.fernandez@gmail.com>,
	Chao Yu <chao@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 006/259] hfsplus: fix to avoid false alarm of circular locking
Date: Thu, 15 Aug 2024 15:22:19 +0200
Message-ID: <20240815131903.035918131@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit be4edd1642ee205ed7bbf66edc0453b1be1fb8d7 ]

Syzbot report potential ABBA deadlock as below:

loop0: detected capacity change from 0 to 1024
======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-10323-g8f6a15f095a6 #0 Not tainted
------------------------------------------------------
syz-executor171/5344 is trying to acquire lock:
ffff88807cb980b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x811/0xb50 fs/hfsplus/extents.c:595

but task is already holding lock:
ffff88807a930108 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x2da/0xb50 fs/hfsplus/extents.c:576

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hfsplus_file_extend+0x21b/0x1b70 fs/hfsplus/extents.c:457
       hfsplus_bmap_reserve+0x105/0x4e0 fs/hfsplus/btree.c:358
       hfsplus_rename_cat+0x1d0/0x1050 fs/hfsplus/catalog.c:456
       hfsplus_rename+0x12e/0x1c0 fs/hfsplus/dir.c:552
       vfs_rename+0xbdb/0xf00 fs/namei.c:4887
       do_renameat2+0xd94/0x13f0 fs/namei.c:5044
       __do_sys_rename fs/namei.c:5091 [inline]
       __se_sys_rename fs/namei.c:5089 [inline]
       __x64_sys_rename+0x86/0xa0 fs/namei.c:5089
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&tree->tree_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hfsplus_file_truncate+0x811/0xb50 fs/hfsplus/extents.c:595
       hfsplus_setattr+0x1ce/0x280 fs/hfsplus/inode.c:265
       notify_change+0xb9d/0xe70 fs/attr.c:497
       do_truncate+0x220/0x310 fs/open.c:65
       handle_truncate fs/namei.c:3308 [inline]
       do_open fs/namei.c:3654 [inline]
       path_openat+0x2a3d/0x3280 fs/namei.c:3807
       do_filp_open+0x235/0x490 fs/namei.c:3834
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_creat fs/open.c:1497 [inline]
       __se_sys_creat fs/open.c:1491 [inline]
       __x64_sys_creat+0x123/0x170 fs/open.c:1491
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&HFSPLUS_I(inode)->extents_lock);
                               lock(&tree->tree_lock);
                               lock(&HFSPLUS_I(inode)->extents_lock);
  lock(&tree->tree_lock);

This is a false alarm as tree_lock mutex are different, one is
from sbi->cat_tree, and another is from sbi->ext_tree:

Thread A			Thread B
- hfsplus_rename
 - hfsplus_rename_cat
  - hfs_find_init
   - mutext_lock(cat_tree->tree_lock)
				- hfsplus_setattr
				 - hfsplus_file_truncate
				  - mutex_lock(hip->extents_lock)
				  - hfs_find_init
				   - mutext_lock(ext_tree->tree_lock)
  - hfs_bmap_reserve
   - hfsplus_file_extend
    - mutex_lock(hip->extents_lock)

So, let's call mutex_lock_nested for tree_lock mutex lock, and pass
correct lock class for it.

Fixes: 31651c607151 ("hfsplus: avoid deadlock on file truncation")
Reported-by: syzbot+6030b3b1b9bf70e538c4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-fsdevel/000000000000e37a4005ef129563@google.com
Cc: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20240607142304.455441-1-chao@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/bfind.c      | 15 ++-------------
 fs/hfsplus/extents.c    |  9 ++++++---
 fs/hfsplus/hfsplus_fs.h | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca2ba8c9f82ef..901e83d65d202 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -25,19 +25,8 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 	fd->key = ptr + tree->max_key_len + 2;
 	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
 		tree->cnid, __builtin_return_address(0));
-	switch (tree->cnid) {
-	case HFSPLUS_CAT_CNID:
-		mutex_lock_nested(&tree->tree_lock, CATALOG_BTREE_MUTEX);
-		break;
-	case HFSPLUS_EXT_CNID:
-		mutex_lock_nested(&tree->tree_lock, EXTENTS_BTREE_MUTEX);
-		break;
-	case HFSPLUS_ATTR_CNID:
-		mutex_lock_nested(&tree->tree_lock, ATTR_BTREE_MUTEX);
-		break;
-	default:
-		BUG();
-	}
+	mutex_lock_nested(&tree->tree_lock,
+			hfsplus_btree_lock_class(tree));
 	return 0;
 }
 
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 7054a542689f9..c95a2f0ed4a74 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -430,7 +430,8 @@ int hfsplus_free_fork(struct super_block *sb, u32 cnid,
 		hfsplus_free_extents(sb, ext_entry, total_blocks - start,
 				     total_blocks);
 		total_blocks = start;
-		mutex_lock(&fd.tree->tree_lock);
+		mutex_lock_nested(&fd.tree->tree_lock,
+			hfsplus_btree_lock_class(fd.tree));
 	} while (total_blocks > blocks);
 	hfs_find_exit(&fd);
 
@@ -592,7 +593,8 @@ void hfsplus_file_truncate(struct inode *inode)
 					     alloc_cnt, alloc_cnt - blk_cnt);
 			hfsplus_dump_extent(hip->first_extents);
 			hip->first_blocks = blk_cnt;
-			mutex_lock(&fd.tree->tree_lock);
+			mutex_lock_nested(&fd.tree->tree_lock,
+				hfsplus_btree_lock_class(fd.tree));
 			break;
 		}
 		res = __hfsplus_ext_cache_extent(&fd, inode, alloc_cnt);
@@ -606,7 +608,8 @@ void hfsplus_file_truncate(struct inode *inode)
 		hfsplus_free_extents(sb, hip->cached_extents,
 				     alloc_cnt - start, alloc_cnt - blk_cnt);
 		hfsplus_dump_extent(hip->cached_extents);
-		mutex_lock(&fd.tree->tree_lock);
+		mutex_lock_nested(&fd.tree->tree_lock,
+				hfsplus_btree_lock_class(fd.tree));
 		if (blk_cnt > start) {
 			hip->extent_state |= HFSPLUS_EXT_DIRTY;
 			break;
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 9580179ff535a..909e03956c3f2 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -539,6 +539,27 @@ int hfsplus_read_wrapper(struct super_block *sb);
 #define __hfsp_mt2ut(t)		(be32_to_cpu(t) - 2082844800U)
 #define __hfsp_ut2mt(t)		(cpu_to_be32(t + 2082844800U))
 
+static inline enum hfsplus_btree_mutex_classes
+hfsplus_btree_lock_class(struct hfs_btree *tree)
+{
+	enum hfsplus_btree_mutex_classes class;
+
+	switch (tree->cnid) {
+	case HFSPLUS_CAT_CNID:
+		class = CATALOG_BTREE_MUTEX;
+		break;
+	case HFSPLUS_EXT_CNID:
+		class = EXTENTS_BTREE_MUTEX;
+		break;
+	case HFSPLUS_ATTR_CNID:
+		class = ATTR_BTREE_MUTEX;
+		break;
+	default:
+		BUG();
+	}
+	return class;
+}
+
 /* compatibility */
 #define hfsp_mt2ut(t)		(struct timespec){ .tv_sec = __hfsp_mt2ut(t) }
 #define hfsp_ut2mt(t)		__hfsp_ut2mt((t).tv_sec)
-- 
2.43.0




