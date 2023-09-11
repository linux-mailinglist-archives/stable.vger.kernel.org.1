Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C0B79BBC3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376650AbjIKWUJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbjIKO0t (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:26:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4B7CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:26:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BBCC433C8;
        Mon, 11 Sep 2023 14:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442404;
        bh=MFYCr/fVXla8TEokWeL4XCmtR86ycjRXuOZmjN8WA8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nog0F+DurZoBHW0Vf6kHvLhp1S0giaPK6JWfgQra4NWdNw7GQ3pC19hB5v+4khJyU
         rm6WxQI+s+3IbKLKlblUqcKPnHouKJAZjQV5OduVqOP3F8tUZw2N6a4mvwZ272TbTg
         fRHju9Nfsbe0D9AfLeOFrSHOhSFS4cBS+cBgDP7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, zdi-disclosures@trendmicro.com
Subject: [PATCH 6.4 014/737] ksmbd: fix out of bounds in init_smb2_rsp_hdr()
Date:   Mon, 11 Sep 2023 15:37:53 +0200
Message-ID: <20230911134650.728565077@linuxfoundation.org>
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

[ Upstream commit 536bb492d39bb6c080c92f31e8a55fe9934f452b ]

If client send smb2 negotiate request and then send smb1 negotiate
request, init_smb2_rsp_hdr is called for smb1 negotiate request since
need_neg is set to false. This patch ignore smb1 packets after ->need_neg
is set to false.

Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21541
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/server.c     |  7 ++++++-
 fs/smb/server/smb_common.c | 19 +++++++++++--------
 fs/smb/server/smb_common.h |  2 +-
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index ced7a9e916f01..9df121bdf3492 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -286,6 +286,7 @@ static void handle_ksmbd_work(struct work_struct *wk)
 static int queue_ksmbd_work(struct ksmbd_conn *conn)
 {
 	struct ksmbd_work *work;
+	int err;
 
 	work = ksmbd_alloc_work_struct();
 	if (!work) {
@@ -297,7 +298,11 @@ static int queue_ksmbd_work(struct ksmbd_conn *conn)
 	work->request_buf = conn->request_buf;
 	conn->request_buf = NULL;
 
-	ksmbd_init_smb_server(work);
+	err = ksmbd_init_smb_server(work);
+	if (err) {
+		ksmbd_free_work_struct(work);
+		return 0;
+	}
 
 	ksmbd_conn_enqueue_request(work);
 	atomic_inc(&conn->r_count);
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 3e391a7d5a3ab..27b8bd039791e 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -388,26 +388,29 @@ static struct smb_version_cmds smb1_server_cmds[1] = {
 	[SMB_COM_NEGOTIATE_EX]	= { .proc = smb1_negotiate, },
 };
 
-static void init_smb1_server(struct ksmbd_conn *conn)
+static int init_smb1_server(struct ksmbd_conn *conn)
 {
 	conn->ops = &smb1_server_ops;
 	conn->cmds = smb1_server_cmds;
 	conn->max_cmds = ARRAY_SIZE(smb1_server_cmds);
+	return 0;
 }
 
-void ksmbd_init_smb_server(struct ksmbd_work *work)
+int ksmbd_init_smb_server(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	__le32 proto;
 
-	if (conn->need_neg == false)
-		return;
-
 	proto = *(__le32 *)((struct smb_hdr *)work->request_buf)->Protocol;
+	if (conn->need_neg == false) {
+		if (proto == SMB1_PROTO_NUMBER)
+			return -EINVAL;
+		return 0;
+	}
+
 	if (proto == SMB1_PROTO_NUMBER)
-		init_smb1_server(conn);
-	else
-		init_smb3_11_server(conn);
+		return init_smb1_server(conn);
+	return init_smb3_11_server(conn);
 }
 
 int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work, int info_level,
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index 6b0d5f1fe85ca..f0134d16067fb 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -427,7 +427,7 @@ bool ksmbd_smb_request(struct ksmbd_conn *conn);
 
 int ksmbd_lookup_dialect_by_id(__le16 *cli_dialects, __le16 dialects_count);
 
-void ksmbd_init_smb_server(struct ksmbd_work *work);
+int ksmbd_init_smb_server(struct ksmbd_work *work);
 
 struct ksmbd_kstat;
 int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work,
-- 
2.40.1



