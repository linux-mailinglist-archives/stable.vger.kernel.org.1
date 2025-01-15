Return-Path: <stable+bounces-108813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56502A1206B
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329403A58F6
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D00248BDA;
	Wed, 15 Jan 2025 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BjgeYK9f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972CC248BC6;
	Wed, 15 Jan 2025 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937887; cv=none; b=gczyCb7JG/giNZ2hkNwtwwNtbS8aNQ4WUUmZPJES1utRzz6M58OYVyEsbxPVgVfOaic1S/gIPeETiurAX8csrpOKxvfJSj6EZ4Lwg8IIlMx7LbI5eTd5waDA1YMNQNf7vcc7TAO9PQtizoj9DhRIjXLbIk3zUw5opwOlLpQlpZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937887; c=relaxed/simple;
	bh=e+8frJe6HcqyjSdfEkkHUPyJx40VxmaTR7EhDNTYf34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZNyDKA9QUtfArmAcSmPKmqjGyXUPR7c5v85Y4vvfy6gOqad17s7gyu2xYL+HZR15ltb4y8KlDbZ86zFEBvG/7GHhiCjYmJ5LkLawPTIJ5Nnd9By6aL1cVlJUfFs8uvX7cTxfSelnzZnahkafqeCd/dVGL85eQKWDdmoyZgeyes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BjgeYK9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8978C4CEDF;
	Wed, 15 Jan 2025 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736937887;
	bh=e+8frJe6HcqyjSdfEkkHUPyJx40VxmaTR7EhDNTYf34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BjgeYK9fi6+YYRHjYC1o+t9rjP7wBLlfmxNTxlUVys2XSSoKaZLtYdPKwDwpPJEG5
	 uOWZK1mZs6b4nHwDUdsgLiOhWL/pBRquWhIOmxB1XGQfDb/HafiasRm7N+lRmRzORk
	 fEmYv9YLPFZoyQmdpDa/5cHco1rqBRg5uC82LCNU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Safonov <dima@arista.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 020/189] ovl: support encoding fid from inode with no alias
Date: Wed, 15 Jan 2025 11:35:16 +0100
Message-ID: <20250115103607.164394816@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit c45beebfde34aa71afbc48b2c54cdda623515037 ]

Dmitry Safonov reported that a WARN_ON() assertion can be trigered by
userspace when calling inotify_show_fdinfo() for an overlayfs watched
inode, whose dentry aliases were discarded with drop_caches.

The WARN_ON() assertion in inotify_show_fdinfo() was removed, because
it is possible for encoding file handle to fail for other reason, but
the impact of failing to encode an overlayfs file handle goes beyond
this assertion.

As shown in the LTP test case mentioned in the link below, failure to
encode an overlayfs file handle from a non-aliased inode also leads to
failure to report an fid with FAN_DELETE_SELF fanotify events.

As Dmitry notes in his analyzis of the problem, ovl_encode_fh() fails
if it cannot find an alias for the inode, but this failure can be fixed.
ovl_encode_fh() seldom uses the alias and in the case of non-decodable
file handles, as is often the case with fanotify fid info,
ovl_encode_fh() never needs to use the alias to encode a file handle.

Defer finding an alias until it is actually needed so ovl_encode_fh()
will not fail in the common case of FAN_DELETE_SELF fanotify events.

Fixes: 16aac5ad1fa9 ("ovl: support encoding non-decodable file handles")
Reported-by: Dmitry Safonov <dima@arista.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAOQ4uxiie81voLZZi2zXS1BziXZCM24nXqPAxbu8kxXCUWdwOg@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/r/20250105162404.357058-3-amir73il@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/export.c | 46 +++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 036c9f39a14d..444aeeccb6da 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -176,35 +176,37 @@ static int ovl_connect_layer(struct dentry *dentry)
  *
  * Return 0 for upper file handle, > 0 for lower file handle or < 0 on error.
  */
