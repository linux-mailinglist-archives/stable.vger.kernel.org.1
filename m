Return-Path: <stable+bounces-7661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C638175A9
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9DE283D3F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0680F4FF73;
	Mon, 18 Dec 2023 15:37:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7F4FF75
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso1075180a12.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913827; x=1703518627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uusHOQW7/t44xHPtqJTb1p/hYQmdwAz9kB63ZfWBfFA=;
        b=iyLgqRJ60awJs/TQOk1+y+7P4Gyz5cAYSwzP8Y+wXsG7tc6yHWdeuUsC6+x1vFwrQF
         MRjiGad6S8OTQJ31P+5LgsMtrz5qvhokgQ3u63lByAgEF538PEL5Bsgkz1SnhhYSN/sh
         I/bpSdJCus+gy1KtOr2OnTEso9Ob2HzhQCqJyXpRdaXkNim4xPaqmL0n67XezsN0QYbE
         Qqd3C/C+xAz8pkTlo85ZDBYqSWWRls3uh5kDTVKv76AGVRu8noAVnu9eH0oXuODKhieJ
         xCeSrvCvAKZ1O1GvryXJd3mnZwbATlTPa2naBOM5OEqzkjWsl4elxWKK08U2Q3P685Rq
         8I/w==
X-Gm-Message-State: AOJu0Yx7D73k1DVVQ4Oc5i2oD1qfpMF0MEqnNfpMR16Q+/f7YysgudzM
	NXpm8etuAyrzsZ0+RA5xVD4=
X-Google-Smtp-Source: AGHT+IFaQGC8wY1djwYpNQdX5BX8ZoXUnOB+WD3pWEJ2XL6uHWKci/gW2F/EdocuMV0QGzrTa14nCQ==
X-Received: by 2002:a17:90b:1113:b0:286:6cc1:289 with SMTP id gi19-20020a17090b111300b002866cc10289mr7226225pjb.84.1702913822417;
        Mon, 18 Dec 2023 07:37:02 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:01 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 031/154] ksmbd: remove filename in ksmbd_file
Date: Tue, 19 Dec 2023 00:32:51 +0900
Message-Id: <20231218153454.8090-32-linkinjeon@kernel.org>
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

[ Upstream commit 50f500b7f6335404b18bbffa93e3a905a08d061a ]

If the filename is change by underlying rename the server, fp->filename
and real filename can be different. This patch remove the uses of
fp->filename in ksmbd and replace it with d_path().

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/misc.c      | 40 +++++++++++++++++++++++++++++++---------
 fs/ksmbd/misc.h      |  3 ++-
 fs/ksmbd/oplock.c    | 30 ------------------------------
 fs/ksmbd/oplock.h    |  2 --
 fs/ksmbd/smb2pdu.c   | 21 +++++++--------------
 fs/ksmbd/vfs.c       |  6 ++----
 fs/ksmbd/vfs_cache.c |  1 -
 fs/ksmbd/vfs_cache.h |  1 -
 8 files changed, 42 insertions(+), 62 deletions(-)

diff --git a/fs/ksmbd/misc.c b/fs/ksmbd/misc.c
index 60e7ac62c917..1e2076a53bed 100644
--- a/fs/ksmbd/misc.c
+++ b/fs/ksmbd/misc.c
@@ -158,19 +158,41 @@ int parse_stream_name(char *filename, char **stream_name, int *s_type)
  * Return : windows path string or error
  */
 
-char *convert_to_nt_pathname(char *filename)
+char *convert_to_nt_pathname(struct ksmbd_share_config *share,
+			     struct path *path)
 {
-	char *ab_pathname;
+	char *pathname, *ab_pathname, *nt_pathname;
+	int share_path_len = share->path_sz;
 
-	if (strlen(filename) == 0)
-		filename = "\\";
+	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!pathname)
+		return ERR_PTR(-EACCES);
 
