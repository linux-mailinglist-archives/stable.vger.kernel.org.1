Return-Path: <stable+bounces-148530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DF6ACA42F
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668C8188747C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56FF29117D;
	Sun,  1 Jun 2025 23:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5s4yPbR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3F6291174;
	Sun,  1 Jun 2025 23:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820721; cv=none; b=oCxnVynufpQAE7TW88SLMQ/m/DeWeibjdIVe0isngXfHLc7JdpJEYnMMUpETwPEcI0Lkx5hhwuw4Syb0d2vVbr7/dKp1DlQD4x9wSZElWL6iJWY0gH0tqqYo0LCvhwiCESgTwCzmdrCa9+8zrk6R7vS574nk+LIZ76cRwuFSoyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820721; c=relaxed/simple;
	bh=2qQRbc8foWyPk4Ll7hu4nDd6hQ5gzi6GQTZch/QUO2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ofkzCnNVo8LQyu6l4HG9Ov6M34kCUuTmDoo6Y06pgv5Gtt1NZc5jKIErr8NzlBM9+hf7uQGK/+rmUdQQgWL7/y1DrUW75Djy15QiqHzs6Be4LlTh3tkLTw6L3jKAq15Y3Mmze5VSR23vlxed2Hk4h1xlTqBPyR44nftq4T2eCoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5s4yPbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2742C4CEF1;
	Sun,  1 Jun 2025 23:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820720;
	bh=2qQRbc8foWyPk4Ll7hu4nDd6hQ5gzi6GQTZch/QUO2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a5s4yPbRPtdbwvOSdRNDLPlZPLnbn8ag4or+8j8T0wmhtSo/NzjdRncGEA/EeTXIV
	 0oFcV9phL8guzpfGnOvrkyI9VHEbHZbzBRjAhC4r6eXuPRPJbbzaARB/OECncPeC8m
	 2AAEcyVYVJYjASR2OBk/SJlNLMx+6N2NNjSRPgXmexexlNf8j4H2qeQQjdjj/uUvX4
	 /FWJNOtbAjL4jSEFI3eeJ5TINTUsT076qUHVzRTZRVn2AELzPQ0GbPk0FlYx6fM43G
	 mwrlrWt45BPN6o+PhapHJBcGxiYtGmNbzBQGQ8PLvYwfTmIyoLT5ti314zb5Knc5BS
	 LqkZn+hSyEseA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 054/102] ext4: prevent stale extent cache entries caused by concurrent get es_cache
Date: Sun,  1 Jun 2025 19:28:46 -0400
Message-Id: <20250601232937.3510379-54-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232937.3510379-1-sashal@kernel.org>
References: <20250601232937.3510379-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit f22a0ef2231a7d8374bb021eb86404d0e9de5a02 ]

The EXT4_IOC_GET_ES_CACHE and EXT4_IOC_PRECACHE_EXTENTS currently
invokes ext4_ext_precache() to preload the extent cache without holding
the inode's i_rwsem. This can result in stale extent cache entries when
competing with operations such as ext4_collapse_range() which calls
ext4_ext_remove_space() or ext4_ext_shift_extents().

The problem arises when ext4_ext_remove_space() temporarily releases
i_data_sem due to insufficient journal credits. During this interval, a
concurrent EXT4_IOC_GET_ES_CACHE or EXT4_IOC_PRECACHE_EXTENTS may cache
extent entries that are about to be deleted. As a result, these cached
entries become stale and inconsistent with the actual extents.

