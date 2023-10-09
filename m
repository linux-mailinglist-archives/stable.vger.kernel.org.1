Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A72B7BDECA
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376426AbjJINXI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376435AbjJINXH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:23:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F6694
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:23:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C07C433C8;
        Mon,  9 Oct 2023 13:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857785;
        bh=MA+fMjA9dDTUjI7SoZJlDDopUqnOiS4neuCA/r4y/m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwsS+6pc+59E/OApMasC/zgJhT2vos9GVFmiAhQ4qbUha2G5tZJ8KHPkJXikDD6UB
         p0aDLelhEGk1sGLf0smYLeViV5AAM0MJIJFo4xfet1y3wFpgom0mfwHHZBq8X8VqR+
         qtR6uDiYpIqTAsoSX0wUWSknFH9H74AWS9vuLyhU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, luosili <rootlab@huawei.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 155/162] ksmbd: fix race condition between session lookup and expire
Date:   Mon,  9 Oct 2023 15:02:16 +0200
Message-ID: <20231009130127.193700356@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 53ff5cf89142b978b1a5ca8dc4d4425e6a09745f upstream.

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
 fs/smb/server/connection.c        |    2 ++
 fs/smb/server/connection.h        |    1 +
 fs/smb/server/mgmt/user_session.c |   10 +++++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -84,6 +84,8 @@ struct ksmbd_conn *ksmbd_conn_alloc(void
 	spin_lock_init(&conn->llist_lock);
 	INIT_LIST_HEAD(&conn->lock_list);
 
+	init_rwsem(&conn->session_lock);
+
 	down_write(&conn_list_lock);
 	list_add(&conn->conns_list, &conn_list);
 	up_write(&conn_list_lock);
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -50,6 +50,7 @@ struct ksmbd_conn {
 	struct nls_table		*local_nls;
 	struct unicode_map		*um;
 	struct list_head		conns_list;
+	struct rw_semaphore		session_lock;
 	/* smb session 1 per user */
 	struct xarray			sessions;
 	unsigned long			last_active;
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -183,7 +183,7 @@ static void ksmbd_expire_session(struct
 	unsigned long id;
 	struct ksmbd_session *sess;
 
-	down_write(&sessions_table_lock);
+	down_write(&conn->session_lock);
 	xa_for_each(&conn->sessions, id, sess) {
 		if (sess->state != SMB2_SESSION_VALID ||
 		    time_after(jiffies,
@@ -194,7 +194,7 @@ static void ksmbd_expire_session(struct
 			continue;
 		}
 	}
-	up_write(&sessions_table_lock);
+	up_write(&conn->session_lock);
 }
 
 int ksmbd_session_register(struct ksmbd_conn *conn,
@@ -236,7 +236,9 @@ void ksmbd_sessions_deregister(struct ks
 			}
 		}
 	}
+	up_write(&sessions_table_lock);
 
+	down_write(&conn->session_lock);
 	xa_for_each(&conn->sessions, id, sess) {
 		unsigned long chann_id;
 		struct channel *chann;
@@ -253,7 +255,7 @@ void ksmbd_sessions_deregister(struct ks
 			ksmbd_session_destroy(sess);
 		}
 	}
-	up_write(&sessions_table_lock);
+	up_write(&conn->session_lock);
 }
 
 struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
@@ -261,9 +263,11 @@ struct ksmbd_session *ksmbd_session_look
 {
 	struct ksmbd_session *sess;
 
+	down_read(&conn->session_lock);
 	sess = xa_load(&conn->sessions, id);
 	if (sess)
 		sess->last_active = jiffies;
+	up_read(&conn->session_lock);
 	return sess;
 }
 


