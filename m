Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ECF7A2FED
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbjIPMQU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjIPMPu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:15:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDE0194
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:15:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965BCC433C8;
        Sat, 16 Sep 2023 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694866545;
        bh=oim1sA+BTvo+0TSNH2lts2QGvg356cZFaB8rqZyqFKI=;
        h=Subject:To:Cc:From:Date:From;
        b=kxKbXcCo+jWwJwWK7NHodBiZAQURaZZbhbqhdGvSOQ68FWOULlXiDCkR+0j1xxuzZ
         ebneoDBLqRjm5mMV2ROwvtIeDl+Wq0d4JvJ7aHsPuZYgPr7dfTJXXzzqL/bMzxi8uf
         PBuockyqteajpG59wRtBZ5FF0Dne1gLd5cFfR5PA=
Subject: FAILED: patch "[PATCH] ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow" failed to apply to 6.1-stable tree
To:     libaokun1@huawei.com, ritesh.list@gmail.com, tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:15:42 +0200
Message-ID: <2023091642-shucking-scant-a1b0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x bc056e7163ac7db945366de219745cf94f32a3e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091642-shucking-scant-a1b0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")
1b4200112108 ("ext4: Avoid scanning smaller extents in BG during CR1")
3ef5d2638796 ("ext4: Add counter to track successful allocation of goal length")
4eb7a4a1a33b ("ext4: Convert mballoc cr (criteria) to enum")
c3defd99d58c ("ext4: treat stripe in block unit")
361eb69fc99f ("ext4: Remove the logic to trim inode PAs")
3872778664e3 ("ext4: Use rbtrees to manage PAs instead of inode i_prealloc_list")
a8e38fd37cff ("ext4: Convert pa->pa_inode_list and pa->pa_obj_lock into a union")
93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
0830344c953a ("ext4: Abstract out overlap fix/check logic in ext4_mb_normalize_request()")
7692094ac513 ("ext4: Move overlap assert logic into a separate function")
bcf434992145 ("ext4: Refactor code in ext4_mb_normalize_request() and ext4_mb_use_preallocated()")
e86a718228b6 ("ext4: Stop searching if PA doesn't satisfy non-extent file")
91a48aaf59d0 ("ext4: avoid unnecessary pointer dereference in ext4_mb_normalize_request")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bc056e7163ac7db945366de219745cf94f32a3e6 Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun1@huawei.com>
Date: Mon, 24 Jul 2023 20:10:58 +0800
Subject: [PATCH] ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow

When we calculate the end position of ext4_free_extent, this position may
be exactly where ext4_lblk_t (i.e. uint) overflows. For example, if
ac_g_ex.fe_logical is 4294965248 and ac_orig_goal_len is 2048, then the
computed end is 0x100000000, which is 0. If ac->ac_o_ex.fe_logical is not
the first case of adjusting the best extent, that is, new_bex_end > 0, the
following BUG_ON will be triggered:

=========================================================
kernel BUG at fs/ext4/mballoc.c:5116!
invalid opcode: 0000 [#1] PREEMPT SMP PTI
CPU: 3 PID: 673 Comm: xfs_io Tainted: G E 6.5.0-rc1+ #279
RIP: 0010:ext4_mb_new_inode_pa+0xc5/0x430
Call Trace:
 <TASK>
 ext4_mb_use_best_found+0x203/0x2f0
 ext4_mb_try_best_found+0x163/0x240
 ext4_mb_regular_allocator+0x158/0x1550
 ext4_mb_new_blocks+0x86a/0xe10
 ext4_ext_map_blocks+0xb0c/0x13a0
 ext4_map_blocks+0x2cd/0x8f0
 ext4_iomap_begin+0x27b/0x400
 iomap_iter+0x222/0x3d0
 __iomap_dio_rw+0x243/0xcb0
 iomap_dio_rw+0x16/0x80
=========================================================

A simple reproducer demonstrating the problem:

	mkfs.ext4 -F /dev/sda -b 4096 100M
	mount /dev/sda /tmp/test
	fallocate -l1M /tmp/test/tmp
	fallocate -l10M /tmp/test/file
	fallocate -i -o 1M -l16777203M /tmp/test/file
	fsstress -d /tmp/test -l 0 -n 100000 -p 8 &
	sleep 10 && killall -9 fsstress
	rm -f /tmp/test/tmp
	xfs_io -c "open -ad /tmp/test/file" -c "pwrite -S 0xff 0 8192"

We simply refactor the logic for adjusting the best extent by adding
a temporary ext4_free_extent ex and use extent_logical_end() to avoid
overflow, which also simplifies the code.

Cc: stable@kernel.org # 6.4
Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Link: https://lore.kernel.org/r/20230724121059.11834-3-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 4cb13b3e41b3..86bce870dc5a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5177,8 +5177,11 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	pa = ac->ac_pa;
 
 	if (ac->ac_b_ex.fe_len < ac->ac_orig_goal_len) {
-		int new_bex_start;
-		int new_bex_end;
+		struct ext4_free_extent ex = {
+			.fe_logical = ac->ac_g_ex.fe_logical,
+			.fe_len = ac->ac_orig_goal_len,
+		};
+		loff_t orig_goal_end = extent_logical_end(sbi, &ex);
 
 		/* we can't allocate as much as normalizer wants.
 		 * so, found space must get proper lstart
@@ -5197,29 +5200,23 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		 *    still cover original start
 		 * 3. Else, keep the best ex at start of original request.
 		 */
-		new_bex_end = ac->ac_g_ex.fe_logical +
-			EXT4_C2B(sbi, ac->ac_orig_goal_len);
-		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
-		if (ac->ac_o_ex.fe_logical >= new_bex_start)
-			goto adjust_bex;
+		ex.fe_len = ac->ac_b_ex.fe_len;
 
-		new_bex_start = ac->ac_g_ex.fe_logical;
-		new_bex_end =
-			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
-		if (ac->ac_o_ex.fe_logical < new_bex_end)
+		ex.fe_logical = orig_goal_end - EXT4_C2B(sbi, ex.fe_len);
+		if (ac->ac_o_ex.fe_logical >= ex.fe_logical)
 			goto adjust_bex;
 
-		new_bex_start = ac->ac_o_ex.fe_logical;
-		new_bex_end =
-			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
+		ex.fe_logical = ac->ac_g_ex.fe_logical;
+		if (ac->ac_o_ex.fe_logical < extent_logical_end(sbi, &ex))
+			goto adjust_bex;
 
+		ex.fe_logical = ac->ac_o_ex.fe_logical;
 adjust_bex:
-		ac->ac_b_ex.fe_logical = new_bex_start;
+		ac->ac_b_ex.fe_logical = ex.fe_logical;
 
 		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
 		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
-		BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
-				      EXT4_C2B(sbi, ac->ac_orig_goal_len)));
+		BUG_ON(extent_logical_end(sbi, &ex) > orig_goal_end);
 	}
 
 	pa->pa_lstart = ac->ac_b_ex.fe_logical;

