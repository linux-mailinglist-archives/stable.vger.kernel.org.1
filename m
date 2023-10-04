Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77E37B8A73
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244435AbjJDSfk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244428AbjJDSfj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:35:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC83C0
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:35:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A196DC433C7;
        Wed,  4 Oct 2023 18:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444535;
        bh=4+egCyYuR4IUipqCIaDW5Wps7mp/K+izVoMt9GxTuY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SG0Cky3IwXOmsoTahivrpoGVsi4ybD2Fgmq/K+2kjzMVZ+3mRbGWBIgqlldaW7q9r
         1hpAHzkQ6oKuTvMPrQcohUpdZJcUmAKkrbsQIB5mQyY8YRAL3uGv3ZLxLPfUqcZRfa
         zYTF2WXOhjsx5QA1ZTfSeHZRcQUwNdXfTwOkIdnY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Weiner <hannes@cmpxchg.org>,
        Breno Leitao <leitao@debian.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5 285/321] mm: memcontrol: fix GFP_NOFS recursion in memory.high enforcement
Date:   Wed,  4 Oct 2023 19:57:10 +0200
Message-ID: <20231004175242.481996581@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Weiner <hannes@cmpxchg.org>

commit 9ea9cb00a82b53ec39630eac718776d37e41b35a upstream.

Breno and Josef report a deadlock scenario from cgroup reclaim
re-entering the filesystem:

[  361.546690] ======================================================
[  361.559210] WARNING: possible circular locking dependency detected
[  361.571703] 6.5.0-0_fbk700_debug_rc0_kbuilder_13159_gbf787a128001 #1 Tainted: G S          E
[  361.589704] ------------------------------------------------------
[  361.602277] find/9315 is trying to acquire lock:
[  361.611625] ffff88837ba140c0 (&delayed_node->mutex){+.+.}-{4:4}, at: __btrfs_release_delayed_node+0x68/0x4f0
[  361.631437]
[  361.631437] but task is already holding lock:
[  361.643243] ffff8881765b8678 (btrfs-tree-01){++++}-{4:4}, at: btrfs_tree_read_lock+0x1e/0x40

[  362.904457]  mutex_lock_nested+0x1c/0x30
[  362.912414]  __btrfs_release_delayed_node+0x68/0x4f0
[  362.922460]  btrfs_evict_inode+0x301/0x770
[  362.982726]  evict+0x17c/0x380
[  362.988944]  prune_icache_sb+0x100/0x1d0
[  363.005559]  super_cache_scan+0x1f8/0x260
[  363.013695]  do_shrink_slab+0x2a2/0x540
[  363.021489]  shrink_slab_memcg+0x237/0x3d0
[  363.050606]  shrink_slab+0xa7/0x240
[  363.083382]  shrink_node_memcgs+0x262/0x3b0
[  363.091870]  shrink_node+0x1a4/0x720
[  363.099150]  shrink_zones+0x1f6/0x5d0
[  363.148798]  do_try_to_free_pages+0x19b/0x5e0
[  363.157633]  try_to_free_mem_cgroup_pages+0x266/0x370
[  363.190575]  reclaim_high+0x16f/0x1f0
[  363.208409]  mem_cgroup_handle_over_high+0x10b/0x270
[  363.246678]  try_charge_memcg+0xaf2/0xc70
[  363.304151]  charge_memcg+0xf0/0x350
[  363.320070]  __mem_cgroup_charge+0x28/0x40
[  363.328371]  __filemap_add_folio+0x870/0xd50
[  363.371303]  filemap_add_folio+0xdd/0x310
[  363.399696]  __filemap_get_folio+0x2fc/0x7d0
[  363.419086]  pagecache_get_page+0xe/0x30
[  363.427048]  alloc_extent_buffer+0x1cd/0x6a0
[  363.435704]  read_tree_block+0x43/0xc0
[  363.443316]  read_block_for_search+0x361/0x510
[  363.466690]  btrfs_search_slot+0xc8c/0x1520

This is caused by the mem_cgroup_handle_over_high() not respecting the
gfp_mask of the allocation context.  We used to only call this function on
resume to userspace, where no locks were held.  But c9afe31ec443 ("memcg:
synchronously enforce memory.high for large overcharges") added a call
from the allocation context without considering the gfp.

Link: https://lkml.kernel.org/r/20230914152139.100822-1-hannes@cmpxchg.org
Fixes: c9afe31ec443 ("memcg: synchronously enforce memory.high for large overcharges")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reported-by: Breno Leitao <leitao@debian.org>
Reported-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: <stable@vger.kernel.org>	[5.17+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/memcontrol.h       |    4 ++--
 include/linux/resume_user_mode.h |    2 +-
 mm/memcontrol.c                  |    6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -919,7 +919,7 @@ unsigned long mem_cgroup_get_zone_lru_si
 	return READ_ONCE(mz->lru_zone_size[zone_idx][lru]);
 }
 
-void mem_cgroup_handle_over_high(void);
+void mem_cgroup_handle_over_high(gfp_t gfp_mask);
 
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
 
@@ -1460,7 +1460,7 @@ static inline void mem_cgroup_unlock_pag
 	rcu_read_unlock();
 }
 
-static inline void mem_cgroup_handle_over_high(void)
+static inline void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 {
 }
 
--- a/include/linux/resume_user_mode.h
+++ b/include/linux/resume_user_mode.h
@@ -55,7 +55,7 @@ static inline void resume_user_mode_work
 	}
 #endif
 
-	mem_cgroup_handle_over_high();
+	mem_cgroup_handle_over_high(GFP_KERNEL);
 	blkcg_maybe_throttle_current();
 
 	rseq_handle_notify_resume(NULL, regs);
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2559,7 +2559,7 @@ static unsigned long calculate_high_dela
  * Scheduled by try_charge() to be executed from the userland return path
  * and reclaims memory over the high limit.
  */
-void mem_cgroup_handle_over_high(void)
+void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 {
 	unsigned long penalty_jiffies;
 	unsigned long pflags;
@@ -2587,7 +2587,7 @@ retry_reclaim:
 	 */
 	nr_reclaimed = reclaim_high(memcg,
 				    in_retry ? SWAP_CLUSTER_MAX : nr_pages,
-				    GFP_KERNEL);
+				    gfp_mask);
 
 	/*
 	 * memory.high is breached and reclaim is unable to keep up. Throttle
@@ -2823,7 +2823,7 @@ done_restock:
 	if (current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH &&
 	    !(current->flags & PF_MEMALLOC) &&
 	    gfpflags_allow_blocking(gfp_mask)) {
-		mem_cgroup_handle_over_high();
+		mem_cgroup_handle_over_high(gfp_mask);
 	}
 	return 0;
 }


