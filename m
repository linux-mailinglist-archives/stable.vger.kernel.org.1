Return-Path: <stable+bounces-91995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA7A9C2C58
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 12:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0EB2822EB
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 11:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B3D14D456;
	Sat,  9 Nov 2024 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NzJlEO6x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB5D12F5B1
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731153408; cv=none; b=QDOmpDKNKnL8mswKRUt4Y0izNBOBMFHkyC9AR4uYyOn3nXQnLEbEKID8ZOvma0oFzicsvnbNuIc6Hzvc3hXnBu72WHddQK+LGLE0ZD0pHwVNiCwPrsB2LE1U3AOmBzjeP2ox3QegZwVmjtHh4t1CoLVTPurn64PzpX8HheaEUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731153408; c=relaxed/simple;
	bh=qVQ9jsPnChkxuWN9vfC3WBQozmn1Fv90VhNMTkTv6gs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=avBVSxle/i/6WjLdQL7PB+EyvCV7/iYYhidIa1iuOY3U1Wl7z9Qh9qFJqn9+e2KobcZXqLAUnCt/nCARDhpm3MzdR2f7BrE09jmFGXITI5yKkwB8DLD2El6RDztZozeG8u8x2q7P+TglJWfplGHEQKAwKDJXnkTl2aGS/Ew3YOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NzJlEO6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034EBC4CECE;
	Sat,  9 Nov 2024 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731153408;
	bh=qVQ9jsPnChkxuWN9vfC3WBQozmn1Fv90VhNMTkTv6gs=;
	h=Subject:To:Cc:From:Date:From;
	b=NzJlEO6xz83rZtez1OTGOfudRVNQHEavgu0FJKx6X8zEb8/JIzDx5Lc/hskwJ5qEW
	 CS5wNgZR6S5MvMks0ZVaJNVmLFy+Z7IuR9US21NbPrwb+Tod1n2PqE335YJ6Xlo/De
	 R+bmwr4Ui7ww2PJSKEzWiIUW5J7dWtQWiOejkj6U=
Subject: FAILED: patch "[PATCH] ksmbd: check outstanding simultaneous SMB operations" failed to apply to 6.1-stable tree
To: linkinjeon@kernel.org,norbert@doyensec.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Nov 2024 12:56:45 +0100
Message-ID: <2024110945-blot-unsaid-0239@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0a77d947f599b1f39065015bec99390d0c0022ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110945-blot-unsaid-0239@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0a77d947f599b1f39065015bec99390d0c0022ee Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 4 Nov 2024 13:43:06 +0900
Subject: [PATCH] ksmbd: check outstanding simultaneous SMB operations
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If Client send simultaneous SMB operations to ksmbd, It exhausts too much
memory through the "ksmbd_work_cache”. It will cause OOM issue.
ksmbd has a credit mechanism but it can't handle this problem. This patch
add the check if it exceeds max credits to prevent this problem by assuming
that one smb request consumes at least one credit.

Cc: stable@vger.kernel.org # v5.15+
Reported-by: Norbert Szetei <norbert@doyensec.com>
Tested-by: Norbert Szetei <norbert@doyensec.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index aa2a37a7ce84..e6a72f75ab94 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -70,6 +70,7 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 	atomic_set(&conn->req_running, 0);
 	atomic_set(&conn->r_count, 0);
 	atomic_set(&conn->refcnt, 1);
+	atomic_set(&conn->mux_smb_requests, 0);
 	conn->total_credits = 1;
 	conn->outstanding_credits = 0;
 
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index b379ae4fdcdf..8ddd5a3c7baf 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -107,6 +107,7 @@ struct ksmbd_conn {
 	__le16				signing_algorithm;
 	bool				binding;
 	atomic_t			refcnt;
+	atomic_t			mux_smb_requests;
 };
 
 struct ksmbd_conn_ops {
diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index e7f14f8df943..e6cfedba9992 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -270,6 +270,7 @@ static void handle_ksmbd_work(struct work_struct *wk)
 
 	ksmbd_conn_try_dequeue_request(work);
 	ksmbd_free_work_struct(work);
+	atomic_dec(&conn->mux_smb_requests);
 	/*
 	 * Checking waitqueue to dropping pending requests on
 	 * disconnection. waitqueue_active is safe because it
@@ -291,6 +292,15 @@ static int queue_ksmbd_work(struct ksmbd_conn *conn)
 	struct ksmbd_work *work;
 	int err;
 
+	err = ksmbd_init_smb_server(conn);
+	if (err)
+		return 0;
+
+	if (atomic_inc_return(&conn->mux_smb_requests) >= conn->vals->max_credits) {
+		atomic_dec_return(&conn->mux_smb_requests);
+		return -ENOSPC;
+	}
+
 	work = ksmbd_alloc_work_struct();
 	if (!work) {
 		pr_err("allocation for work failed\n");
@@ -301,12 +311,6 @@ static int queue_ksmbd_work(struct ksmbd_conn *conn)
 	work->request_buf = conn->request_buf;
 	conn->request_buf = NULL;
 
-	err = ksmbd_init_smb_server(work);
-	if (err) {
-		ksmbd_free_work_struct(work);
-		return 0;
-	}
-
 	ksmbd_conn_enqueue_request(work);
 	atomic_inc(&conn->r_count);
 	/* update activity on connection */
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index a2ebbe604c8c..75b4eb856d32 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -388,6 +388,10 @@ static struct smb_version_ops smb1_server_ops = {
 	.set_rsp_status = set_smb1_rsp_status,
 };
 
+static struct smb_version_values smb1_server_values = {
+	.max_credits = SMB2_MAX_CREDITS,
+};
+
 static int smb1_negotiate(struct ksmbd_work *work)
 {
 	return ksmbd_smb_negotiate_common(work, SMB_COM_NEGOTIATE);
@@ -399,18 +403,18 @@ static struct smb_version_cmds smb1_server_cmds[1] = {
 
 static int init_smb1_server(struct ksmbd_conn *conn)
 {
+	conn->vals = &smb1_server_values;
 	conn->ops = &smb1_server_ops;
 	conn->cmds = smb1_server_cmds;
 	conn->max_cmds = ARRAY_SIZE(smb1_server_cmds);
 	return 0;
 }
 
-int ksmbd_init_smb_server(struct ksmbd_work *work)
+int ksmbd_init_smb_server(struct ksmbd_conn *conn)
 {
-	struct ksmbd_conn *conn = work->conn;
 	__le32 proto;
 
-	proto = *(__le32 *)((struct smb_hdr *)work->request_buf)->Protocol;
+	proto = *(__le32 *)((struct smb_hdr *)conn->request_buf)->Protocol;
 	if (conn->need_neg == false) {
 		if (proto == SMB1_PROTO_NUMBER)
 			return -EINVAL;
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index cc1d6dfe29d5..a3d8a905b07e 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -427,7 +427,7 @@ bool ksmbd_smb_request(struct ksmbd_conn *conn);
 
 int ksmbd_lookup_dialect_by_id(__le16 *cli_dialects, __le16 dialects_count);
 
-int ksmbd_init_smb_server(struct ksmbd_work *work);
+int ksmbd_init_smb_server(struct ksmbd_conn *conn);
 
 struct ksmbd_kstat;
 int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work,


