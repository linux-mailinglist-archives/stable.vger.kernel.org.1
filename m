Return-Path: <stable+bounces-9067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 207D9820A14
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD23E282F6B
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7BE17C2;
	Sun, 31 Dec 2023 07:15:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1417F4
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cdfbd4e8caso4687994a12.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006940; x=1704611740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjGmUPAk8gnP4eH2K6gV3rQL7llvxFTA73b1U0pX5zs=;
        b=cU6ZiYBGEk4wcg4kLMHNA7CAM0xA0X0/Ve0iiVQ8dGCOJ7BUI2As8P0EDLxHWo/2Nl
         llghVQTvmXQNfn1gxBXSY21DneLUulv+kHfwc1LJyuTnbfDnXBxQF4mor24ajdVDBDHL
         YNJ3sylFDWYNxUJ1vh2HA5rZy392VUtEvG2uDSUSm0Z5kGbPagMdzHKbFp1F9DW4p0mr
         1GmlxClLkiUJMiRnz8PwrgWsWvZ2aEcRaK3W8BNfeij2Y8fsn74Bgm60QOgxllEjSDIE
         8kYw61y5FbkwVVfH+mGL/a7yvfWeQqUawS+IUTH7T49dy7E+FFQvg11rOIpohRBtjpLP
         RFJg==
X-Gm-Message-State: AOJu0YyU2Py8kwPG+OKCtlOYbk8ENtglDtfOnef2H30G23aDat4MLWj4
	1Wg+qWc0hhJ3HMMDMm+3low=
X-Google-Smtp-Source: AGHT+IFRhazTP8H7J7mrcpwsFzmJM+wo6q3igSm70fh5siRcL8exeC6pytp2kPnxUuvQBZEB7yOVCQ==
X-Received: by 2002:a05:6a20:c613:b0:194:f56a:dd96 with SMTP id gp19-20020a056a20c61300b00194f56add96mr14810020pzb.124.1704006940357;
        Sat, 30 Dec 2023 23:15:40 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:15:39 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 33/73] ksmbd: check if a mount point is crossed during path lookup
Date: Sun, 31 Dec 2023 16:12:52 +0900
Message-Id: <20231231071332.31724-34-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071332.31724-1-linkinjeon@kernel.org>
References: <20231231071332.31724-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 2b57a4322b1b14348940744fdc02f9a86cbbdbeb ]

Since commit 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and
->d_name"), ksmbd can not lookup cross mount points. If last component is
a cross mount point during path lookup, check if it is crossed to follow it
down. And allow path lookup to cross a mount point when a crossmnt
parameter is set to 'yes' in smb.conf.

Cc: stable@vger.kernel.org
Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/ksmbd_netlink.h |  3 +-
 fs/smb/server/smb2pdu.c       | 27 +++++++++-------
 fs/smb/server/vfs.c           | 58 ++++++++++++++++++++---------------
 fs/smb/server/vfs.h           |  4 +--
 4 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.h
