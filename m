Return-Path: <stable+bounces-131111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE79A80925
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8284426B6A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF044267B96;
	Tue,  8 Apr 2025 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oRG+X1w+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3520330;
	Tue,  8 Apr 2025 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115517; cv=none; b=AOHdyDMKM8kdmnouqO7EZ2cJl5UkFmZ+cNB8NSqEjns/d8/j/MbwrdB2xJB+APgUhoaxQd54FZWZOjlTiP38MpBUtF+NKtSjyEcfE/lMZMK6HuxfzAzUXEBF0VnoX2ObmjycgfzlWfxyTNrBcKV6CjPk6P6aWUaT8rbYh3hXowc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115517; c=relaxed/simple;
	bh=2s4S4bQUDtoe1eV5cnjdAXjVk9wwHGacTNoksgy5Hto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnFamu3SJ4z57sBi3AHhtgJvxNzfBC7A2Wjze9xtaNxiUjVTUp9BOWsnytOMpYQw/xNYKuAcrVMpiAkSZkCKEtp/dnzd+X3gmi3ZxBx1fjKNolrsErfBe+HUJgevOfw4NuiKerJYhEiy6Q94zgAvmm2eM4QKE7ysGdqJtJ7oBTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oRG+X1w+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD040C4CEE5;
	Tue,  8 Apr 2025 12:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115517;
	bh=2s4S4bQUDtoe1eV5cnjdAXjVk9wwHGacTNoksgy5Hto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRG+X1w+bAxXsfND5b69vOiP3RbsSPy/QihQ96RldE7Nqs71UHbom+YN6bfTx5Naw
	 rIAC9f+o5JQU7gS1ySkHbGygBkLinbVhuoFx0zBmjZM7LKktfAKVN/rMiF5g3eEv0S
	 JOIOYvebdXkwXtIr4xzh9W+N8grdi2MsmZHCoCPY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Heelan <seanheelan@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.13 469/499] ksmbd: fix session use-after-free in multichannel connection
Date: Tue,  8 Apr 2025 12:51:21 +0200
Message-ID: <20250408104902.939558946@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit fa4cdb8cbca7d6cb6aa13e4d8d83d1103f6345db upstream.

There is a race condition between session setup and
ksmbd_sessions_deregister. The session can be freed before the connection
is added to channel list of session.
This patch check reference count of session before freeing it.

Cc: stable@vger.kernel.org
Reported-by: Sean Heelan <seanheelan@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/auth.c              |    4 ++--
 fs/smb/server/mgmt/user_session.c |   14 ++++++++------
 fs/smb/server/smb2pdu.c           |    7 ++++---
 3 files changed, 14 insertions(+), 11 deletions(-)

--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -1016,9 +1016,9 @@ static int ksmbd_get_encryption_key(stru
 
 	ses_enc_key = enc ? sess->smb3encryptionkey :
 		sess->smb3decryptionkey;
-	if (enc)
-		ksmbd_user_session_get(sess);
 	memcpy(key, ses_enc_key, SMB3_ENC_DEC_KEY_SIZE);
+	if (!enc)
+		ksmbd_user_session_put(sess);
 
 	return 0;
 }
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -181,7 +181,7 @@ static void ksmbd_expire_session(struct
 	down_write(&sessions_table_lock);
 	down_write(&conn->session_lock);
 	xa_for_each(&conn->sessions, id, sess) {
-		if (atomic_read(&sess->refcnt) == 0 &&
+		if (atomic_read(&sess->refcnt) <= 1 &&
 		    (sess->state != SMB2_SESSION_VALID ||
 		     time_after(jiffies,
 			       sess->last_active + SMB2_SESSION_TIMEOUT))) {
@@ -233,7 +233,8 @@ void ksmbd_sessions_deregister(struct ks
 				down_write(&conn->session_lock);
 				xa_erase(&conn->sessions, sess->id);
 				up_write(&conn->session_lock);
-				ksmbd_session_destroy(sess);
+				if (atomic_dec_and_test(&sess->refcnt))
+					ksmbd_session_destroy(sess);
 			}
 		}
 	}
@@ -252,7 +253,8 @@ void ksmbd_sessions_deregister(struct ks
 		if (xa_empty(&sess->ksmbd_chann_list)) {
 			xa_erase(&conn->sessions, sess->id);
 			hash_del(&sess->hlist);
-			ksmbd_session_destroy(sess);
+			if (atomic_dec_and_test(&sess->refcnt))
+				ksmbd_session_destroy(sess);
 		}
 	}
 	up_write(&conn->session_lock);
@@ -328,8 +330,8 @@ void ksmbd_user_session_put(struct ksmbd
 
 	if (atomic_read(&sess->refcnt) <= 0)
 		WARN_ON(1);
-	else
-		atomic_dec(&sess->refcnt);
+	else if (atomic_dec_and_test(&sess->refcnt))
+		ksmbd_session_destroy(sess);
 }
 
 struct preauth_session *ksmbd_preauth_session_alloc(struct ksmbd_conn *conn,
@@ -436,7 +438,7 @@ static struct ksmbd_session *__session_c
 	xa_init(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
 	rwlock_init(&sess->tree_conns_lock);
-	atomic_set(&sess->refcnt, 1);
+	atomic_set(&sess->refcnt, 2);
 
 	ret = __init_smb2_session(sess);
 	if (ret)
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2234,13 +2234,14 @@ int smb2_session_logoff(struct ksmbd_wor
 		return -ENOENT;
 	}
 
-	ksmbd_destroy_file_table(&sess->file_table);
 	down_write(&conn->session_lock);
 	sess->state = SMB2_SESSION_EXPIRED;
 	up_write(&conn->session_lock);
 
-	ksmbd_free_user(sess->user);
-	sess->user = NULL;
+	if (sess->user) {
+		ksmbd_free_user(sess->user);
+		sess->user = NULL;
+	}
 	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_NEGOTIATE);
 
 	rsp->StructureSize = cpu_to_le16(4);



