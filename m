Return-Path: <stable+bounces-139241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37D6AA5765
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D84504858
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D262D269A;
	Wed, 30 Apr 2025 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOwrVT/y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D02D110A
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048448; cv=none; b=fXeq6sPKhhQFeEnmpjt621soDIG8+TpWjFGkX6gK8Lu3dir+sNNdtQctoR+H6Sk3ycKwDssrvKancGNdgKMRe7UV9WLge/DDF9m10Mr9MptIUkEhsd64w4qWAk1EYJO1pgmQ0qRNqy6gtbSE0LyqeGIpMHf5cDlKZAjrfxAkXWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048448; c=relaxed/simple;
	bh=vjYRyg4aMFCXTWJe7tba++dQVx7KTufXr8gbgwaI7Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/G3oyrUPsVEdIN4sFa+MZ7Nvrjm+grPkDY5YE0C/ooguTLm3INUVnp8hdLW19ABUwn/RN4DnvtW7mR9lq/1PqMI07TEf9hiXbszD4vyEffaz/9ymkYaJLRVMLFBygX/yiOzohwWJSBrWKY9DNGehk4thtJ/arD2s6qw5XTF/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOwrVT/y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736c062b1f5so472649b3a.0
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048446; x=1746653246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrO2wtCqcWxS1DHJvoG7hXESNHyGSu2HBALasRbxkoY=;
        b=ZOwrVT/yvJ49Batx62J691Kj7O0wuanVrKdajjO46viTrpw95er9CZE00qtdbx+Ukj
         09e1yODmDzyniinUkdPxBtRbKSy8VXImVS80R6hpwlgQAD1vMPLqxY1viJQ9JXDB/rsm
         mJEQnqJERfk1FiRGL2Hm8l1rJYEpsyq45cHwZRaY8MCioSGI5iGyi5XWpR35rCERlwOV
         XvKWAVGhgf2jOsLcMJQ8z8AAoylDPolO0coq1XUO1CL8Yvn7CLbkJHBVeeZgnNB7ytnS
         BLlrrWuvuTBppp28/nYA2iFtOeOCes0DAt27Q+0twzVWLWgPuNd4gaWMzvQSP/wJT4Ha
         FD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048446; x=1746653246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrO2wtCqcWxS1DHJvoG7hXESNHyGSu2HBALasRbxkoY=;
        b=q+g5prgTEqh2LFCTgOxCDUM45xn54HOAo3r0H23PeXuZq7JZRtI0c3efvINUrM6/2T
         2+C1vb4YMvTV8xn7yi1wvbi4o6ys0TsCYrbmvEtuLrm7WVQmatOBj2LN/YcjXV5++yBE
         /jQxiWKuAYm1daAJNP99o8PnbrxIMST7SBJxeS+LRyqUHnorooZWFjbasrKSgHYFIET4
         pDJLFTQz558ggwyQmgceYCJkyZjwRHUraXI9qccNQXuaFizGZdPDLQ090Z7AahmMEUZI
         bYBYIf1Z3RB4ktsXodfbuAiXYjwlzHvH52MxOYuus6TJzWkjhb1sQLWX5O3Ppfatt0lY
         OgIg==
X-Gm-Message-State: AOJu0Yxi8IdRoEQMkSTK0eVVDs2uRB32kTX3EJlFy5rfkiPkGEQPalhQ
	9M3G46ax9mk5AHx2gp0S4Lw0Yozi6UNnrV6fSBxJeCp4k+6n8hSHK0u5hgT1
X-Gm-Gg: ASbGncuzF0RdkdkpC3TyhItC+tas6ojXHygW1Ki2qL1KF+ohRDZOdXFCNlUtCS75wBj
	yP4z/Y8Ys2GdPiDQm3MUH1Vhw6w9Z968rhjDmgSUwKkgl80rQ3zEFZP+6/iBcnlyjO453BoUEuF
	C0e+Sh4n1lJNkmfqboFoZH5Nkc/ChSm7lKF4punuxVE23pfjb1kQmIapP8CalB/qx5AgoY42h/d
	2HWPa+IbV9BgIfrrGqJDb16U3CxXlvK0QUpgcN0jTDJh/uZ8keP87K3YuByRQnL+W0rZgY7k275
	CWsC/U26KE1fxzXSZp0ucJlr4OILlWr08TDF+/VuQSy9XgVDhEt66Waf6Q8SooLUelLd
