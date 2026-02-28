Return-Path: <stable+bounces-220118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF8iIlApo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:43:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 016831C5104
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC29830F7018
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4742B48033C;
	Sat, 28 Feb 2026 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff1IEegK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093DB480336;
	Sat, 28 Feb 2026 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300029; cv=none; b=NrlwuTNm2fvzEz6R6DuqFxUDYrD2fxpBND+G5PRcckzuzufWu7VeFPKCwMmIvDpqGjc8yP6clpBwFJMaskdwB8zVa4wG9jxPxLlnI0cJoc6OabizZx5w+/so8SDBEIJTcSeWlOtyRYLvW82bSwRBCT+cH7sCxpMFRBP41cDrwbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300029; c=relaxed/simple;
	bh=k1eVPDFyak+bkrd/W+y8JFeWv2XzHiOhynm/OIhazF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrobaGjNT6rZtfwIPiaJg/9bv3c6QDadhcflS3UZOFlak4Ru9bIIz1NJqk+1LUPwZe1NKdT4OaeV8M39ccrXxMRFoHlFLly6XyryPIlpa0km7H43wEx3P5rQsy7ZqS8qVfslUcz/EJ36OZSZ9jXNTLEjymPb6nGD1SUyQSH9Zts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff1IEegK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C5BC2BC9E;
	Sat, 28 Feb 2026 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300028;
	bh=k1eVPDFyak+bkrd/W+y8JFeWv2XzHiOhynm/OIhazF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ff1IEegKK1nwye8IntdaeAlOlWQOwLGAKItGTQN+Rm+dlcocGyy4m2Fr3JosvKYi9
	 1L/9USaIzstKcc6dOX/HWNawSfIJKlT8GYY1Lm0Ky3q7a7MJBXxx4CAzDTrCzKaq1L
	 2yX7adp7jALOVApakiyf2c8GJTh124Vwr97EL32rz7Go3FRJXLQnUEgEaLm+YUbzls
	 /krGedmA+dXZ0nEX3gwbPwo7XRpW8jL9XNwa7I2Y1BWwY8Z6XVKzt2Uskivb2rsVn8
	 Wk1xnxT+lghBYItr8kvDKX+Dw3Rn3kZzBnXpRbugDTtY4/imk1BHCQQpvrr2fsAral
	 HtResEqLIBqPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 040/844] hfs: Replace BUG_ON with error handling for CNID count checks
Date: Sat, 28 Feb 2026 12:19:13 -0500
Message-ID: <20260228173244.1509663-41-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[xs4all.nl,syzkaller.appspotmail.com,dubeyko.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220118-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,17cc9bb6d8d69b4139f0];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dubeyko.com:email,syzbot.org:url,xs4all.nl:email]
X-Rspamd-Queue-Id: 016831C5104
X-Rspamd-Action: no action

From: Jori Koolstra <jkoolstra@xs4all.nl>

[ Upstream commit b226804532a875c10276168dc55ce752944096bd ]

In a06ec283e125 next_id, folder_count, and file_count in the super block
info were expanded to 64 bits, and BUG_ONs were added to detect
overflow. This triggered an error reported by syzbot: if the MDB is
corrupted, the BUG_ON is triggered. This patch replaces this mechanism
with proper error handling and resolves the syzbot reported bug.

Singed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reported-by: syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=17cc9bb6d8d69b4139f0
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/20251220191006.2465256-1-jkoolstra@xs4all.nl
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfs/dir.c    | 15 +++++++++++----
 fs/hfs/hfs_fs.h |  1 +
 fs/hfs/inode.c  | 30 ++++++++++++++++++++++++------
 fs/hfs/mdb.c    | 31 +++++++++++++++++++++++++++----
 fs/hfs/super.c  |  3 +++
 5 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 86a6b317b474a..0c615c078650c 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -196,8 +196,8 @@ static int hfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	int res;
 
 	inode = hfs_new_inode(dir, &dentry->d_name, mode);
