Return-Path: <stable+bounces-249089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJLEAg7ICWropQQAu9opvQ
	(envelope-from <stable+bounces-249089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:52:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D635614BC
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4096D3009B36
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1741F248893;
	Sun, 17 May 2026 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmzuI4Mn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5972512DE
	for <stable@vger.kernel.org>; Sun, 17 May 2026 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025927; cv=none; b=LZ7W66Yp3cLjgT++F0IvxSPnmg2VdqOBIrxAh/pK8DkxcuQaIACD9v3u12u4P92hgt0NF4Z7XlCunoKM84SiunMUPbTBs4WTgd9L/miEDh7oNwH/az/+gmbvJldZorzclGr6LdToMIC9igQ/E+K1rSHA0CjLERO7ZRokJ4ZwIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025927; c=relaxed/simple;
	bh=iGLs2s1OmSS+rKMHXgHlQCAEHQEEd3scx0SMg1pXwZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIzh3JExcIervWSlqPZyRnfvwul8kHFruQExb4OSf83VsGgKht0VIE52oj1UTQTqZpweXkLldiKb65hgZdeLPVQAcYd0XBe4SadnOPy+p7welRmtkE/QSX9Eg0x1KKQluFuEMwtCs+15Yt3UJ87hxICrkdOWYzdY69i20HrSIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmzuI4Mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD24C2BCB8;
	Sun, 17 May 2026 13:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779025927;
	bh=iGLs2s1OmSS+rKMHXgHlQCAEHQEEd3scx0SMg1pXwZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmzuI4MnRnAuxRm3Udaon3UQBhWzmytJfuv3yqHEC2W+nJWPCCBgqb5ypUTl5LmGl
	 LOP6r9V6xWCprn/u2175+dPvsUw3M+FlZrpFn6EryOkcYB9ORRISAkgN5BrokgbYPA
	 VwJ2XTPsLrzA9DYuqRaWTJHY/E5lAsXV0hZEdynI1pmPJ7wwZNJys+2M1lU/x/FEFK
	 lnE5wXFRiB4UCQwLttfm62miwSmZ2TGpDP5cLTzXtxntz0ktaKDGdruqAQmcdJJkLu
	 OB/AOcM0LJYMSDu0Jm36FTj8tnZV9OJ+Kd8oygQne+L4umdj+dKRSvtq3jr42ftllw
	 ThxRI4K0YPZOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] btrfs: use btrfs inodes in btrfs_rmdir() to avoid so much usage of BTRFS_I()
Date: Sun, 17 May 2026 09:52:03 -0400
Message-ID: <20260517135204.148250-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517135204.148250-1-sashal@kernel.org>
References: <2026051232-runner-cornhusk-38cf@gregkh>
 <20260517135204.148250-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 88D635614BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249089-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 98060e1611177ddc842601a58258876ab435fdbf ]

Almost everywhere we want to use a btrfs inode and therefore we have a
lot of calls to BTRFS_I(), making the code more verbose. Instead use btrfs
inode local variables to avoid so much use of BTRFS_I().

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 999757231c49 ("btrfs: fix missing last_unlink_trans update when removing a directory")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 65fb689f8d6ab..eb9e02c9a7ed1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4623,32 +4623,33 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	return ret;
 }
 
-static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
+static int btrfs_rmdir(struct inode *vfs_dir, struct dentry *dentry)
 {
-	struct inode *inode = d_inode(dentry);
-	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
+	struct btrfs_inode *dir = BTRFS_I(vfs_dir);
+	struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int ret = 0;
 	struct btrfs_trans_handle *trans;
 	struct fscrypt_name fname;
 
-	if (inode->i_size > BTRFS_EMPTY_DIR_SIZE)
+	if (inode->vfs_inode.i_size > BTRFS_EMPTY_DIR_SIZE)
 		return -ENOTEMPTY;
-	if (btrfs_ino(BTRFS_I(inode)) == BTRFS_FIRST_FREE_OBJECTID) {
+	if (btrfs_ino(inode) == BTRFS_FIRST_FREE_OBJECTID) {
 		if (unlikely(btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))) {
 			btrfs_err(fs_info,
 			"extent tree v2 doesn't support snapshot deletion yet");
 			return -EOPNOTSUPP;
 		}
-		return btrfs_delete_subvolume(BTRFS_I(dir), dentry);
+		return btrfs_delete_subvolume(dir, dentry);
 	}
 
-	ret = fscrypt_setup_filename(dir, &dentry->d_name, 1, &fname);
+	ret = fscrypt_setup_filename(vfs_dir, &dentry->d_name, 1, &fname);
 	if (ret)
 		return ret;
 
 	/* This needs to handle no-key deletions later on */
 
-	trans = __unlink_start_trans(BTRFS_I(dir));
+	trans = __unlink_start_trans(dir);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out_notrans;
@@ -4668,22 +4669,22 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	 * This is because we can't unlink other roots when replaying the dir
 	 * deletes for directory foo.
 	 */
-	if (BTRFS_I(inode)->last_unlink_trans >= trans->transid)
-		btrfs_record_snapshot_destroy(trans, BTRFS_I(dir));
+	if (inode->last_unlink_trans >= trans->transid)
+		btrfs_record_snapshot_destroy(trans, dir);
 
-	if (unlikely(btrfs_ino(BTRFS_I(inode)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
-		ret = btrfs_unlink_subvol(trans, BTRFS_I(dir), dentry);
+	if (unlikely(btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
+		ret = btrfs_unlink_subvol(trans, dir, dentry);
 		goto out;
 	}
 
-	ret = btrfs_orphan_add(trans, BTRFS_I(inode));
+	ret = btrfs_orphan_add(trans, inode);
 	if (ret)
 		goto out;
 
 	/* now the directory is empty */
-	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(inode), &fname.disk_name);
+	ret = btrfs_unlink_inode(trans, dir, inode, &fname.disk_name);
 	if (!ret)
-		btrfs_i_size_write(BTRFS_I(inode), 0);
+		btrfs_i_size_write(inode, 0);
 out:
 	btrfs_end_transaction(trans);
 out_notrans:
-- 
2.53.0


