Return-Path: <stable+bounces-7679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC6A8175BE
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6161E283D23
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6EC4FF9F;
	Mon, 18 Dec 2023 15:38:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCCB42389
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d393e5d325so10529405ad.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913886; x=1703518686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyyUtCq76OrMfFbk6OLFA0oaHtJOasOnnhVGmhNS0ng=;
        b=JGL6Y6+nVyS/kVOHWG3vYCaEpBSjcp9a+7St+f0J9WfMZQ+XZhglUXmCTfhn9DtwhR
         gXXOrbv4GCrD+SKZZAgL95RIaZoZQDaCMs2sU6e2ovySbxGvVJGnzPPQr5cT53knRdki
         a+DENyZZwHVSiV/3xsShTA27kcdTbEQu/LFo0NHKj165lH5chsPRVlZOPmd1I+kjYHuE
         mhkT1G6EOzi5s/9SkhxBFFa7sqVFJTiqXV8cZN7e19I5+ou0g2xh2AfLjxuLLegRSTkA
         bRMcbRWqWAFcKaL+Ss40m764tepRoUJmggDVkHSHCcVvY0JKLjaBdG/6uHkKgotWWFKv
         4DLg==
X-Gm-Message-State: AOJu0YzFEtmM25jbT6Pg0j6YBbYVIuk/6TPhtU5uKRERWWneavUDFK12
	cLqWq4GMNEwxyMWYPFnG31w=
X-Google-Smtp-Source: AGHT+IFEvE9vmzsn/GJv+E+xgxwYnVmmXhKAngFDB1+4C5IMRKiTTBqLM3szPo1EC73pbXOeJ2zTrA==
X-Received: by 2002:a17:90b:46c7:b0:28b:558e:9af5 with SMTP id jx7-20020a17090b46c700b0028b558e9af5mr814781pjb.92.1702913886012;
        Mon, 18 Dec 2023 07:38:06 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:05 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Al Viro <viro@zeniv.linux.org.uk>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 050/154] ksmbd: constify struct path
Date: Tue, 19 Dec 2023 00:33:10 +0900
Message-Id: <20231218153454.8090-51-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit c22180a5e2a9e1426fab01d9e54011ec531b1b52 ]

... in particular, there should never be a non-const pointers to
any file->f_path.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/misc.c    |  2 +-
 fs/ksmbd/misc.h    |  2 +-
 fs/ksmbd/smb2pdu.c | 18 +++++++++---------
 fs/ksmbd/smbacl.c  |  6 +++---
 fs/ksmbd/smbacl.h  |  6 +++---
 fs/ksmbd/vfs.c     |  4 ++--
 fs/ksmbd/vfs.h     |  2 +-
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/ksmbd/misc.c b/fs/ksmbd/misc.c
index df991107ad2c..364a0a463dfc 100644
--- a/fs/ksmbd/misc.c
+++ b/fs/ksmbd/misc.c
@@ -159,7 +159,7 @@ int parse_stream_name(char *filename, char **stream_name, int *s_type)
  */
 
 char *convert_to_nt_pathname(struct ksmbd_share_config *share,
-			     struct path *path)
+			     const struct path *path)
 {
 	char *pathname, *ab_pathname, *nt_pathname;
 	int share_path_len = share->path_sz;
diff --git a/fs/ksmbd/misc.h b/fs/ksmbd/misc.h
index aae2a252945f..5a0ae2f8e5e7 100644
--- a/fs/ksmbd/misc.h
+++ b/fs/ksmbd/misc.h
@@ -15,7 +15,7 @@ int match_pattern(const char *str, size_t len, const char *pattern);
 int ksmbd_validate_filename(char *filename);
 int parse_stream_name(char *filename, char **stream_name, int *s_type);
 char *convert_to_nt_pathname(struct ksmbd_share_config *share,
-			     struct path *path);
+			     const struct path *path);
 int get_nlink(struct kstat *st);
 void ksmbd_conv_path_to_unix(char *path);
 void ksmbd_strip_last_slash(char *path);
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 61811c10ec93..8f929807f4c8 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2226,7 +2226,7 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
  * Return:	0 on success, otherwise error
  */
 static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
-		       struct path *path)
+		       const struct path *path)
 {
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	char *attr_name = NULL, *value;
@@ -2320,7 +2320,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 	return rc;
 }
 
