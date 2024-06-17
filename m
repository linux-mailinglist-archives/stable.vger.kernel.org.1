Return-Path: <stable+bounces-52570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CC890B88A
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 19:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370E91C23601
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 17:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733F918EFFC;
	Mon, 17 Jun 2024 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ixa7xbWb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B2218A93C
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646832; cv=none; b=VAPC4Y9/sOqkgkzDRVPEVSCUur9eita3B8AZaPnfWj9b1FTuMJ7fuuPR+EZjzmN8seyM4nObxW5J33LwGF3gc1YyOa1IeGh3o8Ys9AsMnCrasY2CpynNAPlHVrur6KrZRFd3C9c7auT4eEPQimzjppVBRobaXnlvPb8dFIsljvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646832; c=relaxed/simple;
	bh=1D8168PZ0Tjo5kXicNezcX12Xevd4p++rtyoxXevT9I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K8hqGT6dg5Vft+XuI1XUQuQzJT8KkqnZItvLvuM5Nan7MymEsnFKNQ7vI+ZvNuwjaG3sXOLaTiut+Iw5+IM+mUyQnVMWgxRIFORfs+wpxz0bCugg2IZ9d1GaHRkeYQflYEWHoFN2RyGT4cWT6nbrXj1UUhotF0t0r2QvBSgp14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ixa7xbWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EC9C2BD10;
	Mon, 17 Jun 2024 17:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718646831;
	bh=1D8168PZ0Tjo5kXicNezcX12Xevd4p++rtyoxXevT9I=;
	h=Subject:To:Cc:From:Date:From;
	b=ixa7xbWbwhuWqZkEknKc0gwsB+GTbYZil4HgsdjsQAWbJtJfb00/6UCXOH25aYIAs
	 kjW003NjncaPI9nLSST7P+ma7JNJmB/KFJ9sdeAe490T2N7DSdjF596Ybv3TCwgn7a
	 gMcmcJO3XcbGM9v7X21rgSJedTpFk+f4YbsEraLQ=
Subject: FAILED: patch "[PATCH] ksmbd: fix missing use of get_write in in smb2_set_ea()" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,stfrench@microsoft.com,wangzhaolong1@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 19:53:48 +0200
Message-ID: <2024061748-silica-lively-43ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2bfc4214c69c62da13a9da8e3c3db5539da2ccd3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061748-silica-lively-43ca@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

2bfc4214c69c ("ksmbd: fix missing use of get_write in in smb2_set_ea()")
864fb5d37163 ("ksmbd: fix possible deadlock in smb2_open")
2b57a4322b1b ("ksmbd: check if a mount point is crossed during path lookup")
40b268d384a2 ("ksmbd: add mnt_want_write to ksmbd vfs functions")
6fe55c2799bc ("ksmbd: call putname after using the last component")
df14afeed2e6 ("ksmbd: fix uninitialized pointer read in smb2_create_link()")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
211db0ac9e3d ("ksmbd: remove internal.h include")
4d7ca4090184 ("fs: port vfs{g,u}id helpers to mnt_idmap")
c14329d39f2d ("fs: port fs{g,u}id helpers to mnt_idmap")
e67fe63341b8 ("fs: port i_{g,u}id_into_vfs{g,u}id() to mnt_idmap")
0dbe12f2e49c ("fs: port i_{g,u}id_{needs_}update() to mnt_idmap")
9452e93e6dae ("fs: port privilege checking helpers to mnt_idmap")
f2d40141d5d9 ("fs: port inode_init_owner() to mnt_idmap")
4609e1f18e19 ("fs: port ->permission() to pass mnt_idmap")
13e83a4923be ("fs: port ->set_acl() to pass mnt_idmap")
77435322777d ("fs: port ->get_acl() to pass mnt_idmap")
011e2b717b1b ("fs: port ->tmpfile() to pass mnt_idmap")
5ebb29bee8d5 ("fs: port ->mknod() to pass mnt_idmap")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2bfc4214c69c62da13a9da8e3c3db5539da2ccd3 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 11 Jun 2024 23:27:27 +0900
Subject: [PATCH] ksmbd: fix missing use of get_write in in smb2_set_ea()

