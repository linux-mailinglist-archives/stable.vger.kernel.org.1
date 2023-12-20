Return-Path: <stable+bounces-8157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C62A81A4CB
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2D71C25973
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87154D598;
	Wed, 20 Dec 2023 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LWzNdqmW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903354C3D7;
	Wed, 20 Dec 2023 16:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1720EC433C7;
	Wed, 20 Dec 2023 16:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703089072;
	bh=yy+nZboN2nk7sp/YdNbNe3uOngTJDI/iA9/PMmI+tfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LWzNdqmW1c8ZhnJLkLsbXLnMAdoTF1UFgZcI0zEKpO1FQvHWwW78YDuQ6ETdCHm+4
	 0j8jj76K8lp7RBfeDmG/EqiHkaTrIkwvlu+71vuzggpDpHuP3eTnDuvI5vngBuBV9L
	 zfnb2k3byxho1i8DlXf9MBL4TS22NJlGEXfi7pyM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	luosili <rootlab@huawei.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 131/159] ksmbd: fix race condition between session lookup and expire
Date: Wed, 20 Dec 2023 17:09:56 +0100
Message-ID: <20231220160937.444129873@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 53ff5cf89142b978b1a5ca8dc4d4425e6a09745f ]

 Thread A                        +  Thread B
 ksmbd_session_lookup            |  smb2_sess_setup
   sess = xa_load                |
                                 |
                                 |    xa_erase(&conn->sessions, sess->id);
                                 |
                                 |    ksmbd_session_destroy(sess) --> kfree(sess)
                                 |
   // UAF!                       |
   sess->last_active = jiffies   |
                                 +

This patch add rwsem to fix race condition between ksmbd_session_lookup
and ksmbd_expire_session.

Reported-by: luosili <rootlab@huawei.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/connection.c        |    2 ++
 fs/ksmbd/connection.h        |    1 +
 fs/ksmbd/mgmt/user_session.c |   10 +++++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -84,6 +84,8 @@ struct ksmbd_conn *ksmbd_conn_alloc(void
 	spin_lock_init(&conn->llist_lock);
 	INIT_LIST_HEAD(&conn->lock_list);
 
+	init_rwsem(&conn->session_lock);
+
 	down_write(&conn_list_lock);
 	list_add(&conn->conns_list, &conn_list);
 	up_write(&conn_list_lock);
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -50,6 +50,7 @@ struct ksmbd_conn {
 	struct nls_table		*local_nls;
 	struct unicode_map		*um;
 	struct list_head		conns_list;
+	struct rw_semaphore		session_lock;
 	/* smb session 1 per user */
 	struct xarray			sessions;
 	unsigned long			last_active;
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -174,7 +174,7 @@ static void ksmbd_expire_session(struct
 	unsigned long id;
 	struct ksmbd_session *sess;
 
-	down_write(&sessions_table_lock);
+	down_write(&conn->session_lock);
 	xa_for_each(&conn->sessions, id, sess) {
 		if (sess->state != SMB2_SESSION_VALID ||
 		    time_after(jiffies,
@@ -185,7 +185,7 @@ static void ksmbd_expire_session(struct
 			continue;
 		}
 	}
-	up_write(&sessions_table_lock);
+	up_write(&conn->session_lock);
 }
 
 int ksmbd_session_register(struct ksmbd_conn *conn,
@@ -227,7 +227,9 @@ void ksmbd_sessions_deregister(struct ks
 			}
 		}
 	}
+	up_write(&sessions_table_lock);
 
+	down_write(&conn->session_lock);
 	xa_for_each(&conn->sessions, id, sess) {
 		unsigned long chann_id;
 		struct channel *chann;
@@ -244,7 +246,7 @@ void ksmbd_sessions_deregister(struct ks
 			ksmbd_session_destroy(sess);
 		}
 	}
-	up_write(&sessions_table_lock);
+	up_write(&conn->session_lock);
 }
 
 struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
@@ -252,9 +254,11 @@ struct ksmbd_session *ksmbd_session_look
 {
 	struct ksmbd_session *sess;
 
+	down_read(&conn->session_lock);
 	sess = xa_load(&conn->sessions, id);
 	if (sess)
 		sess->last_active = jiffies;
+	up_read(&conn->session_lock);
 	return sess;
 }
 



