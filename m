Return-Path: <stable+bounces-8048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4B881A445
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A711F26A1A
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603C04AF89;
	Wed, 20 Dec 2023 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UPAYLSf/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E34AF7B;
	Wed, 20 Dec 2023 16:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1565C433C7;
	Wed, 20 Dec 2023 16:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088766;
	bh=bxs0fC8WNin3GcAZxnRoqxmaJFeRVZz0z93cPgL2W6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UPAYLSf/l6onGXE2GW7vy1AeunehGZ6dSDvl/jM5W0e4pLO9HkALQUu6Ff0pvML5l
	 9jvw4Ni5eREUQ0iH5lzgEXvVbIMydHA/nsAzXIp3JcWvUJ4OchdMvqzDI7cp6/Vy/S
	 bVetAbqiniq7xefref9F7DMKO44tLiga6QokoGC4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 050/159] ksmbd: constify struct path
Date: Wed, 20 Dec 2023 17:08:35 +0100
Message-ID: <20231220160933.662870613@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit c22180a5e2a9e1426fab01d9e54011ec531b1b52 ]

... in particular, there should never be a non-const pointers to
any file->f_path.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/misc.c    |    2 +-
 fs/ksmbd/misc.h    |    2 +-
 fs/ksmbd/smb2pdu.c |   18 +++++++++---------
 fs/ksmbd/smbacl.c  |    6 +++---
 fs/ksmbd/smbacl.h  |    6 +++---
 fs/ksmbd/vfs.c     |    4 ++--
 fs/ksmbd/vfs.h     |    2 +-
 7 files changed, 20 insertions(+), 20 deletions(-)

--- a/fs/ksmbd/misc.c
+++ b/fs/ksmbd/misc.c
@@ -159,7 +159,7 @@ out:
  */
 
 char *convert_to_nt_pathname(struct ksmbd_share_config *share,
-			     struct path *path)
+			     const struct path *path)
 {
 	char *pathname, *ab_pathname, *nt_pathname;
 	int share_path_len = share->path_sz;
--- a/fs/ksmbd/misc.h
+++ b/fs/ksmbd/misc.h
@@ -15,7 +15,7 @@ int match_pattern(const char *str, size_
 int ksmbd_validate_filename(char *filename);
 int parse_stream_name(char *filename, char **stream_name, int *s_type);
 char *convert_to_nt_pathname(struct ksmbd_share_config *share,
-			     struct path *path);
+			     const struct path *path);
 int get_nlink(struct kstat *st);
 void ksmbd_conv_path_to_unix(char *path);
 void ksmbd_strip_last_slash(char *path);
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2226,7 +2226,7 @@ out:
  * Return:	0 on success, otherwise error
  */
 static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
-		       struct path *path)
+		       const struct path *path)
 {
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	char *attr_name = NULL, *value;
@@ -2320,7 +2320,7 @@ next:
 	return rc;
 }
 