Loading the extents cache without holding the inode's i_rwsem or the
mapping's invalidate_lock is not permitted besides during the writeback.
Fix this by holding the i_rwsem during EXT4_IOC_GET_ES_CACHE and
EXT4_IOC_PRECACHE_EXTENTS.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20250423085257.122685-6-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my comprehensive analysis of this commit and comparison with
the historical similar commits, here is my assessment: **YES** This
commit should be backported to stable kernel trees for the following
reasons: ## Analysis Summary ### **Type of Bug Fix** This commit
addresses a **race condition** that can lead to **stale extent cache
entries** in the ext4 filesystem. The race occurs between: 1.
`EXT4_IOC_GET_ES_CACHE` and `EXT4_IOC_PRECACHE_EXTENTS` operations 2.
Concurrent `ext4_collapse_range()` operations that call
`ext4_ext_remove_space()` or `ext4_ext_shift_extents()` ### **Technical
Details of the Race** The problem stems from the fact that
`ext4_ext_remove_space()` temporarily releases `i_data_sem` when journal
credits are insufficient. During this critical window: - The extent
precaching operations (`ext4_ext_precache()`) can cache extent entries -
These cached entries are about to be deleted by the ongoing
collapse/shift operation - Result: **stale, inconsistent extent cache
entries** ### **Code Changes Analysis** The fix is **minimal and
surgical**: **In `fs/ext4/extents.c` (ext4_get_es_cache function):**
```c if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) { +
inode_lock_shared(inode); error = ext4_ext_precache(inode); +
inode_unlock_shared(inode); if (error) return error; ``` **In
`fs/ext4/ioctl.c` (EXT4_IOC_PRECACHE_EXTENTS case):** ```c case
EXT4_IOC_PRECACHE_EXTENTS: - return ext4_ext_precache(inode); +{ + int
ret; + + inode_lock_shared(inode); + ret = ext4_ext_precache(inode); +
inode_unlock_shared(inode); + return ret; +} ``` ### **Why This
Qualifies for Backporting** 1. **Important Bug Fix**: Stale extent cache
entries can lead to filesystem inconsistencies and potential data
corruption scenarios. 2. **Minimal Risk**: The changes are extremely
small and contained: - Only adds proper locking around existing
operations - Uses shared locking (`inode_lock_shared`) which allows
concurrent readers - No algorithmic changes or new features 3. **Follows
Established Patterns**: Similar commits in the repository (marked with
"Backport Status: YES") show this pattern: - Similar commit #2: "ext4:
fix data races when using cached status extents" - also deals with
extent cache consistency - Similar commit #3: "ext4: convert to
exclusive lock while inserting delalloc extents" - addresses similar
race conditions with proper locking - Similar commit #4: "ext4: do not
polute the extents cache while shifting extents" - prevents extent cache
corruption during shift operations 4. **Clear Impact**: The commit
message explicitly states this prevents "stale extent cache entries"
which can cause inconsistency with actual extents. 5. **Contained to
Subsystem**: Changes are limited to ext4 extent management and don't
affect other kernel subsystems. 6. **Stable Backport Indicators**: - No
"Cc: stable@" tag is present, but the nature of the fix (race condition
leading to corruption) makes it a good candidate - The fix follows
ext4's established locking protocol requirements - Multiple similar
extent cache race condition fixes have been backported ### **Risk
Assessment** - **Very Low Regression Risk**: Only adds locking
protection, doesn't change functional behavior - **Well-understood
Fix**: The locking pattern matches established ext4 conventions -
**Limited Scope**: Only affects two specific ioctl code paths This
commit represents exactly the type of fix that stable trees are meant
for: a small, safe fix for a real bug that can cause filesystem
corruption without introducing new functionality or architectural
changes.

 fs/ext4/extents.c | 2 ++
 fs/ext4/ioctl.c   | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 478803ed36c6f..4397c841f03b7 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5045,7 +5045,9 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	}
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
+		inode_lock_shared(inode);
 		error = ext4_ext_precache(inode);
+		inode_unlock_shared(inode);
 		if (error)
 			return error;
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7b9ce71c1c815..f5146b274dd81 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1504,8 +1504,14 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return 0;
 	}
 	case EXT4_IOC_PRECACHE_EXTENTS:
-		return ext4_ext_precache(inode);
+	{
+		int ret;
 
+		inode_lock_shared(inode);
+		ret = ext4_ext_precache(inode);
+		inode_unlock_shared(inode);
+		return ret;
+	}
 	case FS_IOC_SET_ENCRYPTION_POLICY:
 		if (!ext4_has_feature_encrypt(sb))
 			return -EOPNOTSUPP;
-- 
2.39.5


