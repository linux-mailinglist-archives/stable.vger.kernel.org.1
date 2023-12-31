Return-Path: <stable+bounces-9040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 733478209F9
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CDC1F21FE3
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFE017F4;
	Sun, 31 Dec 2023 07:14:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1188917C2
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so6269263a12.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006844; x=1704611644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCqyEn+Yo79wXrLZDIg/RoYVpqLgfx26N5V/ZH7hD/M=;
        b=mjzScZEWJEzXxq7s4SwP4RMvKAzFRDG6FCei23VAPbp6RrCqnaqy92GaA1QCHp3T+e
         RZNXh7G7yI7JiK5CFw+C1QzffLgyFD+YRgKbhqSxO+WuBXjagj7NMbuZiyhC16dggXpz
         T69IiJV0rmk1ixKq2aa5NdvN+H9PxuiNuKn2tu9aXffaoBF8PUQ0u5eanJFu4lgRKITe
         Si9rzGI9mM1pifO3oRJD9pf3y1CLBa+z/Vtx8wMCfaV4C9oo+nZU7Nwcta9Mndh6Oy3i
         dwTOxuB2dHWGd3a3pQ5d+P/xGQ1hWdW/tvNVJ1WyjqBE/rVf0mGTUNkCSjpxRz3mbgRC
         Hy3w==
X-Gm-Message-State: AOJu0YwMnFVdw9zFVIzj66Ggpbkm4qZ2r85IE6kTdVOVqMWf9j3RPUlB
	mrmCgMajy0fBWUhu/enArPs=
X-Google-Smtp-Source: AGHT+IHikvnqdpw1fR8YJ7pGdH6pbjYPkGdjO5FNfVYjP9qHKLazMfzw07zB9nMh/I95mwj6Gjn1Pw==
X-Received: by 2002:a05:6a20:4322:b0:195:74dd:eb7b with SMTP id h34-20020a056a20432200b0019574ddeb7bmr14599604pzk.103.1704006844248;
        Sat, 30 Dec 2023 23:14:04 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:03 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Dawei Li <set_pte_at@outlook.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 06/73] ksmbd: Implements sess->rpc_handle_list as xarray
Date: Sun, 31 Dec 2023 16:12:25 +0900
Message-Id: <20231231071332.31724-7-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071332.31724-1-linkinjeon@kernel.org>
References: <20231231071332.31724-1-linkinjeon@kernel.org>
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
 fs/smb/server/mgmt/user_session.c | 37 ++++++++++++-------------------
 fs/smb/server/mgmt/user_session.h |  2 +-
 2 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index cf6621e21ba3..b8be14a96cf6 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
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
@@ -362,7 +353,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	set_session_flag(sess, protocol);
 	xa_init(&sess->tree_conns);
 	xa_init(&sess->ksmbd_chann_list);
-	INIT_LIST_HEAD(&sess->rpc_handle_list);
+	xa_init(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
 
 	ret = __init_smb2_session(sess);
diff --git a/fs/smb/server/mgmt/user_session.h b/fs/smb/server/mgmt/user_session.h
index 51f38e5b61ab..f99d475b28db 100644
--- a/fs/smb/server/mgmt/user_session.h
+++ b/fs/smb/server/mgmt/user_session.h
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


