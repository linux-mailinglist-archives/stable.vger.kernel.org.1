Return-Path: <stable+bounces-204257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAAACEA4C4
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C781300A281
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7094D21CC7B;
	Tue, 30 Dec 2025 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olewcffW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027E2144C7
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767115201; cv=none; b=UL4bWmaPZGJEpN+11t35AeZ6XhYxPWjbyLB9Z4jDAeZGAnOVbslhZM9mm//gR3Gd/FmTRpTo3x4v2PypcZc0g7d/Dc8PtKng46ErY/X+rMset3q3lMc2nn0uCIj+dmysHfb6tHJ3YgV5sFxaSnsujfU9EdWJSayui2TNYnmHOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767115201; c=relaxed/simple;
	bh=TGsJmtjQTRaC6jw3ylAYf0zEX5SAihRjkE5/uIJw3SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFqv9RAOgEtOHSqfTIz2mHt+SQtcPS/q7vhy3zAV6mDTKl6De56lIYkVJktAoAeUHrHMHedf440iJBpVqkHQgGv5ZD7ooBdJbVN9g4JWrtrOltIC5DXDzwBxAOAQYjvvPL8+qTKt5aXekj0fbfPP91NEkz6MM/ViiLU5WRU5zrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olewcffW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BE6C4CEFB;
	Tue, 30 Dec 2025 17:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767115200;
	bh=TGsJmtjQTRaC6jw3ylAYf0zEX5SAihRjkE5/uIJw3SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=olewcffWqAWg2BiVyMN1xRfbNkhVvajWZqcBrfjJyau1fvKxkZWbQAQLgWYxmvv2m
	 07FrvxZyDAknItEmWGRvgOYulWob1lhVdBZTxrpbUhfqv6LVsSR5cZrmDXAfjWUGzn
	 4Dd+iOG4H2dTyZfpvNRlYohEJsMG7cH3VrEPl8it4/LvhzAn9LfY1CzK/4dDHry3FQ
	 E2gQxGhQAkqGQNV6Xu0IOmkcTYsTk76H5jeSdBjUya6AmkK37OLyLpyu+DvJIru8BI
	 e5B5YDwGTWXb95tBH0qMOFi/puaMICiG7K9kRD4wcftvjZ13xH+AWH1p3RQV+VXSpi
	 zQrUU7z1KdCrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] f2fs: remove unused GC_FAILURE_PIN
Date: Tue, 30 Dec 2025 12:19:55 -0500
Message-ID: <20251230171958.2344337-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122923-tricycle-avatar-86c9@gregkh>
References: <2025122923-tricycle-avatar-86c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 968c4f72b23c0c8f1e94e942eab89b8c5a3022e7 ]

After commit 3db1de0e582c ("f2fs: change the current atomic write way"),
we removed all GC_FAILURE_ATOMIC usage, let's change i_gc_failures[]
array to i_pin_failure for cleanup.

