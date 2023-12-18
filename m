Return-Path: <stable+bounces-7636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D55817560
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15BFFB2230E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D3142042;
	Mon, 18 Dec 2023 15:35:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E61D137
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3470496e2so28289585ad.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913739; x=1703518539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/UEJLf4gc764SapxMU/d844wz2P9c3yBoh1Gs5lrjA=;
        b=X//pfuL7dWPWfsXAHlchRU9Hp/G+7VVnKkkzoN513huyJUr45j0iObGXzFGUyJ67Cy
         9yFHbCCJBkwDGxseW/Fo0U7ffM97gmwcSHgrMghQlprUwxot/DQorxywy9OwTR2yxfkS
         QNqd2WI9YBIp8Pdi/GvMfE4w3I3SmtVqHcoEPPNHyZ6HklxJZxnvzZBNTPp7Mgf0Yz7d
         K4AT76Pe5VV5fZ5iWBQsV1umy41TYNONpZ1g8yxfgc1I9sSgv/NfzuIqJjnQUXnxHJyf
         mgqwQM6aCEzvgwD603TMtZXyFYhWAYUZeAqsCT5W90+Ez8TiaBhwGu0sl+Z9n32DpSop
         LqJA==
X-Gm-Message-State: AOJu0YyaKKJXUmItGPB7E1L4+9S32xjvBaCgkLLq1bhiYttvrcM2xMfy
	c+AVH5eGJ9DbvH1w7FzpYH8=
X-Google-Smtp-Source: AGHT+IG7jl7mM4m6Bs+i69QDfx8XsTJxMIG1wwC/uk9+X/YaHNyVCarGYxmDZ37VzZx2sV/G+S04tw==
X-Received: by 2002:a17:90a:970b:b0:28b:3322:687 with SMTP id x11-20020a17090a970b00b0028b33220687mr2723559pjo.33.1702913739424;
        Mon, 18 Dec 2023 07:35:39 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:35:38 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 007/154] ksmbd: change LeaseKey data type to u8 array
Date: Tue, 19 Dec 2023 00:32:27 +0900
Message-Id: <20231218153454.8090-8-linkinjeon@kernel.org>
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

[ Upstream commit 2734b692f7b8167b93498dcd698067623d4267ca ]

