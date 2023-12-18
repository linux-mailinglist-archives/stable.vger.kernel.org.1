Return-Path: <stable+bounces-7782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A09F81763D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A212E1C25389
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FEA4FF7B;
	Mon, 18 Dec 2023 15:43:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB455A846
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b4d7bf8bdso634954a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914217; x=1703519017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqMJSqK/OSRn8iXRoNfdEL6dVqMsMDjH0zxto/F8QhQ=;
        b=IwXswc93mb0PpvZ2f3U34AWRsaxd1EaVZtCMS66VDa/vHo7nAz6EWPpHwM6gdpPBAe
         kXILvKXlvJTC18OH6yZNe7wsEF6FLzlHnEQnXlZw/Ha6ogwpvyixvS4TK0VBwUkqCp86
         ARMF+fT+3QaS9o8rvBiE5HhG8HogleZcX3lvOjY2YYHQCO5+WKf5vRjw4CYLmvBR3xqT
         GAeJeTriGvdHurQHmTH2SOOtnjOe7sPGUbpXXGjKwzLRS1jTN2MgCb9xUSvaKmAI+w4G
         wbzxfO/LcNd/WTMdS336W85z2+dwXF/qYrnUvm/MMW9DkiCGgcoiR77s0bRX75uTKoBZ
         rPbg==
X-Gm-Message-State: AOJu0YxQd0TuWOUWzpbWyfeJ3VEGbm08QqTGtgWntKyYNFosIKtPpL5H
	Lwo5U+aGKJzAexnM79CRSDo=
X-Google-Smtp-Source: AGHT+IH3s6ZdhFjpRG6lufV5sHxP772G1eNYlEbvt4KKGDv5OSQMCeuNNdOhawBESkAeNf6T7bGZCw==
X-Received: by 2002:a17:90b:ed1:b0:28b:68fa:f460 with SMTP id gz17-20020a17090b0ed100b0028b68faf460mr873239pjb.6.1702914217443;
        Mon, 18 Dec 2023 07:43:37 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:43:37 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 153/154] ksmbd: move setting SMB2_FLAGS_ASYNC_COMMAND and AsyncId
Date: Tue, 19 Dec 2023 00:34:53 +0900
Message-Id: <20231218153454.8090-154-linkinjeon@kernel.org>
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

[ Upstream commit 9ac45ac7cf65b0623ceeab9b28b307a08efa22dc ]

Directly set SMB2_FLAGS_ASYNC_COMMAND flags and AsyncId in smb2 header of
interim response instead of current response header.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 73eb3ea6441b..2b990ed35fde 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -658,13 +658,9 @@ smb2_get_name(const char *src, const int maxlen, struct nls_table *local_nls)
 
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
@@ -672,7 +668,6 @@ int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 	}
 	work->asynchronous = true;
 	work->async_id = id;
-	rsp_hdr->Id.AsyncId = cpu_to_le64(id);
 
 	ksmbd_debug(SMB,
 		    "Send interim Response to inform async request id : %d\n",
@@ -724,6 +719,8 @@ void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
 	       __SMB2_HEADER_STRUCTURE_SIZE);
 
 	rsp_hdr = smb2_get_msg(in_work->response_buf);
+	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
+	rsp_hdr->Id.AsyncId = cpu_to_le64(work->async_id);
 	smb2_set_err_rsp(in_work);
 	rsp_hdr->Status = status;
 
-- 
2.25.1


