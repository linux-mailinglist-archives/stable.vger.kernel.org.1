Return-Path: <stable+bounces-7723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E9E8175F5
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B306B2391A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B931772048;
	Mon, 18 Dec 2023 15:40:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3671E71469
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28b5f4a1b48so1676665a91.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914026; x=1703518826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUeAFnXPzz37W5frsfNFs63mkTMKw7FVXw7I1Ks2E10=;
        b=hwfJYgdq8rQrkqqDof+ccy4Gn0UeoHxiipRVPHlDpsWTtZvTM3oZnBy6DluvlYXigV
         D6e7qZMfJsCmn2vB4sPhUsw8e4vughRrCk+qFxbmH0tRKQ9JfI5AEm+L0hTAPc7RCbJV
         V0L3Qly2P75AUFlOeekGQE0P0g09cogYgX1jmkE5OPCfJJ7rFgbqrr8kmmeZHsVDpFML
         SiS+L9eePZFTeeHndNRmFIDS3ZcYwqx+IeW4WYHkGuWLJh8htHsXunY2xrbeCnjbgxZE
         rgSPhTWqIJSWovi+gTIj9N5uT3oxh5i3ama9prbOhf/2GkvcyKdyl4AW9cDCSeooiSyF
         ru0Q==
X-Gm-Message-State: AOJu0Ywel1InIkYGwmXHxd2AvgA9acFbhyphW9QxSx7uEuKOsO3qb/4M
	jm1YgfdqeWFpLpV+dPKh3/Dt8FDjMIY=
X-Google-Smtp-Source: AGHT+IGiDOOpXeXdWRk2I3uv1ehfgB1tSMRBNCzlSaj1Y1Iz6ouN7P7aAnnQzik5OMipgr5WZ4f9Lw==
X-Received: by 2002:a17:90a:dc18:b0:28b:9035:632c with SMTP id i24-20020a17090adc1800b0028b9035632cmr837665pjv.51.1702914026465;
        Mon, 18 Dec 2023 07:40:26 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:26 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Kuan-Ting Chen <h3xrabbit@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 095/154] ksmbd: fix multiple out-of-bounds read during context decoding
Date: Tue, 19 Dec 2023 00:33:55 +0900
Message-Id: <20231218153454.8090-96-linkinjeon@kernel.org>
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

From: Kuan-Ting Chen <h3xrabbit@gmail.com>

[ Upstream commit 0512a5f89e1fae74251fde6893ff634f1c96c6fb ]

