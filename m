Return-Path: <stable+bounces-86656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8770F9A2AF1
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E19CB2B6A5
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7976F1DF993;
	Thu, 17 Oct 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="J5hKrOJU"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27411DFD82
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185588; cv=none; b=nASxY0EKcW9ZolbrMAh1nT/+YvyqnV0lZaoZSg07W3rWmeI3lWuLrWh7cawzhqOKcHAODsA8stz0zeWD0KL/BQ4i30FsfjxmEeZFr97FaW5Pv7dCNYAxCGscWnwOKx31PyoFcYTk2TvJrLyGQ5Z0EPQYyj1ciKOwIqwImhhfC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185588; c=relaxed/simple;
	bh=thQeI2st5IPpUk3F16nai5d9LJHeUJsYFA7imjX05Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y3CkftE8KI4fPoP6eUYr3CIyFTEc28Bd6vjQjqSaUg3j6feYqGzfMHKd8JmM4RtV1kzAtZejKhLjN8AVHHrOIb0wUZoo7oxHHlMzB2/o63ZTJWWdowAHUOE8FScl/RXG8YgatbnqiDqsfeo8XkSXzrERl7YcLfWuPfrpeGJx3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=J5hKrOJU; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3BZ/KO7wHgsbZJGiowL5Ftrllo6MT136b+GzHwLXRAI=; b=J5hKrOJUItizGRiEQKN19VqudW
	2trDU0PMVpIvRaFOWN49YdUdzod+w3q7OE2RWIZWtQTswwXVctgJWITfqaMBMVgU3XATDz742UKz1
	RhNArPvFhDR2odJKpNtddk2Nw1ijv1SyG8NNTQzK8u/f/sKu9uqsxoLKj1TZPGq/VwPV3BaXTNfi0
	NDW9+lKZx8OEYiFyoMSms3bp7zfOQG4ckVlyHk6xLzYSgCXIq93jaqkZWSX0WQOIOxtrL/hivXo7k
	nQZGQlT5QsaFpyth/mXkdErWLVWJTQIhi6T2yk2/r+q94Ha/62MxmCzZDQo14vpeoAvVcWMW/C142
	mFdSWcEw==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1UA1-00Biqr-4b; Thu, 17 Oct 2024 19:19:41 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	syzbot+0eaad3590d65102b9391@syzkaller.appspotmail.com,
	syzbot+b7fc73213bc2361ab650@syzkaller.appspotmail.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 06/19] udf: Convert udf_rename() to new directory iteration code
Date: Thu, 17 Oct 2024 14:19:02 -0300
Message-Id: <20241017171915.311132-7-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017171915.311132-1-cascardo@igalia.com>
References: <20241017171915.311132-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit e9109a92d2a95889498bed3719cd2318892171a2 ]

Convert udf_rename() to use new directory iteration code.

