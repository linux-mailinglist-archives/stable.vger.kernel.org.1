Return-Path: <stable+bounces-9096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECE5820A32
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E0F1F2206F
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC1217D3;
	Sun, 31 Dec 2023 07:17:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1331017C3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6da55cc8e78so915983b3a.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:17:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007039; x=1704611839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fy6cZL5kbpA5QK8YzGhVK2DJ8NUV/k7dXyffb0t5d2I=;
        b=p29eh4gH4KRVrt8EX8RQx4dUUG+gojTBBGMkM4SuYixKWsIJh14ukPGFnUg79tVglK
         VORbyUoBlliXUb1R69OfUY9Vx1i/J550hrUcN2uOKKCzODB0AOtKQR8NzDJd/ej68MZc
         3X4MmpsD334CN5k13ADEDQsfDZBS0QMKjuZYmRNHyQMvTN5bRdWZGKForFTj/4Uk7cZW
         KY5cB2xaF9XKnBgAmUbwQe4hQpRe8TweuGRuNVbnAWUuXi8jl5p4BRvZWeDNdXs13/bS
         Glt/VmAsqqL87D2OQUmCRmSz7fK7GT3I5u9nINPqtwg8fT+cDjoF8wmEdgWi+GKC8HEP
         nJRw==
X-Gm-Message-State: AOJu0YyV6JQ6CT/724qzqOn48gfUCcibbghT9Dh7JJTO/9eRz+f8H2Vp
	DvOniUtsFdb+/u78FGNSZBQ=
X-Google-Smtp-Source: AGHT+IHMsKyI+Hu4DzTEWVNXhYLhmkxATGZV47nONZfQLOW45RR/dC3gSZ5npvR1HDOY446DvXB4Cw==
X-Received: by 2002:a05:6a00:a03:b0:6da:23d7:3786 with SMTP id p3-20020a056a000a0300b006da23d73786mr5082016pfh.21.1704007039408;
        Sat, 30 Dec 2023 23:17:19 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:17:18 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 62/73] ksmbd: separately allocate ci per dentry
Date: Sun, 31 Dec 2023 16:13:21 +0900
Message-Id: <20231231071332.31724-63-linkinjeon@kernel.org>
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

[ Upstream commit 4274a9dc6aeb9fea66bffba15697a35ae8983b6a ]

xfstests generic/002 test fail when enabling smb2 leases feature.
This test create hard link file, but removeal failed.
ci has a file open count to count file open through the smb client,
but in the case of hard link files, The allocation of ci per inode
cause incorrectly open count for file deletion. This patch allocate
ci per dentry to counts open counts for hard link.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c   |  2 +-
 fs/smb/server/vfs.c       |  2 +-
 fs/smb/server/vfs_cache.c | 33 +++++++++++++--------------------
 fs/smb/server/vfs_cache.h |  6 +++---
 4 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 91fa172a45f1..4c759f84312e 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3039,7 +3039,7 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	}
 
-	rc = ksmbd_query_inode_status(d_inode(path.dentry->d_parent));
+	rc = ksmbd_query_inode_status(path.dentry->d_parent);
 	if (rc == KSMBD_INODE_STATUS_PENDING_DELETE) {
 		rc = -EBUSY;
 		goto err_out;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 08f3f66e4b38..42f270ee399c 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -720,7 +720,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		goto out3;
 	}
 