Fix an issue where get_write is not used in smb2_set_ea().

Fixes: 6fc0a265e1b9 ("ksmbd: fix potential circular locking issue in smb2_set_ea()")
Cc: stable@vger.kernel.org
Reported-by: Wang Zhaolong <wangzhaolong1@huawei.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f79d06d2d655..e7e07891781b 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2367,7 +2367,8 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 			if (rc > 0) {
 				rc = ksmbd_vfs_remove_xattr(idmap,
 							    path,
-							    attr_name);
+							    attr_name,
+							    get_write);
 
 				if (rc < 0) {
 					ksmbd_debug(SMB,
@@ -2382,7 +2383,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 		} else {
 			rc = ksmbd_vfs_setxattr(idmap, path, attr_name, value,
 						le16_to_cpu(eabuf->EaValueLength),
-						0, true);
+						0, get_write);
 			if (rc < 0) {
 				ksmbd_debug(SMB,
 					    "ksmbd_vfs_setxattr is failed(%d)\n",
@@ -2474,7 +2475,7 @@ static int smb2_remove_smb_xattrs(const struct path *path)
 		    !strncmp(&name[XATTR_USER_PREFIX_LEN], STREAM_PREFIX,
 			     STREAM_PREFIX_LEN)) {
 			err = ksmbd_vfs_remove_xattr(idmap, path,
-						     name);
+						     name, true);
 			if (err)
 				ksmbd_debug(SMB, "remove xattr failed : %s\n",
 					    name);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 51b1b0bed616..9e859ba010cf 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1058,16 +1058,21 @@ int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
 }
 
 int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
-			   const struct path *path, char *attr_name)
+			   const struct path *path, char *attr_name,
+			   bool get_write)
 {
 	int err;
 
-	err = mnt_want_write(path->mnt);
-	if (err)
-		return err;
+	if (get_write == true) {
+		err = mnt_want_write(path->mnt);
+		if (err)
+			return err;
+	}
 
 	err = vfs_removexattr(idmap, path->dentry, attr_name);
-	mnt_drop_write(path->mnt);
+
+	if (get_write == true)
+		mnt_drop_write(path->mnt);
 
 	return err;
 }
@@ -1380,7 +1385,7 @@ int ksmbd_vfs_remove_sd_xattrs(struct mnt_idmap *idmap, const struct path *path)
 		ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
 
 		if (!strncmp(name, XATTR_NAME_SD, XATTR_NAME_SD_LEN)) {
-			err = ksmbd_vfs_remove_xattr(idmap, path, name);
+			err = ksmbd_vfs_remove_xattr(idmap, path, name, true);
 			if (err)
 				ksmbd_debug(SMB, "remove xattr failed : %s\n", name);
 		}
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index cfe1c8092f23..cb76f4b5bafe 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -114,7 +114,8 @@ int ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
 int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 				size_t *xattr_stream_name_size, int s_type);
 int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
-			   const struct path *path, char *attr_name);
+			   const struct path *path, char *attr_name,
+			   bool get_write);
 int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 			       unsigned int flags, struct path *parent_path,
 			       struct path *path, bool caseless);
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 6cb599cd287e..8b2e37c8716e 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -254,7 +254,8 @@ static void __ksmbd_inode_close(struct ksmbd_file *fp)
 		ci->m_flags &= ~S_DEL_ON_CLS_STREAM;
 		err = ksmbd_vfs_remove_xattr(file_mnt_idmap(filp),
 					     &filp->f_path,
-					     fp->stream.name);
+					     fp->stream.name,
+					     true);
 		if (err)
 			pr_err("remove xattr failed : %s\n",
 			       fp->stream.name);


