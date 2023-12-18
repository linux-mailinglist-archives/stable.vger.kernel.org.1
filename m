Return-Path: <stable+bounces-7685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECEC8175C7
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7BF283EEF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6EA42392;
	Mon, 18 Dec 2023 15:38:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C6A5BF87
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cd82917ecfso1522015a12.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913904; x=1703518704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUatd8wJJ+z6VzEdjAVddp9YyrB0MNqzlb4IG+0smn4=;
        b=Xir7NhymVyRlyHZ7J30F2rHFChvFa1PehCUB2saZmfsN+1CZwRCuFw/NVbamMOs2nU
         6zQPPFFTdxiRkvfsOGWgD8ojsGWK3WPZNqDIH/0Eq2Ez1TV/UVoQxo5m69lPegx+XoU7
         sr5OlK8EzDkWNYkxLjpk/J0yT/jdf8wEfSqn7PgJ9CcZhCPF1Mb7N3xT9+91DTU1vRsc
         IKSunq/OrOca+eVELEyc4yssl9f3FiktQllPiWvCTZNN76je2mQCk9ngci7VbkixWeLa
         qZ8hhQODCflK6SanzYdx3/CvJabtE1MKdyaM6QWKbXJWEJWrHYaDOTJWSaYxndFXdZDs
         GyuA==
X-Gm-Message-State: AOJu0Yxys8W6J+N4Dvv8ji7HQgr+E4q2/1SJvD2GCHORh4TI7xbihhip
	jl44VxhwPTGI/NSpAHYLwZ4=
X-Google-Smtp-Source: AGHT+IGL5K6Uy83I5bjV1t4XGsCotgSuCBcTXaB1UDyjsjnSakCrKVxLPzpfKBoyuEClyu3tC68QNQ==
X-Received: by 2002:a17:90b:2312:b0:28b:4f22:de68 with SMTP id mt18-20020a17090b231200b0028b4f22de68mr1459714pjb.59.1702913904343;
        Mon, 18 Dec 2023 07:38:24 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:23 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 056/154] ksmbd: fix encryption failure issue for session logoff response
Date: Tue, 19 Dec 2023 00:33:16 +0900
Message-Id: <20231218153454.8090-57-linkinjeon@kernel.org>
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

[ Upstream commit af705ef2b0ded0d8f54c238fdf3c17a1d47ad924 ]

If client send encrypted session logoff request on seal mount,
Encryption for that response fails.

ksmbd: Could not get encryption key
CIFS: VFS: cifs_put_smb_ses: Session Logoff failure rc=-512

Session lookup fails in ksmbd_get_encryption_key() because sess->state is
set to SMB2_SESSION_EXPIRED in session logoff. There is no need to do
session lookup again to encrypt the response. This patch change to use
ksmbd_session in ksmbd_work.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/auth.c    | 12 ++++++++----
 fs/ksmbd/auth.h    |  3 ++-
 fs/ksmbd/smb2pdu.c |  7 +++----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index 2048e0546116..45f0e9a75e63 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -988,13 +988,16 @@ int ksmbd_gen_sd_hash(struct ksmbd_conn *conn, char *sd_buf, int len,
 	return rc;
 }
 
-static int ksmbd_get_encryption_key(struct ksmbd_conn *conn, __u64 ses_id,
+static int ksmbd_get_encryption_key(struct ksmbd_work *work, __u64 ses_id,
 				    int enc, u8 *key)
 {
 	struct ksmbd_session *sess;
 	u8 *ses_enc_key;
 
-	sess = ksmbd_session_lookup_all(conn, ses_id);
+	if (enc)
+		sess = work->sess;
+	else
+		sess = ksmbd_session_lookup_all(work->conn, ses_id);
 	if (!sess)
 		return -EINVAL;
 
@@ -1082,9 +1085,10 @@ static struct scatterlist *ksmbd_init_sg(struct kvec *iov, unsigned int nvec,
 	return sg;
 }
 
-int ksmbd_crypt_message(struct ksmbd_conn *conn, struct kvec *iov,
+int ksmbd_crypt_message(struct ksmbd_work *work, struct kvec *iov,
 			unsigned int nvec, int enc)
 {
+	struct ksmbd_conn *conn = work->conn;
 	struct smb2_transform_hdr *tr_hdr = smb2_get_msg(iov[0].iov_base);
 	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 20;
 	int rc;
@@ -1098,7 +1102,7 @@ int ksmbd_crypt_message(struct ksmbd_conn *conn, struct kvec *iov,
 	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
 	struct ksmbd_crypto_ctx *ctx;
 
-	rc = ksmbd_get_encryption_key(conn,
+	rc = ksmbd_get_encryption_key(work,
 				      le64_to_cpu(tr_hdr->SessionId),
 				      enc,
 				      key);
diff --git a/fs/ksmbd/auth.h b/fs/ksmbd/auth.h
index 25b772653de0..362b6159a6cf 100644
--- a/fs/ksmbd/auth.h
+++ b/fs/ksmbd/auth.h
@@ -33,9 +33,10 @@
 
 struct ksmbd_session;
 struct ksmbd_conn;
+struct ksmbd_work;
 struct kvec;
 
-int ksmbd_crypt_message(struct ksmbd_conn *conn, struct kvec *iov,
+int ksmbd_crypt_message(struct ksmbd_work *work, struct kvec *iov,
 			unsigned int nvec, int enc);
 void ksmbd_copy_gss_neg_header(void *buf);
 int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 85678fcabe3c..933f806f14dc 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -8645,7 +8645,7 @@ int smb3_encrypt_resp(struct ksmbd_work *work)
 	buf_size += iov[1].iov_len;
 	work->resp_hdr_sz = iov[1].iov_len;
 
-	rc = ksmbd_crypt_message(work->conn, iov, rq_nvec, 1);
+	rc = ksmbd_crypt_message(work, iov, rq_nvec, 1);
 	if (rc)
 		return rc;
 
@@ -8664,7 +8664,6 @@ bool smb3_is_transform_hdr(void *buf)
 
 int smb3_decrypt_req(struct ksmbd_work *work)
 {
-	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess;
 	char *buf = work->request_buf;
 	unsigned int pdu_length = get_rfc1002_len(buf);
@@ -8685,7 +8684,7 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 		return -ECONNABORTED;
 	}
 
-	sess = ksmbd_session_lookup_all(conn, le64_to_cpu(tr_hdr->SessionId));
+	sess = ksmbd_session_lookup_all(work->conn, le64_to_cpu(tr_hdr->SessionId));
 	if (!sess) {
 		pr_err("invalid session id(%llx) in transform header\n",
 		       le64_to_cpu(tr_hdr->SessionId));
@@ -8696,7 +8695,7 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	iov[0].iov_len = sizeof(struct smb2_transform_hdr) + 4;
 	iov[1].iov_base = buf + sizeof(struct smb2_transform_hdr) + 4;
 	iov[1].iov_len = buf_data_size;
-	rc = ksmbd_crypt_message(conn, iov, 2, 0);
+	rc = ksmbd_crypt_message(work, iov, 2, 0);
 	if (rc)
 		return rc;
 
-- 
2.25.1