-	parent_fp = ksmbd_lookup_fd_inode(d_inode(old_child->d_parent));
+	parent_fp = ksmbd_lookup_fd_inode(old_child->d_parent);
 	if (parent_fp) {
 		if (parent_fp->daccess & FILE_DELETE_LE) {
 			pr_err("parent dir is opened with delete access\n");
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 38f414e803ad..774a387fccce 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -65,14 +65,14 @@ static unsigned long inode_hash(struct super_block *sb, unsigned long hashval)
 	return tmp & inode_hash_mask;
 }
 
-static struct ksmbd_inode *__ksmbd_inode_lookup(struct inode *inode)
+static struct ksmbd_inode *__ksmbd_inode_lookup(struct dentry *de)
 {
 	struct hlist_head *head = inode_hashtable +
-		inode_hash(inode->i_sb, inode->i_ino);
+		inode_hash(d_inode(de)->i_sb, (unsigned long)de);
 	struct ksmbd_inode *ci = NULL, *ret_ci = NULL;
 
 	hlist_for_each_entry(ci, head, m_hash) {
-		if (ci->m_inode == inode) {
+		if (ci->m_de == de) {
 			if (atomic_inc_not_zero(&ci->m_count))
 				ret_ci = ci;
 			break;
@@ -83,26 +83,16 @@ static struct ksmbd_inode *__ksmbd_inode_lookup(struct inode *inode)
 
 static struct ksmbd_inode *ksmbd_inode_lookup(struct ksmbd_file *fp)
 {
-	return __ksmbd_inode_lookup(file_inode(fp->filp));
+	return __ksmbd_inode_lookup(fp->filp->f_path.dentry);
 }
 
-static struct ksmbd_inode *ksmbd_inode_lookup_by_vfsinode(struct inode *inode)
-{
-	struct ksmbd_inode *ci;
-
-	read_lock(&inode_hash_lock);
-	ci = __ksmbd_inode_lookup(inode);
-	read_unlock(&inode_hash_lock);
-	return ci;
-}
-
-int ksmbd_query_inode_status(struct inode *inode)
+int ksmbd_query_inode_status(struct dentry *dentry)
 {
 	struct ksmbd_inode *ci;
 	int ret = KSMBD_INODE_STATUS_UNKNOWN;
 
 	read_lock(&inode_hash_lock);
-	ci = __ksmbd_inode_lookup(inode);
+	ci = __ksmbd_inode_lookup(dentry);
 	if (ci) {
 		ret = KSMBD_INODE_STATUS_OK;
 		if (ci->m_flags & (S_DEL_PENDING | S_DEL_ON_CLS))
@@ -142,7 +132,7 @@ void ksmbd_fd_set_delete_on_close(struct ksmbd_file *fp,
 static void ksmbd_inode_hash(struct ksmbd_inode *ci)
 {
 	struct hlist_head *b = inode_hashtable +
-		inode_hash(ci->m_inode->i_sb, ci->m_inode->i_ino);
+		inode_hash(d_inode(ci->m_de)->i_sb, (unsigned long)ci->m_de);
 
 	hlist_add_head(&ci->m_hash, b);
 }
@@ -156,7 +146,6 @@ static void ksmbd_inode_unhash(struct ksmbd_inode *ci)
 
 static int ksmbd_inode_init(struct ksmbd_inode *ci, struct ksmbd_file *fp)
 {
-	ci->m_inode = file_inode(fp->filp);
 	atomic_set(&ci->m_count, 1);
 	atomic_set(&ci->op_count, 0);
 	atomic_set(&ci->sop_count, 0);
@@ -165,6 +154,7 @@ static int ksmbd_inode_init(struct ksmbd_inode *ci, struct ksmbd_file *fp)
 	INIT_LIST_HEAD(&ci->m_fp_list);
 	INIT_LIST_HEAD(&ci->m_op_list);
 	rwlock_init(&ci->m_lock);
+	ci->m_de = fp->filp->f_path.dentry;
 	return 0;
 }
 
@@ -487,12 +477,15 @@ struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid)
 	return fp;
 }
 
-struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode *inode)
+struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry)
 {
 	struct ksmbd_file	*lfp;
 	struct ksmbd_inode	*ci;
+	struct inode		*inode = d_inode(dentry);
 
-	ci = ksmbd_inode_lookup_by_vfsinode(inode);
+	read_lock(&inode_hash_lock);
+	ci = __ksmbd_inode_lookup(dentry);
+	read_unlock(&inode_hash_lock);
 	if (!ci)
 		return NULL;
 
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index 03d0bf941216..8325cf4527c4 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -51,7 +51,7 @@ struct ksmbd_inode {
 	atomic_t			op_count;
 	/* opinfo count for streams */
 	atomic_t			sop_count;
-	struct inode			*m_inode;
+	struct dentry			*m_de;
 	unsigned int			m_flags;
 	struct hlist_node		m_hash;
 	struct list_head		m_fp_list;
@@ -140,7 +140,7 @@ struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work, u64 id,
 void ksmbd_fd_put(struct ksmbd_work *work, struct ksmbd_file *fp);
 struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id);
 struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid);
-struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode *inode);
+struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry);
 unsigned int ksmbd_open_durable_fd(struct ksmbd_file *fp);
 struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp);
 void ksmbd_close_tree_conn_fds(struct ksmbd_work *work);
@@ -164,7 +164,7 @@ enum KSMBD_INODE_STATUS {
 	KSMBD_INODE_STATUS_PENDING_DELETE,
 };
 
-int ksmbd_query_inode_status(struct inode *inode);
+int ksmbd_query_inode_status(struct dentry *dentry);
 bool ksmbd_inode_pending_delete(struct ksmbd_file *fp);
 void ksmbd_set_inode_pending_delete(struct ksmbd_file *fp);
 void ksmbd_clear_inode_pending_delete(struct ksmbd_file *fp);
-- 
2.25.1


