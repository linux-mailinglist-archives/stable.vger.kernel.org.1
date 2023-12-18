Return-Path: <stable+bounces-7651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C15D817590
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35FA1C24C5C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6329972074;
	Mon, 18 Dec 2023 15:36:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60172042
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28b4e6579a9so622775a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913792; x=1703518592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY9buF8qYAujBsSnALRkjI4l6438w+pdJTtuP7a+vuM=;
        b=K9BBp/TZK407BXhZIHYDrrw21/iBJIqiogbpKJCYCbUx+EpmKI0vByYZH2f9tbGlpl
         4i8QABi9dsMLC0lkvP5KOzskim6LhNvCDUjp3E5JN2O97M4n4w5Yy8TcW69bHdyA+WK9
         3NRY1Y7VWUKZijM3CMbLCv+dJmWkqKtX4OJD20BbxbI68PcxhC+QxwjWBxs//UCJQKIv
         3jVFpK3nZtqQZ7aI+e1C2g6KknZyv0kArlzRKfrOpH0fH6qxLm3CVqFlQOrN7muLhOfO
         VZF+L4axx8R0x668uzIOXnEEG3qTwietcc5c8c/APJ4FWmCj1NuigXyUgdMPHe7FNo3g
         d4Og==
X-Gm-Message-State: AOJu0YwBsXR0Y5YGa3o8Mph6hO4GMvki/IIQuXwz8TpRuZvsVCV7Rksm
	4nr42aRf7HkbhwWpMkYABQg=
X-Google-Smtp-Source: AGHT+IErKlNjOMzK3pivchV4SmxA14/VpDPoyNz7UDz6Kj5SHtrnRfV/juFJrnkZSl2mW05epZN2pA==
X-Received: by 2002:a17:90b:37cf:b0:28b:1868:9924 with SMTP id nc15-20020a17090b37cf00b0028b18689924mr2296739pjb.64.1702913791592;
        Mon, 18 Dec 2023 07:36:31 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:31 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 022/154] ksmbd: smbd: fix missing client's memory region invalidation
Date: Tue, 19 Dec 2023 00:32:42 +0900
Message-Id: <20231218153454.8090-23-linkinjeon@kernel.org>
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

From: Hyunchul Lee <hyc.lee@gmail.com>

[ Upstream commit 2fd5dcb1c8ef96c9f0fa8bda53ca480524b80ae7 ]

if the Channel of a SMB2 WRITE request is
SMB2_CHANNEL_RDMA_V1_INVALIDTE, a client
does not invalidate its memory regions but
ksmbd must do it by sending a SMB2 WRITE response
with IB_WR_SEND_WITH_INV.

But if errors occur while processing a SMB2
READ/WRITE request, ksmbd sends a response
with IB_WR_SEND. So a client could use memory
regions already in use.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 71 +++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 7b7b620d2d66..51198d3b4bb6 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6203,25 +6203,33 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 	return err;
 }
 
-static ssize_t smb2_read_rdma_channel(struct ksmbd_work *work,
-				      struct smb2_read_req *req, void *data_buf,
-				      size_t length)
+static int smb2_set_remote_key_for_rdma(struct ksmbd_work *work,
+					struct smb2_buffer_desc_v1 *desc,
+					__le32 Channel,
+					__le16 ChannelInfoOffset,
+					__le16 ChannelInfoLength)
 {
-	struct smb2_buffer_desc_v1 *desc =
-		(struct smb2_buffer_desc_v1 *)&req->Buffer[0];
-	int err;
-
 	if (work->conn->dialect == SMB30_PROT_ID &&
-	    req->Channel != SMB2_CHANNEL_RDMA_V1)
+	    Channel != SMB2_CHANNEL_RDMA_V1)
 		return -EINVAL;
 
-	if (req->ReadChannelInfoOffset == 0 ||
-	    le16_to_cpu(req->ReadChannelInfoLength) < sizeof(*desc))
+	if (ChannelInfoOffset == 0 ||
+	    le16_to_cpu(ChannelInfoLength) < sizeof(*desc))
 		return -EINVAL;
 
 	work->need_invalidate_rkey =
-		(req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE);
+		(Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE);
 	work->remote_key = le32_to_cpu(desc->token);
+	return 0;
+}
+
+static ssize_t smb2_read_rdma_channel(struct ksmbd_work *work,
+				      struct smb2_read_req *req, void *data_buf,
+				      size_t length)
+{
+	struct smb2_buffer_desc_v1 *desc =
+		(struct smb2_buffer_desc_v1 *)&req->Buffer[0];
+	int err;
 
 	err = ksmbd_conn_rdma_write(work->conn, data_buf, length,
 				    le32_to_cpu(desc->token),
@@ -6263,6 +6271,18 @@ int smb2_read(struct ksmbd_work *work)
 		return smb2_read_pipe(work);
 	}
 
+	if (req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE ||
+	    req->Channel == SMB2_CHANNEL_RDMA_V1) {
+		err = smb2_set_remote_key_for_rdma(work,
+						   (struct smb2_buffer_desc_v1 *)
+						   &req->Buffer[0],
+						   req->Channel,
+						   req->ReadChannelInfoOffset,
+						   req->ReadChannelInfoLength);
+		if (err)
+			goto out;
+	}
+
 	fp = ksmbd_lookup_fd_slow(work, le64_to_cpu(req->VolatileFileId),
 				  le64_to_cpu(req->PersistentFileId));
 	if (!fp) {
@@ -6448,21 +6468,6 @@ static ssize_t smb2_write_rdma_channel(struct ksmbd_work *work,
 
 	desc = (struct smb2_buffer_desc_v1 *)&req->Buffer[0];
 
-	if (work->conn->dialect == SMB30_PROT_ID &&
-	    req->Channel != SMB2_CHANNEL_RDMA_V1)
-		return -EINVAL;
-
-	if (req->Length != 0 || req->DataOffset != 0)
-		return -EINVAL;
-
-	if (req->WriteChannelInfoOffset == 0 ||
-	    le16_to_cpu(req->WriteChannelInfoLength) < sizeof(*desc))
-		return -EINVAL;
-
-	work->need_invalidate_rkey =
-		(req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE);
-	work->remote_key = le32_to_cpu(desc->token);
-
 	data_buf = kvmalloc(length, GFP_KERNEL | __GFP_ZERO);
 	if (!data_buf)
 		return -ENOMEM;
@@ -6509,6 +6514,20 @@ int smb2_write(struct ksmbd_work *work)
 		return smb2_write_pipe(work);
 	}
 
+	if (req->Channel == SMB2_CHANNEL_RDMA_V1 ||
+	    req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE) {
+		if (req->Length != 0 || req->DataOffset != 0)
+			return -EINVAL;
+		err = smb2_set_remote_key_for_rdma(work,
+						   (struct smb2_buffer_desc_v1 *)
+						   &req->Buffer[0],
+						   req->Channel,
+						   req->WriteChannelInfoOffset,
+						   req->WriteChannelInfoLength);
+		if (err)
+			goto out;
+	}
+
 	if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
 		ksmbd_debug(SMB, "User does not have write permission\n");
 		err = -EACCES;
-- 
2.25.1