X-Google-Smtp-Source: AGHT+IHAcmAAUzZQMzogz70VVC1fptpbxtocOXT1EXnHgLloXkeJE2SCeIxdhj9SR+1CTJleDAtE+w==
X-Received: by 2002:a05:6a00:3a10:b0:736:69aa:112c with SMTP id d2e1a72fcca58-740491d1385mr42964b3a.9.1746048445848;
        Wed, 30 Apr 2025 14:27:25 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:25 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 14/16] xfs: fix freeing speculative preallocations for preallocated files
Date: Wed, 30 Apr 2025 14:27:01 -0700
Message-ID: <20250430212704.2905795-15-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430212704.2905795-1-leah.rumancik@gmail.com>
References: <20250430212704.2905795-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 610b29161b0aa9feb59b78dc867553274f17fb01 ]

xfs_can_free_eofblocks returns false for files that have persistent
preallocations unless the force flag is passed and there are delayed
blocks.  This means it won't free delalloc reservations for files
with persistent preallocations unless the force flag is set, and it
will also free the persistent preallocations if the force flag is
set and the file happens to have delayed allocations.

Both of these are bad, so do away with the force flag and always free
only post-EOF delayed allocations for files with the XFS_DIFLAG_PREALLOC
or APPEND flags set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c | 30 ++++++++++++++++++++++--------
 fs/xfs/xfs_bmap_util.h |  2 +-
 fs/xfs/xfs_icache.c    |  2 +-
 fs/xfs/xfs_inode.c     | 14 ++++----------
 4 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 399451aab26a..62b92e92a685 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -634,17 +634,15 @@ xfs_bmap_punch_delalloc_range(
 	return error;
 }
 
 /*
  * Test whether it is appropriate to check an inode for and free post EOF
- * blocks. The 'force' parameter determines whether we should also consider
- * regular files that are marked preallocated or append-only.
+ * blocks.
  */
 bool
 xfs_can_free_eofblocks(
-	struct xfs_inode	*ip,
-	bool			force)
+	struct xfs_inode	*ip)
 {
 	struct xfs_bmbt_irec	imap;
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		end_fsb;
 	xfs_fileoff_t		last_fsb;
@@ -674,15 +672,15 @@ xfs_can_free_eofblocks(
 	/* If we haven't read in the extent list, then don't do it now. */
 	if (xfs_need_iread_extents(&ip->i_df))
 		return false;
 
 	/*
-	 * Do not free real preallocated or append-only files unless the file
-	 * has delalloc blocks and we are forced to remove them.
+	 * Only free real extents for inodes with persistent preallocations or
+	 * the append-only flag.
 	 */
 	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND))
-		if (!force || ip->i_delayed_blks == 0)
+		if (ip->i_delayed_blks == 0)
 			return false;
 
 	/*
 	 * Do not try to free post-EOF blocks if EOF is beyond the end of the
 	 * range supported by the page cache, because the truncation will loop
@@ -732,10 +730,26 @@ xfs_free_eofblocks(
 		return error;
 
 	/* Wait on dio to ensure i_size has settled. */
 	inode_dio_wait(VFS_I(ip));
 
+	/*
+	 * For preallocated files only free delayed allocations.
+	 *
+	 * Note that this means we also leave speculative preallocations in
+	 * place for preallocated files.
+	 */
+	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND)) {
+		if (ip->i_delayed_blks) {
+			xfs_bmap_punch_delalloc_range(ip,
+				round_up(XFS_ISIZE(ip), mp->m_sb.sb_blocksize),
+				LLONG_MAX);
+		}
+		xfs_inode_clear_eofblocks_tag(ip);
+		return 0;
+	}
+
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
 	if (error) {
 		ASSERT(xfs_is_shutdown(mp));
 		return error;
 	}
