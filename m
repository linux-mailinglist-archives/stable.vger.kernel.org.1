Return-Path: <stable+bounces-7751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0073E81761A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256F11C25268
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B10774E05;
	Mon, 18 Dec 2023 15:41:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231AC74E07
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b7df7d14dso1142234a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914113; x=1703518913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNjOPKHL0dQgakoG38Tw/YQZ7wdpRmmcKUwjiXgrJe4=;
        b=SZJeRop19hN06ARtpzd2P6TLYcQISMlSSQ41PgCccgZvFhlgRN04Jm3u619HIWP54S
         diESTcjRcppha8tKnFiLoSTENuExwrtcGWNEy/UAN9G7FptpKdbs1L7liAPYmTv5Dsgo
         Re3CV9afnCHQrXr4kgBesxqLe3fCQVECY1U8S2py5BdTwUbSa9RDugDzUyZjPoAMrGq/
         eVb8tfyY9Os7zdkispEpCRwnc4r4Y/cBmp0G+YcHl9q7oGE89ijZX1Ykf7tDkZ9knHyu
         zZL4fS8/HfDeDLFvy5WnR/W9NCCRl84QCZe1SASV/2i8QENxyoEAOdPbKjBCOLrqooLE
         E3zw==
X-Gm-Message-State: AOJu0Yypwc9U6QB7cRGTLs5VzffW1Qz545Z55bM81ezs9C515UJ3h6Oj
	o13b5tqoevwfqcrhaM8pjXc=
X-Google-Smtp-Source: AGHT+IG8FzdKM/PyTBBNt1ODe3KIe8nB7ki6Qd1isH60mcOY/VDR26tY/WLfKp4y9iEDNaDPdwipxg==
X-Received: by 2002:a17:90a:2a4b:b0:28b:313a:749e with SMTP id d11-20020a17090a2a4b00b0028b313a749emr2772764pjg.45.1702914113395;
        Mon, 18 Dec 2023 07:41:53 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:53 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 122/154] ksmbd: reduce descriptor size if remaining bytes is less than request size
Date: Tue, 19 Dec 2023 00:34:22 +0900
Message-Id: <20231218153454.8090-123-linkinjeon@kernel.org>
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

[ Upstream commit e628bf939aafb61fbc56e9bdac8795cea5127e25 ]

Create 3 kinds of files to reproduce this problem.

dd if=/dev/urandom of=127k.bin bs=1024 count=127
dd if=/dev/urandom of=128k.bin bs=1024 count=128
dd if=/dev/urandom of=129k.bin bs=1024 count=129

When copying files from ksmbd share to windows or cifs.ko, The following
error message happen from windows client.

"The file '129k.bin' is too large for the destination filesystem."

We can see the error logs from ksmbd debug prints

[48394.611537] ksmbd: RDMA r/w request 0x0: token 0x669d, length 0x20000
[48394.612054] ksmbd: smb_direct: RDMA write, len 0x20000, needed credits 0x1
[48394.612572] ksmbd: filename 129k.bin, offset 131072, len 131072
[48394.614189] ksmbd: nbytes 1024, offset 132096 mincount 0
[48394.614585] ksmbd: Failed to process 8 [-22]

And we can reproduce it with cifs.ko,
e.g. dd if=129k.bin of=/dev/null bs=128KB count=2

This problem is that ksmbd rdma return error if remaining bytes is less
than Length of Buffer Descriptor V1 Structure.

smb_direct_rdma_xmit()
...
     if (desc_buf_len == 0 || total_length > buf_len ||
           total_length > t->max_rdma_rw_size)
               return -EINVAL;

This patch reduce descriptor size with remaining bytes and remove the
check for total_length and buf_len.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_rdma.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 3e0fd0f50b7f..80765bbe8efc 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -1364,24 +1364,35 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
 	LIST_HEAD(msg_list);
 	char *desc_buf;
 	int credits_needed;
-	unsigned int desc_buf_len;
-	size_t total_length = 0;
+	unsigned int desc_buf_len, desc_num = 0;
 
 	if (t->status != SMB_DIRECT_CS_CONNECTED)
 		return -ENOTCONN;
 
+	if (buf_len > t->max_rdma_rw_size)
+		return -EINVAL;
+
 	/* calculate needed credits */
 	credits_needed = 0;
 	desc_buf = buf;
 	for (i = 0; i < desc_len / sizeof(*desc); i++) {
+		if (!buf_len)
+			break;
+
 		desc_buf_len = le32_to_cpu(desc[i].length);
+		if (!desc_buf_len)
+			return -EINVAL;
+
+		if (desc_buf_len > buf_len) {
+			desc_buf_len = buf_len;
+			desc[i].length = cpu_to_le32(desc_buf_len);
+			buf_len = 0;
+		}
 
 		credits_needed += calc_rw_credits(t, desc_buf, desc_buf_len);
 		desc_buf += desc_buf_len;
-		total_length += desc_buf_len;
-		if (desc_buf_len == 0 || total_length > buf_len ||
-		    total_length > t->max_rdma_rw_size)
-			return -EINVAL;
+		buf_len -= desc_buf_len;
+		desc_num++;
 	}
 
 	ksmbd_debug(RDMA, "RDMA %s, len %#x, needed credits %#x\n",
@@ -1393,7 +1404,7 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
 
 	/* build rdma_rw_ctx for each descriptor */
 	desc_buf = buf;
-	for (i = 0; i < desc_len / sizeof(*desc); i++) {
+	for (i = 0; i < desc_num; i++) {
 		msg = kzalloc(offsetof(struct smb_direct_rdma_rw_msg, sg_list) +
 			      sizeof(struct scatterlist) * SG_CHUNK_SIZE, GFP_KERNEL);
 		if (!msg) {
-- 
2.25.1


