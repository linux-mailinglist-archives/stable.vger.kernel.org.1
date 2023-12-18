Return-Path: <stable+bounces-7724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 679518175F4
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F3E280C17
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2357147D;
	Mon, 18 Dec 2023 15:40:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2088E49883
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b436f6cb9so2346213a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914029; x=1703518829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1SfKyCK5+sHX3Wr7uZgrIDoFHfOUO1B8iPfaLe8ivE=;
        b=Be12kyODHhP+6kZ19uU/E9XbPAHQcw0EYV8fb1++1EQi+nThLfN+mm3BlFXRJSL/RV
         eFZ3c0qqECN6d0GCgCCbrARkFtwdr3tuiW9ZH7v9Pc8Gy7YyM+rWjR+GJ15SlWG62zUh
         62G+q4DGLtjqmf10bmY/8TT+ezNdxo+QZJVUb7phtBk8EtBPGfDtbjA52ac9nIxMB7BB
         fNtnNhQYJha/AdrqSitFVApv5jwMhjXUodoTHG5nMMF/ALlZn/Wb8ziQoY3ub7mdUcvu
         HWMAAuvAotLy6sbcWgkojXbi9Bn3akd8w3GynkF0NgHOxV5+X0TGW7wGFLE4evcQeKRo
         WreA==
X-Gm-Message-State: AOJu0YxpJJXJC6zKG2DlqoiMRsyLVJQFq9Xm5llVu3/ifX4e1hBdVdK4
	MPHnaSWqCggX17bykpy9vTo=
X-Google-Smtp-Source: AGHT+IF+4C0fYFXebUI1Ez5UeE2rL2Cq8yCLDMt/UZUK5oadRq+TQ96fxMSqDbQRRoOyQQR5g6H6hg==
X-Received: by 2002:a17:90a:e554:b0:28b:4669:3cd1 with SMTP id ei20-20020a17090ae55400b0028b46693cd1mr1667470pjb.96.1702914029327;
        Mon, 18 Dec 2023 07:40:29 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:28 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Per Forlin <per.forlin@axis.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 096/154] ksmbd: fix UAF issue from opinfo->conn
Date: Tue, 19 Dec 2023 00:33:56 +0900
Message-Id: <20231218153454.8090-97-linkinjeon@kernel.org>
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

[ Upstream commit 36322523dddb11107e9f7f528675a0dec2536103 ]

If opinfo->conn is another connection and while ksmbd send oplock break
request to cient on current connection, The connection for opinfo->conn
can be disconnect and conn could be freed. When sending oplock break
request, this ksmbd_conn can be used and cause user-after-free issue.
When getting opinfo from the list, ksmbd check connection is being
released. If it is not released, Increase ->r_count to wait that connection
is freed.

Cc: stable@vger.kernel.org
Reported-by: Per Forlin <per.forlin@axis.com>
Tested-by: Per Forlin <per.forlin@axis.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/oplock.c | 72 +++++++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 25 deletions(-)

diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 919c598a9d66..28c7f2193fb3 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -157,13 +157,42 @@ static struct oplock_info *opinfo_get_list(struct ksmbd_inode *ci)
 	rcu_read_lock();
 	opinfo = list_first_or_null_rcu(&ci->m_op_list, struct oplock_info,
 					op_entry);
-	if (opinfo && !atomic_inc_not_zero(&opinfo->refcount))
-		opinfo = NULL;
+	if (opinfo) {
+		if (!atomic_inc_not_zero(&opinfo->refcount))
+			opinfo = NULL;
+		else {
+			atomic_inc(&opinfo->conn->r_count);
+			if (ksmbd_conn_releasing(opinfo->conn)) {
+				atomic_dec(&opinfo->conn->r_count);
+				atomic_dec(&opinfo->refcount);
+				opinfo = NULL;
+			}
+		}
+	}
+
 	rcu_read_unlock();
 
 	return opinfo;
 }
 
