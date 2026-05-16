Return-Path: <stable+bounces-249029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKxpFefACGrC3wMAu9opvQ
	(envelope-from <stable+bounces-249029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:09:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F39B055D76E
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B98B6300EF85
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4782535FF58;
	Sat, 16 May 2026 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/bUrp2o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B242405C31
	for <stable@vger.kernel.org>; Sat, 16 May 2026 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958562; cv=none; b=MalPOfOv7etLj5yX7wylVycEcPCyMgF9QlBSMJGec9ClKTpiuobEO5qOVBDPGizue5VBAuikdeUQt5kehuQl2XWQvkVTNUEWGas6KYfta5OmZqgSArtbosS7ucTaJ5AaC6IbC2Rn8u0e9zV4c2KDK4T67K5ArJVnxUL/nsuS6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958562; c=relaxed/simple;
	bh=Wzbs1bljazWirDbMEqB51uNfD8tEPZ705VcqcDsENhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osdSUttiQiTLhf3WbTro1Zi2B4cSFDNXsUqiodzFnDr2z5qfyvvuj+dV24Zyd6w0Z8jHRd2WH3bKVFs5nbVSIxLrWAe0o/7WtUwvkFow0StxAZUUYjKrh1fteMEGtrDUDNokFOlbiJ9neU3SPfjoKV+bWm7piXJrQgnuqQOG1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/bUrp2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B9BC19425;
	Sat, 16 May 2026 19:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778958561;
	bh=Wzbs1bljazWirDbMEqB51uNfD8tEPZ705VcqcDsENhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/bUrp2otT1P4+o/8k286H81bdYz4+mmgtlyhsatnTr/QS64XiioJbP4stQM1L7/M
	 XA+wN/Flv3ECYDyDploQ+8bpZcgfC/JwfcxhdYXdM9267J47VtIdavtDJq53pUMMkY
	 Ppg6OeUnt4ZYR8D3bpWzqJLpGPzNu5qfvMR+ztRHCeO0HecRLuxp/kbNyHNrRZjF6L
	 +dLDqDZdQvoRXQA27ryK+Wa0D5hKE3THL8W3WcuMVnsRB33wHbhLOdWwI26mXnQ5d+
	 zQPHN9k4Qw6H5CkURKT/lRPw/0s0XB2izBLNci3N1C9eg/86kn0MjH6hlFTZm0j/gw
	 gr9akePpXjyOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] btrfs: use btrfs inodes in btrfs_rmdir() to avoid so much usage of BTRFS_I()
Date: Sat, 16 May 2026 15:09:17 -0400
Message-ID: <20260516190918.4017278-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516190918.4017278-1-sashal@kernel.org>
References: <2026051231-sandworm-portable-73a6@gregkh>
 <20260516190918.4017278-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F39B055D76E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249029-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,wdc.com:email]
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
index 981526b7ad684..fd0484df13a8c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4743,32 +4743,33 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
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
@@ -4788,22 +4789,22 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
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


