Return-Path: <stable+bounces-239980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDucIep05mnKwgEAu9opvQ
	(envelope-from <stable+bounces-239980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:48:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0648A43311C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 384E1308F04A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8382F3B0ACE;
	Mon, 20 Apr 2026 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2OjUTYK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E739B97E
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710148; cv=none; b=iQnUX77RBOnx7pKUVXQh/9ImSIX+kxh/jyYUvOHTFwEMj9YG1KRJ10qYri/e43k6pVBwzji9tsTP7AAtR3UPJW4FxAyYeaKqZA80U0j8Bq1v5L3h3giW9jPypL47WEEHc+00gbciykRIbm/CtCt6riEO6UEI51XPsrmsN0SuEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710148; c=relaxed/simple;
	bh=3PEdLGdwIWwuG3u+pFJa7Q0KQDlZuh2gB0tsxTTHqzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZHU2m7zF8OnTTocazpbWFT2i4V/4WOjvdHv9JqktDkqxXMMedRrswEONmXj+riRVXVE/atXmw4JOYYb6YFrsh3zsDFSCjygJrVgdcQAZqgCL/utEzpWHS/UGZv1WFv409ldXKG///nlCtJ7vt6/cMLxexmtMdWBs+LnEdarUoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2OjUTYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CB1C19425;
	Mon, 20 Apr 2026 18:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776710148;
	bh=3PEdLGdwIWwuG3u+pFJa7Q0KQDlZuh2gB0tsxTTHqzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2OjUTYKZAFNg6HOzxtvj21r+rV+OqDf2GaBAhbjOFRZ0Cqj3tvtUo26LcNIMvgyX
	 F5TcDImBnMEiTIQgcelHBIXoSWcgksvQz1DOnOuBLBwrsTPJ/RpE7Mqp6hviT+QDvz
	 l+ZWcCZ9ONRTBoUGj/lwSx2GwuTxFqqG7Ouoal7lt6XoNNEKf4qT1hiqVUm8Q5Qt7P
	 phHRupIC1C3DgzDSj5tWA9nphr5tDrDmfk48joW+ofw7SgeCyzKRTEwhb3z0zOz/ml
	 xSej+TEUBVoTfG8pjYWLH/6UwxkgguAstC/TvJvCD1lOlMT2HIWlL0weeKwM2G9s8D
	 fmUWhB2I4HqMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	munan Huang <munanevil@gmail.com>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: fix use-after-free in __ksmbd_close_fd() via durable scavenger
Date: Mon, 20 Apr 2026 14:35:45 -0400
Message-ID: <20260420183545.1526803-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042010-daisy-antonym-6130@gregkh>
References: <2026042010-daisy-antonym-6130@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,kylinos.cn,microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239980-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: 0648A43311C
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/vfs_cache.c | 41 ++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 6ef116585af64..08f25a2d75416 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -370,9 +370,11 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
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
@@ -902,6 +904,7 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 	struct ksmbd_inode *ci;
 	struct oplock_info *op;
 	struct ksmbd_conn *conn;
+	struct ksmbd_lock *smb_lock, *tmp_lock;
 
 	if (!is_reconnectable(fp))
 		return false;
@@ -918,6 +921,12 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
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
@@ -996,6 +1005,9 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 {
 	struct ksmbd_inode *ci;
 	struct oplock_info *op;
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_lock *smb_lock;
+	unsigned int old_f_state;
 
 	if (!fp->is_durable || fp->conn || fp->tcon) {
 		pr_err("Invalid durable fd [%p:%p]\n", fp->conn, fp->tcon);
@@ -1007,9 +1019,23 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
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
@@ -1020,13 +1046,6 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
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


