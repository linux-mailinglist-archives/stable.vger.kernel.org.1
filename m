Return-Path: <stable+bounces-9104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555C9820A3B
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E311F220E5
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581F917C2;
	Sun, 31 Dec 2023 07:17:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E202217F4
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9b51093a0so4148216b3a.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007065; x=1704611865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIz68XQODNMrNKyZy589zBY5mGMROiuo7X7TyI8yWqs=;
        b=NmASOAAm357WJQZ0JHhbq4OpbtK/9jDdromoqKMygH6mXF/bQ/xN8q1lY0f14mS19v
         pyeySXFTdA/ET1P2WrX2nrcdDAiKXVSmj7RQvWcdqQ4XBnxvj1C1rcS5gGmEXvmlB78S
         /ETp4+n/uGRNMiv57UzRd26ieYYnJnmhr3zQ0YfDcOcjI8EeEubBa/akGJg/aptInnNq
         +PBvG5HKd5RuKwOQBUtXzbEfDdt2rijYuCkBKMXFJSG7WaQ2rLJ83MwyoAP8MZXqusJe
         qReeE18lytyycnO2ZgFdvuBrsO1E1RCtr97l0R+uumbu6De8qjEKothi7QOj3+qjg+TS
         /JZA==
X-Gm-Message-State: AOJu0YyMw1o1NcP/N0MkIhfhWqv5Sd7+InEzvzzVdkWEueE/KAt+2B+a
	ywq0c1ny7p8HXa3xoXk8r+I=
X-Google-Smtp-Source: AGHT+IEKIWl0qfy5N2kh8QNGoodZUeCrBsqSA7l0TpxZe6VJF9WUl0WNzPiIJSlamrF8kura84/Dag==
X-Received: by 2002:a05:6a21:78a4:b0:196:ae29:7c22 with SMTP id bf36-20020a056a2178a400b00196ae297c22mr2283135pzc.54.1704007065357;
        Sat, 30 Dec 2023 23:17:45 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:17:44 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 70/73] ksmbd: send v2 lease break notification for directory
Date: Sun, 31 Dec 2023 16:13:29 +0900
Message-Id: <20231231071332.31724-71-linkinjeon@kernel.org>
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

[ Upstream commit d47d9886aeef79feba7adac701a510d65f3682b5 ]

If client send different parent key, different client guid, or there is
no parent lease key flags in create context v2 lease, ksmbd send lease
break to client.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/common/smb2pdu.h   |  1 +
 fs/smb/server/oplock.c    | 56 +++++++++++++++++++++++++++++++++++----
 fs/smb/server/oplock.h    |  4 +++
 fs/smb/server/smb2pdu.c   |  7 +++++
 fs/smb/server/vfs_cache.c | 13 ++++++++-
 fs/smb/server/vfs_cache.h |  2 ++
 6 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index c8a4014f9d39..07549957b309 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -1196,6 +1196,7 @@ struct create_posix {
 #define SMB2_LEASE_WRITE_CACHING_LE		cpu_to_le32(0x04)
 
 #define SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE	cpu_to_le32(0x02)
+#define SMB2_LEASE_FLAG_PARENT_LEASE_KEY_SET_LE	cpu_to_le32(0x04)
 
 #define SMB2_LEASE_KEY_SIZE			16
 
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index f8ac539b2164..4a8745b3e830 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -102,6 +102,7 @@ static int alloc_lease(struct oplock_info *opinfo, struct lease_ctx_info *lctx)
 	lease->new_state = 0;
 	lease->flags = lctx->flags;
 	lease->duration = lctx->duration;
+	lease->is_dir = lctx->is_dir;
 	memcpy(lease->parent_lease_key, lctx->parent_lease_key, SMB2_LEASE_KEY_SIZE);
 	lease->version = lctx->version;
 	lease->epoch = le16_to_cpu(lctx->epoch);
@@ -543,12 +544,13 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 			/* upgrading lease */
 			if ((atomic_read(&ci->op_count) +
 			     atomic_read(&ci->sop_count)) == 1) {
-				if (lease->state ==
-				    (lctx->req_state & lease->state)) {
+				if (lease->state != SMB2_LEASE_NONE_LE &&
+				    lease->state == (lctx->req_state & lease->state)) {
 					lease->state |= lctx->req_state;
 					if (lctx->req_state &
 						SMB2_LEASE_WRITE_CACHING_LE)
 						lease_read_to_write(opinfo);
+
 				}
 			} else if ((atomic_read(&ci->op_count) +
 				    atomic_read(&ci->sop_count)) > 1) {
@@ -900,7 +902,8 @@ static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level)
 					lease->new_state =
 						SMB2_LEASE_READ_CACHING_LE;
 			} else {
-				if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE)
+				if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE &&
+						!lease->is_dir)
 					lease->new_state =
 						SMB2_LEASE_READ_CACHING_LE;
 				else
@@ -1082,6 +1085,48 @@ static void set_oplock_level(struct oplock_info *opinfo, int level,
 	}
 }
 
