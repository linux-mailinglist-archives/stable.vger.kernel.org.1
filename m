Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC277A7B31
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbjITLt4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjITLt4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:49:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B170DB0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:49:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4C7C433CD;
        Wed, 20 Sep 2023 11:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210589;
        bh=ewBN+g3NDcSnxIk9L7qEIz+Hs9NzKSSiXDqRZ5KkDqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0rdOj29gmOA63I918+uwWcvMgkEYyHYShsnMrANzxXoVo8YLAt9SxkLrGZUXqxAxG
         YUX1OrcUHFCMhFLzM7kmeqXdn7BzYh2TjTCQRnivmEn+4kQChkiEdKHCkABygNT6KB
         wCBIBIVs3Fd+neL0KN34DiAcs+agfsme8fIFnhoU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Baokun Li <libaokun1@huawei.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 097/211] ext4: add two helper functions extent_logical_end() and pa_logical_end()
Date:   Wed, 20 Sep 2023 13:29:01 +0200
Message-ID: <20230920112848.814816189@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 43bbddc067883d94de7a43d5756a295439fbe37d ]

When we use lstart + len to calculate the end of free extent or prealloc
space, it may exceed the maximum value of 4294967295(0xffffffff) supported
by ext4_lblk_t and cause overflow, which may lead to various problems.

Therefore, we add two helper functions, extent_logical_end() and
pa_logical_end(), to limit the type of end to loff_t, and also convert
lstart to loff_t for calculation to avoid overflow.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Link: https://lore.kernel.org/r/20230724121059.11834-2-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c |  9 +++------
 fs/ext4/mballoc.h | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a197ef71b7b02..627c813cf0759 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4433,7 +4433,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 
 	/* first, let's learn actual file size
 	 * given current request is allocated */
-	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
+	size = extent_logical_end(sbi, &ac->ac_o_ex);
 	size = size << bsbits;
 	if (size < i_size_read(ac->ac_inode))
 		size = i_size_read(ac->ac_inode);
@@ -4767,7 +4767,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 	struct ext4_locality_group *lg;
 	struct ext4_prealloc_space *tmp_pa = NULL, *cpa = NULL;
-	loff_t tmp_pa_end;
 	struct rb_node *iter;
 	ext4_fsblk_t goal_block;
 
@@ -4863,9 +4862,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	 * pa can possibly satisfy the request hence check if it overlaps
 	 * original logical start and stop searching if it doesn't.
 	 */
-	tmp_pa_end = (loff_t)tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
-
-	if (ac->ac_o_ex.fe_logical >= tmp_pa_end) {
+	if (ac->ac_o_ex.fe_logical >= pa_logical_end(sbi, tmp_pa)) {
 		spin_unlock(&tmp_pa->pa_lock);
 		goto try_group_pa;
 	}
@@ -5770,7 +5767,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 
 	group_pa_eligible = sbi->s_mb_group_prealloc > 0;
 	inode_pa_eligible = true;
-	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
+	size = extent_logical_end(sbi, &ac->ac_o_ex);
 	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
 		>> bsbits;
 
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index df6b5e7c22741..d7aeb5da7d867 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -233,6 +233,20 @@ static inline ext4_fsblk_t ext4_grp_offs_to_block(struct super_block *sb,
 		(fex->fe_start << EXT4_SB(sb)->s_cluster_bits);
 }
 
+static inline loff_t extent_logical_end(struct ext4_sb_info *sbi,
+					struct ext4_free_extent *fex)
+{
+	/* Use loff_t to avoid end exceeding ext4_lblk_t max. */
+	return (loff_t)fex->fe_logical + EXT4_C2B(sbi, fex->fe_len);
+}
+
+static inline loff_t pa_logical_end(struct ext4_sb_info *sbi,
+				    struct ext4_prealloc_space *pa)
+{
+	/* Use loff_t to avoid end exceeding ext4_lblk_t max. */
+	return (loff_t)pa->pa_lstart + EXT4_C2B(sbi, pa->pa_len);
+}
+
 typedef int (*ext4_mballoc_query_range_fn)(
 	struct super_block		*sb,
 	ext4_group_t			agno,
-- 
2.40.1



