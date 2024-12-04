Return-Path: <stable+bounces-98487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640929E4205
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D37164AA8
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2B1233D6D;
	Wed,  4 Dec 2024 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYvF+1sx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9E0233D6A;
	Wed,  4 Dec 2024 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332316; cv=none; b=C0Nv7hZchoQqpg0YndOj2+eInHYMTl4APpGYG5RiYgiXHHpcl6KM1CMWSoy8J3pE6PiQBoULcpze0vnSfyd5evQ6Gnl6sM8lDzL0ELDGgt5+MmFLBZVdilT//EZ8rk0r/djFt+A01r0Zslskv2FYabPi7nFk9rDp2kXF1vU8fnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332316; c=relaxed/simple;
	bh=TbBfQwKdP331oy9aQCT7ZsPcuyQG/3FmklJ1v4p79NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovm87UDmPOX41PBvyyZ3NDb1M6lQRK9rjH0LhlQMp/lG5IAFa1So4pzt5D3wPfmUBLwCqaCCvr4b6Y7D+uG6/mjlsS4WpvqIb2mVrABZdw9evU8RTdCw1ayEbdM9T4vfBFHGhAnHZbATRcXkIPKf7Stdyv2mPtECq3YMMNNLWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYvF+1sx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1EAC4CECD;
	Wed,  4 Dec 2024 17:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332315;
	bh=TbBfQwKdP331oy9aQCT7ZsPcuyQG/3FmklJ1v4p79NE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYvF+1sxLgv8jNgjo0ZBUhdArKk8z8DUTr6f8U9WqnnnxznJIUF/Yc4DZBB6ZqSU4
	 Ip/mqDe+g8CMWTrokRB5zkv9q3/9Z0uHtg0QufuQuoWp/zfPKKQKiBLCSKsyKB7bmG
	 wcy3oJmEc5eIrjJz4ukiDjhkiazTNhtAYjhsrjDTf8sOG8gFuzkT/nCB/HuTxHiLTz
	 gmtdeNhkdCgOPnMnuxaL+itl/QTpnCEKoygcRinELw2r6yAMyNaoVWav2NjDoDgiaX
	 rNcm4XXo0B2AmNwSIc06NNErBiIOLxd9AfpFLNgJB8Aio3fkCep1uNLpHPkKxIU8de
	 LIeOr78AsOyGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Xiuhong Wang <xiuhong.wang@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.12 15/15] f2fs: add a sysfs node to limit max read extent count per-inode
Date: Wed,  4 Dec 2024 11:00:03 -0500
Message-ID: <20241204160010.2216008-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160010.2216008-1-sashal@kernel.org>
References: <20241204160010.2216008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 009a8241a8e5a14ea2dd0b8db42dbf283527dd44 ]

Quoted:
"at this time, there are still 1086911 extent nodes in this zombie
extent tree that need to be cleaned up.

crash_arm64_sprd_v8.0.3++> extent_tree.node_cnt ffffff80896cc500
  node_cnt = {
    counter = 1086911
  },
"

As reported by Xiuhong, there will be a huge number of extent nodes
in extent tree, it may potentially cause:
- slab memory fragments
- extreme long time shrink on extent tree
- low mapping efficiency

Let's add a sysfs node to limit max read extent count for each inode,
by default, value of this threshold is 10240, it can be updated
according to user's requirement.

Reported-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
Closes: https://lore.kernel.org/linux-f2fs-devel/20241112110627.1314632-1-xiuhong.wang@unisoc.com/
Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
 fs/f2fs/extent_cache.c                  |  5 ++++-
 fs/f2fs/f2fs.h                          |  4 ++++
 fs/f2fs/sysfs.c                         | 10 ++++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index fdedf1ea944ba..ccee0fd74dd66 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -819,3 +819,9 @@ Description:	It controls the valid block ratio threshold not to trigger excessiv
 		for zoned deivces. The initial value of it is 95(%). F2FS will stop the
 		background GC thread from intiating GC for sections having valid blocks
 		exceeding the ratio.
+
+What:		/sys/fs/f2fs/<disk>/max_read_extent_count
+Date:		November 2024
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	It controls max read extent count for per-inode, the value of threshold
+		is 10240 by default.
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 368d9cbdea743..fb09c8e9bc573 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -674,7 +674,9 @@ static void __update_extent_tree_range(struct inode *inode,
 		}
 
 		if (end < org_end && (type != EX_READ ||
-				org_end - end >= F2FS_MIN_EXTENT_LEN)) {
+			(org_end - end >= F2FS_MIN_EXTENT_LEN &&
+			atomic_read(&et->node_cnt) <
+					sbi->max_read_extent_count))) {
 			if (parts) {
 				__set_extent_info(&ei,
 					end, org_end - end,
@@ -1169,6 +1171,7 @@ void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi)
 	sbi->hot_data_age_threshold = DEF_HOT_DATA_AGE_THRESHOLD;
 	sbi->warm_data_age_threshold = DEF_WARM_DATA_AGE_THRESHOLD;
 	sbi->last_age_weight = LAST_AGE_WEIGHT;
+	sbi->max_read_extent_count = DEF_MAX_READ_EXTENT_COUNT;
 }
 
 int __init f2fs_create_extent_cache(void)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 33f5449dc22d5..928c10dc7ad58 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -634,6 +634,9 @@ enum {
 #define DEF_HOT_DATA_AGE_THRESHOLD	262144
 #define DEF_WARM_DATA_AGE_THRESHOLD	2621440
 
+/* default max read extent count per inode */
+#define DEF_MAX_READ_EXTENT_COUNT	10240
+
 /* extent cache type */
 enum extent_type {
 	EX_READ,
@@ -1619,6 +1622,7 @@ struct f2fs_sb_info {
 	/* for extent tree cache */
 	struct extent_tree_info extent_tree[NR_EXTENT_CACHES];
 	atomic64_t allocated_data_blocks;	/* for block age extent_cache */
+	unsigned int max_read_extent_count;	/* max read extent count per inode */
 
 	/* The threshold used for hot and warm data seperation*/
 	unsigned int hot_data_age_threshold;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index c56e8c8739352..d9a44f03e558b 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -789,6 +789,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "max_read_extent_count")) {
+		if (t > UINT_MAX)
+			return -EINVAL;
+		*ui = (unsigned int)t;
+		return count;
+	}
+
 	if (!strcmp(a->attr.name, "ipu_policy")) {
 		if (t >= BIT(F2FS_IPU_MAX))
 			return -EINVAL;
@@ -1054,6 +1061,8 @@ F2FS_SBI_GENERAL_RW_ATTR(revoked_atomic_block);
 F2FS_SBI_GENERAL_RW_ATTR(hot_data_age_threshold);
 F2FS_SBI_GENERAL_RW_ATTR(warm_data_age_threshold);
 F2FS_SBI_GENERAL_RW_ATTR(last_age_weight);
+/* read extent cache */
+F2FS_SBI_GENERAL_RW_ATTR(max_read_extent_count);
 #ifdef CONFIG_BLK_DEV_ZONED
 F2FS_SBI_GENERAL_RO_ATTR(unusable_blocks_per_sec);
 F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
@@ -1244,6 +1253,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(hot_data_age_threshold),
 	ATTR_LIST(warm_data_age_threshold),
 	ATTR_LIST(last_age_weight),
+	ATTR_LIST(max_read_extent_count),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.43.0