index fb8b2d566efb..b7521e41402e 100644
--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -352,7 +352,8 @@ enum KSMBD_TREE_CONN_STATUS {
 #define KSMBD_SHARE_FLAG_STREAMS		BIT(11)
 #define KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS	BIT(12)
 #define KSMBD_SHARE_FLAG_ACL_XATTR		BIT(13)
-#define KSMBD_SHARE_FLAG_UPDATE		BIT(14)
+#define KSMBD_SHARE_FLAG_UPDATE			BIT(14)
+#define KSMBD_SHARE_FLAG_CROSSMNT		BIT(15)
 
 /*
  * Tree connect request flags.
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 10d51256858f..687e59cb0c8c 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2475,8 +2475,9 @@ static void smb2_update_xattrs(struct ksmbd_tree_connect *tcon,
 	}
 }
 
-static int smb2_creat(struct ksmbd_work *work, struct path *path, char *name,
-		      int open_flags, umode_t posix_mode, bool is_dir)
+static int smb2_creat(struct ksmbd_work *work, struct path *parent_path,
+		      struct path *path, char *name, int open_flags,
+		      umode_t posix_mode, bool is_dir)
 {
 	struct ksmbd_tree_connect *tcon = work->tcon;
 	struct ksmbd_share_config *share = tcon->share_conf;
@@ -2503,7 +2504,7 @@ static int smb2_creat(struct ksmbd_work *work, struct path *path, char *name,
 			return rc;
 	}
 
-	rc = ksmbd_vfs_kern_path_locked(work, name, 0, path, 0);
+	rc = ksmbd_vfs_kern_path_locked(work, name, 0, parent_path, path, 0);
 	if (rc) {
 		pr_err("cannot get linux path (%s), err = %d\n",
 		       name, rc);
@@ -2573,7 +2574,7 @@ int smb2_open(struct ksmbd_work *work)
 	struct ksmbd_tree_connect *tcon = work->tcon;
 	struct smb2_create_req *req;
 	struct smb2_create_rsp *rsp;
-	struct path path;
+	struct path path, parent_path;
 	struct ksmbd_share_config *share = tcon->share_conf;
 	struct ksmbd_file *fp = NULL;
 	struct file *filp = NULL;
@@ -2794,7 +2795,8 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out1;
 	}
 
-	rc = ksmbd_vfs_kern_path_locked(work, name, LOOKUP_NO_SYMLINKS, &path, 1);
+	rc = ksmbd_vfs_kern_path_locked(work, name, LOOKUP_NO_SYMLINKS,
+					&parent_path, &path, 1);
 	if (!rc) {
 		file_present = true;
 
@@ -2914,7 +2916,8 @@ int smb2_open(struct ksmbd_work *work)
 
 	/*create file if not present */
 	if (!file_present) {
-		rc = smb2_creat(work, &path, name, open_flags, posix_mode,
+		rc = smb2_creat(work, &parent_path, &path, name, open_flags,
+				posix_mode,
 				req->CreateOptions & FILE_DIRECTORY_FILE_LE);
 		if (rc) {
 			if (rc == -ENOENT) {
@@ -3329,8 +3332,9 @@ int smb2_open(struct ksmbd_work *work)
 
 err_out:
 	if (file_present || created) {
-		inode_unlock(d_inode(path.dentry->d_parent));
-		dput(path.dentry);
+		inode_unlock(d_inode(parent_path.dentry));
+		path_put(&path);
+		path_put(&parent_path);
 	}
 	ksmbd_revert_fsids(work);
 err_out1:
@@ -5553,7 +5557,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 			    struct nls_table *local_nls)
 {
 	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
-	struct path path;
+	struct path path, parent_path;
 	bool file_present = false;
 	int rc;
 
@@ -5583,7 +5587,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 
 	ksmbd_debug(SMB, "target name is %s\n", target_name);
 	rc = ksmbd_vfs_kern_path_locked(work, link_name, LOOKUP_NO_SYMLINKS,
-					&path, 0);
+					&parent_path, &path, 0);
 	if (rc) {
 		if (rc != -ENOENT)
 			goto out;
@@ -5613,8 +5617,9 @@ static int smb2_create_link(struct ksmbd_work *work,
 		rc = -EINVAL;
 out:
 	if (file_present) {
-		inode_unlock(d_inode(path.dentry->d_parent));
+		inode_unlock(d_inode(parent_path.dentry));
 		path_put(&path);
+		path_put(&parent_path);
 	}
 	if (!IS_ERR(link_name))
 		kfree(link_name);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 73ce3fb6e405..1752a6c10bcc 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -64,13 +64,13 @@ int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child)
 
 static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 					char *pathname, unsigned int flags,
+					struct path *parent_path,
 					struct path *path)
 {
 	struct qstr last;
 	struct filename *filename;
 	struct path *root_share_path = &share_conf->vfs_path;
 	int err, type;
-	struct path parent_path;
 	struct dentry *d;
 
 	if (pathname[0] == '\0') {
@@ -85,7 +85,7 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 		return PTR_ERR(filename);
 
 	err = vfs_path_parent_lookup(filename, flags,
-				     &parent_path, &last, &type,
+				     parent_path, &last, &type,
 				     root_share_path);
 	if (err) {
 		putname(filename);
@@ -93,13 +93,13 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 	}
 
 	if (unlikely(type != LAST_NORM)) {
-		path_put(&parent_path);
+		path_put(parent_path);
 		putname(filename);
 		return -ENOENT;
 	}
 
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, 0);
+	inode_lock_nested(parent_path->dentry->d_inode, I_MUTEX_PARENT);
+	d = lookup_one_qstr_excl(&last, parent_path->dentry, 0);
 	if (IS_ERR(d))
 		goto err_out;
 
@@ -109,15 +109,22 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 	}
 
 	path->dentry = d;
-	path->mnt = share_conf->vfs_path.mnt;
-	path_put(&parent_path);
-	putname(filename);
+	path->mnt = mntget(parent_path->mnt);
+
+	if (test_share_config_flag(share_conf, KSMBD_SHARE_FLAG_CROSSMNT)) {
+		err = follow_down(path);
+		if (err < 0) {
+			path_put(path);
+			goto err_out;
+		}
+	}
 
+	putname(filename);
 	return 0;
 
 err_out:
-	inode_unlock(parent_path.dentry->d_inode);
-	path_put(&parent_path);
+	inode_unlock(d_inode(parent_path->dentry));
+	path_put(parent_path);
 	putname(filename);
 	return -ENOENT;
 }
@@ -1196,14 +1203,14 @@ static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name,
  * Return:	0 on success, otherwise error
  */
 int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
-			       unsigned int flags, struct path *path,
-			       bool caseless)
+			       unsigned int flags, struct path *parent_path,
+			       struct path *path, bool caseless)
 {
 	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
 	int err;
-	struct path parent_path;
 
-	err = ksmbd_vfs_path_lookup_locked(share_conf, name, flags, path);
+	err = ksmbd_vfs_path_lookup_locked(share_conf, name, flags, parent_path,
+					   path);
 	if (!err)
 		return 0;
 
@@ -1218,10 +1225,10 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 		path_len = strlen(filepath);
 		remain_len = path_len;
 
-		parent_path = share_conf->vfs_path;
-		path_get(&parent_path);
+		*parent_path = share_conf->vfs_path;
+		path_get(parent_path);
 
-		while (d_can_lookup(parent_path.dentry)) {
+		while (d_can_lookup(parent_path->dentry)) {
 			char *filename = filepath + path_len - remain_len;
 			char *next = strchrnul(filename, '/');
 			size_t filename_len = next - filename;
@@ -1230,7 +1237,7 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 			if (filename_len == 0)
 				break;
 
-			err = ksmbd_vfs_lookup_in_dir(&parent_path, filename,
+			err = ksmbd_vfs_lookup_in_dir(parent_path, filename,
 						      filename_len,
 						      work->conn->um);
 			if (err)
@@ -1247,8 +1254,8 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 				goto out2;
 			else if (is_last)
 				goto out1;
-			path_put(&parent_path);
-			parent_path = *path;
+			path_put(parent_path);
+			*parent_path = *path;
 
 			next[0] = '/';
 			remain_len -= filename_len + 1;
@@ -1256,16 +1263,17 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 
 		err = -EINVAL;
 out2:
-		path_put(&parent_path);
+		path_put(parent_path);
 out1:
 		kfree(filepath);
 	}
 
 	if (!err) {
-		err = ksmbd_vfs_lock_parent(parent_path.dentry, path->dentry);
-		if (err)
-			dput(path->dentry);
-		path_put(&parent_path);
+		err = ksmbd_vfs_lock_parent(parent_path->dentry, path->dentry);
+		if (err) {
+			path_put(path);
+			path_put(parent_path);
+		}
 	}
 	return err;
 }
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 3e3c92d22e3e..a7cc0aad6d57 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -115,8 +115,8 @@ int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
 			   const struct path *path, char *attr_name);
 int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
-			       unsigned int flags, struct path *path,
-			       bool caseless);
+			       unsigned int flags, struct path *parent_path,
+			       struct path *path, bool caseless);
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,
-- 
2.25.1