-	ab_pathname = kstrdup(filename, GFP_KERNEL);
-	if (!ab_pathname)
-		return NULL;
+	ab_pathname = d_path(path, pathname, PATH_MAX);
+	if (IS_ERR(ab_pathname)) {
+		nt_pathname = ERR_PTR(-EACCES);
+		goto free_pathname;
+	}
+
+	if (strncmp(ab_pathname, share->path, share_path_len)) {
+		nt_pathname = ERR_PTR(-EACCES);
+		goto free_pathname;
+	}
+
+	nt_pathname = kzalloc(strlen(&ab_pathname[share_path_len]) + 2, GFP_KERNEL);
+	if (!nt_pathname) {
+		nt_pathname = ERR_PTR(-ENOMEM);
+		goto free_pathname;
+	}
+	if (ab_pathname[share_path_len] == '\0')
+		strcpy(nt_pathname, "/");
+	strcat(nt_pathname, &ab_pathname[share_path_len]);
+
+	ksmbd_conv_path_to_windows(nt_pathname);
 
-	ksmbd_conv_path_to_windows(ab_pathname);
-	return ab_pathname;
+free_pathname:
+	kfree(pathname);
+	return nt_pathname;
 }
 
 int get_nlink(struct kstat *st)
diff --git a/fs/ksmbd/misc.h b/fs/ksmbd/misc.h
index 253366bd0951..aae2a252945f 100644
--- a/fs/ksmbd/misc.h
+++ b/fs/ksmbd/misc.h
@@ -14,7 +14,8 @@ struct ksmbd_file;
 int match_pattern(const char *str, size_t len, const char *pattern);
 int ksmbd_validate_filename(char *filename);
 int parse_stream_name(char *filename, char **stream_name, int *s_type);
-char *convert_to_nt_pathname(char *filename);
+char *convert_to_nt_pathname(struct ksmbd_share_config *share,
+			     struct path *path);
 int get_nlink(struct kstat *st);
 void ksmbd_conv_path_to_unix(char *path);
 void ksmbd_strip_last_slash(char *path);
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 2e52ebc209d2..ae5fc4b2c133 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1696,33 +1696,3 @@ struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
 	read_unlock(&lease_list_lock);
 	return ret_op;
 }
-
-int smb2_check_durable_oplock(struct ksmbd_file *fp,
-			      struct lease_ctx_info *lctx, char *name)
-{
-	struct oplock_info *opinfo = opinfo_get(fp);
-	int ret = 0;
-
-	if (opinfo && opinfo->is_lease) {
-		if (!lctx) {
-			pr_err("open does not include lease\n");
-			ret = -EBADF;
-			goto out;
-		}
-		if (memcmp(opinfo->o_lease->lease_key, lctx->lease_key,
-			   SMB2_LEASE_KEY_SIZE)) {
-			pr_err("invalid lease key\n");
-			ret = -EBADF;
-			goto out;
-		}
-		if (name && strcmp(fp->filename, name)) {
-			pr_err("invalid name reconnect %s\n", name);
-			ret = -EINVAL;
-			goto out;
-		}
-	}
-out:
-	if (opinfo)
-		opinfo_put(opinfo);
-	return ret;
-}
diff --git a/fs/ksmbd/oplock.h b/fs/ksmbd/oplock.h
index e1ba363b412a..4b0fe6da7694 100644
--- a/fs/ksmbd/oplock.h
+++ b/fs/ksmbd/oplock.h
@@ -124,6 +124,4 @@ struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
 int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
 			struct lease_ctx_info *lctx);
 void destroy_lease_table(struct ksmbd_conn *conn);
-int smb2_check_durable_oplock(struct ksmbd_file *fp,
-			      struct lease_ctx_info *lctx, char *name);
 #endif /* __KSMBD_OPLOCK_H */
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 6b4132ea1956..a1bcb822c95d 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2988,7 +2988,6 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out;
 	}
 
-	fp->filename = name;
 	fp->cdoption = req->CreateDisposition;
 	fp->daccess = daccess;
 	fp->saccess = req->ShareAccess;
@@ -3343,14 +3342,13 @@ int smb2_open(struct ksmbd_work *work)
 		if (!rsp->hdr.Status)
 			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
 
