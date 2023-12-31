Return-Path: <stable+bounces-9049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C567A820A02
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673B01F21FE9
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2EC17C2;
	Sun, 31 Dec 2023 07:14:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBFD17C3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6da55cc8e78so915218b3a.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006877; x=1704611677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NfjOlsr1TPeLavmFkqHb27wKLTXp2zAZRw+BK8ng5k=;
        b=A1emAOs/+np0OlgSiUjgZi/MNJiUoWla6ipjVgpwkvA5OcCCvx2QcYA6vONe/jWL2P
         Eqr+YVYrnQ5bxe5R+YzxffiUP8x4eJZja79fvN7t2HRByen8A/wg1dxdUwQ17UmCVePE
         mpLkj5N/zgj+pvolHPSdWbGsaq7keHJ3PMMcA6cjSkadVgzi6b55NTcaR5I4nYXuJzBG
         yBWwhXnwpE5NYA5zQ9ooGO4sTfvuevxgS+OB6q53D/C05w20WJKIAwJ2YYL1217gh/db
         kpxkF0f5j2j/Tpcmy9TLbjMo3gTFoyCS9SSF6CtoXU+N1IY97hWsYG7jm8hTX/2rkzN7
         RSJQ==
X-Gm-Message-State: AOJu0Yx4NwNisa0CaAVmbhJTCSe0GjCVhifhGzGdlVrHFKq8e2u6IQpZ
	hcvQZCM9kk56UQBGugykHy8=
X-Google-Smtp-Source: AGHT+IGCnt8YJn5kiyxp6hSJlI2MN5QZh88zUc5rI4f3/MQs0GlHjy5+b0VssZAUxGBqlCXSbFoj5g==
X-Received: by 2002:aa7:8694:0:b0:6d9:ac49:4e36 with SMTP id d20-20020aa78694000000b006d9ac494e36mr10305617pfo.68.1704006876876;
        Sat, 30 Dec 2023 23:14:36 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:36 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	David Disseldorp <ddiss@suse.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 15/73] ksmbd: avoid duplicate negotiate ctx offset increments
Date: Sun, 31 Dec 2023 16:12:34 +0900
Message-Id: <20231231071332.31724-16-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071332.31724-1-linkinjeon@kernel.org>
References: <20231231071332.31724-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Disseldorp <ddiss@suse.de>

[ Upstream commit a12a07a85aff72e19520328f78b1c64d2281a1ec ]

Both pneg_ctxt and ctxt_size change in unison, with each adding the
length of the previously added context, rounded up to an eight byte
boundary.
Drop pneg_ctxt increments and instead use the ctxt_size offset when
passing output pointers to per-context helper functions. This slightly
simplifies offset tracking and shaves off a few text bytes.
Before (x86-64 gcc 7.5):
   text    data     bss     dec     hex filename
 213234    8677     672  222583   36577 ksmbd.ko

After:
   text    data     bss     dec     hex filename
 213218    8677     672  222567   36567 ksmbd.ko

Signed-off-by: David Disseldorp <ddiss@suse.de>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index c7d43c83d233..92e657097243 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -838,7 +838,7 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 				  struct smb2_negotiate_rsp *rsp,
 				  void *smb2_buf_len)
 {
-	char *pneg_ctxt = (char *)rsp +
+	char * const pneg_ctxt = (char *)rsp +
 			le32_to_cpu(rsp->NegotiateContextOffset);
 	int neg_ctxt_cnt = 1;
 	int ctxt_size;
@@ -849,21 +849,17 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 			   conn->preauth_info->Preauth_HashId);
 	inc_rfc1001_len(smb2_buf_len, AUTH_GSS_PADDING);
 	ctxt_size = sizeof(struct smb2_preauth_neg_context);
-	/* Round to 8 byte boundary */
-	pneg_ctxt += round_up(sizeof(struct smb2_preauth_neg_context), 8);
 
 	if (conn->cipher_type) {
+		/* Round to 8 byte boundary */
 		ctxt_size = round_up(ctxt_size, 8);
 		ksmbd_debug(SMB,
 			    "assemble SMB2_ENCRYPTION_CAPABILITIES context\n");
-		build_encrypt_ctxt((struct smb2_encryption_neg_context *)pneg_ctxt,
+		build_encrypt_ctxt((struct smb2_encryption_neg_context *)
+				   (pneg_ctxt + ctxt_size),
 				   conn->cipher_type);
 		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_encryption_neg_context) + 2;
-		/* Round to 8 byte boundary */
-		pneg_ctxt +=
-			round_up(sizeof(struct smb2_encryption_neg_context) + 2,
-				 8);
 	}
 
 	if (conn->compress_algorithm) {
@@ -871,31 +867,29 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 		ksmbd_debug(SMB,
 			    "assemble SMB2_COMPRESSION_CAPABILITIES context\n");
 		/* Temporarily set to SMB3_COMPRESS_NONE */
-		build_compression_ctxt((struct smb2_compression_capabilities_context *)pneg_ctxt,
+		build_compression_ctxt((struct smb2_compression_capabilities_context *)
+				       (pneg_ctxt + ctxt_size),
 				       conn->compress_algorithm);
 		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_compression_capabilities_context) + 2;
-		/* Round to 8 byte boundary */
-		pneg_ctxt += round_up(sizeof(struct smb2_compression_capabilities_context) + 2,
-				      8);
 	}
 
 	if (conn->posix_ext_supported) {
 		ctxt_size = round_up(ctxt_size, 8);
 		ksmbd_debug(SMB,
 			    "assemble SMB2_POSIX_EXTENSIONS_AVAILABLE context\n");
-		build_posix_ctxt((struct smb2_posix_neg_context *)pneg_ctxt);
+		build_posix_ctxt((struct smb2_posix_neg_context *)
+				 (pneg_ctxt + ctxt_size));
 		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_posix_neg_context);
-		/* Round to 8 byte boundary */
-		pneg_ctxt += round_up(sizeof(struct smb2_posix_neg_context), 8);
 	}
 
 	if (conn->signing_negotiated) {
 		ctxt_size = round_up(ctxt_size, 8);
 		ksmbd_debug(SMB,
 			    "assemble SMB2_SIGNING_CAPABILITIES context\n");
-		build_sign_cap_ctxt((struct smb2_signing_capabilities *)pneg_ctxt,
+		build_sign_cap_ctxt((struct smb2_signing_capabilities *)
+				    (pneg_ctxt + ctxt_size),
 				    conn->signing_algorithm);
 		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_signing_capabilities) + 2;
-- 
2.25.1


