Return-Path: <stable+bounces-7652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA73817594
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D40E1F2122E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F50F4988C;
	Mon, 18 Dec 2023 15:36:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91467347A
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d32c5ce32eso30917275ad.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913795; x=1703518595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzkV90arvSTS9B1NuJj/xSw9o39hMjMUH7bFrogmpZo=;
        b=su3lohk994cZueFYr3KxbxW4cFeDq1Ro6osQQoACotagWpGNltZ2YnHk8gq+XwgYzK
         mzpuGWHmk/bO1tJ19aaFRl+tHa/o/+HTGWP6/2K2Hew2eM6cOT20dEszBQsOZrT98NVU
         hSqXU0YJ8QQljF4EcKWgmZs/lfgWN1UR4P+KbGLaWR1Zo/xIALSnd+VccgaCqlGkB53B
         +6JqmR0JdoYb+iUMRK6l6fvuqOr2vXlB5SqpKZTXIg4VbElBQME1/xzcWoAgHr3Vj2K4
         wn0CFtnL7QZUr8U0KKvWr+n4eXg6i4hR/A19uZWK/2esvT37qrLjK7I3B16cobeWvzNB
         JcTw==
X-Gm-Message-State: AOJu0Ywu/0eTo9nf/dSpCMHe8VJ9gm8PLhVOzg3tFJzXL3SLjnuZBEED
	AkMQTxrB8eFXn0oSfupqlFc=
X-Google-Smtp-Source: AGHT+IFq3eot6cxGTiybCo52P1R6HarfppzV14c+Qea97xMHFiAB/W+RTOVCgPMIItrExpYa74MV+A==
X-Received: by 2002:a17:90b:4b0e:b0:28b:4c9f:150 with SMTP id lx14-20020a17090b4b0e00b0028b4c9f0150mr4731566pjb.16.1702913795168;
        Mon, 18 Dec 2023 07:36:35 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:34 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 023/154] ksmbd: smbd: validate buffer descriptor structures
Date: Tue, 19 Dec 2023 00:32:43 +0900
Message-Id: <20231218153454.8090-24-linkinjeon@kernel.org>
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

[ Upstream commit 6d896d3b44cf64ab9b2483697e222098e7b72f70 ]

Check ChannelInfoOffset and ChannelInfoLength
to validate buffer descriptor structures.
And add a debug log to print the structures'
content.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 51198d3b4bb6..99ae8f3f3d92 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6209,13 +6209,26 @@ static int smb2_set_remote_key_for_rdma(struct ksmbd_work *work,
 					__le16 ChannelInfoOffset,
 					__le16 ChannelInfoLength)
 {
+	unsigned int i, ch_count;
+
 	if (work->conn->dialect == SMB30_PROT_ID &&
 	    Channel != SMB2_CHANNEL_RDMA_V1)
 		return -EINVAL;
 
-	if (ChannelInfoOffset == 0 ||
-	    le16_to_cpu(ChannelInfoLength) < sizeof(*desc))
+	ch_count = le16_to_cpu(ChannelInfoLength) / sizeof(*desc);
+	if (ksmbd_debug_types & KSMBD_DEBUG_RDMA) {
+		for (i = 0; i < ch_count; i++) {
+			pr_info("RDMA r/w request %#x: token %#x, length %#x\n",
+				i,
+				le32_to_cpu(desc[i].token),
+				le32_to_cpu(desc[i].length));
+		}
+	}
+	if (ch_count != 1) {
+		ksmbd_debug(RDMA, "RDMA multiple buffer descriptors %d are not supported yet\n",
+			    ch_count);
 		return -EINVAL;
+	}
 
 	work->need_invalidate_rkey =
 		(Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE);
@@ -6273,9 +6286,15 @@ int smb2_read(struct ksmbd_work *work)
 
 	if (req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE ||
 	    req->Channel == SMB2_CHANNEL_RDMA_V1) {
+		unsigned int ch_offset = le16_to_cpu(req->ReadChannelInfoOffset);
+
+		if (ch_offset < offsetof(struct smb2_read_req, Buffer)) {
+			err = -EINVAL;
+			goto out;
+		}
 		err = smb2_set_remote_key_for_rdma(work,
 						   (struct smb2_buffer_desc_v1 *)
-						   &req->Buffer[0],
+						   ((char *)req + ch_offset),
 						   req->Channel,
 						   req->ReadChannelInfoOffset,
 						   req->ReadChannelInfoLength);
@@ -6516,11 +6535,16 @@ int smb2_write(struct ksmbd_work *work)
 
 	if (req->Channel == SMB2_CHANNEL_RDMA_V1 ||
 	    req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE) {
-		if (req->Length != 0 || req->DataOffset != 0)
-			return -EINVAL;
+		unsigned int ch_offset = le16_to_cpu(req->WriteChannelInfoOffset);
+
+		if (req->Length != 0 || req->DataOffset != 0 ||
+		    ch_offset < offsetof(struct smb2_write_req, Buffer)) {
+			err = -EINVAL;
+			goto out;
+		}
 		err = smb2_set_remote_key_for_rdma(work,
 						   (struct smb2_buffer_desc_v1 *)
-						   &req->Buffer[0],
+						   ((char *)req + ch_offset),
 						   req->Channel,
 						   req->WriteChannelInfoOffset,
 						   req->WriteChannelInfoLength);
-- 
2.25.1