-static noinline int smb2_set_stream_name_xattr(struct path *path,
+static noinline int smb2_set_stream_name_xattr(const struct path *path,
 					       struct ksmbd_file *fp,
 					       char *stream_name, int s_type)
 {
@@ -2359,7 +2359,7 @@ static noinline int smb2_set_stream_name_xattr(struct path *path,
 	return 0;
 }
 
-static int smb2_remove_smb_xattrs(struct path *path)
+static int smb2_remove_smb_xattrs(const struct path *path)
 {
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	char *name, *xattr_list = NULL;
@@ -2393,7 +2393,7 @@ static int smb2_remove_smb_xattrs(struct path *path)
 	return err;
 }
 
-static int smb2_create_truncate(struct path *path)
+static int smb2_create_truncate(const struct path *path)
 {
 	int rc = vfs_truncate(path, 0);
 
@@ -2412,7 +2412,7 @@ static int smb2_create_truncate(struct path *path)
 	return rc;
 }
 
-static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, struct path *path,
+static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, const struct path *path,
 			    struct ksmbd_file *fp)
 {
 	struct xattr_dos_attrib da = {0};
@@ -2435,7 +2435,7 @@ static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, struct path *path,
 }
 
 static void smb2_update_xattrs(struct ksmbd_tree_connect *tcon,
-			       struct path *path, struct ksmbd_file *fp)
+			       const struct path *path, struct ksmbd_file *fp)
 {
 	struct xattr_dos_attrib da;
 	int rc;
@@ -2495,7 +2495,7 @@ static int smb2_creat(struct ksmbd_work *work, struct path *path, char *name,
 
 static int smb2_create_sd_buffer(struct ksmbd_work *work,
 				 struct smb2_create_req *req,
-				 struct path *path)
+				 const struct path *path)
 {
 	struct create_context *context;
 	struct create_sd_buf_req *sd_buf;
@@ -4201,7 +4201,7 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 	int rc, name_len, value_len, xattr_list_len, idx;
 	ssize_t buf_free_len, alignment_bytes, next_offset, rsp_data_cnt = 0;
 	struct smb2_ea_info_req *ea_req = NULL;
-	struct path *path;
+	const struct path *path;
 	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
 
 	if (!(fp->daccess & FILE_READ_EA_LE)) {
@@ -4523,7 +4523,7 @@ static void get_file_stream_info(struct ksmbd_work *work,
 	struct smb2_file_stream_info *file_info;
 	char *stream_name, *xattr_list = NULL, *stream_buf;
 	struct kstat stat;
-	struct path *path = &fp->filp->f_path;
+	const struct path *path = &fp->filp->f_path;
 	ssize_t xattr_list_len;
 	int nbytes = 0, streamlen, stream_name_len, next, idx = 0;
 	int buf_free_len;
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 83f805248a81..253e8133520a 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -991,7 +991,7 @@ static void smb_set_ace(struct smb_ace *ace, const struct smb_sid *sid, u8 type,
 }
 
 int smb_inherit_dacl(struct ksmbd_conn *conn,
-		     struct path *path,
+		     const struct path *path,
 		     unsigned int uid, unsigned int gid)
 {
 	const struct smb_sid *psid, *creator = NULL;
@@ -1208,7 +1208,7 @@ bool smb_inherit_flags(int flags, bool is_dir)
 	return false;
 }
 
-int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
+int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, int uid)
 {
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
@@ -1375,7 +1375,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
 }
 
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
-		 struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
+		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
 		 bool type_check)
 {
 	int rc;
diff --git a/fs/ksmbd/smbacl.h b/fs/ksmbd/smbacl.h
index fcb2c83f2992..f06abf247445 100644
--- a/fs/ksmbd/smbacl.h
+++ b/fs/ksmbd/smbacl.h
@@ -201,12 +201,12 @@ void posix_state_to_acl(struct posix_acl_state *state,
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
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 8c542581f62a..284aa87f3e5c 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -540,7 +540,7 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
  *
  * Return:	0 on success, otherwise error
  */
-int ksmbd_vfs_getattr(struct path *path, struct kstat *stat)
+int ksmbd_vfs_getattr(const struct path *path, struct kstat *stat)
 {
 	int err;
 
@@ -1165,7 +1165,7 @@ static int __caseless_lookup(struct dir_context *ctx, const char *name,
  *
  * Return:	0 on success, otherwise error
  */
-static int ksmbd_vfs_lookup_in_dir(struct path *dir, char *name, size_t namelen)
+static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name, size_t namelen)
 {
 	int ret;
 	struct file *dfilp;
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 432c94773177..7dd054f86850 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -124,7 +124,7 @@ int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id);
 int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name);
 int ksmbd_vfs_link(struct ksmbd_work *work,
 		   const char *oldname, const char *newname);
-int ksmbd_vfs_getattr(struct path *path, struct kstat *stat);
+int ksmbd_vfs_getattr(const struct path *path, struct kstat *stat);
 int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
 			char *newname);
 int ksmbd_vfs_truncate(struct ksmbd_work *work,
-- 
2.25.1


