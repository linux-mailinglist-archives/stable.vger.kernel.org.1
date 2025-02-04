Return-Path: <stable+bounces-112069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5085A26944
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 02:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7141884FCD
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 01:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008658633F;
	Tue,  4 Feb 2025 01:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpexNTx1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA986321;
	Tue,  4 Feb 2025 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631795; cv=none; b=WQoHe5ze/YA4t0Iai2YlNcDCwCfVz5u9rE6QuQLODRUE5Hpwxt2J0GIKCPh0EyCZIxgTDCWFBF0Ap23utw+MiE4QdCbQHKPYXF2Gl2/BW0ZQuSdOy0PJLe7r5V20Z1DkyXFlWBE6reEfb6vH+FyMSRJvBDqxdcZR5hPI7iZh3Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631795; c=relaxed/simple;
	bh=BKX74RxQvj7KO34dJ9SbmqicVrrf7jXE1/V5pa5N27Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B2mLy17c13AsMrCtbO99cEHz5vw9YVGvtrWxVjH5ouDJB9w/RFqvYX8jWZIa6rHi2VGfWBbkNUVq/jhnM+r5crYsbwLeZu3gODJ20OVGKnk2lAcU39t9St6kXHvs+mboxNynlPk13u30+BPfwS6vjxx1xNiP8p1ZeOY4bNhxLhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpexNTx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E29EC4CEE4;
	Tue,  4 Feb 2025 01:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738631795;
	bh=BKX74RxQvj7KO34dJ9SbmqicVrrf7jXE1/V5pa5N27Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpexNTx1OQ4zQ3uouRo6Cf5J3CY2aIIUz+YEyTkoBrV0oMVuJpwBkO/cSfNc802gh
	 6e5XWN8Li2dOeUBErK4OVIbKtwaprWAjjqZ6tyrW0QGOm/JL9UKkVi98Xcwrorwwxi
	 hzlEmMU5OQnVUNLe16CCYXG8OjMb2mAfTQ4XG01INzVKJjj5vfr8CXaGvag0xYC0FL
	 h7WUin52nPzYfjPLWDezWLLaARKhRoAy8y56FEfVSlWwLk5UhtZY7lYvUVDSdV8GJi
	 RcUtq49rZgTnkV2c9T/0zRnGNitQ2U+BLMkFrepKndzAaf9EbZOGWZwP+pPYWNNRTh
	 eTsMWFjeSIg1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.13 2/5] fs/ntfs3: Unify inode corruption marking with _ntfs_bad_inode()
Date: Mon,  3 Feb 2025 20:16:24 -0500
Message-Id: <20250204011627.2206261-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250204011627.2206261-1-sashal@kernel.org>
References: <20250204011627.2206261-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.1
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 55ad333de0f80bc0caee10c6c27196cdcf8891bb ]

Also reworked error handling in a couple of places.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c  |  4 ++--
 fs/ntfs3/dir.c     |  2 +-
 fs/ntfs3/frecord.c | 12 +++++++-----
 fs/ntfs3/fsntfs.c  |  6 +++++-
 fs/ntfs3/index.c   |  6 ++----
 fs/ntfs3/inode.c   |  3 +++
 6 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 795cf8e75d2ea..af94e3737470d 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1407,7 +1407,7 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 	 */
 	if (!attr->non_res) {
 		if (vbo[1] + bytes_per_off > le32_to_cpu(attr->res.data_size)) {
-			ntfs_inode_err(&ni->vfs_inode, "is corrupted");
+			_ntfs_bad_inode(&ni->vfs_inode);
 			return -EINVAL;
 		}
 		addr = resident_data(attr);
@@ -2588,7 +2588,7 @@ int attr_force_nonresident(struct ntfs_inode *ni)
 
 	attr = ni_find_attr(ni, NULL, &le, ATTR_DATA, NULL, 0, NULL, &mi);
 	if (!attr) {
-		ntfs_bad_inode(&ni->vfs_inode, "no data attribute");
+		_ntfs_bad_inode(&ni->vfs_inode);
 		return -ENOENT;
 	}
 
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index fc6a8aa29e3af..b6da80c69ca63 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -512,7 +512,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos = pos;
 	} else if (err < 0) {
 		if (err == -EINVAL)
-			ntfs_inode_err(dir, "directory corrupted");
+			_ntfs_bad_inode(dir);
 		ctx->pos = eod;
 	}
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index b9d6cb1fb54f4..f66186dbeda9d 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -148,8 +148,10 @@ int ni_load_mi_ex(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi)
 		goto out;
 
 	err = mi_get(ni->mi.sbi, rno, &r);
-	if (err)
+	if (err) {
+		_ntfs_bad_inode(&ni->vfs_inode);
 		return err;
+	}
 
 	ni_add_mi(ni, r);
 
@@ -239,8 +241,7 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 	return attr;
 
 out:
-	ntfs_inode_err(&ni->vfs_inode, "failed to parse mft record");
-	ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+	_ntfs_bad_inode(&ni->vfs_inode);
 	return NULL;
 }
 
@@ -332,6 +333,7 @@ struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	    vcn <= le64_to_cpu(attr->nres.evcn))
 		return attr;
 
+	_ntfs_bad_inode(&ni->vfs_inode);
 	return NULL;
 }
 
@@ -1607,8 +1609,8 @@ int ni_delete_all(struct ntfs_inode *ni)
 		roff = le16_to_cpu(attr->nres.run_off);
 
 		if (roff > asize) {
-			_ntfs_bad_inode(&ni->vfs_inode);
-			return -EINVAL;
+			/* ni_enum_attr_ex checks this case. */
+			continue;
 		}
 
 		/* run==1 means unpack and deallocate. */
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 03471bc9371cd..938d351ebac72 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -908,7 +908,11 @@ void ntfs_bad_inode(struct inode *inode, const char *hint)
 
 	ntfs_inode_err(inode, "%s", hint);
 	make_bad_inode(inode);
-	ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+	/* Avoid recursion if bad inode is $Volume. */
+	if (inode->i_ino != MFT_REC_VOL &&
+	    !(sbi->flags & NTFS_FLAGS_LOG_REPLAYING)) {
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+	}
 }
 
 /*
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 9089c58a005ce..7eb9fae22f8da 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1094,8 +1094,7 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 
 ok:
 	if (!index_buf_check(ib, bytes, &vbn)) {
-		ntfs_inode_err(&ni->vfs_inode, "directory corrupted");
-		ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+		_ntfs_bad_inode(&ni->vfs_inode);
 		err = -EINVAL;
 		goto out;
 	}
@@ -1117,8 +1116,7 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 
 out:
 	if (err == -E_NTFS_CORRUPT) {
-		ntfs_inode_err(&ni->vfs_inode, "directory corrupted");
-		ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+		_ntfs_bad_inode(&ni->vfs_inode);
 		err = -EINVAL;
 	}
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index be04d2845bb7b..a1e11228dafd0 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -410,6 +410,9 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	if (!std5)
 		goto out;
 
+	if (is_bad_inode(inode))
+		goto out;
+
 	if (!is_match && name) {
 		err = -ENOENT;
 		goto out;
-- 
2.39.5