-static int ovl_check_encode_origin(struct dentry *dentry)
+static int ovl_check_encode_origin(struct inode *inode)
 {
-	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
+	struct ovl_fs *ofs = OVL_FS(inode->i_sb);
 	bool decodable = ofs->config.nfs_export;
+	struct dentry *dentry;
+	int err;
 
 	/* No upper layer? */
 	if (!ovl_upper_mnt(ofs))
 		return 1;
 
 	/* Lower file handle for non-upper non-decodable */
-	if (!ovl_dentry_upper(dentry) && !decodable)
+	if (!ovl_inode_upper(inode) && !decodable)
 		return 1;
 
 	/* Upper file handle for pure upper */
-	if (!ovl_dentry_lower(dentry))
+	if (!ovl_inode_lower(inode))
 		return 0;
 
 	/*
 	 * Root is never indexed, so if there's an upper layer, encode upper for
 	 * root.
 	 */
-	if (dentry == dentry->d_sb->s_root)
+	if (inode == d_inode(inode->i_sb->s_root))
 		return 0;
 
 	/*
 	 * Upper decodable file handle for non-indexed upper.
 	 */
-	if (ovl_dentry_upper(dentry) && decodable &&
-	    !ovl_test_flag(OVL_INDEX, d_inode(dentry)))
+	if (ovl_inode_upper(inode) && decodable &&
+	    !ovl_test_flag(OVL_INDEX, inode))
 		return 0;
 
 	/*
@@ -213,17 +215,25 @@ static int ovl_check_encode_origin(struct dentry *dentry)
 	 * ovl_connect_layer() will try to make origin's layer "connected" by
 	 * copying up a "connectable" ancestor.
 	 */
-	if (d_is_dir(dentry) && decodable)
-		return ovl_connect_layer(dentry);
+	if (!decodable || !S_ISDIR(inode->i_mode))
+		return 1;
+
+	dentry = d_find_any_alias(inode);
+	if (!dentry)
+		return -ENOENT;
+
+	err = ovl_connect_layer(dentry);
+	dput(dentry);
+	if (err < 0)
+		return err;
 
 	/* Lower file handle for indexed and non-upper dir/non-dir */
 	return 1;
 }
 
-static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct dentry *dentry,
+static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct inode *inode,
 			     u32 *fid, int buflen)
 {
-	struct inode *inode = d_inode(dentry);
 	struct ovl_fh *fh = NULL;
 	int err, enc_lower;
 	int len;
@@ -232,7 +242,7 @@ static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct dentry *dentry,
 	 * Check if we should encode a lower or upper file handle and maybe
 	 * copy up an ancestor to make lower file handle connectable.
 	 */
-	err = enc_lower = ovl_check_encode_origin(dentry);
+	err = enc_lower = ovl_check_encode_origin(inode);
 	if (enc_lower < 0)
 		goto fail;
 
@@ -252,8 +262,8 @@ static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct dentry *dentry,
 	return err;
 
 fail:
-	pr_warn_ratelimited("failed to encode file handle (%pd2, err=%i)\n",
-			    dentry, err);
+	pr_warn_ratelimited("failed to encode file handle (ino=%lu, err=%i)\n",
+			    inode->i_ino, err);
 	goto out;
 }
 
@@ -261,19 +271,13 @@ static int ovl_encode_fh(struct inode *inode, u32 *fid, int *max_len,
 			 struct inode *parent)
 {
 	struct ovl_fs *ofs = OVL_FS(inode->i_sb);
-	struct dentry *dentry;
 	int bytes, buflen = *max_len << 2;
 
 	/* TODO: encode connectable file handles */
 	if (parent)
 		return FILEID_INVALID;
 
-	dentry = d_find_any_alias(inode);
-	if (!dentry)
-		return FILEID_INVALID;
-
-	bytes = ovl_dentry_to_fid(ofs, dentry, fid, buflen);
-	dput(dentry);
+	bytes = ovl_dentry_to_fid(ofs, inode, fid, buflen);
 	if (bytes <= 0)
 		return FILEID_INVALID;
 
-- 
2.39.5




