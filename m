Return-Path: <stable+bounces-70779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C22D961001
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311E61C23416
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65AE1C86E7;
	Tue, 27 Aug 2024 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MgrCcLl1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24301C57BF;
	Tue, 27 Aug 2024 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771035; cv=none; b=F/POM8EVUJdVyvC7dYmZodW8jMSvVQOn+7FV70G8IURLa1guA7ggfoMmbFUCBcmVvnje4YhyFoUw+2CEzXxBiEODL6kkWt92Ztjw845PoCwE3Cp/eyMiH+cH8uWwdI0OcWs+gQqzI88ExXp4WjD+APJq03kG8gisnXVl1r95eG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771035; c=relaxed/simple;
	bh=jRTH1kpBZX+wCQj5FL/XkHpMwAjXJ/Ubdu2bV6v/O1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQBKxgRfRl9yMQZTHh6FYT7LXVSvaeLPMoCjAjkjwWFX+86xx6H/sUtt6kr8JmP4L/90CCl3MLOCM3lWnvLdrnFPT5SNGG2socQ7nHM73VNX8AWxxznqasRBdNHp9rnL8PKAUttHL12LPyKWiGIba9oHME/OUHca1PPQ+3nLcAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MgrCcLl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F786C6104C;
	Tue, 27 Aug 2024 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771035;
	bh=jRTH1kpBZX+wCQj5FL/XkHpMwAjXJ/Ubdu2bV6v/O1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MgrCcLl19bxa6CMvFVqFHuEmF0pZjKExSToc1XKJj+6I8oKoQn4SbqrS4AHnC/PoE
	 YDXrjQeo3sPwA3OYCH9ahVKDzha99XGWwTGtWrMIIDCH6RojHGPZC7Od48XoZpsveP
	 KuiU9ERwlSOJMxcqOPc+dGIensDvJr1O9QTBN9a4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.10 036/273] vfs: Dont evict inode under the inode lru traversing context
Date: Tue, 27 Aug 2024 16:36:00 +0200
Message-ID: <20240827143834.769998653@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhihao Cheng <chengzhihao1@huawei.com>

commit 2a0629834cd82f05d424bbc193374f9a43d1f87d upstream.

The inode reclaiming process(See function prune_icache_sb) collects all
reclaimable inodes and mark them with I_FREEING flag at first, at that
time, other processes will be stuck if they try getting these inodes
(See function find_inode_fast), then the reclaiming process destroy the
inodes by function dispose_list(). Some filesystems(eg. ext4 with
ea_inode feature, ubifs with xattr) may do inode lookup in the inode
evicting callback function, if the inode lookup is operated under the
inode lru traversing context, deadlock problems may happen.

Case 1: In function ext4_evict_inode(), the ea inode lookup could happen
        if ea_inode feature is enabled, the lookup process will be stuck
	under the evicting context like this:

 1. File A has inode i_reg and an ea inode i_ea
 2. getfattr(A, xattr_buf) // i_ea is added into lru // lru->i_ea
 3. Then, following three processes running like this:

    PA                              PB
 echo 2 > /proc/sys/vm/drop_caches
  shrink_slab
   prune_dcache_sb
   // i_reg is added into lru, lru->i_ea->i_reg
   prune_icache_sb
    list_lru_walk_one
     inode_lru_isolate
      i_ea->i_state |= I_FREEING // set inode state
     inode_lru_isolate
      __iget(i_reg)
      spin_unlock(&i_reg->i_lock)
      spin_unlock(lru_lock)
                                     rm file A
                                      i_reg->nlink = 0
      iput(i_reg) // i_reg->nlink is 0, do evict
       ext4_evict_inode
        ext4_xattr_delete_inode
         ext4_xattr_inode_dec_ref_all
          ext4_xattr_inode_iget
           ext4_iget(i_ea->i_ino)
            iget_locked
             find_inode_fast
              __wait_on_freeing_inode(i_ea) ----→ AA deadlock
    dispose_list // cannot be executed by prune_icache_sb
     wake_up_bit(&i_ea->i_state)

Case 2: In deleted inode writing function ubifs_jnl_write_inode(), file
        deleting process holds BASEHD's wbuf->io_mutex while getting the
	xattr inode, which could race with inode reclaiming process(The
        reclaiming process could try locking BASEHD's wbuf->io_mutex in
	inode evicting function), then an ABBA deadlock problem would
	happen as following:

 1. File A has inode ia and a xattr(with inode ixa), regular file B has
    inode ib and a xattr.
 2. getfattr(A, xattr_buf) // ixa is added into lru // lru->ixa
 3. Then, following three processes running like this:

        PA                PB                        PC
                echo 2 > /proc/sys/vm/drop_caches
                 shrink_slab
                  prune_dcache_sb
                  // ib and ia are added into lru, lru->ixa->ib->ia
                  prune_icache_sb
                   list_lru_walk_one
                    inode_lru_isolate
                     ixa->i_state |= I_FREEING // set inode state
                    inode_lru_isolate
                     __iget(ib)
                     spin_unlock(&ib->i_lock)
                     spin_unlock(lru_lock)
                                                   rm file B
                                                    ib->nlink = 0
 rm file A
  iput(ia)
   ubifs_evict_inode(ia)
    ubifs_jnl_delete_inode(ia)
     ubifs_jnl_write_inode(ia)
      make_reservation(BASEHD) // Lock wbuf->io_mutex
      ubifs_iget(ixa->i_ino)
       iget_locked
        find_inode_fast
         __wait_on_freeing_inode(ixa)
          |          iput(ib) // ib->nlink is 0, do evict
          |           ubifs_evict_inode
          |            ubifs_jnl_delete_inode(ib)
          ↓             ubifs_jnl_write_inode
     ABBA deadlock ←-----make_reservation(BASEHD)
                   dispose_list // cannot be executed by prune_icache_sb
                    wake_up_bit(&ixa->i_state)