Check the remaining data length before accessing the context structure
to ensure that the entire structure is contained within the packet.
Additionally, since the context data length `ctxt_len` has already been
checked against the total packet length `len_of_ctxts`, update the
comparison to use `ctxt_len`.

Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Ting Chen <h3xrabbit@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 53 +++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 0e6f39f05af2..62bcc440ad31 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -879,13 +879,14 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 
 static __le32 decode_preauth_ctxt(struct ksmbd_conn *conn,
 				  struct smb2_preauth_neg_context *pneg_ctxt,
-				  int len_of_ctxts)
+				  int ctxt_len)
 {
 	/*
 	 * sizeof(smb2_preauth_neg_context) assumes SMB311_SALT_SIZE Salt,
 	 * which may not be present. Only check for used HashAlgorithms[1].
 	 */
-	if (len_of_ctxts < 6)
+	if (ctxt_len <
+	    sizeof(struct smb2_neg_context) + 6)
 		return STATUS_INVALID_PARAMETER;
 
 	if (pneg_ctxt->HashAlgorithms != SMB2_PREAUTH_INTEGRITY_SHA512)
@@ -897,15 +898,23 @@ static __le32 decode_preauth_ctxt(struct ksmbd_conn *conn,
 
 static void decode_encrypt_ctxt(struct ksmbd_conn *conn,
 				struct smb2_encryption_neg_context *pneg_ctxt,
-				int len_of_ctxts)
+				int ctxt_len)
 {
-	int cph_cnt = le16_to_cpu(pneg_ctxt->CipherCount);
-	int i, cphs_size = cph_cnt * sizeof(__le16);
+	int cph_cnt;
+	int i, cphs_size;
+
+	if (sizeof(struct smb2_encryption_neg_context) > ctxt_len) {
+		pr_err("Invalid SMB2_ENCRYPTION_CAPABILITIES context size\n");
+		return;
+	}
 
 	conn->cipher_type = 0;
 
+	cph_cnt = le16_to_cpu(pneg_ctxt->CipherCount);
+	cphs_size = cph_cnt * sizeof(__le16);
+
 	if (sizeof(struct smb2_encryption_neg_context) + cphs_size >
-	    len_of_ctxts) {
+	    ctxt_len) {
 		pr_err("Invalid cipher count(%d)\n", cph_cnt);
 		return;
 	}
@@ -953,15 +962,22 @@ static void decode_compress_ctxt(struct ksmbd_conn *conn,
 
 static void decode_sign_cap_ctxt(struct ksmbd_conn *conn,
 				 struct smb2_signing_capabilities *pneg_ctxt,
-				 int len_of_ctxts)
+				 int ctxt_len)
 {
-	int sign_algo_cnt = le16_to_cpu(pneg_ctxt->SigningAlgorithmCount);
-	int i, sign_alos_size = sign_algo_cnt * sizeof(__le16);
+	int sign_algo_cnt;
+	int i, sign_alos_size;
+
+	if (sizeof(struct smb2_signing_capabilities) > ctxt_len) {
+		pr_err("Invalid SMB2_SIGNING_CAPABILITIES context length\n");
+		return;
+	}
 
 	conn->signing_negotiated = false;
+	sign_algo_cnt = le16_to_cpu(pneg_ctxt->SigningAlgorithmCount);
+	sign_alos_size = sign_algo_cnt * sizeof(__le16);
 
 	if (sizeof(struct smb2_signing_capabilities) + sign_alos_size >
-	    len_of_ctxts) {
+	    ctxt_len) {
 		pr_err("Invalid signing algorithm count(%d)\n", sign_algo_cnt);
 		return;
 	}
@@ -999,18 +1015,16 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 	len_of_ctxts = len_of_smb - offset;
 
 	while (i++ < neg_ctxt_cnt) {
-		int clen;
-
-		/* check that offset is not beyond end of SMB */
-		if (len_of_ctxts == 0)
-			break;
+		int clen, ctxt_len;
 
 		if (len_of_ctxts < sizeof(struct smb2_neg_context))
 			break;
 
 		pctx = (struct smb2_neg_context *)((char *)pctx + offset);
 		clen = le16_to_cpu(pctx->DataLength);
-		if (clen + sizeof(struct smb2_neg_context) > len_of_ctxts)
+		ctxt_len = clen + sizeof(struct smb2_neg_context);
+
+		if (ctxt_len > len_of_ctxts)
 			break;
 
 		if (pctx->ContextType == SMB2_PREAUTH_INTEGRITY_CAPABILITIES) {
@@ -1021,7 +1035,7 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 
 			status = decode_preauth_ctxt(conn,
 						     (struct smb2_preauth_neg_context *)pctx,
-						     len_of_ctxts);
+						     ctxt_len);
 			if (status != STATUS_SUCCESS)
 				break;
 		} else if (pctx->ContextType == SMB2_ENCRYPTION_CAPABILITIES) {
@@ -1032,7 +1046,7 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 
 			decode_encrypt_ctxt(conn,
 					    (struct smb2_encryption_neg_context *)pctx,
-					    len_of_ctxts);
+					    ctxt_len);
 		} else if (pctx->ContextType == SMB2_COMPRESSION_CAPABILITIES) {
 			ksmbd_debug(SMB,
 				    "deassemble SMB2_COMPRESSION_CAPABILITIES context\n");
@@ -1051,9 +1065,10 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 		} else if (pctx->ContextType == SMB2_SIGNING_CAPABILITIES) {
 			ksmbd_debug(SMB,
 				    "deassemble SMB2_SIGNING_CAPABILITIES context\n");
+
 			decode_sign_cap_ctxt(conn,
 					     (struct smb2_signing_capabilities *)pctx,
-					     len_of_ctxts);
+					     ctxt_len);
 		}
 
 		/* offsets must be 8 byte aligned */
-- 
2.25.1