@@ -1046,11 +1060,11 @@ xfs_prepare_shift(
 
 	/*
 	 * Trim eofblocks to avoid shifting uninitialized post-eof preallocation
 	 * into the accessible region of the file.
 	 */
-	if (xfs_can_free_eofblocks(ip, true)) {
+	if (xfs_can_free_eofblocks(ip)) {
 		error = xfs_free_eofblocks(ip);
 		if (error)
 			return error;
 	}
 
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index 6888078f5c31..1383019ccdb7 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -61,11 +61,11 @@ int	xfs_collapse_file_space(struct xfs_inode *, xfs_off_t offset,
 				xfs_off_t len);
 int	xfs_insert_file_space(struct xfs_inode *, xfs_off_t offset,
 				xfs_off_t len);
 
 /* EOF block manipulation functions */
-bool	xfs_can_free_eofblocks(struct xfs_inode *ip, bool force);
+bool	xfs_can_free_eofblocks(struct xfs_inode *ip);
 int	xfs_free_eofblocks(struct xfs_inode *ip);
 
 int	xfs_swap_extents(struct xfs_inode *ip, struct xfs_inode *tip,
 			 struct xfs_swapext *sx);
 
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 6df826fc787c..586d26c05160 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1184,11 +1184,11 @@ xfs_inode_free_eofblocks(
 			return -EAGAIN;
 		return 0;
 	}
 	*lockflags |= XFS_IOLOCK_EXCL;
 
-	if (xfs_can_free_eofblocks(ip, false))
+	if (xfs_can_free_eofblocks(ip))
 		return xfs_free_eofblocks(ip);
 
 	/* inode could be preallocated or append-only */
 	trace_xfs_inode_free_eofblocks_invalid(ip);
 	xfs_inode_clear_eofblocks_tag(ip);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 26961b0dae03..b26d26d29273 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1457,11 +1457,11 @@ xfs_release(
 	 * dropped, so we'll never leak blocks permanently.
 	 */
 	if (!xfs_ilock_nowait(ip, XFS_IOLOCK_EXCL))
 		return 0;
 
-	if (xfs_can_free_eofblocks(ip, false)) {
+	if (xfs_can_free_eofblocks(ip)) {
 		/*
 		 * Check if the inode is being opened, written and closed
 		 * frequently and we have delayed allocation blocks outstanding
 		 * (e.g. streaming writes from the NFS server), truncating the
 		 * blocks past EOF will cause fragmentation to occur.
@@ -1673,19 +1673,17 @@ xfs_inode_needs_inactive(
 	if (VFS_I(ip)->i_nlink == 0)
 		return true;
 
 	/*
 	 * This file isn't being freed, so check if there are post-eof blocks
-	 * to free.  @force is true because we are evicting an inode from the
-	 * cache.  Post-eof blocks must be freed, lest we end up with broken
-	 * free space accounting.
+	 * to free.
 	 *
 	 * Note: don't bother with iolock here since lockdep complains about
 	 * acquiring it in reclaim context. We have the only reference to the
 	 * inode at this point anyways.
 	 */
-	return xfs_can_free_eofblocks(ip, true);
+	return xfs_can_free_eofblocks(ip);
 }
 
 /*
  * xfs_inactive
  *
@@ -1732,19 +1730,15 @@ xfs_inactive(
 			goto out;
 	}
 
 	if (VFS_I(ip)->i_nlink != 0) {
 		/*
-		 * force is true because we are evicting an inode from the
-		 * cache. Post-eof blocks must be freed, lest we end up with
-		 * broken free space accounting.
-		 *
 		 * Note: don't bother with iolock here since lockdep complains
 		 * about acquiring it in reclaim context. We have the only
 		 * reference to the inode at this point anyways.
 		 */
-		if (xfs_can_free_eofblocks(ip, true))
+		if (xfs_can_free_eofblocks(ip))
 			error = xfs_free_eofblocks(ip);
 
 		goto out;
 	}
 
-- 
2.49.0.906.g1f30a19c02-goog


