Return-Path: <stable+bounces-7700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5058175DC
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258111C24E70
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037FD5D751;
	Mon, 18 Dec 2023 15:39:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954215D74E
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso2629104a12.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913950; x=1703518750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQvoely9Hh5SC4u8m618gthPbSNuHHW+Cnk8FqNFIlo=;
        b=EJdu7dDkOUeaIN03l7za681rwlTIvSYLhJ3ulJ1hiJsi0dEWnwvbQX9WYCkcFMrqwU
         xuyT2NRD7ivVjLW0zbKowukto7TUPRRbJfN3h/jueyXX0Osf5YynQMqD4G6SDXZUYoMx
         Je2utWnQwFF3WovlMT7tlRqG2H66hn2f6S3eYDceGMvuqqvUTs0jF5lglqxyVKRRUSHv
         beYVjlCbaytCHc03hBmf5AkrFBGCwJR6fNH/z5v2SSm9iIXQr2JKKtdOp2H7lO1bdJJW
         5ybocFKjpgCUpXxWr/+3C+xwVLr1lR+1MV7vVSdgy/Fl7jrFTSXCbAJ+A/Ywl8YImMTj
         oCIg==
X-Gm-Message-State: AOJu0YxMx/usKlA1veqUvjwK3DWjpHgFz6WMCnzhfM+n5/p7+6Bpd9M8
	h1Fv3i1pt+TYUuRc50xi3/k=
X-Google-Smtp-Source: AGHT+IEPwllR39P/DdFW4g9op+1gssz8GG5nwoGZUak32CQL6oDC2t2vnKgXV8HjfZan+2L2e16kAA==
X-Received: by 2002:a17:90a:928a:b0:28a:352a:e17b with SMTP id n10-20020a17090a928a00b0028a352ae17bmr10304902pjo.53.1702913949966;
        Mon, 18 Dec 2023 07:39:09 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:09 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Dawei Li <set_pte_at@outlook.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 071/154] ksmbd: Implements sess->rpc_handle_list as xarray
Date: Tue, 19 Dec 2023 00:33:31 +0900
Message-Id: <20231218153454.8090-72-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dawei Li <set_pte_at@outlook.com>

[ Upstream commit b685757c7b08d5073046fb379be965fd6c06aafc ]

For some ops on rpc handle:
1. ksmbd_session_rpc_method(), possibly on high frequency.
2. ksmbd_session_rpc_close().

id is used as indexing key to lookup channel, in that case,
linear search based on list may suffer a bit for performance.

Implements sess->rpc_handle_list as xarray.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/mgmt/user_session.c | 37 ++++++++++++++----------------------
 fs/ksmbd/mgmt/user_session.h |  2 +-
 2 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index a2b128dedcfc..1ca2aae4c299 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -25,7 +25,6 @@ static DECLARE_RWSEM(sessions_table_lock);
 struct ksmbd_session_rpc {
 	int			id;
 	unsigned int		method;
-	struct list_head	list;
 };
 
 static void free_channel_list(struct ksmbd_session *sess)
@@ -58,15 +57,14 @@ static void __session_rpc_close(struct ksmbd_session *sess,
 static void ksmbd_session_rpc_clear_list(struct ksmbd_session *sess)
 {
 	struct ksmbd_session_rpc *entry;
+	long index;
 
-	while (!list_empty(&sess->rpc_handle_list)) {
-		entry = list_entry(sess->rpc_handle_list.next,
-				   struct ksmbd_session_rpc,
-				   list);
-
-		list_del(&entry->list);
+	xa_for_each(&sess->rpc_handle_list, index, entry) {
+		xa_erase(&sess->rpc_handle_list, index);
 		__session_rpc_close(sess, entry);
 	}
+
+	xa_destroy(&sess->rpc_handle_list);
 }
 
 static int __rpc_method(char *rpc_name)
@@ -102,13 +100,13 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 
 	entry = kzalloc(sizeof(struct ksmbd_session_rpc), GFP_KERNEL);
 	if (!entry)
-		return -EINVAL;
+		return -ENOMEM;
 
-	list_add(&entry->list, &sess->rpc_handle_list);
 	entry->method = method;
 	entry->id = ksmbd_ipc_id_alloc();
 	if (entry->id < 0)
 		goto free_entry;
+	xa_store(&sess->rpc_handle_list, entry->id, entry, GFP_KERNEL);
 
 	resp = ksmbd_rpc_open(sess, entry->id);
 	if (!resp)
@@ -117,9 +115,9 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 	kvfree(resp);
 	return entry->id;
 free_id:
+	xa_erase(&sess->rpc_handle_list, entry->id);
 	ksmbd_rpc_id_free(entry->id);
 free_entry:
-	list_del(&entry->list);
 	kfree(entry);
 	return -EINVAL;
 }
@@ -128,24 +126,17 @@ void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id)
 {
 	struct ksmbd_session_rpc *entry;
 
-	list_for_each_entry(entry, &sess->rpc_handle_list, list) {
-		if (entry->id == id) {
-			list_del(&entry->list);
-			__session_rpc_close(sess, entry);
-			break;
-		}
-	}
+	entry = xa_erase(&sess->rpc_handle_list, id);
+	if (entry)
+		__session_rpc_close(sess, entry);
 }
 
 int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id)
 {
 	struct ksmbd_session_rpc *entry;
 
-	list_for_each_entry(entry, &sess->rpc_handle_list, list) {
-		if (entry->id == id)
-			return entry->method;
-	}
-	return 0;
+	entry = xa_load(&sess->rpc_handle_list, id);
+	return entry ? entry->method : 0;
 }
 
 void ksmbd_session_destroy(struct ksmbd_session *sess)
@@ -327,7 +318,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	set_session_flag(sess, protocol);
 	xa_init(&sess->tree_conns);
 	xa_init(&sess->ksmbd_chann_list);
-	INIT_LIST_HEAD(&sess->rpc_handle_list);
+	xa_init(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
 
 	ret = __init_smb2_session(sess);
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index 44a3c67b2bd9..b6a9e7a6aae4 100644
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -52,7 +52,7 @@ struct ksmbd_session {
 	struct xarray			ksmbd_chann_list;
 	struct xarray			tree_conns;
 	struct ida			tree_conn_ida;
-	struct list_head		rpc_handle_list;
+	struct xarray			rpc_handle_list;
 
 	__u8				smb3encryptionkey[SMB3_ENC_DEC_KEY_SIZE];
 	__u8				smb3decryptionkey[SMB3_ENC_DEC_KEY_SIZE];
-- 
2.25.1


