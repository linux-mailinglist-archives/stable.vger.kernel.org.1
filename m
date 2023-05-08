Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C6B6FAA01
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjEHK5x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbjEHK5g (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:57:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38782DD68
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:56:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6567C629CA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFDCC433D2;
        Mon,  8 May 2023 10:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543389;
        bh=2l16Z/6SMqpJ5wzI3AAe8pVRgaf0sJs0N6Sv+rA9lpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kysWLXrQIK6jGJdcNk7+vyYm71J62RS8mMklKkFs58EhWssdxSwaagBCICtrNBEct
         Pa9xq9bLkLGsFNzjVT1fXhI9qFCda9x5F+LR4Rl72/OGIj1+MWJfcx6wh7vu6fM5VD
         9YIgJDRAQWkS5kpn0dTCkxaZys6HrKKBHC38phU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 6.3 074/694] ksmbd: destroy expired sessions
Date:   Mon,  8 May 2023 11:38:29 +0200
Message-Id: <20230508094434.945863318@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

commit ea174a91893956450510945a0c5d1a10b5323656 upstream.

client can indefinitely send smb2 session setup requests with
the SessionId set to 0, thus indefinitely spawning new sessions,
and causing indefinite memory usage. This patch limit to the number
of sessions using expired timeout and session state.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-20478
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/mgmt/user_session.c |   68 +++++++++++++++++++++++--------------------
 fs/ksmbd/mgmt/user_session.h |    1 
 fs/ksmbd/smb2pdu.c           |    1 
 fs/ksmbd/smb2pdu.h           |    2 +
 4 files changed, 41 insertions(+), 31 deletions(-)

--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -165,70 +165,73 @@ static struct ksmbd_session *__session_l
 	struct ksmbd_session *sess;
 
 	hash_for_each_possible(sessions_table, sess, hlist, id) {
-		if (id == sess->id)
+		if (id == sess->id) {
+			sess->last_active = jiffies;
 			return sess;
+		}
 	}
 	return NULL;
 }
 
+static void ksmbd_expire_session(struct ksmbd_conn *conn)
+{
+	unsigned long id;
+	struct ksmbd_session *sess;
+
+	xa_for_each(&conn->sessions, id, sess) {
+		if (sess->state != SMB2_SESSION_VALID ||
+		    time_after(jiffies,
+			       sess->last_active + SMB2_SESSION_TIMEOUT)) {
+			xa_erase(&conn->sessions, sess->id);
+			ksmbd_session_destroy(sess);
+			continue;
+		}
+	}
+}
+
 int ksmbd_session_register(struct ksmbd_conn *conn,
 			   struct ksmbd_session *sess)
 {
 	sess->dialect = conn->dialect;
 	memcpy(sess->ClientGUID, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
+	ksmbd_expire_session(conn);
 	return xa_err(xa_store(&conn->sessions, sess->id, sess, GFP_KERNEL));
 }
 
-static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
+static void ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
 {
 	struct channel *chann;
 
 	chann = xa_erase(&sess->ksmbd_chann_list, (long)conn);
 	if (!chann)
-		return -ENOENT;
+		return;
 
 	kfree(chann);
-
-	return 0;
 }
 
 void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 {
 	struct ksmbd_session *sess;
+	unsigned long id;
 
-	if (conn->binding) {
-		int bkt;
-
-		down_write(&sessions_table_lock);
-		hash_for_each(sessions_table, bkt, sess, hlist) {
-			if (!ksmbd_chann_del(conn, sess)) {
-				up_write(&sessions_table_lock);
-				goto sess_destroy;
-			}
-		}
-		up_write(&sessions_table_lock);
-	} else {
-		unsigned long id;
-
-		xa_for_each(&conn->sessions, id, sess) {
-			if (!ksmbd_chann_del(conn, sess))
-				goto sess_destroy;
+	xa_for_each(&conn->sessions, id, sess) {
+		ksmbd_chann_del(conn, sess);
+		if (xa_empty(&sess->ksmbd_chann_list)) {
+			xa_erase(&conn->sessions, sess->id);
+			ksmbd_session_destroy(sess);
 		}
 	}
-
-	return;
-
-sess_destroy:
-	if (xa_empty(&sess->ksmbd_chann_list)) {
-		xa_erase(&conn->sessions, sess->id);
-		ksmbd_session_destroy(sess);
-	}
 }
 
 struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
 					   unsigned long long id)
 {
-	return xa_load(&conn->sessions, id);
+	struct ksmbd_session *sess;
+
+	sess = xa_load(&conn->sessions, id);
+	if (sess)
+		sess->last_active = jiffies;
+	return sess;
 }
 
 struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
@@ -237,6 +240,8 @@ struct ksmbd_session *ksmbd_session_look
 
 	down_read(&sessions_table_lock);
 	sess = __session_lookup(id);
+	if (sess)
+		sess->last_active = jiffies;
 	up_read(&sessions_table_lock);
 
 	return sess;
@@ -315,6 +320,7 @@ static struct ksmbd_session *__session_c
 	if (ksmbd_init_file_table(&sess->file_table))
 		goto error;
 
+	sess->last_active = jiffies;
 	sess->state = SMB2_SESSION_IN_PROGRESS;
 	set_session_flag(sess, protocol);
 	xa_init(&sess->tree_conns);
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -59,6 +59,7 @@ struct ksmbd_session {
 	__u8				smb3signingkey[SMB3_SIGN_KEY_SIZE];
 
 	struct ksmbd_file_table		file_table;
+	unsigned long			last_active;
 };
 
 static inline int test_session_flag(struct ksmbd_session *sess, int bit)
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1873,6 +1873,7 @@ out_err:
 			if (sess->user && sess->user->flags & KSMBD_USER_FLAG_DELAY_SESSION)
 				try_delay = true;
 
+			sess->last_active = jiffies;
 			sess->state = SMB2_SESSION_EXPIRED;
 			if (try_delay) {
 				ksmbd_conn_set_need_reconnect(conn);
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -61,6 +61,8 @@ struct preauth_integrity_info {
 #define SMB2_SESSION_IN_PROGRESS	BIT(0)
 #define SMB2_SESSION_VALID		BIT(1)
 
+#define SMB2_SESSION_TIMEOUT		(10 * HZ)
+
 struct create_durable_req_v2 {
 	struct create_context ccontext;
 	__u8   Name[8];