+void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
+				      struct lease_ctx_info *lctx)
+{
+	struct oplock_info *opinfo;
+	struct ksmbd_inode *p_ci = NULL;
+
+	if (lctx->version != 2)
+		return;
+
+	p_ci = ksmbd_inode_lookup_lock(fp->filp->f_path.dentry->d_parent);
+	if (!p_ci)
+		return;
+
+	read_lock(&p_ci->m_lock);
+	list_for_each_entry(opinfo, &p_ci->m_op_list, op_entry) {
+		if (!opinfo->is_lease)
+			continue;
+
+		if (opinfo->o_lease->state != SMB2_OPLOCK_LEVEL_NONE &&
+		    (!(lctx->flags & SMB2_LEASE_FLAG_PARENT_LEASE_KEY_SET_LE) ||
+		     !compare_guid_key(opinfo, fp->conn->ClientGUID,
+				      lctx->parent_lease_key))) {
+			if (!atomic_inc_not_zero(&opinfo->refcount))
+				continue;
+
+			atomic_inc(&opinfo->conn->r_count);
+			if (ksmbd_conn_releasing(opinfo->conn)) {
+				atomic_dec(&opinfo->conn->r_count);
+				continue;
+			}
+
+			read_unlock(&p_ci->m_lock);
+			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE);
+			opinfo_conn_put(opinfo);
+			read_lock(&p_ci->m_lock);
+		}
+	}
+	read_unlock(&p_ci->m_lock);
+
+	ksmbd_inode_put(p_ci);
+}
+
 /**
  * smb_grant_oplock() - handle oplock/lease request on file open
  * @work:		smb work
@@ -1420,10 +1465,11 @@ struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir)
 		struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
 
 		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
-		if (is_dir)
+		if (is_dir) {
 			lreq->req_state = lc->lcontext.LeaseState &
 				~SMB2_LEASE_WRITE_CACHING_LE;
-		else
+			lreq->is_dir = true;
+		} else
 			lreq->req_state = lc->lcontext.LeaseState;
 		lreq->flags = lc->lcontext.LeaseFlags;
 		lreq->epoch = lc->lcontext.Epoch;
diff --git a/fs/smb/server/oplock.h b/fs/smb/server/oplock.h
index 672127318c75..b64d1536882a 100644
--- a/fs/smb/server/oplock.h
+++ b/fs/smb/server/oplock.h
@@ -36,6 +36,7 @@ struct lease_ctx_info {
 	__u8			parent_lease_key[SMB2_LEASE_KEY_SIZE];
 	__le16			epoch;
 	int			version;
+	bool			is_dir;
 };
 
 struct lease_table {
@@ -54,6 +55,7 @@ struct lease {
 	__u8			parent_lease_key[SMB2_LEASE_KEY_SIZE];
 	int			version;
 	unsigned short		epoch;
+	bool			is_dir;
 	struct lease_table	*l_lb;
 };
 
@@ -125,4 +127,6 @@ struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
 int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
 			struct lease_ctx_info *lctx);
 void destroy_lease_table(struct ksmbd_conn *conn);
+void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
+				      struct lease_ctx_info *lctx);
 #endif /* __KSMBD_OPLOCK_H */
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 9222c68b0214..589441ea5491 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3225,6 +3225,13 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	} else {
 		if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE) {
+			/*
+			 * Compare parent lease using parent key. If there is no
+			 * a lease that has same parent key, Send lease break
+			 * notification.
+			 */
+			smb_send_parent_lease_break_noti(fp, lc);
+
 			req_op_level = smb2_map_lease_to_oplock(lc->req_state);
 			ksmbd_debug(SMB,
 				    "lease req for(%s) req oplock state 0x%x, lease state 0x%x\n",
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 774a387fccce..2528ce8aeebb 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -86,6 +86,17 @@ static struct ksmbd_inode *ksmbd_inode_lookup(struct ksmbd_file *fp)
 	return __ksmbd_inode_lookup(fp->filp->f_path.dentry);
 }
 
+struct ksmbd_inode *ksmbd_inode_lookup_lock(struct dentry *d)
+{
+	struct ksmbd_inode *ci;
+
+	read_lock(&inode_hash_lock);
+	ci = __ksmbd_inode_lookup(d);
+	read_unlock(&inode_hash_lock);
+
+	return ci;
+}
+
 int ksmbd_query_inode_status(struct dentry *dentry)
 {
 	struct ksmbd_inode *ci;
@@ -198,7 +209,7 @@ static void ksmbd_inode_free(struct ksmbd_inode *ci)
 	kfree(ci);
 }
 
-static void ksmbd_inode_put(struct ksmbd_inode *ci)
+void ksmbd_inode_put(struct ksmbd_inode *ci)
 {
 	if (atomic_dec_and_test(&ci->m_count))
 		ksmbd_inode_free(ci);
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index 8325cf4527c4..4d4938d6029b 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -138,6 +138,8 @@ struct ksmbd_file *ksmbd_lookup_foreign_fd(struct ksmbd_work *work, u64 id);
 struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work, u64 id,
 					u64 pid);
 void ksmbd_fd_put(struct ksmbd_work *work, struct ksmbd_file *fp);
+struct ksmbd_inode *ksmbd_inode_lookup_lock(struct dentry *d);
+void ksmbd_inode_put(struct ksmbd_inode *ci);
 struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id);
 struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid);
 struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry);
-- 
2.25.1


