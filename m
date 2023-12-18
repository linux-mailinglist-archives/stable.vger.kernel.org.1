Return-Path: <stable+bounces-7635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1FB81755B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB17C1F25AC7
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AC43D557;
	Mon, 18 Dec 2023 15:35:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A81D137
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28b71490fbbso577351a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913736; x=1703518536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3KbPUf+i4WckoYvhaNu3TOym7hMNhRLt4mQCzLCLxo=;
        b=ICcQJ/0cNVFVBoR+hM2m+nc4m9SsO+o7935UJadnQrpu5hdA5WKcTqMgT8PiKPcWZ6
         8wITWH12mIjgqwBRv0chG6faDYfh9AnKHLpQ18t2b0CEroTfJRuDttx3aNAkJH5nCw5O
         24hw+WtQVEQjEA+0V4Z5N0nqgFQSxhi3kA6ZsVzgL4eQqToesdlAwHqWYr6ajf1b0uOO
         Q3pal+x9mvPuiiuCiqsojhVq/53V/xKr8n7xZJtzP+4TIv4D57JqjuIV0P46WY8Ez0le
         gEHtK1Gtt1XKR2OwtIL16R373fX/ejz0DxVm9dat6d3VizedWpxANbX1nZ3CFgPi94Yk
         MG2A==
X-Gm-Message-State: AOJu0YwJkOCMgiy52ZmyFDZ9OfcXpjHgAmiJQ4tZnj0jDHIrGpDyYna9
	eAuuuoWe8BE7sqLUMk3i97Q=
X-Google-Smtp-Source: AGHT+IFp8QUSsCLYilhghX9u/IY0sauWHsCjKJ2eXyQI1ynTNPK9aDvKI5gnDLEo2bX9AmzWEzQ89A==
X-Received: by 2002:a17:90b:48c5:b0:28b:af0a:8888 with SMTP id li5-20020a17090b48c500b0028baf0a8888mr170156pjb.23.1702913735821;
        Mon, 18 Dec 2023 07:35:35 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:35:35 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 006/154] ksmbd: remove smb2_buf_length in smb2_transform_hdr
Date: Tue, 19 Dec 2023 00:32:26 +0900
Message-Id: <20231218153454.8090-7-linkinjeon@kernel.org>
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

[ Upstream commit 2dd9129f7dec1de369e4447a54ea2edf695f765b ]

To move smb2_transform_hdr to smbfs_common, This patch remove
smb2_buf_length variable in smb2_transform_hdr.

Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/auth.c       |  7 +++----
 fs/ksmbd/connection.c |  2 +-
 fs/ksmbd/smb2pdu.c    | 37 +++++++++++++++++--------------------
 fs/ksmbd/smb2pdu.h    |  5 -----
 4 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index 3258a3176c06..33cb94ed6f66 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -994,7 +994,7 @@ static struct scatterlist *ksmbd_init_sg(struct kvec *iov, unsigned int nvec,
 					 u8 *sign)
 {
 	struct scatterlist *sg;
-	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 24;
+	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 20;
 	int i, nr_entries[3] = {0}, total_entries = 0, sg_idx = 0;
 
 	if (!nvec)
@@ -1058,9 +1058,8 @@ static struct scatterlist *ksmbd_init_sg(struct kvec *iov, unsigned int nvec,
 int ksmbd_crypt_message(struct ksmbd_conn *conn, struct kvec *iov,
 			unsigned int nvec, int enc)
 {
-	struct smb2_transform_hdr *tr_hdr =
-		(struct smb2_transform_hdr *)iov[0].iov_base;
-	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 24;
+	struct smb2_transform_hdr *tr_hdr = smb2_get_msg(iov[0].iov_base);
+	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 20;
 	int rc;
 	struct scatterlist *sg;
 	u8 sign[SMB2_SIGNATURE_SIZE] = {};
diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index e4af77581c2f..ddf447e9b8bf 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -173,7 +173,7 @@ int ksmbd_conn_write(struct ksmbd_work *work)
 
 	if (work->tr_buf) {
 		iov[iov_idx] = (struct kvec) { work->tr_buf,
-				sizeof(struct smb2_transform_hdr) };
+				sizeof(struct smb2_transform_hdr) + 4 };
 		len += iov[iov_idx++].iov_len;
 	}
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 2f04b90c8c2b..e693595b9cf3 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -8571,13 +8571,13 @@ void smb3_preauth_hash_rsp(struct ksmbd_work *work)
 	}
 }
 
