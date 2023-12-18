Return-Path: <stable+bounces-7713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 942BD8175E9
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99BB284429
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1511D137;
	Mon, 18 Dec 2023 15:39:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F4B3D549
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28b09aeca73so2278019a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913991; x=1703518791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6p2le9T1GFYBrMfxQLqc6v0QlGBF0qG9HLqswpUoEU=;
        b=LQS4h/EtbpQJe/vQ3yqNhkEv+jLtJJg4l2nTQnvi3cSUFkUUQT1zm6HQGBBulLbew7
         30rfCisjGWTSlKIf7FP3W1r1W6yVk+VGHHJVfRms1oO1rSy6Q547X2U8q+7Cif9m73Eo
         Exe2emyK+78GQSgBqz0hr+YmOemNS+n/oYMhr6mRmhECrebpnoOKGaUgcv9ky3nD3jag
         GpW44y9t+rwFXRtKNYGWIoG4XklgnHhDsicXseH109IlNQ47+R/8eadm8FSH29kFf/Nw
         bDZY+ElaEMmVyQCFPMnY0wgQ8xTDy5Jrxb/t8k9x9IXfu744NOOK/WsZiuNHsRSv4Lxn
         tBxA==
X-Gm-Message-State: AOJu0YzTPb2DpOAd4c8WzqL71r9uGjU2zACaz8Hwe1DWjmDqFwjXjxKq
	1vJRaEpN+MnIPbpi89Km1TI=
X-Google-Smtp-Source: AGHT+IFMIRdxZbRwmnO3JV08egfTsOKiu7WBHoxm2yI/d53bj391hA48lcwcA08IMSW6Xdav5rTxuQ==
X-Received: by 2002:a17:90b:394f:b0:28b:6aa0:f36 with SMTP id oe15-20020a17090b394f00b0028b6aa00f36mr3406076pjb.31.1702913990887;
        Mon, 18 Dec 2023 07:39:50 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:50 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	David Disseldorp <ddiss@suse.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 084/154] ksmbd: avoid duplicate negotiate ctx offset increments
Date: Tue, 19 Dec 2023 00:33:44 +0900
Message-Id: <20231218153454.8090-85-linkinjeon@kernel.org>
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
 fs/ksmbd/smb2pdu.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d8985fe42ac6..06c184927d66 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -839,7 +839,7 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 				  struct smb2_negotiate_rsp *rsp,
 				  void *smb2_buf_len)
 {
-	char *pneg_ctxt = (char *)rsp +
+	char * const pneg_ctxt = (char *)rsp +
 			le32_to_cpu(rsp->NegotiateContextOffset);
 	int neg_ctxt_cnt = 1;
 	int ctxt_size;
@@ -850,21 +850,17 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
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
@@ -872,31 +868,29 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 		ksmbd_debug(SMB,
 			    "assemble SMB2_COMPRESSION_CAPABILITIES context\n");
 		/* Temporarily set to SMB3_COMPRESS_NONE */
-		build_compression_ctxt((struct smb2_compression_ctx *)pneg_ctxt,
+		build_compression_ctxt((struct smb2_compression_ctx *)
+				       (pneg_ctxt + ctxt_size),
 				       conn->compress_algorithm);
 		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_compression_ctx) + 2;
-		/* Round to 8 byte boundary */
-		pneg_ctxt += round_up(sizeof(struct smb2_compression_ctx) + 2,
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


