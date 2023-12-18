Return-Path: <stable+bounces-7701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9D98175DD
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810471C24F73
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FB75D75D;
	Mon, 18 Dec 2023 15:39:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBAE5D753
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d39e2f1089so16489945ad.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913953; x=1703518753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDGgDRyXy5rhN9g4KZaxwmDXPjVjiH27WTxMACYKUTI=;
        b=ZcPw8LD+dmiBzEODfPLDn9rMQzHYd9+KCBTfHtht72lrSqQNmi3ZJ+R6vqPD/Dea0k
         glMPcm1CzRl927zYIupRmsQfe3f5uz71r3dzfSF1wYQZJshDaO6YWbqph7c3t5M5D2xV
         Xp1vZ8ucmDUfbib6Yf25rVbQ+GIgwWoflhYQ30LzZKbMN12DvUxEEjzd7QdpnsxvyhOU
         gJ6VF22XDRUXwTZUYmhoJo4ct1xnEXJ4ifm4t+SwajyjBxyGIFLgS9KAWno0+qqEGckR
         p8ymTBglP3ep1qNoB9aBp6hWICrUp2HqzUMeYsx+pNxqvAYkZQ8ffLhp5zri0T0+sNjl
         KT/A==
X-Gm-Message-State: AOJu0YxUdLTaL6IrbIdyMbhbE9U4R6I4YymwPFjKOnIgepnfg1H9dzA6
	lz85DGnepprbRUVuGtPiXPk=
X-Google-Smtp-Source: AGHT+IEOfquMY41WKu7vmfX03yiUfvhlDmzKJOHfPwQLWDGjmQKCj9/QC4fjoMrzrxPsHqROisCEYw==
X-Received: by 2002:a17:90a:b288:b0:286:6cc0:cad3 with SMTP id c8-20020a17090ab28800b002866cc0cad3mr10771363pjr.74.1702913953092;
        Mon, 18 Dec 2023 07:39:13 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:12 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Dawei Li <set_pte_at@outlook.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 072/154] ksmbd: fix typo, syncronous->synchronous
Date: Tue, 19 Dec 2023 00:33:32 +0900
Message-Id: <20231218153454.8090-73-linkinjeon@kernel.org>
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

[ Upstream commit f8d6e7442aa716a233c7eba99dec628f8885e00b ]

syncronous->synchronous

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/connection.c | 4 ++--
 fs/ksmbd/ksmbd_work.h | 2 +-
 fs/ksmbd/smb2pdu.c    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 14326323da79..9ed669d58742 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -114,7 +114,7 @@ void ksmbd_conn_enqueue_request(struct ksmbd_work *work)
 
 	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL_HE) {
 		requests_queue = &conn->requests;
-		work->syncronous = true;
+		work->synchronous = true;
 	}
 
 	if (requests_queue) {
@@ -139,7 +139,7 @@ int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work)
 	spin_lock(&conn->request_lock);
 	if (!work->multiRsp) {
 		list_del_init(&work->request_entry);
-		if (work->syncronous == false)
+		if (!work->synchronous)
 			list_del_init(&work->async_request_entry);
 		ret = 0;
 	}
diff --git a/fs/ksmbd/ksmbd_work.h b/fs/ksmbd/ksmbd_work.h
index 5ece58e40c97..3234f2cf6327 100644
--- a/fs/ksmbd/ksmbd_work.h
+++ b/fs/ksmbd/ksmbd_work.h
@@ -68,7 +68,7 @@ struct ksmbd_work {
 	/* Request is encrypted */
 	bool                            encrypted:1;
 	/* Is this SYNC or ASYNC ksmbd_work */
-	bool                            syncronous:1;
+	bool                            synchronous:1;
 	bool                            need_invalidate_rkey:1;
 
 	unsigned int                    remote_key;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 8c0872074d1b..294de8d5e19c 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -512,7 +512,7 @@ int init_smb2_rsp_hdr(struct ksmbd_work *work)
 	rsp_hdr->SessionId = rcv_hdr->SessionId;
 	memcpy(rsp_hdr->Signature, rcv_hdr->Signature, 16);
 
-	work->syncronous = true;
+	work->synchronous = true;
 	if (work->async_id) {
 		ksmbd_release_id(&conn->async_ida, work->async_id);
 		work->async_id = 0;
@@ -675,7 +675,7 @@ int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 		pr_err("Failed to alloc async message id\n");
 		return id;
 	}
-	work->syncronous = false;
+	work->synchronous = false;
 	work->async_id = id;
 	rsp_hdr->Id.AsyncId = cpu_to_le64(id);
 
-- 
2.25.1