-	if (!inode)
-		return -ENOMEM;
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
 
 	res = hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
@@ -226,8 +226,8 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	int res;
 
 	inode = hfs_new_inode(dir, &dentry->d_name, S_IFDIR | mode);
-	if (!inode)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
 
 	res = hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
@@ -254,11 +254,18 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
  */
 static int hfs_remove(struct inode *dir, struct dentry *dentry)
 {
+	struct super_block *sb = dir->i_sb;
 	struct inode *inode = d_inode(dentry);
 	int res;
 
 	if (S_ISDIR(inode->i_mode) && inode->i_size != 2)
 		return -ENOTEMPTY;
+
+	if (unlikely(!is_hfs_cnid_counts_valid(sb))) {
+	    pr_err("cannot remove file/folder\n");
+	    return -ERANGE;
+	}
+
 	res = hfs_cat_delete(inode->i_ino, dir, &dentry->d_name);
 	if (res)
 		return res;
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index e94dbc04a1e43..ac0e83f77a0f1 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -199,6 +199,7 @@ extern void hfs_delete_inode(struct inode *inode);
 extern const struct xattr_handler * const hfs_xattr_handlers[];
 
 /* mdb.c */
+extern bool is_hfs_cnid_counts_valid(struct super_block *sb);
 extern int hfs_mdb_get(struct super_block *sb);
 extern void hfs_mdb_commit(struct super_block *sb);
 extern void hfs_mdb_close(struct super_block *sb);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 524db1389737d..878535db64d67 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -187,16 +187,23 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	s64 next_id;
 	s64 file_count;
 	s64 folder_count;
+	int err = -ENOMEM;
 
 	if (!inode)
-		return NULL;
+		goto out_err;
+
+	err = -ERANGE;
 
 	mutex_init(&HFS_I(inode)->extents_lock);
 	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
 	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
 	next_id = atomic64_inc_return(&HFS_SB(sb)->next_id);
-	BUG_ON(next_id > U32_MAX);
+	if (next_id > U32_MAX) {
+		atomic64_dec(&HFS_SB(sb)->next_id);
+		pr_err("cannot create new inode: next CNID exceeds limit\n");
+		goto out_discard;
+	}
 	inode->i_ino = (u32)next_id;
 	inode->i_mode = mode;
 	inode->i_uid = current_fsuid();
@@ -210,7 +217,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
 		folder_count = atomic64_inc_return(&HFS_SB(sb)->folder_count);
-		BUG_ON(folder_count > U32_MAX);
+		if (folder_count> U32_MAX) {
+			atomic64_dec(&HFS_SB(sb)->folder_count);
+			pr_err("cannot create new inode: folder count exceeds limit\n");
+			goto out_discard;
+		}
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_dirs++;
 		inode->i_op = &hfs_dir_inode_operations;
@@ -220,7 +231,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
 		file_count = atomic64_inc_return(&HFS_SB(sb)->file_count);
-		BUG_ON(file_count > U32_MAX);
+		if (file_count > U32_MAX) {
+			atomic64_dec(&HFS_SB(sb)->file_count);
+			pr_err("cannot create new inode: file count exceeds limit\n");
+			goto out_discard;
+		}
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_files++;
 		inode->i_op = &hfs_file_inode_operations;
@@ -244,6 +259,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	hfs_mark_mdb_dirty(sb);
 
 	return inode;
+
+	out_discard:
+		iput(inode);
+	out_err:
+		return ERR_PTR(err);
 }
 
 void hfs_delete_inode(struct inode *inode)
@@ -252,7 +272,6 @@ void hfs_delete_inode(struct inode *inode)
 
 	hfs_dbg("ino %lu\n", inode->i_ino);
 	if (S_ISDIR(inode->i_mode)) {
-		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
 		atomic64_dec(&HFS_SB(sb)->folder_count);
 		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
 			HFS_SB(sb)->root_dirs--;
@@ -261,7 +280,6 @@ void hfs_delete_inode(struct inode *inode)
 		return;
 	}
 