cifs define LeaseKey as u8 array in structure. To move lease structure
to smbfs_common, ksmbd change LeaseKey data type to u8 array.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/oplock.c  | 24 +++++++++---------------
 fs/ksmbd/oplock.h  |  2 --
 fs/ksmbd/smb2pdu.h | 11 +++++------
 3 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index e57b2aa71815..e1d854609195 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1336,19 +1336,16 @@ __u8 smb2_map_lease_to_oplock(__le32 lease_state)
  */
 void create_lease_buf(u8 *rbuf, struct lease *lease)
 {
-	char *LeaseKey = (char *)&lease->lease_key;
-
 	if (lease->version == 2) {
 		struct create_lease_v2 *buf = (struct create_lease_v2 *)rbuf;
-		char *ParentLeaseKey = (char *)&lease->parent_lease_key;
 
 		memset(buf, 0, sizeof(struct create_lease_v2));
-		buf->lcontext.LeaseKeyLow = *((__le64 *)LeaseKey);
-		buf->lcontext.LeaseKeyHigh = *((__le64 *)(LeaseKey + 8));
+		memcpy(buf->lcontext.LeaseKey, lease->lease_key,
+		       SMB2_LEASE_KEY_SIZE);
 		buf->lcontext.LeaseFlags = lease->flags;
 		buf->lcontext.LeaseState = lease->state;
-		buf->lcontext.ParentLeaseKeyLow = *((__le64 *)ParentLeaseKey);
-		buf->lcontext.ParentLeaseKeyHigh = *((__le64 *)(ParentLeaseKey + 8));
+		memcpy(buf->lcontext.ParentLeaseKey, lease->parent_lease_key,
+		       SMB2_LEASE_KEY_SIZE);
 		buf->ccontext.DataOffset = cpu_to_le16(offsetof
 				(struct create_lease_v2, lcontext));
 		buf->ccontext.DataLength = cpu_to_le32(sizeof(struct lease_context_v2));
@@ -1363,8 +1360,7 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
 		struct create_lease *buf = (struct create_lease *)rbuf;
 
 		memset(buf, 0, sizeof(struct create_lease));
-		buf->lcontext.LeaseKeyLow = *((__le64 *)LeaseKey);
-		buf->lcontext.LeaseKeyHigh = *((__le64 *)(LeaseKey + 8));
+		memcpy(buf->lcontext.LeaseKey, lease->lease_key, SMB2_LEASE_KEY_SIZE);
 		buf->lcontext.LeaseFlags = lease->flags;
 		buf->lcontext.LeaseState = lease->state;
 		buf->ccontext.DataOffset = cpu_to_le16(offsetof
@@ -1417,19 +1413,17 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
 		if (sizeof(struct lease_context_v2) == le32_to_cpu(cc->DataLength)) {
 			struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
 
-			*((__le64 *)lreq->lease_key) = lc->lcontext.LeaseKeyLow;
-			*((__le64 *)(lreq->lease_key + 8)) = lc->lcontext.LeaseKeyHigh;
+			memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
 			lreq->req_state = lc->lcontext.LeaseState;
 			lreq->flags = lc->lcontext.LeaseFlags;
 			lreq->duration = lc->lcontext.LeaseDuration;
-			*((__le64 *)lreq->parent_lease_key) = lc->lcontext.ParentLeaseKeyLow;
-			*((__le64 *)(lreq->parent_lease_key + 8)) = lc->lcontext.ParentLeaseKeyHigh;
+			memcpy(lreq->parent_lease_key, lc->lcontext.ParentLeaseKey,
+			       SMB2_LEASE_KEY_SIZE);
 			lreq->version = 2;
 		} else {
 			struct create_lease *lc = (struct create_lease *)cc;
 
-			*((__le64 *)lreq->lease_key) = lc->lcontext.LeaseKeyLow;
-			*((__le64 *)(lreq->lease_key + 8)) = lc->lcontext.LeaseKeyHigh;
+			memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
 			lreq->req_state = lc->lcontext.LeaseState;
 			lreq->flags = lc->lcontext.LeaseFlags;
 			lreq->duration = lc->lcontext.LeaseDuration;
diff --git a/fs/ksmbd/oplock.h b/fs/ksmbd/oplock.h
index 2c4f4a0512b7..e1ba363b412a 100644
--- a/fs/ksmbd/oplock.h
+++ b/fs/ksmbd/oplock.h
@@ -28,8 +28,6 @@
 #define OPLOCK_WRITE_TO_NONE		0x04
 #define OPLOCK_READ_TO_NONE		0x08
 
-#define SMB2_LEASE_KEY_SIZE		16
-
 struct lease_ctx_info {
 	__u8			lease_key[SMB2_LEASE_KEY_SIZE];
 	__le32			req_state;
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index 2175ab5fb557..3ae27ccfc20d 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -734,22 +734,21 @@ struct create_posix_rsp {
 
 #define SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE	cpu_to_le32(0x02)
 
+#define SMB2_LEASE_KEY_SIZE			16
+
 struct lease_context {
-	__le64 LeaseKeyLow;
-	__le64 LeaseKeyHigh;
+	__u8 LeaseKey[SMB2_LEASE_KEY_SIZE];
 	__le32 LeaseState;
 	__le32 LeaseFlags;
 	__le64 LeaseDuration;
 } __packed;
 
 struct lease_context_v2 {
-	__le64 LeaseKeyLow;
-	__le64 LeaseKeyHigh;
+	__u8 LeaseKey[SMB2_LEASE_KEY_SIZE];
 	__le32 LeaseState;
 	__le32 LeaseFlags;
 	__le64 LeaseDuration;
-	__le64 ParentLeaseKeyLow;
-	__le64 ParentLeaseKeyHigh;
+	__u8 ParentLeaseKey[SMB2_LEASE_KEY_SIZE];
 	__le16 Epoch;
 	__le16 Reserved;
 } __packed;
-- 
2.25.1


