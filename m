Return-Path: <stable+bounces-62775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2E4941223
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FD62B2984F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39921A0AE7;
	Tue, 30 Jul 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNXG8ekU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E99819F48D;
	Tue, 30 Jul 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343362; cv=none; b=VGfkVmZM98IkGtgk3mxhxuJHwBMlwDL+gw07LX9TgNiXA1cojHiebEX4lCvozu0ROmXpR+Pmgiqcy6HzNWUXOSb2pBGLxMwU/TMNgXLVS5hMxbpXf+RByHBJSKYOax66tTfD4YvqdvpAlyjN46+E8kH4Z4SJUJZRleMynpisvZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343362; c=relaxed/simple;
	bh=DCK/ubdDeaFKKNT6RWWyUl622qsk4lSOqGAigtkhg4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pgSHGpvU+cqry+Fuqoyy93uMl5xRHQOPYVNGPRCquel4kjv8kQszsoy5YcmsFmFYaatnG/v1wOTJOK3Ifm4hutYUvFWgbkhBQkmY2NCrkKHoBqBitHY/97LwSn7V+NsFP8kqtl3UMwTAXmtBDZjb60g4Wq77lYwTjolxa0TDG2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNXG8ekU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78F6C32782;
	Tue, 30 Jul 2024 12:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343362;
	bh=DCK/ubdDeaFKKNT6RWWyUl622qsk4lSOqGAigtkhg4Y=;
	h=From:To:Cc:Subject:Date:From;
	b=PNXG8ekURtyOzCqRHrYCWzaIBYmT6BGbS4sa5hFvL6EDh44AG69jL1n+DvBLd7JkW
	 qWyHSuSigDMsHg6zC4ym8m6N5r7iZNI/NweV6qqMwT+BKAyThcHIFAfxDEI4kNMJtt
	 0hZnp9lBeVgigWGwMJcqeZgaVv1omwhmSiN0P3C/kkhKk/Httwm48ImJsOr4DiaHOY
	 L5KNQvv4rTzSFYbIEYQ5mpiglzHPTvkZvFBPDFv0HQItoiuhQl4CH9RdLiN792VY+N
	 5xXxKFPFf0KQGw5HMkIYl2fh25O6kgOdQ7PIKLEozR62hYBrVyVhLDuBCaYceWprtE
	 0MFJabCXWbiUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 1/2] fs/ntfs3: Do copy_to_user out of run_lock
Date: Tue, 30 Jul 2024 08:42:37 -0400
Message-ID: <20240730124238.3084861-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index b02778cbb1d34..952ad321edff8 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1848,6 +1848,47 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
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
@@ -1858,6 +1899,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	      __u64 vbo, __u64 len)
 {
 	int err = 0;
+	struct fiemap_extent __user *fe_u = fieinfo->fi_extents_start;
+	struct fiemap_extent *fe_k = NULL;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	u8 cluster_bits = sbi->cluster_bits;
 	struct runs_tree *run;
@@ -1905,6 +1948,18 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
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
@@ -1993,8 +2048,9 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
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
@@ -2014,7 +2070,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		if (vbo + bytes >= end)
 			flags |= FIEMAP_EXTENT_LAST;
 
-		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, flags);
+		err = fiemap_fill_next_extent_k(fieinfo, vbo, lbo, bytes,
+						flags);
 		if (err < 0)
 			break;
 		if (err == 1) {
@@ -2027,7 +2084,19 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 
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