-static noinline int smb2_set_stream_name_xattr(struct path *path,
+static noinline int smb2_set_stream_name_xattr(const struct path *path,
 					       struct ksmbd_file *fp,
 					       char *stream_name, int s_type)
 {
@@ -2359,7 +2359,7 @@ static noinline int smb2_set_stream_name
 	return 0;
 }
 
-static int smb2_remove_smb_xattrs(struct path *path)
+static int smb2_remove_smb_xattrs(const struct path *path)
 {
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	char *name, *xattr_list = NULL;
@@ -2393,7 +2393,7 @@ out:
 	return err;
 }
 
-static int smb2_create_truncate(struct path *path)
+static int smb2_create_truncate(const struct path *path)
 {
 	int rc = vfs_truncate(path, 0);
 
@@ -2412,7 +2412,7 @@ static int smb2_create_truncate(struct p
 	return rc;
 }
 
-static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, struct path *path,
+static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, const struct path *path,
 			    struct ksmbd_file *fp)
 {
 	struct xattr_dos_attrib da = {0};
@@ -2435,7 +2435,7 @@ static void smb2_new_xattrs(struct ksmbd
 }
 
 static void smb2_update_xattrs(struct ksmbd_tree_connect *tcon,
-			       struct path *path, struct ksmbd_file *fp)
+			       const struct path *path, struct ksmbd_file *fp)
 {
 	struct xattr_dos_attrib da;
 	int rc;
@@ -2495,7 +2495,7 @@ static int smb2_creat(struct ksmbd_work
 
 static int smb2_create_sd_buffer(struct ksmbd_work *work,
 				 struct smb2_create_req *req,
-				 struct path *path)
+				 const struct path *path)
 {
 	struct create_context *context;
 	struct create_sd_buf_req *sd_buf;
@@ -4201,7 +4201,7 @@ static int smb2_get_ea(struct ksmbd_work
 	int rc, name_len, value_len, xattr_list_len, idx;
 	ssize_t buf_free_len, alignment_bytes, next_offset, rsp_data_cnt = 0;
 	struct smb2_ea_info_req *ea_req = NULL;
-	struct path *path;
+	const struct path *path;
 	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
 
 	if (!(fp->daccess & FILE_READ_EA_LE)) {
@@ -4523,7 +4523,7 @@ static void get_file_stream_info(struct
 	struct smb2_file_stream_info *file_info;
 	char *stream_name, *xattr_list = NULL, *stream_buf;
 	struct kstat stat;
-	struct path *path = &fp->filp->f_path;
+	const struct path *path = &fp->filp->f_path;
 	ssize_t xattr_list_len;
 	int nbytes = 0, streamlen, stream_name_len, next, idx = 0;
 	int buf_free_len;
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -991,7 +991,7 @@ static void smb_set_ace(struct smb_ace *
 }
 
 int smb_inherit_dacl(struct ksmbd_conn *conn,
-		     struct path *path,
+		     const struct path *path,
 		     unsigned int uid, unsigned int gid)
 {
 	const struct smb_sid *psid, *creator = NULL;
@@ -1208,7 +1208,7 @@ bool smb_inherit_flags(int flags, bool i
 	return false;
 }
 
-int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
+int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, int uid)
 {
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
@@ -1375,7 +1375,7 @@ err_out:
 }
 
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
-		 struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
+		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
 		 bool type_check)
 {
 	int rc;
--- a/fs/ksmbd/smbacl.h
+++ b/fs/ksmbd/smbacl.h
@@ -201,12 +201,12 @@ void posix_state_to_acl(struct posix_acl
 			struct posix_acl_entry *pace);
 int compare_sids(const struct smb_sid *ctsid, const struct smb_sid *cwsid);
 bool smb_inherit_flags(int flags, bool is_dir);
-int smb_inherit_dacl(struct ksmbd_conn *conn, struct path *path,
+int smb_inherit_dacl(struct ksmbd_conn *conn, const struct path *path,
 		     unsigned int uid, unsigned int gid);
-int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
+int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, int uid);
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
-		 struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
+		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
 		 bool type_check);
 void id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid);
 void ksmbd_init_domain(u32 *sub_auth);
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -540,7 +540,7 @@ out:
  *
  * Return:	0 on success, otherwise error
  */
-int ksmbd_vfs_getattr(struct path *path, struct kstat *stat)
+int ksmbd_vfs_getattr(const struct path *path, struct kstat *stat)
 {
 	int err;
 
@@ -1165,7 +1165,7 @@ static int __caseless_lookup(struct dir_
  *
  * Return:	0 on success, otherwise error
  */
-static int ksmbd_vfs_lookup_in_dir(struct path *dir, char *name, size_t namelen)
+static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name, size_t namelen)
 {
 	int ret;
 	struct file *dfilp;
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -124,7 +124,7 @@ int ksmbd_vfs_fsync(struct ksmbd_work *w
 int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name);
 int ksmbd_vfs_link(struct ksmbd_work *work,
 		   const char *oldname, const char *newname);
-int ksmbd_vfs_getattr(struct path *path, struct kstat *stat);
+int ksmbd_vfs_getattr(const struct path *path, struct kstat *stat);
 int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
 			char *newname);
 int ksmbd_vfs_truncate(struct ksmbd_work *work,



