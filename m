Return-Path: <stable+bounces-247326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePoTH+ahBmoMlgIAu9opvQ
	(envelope-from <stable+bounces-247326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:32:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F2C54940F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E32F630107FD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D263D5651;
	Fri, 15 May 2026 04:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="dFHQa0JC"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F583CB918;
	Fri, 15 May 2026 04:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778819550; cv=none; b=sIe8bIbbrT8PhI6KSV0GQok6w/ZbHQKllYQ7WnvnjavZNHToZtJ8+KEv4yX/iCOCyDoAJ/c7hhpwkIG/v/o+Dy9dbHav5oHN5g4o8bv1lpL3i6P5PvmK8N84XlYWSTF6RMsHppz3XzNOdB1/5lV/CzxGrcBozFlufVFI/CxbUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778819550; c=relaxed/simple;
	bh=TYSeRGYQbwHjHYALMSLDJsZJO/7cPbMhBmvBCixaZIY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=OEHYhE016Ljf3+1yWpUklHsLqjmkzm55rtwyV0TD3cuaUloeROo8ALELpstXztHK17jRLzco78duMBo801lqNCU4VrvLDRPWIr529lc/qJx9vnrWSj2hdTq9PCCGXRySuIH6+HuYaixwV/VqHvvkKuv2Uk3z2wO9FjYj5jzOMaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=dFHQa0JC; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778819545;
	bh=YLl7q1MmYPzGhWnNmRQA7+w/Oq/fXDObxmGFJVxbJ/E=;
	h=From:To:Cc:Subject:Date;
	b=dFHQa0JCnJik5vFFiKJiiECx1QLsMiTKuAfjAcAx38sgXiry3M4LeMPAcoKS5Hb6J
	 VPd+MKeCrVm/TGJYIbW9RqGYOLIQ5kQzx3kXfcgPbKr2Jtx0oc4TdKHRfD3PRsx7H9
	 6Ici4tRpOxFgaZzJcDxoMQGrDKIdpvo/O+SbNtAE=
Received: from China-team ([183.241.54.211])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 7EA09032; Fri, 15 May 2026 12:31:42 +0800
X-QQ-mid: xmsmtpt1778819502tpu0ief7s
Message-ID: <tencent_B3339C2998B206175A889A950F15C91AEB07@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAU1Gny1w7wbCvqHKx80R4MHaUEKQyN60xexAtVPINlb/uKfu0J3
	 RSIW1w1MUcsVRtAvimicxykfkg91+8SAkfwbZcEHgKVcR0CHFm3ciNhr0usYeaEllR5ejGgGfXHX
	 TL5Zxdn7lP/X33Hsq/aAWUaI4xshOUe8NiOW8dkbXt/4doSo+1kKrS4BT2+y+BSqNnTlUV/Av+KY
	 XAH/vnqx5m2nlyCdthIAPL4xp/YN3FRvqngpTQ/POYIqp9MXhtefAq2oHCo2pPZg0Fz6nHAjTg9B
	 eoNNWcoXYoxoB1dAo0JPv35NqhDZT2ow9I53s5uYlFM9dmkV3DIDCySPkN+A4EYGBPemgSgq+XPI
	 0KJrr0FUUBy4MNYDQ4rFmZ8Yv6E8au7kEyy3+0K/wbFIGI3GDPCYtQD1EKC1C04Et17J8h8Jbybq
	 1O1kKoTdtq3fe5Ji8eJ71mG5U7+E7htJzzo9LqXUtnIef3CumME0Wr2FW6NVBjjcxnqHGLDDgNzK
	 7jTDlSV7hCDYvEwQ50zvr1UKPYf8DCG03cavH8/eZRspFpN+r7AuxFOW7mkdITMM7wCTDfAYQzMb
	 iLGqxOE1xT/N1yPRpcxIPNTz4m0+yvONiTCkpIUb/3YoSjittLO2dwZl62Eg3XLzMrHU+PtKAcTb
	 Eoai1M7kz6AboOXMY3uFtVhFhZ5p+sUnSO71V/7r2uUkLNd2JDM8d/o/sk/g8bObB2vtIZtJcTde
	 0to+bOBEcPIXwRt5xUBDDaSgdiTbtm8hkL+soHBGd1k9qhEYNq1aUVLKQJA5sUuxg3biGpPMaHRk
	 mJOqOh1nEYou1v7LyabMzmm/zxrHmJk86ZKBaO2aUoMEJltFOXfvwpw9/RJGkeyDMP9maTdYCVMu
	 4iKwTpY4D7FSyKkIyI3fDnpi7rh/1RtzZNfVEkU2lH5h+eaxSsoNx6+uUuPwbTjCGiY2EI5yu65n
	 Ssr7I0N2UFTSBg57gZzR/hGX6DG8P+TIHF+uaX1NfgjP3QdEAU4cOjnHZK75FcD7VKugQ4MD77bG
	 7iz1ZeTjBIcDEsQSitaRsdZOd53zK9FsxaPvaXJQekjA8YlC5hgxIbkaacvv30/YL2IUrwxw==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	munan Huang <munanevil@gmail.com>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y] ksmbd: fix use-after-free in __ksmbd_close_fd() via durable scavenger
Date: Fri, 15 May 2026 12:31:24 +0800
X-OQ-MSGID: <20260515043124.728-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F2F2C54940F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-247326-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,kylinos.cn,microsoft.com,foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,qq.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
[ Minor context conflict resolved. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
Backport notes:
- Minor context conflict in vfs_cache.c in 6.6.y.
  This only affects surrounding context lines, not the fix logic itself.
- Tested with KASAN-enabled kernel: fixed kernel shows no crash when
  durable handle with byte-range lock is expired by scavenger after
  abrupt TCP disconnect.

---
 fs/smb/server/vfs_cache.c | 40 +++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 2fcb7ca33a63..eacc6ef41db0 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -356,9 +356,11 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
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
@@ -755,6 +757,7 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 	struct ksmbd_inode *ci;
 	struct oplock_info *op;
 	struct ksmbd_conn *conn;
+	struct ksmbd_lock *smb_lock, *tmp_lock;
 
 	if (!is_reconnectable(fp))
 		return false;
@@ -771,6 +774,12 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
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
@@ -844,6 +853,9 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 {
 	struct ksmbd_inode *ci;
 	struct oplock_info *op;
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_lock *smb_lock;
+	unsigned int old_f_state;
 
 	if (!fp->is_durable || fp->conn || fp->tcon) {
 		pr_err("Invalid durable fd [%p:%p]\n", fp->conn, fp->tcon);
@@ -855,9 +867,23 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
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
@@ -868,12 +894,6 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 	}
 	up_write(&ci->m_lock);
 
-	__open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
-	if (!has_file_id(fp->volatile_id)) {
-		fp->conn = NULL;
-		fp->tcon = NULL;
-		return -EBADF;
-	}
 	return 0;
 }
 
-- 
2.43.0


