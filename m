Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3926975CD42
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjGUQJa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjGUQJ1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:09:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432FC2D79
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCB8261D26
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A5CC433C9;
        Fri, 21 Jul 2023 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955764;
        bh=DK7FIdItityF1YvJnNAUvKYGHNLp00CCiRu9GwSICiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/idryfxT/ZND8M7OFjhkfeJBEcWXbAGZUAmaSXn+V18uIqWeXD5bNymrEeO2qjzz
         P2ZCT24VitUj8lKu5JxxzythMg/MqII5WQ55DJclY342nI/00j+tuy4sdBgihKh6Tf
         I1dFsr26Y4ok1CeGbOkLyrT0AZbxJIiFisBTY62E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 6.4 009/292] ksmbd: fix out of bounds read in smb2_sess_setup
Date:   Fri, 21 Jul 2023 18:01:58 +0200
Message-ID: <20230721160529.213850591@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

commit 98422bdd4cb3ca4d08844046f6507d7ec2c2b8d8 upstream.

ksmbd does not consider the case of that smb2 session setup is
in compound request. If this is the second payload of the compound,
OOB read issue occurs while processing the first payload in
the smb2_sess_setup().

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21355
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1322,9 +1322,8 @@ static int decode_negotiation_token(stru
 
 static int ntlm_negotiate(struct ksmbd_work *work,
 			  struct negotiate_message *negblob,
-			  size_t negblob_len)
+			  size_t negblob_len, struct smb2_sess_setup_rsp *rsp)
 {
-	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct challenge_message *chgblob;
 	unsigned char *spnego_blob = NULL;
 	u16 spnego_blob_len;
@@ -1429,10 +1428,10 @@ static struct ksmbd_user *session_user(s
 	return user;
 }
 
-static int ntlm_authenticate(struct ksmbd_work *work)
+static int ntlm_authenticate(struct ksmbd_work *work,
+			     struct smb2_sess_setup_req *req,
+			     struct smb2_sess_setup_rsp *rsp)
 {
-	struct smb2_sess_setup_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
 	struct channel *chann = NULL;
@@ -1566,10 +1565,10 @@ binding_session:
 }
 
 #ifdef CONFIG_SMB_SERVER_KERBEROS5
-static int krb5_authenticate(struct ksmbd_work *work)
+static int krb5_authenticate(struct ksmbd_work *work,
+			     struct smb2_sess_setup_req *req,
+			     struct smb2_sess_setup_rsp *rsp)
 {
-	struct smb2_sess_setup_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
 	char *in_blob, *out_blob;
@@ -1647,7 +1646,9 @@ static int krb5_authenticate(struct ksmb
 	return 0;
 }
 #else
-static int krb5_authenticate(struct ksmbd_work *work)
+static int krb5_authenticate(struct ksmbd_work *work,
+			     struct smb2_sess_setup_req *req,
+			     struct smb2_sess_setup_rsp *rsp)
 {
 	return -EOPNOTSUPP;
 }
@@ -1656,8 +1657,8 @@ static int krb5_authenticate(struct ksmb
 int smb2_sess_setup(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_sess_setup_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_sess_setup_req *req;
+	struct smb2_sess_setup_rsp *rsp;
 	struct ksmbd_session *sess;
 	struct negotiate_message *negblob;
 	unsigned int negblob_len, negblob_off;
@@ -1665,6 +1666,8 @@ int smb2_sess_setup(struct ksmbd_work *w
 
 	ksmbd_debug(SMB, "Received request for session setup\n");
 
+	WORK_BUFFERS(work, req, rsp);
+
 	rsp->StructureSize = cpu_to_le16(9);
 	rsp->SessionFlags = 0;
 	rsp->SecurityBufferOffset = cpu_to_le16(72);
@@ -1786,7 +1789,7 @@ int smb2_sess_setup(struct ksmbd_work *w
 
 		if (conn->preferred_auth_mech &
 				(KSMBD_AUTH_KRB5 | KSMBD_AUTH_MSKRB5)) {
-			rc = krb5_authenticate(work);
+			rc = krb5_authenticate(work, req, rsp);
 			if (rc) {
 				rc = -EINVAL;
 				goto out_err;
@@ -1800,7 +1803,7 @@ int smb2_sess_setup(struct ksmbd_work *w
 			sess->Preauth_HashValue = NULL;
 		} else if (conn->preferred_auth_mech == KSMBD_AUTH_NTLMSSP) {
 			if (negblob->MessageType == NtLmNegotiate) {
-				rc = ntlm_negotiate(work, negblob, negblob_len);
+				rc = ntlm_negotiate(work, negblob, negblob_len, rsp);
 				if (rc)
 					goto out_err;
 				rsp->hdr.Status =
@@ -1813,7 +1816,7 @@ int smb2_sess_setup(struct ksmbd_work *w
 						le16_to_cpu(rsp->SecurityBufferLength) - 1);
 
 			} else if (negblob->MessageType == NtLmAuthenticate) {
-				rc = ntlm_authenticate(work);
+				rc = ntlm_authenticate(work, req, rsp);
 				if (rc)
 					goto out_err;
 


