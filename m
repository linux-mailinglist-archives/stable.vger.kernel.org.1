Return-Path: <stable+bounces-239935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCh5KUJY5mlQvAEAu9opvQ
	(envelope-from <stable+bounces-239935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:45:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A0042FF6E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E82543156ABE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DFA346770;
	Mon, 20 Apr 2026 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTpf0cs1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2B345CD8
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701734; cv=none; b=QAAGz56CM/pjZ5r1uZV/f3AtleLA5PNsNbMuMEUwWB2a1h0++kU5JSTOvqRvTG6phNJcBiW6PyEBMgzh8ZKX4CQgHBWMokTu3Qjplqh15fWBNHBlfjr1e2clhYSjIhV9Bp99DaWYdQEHJU+mqcnqXpoqjdrsTM7crF2+u4HDPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701734; c=relaxed/simple;
	bh=kKtWE16eePH+VE8vPLpg6VC3ttrvgn9Wf/CKA6nxao0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPT1nKbu3FXSurC6tK9owmjA2KDYDVR0B9Dm9q5CTiHCArsbkgBl6tThq25E6Vjw1bvAms4NJbkBr6W+zpQdPk+v0YFj8zw+JvjMRj17UASjMecU/6yaBey2mQypMrltdPYmD+RRrdG6i9Cv8TDHXE2k345RfUv2wb7WyG9BjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTpf0cs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17495C19425;
	Mon, 20 Apr 2026 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776701733;
	bh=kKtWE16eePH+VE8vPLpg6VC3ttrvgn9Wf/CKA6nxao0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTpf0cs1/Pjmig9R9dvQEQqS7wPehLeeY+uVbSgVhD6xW2k4ArgMWpNjjBDS5uqbu
	 U5byDywxOH03DG4dkuMa17ZQEGn+Ik/ZbpXMniQcn2gR04a5N8yxof17JHFYVX5YXO
	 2kU5ZVnhTkK1P33RyC9xFAiyfEzVQNeSwbya0kmyZe5fQCiB+MdDvxR9TtEgSrZ2K8
	 UsUGIJCH9/OXucHHDEPTNK1ltaJvqEqegjJUYZIILdGd6EdFutxNnwRYl4j3U/HO9G
	 Terom5yMIojXclWIxsbFY2KOkcljAWqWd4f3j51Hst1IMNK9j4+dj2R7F206Gqbvlm
	 474vb5S+awWVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	munan Huang <munanevil@gmail.com>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/2] ksmbd: fix use-after-free in __ksmbd_close_fd() via durable scavenger
Date: Mon, 20 Apr 2026 12:15:30 -0400
Message-ID: <20260420161531.1241004-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042008-renovate-washout-9325@gregkh>
References: <2026042008-renovate-washout-9325@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,kylinos.cn,microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239935-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55A0042FF6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 235e32320a470fcd3998fb3774f2290a0eb302a1 ]

When a durable file handle survives session disconnect (TCP close without
SMB2_LOGOFF), session_fd_check() sets fp->conn = NULL to preserve the
handle for later reconnection. However, it did not clean up the byte-range
locks on fp->lock_list.

Later, when the durable scavenger thread times out and calls
__ksmbd_close_fd(NULL, fp), the lock cleanup loop did:

    spin_lock(&fp->conn->llist_lock);

This caused a slab use-after-free because fp->conn was NULL and the
original connection object had already been freed by
ksmbd_tcp_disconnect().

The root cause is asymmetric cleanup: lock entries (smb_lock->clist) were
left dangling on the freed conn->lock_list while fp->conn was nulled out.

To fix this issue properly, we need to handle the lifetime of
smb_lock->clist across three paths:
 - Safely skip clist deletion when list is empty and fp->conn is NULL.
 - Remove the lock from the old connection's lock_list in
   session_fd_check()
 - Re-add the lock to the new connection's lock_list in
   ksmbd_reopen_durable_fd().

Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
Co-developed-by: munan Huang <munanevil@gmail.com>
Signed-off-by: munan Huang <munanevil@gmail.com>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 49110a8ce654 ("ksmbd: validate owner of durable handle on reconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/vfs_cache.c | 41 ++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 168f2dd7e200b..87f63525062b1 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -463,9 +463,11 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 	 * there are not accesses to fp->lock_list.
 	 */
 	list_for_each_entry_safe(smb_lock, tmp_lock, &fp->lock_list, flist) {
-		spin_lock(&fp->conn->llist_lock);
-		list_del(&smb_lock->clist);
-		spin_unlock(&fp->conn->llist_lock);
+		if (!list_empty(&smb_lock->clist) && fp->conn) {
+			spin_lock(&fp->conn->llist_lock);
+			list_del(&smb_lock->clist);
+			spin_unlock(&fp->conn->llist_lock);
+		}
 
 		list_del(&smb_lock->flist);
 		locks_free_lock(smb_lock->fl);
@@ -995,6 +997,7 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 	struct ksmbd_inode *ci;
 	struct oplock_info *op;
 	struct ksmbd_conn *conn;
+	struct ksmbd_lock *smb_lock, *tmp_lock;
 
 	if (!is_reconnectable(fp))
 		return false;
@@ -1011,6 +1014,12 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 	}
 	up_write(&ci->m_lock);
 
+	list_for_each_entry_safe(smb_lock, tmp_lock, &fp->lock_list, flist) {
+		spin_lock(&fp->conn->llist_lock);
+		list_del_init(&smb_lock->clist);
+		spin_unlock(&fp->conn->llist_lock);
+	}
+
 	fp->conn = NULL;
 	fp->tcon = NULL;
 	fp->volatile_id = KSMBD_NO_FID;
@@ -1090,6 +1099,9 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 {
 	struct ksmbd_inode *ci;
 	struct oplock_info *op;
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_lock *smb_lock;
+	unsigned int old_f_state;
 
 	if (!fp->is_durable || fp->conn || fp->tcon) {
 		pr_err("Invalid durable fd [%p:%p]\n", fp->conn, fp->tcon);
@@ -1101,9 +1113,23 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 		return -EBADF;
 	}
 
-	fp->conn = work->conn;
+	old_f_state = fp->f_state;
+	fp->f_state = FP_NEW;
+	__open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
+	if (!has_file_id(fp->volatile_id)) {
+		fp->f_state = old_f_state;
+		return -EBADF;
+	}
+
+	fp->conn = conn;
 	fp->tcon = work->tcon;
 
+	list_for_each_entry(smb_lock, &fp->lock_list, flist) {
+		spin_lock(&conn->llist_lock);
+		list_add_tail(&smb_lock->clist, &conn->lock_list);
+		spin_unlock(&conn->llist_lock);
+	}
+
 	ci = fp->f_ci;
 	down_write(&ci->m_lock);
 	list_for_each_entry_rcu(op, &ci->m_op_list, op_entry) {
@@ -1114,13 +1140,6 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 	}
 	up_write(&ci->m_lock);
 
-	fp->f_state = FP_NEW;
-	__open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
-	if (!has_file_id(fp->volatile_id)) {
-		fp->conn = NULL;
-		fp->tcon = NULL;
-		return -EBADF;
-	}
 	return 0;
 }
 
-- 
2.53.0


