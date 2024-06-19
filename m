Return-Path: <stable+bounces-53851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEF990EAF0
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863111F223C3
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA46145334;
	Wed, 19 Jun 2024 12:20:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370C14372C
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799654; cv=none; b=RIjbOxURVgEJhX0xyj/ZnnwHN6l585Y6etmbOe2SBLyawu3VGHB8BbxDAJTqeAYlyywsLoKwvN9XyQDBZwztxtAt5PeSYuM3Nvm7RyPUzxTb5clAiJBbaUAH1KsP1zbtc6Y1dRBbYljM56hj6FiqbCk0AYd5gT8e0z+EtBDffZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799654; c=relaxed/simple;
	bh=wjNoO/fZeuUHUIOr4SQMOaDqwoX3o/BhygNNf0awXsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQGWWfQ/PSGBpGfffVF3xdPdX0zN/CzgQcV6uFux8nguFWaIT44uWjo4qeqRG3zNavNxPhENXt32i+3AeJ1LYCv6LUF78U8qEkMeXe471dQf+/ZhOjty58MIgR0DVZe5OG8GC0z1kwCQsqSB3FuDUqRVZK7cnXNBCdnHt3DgUu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W42lG1H9tz4f3jZ7
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 20:20:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 084EC1A016E
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 20:20:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCH8A0dzXJmYKiAAQ--.12076S5;
	Wed, 19 Jun 2024 20:20:48 +0800 (CST)
From: libaokun@huaweicloud.com
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 6.6/6.9 v2 2/2] ext4: fix slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists()
Date: Wed, 19 Jun 2024 20:19:52 +0800
Message-Id: <20240619121952.3508695-2-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240619121952.3508695-1-libaokun@huaweicloud.com>
References: <20240619121952.3508695-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH8A0dzXJmYKiAAQ--.12076S5
X-Coremail-Antispam: 1UD129KBjvJXoWxtryUWw48ZF1xXry3tFW5Wrg_yoW7Cw4rpa
	nIyFyxJr4FqryUWrs7C3Z0gw1Fkw4xC3WUXryfXr1xZasrJr1Skr9rtF1YvF1kKrWkZF15
	Xa4jvrWUGrsrWa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhTmDUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQASBV1jkHu0lAADsg

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 13df4d44a3aaabe61cd01d277b6ee23ead2a5206 ]

We can trigger a slab-out-of-bounds with the following commands:

    mkfs.ext4 -F /dev/$disk 10G
    mount /dev/$disk /tmp/test
    echo 2147483647 > /sys/fs/ext4/$disk/mb_group_prealloc
    echo test > /tmp/test/file && sync

==================================================================
BUG: KASAN: slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
Read of size 8 at addr ffff888121b9d0f0 by task kworker/u2:0/11
CPU: 0 PID: 11 Comm: kworker/u2:0 Tainted: GL 6.7.0-next-20240118 #521
Call Trace:
 dump_stack_lvl+0x2c/0x50
 kasan_report+0xb6/0xf0
 ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
 ext4_mb_regular_allocator+0x19e9/0x2370 [ext4]
 ext4_mb_new_blocks+0x88a/0x1370 [ext4]
 ext4_ext_map_blocks+0x14f7/0x2390 [ext4]
 ext4_map_blocks+0x569/0xea0 [ext4]
 ext4_do_writepages+0x10f6/0x1bc0 [ext4]
[...]
==================================================================

The flow of issue triggering is as follows:

// Set s_mb_group_prealloc to 2147483647 via sysfs
ext4_mb_new_blocks
  ext4_mb_normalize_request
    ext4_mb_normalize_group_request
      ac->ac_g_ex.fe_len = EXT4_SB(sb)->s_mb_group_prealloc
  ext4_mb_regular_allocator
    ext4_mb_choose_next_group
      ext4_mb_choose_next_group_best_avail
        mb_avg_fragment_size_order
          order = fls(len) - 2 = 29
        ext4_mb_find_good_group_avg_frag_lists
          frag_list = &sbi->s_mb_avg_fragment_size[order]
          if (list_empty(frag_list)) // Trigger SOOB!

At 4k block size, the length of the s_mb_avg_fragment_size list is 14,
but an oversized s_mb_group_prealloc is set, causing slab-out-of-bounds
to be triggered by an attempt to access an element at index 29.

Add a new attr_id attr_clusters_in_group with values in the range
[0, sbi->s_clusters_per_group] and declare mb_group_prealloc as
that type to fix the issue. In addition avoid returning an order
from mb_avg_fragment_size_order() greater than MB_NUM_ORDERS(sb)
and reduce some useless loops.

Fixes: 7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")
CC: stable@vger.kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://lore.kernel.org/r/20240319113325.3110393-5-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c |  4 ++++
 fs/ext4/sysfs.c   | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 714f83632e3f..66b5a68b0254 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -831,6 +831,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
 		return 0;
 	if (order == MB_NUM_ORDERS(sb))
 		order--;
+	if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
+		order = MB_NUM_ORDERS(sb) - 1;
 	return order;
 }
 
@@ -1008,6 +1010,8 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
 	 * goal length.
 	 */
 	order = fls(ac->ac_g_ex.fe_len) - 1;
+	if (WARN_ON_ONCE(order - 1 > MB_NUM_ORDERS(ac->ac_sb)))
+		order = MB_NUM_ORDERS(ac->ac_sb);
 	min_order = order - sbi->s_mb_best_avail_max_trim_order;
 	if (min_order < 0)
 		min_order = 0;
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index ca820620b974..d65dccb44ed5 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -29,6 +29,7 @@ typedef enum {
 	attr_trigger_test_error,
 	attr_first_error_time,
 	attr_last_error_time,
+	attr_clusters_in_group,
 	attr_feature,
 	attr_pointer_ui,
 	attr_pointer_ul,
@@ -207,13 +208,14 @@ EXT4_ATTR_FUNC(sra_exceeded_retry_limit, 0444);
 
 EXT4_ATTR_OFFSET(inode_readahead_blks, 0644, inode_readahead,
 		 ext4_sb_info, s_inode_readahead_blks);
+EXT4_ATTR_OFFSET(mb_group_prealloc, 0644, clusters_in_group,
+		 ext4_sb_info, s_mb_group_prealloc);
 EXT4_RW_ATTR_SBI_UI(inode_goal, s_inode_goal);
 EXT4_RW_ATTR_SBI_UI(mb_stats, s_mb_stats);
 EXT4_RW_ATTR_SBI_UI(mb_max_to_scan, s_mb_max_to_scan);
 EXT4_RW_ATTR_SBI_UI(mb_min_to_scan, s_mb_min_to_scan);
 EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
 EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
-EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
 EXT4_RW_ATTR_SBI_UI(mb_max_linear_groups, s_mb_max_linear_groups);
 EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
 EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
@@ -392,6 +394,7 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
 				(unsigned long long)
 			percpu_counter_sum(&sbi->s_sra_exceeded_retry_limit));
 	case attr_inode_readahead:
+	case attr_clusters_in_group:
 	case attr_pointer_ui:
 		if (!ptr)
 			return 0;
@@ -469,6 +472,16 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 		else
 			*((unsigned int *) ptr) = t;
 		return len;
+	case attr_clusters_in_group:
+		if (!ptr)
+			return 0;
+		ret = kstrtouint(skip_spaces(buf), 0, &t);
+		if (ret)
+			return ret;
+		if (t > sbi->s_clusters_per_group)
+			return -EINVAL;
+		*((unsigned int *) ptr) = t;
+		return len;
 	case attr_pointer_ul:
 		if (!ptr)
 			return 0;
-- 
2.39.2