-static void fill_transform_hdr(struct smb2_transform_hdr *tr_hdr, char *old_buf,
-			       __le16 cipher_type)
+static void fill_transform_hdr(void *tr_buf, char *old_buf, __le16 cipher_type)
 {
-	struct smb2_hdr *hdr = (struct smb2_hdr *)old_buf;
+	struct smb2_transform_hdr *tr_hdr = tr_buf + 4;
+	struct smb2_hdr *hdr = smb2_get_msg(old_buf);
 	unsigned int orig_len = get_rfc1002_len(old_buf);
 
-	memset(tr_hdr, 0, sizeof(struct smb2_transform_hdr));
+	memset(tr_buf, 0, sizeof(struct smb2_transform_hdr) + 4);
 	tr_hdr->ProtocolId = SMB2_TRANSFORM_PROTO_NUM;
 	tr_hdr->OriginalMessageSize = cpu_to_le32(orig_len);
 	tr_hdr->Flags = cpu_to_le16(0x01);
@@ -8587,14 +8587,13 @@ static void fill_transform_hdr(struct smb2_transform_hdr *tr_hdr, char *old_buf,
 	else
 		get_random_bytes(&tr_hdr->Nonce, SMB3_AES_CCM_NONCE);
 	memcpy(&tr_hdr->SessionId, &hdr->SessionId, 8);
-	inc_rfc1001_len(tr_hdr, sizeof(struct smb2_transform_hdr) - 4);
-	inc_rfc1001_len(tr_hdr, orig_len);
+	inc_rfc1001_len(tr_buf, sizeof(struct smb2_transform_hdr));
+	inc_rfc1001_len(tr_buf, orig_len);
 }
 
 int smb3_encrypt_resp(struct ksmbd_work *work)
 {
 	char *buf = work->response_buf;
-	struct smb2_transform_hdr *tr_hdr;
 	struct kvec iov[3];
 	int rc = -ENOMEM;
 	int buf_size = 0, rq_nvec = 2 + (work->aux_payload_sz ? 1 : 0);
@@ -8602,15 +8601,15 @@ int smb3_encrypt_resp(struct ksmbd_work *work)
 	if (ARRAY_SIZE(iov) < rq_nvec)
 		return -ENOMEM;
 
-	tr_hdr = kzalloc(sizeof(struct smb2_transform_hdr), GFP_KERNEL);
-	if (!tr_hdr)
+	work->tr_buf = kzalloc(sizeof(struct smb2_transform_hdr) + 4, GFP_KERNEL);
+	if (!work->tr_buf)
 		return rc;
 
 	/* fill transform header */
-	fill_transform_hdr(tr_hdr, buf, work->conn->cipher_type);
+	fill_transform_hdr(work->tr_buf, buf, work->conn->cipher_type);
 
-	iov[0].iov_base = tr_hdr;
-	iov[0].iov_len = sizeof(struct smb2_transform_hdr);
+	iov[0].iov_base = work->tr_buf;
+	iov[0].iov_len = sizeof(struct smb2_transform_hdr) + 4;
 	buf_size += iov[0].iov_len - 4;
 
 	iov[1].iov_base = buf + 4;
@@ -8630,15 +8629,14 @@ int smb3_encrypt_resp(struct ksmbd_work *work)
 		return rc;
 
 	memmove(buf, iov[1].iov_base, iov[1].iov_len);
-	tr_hdr->smb2_buf_length = cpu_to_be32(buf_size);
-	work->tr_buf = tr_hdr;
+	*(__be32 *)work->tr_buf = cpu_to_be32(buf_size);
 
 	return rc;
 }
 
 bool smb3_is_transform_hdr(void *buf)
 {
-	struct smb2_transform_hdr *trhdr = buf;
+	struct smb2_transform_hdr *trhdr = smb2_get_msg(buf);
 
 	return trhdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM;
 }
@@ -8650,9 +8648,8 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	char *buf = work->request_buf;
 	unsigned int pdu_length = get_rfc1002_len(buf);
 	struct kvec iov[2];
-	int buf_data_size = pdu_length + 4 -
-		sizeof(struct smb2_transform_hdr);
-	struct smb2_transform_hdr *tr_hdr = (struct smb2_transform_hdr *)buf;
+	int buf_data_size = pdu_length - sizeof(struct smb2_transform_hdr);
+	struct smb2_transform_hdr *tr_hdr = smb2_get_msg(buf);
 	int rc = 0;
 
 	if (pdu_length < sizeof(struct smb2_transform_hdr) ||
@@ -8675,8 +8672,8 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	}
 
 	iov[0].iov_base = buf;
-	iov[0].iov_len = sizeof(struct smb2_transform_hdr);
-	iov[1].iov_base = buf + sizeof(struct smb2_transform_hdr);
+	iov[0].iov_len = sizeof(struct smb2_transform_hdr) + 4;
+	iov[1].iov_base = buf + sizeof(struct smb2_transform_hdr) + 4;
 	iov[1].iov_len = buf_data_size;
 	rc = ksmbd_crypt_message(conn, iov, 2, 0);
 	if (rc)
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index ebbdb6476c11..2175ab5fb557 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -160,11 +160,6 @@ struct smb2_pdu {
 #define SMB3_AES_GCM_NONCE 12
 
 struct smb2_transform_hdr {
-	__be32 smb2_buf_length; /* big endian on wire */
-	/*
-	 * length is only two or three bytes - with
-	 * one or two byte type preceding it that MBZ
-	 */
 	__le32 ProtocolId;      /* 0xFD 'S' 'M' 'B' */
 	__u8   Signature[16];
 	__u8   Nonce[16];
-- 
2.25.1


