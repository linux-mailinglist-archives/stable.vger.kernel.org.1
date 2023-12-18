Return-Path: <stable+bounces-7660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C57C8175A8
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F7F283C6F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ADD498BF;
	Mon, 18 Dec 2023 15:37:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C66B4FF66
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c701bd98f3so1080155a12.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913826; x=1703518626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhQSN086viISrQ4EgXus4bbMPqPJ1HGaKWP/K7UhSEE=;
        b=lOtbmsrRHvaFRSslLbLXND/zN12LIL6qbMwy7g5hUiZSx+V4jXvIcZCHektPkJVEjH
         0pmUl8TQc3JAqymje0i/w2OJqNS77HfXcoCOPaxTozMdNl16XZOkVoNjGNRuskL3vB2D
         UMUsYjFxA136Zj/rSR8sgKi6UauE5lDgaFxR7l77uYaxq+mhouYHrqy0CeRWNY71WtaO
         HwdViavVZD9+8ESxjCw40p2Fie7orHwZ5sBDq/a44fbOBZcPkOb/q/swEFES0Vsnx59k
         3Kglb/+Txrl5cemJ6yOQNjKsewfcUrHph4gJH0sjmnQ1nScB2jQFkqOl02ryfrRqVKf8
         w4kg==
X-Gm-Message-State: AOJu0YzrrWil/Pp1Z/p8taqWMjx1vwZYapXC0C+Jczl7k25sjtTSdXGX
	CioW/eG6CLuG3+Tvb3MdyvI=
X-Google-Smtp-Source: AGHT+IHPXJxQhu1t6gIxnCw3veahfiBVcKWqEGEFgFnajr5LfmUO6YLps1BIvPvdAwoYCjlZgQQPDQ==
X-Received: by 2002:a17:90a:49cd:b0:28b:750a:8f81 with SMTP id l13-20020a17090a49cd00b0028b750a8f81mr702012pjm.41.1702913825608;
        Mon, 18 Dec 2023 07:37:05 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:04 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 032/154] ksmbd: validate length in smb2_write()
Date: Tue, 19 Dec 2023 00:32:52 +0900
Message-Id: <20231218153454.8090-33-linkinjeon@kernel.org>
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

[ Upstream commit 158a66b245739e15858de42c0ba60fcf3de9b8e6 ]

The SMB2 Write packet contains data that is to be written
to a file or to a pipe. Depending on the client, there may
be padding between the header and the data field.
Currently, the length is validated only in the case padding
is present.

Since the DataOffset field always points to the beginning
of the data, there is no need to have a special case for
padding. By removing this, the length is validated in both
cases.

Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index a1bcb822c95d..134a725332a0 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6410,23 +6410,18 @@ static noinline int smb2_write_pipe(struct ksmbd_work *work)
 	length = le32_to_cpu(req->Length);
 	id = req->VolatileFileId;
 
-	if (le16_to_cpu(req->DataOffset) ==
-	    offsetof(struct smb2_write_req, Buffer)) {
-		data_buf = (char *)&req->Buffer[0];
-	} else {
-		if ((u64)le16_to_cpu(req->DataOffset) + length >
-		    get_rfc1002_len(work->request_buf)) {
-			pr_err("invalid write data offset %u, smb_len %u\n",
-			       le16_to_cpu(req->DataOffset),
-			       get_rfc1002_len(work->request_buf));
-			err = -EINVAL;
-			goto out;
-		}
-
-		data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
-				le16_to_cpu(req->DataOffset));
+	if ((u64)le16_to_cpu(req->DataOffset) + length >
+	    get_rfc1002_len(work->request_buf)) {
+		pr_err("invalid write data offset %u, smb_len %u\n",
+		       le16_to_cpu(req->DataOffset),
+		       get_rfc1002_len(work->request_buf));
+		err = -EINVAL;
+		goto out;
 	}
 
+	data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
+			   le16_to_cpu(req->DataOffset));
+
 	rpc_resp = ksmbd_rpc_write(work->sess, id, data_buf, length);
 	if (rpc_resp) {
 		if (rpc_resp->flags == KSMBD_RPC_ENOTIMPLEMENTED) {
@@ -6571,20 +6566,15 @@ int smb2_write(struct ksmbd_work *work)
 
 	if (req->Channel != SMB2_CHANNEL_RDMA_V1 &&
 	    req->Channel != SMB2_CHANNEL_RDMA_V1_INVALIDATE) {
-		if (le16_to_cpu(req->DataOffset) ==
+		if (le16_to_cpu(req->DataOffset) <
 		    offsetof(struct smb2_write_req, Buffer)) {
-			data_buf = (char *)&req->Buffer[0];
-		} else {
-			if (le16_to_cpu(req->DataOffset) <
-			    offsetof(struct smb2_write_req, Buffer)) {
-				err = -EINVAL;
-				goto out;
-			}
-
-			data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
-					le16_to_cpu(req->DataOffset));
+			err = -EINVAL;
+			goto out;
 		}
 
+		data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
+				    le16_to_cpu(req->DataOffset));
+
 		ksmbd_debug(SMB, "flags %u\n", le32_to_cpu(req->Flags));
 		if (le32_to_cpu(req->Flags) & SMB2_WRITEFLAG_WRITE_THROUGH)
 			writethrough = true;
-- 
2.25.1