+static void opinfo_conn_put(struct oplock_info *opinfo)
+{
+	struct ksmbd_conn *conn;
+
+	if (!opinfo)
+		return;
+
+	conn = opinfo->conn;
+	/*
+	 * Checking waitqueue to dropping pending requests on
+	 * disconnection. waitqueue_active is safe because it
+	 * uses atomic operation for condition.
+	 */
+	if (!atomic_dec_return(&conn->r_count) && waitqueue_active(&conn->r_count_q))
+		wake_up(&conn->r_count_q);
+	opinfo_put(opinfo);
+}
+
 void opinfo_put(struct oplock_info *opinfo)
 {
 	if (!atomic_dec_and_test(&opinfo->refcount))
@@ -666,13 +695,6 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 
 out:
 	ksmbd_free_work_struct(work);
-	/*
-	 * Checking waitqueue to dropping pending requests on
-	 * disconnection. waitqueue_active is safe because it
-	 * uses atomic operation for condition.
-	 */
-	if (!atomic_dec_return(&conn->r_count) && waitqueue_active(&conn->r_count_q))
-		wake_up(&conn->r_count_q);
 }
 
 /**
@@ -706,7 +728,6 @@ static int smb2_oplock_break_noti(struct oplock_info *opinfo)
 	work->conn = conn;
 	work->sess = opinfo->sess;
 
-	atomic_inc(&conn->r_count);
 	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
 		INIT_WORK(&work->work, __smb2_oplock_break_noti);
 		ksmbd_queue_work(work);
@@ -776,13 +797,6 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 
 out:
 	ksmbd_free_work_struct(work);
-	/*
-	 * Checking waitqueue to dropping pending requests on
-	 * disconnection. waitqueue_active is safe because it
-	 * uses atomic operation for condition.
-	 */
-	if (!atomic_dec_return(&conn->r_count) && waitqueue_active(&conn->r_count_q))
-		wake_up(&conn->r_count_q);
 }
 
 /**
@@ -822,7 +836,6 @@ static int smb2_lease_break_noti(struct oplock_info *opinfo)
 	work->conn = conn;
 	work->sess = opinfo->sess;
 
-	atomic_inc(&conn->r_count);
 	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
 		list_for_each_safe(tmp, t, &opinfo->interim_list) {
 			struct ksmbd_work *in_work;
@@ -1144,8 +1157,10 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	}
 	prev_opinfo = opinfo_get_list(ci);
 	if (!prev_opinfo ||
-	    (prev_opinfo->level == SMB2_OPLOCK_LEVEL_NONE && lctx))
+	    (prev_opinfo->level == SMB2_OPLOCK_LEVEL_NONE && lctx)) {
+		opinfo_conn_put(prev_opinfo);
 		goto set_lev;
+	}
 	prev_op_has_lease = prev_opinfo->is_lease;
 	if (prev_op_has_lease)
 		prev_op_state = prev_opinfo->o_lease->state;
@@ -1153,19 +1168,19 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	if (share_ret < 0 &&
 	    prev_opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
 		err = share_ret;
-		opinfo_put(prev_opinfo);
+		opinfo_conn_put(prev_opinfo);
 		goto err_out;
 	}
 
 	if (prev_opinfo->level != SMB2_OPLOCK_LEVEL_BATCH &&
 	    prev_opinfo->level != SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
-		opinfo_put(prev_opinfo);
+		opinfo_conn_put(prev_opinfo);
 		goto op_break_not_needed;
 	}
 
 	list_add(&work->interim_entry, &prev_opinfo->interim_list);
 	err = oplock_break(prev_opinfo, SMB2_OPLOCK_LEVEL_II);
-	opinfo_put(prev_opinfo);
+	opinfo_conn_put(prev_opinfo);
 	if (err == -ENOENT)
 		goto set_lev;
 	/* Check all oplock was freed by close */
@@ -1228,14 +1243,14 @@ static void smb_break_all_write_oplock(struct ksmbd_work *work,
 		return;
 	if (brk_opinfo->level != SMB2_OPLOCK_LEVEL_BATCH &&
 	    brk_opinfo->level != SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
-		opinfo_put(brk_opinfo);
+		opinfo_conn_put(brk_opinfo);
 		return;
 	}
 
 	brk_opinfo->open_trunc = is_trunc;
 	list_add(&work->interim_entry, &brk_opinfo->interim_list);
 	oplock_break(brk_opinfo, SMB2_OPLOCK_LEVEL_II);
-	opinfo_put(brk_opinfo);
+	opinfo_conn_put(brk_opinfo);
 }
 
 /**
@@ -1263,6 +1278,13 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 	list_for_each_entry_rcu(brk_op, &ci->m_op_list, op_entry) {
 		if (!atomic_inc_not_zero(&brk_op->refcount))
 			continue;
+
+		atomic_inc(&brk_op->conn->r_count);
+		if (ksmbd_conn_releasing(brk_op->conn)) {
+			atomic_dec(&brk_op->conn->r_count);
+			continue;
+		}
+
 		rcu_read_unlock();
 		if (brk_op->is_lease && (brk_op->o_lease->state &
 		    (~(SMB2_LEASE_READ_CACHING_LE |
@@ -1292,7 +1314,7 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 		brk_op->open_trunc = is_trunc;
 		oplock_break(brk_op, SMB2_OPLOCK_LEVEL_NONE);
 next:
-		opinfo_put(brk_op);
+		opinfo_conn_put(brk_op);
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
-- 
2.25.1


