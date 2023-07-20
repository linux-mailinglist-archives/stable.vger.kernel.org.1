Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA09975AFA3
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 15:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjGTNZi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 09:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjGTNZh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 09:25:37 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05A7E60
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:25:36 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1b89d47ffb6so4377285ad.2
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859536; x=1690464336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijcWtsxt0S3veIzbjyQlH7TvYfZuxfwlPe7HNtFuKs8=;
        b=kyvpJYkVK3ZSyY9AVPoUsoD8pHLUyIky4iUem5br9GUwmPBAstr4ict5DZsAg/wf0K
         lKgTd1sDJugoE8HZ8axJBF9O1aHhWBSNUvdHzthcb1BVxOmUXfJjsM9cdG9AIDRIETFQ
         fGVYGEmBgdWcdGW5B3Nld+dHZWHVO5u1fswO8TisvyJk6GPtLJed4ixvyq95n6ngdmRE
         clnv5+aDUwflE5teIZzgKkWFoT4nxeRXocXO4hL1B8+/9xh6nSVfhCC8voSyCwAXohXd
         llW//jOANpT+UosLho4Z7F2KeP68q06W8akxTaE7icEVWfQY8PRwk+de+o7BWlNdvvUY
         1R4Q==
X-Gm-Message-State: ABy/qLbWihCSqvhiDBf5i8b8WvOxx5Z6owX+FK9w5Yn0fuGPMlo5wx6F
        ug0kZ5Vr1SStPgzWUQn9Q+Rpn5Wsuig=
X-Google-Smtp-Source: APBJJlGWF1EDz3yxuEnl2y3MkxLYyEXHvNTj+b1CyVByXefeDUssvlBXv1rkl7rqHjWicR6mz1p95Q==
X-Received: by 2002:a17:902:eccb:b0:1b9:e9b2:124b with SMTP id a11-20020a170902eccb00b001b9e9b2124bmr19086023plh.64.1689859536162;
        Thu, 20 Jul 2023 06:25:36 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id jg19-20020a17090326d300b001b9bebb7a9dsm1336039plb.90.2023.07.20.06.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:25:35 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stfrench@microsoft.com,
        smfrench@gmail.com, Namjae Jeon <linkinjeon@kernel.org>,
        zdi-disclosures@trendmicro.com
Subject: [5.15.y PATCH 4/4] ksmbd: validate session id and tree id in the compound request
Date:   Thu, 20 Jul 2023 22:23:31 +0900
Message-Id: <20230720132336.7614-5-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720132336.7614-1-linkinjeon@kernel.org>
References: <20230720132336.7614-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 5005bcb4219156f1bf7587b185080ec1da08518e upstream.

This patch validate session id and tree id in compound request.
If first operation in the compound is SMB2 ECHO request, ksmbd bypass
session and tree validation. So work->sess and work->tcon could be NULL.
If secound request in the compound access work->sess or tcon, It cause
NULL pointer dereferecing error.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21165
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/server.c  | 33 ++++++++++++++++++++-------------
 fs/ksmbd/smb2pdu.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 59 insertions(+), 18 deletions(-)

diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index 1c5e7e023058..eb45d56b3577 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -184,24 +184,31 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 		goto send;
 	}
 