-	BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
 	atomic64_dec(&HFS_SB(sb)->file_count);
 	if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
 		HFS_SB(sb)->root_files--;
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index f28cd24dee842..a97cea35ca2e1 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -64,6 +64,27 @@ static int hfs_get_last_session(struct super_block *sb,
 	return 0;
 }
 
+bool is_hfs_cnid_counts_valid(struct super_block *sb)
+{
+	struct hfs_sb_info *sbi = HFS_SB(sb);
+	bool corrupted = false;
+
+	if (unlikely(atomic64_read(&sbi->next_id) > U32_MAX)) {
+		pr_warn("next CNID exceeds limit\n");
+		corrupted = true;
+	}
+	if (unlikely(atomic64_read(&sbi->file_count) > U32_MAX)) {
+		pr_warn("file count exceeds limit\n");
+		corrupted = true;
+	}
+	if (unlikely(atomic64_read(&sbi->folder_count) > U32_MAX)) {
+		pr_warn("folder count exceeds limit\n");
+		corrupted = true;
+	}
+
+	return !corrupted;
+}
+
 /*
  * hfs_mdb_get()
  *
@@ -159,6 +180,11 @@ int hfs_mdb_get(struct super_block *sb)
 	atomic64_set(&HFS_SB(sb)->file_count, be32_to_cpu(mdb->drFilCnt));
 	atomic64_set(&HFS_SB(sb)->folder_count, be32_to_cpu(mdb->drDirCnt));
 
+	if (!is_hfs_cnid_counts_valid(sb)) {
+		pr_warn("filesystem possibly corrupted, running fsck.hfs is recommended. Mounting read-only.\n");
+		sb->s_flags |= SB_RDONLY;
+	}
+
 	/* TRY to get the alternate (backup) MDB. */
 	sect = part_start + part_size - 2;
 	bh = sb_bread512(sb, sect, mdb2);
@@ -212,7 +238,7 @@ int hfs_mdb_get(struct super_block *sb)
 
 	attrib = mdb->drAtrb;
 	if (!(attrib & cpu_to_be16(HFS_SB_ATTRIB_UNMNT))) {
-		pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is recommended.  mounting read-only.\n");
+		pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is recommended.	Mounting read-only.\n");
 		sb->s_flags |= SB_RDONLY;
 	}
 	if ((attrib & cpu_to_be16(HFS_SB_ATTRIB_SLOCK))) {
@@ -270,15 +296,12 @@ void hfs_mdb_commit(struct super_block *sb)
 		/* These parameters may have been modified, so write them back */
 		mdb->drLsMod = hfs_mtime();
 		mdb->drFreeBks = cpu_to_be16(HFS_SB(sb)->free_ablocks);
-		BUG_ON(atomic64_read(&HFS_SB(sb)->next_id) > U32_MAX);
 		mdb->drNxtCNID =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->next_id));
 		mdb->drNmFls = cpu_to_be16(HFS_SB(sb)->root_files);
 		mdb->drNmRtDirs = cpu_to_be16(HFS_SB(sb)->root_dirs);
-		BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
 		mdb->drFilCnt =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->file_count));
-		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
 		mdb->drDirCnt =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
 
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index df289cbdd4e85..97546d6b41f47 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -34,6 +34,7 @@ MODULE_LICENSE("GPL");
 
 static int hfs_sync_fs(struct super_block *sb, int wait)
 {
+	is_hfs_cnid_counts_valid(sb);
 	hfs_mdb_commit(sb);
 	return 0;
 }
@@ -65,6 +66,8 @@ static void flush_mdb(struct work_struct *work)
 	sbi->work_queued = 0;
 	spin_unlock(&sbi->work_lock);
 
+	is_hfs_cnid_counts_valid(sb);
+
 	hfs_mdb_commit(sb);
 }
 
-- 
2.51.0


