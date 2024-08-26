Return-Path: <stable+bounces-70164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D3795EFE8
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 13:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677A51C2141C
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 11:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B32D14EC77;
	Mon, 26 Aug 2024 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iGKj4NS0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1B1482E3
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672318; cv=none; b=MdpT9MEXallMwIWqlfrn3vNIkrGq3+rMJvQOx3ENC97ICvguSr+8M0D2lnS7J5Q+/RI3/sRKHU/UjXJg/9d3HkeZakAuo5dtBIa6J+WMV1bDRNYyq7xai2fmMo+M2OhnErXSt3KO5IRrASDmE0P2umChYzemCD4s5ppDrTlrXuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672318; c=relaxed/simple;
	bh=m9+g823uM1dusP1KPaWMYHFgwJEgC0efPLIOipjnO9Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a+zjpmvBWfR/Vvfc4+PKZ6C93R62RyBGaalHjhKEVHe/EUqIv7RxY1U2Yd1g/gkBWRI+5SlItjtTa4gppGrfRbjnQW3RKR8VV8wQZVC5MgSWCuIdMhSS/kMJb1NZDnAG4l1R1jT+w+GU2VnbkqXq+nZE/jAQj8v4uTFzgwAQZko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iGKj4NS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D24EC51400;
	Mon, 26 Aug 2024 11:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724672317;
	bh=m9+g823uM1dusP1KPaWMYHFgwJEgC0efPLIOipjnO9Y=;
	h=Subject:To:Cc:From:Date:From;
	b=iGKj4NS016g9g3U2Pu0/Rc/k5+wGg3C0C4w7VWBj9QuuI8rNwInC02et4jjFBiIOU
	 jgeIcuXl9dL990w5fNEBGMzcRIzK8mruyfo150cx/5Posl3hgq8DwVk4pU/Fm6VghN
	 aIrA3yCydJD5PFUNAjKgTpAWYEkgIRQcIlxRumyM=
Subject: FAILED: patch "[PATCH] ksmbd: fix race condition between destroy_previous_session()" failed to apply to 6.6-stable tree
To: linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 13:38:26 +0200
Message-ID: <2024082626-succulent-engraver-73cd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 76e98a158b207771a6c9a0de0a60522a446a3447
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082626-succulent-engraver-73cd@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

76e98a158b20 ("ksmbd: fix race condition between destroy_previous_session() and smb2 operations()")
d484d621d40f ("ksmbd: add durable scavenger timer")
c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
fa9415d4024f ("ksmbd: mark SMB2_SESSION_EXPIRED to session when destroying previous session")
c2a721eead71 ("ksmbd: lazy v2 lease break on smb2_write()")
d47d9886aeef ("ksmbd: send v2 lease break notification for directory")
eb547407f357 ("ksmbd: downgrade RWH lease caching state to RH for directory")
2e450920d58b ("ksmbd: move oplock handling after unlock parent dir")
4274a9dc6aeb ("ksmbd: separately allocate ci per dentry")
864fb5d37163 ("ksmbd: fix possible deadlock in smb2_open")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76e98a158b207771a6c9a0de0a60522a446a3447 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 17 Aug 2024 14:03:49 +0900
Subject: [PATCH] ksmbd: fix race condition between destroy_previous_session()
 and smb2 operations()

If there is ->PreviousSessionId field in the session setup request,
The session of the previous connection should be destroyed.
During this, if the smb2 operation requests in the previous session are
being processed, a racy issue could happen with ksmbd_destroy_file_table().
This patch sets conn->status to KSMBD_SESS_NEED_RECONNECT to block
incoming  operations and waits until on-going operations are complete
(i.e. idle) before desctorying the previous session.

Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
Cc: stable@vger.kernel.org # v6.6+
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-25040
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 09e1e7771592..7889df8112b4 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -165,11 +165,43 @@ void ksmbd_all_conn_set_status(u64 sess_id, u32 status)
 	up_read(&conn_list_lock);
 }
 
-void ksmbd_conn_wait_idle(struct ksmbd_conn *conn, u64 sess_id)
+void ksmbd_conn_wait_idle(struct ksmbd_conn *conn)
 {
 	wait_event(conn->req_running_q, atomic_read(&conn->req_running) < 2);
 }
 
+int ksmbd_conn_wait_idle_sess_id(struct ksmbd_conn *curr_conn, u64 sess_id)
+{
+	struct ksmbd_conn *conn;
+	int rc, retry_count = 0, max_timeout = 120;
+	int rcount = 1;
+
+retry_idle:
+	if (retry_count >= max_timeout)
+		return -EIO;
+
+	down_read(&conn_list_lock);
+	list_for_each_entry(conn, &conn_list, conns_list) {
+		if (conn->binding || xa_load(&conn->sessions, sess_id)) {
+			if (conn == curr_conn)
+				rcount = 2;
+			if (atomic_read(&conn->req_running) >= rcount) {
+				rc = wait_event_timeout(conn->req_running_q,
+					atomic_read(&conn->req_running) < rcount,
+					HZ);
+				if (!rc) {
+					up_read(&conn_list_lock);
+					retry_count++;
+					goto retry_idle;
+				}
+			}
+		}
+	}
+	up_read(&conn_list_lock);
+
+	return 0;
+}
+
 int ksmbd_conn_write(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index 5c2845e47cf2..5b947175c048 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -145,7 +145,8 @@ extern struct list_head conn_list;
 extern struct rw_semaphore conn_list_lock;
 
 bool ksmbd_conn_alive(struct ksmbd_conn *conn);
-void ksmbd_conn_wait_idle(struct ksmbd_conn *conn, u64 sess_id);
+void ksmbd_conn_wait_idle(struct ksmbd_conn *conn);
+int ksmbd_conn_wait_idle_sess_id(struct ksmbd_conn *curr_conn, u64 sess_id);
 struct ksmbd_conn *ksmbd_conn_alloc(void);
 void ksmbd_conn_free(struct ksmbd_conn *conn);
 bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c);
diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 162a12685d2c..99416ce9f501 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -311,6 +311,7 @@ void destroy_previous_session(struct ksmbd_conn *conn,
 {
 	struct ksmbd_session *prev_sess;
 	struct ksmbd_user *prev_user;
+	int err;
 
 	down_write(&sessions_table_lock);
 	down_write(&conn->session_lock);
@@ -325,8 +326,16 @@ void destroy_previous_session(struct ksmbd_conn *conn,
 	    memcmp(user->passkey, prev_user->passkey, user->passkey_sz))
 		goto out;
 
+	ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_RECONNECT);
+	err = ksmbd_conn_wait_idle_sess_id(conn, id);
+	if (err) {
+		ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_NEGOTIATE);
+		goto out;
+	}
+
 	ksmbd_destroy_file_table(&prev_sess->file_table);
 	prev_sess->state = SMB2_SESSION_EXPIRED;
+	ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_NEGOTIATE);
 	ksmbd_launch_ksmbd_durable_scavenger();
 out:
 	up_write(&conn->session_lock);
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 3f4c56a10a86..cb7f487c96af 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2213,7 +2213,7 @@ int smb2_session_logoff(struct ksmbd_work *work)
 	ksmbd_conn_unlock(conn);
 
 	ksmbd_close_session_fds(work);
-	ksmbd_conn_wait_idle(conn, sess_id);
+	ksmbd_conn_wait_idle(conn);
 
 	/*
 	 * Re-lookup session to validate if session is deleted


