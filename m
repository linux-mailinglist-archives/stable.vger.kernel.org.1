Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4732479AF60
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350395AbjIKVhz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbjIKO0o (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:26:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2268F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:26:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D59C433C8;
        Mon, 11 Sep 2023 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442399;
        bh=iqEAit+rueMMh2I+vZ+GsKXf2Tt1IBM6EuwjDauVzuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IH62q1r3aembX1W/Tz6TEMUP7CWplFR75HHPIeloJw9aFuVQCUxBnMQ1+O/JDHA9O
         txJORr9Nt1qGEEpyqsn39AkXeIkUrz5tPsPu7Ty/k6aNDT4dHrDyzdHgzo8ODXv7oY
         p5COD5WYgrJ4PZZZW1PGnedTAB3TU0TJ0zqTXhfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, zdi-disclosures@trendmicro.com
Subject: [PATCH 6.4 012/737] ksmbd: validate session id and tree id in compound request
Date:   Mon, 11 Sep 2023 15:37:51 +0200
Message-ID: <20230911134650.668056847@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 3df0411e132ee74a87aa13142dfd2b190275332e ]

`smb2_get_msg()` in smb2_get_ksmbd_tcon() and smb2_check_user_session()
will always return the first request smb2 header in a compound request.
if `SMB2_TREE_CONNECT_HE` is the first command in compound request, will
return 0, i.e. The tree id check is skipped.
This patch use ksmbd_req_buf_next() to get current command in compound.

Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21506
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index dab4c7d710914..ca5af2d9e28bb 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -87,9 +87,9 @@ struct channel *lookup_chann_list(struct ksmbd_session *sess, struct ksmbd_conn
  */
 int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 {
-	struct smb2_hdr *req_hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *req_hdr = ksmbd_req_buf_next(work);
 	unsigned int cmd = le16_to_cpu(req_hdr->Command);
-	int tree_id;
+	unsigned int tree_id;
 
 	if (cmd == SMB2_TREE_CONNECT_HE ||
 	    cmd ==  SMB2_CANCEL_HE ||
@@ -114,7 +114,7 @@ int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 			pr_err("The first operation in the compound does not have tcon\n");
 			return -EINVAL;
 		}
-		if (work->tcon->id != tree_id) {
+		if (tree_id != UINT_MAX && work->tcon->id != tree_id) {
 			pr_err("tree id(%u) is different with id(%u) in first operation\n",
 					tree_id, work->tcon->id);
 			return -EINVAL;
@@ -559,9 +559,9 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
  */
 int smb2_check_user_session(struct ksmbd_work *work)
 {
-	struct smb2_hdr *req_hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *req_hdr = ksmbd_req_buf_next(work);
 	struct ksmbd_conn *conn = work->conn;
-	unsigned int cmd = conn->ops->get_cmd_val(work);
+	unsigned int cmd = le16_to_cpu(req_hdr->Command);
 	unsigned long long sess_id;
 
 	/*
@@ -587,7 +587,7 @@ int smb2_check_user_session(struct ksmbd_work *work)
 			pr_err("The first operation in the compound does not have sess\n");
 			return -EINVAL;
 		}
-		if (work->sess->id != sess_id) {
+		if (sess_id != ULLONG_MAX && work->sess->id != sess_id) {
 			pr_err("session id(%llu) is different with the first operation(%lld)\n",
 					sess_id, work->sess->id);
 			return -EINVAL;
-- 
2.40.1



