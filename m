Return-Path: <stable+bounces-7711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFC68175E6
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DEA1F24D58
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462703D556;
	Mon, 18 Dec 2023 15:39:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1DB3D549
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3c394c1f4so4324465ad.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913984; x=1703518784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q98lfexs5uyhMbU3vhRxRkbL+zMRykxpgdMBJs5XJDQ=;
        b=md6Hc2O9B9UHGTZNeqOVbkx5dxw5974twiGX+i7LcpYXhXi7b8jnMm515MXqFiFXxR
         n4H7fOqS0kxjRxbsopVQKOzJoPiAVnZHvrctq/iyZqgooe7ol8KzbjxhMHE64B3VVnDd
         UCLnqoBlXl2KRusDzBSIkL+6a+gUJhO/yAwuJG8TdQ463pVQWR55uPlflMzwfdj+iPa8
         izjW7NXuYk4yKrWBDoe8outBManuS53/PNKHJ8Yi8bxr7xL0/+fVqIFTZabCA0H/yXSn
         szY5BAxOGWuYYO25cTx8UgyD88nwKO/FrB3G97zoB8CPJ9cob37iPr5/s6bZWBp+P7zV
         ZrGQ==
X-Gm-Message-State: AOJu0Yxkv64dxB+CEebJY5Srbli77RKZN7O0pqgRa/bB7701XStTI+PN
	isYfcmRl1kbAEWetEICuR8I=
X-Google-Smtp-Source: AGHT+IGjKNmMg6tSSP+qX03iFhkLJhkczvrFTf8nXMWuvpi2fLgAP+WV4TKbF81kLc2Yu1jkP1aTnQ==
X-Received: by 2002:a17:90b:4c81:b0:28b:263a:cd40 with SMTP id my1-20020a17090b4c8100b0028b263acd40mr2203009pjb.89.1702913984262;
        Mon, 18 Dec 2023 07:39:44 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:43 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	David Disseldorp <ddiss@suse.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 082/154] ksmbd: avoid out of bounds access in decode_preauth_ctxt()
Date: Tue, 19 Dec 2023 00:33:42 +0900
Message-Id: <20231218153454.8090-83-linkinjeon@kernel.org>
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

[ Upstream commit e7067a446264a7514fa1cfaa4052cdb6803bc6a2 ]

Confirm that the accessed pneg_ctxt->HashAlgorithms address sits within
the SMB request boundary; deassemble_neg_contexts() only checks that the
eight byte smb2_neg_context header + (client controlled) DataLength are
within the packet boundary, which is insufficient.

Checking for sizeof(struct smb2_preauth_neg_context) is overkill given
that the type currently assumes SMB311_SALT_SIZE bytes of trailing Salt.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 92fa2090ac54..472aa5fa0d10 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -907,17 +907,21 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 }
 
 static __le32 decode_preauth_ctxt(struct ksmbd_conn *conn,
-				  struct smb2_preauth_neg_context *pneg_ctxt)
+				  struct smb2_preauth_neg_context *pneg_ctxt,
+				  int len_of_ctxts)
 {
-	__le32 err = STATUS_NO_PREAUTH_INTEGRITY_HASH_OVERLAP;
+	/*
+	 * sizeof(smb2_preauth_neg_context) assumes SMB311_SALT_SIZE Salt,
+	 * which may not be present. Only check for used HashAlgorithms[1].
+	 */
+	if (len_of_ctxts < 6)
+		return STATUS_INVALID_PARAMETER;
 
-	if (pneg_ctxt->HashAlgorithms == SMB2_PREAUTH_INTEGRITY_SHA512) {
-		conn->preauth_info->Preauth_HashId =
-			SMB2_PREAUTH_INTEGRITY_SHA512;
-		err = STATUS_SUCCESS;
-	}
+	if (pneg_ctxt->HashAlgorithms != SMB2_PREAUTH_INTEGRITY_SHA512)
+		return STATUS_NO_PREAUTH_INTEGRITY_HASH_OVERLAP;
 
-	return err;
+	conn->preauth_info->Preauth_HashId = SMB2_PREAUTH_INTEGRITY_SHA512;
+	return STATUS_SUCCESS;
 }
 
 static void decode_encrypt_ctxt(struct ksmbd_conn *conn,
@@ -1045,7 +1049,8 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 				break;
 
 			status = decode_preauth_ctxt(conn,
-						     (struct smb2_preauth_neg_context *)pctx);
+						     (struct smb2_preauth_neg_context *)pctx,
+						     len_of_ctxts);
 			if (status != STATUS_SUCCESS)
 				break;
 		} else if (pctx->ContextType == SMB2_ENCRYPTION_CAPABILITIES) {
-- 
2.25.1


