Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F9B73E769
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjFZSO6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjFZSOt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:14:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C48F10DD
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:14:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B595E60F24
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD87C433C8;
        Mon, 26 Jun 2023 18:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803287;
        bh=hNbypIWMPjlqFzQqY4wEJZSqof/S3UClAnU+H0oTECg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MeSWjTbkj/Pm6jG1k9KrDELOAlCMgseC8vMSImH+MBvX3j/LCzkrM+ZnaHA/i/c83
         a6zhAfGNoG01wmFqPuK2F+gG/3wMGv64b2j6WdJxHrInplBCcLSx2mOXrjf8I8zkHc
         MXZ9IEeRPut1wAqqRdnuAqK2m00DHYhnI+QWgNeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 6.3 010/199] ksmbd: validate session id and tree id in the compound request
Date:   Mon, 26 Jun 2023 20:08:36 +0200
Message-ID: <20230626180806.105257976@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/server.c  |   33 ++++++++++++++++++++-------------
 fs/ksmbd/smb2pdu.c |   44 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 59 insertions(+), 18 deletions(-)

--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -185,24 +185,31 @@ static void __handle_ksmbd_work(struct k
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
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -91,7 +91,6 @@ int smb2_get_ksmbd_tcon(struct ksmbd_wor
 	unsigned int cmd = le16_to_cpu(req_hdr->Command);
 	int tree_id;
 
-	work->tcon = NULL;
 	if (cmd == SMB2_TREE_CONNECT_HE ||
 	    cmd ==  SMB2_CANCEL_HE ||
 	    cmd ==  SMB2_LOGOFF_HE) {
@@ -105,10 +104,28 @@ int smb2_get_ksmbd_tcon(struct ksmbd_wor
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
@@ -547,7 +564,6 @@ int smb2_check_user_session(struct ksmbd
 	unsigned int cmd = conn->ops->get_cmd_val(work);
 	unsigned long long sess_id;
 
-	work->sess = NULL;
 	/*
 	 * SMB2_ECHO, SMB2_NEGOTIATE, SMB2_SESSION_SETUP command do not
 	 * require a session id, so no need to validate user session's for
@@ -558,15 +574,33 @@ int smb2_check_user_session(struct ksmbd
 		return 0;
 
 	if (!ksmbd_conn_good(conn))
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


