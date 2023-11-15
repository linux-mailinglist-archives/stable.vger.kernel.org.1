Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF897E250E
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjKFN1r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjKFN1q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:27:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4AFD8
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:27:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F144C433C7;
        Mon,  6 Nov 2023 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277263;
        bh=2Kvl9NCzCFudjfr91Z2b2H/YwcsThy08fi6K6yTyeMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tndw2fLK3iwMYL8zw7WRUGr6zVnaw0ezzy9GPcFQXSXhYvnlCTBgQx2JA8uoeizM1
         roKOLymVzCFAhisVXY0FsmPDQMgmFAeVSp7JzhbHxmwG5ja+MYL0Y4A5FzkJJfsFJm
         rih92JOzRI+TkY8asek1v4MIGXOmw5UTuNjVKEZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Baokun Li <libaokun1@huawei.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.15 064/128] ext4: add two helper functions extent_logical_end() and pa_logical_end()
Date:   Mon,  6 Nov 2023 14:03:44 +0100
Message-ID: <20231106130312.009272711@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

commit 43bbddc067883d94de7a43d5756a295439fbe37d upstream.

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
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/mballoc.c |    7 +++----
 fs/ext4/mballoc.h |   14 ++++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4079,7 +4079,7 @@ ext4_mb_normalize_request(struct ext4_al
 
 	/* first, let's learn actual file size
 	 * given current request is allocated */
-	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
+	size = extent_logical_end(sbi, &ac->ac_o_ex);
 	size = size << bsbits;
 	if (size < i_size_read(ac->ac_inode))
 		size = i_size_read(ac->ac_inode);
@@ -4419,8 +4419,7 @@ ext4_mb_use_preallocated(struct ext4_all
 		/* all fields in this condition don't change,
 		 * so we can skip locking for them */
 		if (ac->ac_o_ex.fe_logical < pa->pa_lstart ||
-		    ac->ac_o_ex.fe_logical >= (pa->pa_lstart +
-					       EXT4_C2B(sbi, pa->pa_len)))
+		    ac->ac_o_ex.fe_logical >= pa_logical_end(sbi, pa))
 			continue;
 
 		/* non-extent files can't have physical blocks past 2^32 */
@@ -5241,7 +5240,7 @@ static void ext4_mb_group_or_file(struct
 
 	group_pa_eligible = sbi->s_mb_group_prealloc > 0;
 	inode_pa_eligible = true;
-	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
+	size = extent_logical_end(sbi, &ac->ac_o_ex);
 	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
 		>> bsbits;
 
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -219,6 +219,20 @@ static inline ext4_fsblk_t ext4_grp_offs
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