-	if (conn->ops->check_user_session) {
-		rc = conn->ops->check_user_session(work);
-		if (rc < 0) {
-			command = conn->ops->get_cmd_val(work);
-			conn->ops->set_rsp_status(work,
-					STATUS_USER_SESSION_DELETED);
-			goto send;
-		} else if (rc > 0) {
-			rc = conn->ops->get_ksmbd_tcon(work);
+	do {
+		if (conn->ops->check_user_session) {
+			rc = conn->ops->check_user_session(work);
 			if (rc < 0) {
-				conn->ops->set_rsp_status(work,
-					STATUS_NETWORK_NAME_DELETED);
+				if (rc == -EINVAL)
+					conn->ops->set_rsp_status(work,
+						STATUS_INVALID_PARAMETER);
+				else
+					conn->ops->set_rsp_status(work,
+						STATUS_USER_SESSION_DELETED);
 				goto send;
+			} else if (rc > 0) {
+				rc = conn->ops->get_ksmbd_tcon(work);
+				if (rc < 0) {
+					if (rc == -EINVAL)
+						conn->ops->set_rsp_status(work,
+							STATUS_INVALID_PARAMETER);
+					else
+						conn->ops->set_rsp_status(work,
+							STATUS_NETWORK_NAME_DELETED);
+					goto send;
+				}
 			}
 		}
-	}
 
-	do {
 		rc = __process_request(work, conn, &command);
 		if (rc == SERVER_HANDLER_ABORT)
 			break;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 266430a2a0e0..9f9d07caa57e 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -97,7 +97,6 @@ int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 	struct smb2_hdr *req_hdr = work->request_buf;
 	int tree_id;
 
-	work->tcon = NULL;
 	if (work->conn->ops->get_cmd_val(work) == SMB2_TREE_CONNECT_HE ||
 	    work->conn->ops->get_cmd_val(work) ==  SMB2_CANCEL_HE ||
 	    work->conn->ops->get_cmd_val(work) ==  SMB2_LOGOFF_HE) {
@@ -111,10 +110,28 @@ int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 	}
 
 	tree_id = le32_to_cpu(req_hdr->Id.SyncId.TreeId);
+
+	/*
+	 * If request is not the first in Compound request,
+	 * Just validate tree id in header with work->tcon->id.
+	 */
+	if (work->next_smb2_rcv_hdr_off) {
+		if (!work->tcon) {
+			pr_err("The first operation in the compound does not have tcon\n");
+			return -EINVAL;
+		}
+		if (work->tcon->id != tree_id) {
+			pr_err("tree id(%u) is different with id(%u) in first operation\n",
+					tree_id, work->tcon->id);
+			return -EINVAL;
+		}
+		return 1;
+	}
+
 	work->tcon = ksmbd_tree_conn_lookup(work->sess, tree_id);
 	if (!work->tcon) {
 		pr_err("Invalid tid %d\n", tree_id);
-		return -EINVAL;
+		return -ENOENT;
 	}
 
 	return 1;
@@ -569,7 +586,6 @@ int smb2_check_user_session(struct ksmbd_work *work)
 	unsigned int cmd = conn->ops->get_cmd_val(work);
 	unsigned long long sess_id;
 
-	work->sess = NULL;
 	/*
 	 * SMB2_ECHO, SMB2_NEGOTIATE, SMB2_SESSION_SETUP command do not
 	 * require a session id, so no need to validate user session's for
@@ -580,15 +596,33 @@ int smb2_check_user_session(struct ksmbd_work *work)
 		return 0;
 
 	if (!ksmbd_conn_good(work))
-		return -EINVAL;
+		return -EIO;
 
 	sess_id = le64_to_cpu(req_hdr->SessionId);
+
+	/*
+	 * If request is not the first in Compound request,
+	 * Just validate session id in header with work->sess->id.
+	 */
+	if (work->next_smb2_rcv_hdr_off) {
+		if (!work->sess) {
+			pr_err("The first operation in the compound does not have sess\n");
+			return -EINVAL;
+		}
+		if (work->sess->id != sess_id) {
+			pr_err("session id(%llu) is different with the first operation(%lld)\n",
+					sess_id, work->sess->id);
+			return -EINVAL;
+		}
+		return 1;
+	}
+
 	/* Check for validity of user session */
 	work->sess = ksmbd_session_lookup_all(conn, sess_id);
 	if (work->sess)
 		return 1;
 	ksmbd_debug(SMB, "Invalid user session, Uid %llu\n", sess_id);
-	return -EINVAL;
+	return -ENOENT;
 }
 
 static void destroy_previous_session(struct ksmbd_conn *conn,
-- 
2.25.1