Meanwhile, let's define i_current_depth and i_gc_failures as union
variable due to they won't be valid at the same time.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 10b591e7fb7c ("f2fs: fix to avoid updating compression context during writeback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h     | 14 +++++---------
 fs/f2fs/file.c     | 12 +++++-------
 fs/f2fs/inode.c    |  6 ++----
 fs/f2fs/recovery.c |  3 +--
 4 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d8a32a02bcbc..ef4cb3870e2c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -747,11 +747,6 @@ enum {
 
 #define DEF_DIR_LEVEL		0
 
-enum {
-	GC_FAILURE_PIN,
-	MAX_GC_FAILURE
-};
-
 /* used for f2fs_inode_info->flags */
 enum {
 	FI_NEW_INODE,		/* indicate newly allocated inode */
@@ -797,9 +792,10 @@ struct f2fs_inode_info {
 	unsigned long i_flags;		/* keep an inode flags for ioctl */
 	unsigned char i_advise;		/* use to give file attribute hints */
 	unsigned char i_dir_level;	/* use for dentry level for large dir */
-	unsigned int i_current_depth;	/* only for directory depth */
-	/* for gc failure statistic */
-	unsigned int i_gc_failures[MAX_GC_FAILURE];
+	union {
+		unsigned int i_current_depth;	/* only for directory depth */
+		unsigned int i_gc_failures;	/* for gc failure statistic */
+	};
 	unsigned int i_pino;		/* parent inode number */
 	umode_t i_acl_mode;		/* keep file acl mode temporarily */
 
@@ -3100,7 +3096,7 @@ static inline void f2fs_i_depth_write(struct inode *inode, unsigned int depth)
 static inline void f2fs_i_gc_failures_write(struct inode *inode,
 					unsigned int count)
 {
-	F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN] = count;
+	F2FS_I(inode)->i_gc_failures = count;
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6228a4827de3..13ce7d9ee911 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3245,13 +3245,11 @@ int f2fs_pin_file_control(struct inode *inode, bool inc)
 
 	/* Use i_gc_failures for normal file as a risk signal. */
 	if (inc)
-		f2fs_i_gc_failures_write(inode,
-				fi->i_gc_failures[GC_FAILURE_PIN] + 1);
+		f2fs_i_gc_failures_write(inode, fi->i_gc_failures + 1);
 
-	if (fi->i_gc_failures[GC_FAILURE_PIN] > sbi->gc_pin_file_threshold) {
+	if (fi->i_gc_failures > sbi->gc_pin_file_threshold) {
 		f2fs_warn(sbi, "%s: Enable GC = ino %lx after %x GC trials",
-			  __func__, inode->i_ino,
-			  fi->i_gc_failures[GC_FAILURE_PIN]);
+			  __func__, inode->i_ino, fi->i_gc_failures);
 		clear_inode_flag(inode, FI_PIN_FILE);
 		return -EAGAIN;
 	}
@@ -3310,7 +3308,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	}
 
 	set_inode_flag(inode, FI_PIN_FILE);
-	ret = F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN];
+	ret = F2FS_I(inode)->i_gc_failures;
 done:
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 out:
@@ -3325,7 +3323,7 @@ static int f2fs_ioc_get_pin_file(struct file *filp, unsigned long arg)
 	__u32 pin = 0;
 
 	if (is_inode_flag_set(inode, FI_PIN_FILE))
-		pin = F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN];
+		pin = F2FS_I(inode)->i_gc_failures;
 	return put_user(pin, (u32 __user *)arg);
 }
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 020a3249c9c9..3d189732c891 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -362,8 +362,7 @@ static int do_read_inode(struct inode *inode)
 	if (S_ISDIR(inode->i_mode))
 		fi->i_current_depth = le32_to_cpu(ri->i_current_depth);
 	else if (S_ISREG(inode->i_mode))
-		fi->i_gc_failures[GC_FAILURE_PIN] =
-					le16_to_cpu(ri->i_gc_failures);
+		fi->i_gc_failures = le16_to_cpu(ri->i_gc_failures);
 	fi->i_xattr_nid = le32_to_cpu(ri->i_xattr_nid);
 	fi->i_flags = le32_to_cpu(ri->i_flags);
 	if (S_ISREG(inode->i_mode))
@@ -623,8 +622,7 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 		ri->i_current_depth =
 			cpu_to_le32(F2FS_I(inode)->i_current_depth);
 	else if (S_ISREG(inode->i_mode))
-		ri->i_gc_failures =
-			cpu_to_le16(F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN]);
+		ri->i_gc_failures = cpu_to_le16(F2FS_I(inode)->i_gc_failures);
 	ri->i_xattr_nid = cpu_to_le32(F2FS_I(inode)->i_xattr_nid);
 	ri->i_flags = cpu_to_le32(F2FS_I(inode)->i_flags);
 	ri->i_pino = cpu_to_le32(F2FS_I(inode)->i_pino);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index f5efc37a2b51..091c480877d6 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -330,8 +330,7 @@ static int recover_inode(struct inode *inode, struct page *page)
 	F2FS_I(inode)->i_advise = raw->i_advise;
 	F2FS_I(inode)->i_flags = le32_to_cpu(raw->i_flags);
 	f2fs_set_inode_flags(inode);
-	F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN] =
-				le16_to_cpu(raw->i_gc_failures);
+	F2FS_I(inode)->i_gc_failures = le16_to_cpu(raw->i_gc_failures);
 
 	recover_inline_flags(inode, raw);
 
-- 
2.51.0


