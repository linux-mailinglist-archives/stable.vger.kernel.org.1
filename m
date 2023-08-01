Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C75276AF10
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjHAJo4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjHAJom (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:44:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C244225
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AB426150B
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F827C433CA;
        Tue,  1 Aug 2023 09:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882919;
        bh=K+c6ZgIpMdNOstUWNKAlRjYro6ySQaDe8wh9ZpH11wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDRYw/BjCxrcclSGe3X7guucl8srES3RBFp04xfp5I39rR6aFWQmnDpNrs7vSyRLJ
         V6U/yXr24bwxdzJ4aqtceEGdk0QlDPzwMEFVvCy7kGZO4AnbV+a0Ck7YK5btdqFuWx
         CUEGL7zyBHnH58QAGy46+S1Ws0JwtOHJ08ZoeBCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kemeng Shi <shikemeng@huaweicloud.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 049/239] ext4: add EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated
Date:   Tue,  1 Aug 2023 11:18:33 +0200
Message-ID: <20230801091927.325093666@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit 1eff590489a213a213c57d96b86f48b32cdf8c3a ]

ext4_mb_use_preallocated will ignore the demand to alloc goal blocks,
although the EXT4_MB_HINT_GOAL_ONLY is requested.
For group pa, ext4_mb_group_or_file will not set EXT4_MB_HINT_GROUP_ALLOC
if EXT4_MB_HINT_GOAL_ONLY is set. So we will not alloc goal blocks from
group pa if EXT4_MB_HINT_GOAL_ONLY is set.
For inode pa, ext4_mb_pa_goal_check is added to check if free extent in
found inode pa meets goal blocks when EXT4_MB_HINT_GOAL_ONLY is set.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Suggested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://lore.kernel.org/r/20230603150327.3596033-6-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 9d3de7ee192a ("ext4: fix rbtree traversal bug in ext4_mb_use_preallocated")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index fd4d12c58c3b4..1f4d00a4308dc 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4528,6 +4528,37 @@ ext4_mb_check_group_pa(ext4_fsblk_t goal_block,
 	return pa;
 }
 
+/*
+ * check if found pa meets EXT4_MB_HINT_GOAL_ONLY
+ */
+static bool
+ext4_mb_pa_goal_check(struct ext4_allocation_context *ac,
+		      struct ext4_prealloc_space *pa)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	ext4_fsblk_t start;
+
+	if (likely(!(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY)))
+		return true;
+
+	/*
+	 * If EXT4_MB_HINT_GOAL_ONLY is set, ac_g_ex will not be adjusted
+	 * in ext4_mb_normalize_request and will keep same with ac_o_ex
+	 * from ext4_mb_initialize_context. Choose ac_g_ex here to keep
+	 * consistent with ext4_mb_find_by_goal.
+	 */
+	start = pa->pa_pstart +
+		(ac->ac_g_ex.fe_logical - pa->pa_lstart);
+	if (ext4_grp_offs_to_block(ac->ac_sb, &ac->ac_g_ex) != start)
+		return false;
+
+	if (ac->ac_g_ex.fe_len > pa->pa_len -
+	    EXT4_B2C(sbi, ac->ac_g_ex.fe_logical - pa->pa_lstart))
+		return false;
+
+	return true;
+}
+
 /*
  * search goal blocks in preallocated space
  */
@@ -4578,7 +4609,8 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 
 		/* found preallocated blocks, use them */
 		spin_lock(&tmp_pa->pa_lock);
-		if (tmp_pa->pa_deleted == 0 && tmp_pa->pa_free) {
+		if (tmp_pa->pa_deleted == 0 && tmp_pa->pa_free &&
+		    likely(ext4_mb_pa_goal_check(ac, tmp_pa))) {
 			atomic_inc(&tmp_pa->pa_count);
 			ext4_mb_use_inode_pa(ac, tmp_pa);
 			spin_unlock(&tmp_pa->pa_lock);
-- 
2.39.2