Fix the possible deadlock by using new inode state flag I_LRU_ISOLATING
to pin the inode in memory while inode_lru_isolate() reclaims its pages
instead of using ordinary inode reference. This way inode deletion
cannot be triggered from inode_lru_isolate() thus avoiding the deadlock.
evict() is made to wait for I_LRU_ISOLATING to be cleared before
proceeding with inode cleanup.

Link: https://lore.kernel.org/all/37c29c42-7685-d1f0-067d-63582ffac405@huaweicloud.com/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219022
Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Fixes: 7959cf3a7506 ("ubifs: journal: Handle xattrs like files")
Cc: stable@vger.kernel.org
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Link: https://lore.kernel.org/r/20240809031628.1069873-1-chengzhihao@huaweicloud.com
Reviewed-by: Jan Kara <jack@suse.cz>
Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/inode.c         |   39 +++++++++++++++++++++++++++++++++++++--
 include/linux/fs.h |    5 +++++
 2 files changed, 42 insertions(+), 2 deletions(-)

--- a/fs/inode.c
+++ b/fs/inode.c
@@ -486,6 +486,39 @@ static void inode_lru_list_del(struct in
 		this_cpu_dec(nr_unused);
 }
 
+static void inode_pin_lru_isolating(struct inode *inode)
+{
+	lockdep_assert_held(&inode->i_lock);
+	WARN_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
+	inode->i_state |= I_LRU_ISOLATING;
+}
+
+static void inode_unpin_lru_isolating(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	WARN_ON(!(inode->i_state & I_LRU_ISOLATING));
+	inode->i_state &= ~I_LRU_ISOLATING;
+	smp_mb();
+	wake_up_bit(&inode->i_state, __I_LRU_ISOLATING);
+	spin_unlock(&inode->i_lock);
+}
+
+static void inode_wait_for_lru_isolating(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	if (inode->i_state & I_LRU_ISOLATING) {
+		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
+		wait_queue_head_t *wqh;
+
+		wqh = bit_waitqueue(&inode->i_state, __I_LRU_ISOLATING);
+		spin_unlock(&inode->i_lock);
+		__wait_on_bit(wqh, &wq, bit_wait, TASK_UNINTERRUPTIBLE);
+		spin_lock(&inode->i_lock);
+		WARN_ON(inode->i_state & I_LRU_ISOLATING);
+	}
+	spin_unlock(&inode->i_lock);
+}
+
 /**
  * inode_sb_list_add - add inode to the superblock list of inodes
  * @inode: inode to add
@@ -655,6 +688,8 @@ static void evict(struct inode *inode)
 
 	inode_sb_list_del(inode);
 
+	inode_wait_for_lru_isolating(inode);
+
 	/*
 	 * Wait for flusher thread to be done with the inode so that filesystem
 	 * does not start destroying it while writeback is still running. Since
@@ -843,7 +878,7 @@ static enum lru_status inode_lru_isolate
 	 * be under pressure before the cache inside the highmem zone.
 	 */
 	if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) {
-		__iget(inode);
+		inode_pin_lru_isolating(inode);
 		spin_unlock(&inode->i_lock);
 		spin_unlock(lru_lock);
 		if (remove_inode_buffers(inode)) {
@@ -855,7 +890,7 @@ static enum lru_status inode_lru_isolate
 				__count_vm_events(PGINODESTEAL, reap);
 			mm_account_reclaimed_pages(reap);
 		}
-		iput(inode);
+		inode_unpin_lru_isolating(inode);
 		spin_lock(lru_lock);
 		return LRU_RETRY;
 	}
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2370,6 +2370,9 @@ static inline void kiocb_clone(struct ki
  *
  * I_PINNING_FSCACHE_WB	Inode is pinning an fscache object for writeback.
  *
+ * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
+ *			i_count.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  */
 #define I_DIRTY_SYNC		(1 << 0)
@@ -2393,6 +2396,8 @@ static inline void kiocb_clone(struct ki
 #define I_DONTCACHE		(1 << 16)
 #define I_SYNC_QUEUED		(1 << 17)
 #define I_PINNING_NETFS_WB	(1 << 18)
+#define __I_LRU_ISOLATING	19
+#define I_LRU_ISOLATING		(1 << __I_LRU_ISOLATING)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)



