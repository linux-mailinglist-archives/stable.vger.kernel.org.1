Return-Path: <stable+bounces-9041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACC88209FA
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A805282EA9
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E76817C2;
	Sun, 31 Dec 2023 07:14:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A86D6EF
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58e256505f7so5041995eaf.3
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006848; x=1704611648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSUe6cWbzN9fbT/SsZHm9/bQZ68iXWd2JITaulptyWc=;
        b=UHrYpi5/FdoQDwIi69uhbyEkhlKgTmLfcJ5w+N4CdEFTVG7QB/wzWkShRp4tP8Hhqz
         Wq0Zc2H3+fkRSvt41yoyKCei4pXDhiVlTBhf0bg04gbEjvwzp6rTo1C1kFzW4/rczREK
         WnZw0VcNXJcaDF/zWKWyrTqHI5IZIRKskMNtnwp5Rc6jqfE8l+D8Mfv1rnml53iaaaxO
         wXxxJ4uIy7iI68CRDbLOE6kZID41PIg+wGYQnlctBE1AIvDDvUQ+Cw0R40F8qh5GyBe1
         Gi7MjoWemaaKgWwelLOltnHp+Mv5qr+6irSn8Q9SZ6YNVI0DIL7Pr1c26GE2iqfzCBVr
         7NRA==
X-Gm-Message-State: AOJu0YyuywcM5XG14lE9HncX48LV77W2j3IXINa5/KeBZ1e3hGNgXdcO
	pguhqt/DysKUeG+HLQcjAIQ=
X-Google-Smtp-Source: AGHT+IGYJxhVe4urR4o39+jb1GrvEMzjCd51P+2zF/geVO0uuSuUjejn43jfxTL+h5wFcrra8cD7eA==
X-Received: by 2002:a05:6871:2b01:b0:1fa:edc2:892e with SMTP id dr1-20020a0568712b0100b001faedc2892emr16168923oac.11.1704006848147;
        Sat, 30 Dec 2023 23:14:08 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:07 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Dawei Li <set_pte_at@outlook.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 07/73] ksmbd: fix typo, syncronous->synchronous
Date: Sun, 31 Dec 2023 16:12:26 +0900
Message-Id: <20231231071332.31724-8-linkinjeon@kernel.org>
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

[ Upstream commit f8d6e7442aa716a233c7eba99dec628f8885e00b ]

syncronous->synchronous

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/connection.c | 4 ++--
 fs/smb/server/ksmbd_work.h | 2 +-
 fs/smb/server/smb2pdu.c    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index ff97cad8d5b4..e885e0eb0dc3 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -116,7 +116,7 @@ void ksmbd_conn_enqueue_request(struct ksmbd_work *work)
 
 	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL_HE) {
 		requests_queue = &conn->requests;
-		work->syncronous = true;
+		work->synchronous = true;
 	}
 
 	if (requests_queue) {
@@ -141,7 +141,7 @@ int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work)
 	spin_lock(&conn->request_lock);
 	if (!work->multiRsp) {
 		list_del_init(&work->request_entry);
-		if (work->syncronous == false)
+		if (!work->synchronous)
 			list_del_init(&work->async_request_entry);
 		ret = 0;
 	}
diff --git a/fs/smb/server/ksmbd_work.h b/fs/smb/server/ksmbd_work.h
index 5ece58e40c97..3234f2cf6327 100644
--- a/fs/smb/server/ksmbd_work.h
+++ b/fs/smb/server/ksmbd_work.h
@@ -68,7 +68,7 @@ struct ksmbd_work {
 	/* Request is encrypted */
 	bool                            encrypted:1;
 	/* Is this SYNC or ASYNC ksmbd_work */
-	bool                            syncronous:1;
+	bool                            synchronous:1;
 	bool                            need_invalidate_rkey:1;
 
 	unsigned int                    remote_key;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 21d0416f1101..d3939fd48149 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -508,7 +508,7 @@ int init_smb2_rsp_hdr(struct ksmbd_work *work)
 	rsp_hdr->SessionId = rcv_hdr->SessionId;
 	memcpy(rsp_hdr->Signature, rcv_hdr->Signature, 16);
 
-	work->syncronous = true;
+	work->synchronous = true;
 	if (work->async_id) {
 		ksmbd_release_id(&conn->async_ida, work->async_id);
 		work->async_id = 0;
@@ -671,7 +671,7 @@ int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 		pr_err("Failed to alloc async message id\n");
 		return id;
 	}
-	work->syncronous = false;
+	work->synchronous = false;
 	work->async_id = id;
 	rsp_hdr->Id.AsyncId = cpu_to_le64(id);
 
-- 
2.25.1


