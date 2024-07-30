Return-Path: <stable+bounces-62769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F2E941212
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE45FB23B76
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9C419F466;
	Tue, 30 Jul 2024 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz1RENcm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD16119EEC6;
	Tue, 30 Jul 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343346; cv=none; b=iGvIIXiT/6418saOvEtKO4x7xgDrSebufHBM7KOhG0sBidrrDQRJctB50oiGIX46MmazyW36YkcEGLXzPKK+Vgb7SGzqCruQ3E2drZPTdXtB8INuYkPKwY+u9bsQqHY+fa68QxFax+2QlkejQkikp94bbiuRNekhUxIOITJP0MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343346; c=relaxed/simple;
	bh=Vd9doB38uRFtLMvEbw1L6Px6u/grH0Gwqhi0wzlAkMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcSIYOZ5DUC5vpUDvNmrEVbmUPUTbcDuyD0CHQNrAPUtRKmqh7bVPNfESSZ1zZaUSUDIH7COpjhoU2FtseBKhyxkiOn9kiqmBRxwH0bK7kNanVKkhWP3OTBl8GGA1qocXXGyACwTpWJ8CGxjbvYk1LoPeMjlbYHpKCfmp3bX5O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz1RENcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A110C4AF0A;
	Tue, 30 Jul 2024 12:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343346;
	bh=Vd9doB38uRFtLMvEbw1L6Px6u/grH0Gwqhi0wzlAkMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pz1RENcmUIUGFWjxflyKTu2qHpLx94se7M97kIXJWinxE4u03ElsynYFhh8yp4rN5
	 Eholj/25FnHrAHHdd6RKbT1+t4ULSxz7a/Xj7OYXvuTwesKVGEgHSxbAifOM1XJchW
	 7sEO3n0bVIfdR8ixutb1axPikwM/5J4xpYMNJs+1q0iN/qi8w3xUwnRdDUNh7vB295
	 cvKluoHCZlEYNKE1qkkZxu7DryTPPPOYg8aWs1H4aNtwUWXDx+eO0bsU7Vdr+uaC7h
	 HiY8VXcjU9I2Sn8HQniuXgJGsJ+ZwqSufjOTIVj0zmIkYHxweYkQQj5k5ICTrVHQFO
	 vrVLITGxeulJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.10 2/3] fs/ntfs3: Do copy_to_user out of run_lock
Date: Tue, 30 Jul 2024 08:42:20 -0400
Message-ID: <20240730124222.3083443-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730124222.3083443-1-sashal@kernel.org>
References: <20240730124222.3083443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit d57431c6f511bf020e474026d9f3123d7bfbea8c ]

In order not to call copy_to_user (from fiemap_fill_next_extent)
we allocate memory in the kernel, fill it and copy it to user memory
after up_read(run_lock).

Reported-by: syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 75 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 0008670939a4a..26fe351fc0e38 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1896,6 +1896,47 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
 	return REPARSE_LINK;
 }
 
+/*
+ * fiemap_fill_next_extent_k - a copy of fiemap_fill_next_extent
+ * but it accepts kernel address for fi_extents_start
+ */
+static int fiemap_fill_next_extent_k(struct fiemap_extent_info *fieinfo,
+				     u64 logical, u64 phys, u64 len, u32 flags)
+{
+	struct fiemap_extent extent;
+	struct fiemap_extent __user *dest = fieinfo->fi_extents_start;
+
+	/* only count the extents */
+	if (fieinfo->fi_extents_max == 0) {
+		fieinfo->fi_extents_mapped++;
+		return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
+	}
+
+	if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
+		return 1;
+
+	if (flags & FIEMAP_EXTENT_DELALLOC)
+		flags |= FIEMAP_EXTENT_UNKNOWN;
+	if (flags & FIEMAP_EXTENT_DATA_ENCRYPTED)
+		flags |= FIEMAP_EXTENT_ENCODED;
+	if (flags & (FIEMAP_EXTENT_DATA_TAIL | FIEMAP_EXTENT_DATA_INLINE))
+		flags |= FIEMAP_EXTENT_NOT_ALIGNED;
+
+	memset(&extent, 0, sizeof(extent));
+	extent.fe_logical = logical;
+	extent.fe_physical = phys;
+	extent.fe_length = len;
+	extent.fe_flags = flags;
+
+	dest += fieinfo->fi_extents_mapped;
+	memcpy(dest, &extent, sizeof(extent));
+
+	fieinfo->fi_extents_mapped++;
+	if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
+		return 1;
+	return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
+}
+
 /*
  * ni_fiemap - Helper for file_fiemap().
  *
@@ -1906,6 +1947,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	      __u64 vbo, __u64 len)
 {
 	int err = 0;
+	struct fiemap_extent __user *fe_u = fieinfo->fi_extents_start;
+	struct fiemap_extent *fe_k = NULL;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	u8 cluster_bits = sbi->cluster_bits;
 	struct runs_tree *run;
@@ -1953,6 +1996,18 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		goto out;
 	}
 
+	/*
+	 * To avoid lock problems replace pointer to user memory by pointer to kernel memory.
+	 */
+	fe_k = kmalloc_array(fieinfo->fi_extents_max,
+			     sizeof(struct fiemap_extent),
+			     GFP_NOFS | __GFP_ZERO);
+	if (!fe_k) {
+		err = -ENOMEM;
+		goto out;
+	}
+	fieinfo->fi_extents_start = fe_k;
+
 	end = vbo + len;
 	alloc_size = le64_to_cpu(attr->nres.alloc_size);
 	if (end > alloc_size)
@@ -2041,8 +2096,9 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 			if (vbo + dlen >= end)
 				flags |= FIEMAP_EXTENT_LAST;
 
-			err = fiemap_fill_next_extent(fieinfo, vbo, lbo, dlen,
-						      flags);
+			err = fiemap_fill_next_extent_k(fieinfo, vbo, lbo, dlen,
+							flags);
+
 			if (err < 0)
 				break;
 			if (err == 1) {
@@ -2062,7 +2118,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		if (vbo + bytes >= end)
 			flags |= FIEMAP_EXTENT_LAST;
 
-		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, flags);
+		err = fiemap_fill_next_extent_k(fieinfo, vbo, lbo, bytes,
+						flags);
 		if (err < 0)
 			break;
 		if (err == 1) {
@@ -2075,7 +2132,19 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 
 	up_read(run_lock);
 
+	/*
+	 * Copy to user memory out of lock
+	 */
+	if (copy_to_user(fe_u, fe_k,
+			 fieinfo->fi_extents_max *
+				 sizeof(struct fiemap_extent))) {
+		err = -EFAULT;
+	}
+
 out:
+	/* Restore original pointer. */
+	fieinfo->fi_extents_start = fe_u;
+	kfree(fe_k);
 	return err;
 }
 
-- 
2.43.0


