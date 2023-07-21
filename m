Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A78675D35B
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjGUTJm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjGUTJl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:09:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E184F30E8
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:09:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8066B61D70
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F392C433C9;
        Fri, 21 Jul 2023 19:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966579;
        bh=5B6b6aB6G/l3jHrt9mLMJ0MUvdC4KXa4vv2VfsfBUls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaTWresIh1yffoifX9q1GhIKyqlBWLFst2E21UNKgXx2lEoHN9Zr9UR2hH9JZagja
         nC1sRSR7PeuEdzxzPH0o8qAyaXCsx+t92BUWbQ9l546qOOzgCisc1SXv4MGpx8L6eA
         OtH65Mob2vlCKbI8RYj/kBFgYjNfeQb0XtRvfX38=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 5.15 394/532] ksmbd: validate session id and tree id in the compound request
Date:   Fri, 21 Jul 2023 18:04:58 +0200
Message-ID: <20230721160635.845338613@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
@@ -184,24 +184,31 @@ static void __handle_ksmbd_work(struct k
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
@@ -97,7 +97,6 @@ int smb2_get_ksmbd_tcon(struct ksmbd_wor
 	struct smb2_hdr *req_hdr = work->request_buf;
 	int tree_id;
 
-	work->tcon = NULL;
 	if (work->conn->ops->get_cmd_val(work) == SMB2_TREE_CONNECT_HE ||
 	    work->conn->ops->get_cmd_val(work) ==  SMB2_CANCEL_HE ||
 	    work->conn->ops->get_cmd_val(work) ==  SMB2_LOGOFF_HE) {
@@ -111,10 +110,28 @@ int smb2_get_ksmbd_tcon(struct ksmbd_wor
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
@@ -569,7 +586,6 @@ int smb2_check_user_session(struct ksmbd
 	unsigned int cmd = conn->ops->get_cmd_val(work);
 	unsigned long long sess_id;
 
-	work->sess = NULL;
 	/*
 	 * SMB2_ECHO, SMB2_NEGOTIATE, SMB2_SESSION_SETUP command do not
 	 * require a session id, so no need to validate user session's for
@@ -580,15 +596,33 @@ int smb2_check_user_session(struct ksmbd
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


