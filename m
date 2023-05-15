Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0427038CC
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243310AbjEORfM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244412AbjEOReh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:34:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA55E52
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:32:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6538862D6A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF6DC4339B;
        Mon, 15 May 2023 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171965;
        bh=wkPsRlIz8BqHBMrI7UBkBDTKDFc/0Tx8N/qUmgIE+4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/lWxvCg0wt2GUU7yN+tZyIC7TL2cPkZGE3fhYJR/gwncneEk57p74iPlyN/E6y57
         SeFiZF9KGZD1RwsMMKOsrhTa1UtwYYUHMpsQj8hjPTMyUZrYuYoaMhAaunj1ZxB0+q
         WdBYK32auQW1vk1HF5me1FKheKt0OWqirI4AtC7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 113/134] ksmbd: add channel rwlock
Date:   Mon, 15 May 2023 18:29:50 +0200
Message-Id: <20230515161706.888555843@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

[ Upstream commit 8e06b31e348107c5d78e2c90bb7e69388cb97fb6 ]

Add missing rwlock for channel list in session.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 7b4323373d84 ("ksmbd: fix deadlock in ksmbd_find_crypto_ctx()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/mgmt/user_session.c |  3 +++
 fs/ksmbd/mgmt/user_session.h |  1 +
 fs/ksmbd/smb2pdu.c           | 20 ++++++++++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index 8fe08df668582..0c7b5335c12af 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -32,11 +32,13 @@ static void free_channel_list(struct ksmbd_session *sess)
 {
 	struct channel *chann, *tmp;
 
+	write_lock(&sess->chann_lock);
 	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
 				 chann_list) {
 		list_del(&chann->chann_list);
 		kfree(chann);
 	}
+	write_unlock(&sess->chann_lock);
 }
 
 static void __session_rpc_close(struct ksmbd_session *sess,
@@ -305,6 +307,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	INIT_LIST_HEAD(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
 	atomic_set(&sess->refcnt, 1);
+	rwlock_init(&sess->chann_lock);
 
 	switch (protocol) {
 	case CIFDS_SESSION_FLAG_SMB2:
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index 8b08189be3fc2..1ec659f0151bf 100644
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -48,6 +48,7 @@ struct ksmbd_session {
 	char				sess_key[CIFS_KEY_SIZE];
 
 	struct hlist_node		hlist;
+	rwlock_t			chann_lock;
 	struct list_head		ksmbd_chann_list;
 	struct xarray			tree_conns;
 	struct ida			tree_conn_ida;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d41995f89befe..e17f7a5dd9974 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1525,7 +1525,9 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 
 binding_session:
 	if (conn->dialect >= SMB30_PROT_ID) {
+		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
+		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
@@ -1533,7 +1535,9 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 
 			chann->conn = conn;
 			INIT_LIST_HEAD(&chann->chann_list);
+			write_lock(&sess->chann_lock);
 			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
+			write_unlock(&sess->chann_lock);
 		}
 	}
 
@@ -1608,7 +1612,9 @@ static int krb5_authenticate(struct ksmbd_work *work)
 	}
 
 	if (conn->dialect >= SMB30_PROT_ID) {
+		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
+		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
@@ -1616,7 +1622,9 @@ static int krb5_authenticate(struct ksmbd_work *work)
 
 			chann->conn = conn;
 			INIT_LIST_HEAD(&chann->chann_list);
+			write_lock(&sess->chann_lock);
 			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
+			write_unlock(&sess->chann_lock);
 		}
 	}
 
@@ -8388,10 +8396,14 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
+		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, conn);
-		if (!chann)
+		if (!chann) {
+			read_unlock(&work->sess->chann_lock);
 			return 0;
+		}
 		signing_key = chann->smb3signingkey;
+		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key) {
@@ -8451,10 +8463,14 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 	    le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
+		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, work->conn);
-		if (!chann)
+		if (!chann) {
+			read_unlock(&work->sess->chann_lock);
 			return;
+		}
 		signing_key = chann->smb3signingkey;
+		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key)
-- 
2.39.2



