Return-Path: <stable+bounces-9120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CD1820A4A
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C731C21559
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE3A17F4;
	Sun, 31 Dec 2023 07:20:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96556D6F5
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6dc049c7b58so2502838a34.3
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007220; x=1704612020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1H2BZIiUKV7j1jBZyGfiI/AJZ3rHtJZDntt5+I1A9+4=;
        b=itcIBTKJ6f6+xG10nAkNetkjJlvTUXQ8nwBtm2Wu53UFh2vOyJxKiQx7b9S6RGWHaA
         41EdDwb5KG5IiYMAiKki7aBaw3KYOkolvDupCmV1/UhsNugiHVqy72Rw/5JyokBUNL4L
         o1PUlTtk4gLVOMUAhIajM1MQFeJuurnk+otd4/uPj6UyLLd0yuJ+kMaoWfYqEIQNDG7G
         NFYArzJ30uW6d8b4hx+mraa0GYPuJHI5MsKuHaLwGI1JeN+GFk5TPeV6YJoXmyRDeOsj
         yOkFT0TOIPHBqyE2euRTFYJRPdpSzAYeZk8Lz3nmObFryiYkNtXz0WBx+uolQs4LBF9N
         KfjA==
X-Gm-Message-State: AOJu0YyvzmXcgutV6B9jv45mDyPBo33uWfB6ev5w9LTb3Ujo2uq3mGDL
	Dr1Uzrz/le7M5mCtqoDKAIY=
X-Google-Smtp-Source: AGHT+IEU8/aLeOJvm81iJWW7p8WgSnVe+4tDhx2RdXfekfwGXtPyHVRuT/YX7HHuZEMRurW2nrjFXQ==
X-Received: by 2002:a05:6808:2e4b:b0:3bb:bfc9:2204 with SMTP id gp11-20020a0568082e4b00b003bbbfc92204mr12157320oib.105.1704007219896;
        Sat, 30 Dec 2023 23:20:19 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm17425312pgj.32.2023.12.30.23.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:20:19 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 12/19] ksmbd: move setting SMB2_FLAGS_ASYNC_COMMAND and AsyncId
Date: Sun, 31 Dec 2023 16:19:12 +0900
Message-Id: <20231231071919.32103-13-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071919.32103-1-linkinjeon@kernel.org>
References: <20231231071919.32103-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 9ac45ac7cf65b0623ceeab9b28b307a08efa22dc ]

Directly set SMB2_FLAGS_ASYNC_COMMAND flags and AsyncId in smb2 header of
interim response instead of current response header.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index e58504d0e9c1..de71532651d9 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -657,13 +657,9 @@ smb2_get_name(const char *src, const int maxlen, struct nls_table *local_nls)
 
 int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 {
-	struct smb2_hdr *rsp_hdr;
 	struct ksmbd_conn *conn = work->conn;
 	int id;
 
-	rsp_hdr = ksmbd_resp_buf_next(work);
-	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
-
 	id = ksmbd_acquire_async_msg_id(&conn->async_ida);
 	if (id < 0) {
 		pr_err("Failed to alloc async message id\n");
@@ -671,7 +667,6 @@ int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 	}
 	work->asynchronous = true;
 	work->async_id = id;
-	rsp_hdr->Id.AsyncId = cpu_to_le64(id);
 
 	ksmbd_debug(SMB,
 		    "Send interim Response to inform async request id : %d\n",
@@ -723,6 +718,8 @@ void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
 	       __SMB2_HEADER_STRUCTURE_SIZE);
 
 	rsp_hdr = smb2_get_msg(in_work->response_buf);
+	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
+	rsp_hdr->Id.AsyncId = cpu_to_le64(work->async_id);
 	smb2_set_err_rsp(in_work);
 	rsp_hdr->Status = status;
 
-- 
2.25.1