-		if (!fp || !fp->filename)
-			kfree(name);
 		if (fp)
 			ksmbd_fd_put(work, fp);
 		smb2_set_err_rsp(work);
 		ksmbd_debug(SMB, "Error response: %x\n", rsp->hdr.Status);
 	}
 
+	kfree(name);
 	kfree(lc);
 
 	return 0;
@@ -3969,8 +3967,6 @@ int smb2_query_dir(struct ksmbd_work *work)
 		ksmbd_debug(SMB, "Search pattern is %s\n", srch_ptr);
 	}
 
-	ksmbd_debug(SMB, "Directory name is %s\n", dir_fp->filename);
-
 	if (srch_flag & SMB2_REOPEN || srch_flag & SMB2_RESTART_SCANS) {
 		ksmbd_debug(SMB, "Restart directory scan\n");
 		generic_file_llseek(dir_fp->filp, 0, SEEK_SET);
@@ -4456,9 +4452,9 @@ static int get_file_all_info(struct ksmbd_work *work,
 		return -EACCES;
 	}
 
-	filename = convert_to_nt_pathname(fp->filename);
-	if (!filename)
-		return -ENOMEM;
+	filename = convert_to_nt_pathname(work->tcon->share_conf, &fp->filp->f_path);
+	if (IS_ERR(filename))
+		return PTR_ERR(filename);
 
 	inode = file_inode(fp->filp);
 	generic_fillattr(file_mnt_user_ns(fp->filp), inode, &stat);
@@ -5761,8 +5757,7 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 		size = i_size_read(inode);
 		rc = ksmbd_vfs_truncate(work, fp, alloc_blks * 512);
 		if (rc) {
-			pr_err("truncate failed! filename : %s, err %d\n",
-			       fp->filename, rc);
+			pr_err("truncate failed!, err %d\n", rc);
 			return rc;
 		}
 		if (size < alloc_blks * 512)
@@ -5792,12 +5787,10 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 	 * truncated range.
 	 */
 	if (inode->i_sb->s_magic != MSDOS_SUPER_MAGIC) {
-		ksmbd_debug(SMB, "filename : %s truncated to newsize %lld\n",
-			    fp->filename, newsize);
+		ksmbd_debug(SMB, "truncated to newsize %lld\n", newsize);
 		rc = ksmbd_vfs_truncate(work, fp, newsize);
 		if (rc) {
-			ksmbd_debug(SMB, "truncate failed! filename : %s err %d\n",
-				    fp->filename, rc);
+			ksmbd_debug(SMB, "truncate failed!, err %d\n", rc);
 			if (rc != -EAGAIN)
 				rc = -EBADF;
 			return rc;
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index f76acd83c294..0092e6911b14 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -397,8 +397,7 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 
 	nbytes = kernel_read(filp, rbuf, count, pos);
 	if (nbytes < 0) {
-		pr_err("smb read failed for (%s), err = %zd\n",
-		       fp->filename, nbytes);
+		pr_err("smb read failed, err = %zd\n", nbytes);
 		return nbytes;
 	}
 
@@ -873,8 +872,7 @@ int ksmbd_vfs_truncate(struct ksmbd_work *work,
 
 	err = vfs_truncate(&filp->f_path, size);
 	if (err)
-		pr_err("truncate failed for filename : %s err %d\n",
-		       fp->filename, err);
+		pr_err("truncate failed, err %d\n", err);
 	return err;
 }
 
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index b67ce2d52cee..52ae9937d6a1 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -328,7 +328,6 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 		kfree(smb_lock);
 	}
 
-	kfree(fp->filename);
 	if (ksmbd_stream_fd(fp))
 		kfree(fp->stream.name);
 	kmem_cache_free(filp_cache, fp);
diff --git a/fs/ksmbd/vfs_cache.h b/fs/ksmbd/vfs_cache.h
index 36239ce31afd..fcb13413fa8d 100644
--- a/fs/ksmbd/vfs_cache.h
+++ b/fs/ksmbd/vfs_cache.h
@@ -62,7 +62,6 @@ struct ksmbd_inode {
 
 struct ksmbd_file {
 	struct file			*filp;
-	char				*filename;
 	u64				persistent_id;
 	u64				volatile_id;
 
-- 
2.25.1