Reported-by: syzbot+0eaad3590d65102b9391@syzkaller.appspotmail.com
Reported-by: syzbot+b7fc73213bc2361ab650@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
[cascardo: remove the call to udf_rename_tag per commit
 27ab33854873 ("udf: Fix bogus checksum computation in udf_rename()")]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 162 +++++++++++++++++++++++--------------------------
 1 file changed, 76 insertions(+), 86 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index f9e7fe80a066..1f8c91e953bb 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1238,78 +1238,68 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 {
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
-	struct udf_fileident_bh ofibh, nfibh;
-	struct fileIdentDesc *ofi = NULL, *nfi = NULL, *dir_fi = NULL;
-	struct fileIdentDesc ocfi, ncfi;
-	struct buffer_head *dir_bh = NULL;
-	int retval = -ENOENT;
+	struct udf_fileident_iter oiter, niter, diriter;
+	bool has_diriter = false;
+	int retval;
 	struct kernel_lb_addr tloc;
-	struct udf_inode_info *old_iinfo = UDF_I(old_inode);
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
-	ofi = udf_find_entry(old_dir, &old_dentry->d_name, &ofibh, &ocfi);
-	if (!ofi || IS_ERR(ofi)) {
-		if (IS_ERR(ofi))
-			retval = PTR_ERR(ofi);
-		goto end_rename;
-	}
-
-	if (ofibh.sbh != ofibh.ebh)
-		brelse(ofibh.ebh);
-
-	brelse(ofibh.sbh);
-	tloc = lelb_to_cpu(ocfi.icb.extLocation);
-	if (udf_get_lb_pblock(old_dir->i_sb, &tloc, 0) != old_inode->i_ino)
-		goto end_rename;
+	retval = udf_fiiter_find_entry(old_dir, &old_dentry->d_name, &oiter);
+	if (retval)
+		return retval;
 
-	nfi = udf_find_entry(new_dir, &new_dentry->d_name, &nfibh, &ncfi);
-	if (IS_ERR(nfi)) {
-		retval = PTR_ERR(nfi);
-		goto end_rename;
-	}
-	if (nfi && !new_inode) {
-		if (nfibh.sbh != nfibh.ebh)
-			brelse(nfibh.ebh);
-		brelse(nfibh.sbh);
-		nfi = NULL;
+	tloc = lelb_to_cpu(oiter.fi.icb.extLocation);
+	if (udf_get_lb_pblock(old_dir->i_sb, &tloc, 0) != old_inode->i_ino) {
+		retval = -ENOENT;
+		goto out_oiter;
 	}
-	if (S_ISDIR(old_inode->i_mode)) {
-		int offset = udf_ext0_offset(old_inode);
 
+	if (S_ISDIR(old_inode->i_mode)) {
 		if (new_inode) {
 			retval = -ENOTEMPTY;
 			if (!empty_dir(new_inode))
-				goto end_rename;
+				goto out_oiter;
 		}
-		retval = -EIO;
-		if (old_iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
-			dir_fi = udf_get_fileident(
-					old_iinfo->i_data -
-					  (old_iinfo->i_efe ?
-					   sizeof(struct extendedFileEntry) :
-					   sizeof(struct fileEntry)),
-					old_inode->i_sb->s_blocksize, &offset);
-		} else {
-			dir_bh = udf_bread(old_inode, 0, 0, &retval);
-			if (!dir_bh)
-				goto end_rename;
-			dir_fi = udf_get_fileident(dir_bh->b_data,
-					old_inode->i_sb->s_blocksize, &offset);
+		retval = udf_fiiter_find_entry(old_inode, &dotdot_name,
+					       &diriter);
+		if (retval == -ENOENT) {
+			udf_err(old_inode->i_sb,
+				"directory (ino %lu) has no '..' entry\n",
+				old_inode->i_ino);
+			retval = -EFSCORRUPTED;
 		}
-		if (!dir_fi)
-			goto end_rename;
-		tloc = lelb_to_cpu(dir_fi->icb.extLocation);
+		if (retval)
+			goto out_oiter;
+		has_diriter = true;
+		tloc = lelb_to_cpu(diriter.fi.icb.extLocation);
 		if (udf_get_lb_pblock(old_inode->i_sb, &tloc, 0) !=
-				old_dir->i_ino)
-			goto end_rename;
+				old_dir->i_ino) {
+			retval = -EFSCORRUPTED;
+			udf_err(old_inode->i_sb,
+				"directory (ino %lu) has parent entry pointing to another inode (%lu != %u)\n",
+				old_inode->i_ino, old_dir->i_ino,
+				udf_get_lb_pblock(old_inode->i_sb, &tloc, 0));
+			goto out_oiter;
+		}
+	}
+
+	retval = udf_fiiter_find_entry(new_dir, &new_dentry->d_name, &niter);
+	if (retval && retval != -ENOENT)
+		goto out_oiter;
+	/* Entry found but not passed by VFS? */
+	if (!retval && !new_inode) {
+		retval = -EFSCORRUPTED;
+		udf_fiiter_release(&niter);
+		goto out_oiter;
 	}
-	if (!nfi) {
-		nfi = udf_add_entry(new_dir, new_dentry, &nfibh, &ncfi,
-				    &retval);
-		if (!nfi)
-			goto end_rename;
+	/* Entry not found? Need to add one... */
+	if (retval) {
+		udf_fiiter_release(&niter);
+		retval = udf_fiiter_add_entry(new_dir, new_dentry, &niter);
+		if (retval)
+			goto out_oiter;
 	}
 
 	/*
@@ -1322,14 +1312,26 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	/*
 	 * ok, that's it
 	 */
-	ncfi.fileVersionNum = ocfi.fileVersionNum;
-	ncfi.fileCharacteristics = ocfi.fileCharacteristics;
-	memcpy(&(ncfi.icb), &(ocfi.icb), sizeof(ocfi.icb));
-	udf_write_fi(new_dir, &ncfi, nfi, &nfibh, NULL, NULL);
+	niter.fi.fileVersionNum = oiter.fi.fileVersionNum;
+	niter.fi.fileCharacteristics = oiter.fi.fileCharacteristics;
+	memcpy(&(niter.fi.icb), &(oiter.fi.icb), sizeof(oiter.fi.icb));
+	udf_fiiter_write_fi(&niter, NULL);
+	udf_fiiter_release(&niter);
 
-	/* The old fid may have moved - find it again */
-	ofi = udf_find_entry(old_dir, &old_dentry->d_name, &ofibh, &ocfi);
-	udf_delete_entry(old_dir, ofi, &ofibh, &ocfi);
+	/*
+	 * The old entry may have moved due to new entry allocation. Find it
+	 * again.
+	 */
+	udf_fiiter_release(&oiter);
+	retval = udf_fiiter_find_entry(old_dir, &old_dentry->d_name, &oiter);
+	if (retval) {
+		udf_err(old_dir->i_sb,
+			"failed to find renamed entry again in directory (ino %lu)\n",
+			old_dir->i_ino);
+	} else {
+		udf_fiiter_delete_entry(&oiter);
+		udf_fiiter_release(&oiter);
+	}
 
 	if (new_inode) {
 		new_inode->i_ctime = current_time(new_inode);
@@ -1340,12 +1342,11 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	mark_inode_dirty(old_dir);
 	mark_inode_dirty(new_dir);
 
-	if (dir_fi) {
-		dir_fi->icb.extLocation = cpu_to_lelb(UDF_I(new_dir)->i_location);
-		if (old_iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-			mark_inode_dirty(old_inode);
-		else
-			mark_buffer_dirty_inode(dir_bh, old_inode);
+	if (has_diriter) {
+		diriter.fi.icb.extLocation =
+					cpu_to_lelb(UDF_I(new_dir)->i_location);
+		udf_fiiter_write_fi(&diriter, NULL);
+		udf_fiiter_release(&diriter);
 
 		inode_dec_link_count(old_dir);
 		if (new_inode)
@@ -1355,22 +1356,11 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			mark_inode_dirty(new_dir);
 		}
 	}
-
-	if (ofi) {
-		if (ofibh.sbh != ofibh.ebh)
-			brelse(ofibh.ebh);
-		brelse(ofibh.sbh);
-	}
-
-	retval = 0;
-
-end_rename:
-	brelse(dir_bh);
-	if (nfi) {
-		if (nfibh.sbh != nfibh.ebh)
-			brelse(nfibh.ebh);
-		brelse(nfibh.sbh);
-	}
+	return 0;
+out_oiter:
+	if (has_diriter)
+		udf_fiiter_release(&diriter);
+	udf_fiiter_release(&oiter);
 
 	return retval;
 }
-- 
2.34.1


